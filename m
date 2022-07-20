Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ACA57B543
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbiGTLWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTLWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:22:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE94D839;
        Wed, 20 Jul 2022 04:22:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w12so23299031edd.13;
        Wed, 20 Jul 2022 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=x6bTFSKyRmleL7Dcjv7zFamUjXAsDrcKNCo9RyO5i3o=;
        b=Y8uILXcdoWMp6Wk6wHyJ4K/lV45McZ2OZJDHGvs7kZgckdf3wvvdV463+0j93hM44t
         +/V1LEF42K2EjEXWl5+naoF8Wl3/mIFYuyjm0UYHSP4g78XihNv9+eiFvxs4YWsJqmb5
         3PQsfBDcmM/xumAd1sNDeL7qlwb4CuJ6sI2t4tQ7VTXXKc+P4irlWgGLszKxNJAhV6h0
         u1Yfs7JFXjM4s1i1R3CnOhPXGlVjLuJCIjnFP8PIlh3AqC7O+gG+m3Nzg1q+2cMacTPB
         VzY3wZIPC2xJ0KMljwSkbXrRON2TgitAp+4++P5Sl9UVew/E+KLPF8hRk7ZCfp2QpKrk
         HrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x6bTFSKyRmleL7Dcjv7zFamUjXAsDrcKNCo9RyO5i3o=;
        b=36pYODYzl4qvWmHEfWO2scHz+GQW2rgqQWbo/q8+PZmaJduAELgsHGgc3IV4DCFqmr
         FrWcgT/Bd3XpiFfcjrExhYgdq6ozmtGXnp0QdRxtErZsUOeNdGCcx4Ajqqu3HWofnazN
         QcgW2+FPfJrffAcFRhfrYbaZQEvEBhfRB7vmLdyubdB7BEU30RIrvbMrH9a/KZOdFJ1r
         E3r2g0sEsmZADhP/ONRjOadcjGJYP1lt/vo2qt6F8AT7gAjGaRAVzHeZTvnx3it38qGP
         y+iJMnwHMU0VjMOtj4d4yZCj2SKee+RD7fZF4HaWofY80bJqC/E46FWFizWTeMbSjUyj
         vGBw==
X-Gm-Message-State: AJIora/1ZPDGefNdzD2H/T32dq3sHrXx61vNZK+nEAE0C9l2tdK8pBJm
        UO+4MX40BT10AgqXmRzMCwU=
X-Google-Smtp-Source: AGRyM1vR/ULUFptmOZ0qgSdaTMZEkAbK7i0xFniwm23m7Y2zbA29wfKRpfqCK5P/rAu97gaFYExbew==
X-Received: by 2002:aa7:db8a:0:b0:43b:75b1:92e9 with SMTP id u10-20020aa7db8a000000b0043b75b192e9mr10819428edt.223.1658316126718;
        Wed, 20 Jul 2022 04:22:06 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f008020c2fc6e115b3e.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:8020:c2fc:6e11:5b3e])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7cd4a000000b00437d3e6c4c7sm12176965edw.53.2022.07.20.04.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 04:22:06 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ASoC: ti: remove sound support for DaVinci DM644x and DM646x
Date:   Wed, 20 Jul 2022 13:21:52 +0200
Message-Id: <20220720112152.22918-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7dd33764486d ("ARM: davinci: Delete DM644x board files") and commit
b4aed01de486 ("ARM: davinci: Delete DM646x board files") removes the
support for DaVinci DM644x and DM646x boards.

Hence, remove the sound support for those boards as well.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 sound/soc/ti/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 40110e9a9e8a..35fddd7c501a 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -180,9 +180,6 @@ config SND_SOC_DAVINCI_EVM
 	select SND_SOC_DAVINCI_ASP if MACH_DAVINCI_DM355_EVM
 	select SND_SOC_DAVINCI_ASP if SND_SOC_DM365_AIC3X_CODEC
 	select SND_SOC_DAVINCI_VCIF if SND_SOC_DM365_VOICE_CODEC
-	select SND_SOC_DAVINCI_ASP if MACH_DAVINCI_EVM # DM6446
-	select SND_SOC_DAVINCI_MCASP if MACH_DAVINCI_DM6467_EVM
-	select SND_SOC_SPDIF if MACH_DAVINCI_DM6467_EVM
 	select SND_SOC_DAVINCI_MCASP if MACH_DAVINCI_DA830_EVM
 	select SND_SOC_DAVINCI_MCASP if MACH_DAVINCI_DA850_EVM
 	select SND_SOC_TLV320AIC3X
@@ -191,8 +188,6 @@ config SND_SOC_DAVINCI_EVM
 	  DaVinci EVM platforms:
 	  - DM355
 	  - DM365
-	  - DM6446
-	  - DM6447
 	  - DM830
 	  - DM850
 
-- 
2.17.1

