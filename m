Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF1D5A1B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiHYV3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiHYV3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:29:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DBCBD2AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:29:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h22so31726133ejk.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=N6mUWstz7/GZuk8gVUfvEQxNLjPXVK6ZWWrfepRR/oY=;
        b=k0unfdejZ8bzDfqcBi8X9NzklJS1acMebUScpkGBo9g16789OB1GCNn6Bya5nZPSPo
         8ln8lsJ1FPjb6o0Ts3km1bIq/RbLVmaxVqNHDS6Nl+pwFtaZb8WwGAC1rOfuHtRLqz1M
         jgiZvsufPrj1vTdzNMBL2eXTPqG5QSQ6v/GS7XKOFoZGiqPrBdeLIrWNVTekjT4lH2pK
         ADdjLBJ7s0q7wj9BPikRpPKdEZ7Nml4F9I/OYh5EE01Jdeq0iLdZrVHh8jUyPL3tTPMb
         RN4092020qR4TIhamwDouAV32zeWrNhR/WCK50Dk6sHq7ry8v10+Cz9txvdBWvXyRVpR
         TgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=N6mUWstz7/GZuk8gVUfvEQxNLjPXVK6ZWWrfepRR/oY=;
        b=fiVfd6xCY0S7zfLadB59x5GkOMoweYE+1kaHX5CTZfUF6XMeyy9Azw2MRUHibhqyZZ
         udCRqQsADc3f3eHgrYsVbkokIMgFxyUhYS+amaaEFXqMqh5XcgQSubQAnxYG5N3xNP5g
         0TiuOf103jT6vxrmRFI4VcsQMITfCfS6FZv9MSSp6Uaf/j6h8cOObM54oSPav3MnEcNM
         eO3KSciWTyVHa78ZMMSd8oOgeuTn53rMuUsTZlCg1lEDOgXFiR+k5GZZZrbmTDuNubZh
         UL6jZJsAcFAh+UH00BeiDPZN2w+rZtvkVO5+uchLY4OgqMXdOBFIe1Cv1M2fOAXtZwwh
         OsxQ==
X-Gm-Message-State: ACgBeo1YPrNH7HoU5bENCrUXR2YuVArTvcza7HK58FgD8T6YpMhBnz+s
        nJYM+THLVqZu569AiVmRlrEIug==
X-Google-Smtp-Source: AA6agR7TX2aV9XD+2pGdV3PwuC/Ru2piDDPY6M5k/pGiZPU0dAkIycRF0jCmSlC3S8345ugq0AJE2Q==
X-Received: by 2002:a17:907:a06e:b0:73e:ab7e:67be with SMTP id ia14-20020a170907a06e00b0073eab7e67bemr282659ejc.20.1661462941021;
        Thu, 25 Aug 2022 14:29:01 -0700 (PDT)
Received: from p330.kohl.home (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906538100b007308bebce51sm95062ejo.171.2022.08.25.14.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:29:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
To:     broonie@kernel.org, m.szyprowski@samsung.com
Cc:     christian@kohlschutter.com, heiko@sntech.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        m.reichl@fivetechno.de, robin.murphy@arm.com,
        vincent.legoll@gmail.com, wens@kernel.org
Subject: [PATCH v5] regulator: core: Resolve supply name earlier to prevent double-init
Date:   Thu, 25 Aug 2022 21:28:42 +0000
Message-Id: <20220825212842.7176-1-christian@kohlschutter.com>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
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

Previously, an unresolved regulator supply reference upon calling
regulator_register on an always-on or boot-on regulator caused
set_machine_constraints to be called twice.

This in turn may initialize the regulator twice, leading to voltage
glitches that are timing-dependent. A simple, unrelated configuration
change may be enough to hide this problem, only to be surfaced by
chance.

One such example is the SD-Card voltage regulator in a NanoPI R4S that
would not initialize reliably unless the registration flow was just
complex enough to allow the regulator to properly reset between calls.

Fix this by re-arranging regulator_register, trying resolve the
regulator's supply early enough that set_machine_constraints does not
need to be called twice.

Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
---
 drivers/regulator/core.c | 58 ++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 77f60eef960..2ff0ab2730f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5391,6 +5391,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	bool dangling_of_gpiod = false;
 	struct device *dev;
 	int ret, i;
+	bool resolved_early = false;
 
 	if (cfg == NULL)
 		return ERR_PTR(-EINVAL);
@@ -5494,24 +5495,10 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
 	INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
 
-	/* preform any regulator specific init */
-	if (init_data && init_data->regulator_init) {
-		ret = init_data->regulator_init(rdev->reg_data);
-		if (ret < 0)
-			goto clean;
-	}
-
-	if (config->ena_gpiod) {
-		ret = regulator_ena_gpio_request(rdev, config);
-		if (ret != 0) {
-			rdev_err(rdev, "Failed to request enable GPIO: %pe\n",
-				 ERR_PTR(ret));
-			goto clean;
-		}
-		/* The regulator core took over the GPIO descriptor */
-		dangling_cfg_gpiod = false;
-		dangling_of_gpiod = false;
-	}
+	if (init_data && init_data->supply_regulator)
+		rdev->supply_name = init_data->supply_regulator;
+	else if (regulator_desc->supply_name)
+		rdev->supply_name = regulator_desc->supply_name;
 
 	/* register with sysfs */
 	rdev->dev.class = &regulator_class;
@@ -5533,13 +5520,38 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		goto wash;
 	}
 
-	if (init_data && init_data->supply_regulator)
-		rdev->supply_name = init_data->supply_regulator;
-	else if (regulator_desc->supply_name)
-		rdev->supply_name = regulator_desc->supply_name;
+	if ((rdev->supply_name && !rdev->supply) &&
+		(rdev->constraints->always_on ||
+		 rdev->constraints->boot_on)) {
+		ret = regulator_resolve_supply(rdev);
+		if (ret != 0)
+			rdev_dbg(rdev, "Unable to resolve supply early: %pe\n",
+				 ERR_PTR(ret));
+
+		resolved_early = true;
+	}
+
+	/* perform any regulator specific init */
+	if (init_data && init_data->regulator_init) {
+		ret = init_data->regulator_init(rdev->reg_data);
+		if (ret < 0)
+			goto wash;
+	}
+
+	if (config->ena_gpiod) {
+		ret = regulator_ena_gpio_request(rdev, config);
+		if (ret != 0) {
+			rdev_err(rdev, "Failed to request enable GPIO: %pe\n",
+					 ERR_PTR(ret));
+			goto wash;
+		}
+		/* The regulator core took over the GPIO descriptor */
+		dangling_cfg_gpiod = false;
+		dangling_of_gpiod = false;
+	}
 
 	ret = set_machine_constraints(rdev);
-	if (ret == -EPROBE_DEFER) {
+	if (ret == -EPROBE_DEFER && !resolved_early) {
 		/* Regulator might be in bypass mode and so needs its supply
 		 * to set the constraints
 		 */
-- 
2.36.2

