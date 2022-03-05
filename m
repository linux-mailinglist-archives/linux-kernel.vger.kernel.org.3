Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784894CE5E8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiCEQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCEQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:25:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB8DB1D8AA2
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646497485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X5vVGCBXhfOjvA/aAVkk1z+IDPpRkv20HBT1rIRWe78=;
        b=jGnzXxOOplScVpgz/EsBhNbCFQc2y6+pyfu75j2ffRGwiIEh1Sv26h6crT0SyeV9t7n1hZ
        /6BWFwgpcsDX2MY9R0+iMbugtItJBaY8bHZ/U17dsMkx47zqpuNOhUJn6HnyjPwcwXVUcm
        HvUBcq1y3BUTVjLsmML5Pq5uWhgaU3k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-_8KXbSewNQ-Vseu6lCFykw-1; Sat, 05 Mar 2022 11:24:44 -0500
X-MC-Unique: _8KXbSewNQ-Vseu6lCFykw-1
Received: by mail-qv1-f70.google.com with SMTP id w7-20020a0ce107000000b0043512c55ecaso9493119qvk.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 08:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5vVGCBXhfOjvA/aAVkk1z+IDPpRkv20HBT1rIRWe78=;
        b=WuaqOAJLB6GNbhc95WOyZwRixYWGLKWsw3/ndoh8IcfQkEEgoLorFXjliRCTamzasp
         zuW9F8W9PCNgZed99C22FTA2z6Z0Pkd2BRfvDS4GNvRdDVUnz9Xdv8VUkHEl5rM2OgC/
         iY7kyP4ngGBrodk5Qu+Sqsbo6LfALJ11nR8dUKKJFWZUJO+8B0Mw20oaAUnhuKfKmz8H
         t5vvJMUw87jsYcJUkyeVNuQ07iGbe5reEtowgQmDP1suf9k3CeodZI05mQIzBEtqJ890
         hNpaQHSSoN7B1sWBOgMCWM3PnRGQxVf6PbKhsJyyWEqH1UJar/ZOzWXqq6jxl5bsMpob
         u8zg==
X-Gm-Message-State: AOAM531N9m7FntRJXX/vsGOnHD68y4f4fMXARKLQaVGv2KrtohCaOTwn
        y1YiM1SiTmyVoD2m0vOuyj5dGdBnpvIwutlzXwV18wUJzl9j88VrGTVXFECDxApNFLOqk6OK3uo
        i2wI5jb8NPhprI0NnX5V+OLHk
X-Received: by 2002:a05:620a:13cc:b0:662:f88d:d45 with SMTP id g12-20020a05620a13cc00b00662f88d0d45mr2429027qkl.248.1646497483610;
        Sat, 05 Mar 2022 08:24:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9FlHALJhCXN9cNLA1EjgTmC/jjU226ABYa1Xc/qbwZ8xBWb9WdQRxA6W3++QW/Jq3Jcr+bQ==
X-Received: by 2002:a05:620a:13cc:b0:662:f88d:d45 with SMTP id g12-20020a05620a13cc00b00662f88d0d45mr2429019qkl.248.1646497483380;
        Sat, 05 Mar 2022 08:24:43 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id n1-20020a05622a11c100b002dff3364c6esm5712200qtk.19.2022.03.05.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:24:42 -0800 (PST)
From:   trix@redhat.com
To:     lgirdwood@gmail.com, broonie@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] regulator: cleanup comments
Date:   Sat,  5 Mar 2022 08:24:38 -0800
Message-Id: <20220305162438.689442-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

For spdx
Remove leading space, add space after //

Replacements
overriden to overridden
Calulate to Calculate
addional to additional
regulatior to regulator
devive to device

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/regulator/max8973-regulator.c | 2 +-
 drivers/regulator/sc2731-regulator.c  | 2 +-
 drivers/regulator/ti-abb-regulator.c  | 6 +++---
 drivers/regulator/wm8350-regulator.c  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 80b65cb87cefd..cb7e50003f702 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -459,7 +459,7 @@ static int max8973_thermal_read_temp(void *data, int *temp)
 		return ret;
 	}
 
-	/* +1 degC to trigger cool devive */
+	/* +1 degC to trigger cool device */
 	if (val & MAX77621_CHIPID_TJINT_S)
 		*temp = mchip->junction_temp_warning + 1000;
 	else
diff --git a/drivers/regulator/sc2731-regulator.c b/drivers/regulator/sc2731-regulator.c
index 0f21f95c8981c..71e5ceb679f4a 100644
--- a/drivers/regulator/sc2731-regulator.c
+++ b/drivers/regulator/sc2731-regulator.c
@@ -1,4 +1,4 @@
- //SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Spreadtrum Communications Inc.
  */
diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index 2931a0b89bffb..bd7b2f287250e 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -42,7 +42,7 @@
 /**
  * struct ti_abb_info - ABB information per voltage setting
  * @opp_sel:	one of TI_ABB macro
- * @vset:	(optional) vset value that LDOVBB needs to be overriden with.
+ * @vset:	(optional) vset value that LDOVBB needs to be overridden with.
  *
  * Array of per voltage entries organized in the same order as regulator_desc's
  * volt_table list. (selector is used to index from this array)
@@ -484,7 +484,7 @@ static int ti_abb_init_timings(struct device *dev, struct ti_abb *abb)
 	/* Calculate cycle rate */
 	cycle_rate = DIV_ROUND_CLOSEST(clock_cycles * 10, clk_rate);
 
-	/* Calulate SR2_WTCNT_VALUE */
+	/* Calculate SR2_WTCNT_VALUE */
 	sr2_wt_cnt_val = DIV_ROUND_CLOSEST(abb->settling_time * 10, cycle_rate);
 
 	dev_dbg(dev, "%s: Clk_rate=%ld, sr2_cnt=0x%08x\n", __func__,
@@ -688,7 +688,7 @@ MODULE_DEVICE_TABLE(of, ti_abb_of_match);
  * @pdev: ABB platform device
  *
  * Initializes an individual ABB LDO for required Body-Bias. ABB is used to
- * addional bias supply to SoC modules for power savings or mandatory stability
+ * additional bias supply to SoC modules for power savings or mandatory stability
  * configuration at certain Operating Performance Points(OPPs).
  *
  * Return: 0 on success or appropriate error value when fails
diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index 6579bfdb0c262..b1d5aac8917de 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1112,7 +1112,7 @@ static int wm8350_regulator_probe(struct platform_device *pdev)
 	if (pdev->id < WM8350_DCDC_1 || pdev->id > WM8350_ISINK_B)
 		return -ENODEV;
 
-	/* do any regulatior specific init */
+	/* do any regulator specific init */
 	switch (pdev->id) {
 	case WM8350_DCDC_1:
 		val = wm8350_reg_read(wm8350, WM8350_DCDC1_LOW_POWER);
-- 
2.26.3

