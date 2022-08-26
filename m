Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA95A2490
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiHZJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343983AbiHZJhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:37:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF96A1D3C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:37:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id k22so1055710ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Mlpv6zMC5nZyYiheus3egIapL2MqYMyQVfbERY5zhDI=;
        b=RLdJJxcqyMf5k/P5cumVodYAzSpCgKk4K0C6c08pnMkW6mc5Mz5l0tn1gHKZ1kRfwo
         AZ57POhXMBDqLhGc/erFt4rpe5Lfd0CwxLqX7ejyH8qPX4IeqOhpHCtEJ6zbv/e4H/pF
         VlLjzzy7ylB4OZQ3SzefGUM7+SPR5m6MHSYSIxH7miD4Gq1WVyto+jwM+IMSWHB00Ucy
         VGgynPUDoFuJyY8v714w6DQKHgoY/t3qk7SEMbEtFwMeGmnideXp03SY5a/tEYkHIZJ/
         t+3FM8y2QnpON9G00cWuvO+IOlHpVfKSiBLkJicApLTv9cvaBZjsjWZtgnXaxbmymgyX
         M8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Mlpv6zMC5nZyYiheus3egIapL2MqYMyQVfbERY5zhDI=;
        b=kzWskSm9hIvAUK5Yga3ZOjq9VqeUL/Lsi4rjcAJoKRkszAkZUsDkMos6T68md77h7G
         zH+vnLT1RaeIGUP2KFE6n/yqMJtY7UQp9BXi1TY/T/0wRvXoHQzqOVppU6Qh4WK/sdlf
         VmeI992GIs2AIMA64NkW3YJPZV8aFnmXpFllYrZmh9zSv+DqG7uyu2WDikAilqzq59L6
         L3z8sl6luOQ3a67ds4G88wlQg1AHcE9VN8m1+7UNymJ8sw3oAClVrRrUMHtkPXw5wn6V
         2To+52tNwhhav31l3e5XM0VduBsdU/53ZBYK8HN0VljmMVxcS6GvW6urjAzEKYfrTylW
         ThyQ==
X-Gm-Message-State: ACgBeo2h76CuCDkNPNX2RFk7qSLj44RQamXnd7C9Z/T596Yi50iteDFP
        MgbJsWNZw/q6P1xDfo9SQnxWVQ==
X-Google-Smtp-Source: AA6agR6B7J/kOZXk73idA4fIQppxgN1IPDOxplY7U2v6gFNy8ic61L00Si0eFSiypKmYhwoDY9CxLA==
X-Received: by 2002:a2e:3515:0:b0:261:e569:77ff with SMTP id z21-20020a2e3515000000b00261e56977ffmr2214941ljz.478.1661506623008;
        Fri, 26 Aug 2022 02:37:03 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048af6242892sm334329lfg.14.2022.08.26.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:37:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: allow compile testing without MFD drivers
Date:   Fri, 26 Aug 2022 12:36:59 +0300
Message-Id: <20220826093659.1059276-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Motorola CPCAP, Lochnagar Sound, Rockchip RK817 and Qualcomm
WCD9340/WCD9341 do not depend on parent MFD driver in build time and can
be compile tested without respective MFD part for increased build
coverage.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 5926b33ba09e..94b7bb85d236 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -610,7 +610,7 @@ config SND_SOC_BT_SCO
 
 config SND_SOC_CPCAP
 	tristate "Motorola CPCAP codec"
-	depends on MFD_CPCAP
+	depends on MFD_CPCAP || COMPILE_TEST
 
 config SND_SOC_CQ0093VC
 	tristate
@@ -972,7 +972,7 @@ config SND_SOC_LM49453
 
 config SND_SOC_LOCHNAGAR_SC
 	tristate "Lochnagar Sound Card"
-	depends on MFD_LOCHNAGAR
+	depends on MFD_LOCHNAGAR || COMPILE_TEST
 	help
 	  This driver support the sound card functionality of the Cirrus
 	  Logic Lochnagar audio development board.
@@ -1197,7 +1197,7 @@ config SND_SOC_RK3328
 
 config SND_SOC_RK817
 	tristate "Rockchip RK817 audio CODEC"
-	depends on MFD_RK808
+	depends on MFD_RK808 || COMPILE_TEST
 	select REGMAP_I2C
 
 config SND_SOC_RL6231
@@ -1745,7 +1745,7 @@ config SND_SOC_WCD934X
 	tristate "WCD9340/WCD9341 Codec"
 	depends on COMMON_CLK
 	select SND_SOC_WCD_MBHC
-	depends on MFD_WCD934X
+	depends on MFD_WCD934X || COMPILE_TEST
 	help
 	  The WCD9340/9341 is a audio codec IC Integrated in
 	  Qualcomm SoCs like SDM845.
-- 
2.34.1

