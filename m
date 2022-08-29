Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F15A5257
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiH2Q4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiH2Q4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:56:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27722B62F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:56:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id cu2so17004448ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=88K4+TLVUo0SZBqnuedDZAAtJGW65jtkotKx2tWux4w=;
        b=b5wu3ceMdhWyNutScJuZIBwlVDrKh4SWcYTvLFnvCj63SjC6hjviO6aJx5rwAPkPVC
         z75GEKCTpmAPglR+2NSUV45quW5kZJj+zM34zO9Fed6dhNYbraihvUgax7dKZpJ371pX
         lMlpPUz7MI54mn1xDCMu5dJxXChWaqRhvhVw1qFYkOuGAZwjXuOu+8aF9hOptfD7uPv/
         S7ZFbeOj5/lm92QMHF6TZqclBA9XDWWtMuDSM8jMCLSKto5z2TpCXV0BOqirLfRiQa5F
         UxEpaIlogDDrDDMvYyHJRuNJsZEIuFPNspN0xx1qjUr09hNQriS0jwZEC4czKc3028Z6
         aPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=88K4+TLVUo0SZBqnuedDZAAtJGW65jtkotKx2tWux4w=;
        b=bsSeOvo0ZT5Lh/B1pO8Jev2wg8PnQHKMyh2Ut0bSLfCtDQBdIT7Xcu31mvNIE3yOIy
         LlKTUS3VnzH9j/5UDit/mffUpF3e3oe1xJ9LrvpwR1esxW1Tj8/vfggZJ1pu3jfOiRvK
         UJ3bMW4w9odLMkBvhAntPG6jToXOWAZYReQ84NOFWev7PYqbEU3rGikx0M7SQct1MIoZ
         TCfWfB7cLP4jLZxtU8fdYRG/QiK4Z26xShdSWVMFbrdNZLq0VeArNguIRMB+an65/le2
         cm8JQ8brF3xKi78SMp+3NvhWHB+1btwAVg8M5PRMrJu51AFyH9O/dxTl30ptdYyaopjP
         IKfQ==
X-Gm-Message-State: ACgBeo1ikjm3KW4xpynzAyHAMhBTpvtozDkYMvmWZX/QvNsH/RNSbspc
        1zj9mcj8OaTUMD4FU8W/06+fnEF2WoYNBD5L
X-Google-Smtp-Source: AA6agR7knbzfglL1V8ncw5OA1DeeDFObheh09PJKN2ltBTimKn2gYUzwHtoJpSM9lrV36fgnOKQgDg==
X-Received: by 2002:a17:907:6092:b0:731:59f0:49ac with SMTP id ht18-20020a170907609200b0073159f049acmr14138215ejc.383.1661792163199;
        Mon, 29 Aug 2022 09:56:03 -0700 (PDT)
Received: from p330.kohl.home (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709061bb200b007304bdf18cfsm4682160ejg.136.2022.08.29.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:56:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
To:     m.szyprowski@samsung.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Fix regulator supply registration with sysfs
Date:   Mon, 29 Aug 2022 16:55:43 +0000
Message-Id: <20220829165543.24856-1-christian@kohlschutter.com>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In "regulator: core: Resolve supply name earlier to prevent
double-init", we introduced a bug that prevented the regulator names
from registering properly with sysfs.

Reorder regulator_register such that supply names are properly resolved
and registered.

Fixes: 8a866d527ac0 ("regulator: core: Resolve supply name earlier to prevent double-init")
Link: https://lore.kernel.org/all/58b92e75-f373-dae7-7031-8abd465bb874@samsung.com/
Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
---
 drivers/regulator/core.c | 44 +++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1d030831ae..b1ece764de 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5414,6 +5414,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	bool dangling_of_gpiod = false;
 	struct device *dev;
 	int ret, i;
+	bool resolved_early = false;
 
 	if (cfg == NULL)
 		return ERR_PTR(-EINVAL);
@@ -5517,6 +5518,18 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
 	INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
 
+	if (init_data && init_data->supply_regulator)
+		rdev->supply_name = init_data->supply_regulator;
+	else if (regulator_desc->supply_name)
+		rdev->supply_name = regulator_desc->supply_name;
+
+	/* register with sysfs */
+	rdev->dev.class = &regulator_class;
+	rdev->dev.parent = dev;
+	dev_set_name(&rdev->dev, "regulator.%lu",
+		    (unsigned long) atomic_inc_return(&regulator_no));
+	dev_set_drvdata(&rdev->dev, rdev);
+
 	/* set regulator constraints */
 	if (init_data)
 		rdev->constraints = kmemdup(&init_data->constraints,
@@ -5527,33 +5540,25 @@ regulator_register(const struct regulator_desc *regulator_desc,
 					    GFP_KERNEL);
 	if (!rdev->constraints) {
 		ret = -ENOMEM;
-		goto clean;
+		goto wash;
 	}
 
-	if (init_data && init_data->supply_regulator)
-		rdev->supply_name = init_data->supply_regulator;
-	else if (regulator_desc->supply_name)
-		rdev->supply_name = regulator_desc->supply_name;
-
 	if ((rdev->supply_name && !rdev->supply) &&
-			(rdev->constraints->always_on ||
-			 rdev->constraints->boot_on)) {
-		/* Try to resolve the name of the supplying regulator here first
-		 * so we prevent double-initializing the regulator, which may
-		 * cause timing-specific voltage brownouts/glitches that are
-		 * hard to debug.
-		 */
+		(rdev->constraints->always_on ||
+		 rdev->constraints->boot_on)) {
 		ret = regulator_resolve_supply(rdev);
 		if (ret)
 			rdev_dbg(rdev, "unable to resolve supply early: %pe\n",
 					 ERR_PTR(ret));
+
+		resolved_early = true;
 	}
 
 	/* perform any regulator specific init */
 	if (init_data && init_data->regulator_init) {
 		ret = init_data->regulator_init(rdev->reg_data);
 		if (ret < 0)
-			goto clean;
+			goto wash;
 	}
 
 	if (config->ena_gpiod) {
@@ -5561,22 +5566,15 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		if (ret != 0) {
 			rdev_err(rdev, "Failed to request enable GPIO: %pe\n",
 				 ERR_PTR(ret));
-			goto clean;
+			goto wash;
 		}
 		/* The regulator core took over the GPIO descriptor */
 		dangling_cfg_gpiod = false;
 		dangling_of_gpiod = false;
 	}
 
-	/* register with sysfs */
-	rdev->dev.class = &regulator_class;
-	rdev->dev.parent = dev;
-	dev_set_name(&rdev->dev, "regulator.%lu",
-		    (unsigned long) atomic_inc_return(&regulator_no));
-	dev_set_drvdata(&rdev->dev, rdev);
-
 	ret = set_machine_constraints(rdev);
-	if (ret == -EPROBE_DEFER) {
+	if (ret == -EPROBE_DEFER && !resolved_early) {
 		/* Regulator might be in bypass mode and so needs its supply
 		 * to set the constraints
 		 */
-- 
2.36.2

