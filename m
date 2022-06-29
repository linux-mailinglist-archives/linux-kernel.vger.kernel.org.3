Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FAB560A33
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiF2TUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiF2TUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8C902EA23
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656530449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tFVPrpGIRVp0BLeI5a57lLi4ssxUxyA/yiqhXka4Vkw=;
        b=AU+w6iKf/BqViXJ7ajCMFlFHaVNYD1997hTFHIL0gsq/pPZ96hVAf13V9GgR6srVoBV4Fo
        JI4HsTaJY7B3DeIU/B+EPZWRd7uoHjmeUYkCPaU0HPL7CbM+CEZ7iBeIZei5tDECIfPZkV
        laakHI4ZsRgRo6nzTBS3dDcN7kkNWpE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-e353LCIqMhG0nDURcQUNpA-1; Wed, 29 Jun 2022 15:20:48 -0400
X-MC-Unique: e353LCIqMhG0nDURcQUNpA-1
Received: by mail-qk1-f198.google.com with SMTP id k190-20020a37bac7000000b006af6d953751so4282839qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFVPrpGIRVp0BLeI5a57lLi4ssxUxyA/yiqhXka4Vkw=;
        b=SvNoQN+6GGp5SLm0CMkTqdhMcNKjkqrGTGPHYRRKVLVXJvO/Q8ykdYVdjkRk2ciDZ1
         SUR4zWaYley+XVrKr/rP5v3TrIKT4nn8cCwPdJDpRa0AUg313ScFjv3+NHhfhH4ruAAQ
         ou9WmK0EJQyiRkWF5MvjqpPu6q9EX4a3Fdu2EoJ+h4CzCHhaMAkzBTY3ncPkvWpBKtQU
         OFNNxa8enudVrboZlHCbUAugCPAdkuckqgZfLnM5RHpa9XbGKJsU2/LiixBzgK3+yYnm
         RM1vGpHOlK6Gx83g3T2qD3FIDRKVRXtoDx0bLx1qRT/2O66HUXa1SyCXd5RutScE5QcZ
         uC2w==
X-Gm-Message-State: AJIora99Ff3eBxIc6YRH60AR2xHQtQEQtU4PY09KDYb2DuYrEITQegIv
        1zIxyd+2GTzJsfnbqYyg0vnplpM848n98K7/UzXurk6FoYz3bbIxGxZHJnXVcEvZeBUHBZbp/ww
        csi394gV/9veOyKoCKyZO88b5
X-Received: by 2002:a05:6214:2506:b0:470:2c9c:65fa with SMTP id gf6-20020a056214250600b004702c9c65famr9081615qvb.117.1656530448109;
        Wed, 29 Jun 2022 12:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u7udpbNcAAWo11I4FvtiEedeJXmYlurqXYJJkBdgJwBA1JJcxCuhkzAYOxK490sBhH4dUtfg==
X-Received: by 2002:a05:6214:2506:b0:470:2c9c:65fa with SMTP id gf6-20020a056214250600b004702c9c65famr9081595qvb.117.1656530447839;
        Wed, 29 Jun 2022 12:20:47 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r4-20020ac84244000000b00317ca023e33sm10799903qtm.80.2022.06.29.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:20:47 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     sre@kernel.org, asmaa@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] power: reset: pwr-mlxbf: change rst_pwr_hid and low_pwr_hid from global to local variables
Date:   Wed, 29 Jun 2022 15:20:45 -0400
Message-Id: <20220629192045.4107237-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports
drivers/power/reset/pwr-mlxbf.c:19:12: warning: symbol 'rst_pwr_hid' was not declared. Should it be static?
drivers/power/reset/pwr-mlxbf.c:20:12: warning: symbol 'low_pwr_hid' was not declared. Should it be static?

Both rst_pwr_hid and low_pwr_hid are only used in a single function
so they should be local variables.

Fixes: a4c0094fcf76 ("power: reset: pwr-mlxbf: add BlueField SoC power control driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/reset/pwr-mlxbf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxbf.c
index 1c4904c0e1f5..12dedf841a44 100644
--- a/drivers/power/reset/pwr-mlxbf.c
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -16,9 +16,6 @@
 #include <linux/reboot.h>
 #include <linux/types.h>
 
-const char *rst_pwr_hid = "MLNXBF24";
-const char *low_pwr_hid = "MLNXBF29";
-
 struct pwr_mlxbf {
 	struct work_struct send_work;
 	const char *hid;
@@ -31,6 +28,8 @@ static void pwr_mlxbf_send_work(struct work_struct *work)
 
 static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr)
 {
+	const char *rst_pwr_hid = "MLNXBF24";
+	const char *low_pwr_hid = "MLNXBF29";
 	struct pwr_mlxbf *priv = ptr;
 
 	if (!strncmp(priv->hid, rst_pwr_hid, 8))
-- 
2.27.0

