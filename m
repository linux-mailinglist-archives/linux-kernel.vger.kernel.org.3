Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81796524473
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347976AbiELEpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348206AbiELEpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:45:05 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E07021A97A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:44:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q76so3546218pgq.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R30IJVXwSL1ZnJ1BIT6fsASUfGoZMEuIG7wV6MAjJno=;
        b=h+dZ7D555Y0ff/nw/PrelqhTvfGg6mV1wkRwlHQISW4SAYlgve8QYXHoBXLJYVvAX3
         V7dIXIcR7GpkdYPqL97NaURewls84oNM/BmyPIGFZxb85VSJHecbsYINz/YPqIf0zoZL
         5PiSm6RVfuYl6+iDo0QGHbhNR/gsVdvxiso6axaNYfWPyIiazAJj/CW1t1Cvnv6d0vEH
         +XMG2dSO1vRHo0Sv7pYBiMqGRN2IH/PvvEmG9OH3F1Qkm+DzuWtNGfiecKPqOeQQnp3h
         HF1QE8CFU4X+pr874n5hRKOUhtPVtdVNOdWgzGXqkSaBjNUUzjhKvObBKQndnLbfw0n9
         jHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R30IJVXwSL1ZnJ1BIT6fsASUfGoZMEuIG7wV6MAjJno=;
        b=xaahstkyNGSkr5oXreoLftCDMewd1p/VdgfeMzRDPaqcaH54XZulejSAl43SigZOd1
         EV3rANgDVMRXGxGILZY4e7oGpEzqOvRG8P2SLiLOj2Am/CwrJdFeG5JUn7rsF6nNZm46
         MfQyOcr1ES5pJ/n9EaTyj4vJpOdxmd7WBubmN+rg74pBrr0J7rIg+eq+9ArvFaGNTUUF
         8N4yOBqdhyAu8pjZJDWA1Gmbgy/HdCfbOCBKoTxbTTdFp78bjiRpVjcjDMzcz5dS6x1w
         N0Bg9YE5f/m+0d1x5LfvADRdbxYfjMwBM82Cg8Ia7+NBkKxNVMh9kKC07PQVI1sPw6QG
         1Rgg==
X-Gm-Message-State: AOAM532FNOpoZFWHRdVwB7jGySdeoie8PnVPUm2cpwWeiFh1q4F4pTxG
        eWC0MQQVP2hoDbJ5PXrqerfHhdSPNS39Y1+7zTM=
X-Google-Smtp-Source: ABdhPJx647XsCpk5dUpr8pTM+cEV6eKbfb7pvLcYKJx4e47f2P98TMMu9EY80y2LRb9+xo0KYSXA6A==
X-Received: by 2002:a05:6a00:14cc:b0:510:4b70:403e with SMTP id w12-20020a056a0014cc00b005104b70403emr28190061pfu.55.1652330694042;
        Wed, 11 May 2022 21:44:54 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id s7-20020a17090aba0700b001d5943e826asm794167pjr.20.2022.05.11.21.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:44:53 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ipmi:ipmb: Fix refcount leak in ipmi_ipmb_probe
Date:   Thu, 12 May 2022 08:44:45 +0400
Message-Id: <20220512044445.3102-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 00d93611f002 ("ipmi:ipmb: Add the ability to have a separate slave and master device")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/char/ipmi/ipmi_ipmb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
index b81b862532fb..a8bfe0ade082 100644
--- a/drivers/char/ipmi/ipmi_ipmb.c
+++ b/drivers/char/ipmi/ipmi_ipmb.c
@@ -476,6 +476,7 @@ static int ipmi_ipmb_probe(struct i2c_client *client,
 	slave_np = of_parse_phandle(dev->of_node, "slave-dev", 0);
 	if (slave_np) {
 		slave_adap = of_get_i2c_adapter_by_node(slave_np);
+		of_node_put(slave_np);
 		if (!slave_adap) {
 			dev_notice(&client->dev,
 				   "Could not find slave adapter\n");
-- 
2.25.1

