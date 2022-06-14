Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E041B54B53F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351203AbiFNQBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbiFNQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:01:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A89E427C4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:01:06 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i1so8114551plg.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WOj4FvigJu5izzW3n402CP69/icG57dAPvfvJVinMKo=;
        b=RWXh5GtZaqxteFf2CROPV/dYD8b91OYqdJpCaYbEbLplBV8sAyMDSZTwi2wLw56CP6
         ZRApnGBR1ta4xkD1UY3ppwMmxNcujKTEsulhIkgzo2zURYB5EX566giijnt+L/rSm1jZ
         mu0SJx3f5P5gay2PFvqWgoxpVSzAV8VpnJMT6XEOq7K0yOCD82spVtua+CfZZcBtfoPy
         wkLtb9EtOxPi3i0E+kMwUdnay6iIjEOJvCS2wiSh9Y2C8Is3rMH9wvY2kFzsqTe/28E+
         pTxLROic1ReUNwZgrzVDCdzhLKP83C6XwJzEPMGFYCLpilswSNnOxe3MZz6BXBNlETz3
         9Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WOj4FvigJu5izzW3n402CP69/icG57dAPvfvJVinMKo=;
        b=cXWFP9rROkBtOVBbD4+35DFccSyXDkYhpw5U891xqneFWhm+BH3Bgx98ycODBmrh4g
         sS4Ubj1DzvPn25A1PM6Q2SGNHvS4I3g3nyaN+je4Rb2YHJAU/Pra56j5HRAnJJWLRSV9
         31p/vS8lra30VtbQmGi9y8yI4LdTz1Hb5Ev2Uv02Xw7wCyVzxnAwnLtZdaeqfE3heAOx
         R+I3KWADfGLneVGwauDt6ASfhaDcV6DFyspxLqoBLJ/eRdv1bc7bACAOZ5EMQcXpFNC7
         xZX2EaSscuNo00fE9yPbrOG8s4xZPAeFEfa9wbYyAjIMI9iwUR2A2DEg6BJyee1SpUIm
         NhnA==
X-Gm-Message-State: AJIora/5ROmdGxbAi418y4fb+xR2rjgyG40lUpFDbzxSpPYVgQHvYF2q
        /Ll33t0HZRkvD/+iBKN+IGr9LGT8yHDMsw==
X-Google-Smtp-Source: AGRyM1uobcyCR9CrxW0vfxC8jLAkB6m+K5e2IPgk+p68PSbp9SU3z7MQSmR6tZKJpFHc7of3VUh1nw==
X-Received: by 2002:a17:90a:6444:b0:1ea:b662:c12e with SMTP id y4-20020a17090a644400b001eab662c12emr5289818pjm.199.1655222465497;
        Tue, 14 Jun 2022 09:01:05 -0700 (PDT)
Received: from n131-251-240.byted.org ([121.30.179.186])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79691000000b00518d06efbc8sm8008508pfk.98.2022.06.14.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:01:05 -0700 (PDT)
From:   Zhi Song <zhi.song@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhi Song <zhi.song@bytedance.com>
Subject: [PATCH] node: put_device after failing to device_register
Date:   Wed, 15 Jun 2022 00:00:59 +0800
Message-Id: <20220614160059.1739862-1-zhi.song@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_register() is used to register a device with the system.
We need to call put_device() to give up the reference initialized
in device_register() when it returns an error and this will clean
up correctly.

Signed-off-by: Zhi Song <zhi.song@bytedance.com>
---
 drivers/base/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ac6376ef7a1..88a3337c546e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -154,6 +154,7 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 	list_add_tail(&access_node->list_node, &node->access_list);
 	return access_node;
 free_name:
+	put_device(dev);
 	kfree_const(dev->kobj.name);
 free:
 	kfree(access_node);
-- 
2.30.2

