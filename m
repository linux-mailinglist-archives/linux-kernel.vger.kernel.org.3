Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD1455C2DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiF0Oen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiF0Oeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:34:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9928B4B0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:34:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i1so8865260wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xB8UF+1tDPAXFYTIVsS3DO5NWz4Ya+4+jwXr4K8uGY4=;
        b=AJIzkWdzmwXuWsgoUh3V1S5FPxgkiqaYzCMmPzq9XHPYalj6+qW1saZG+4HGJvDpq5
         HQ/HgHzM3wZHOha2ru5LyYryCnTjySxFhBKaajcE4rUiwrXLapHvNI77u2cHDrW0/IUZ
         BQR4/vIpZ9Aq+c/cHH2bAmAy2/C4keJKdsu3ISRg6kkr7MyAgl+VIAlYIM+v+Na7f6HL
         RWTjq3f/mwZSNu0abZ/OjlPU1D9D+vTh03SpjxTWxhuwuRYVisIp6uZEwL2l/hLj67ce
         2drkMNUGf5DZWYarBPLirlKWQBoGI8dsW6t4XnumEE6thSCclo6GBQIzBQky8cOwIyWE
         6DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xB8UF+1tDPAXFYTIVsS3DO5NWz4Ya+4+jwXr4K8uGY4=;
        b=p9rhDTD50GrW78qEtfSyMiuDFyZyk98GbsDJEeNOJcUIDgnXLmhh84k2tsqPxG8wG9
         OaBQdNqWw/pfpXBki5WHEybwHNYPU4DqwZVz9lErnDvkvZJvMXwCEsTJfEelqVu9aQ8z
         MUVmkFR4fNorLjZpAjDM+rNOemvwdL7CALPXLnJZXvkMtAgvM46Ygs2LOJ96aXH5cKB1
         vMfdiMBmkYWJFFQ/7Dr7lzdWiTGCo2inIS4z3JWyYt4Z/KKa7znlrdv3VLfXbj94tySW
         a1cQyp7BMflHpKy5+f7QCSqPOY9zkDaNsMGQNdRDUWxzbBgceHHvJW9j9ms1t7hwA4KZ
         +NNA==
X-Gm-Message-State: AJIora9G8or7A79pVbkc3nP7grDTB/g1RuFXU6bZjlfiDPWhGUaydw4X
        ffnxkkgaHNxjOKyeaLOsPlQXj+bXZ+zINg==
X-Google-Smtp-Source: AGRyM1tdNzfJe35MBV2efHUhsb8vXnQsyopl2HbpGBgoVC7JyGAAsXWe4v9sCz1BfXZPfaDNT+3wiQ==
X-Received: by 2002:a05:6000:1865:b0:21b:a408:b474 with SMTP id d5-20020a056000186500b0021ba408b474mr12677672wri.674.1656340474592;
        Mon, 27 Jun 2022 07:34:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5544000000b0021a39f5ba3bsm10662853wrw.7.2022.06.27.07.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:34:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: samsung: Enable compile test
Date:   Mon, 27 Jun 2022 16:34:12 +0200
Message-Id: <20220627143412.477226-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220627143412.477226-1-krzysztof.kozlowski@linaro.org>
References: <20220627143412.477226-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow compile testing of Samsung SoC Sound drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/Kconfig | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index a2221ebb1b6a..2a61e620cd3b 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -33,7 +33,8 @@ config SND_SAMSUNG_I2S
 
 config SND_SOC_SAMSUNG_NEO1973_WM8753
 	tristate "Audio support for Openmoko Neo1973 Smartphones (GTA02)"
-	depends on MACH_NEO1973_GTA02
+	depends on MACH_NEO1973_GTA02 || COMPILE_TEST
+	depends on SND_SOC_I2C_AND_SPI
 	select SND_S3C24XX_I2S
 	select SND_SOC_WM8753
 	select SND_SOC_BT_SCO
@@ -43,7 +44,8 @@ config SND_SOC_SAMSUNG_NEO1973_WM8753
 
 config SND_SOC_SAMSUNG_JIVE_WM8750
 	tristate "SoC I2S Audio support for Jive"
-	depends on MACH_JIVE && I2C
+	depends on MACH_JIVE && I2C || COMPILE_TEST && ARM
+	depends on SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8750
 	select SND_S3C2412_SOC_I2S
 	help
@@ -69,7 +71,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8994
 
 config SND_SOC_SAMSUNG_S3C24XX_UDA134X
 	tristate "SoC I2S Audio support UDA134X wired to a S3C24XX"
-	depends on ARCH_S3C24XX
+	depends on ARCH_S3C24XX || COMPILE_TEST
 	select SND_S3C24XX_I2S
 	select SND_SOC_L3
 	select SND_SOC_UDA134X
@@ -81,21 +83,24 @@ config SND_SOC_SAMSUNG_SIMTEC
 
 config SND_SOC_SAMSUNG_SIMTEC_TLV320AIC23
 	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
-	depends on ARCH_S3C24XX && I2C
+	depends on ARCH_S3C24XX || COMPILE_TEST
+	depends on I2C
 	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_SAMSUNG_SIMTEC
 
 config SND_SOC_SAMSUNG_SIMTEC_HERMES
 	tristate "SoC I2S Audio support for Simtec Hermes board"
-	depends on ARCH_S3C24XX && I2C
+	depends on ARCH_S3C24XX || COMPILE_TEST
+	depends on I2C
 	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_SAMSUNG_SIMTEC
 
 config SND_SOC_SAMSUNG_H1940_UDA1380
 	tristate "Audio support for the HP iPAQ H1940"
-	depends on ARCH_H1940 && I2C
+	depends on ARCH_H1940 || COMPILE_TEST
+	depends on I2C
 	select SND_S3C24XX_I2S
 	select SND_SOC_UDA1380
 	help
@@ -103,7 +108,8 @@ config SND_SOC_SAMSUNG_H1940_UDA1380
 
 config SND_SOC_SAMSUNG_RX1950_UDA1380
 	tristate "Audio support for the HP iPAQ RX1950"
-	depends on MACH_RX1950 && I2C
+	depends on MACH_RX1950 || COMPILE_TEST
+	depends on I2C
 	select SND_S3C24XX_I2S
 	select SND_SOC_UDA1380
 	help
-- 
2.34.1

