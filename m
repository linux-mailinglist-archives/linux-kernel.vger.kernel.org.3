Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8561A5703C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiGKNEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiGKNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:04:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689862E6AB;
        Mon, 11 Jul 2022 06:04:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l23so8698499ejr.5;
        Mon, 11 Jul 2022 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=crNzBSeJ7lK9mknHlFCoUyGG/CrQDaWglIgpkcg1zVQ=;
        b=avg8K6vlxl5NYKO0Z+EFrgmOcbeCjZ9uVNqnllKQZSoBzaakQbS1Bd3fSVS7BO9MC8
         WpAfbNsCHarPAGLWWmUx1jhiGVCywWp67Xh5BUzIhoaRp+SiS1aeyO9NHXmwiiwBDf+t
         +m7NeocZolYuzgThpwmpSL7TXOQCShHq8ErBXg3FFq6F6W2j0ngRAldUibXF67AQWoW9
         e+6v+DuWYKIAREnBoH+yss6xdcFRHOWEIlQxsYuCsn5uiGPK9dRzOmtm3TAWmXEr5cld
         /gNtSVj+TyhaSE4K/rPblpH/Vlh55/B/KesnmqkQC5f/wQpHIeICAuwVLKMniHh3D+nD
         VCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=crNzBSeJ7lK9mknHlFCoUyGG/CrQDaWglIgpkcg1zVQ=;
        b=nW4U3ehlznFXZTMK/8xfb7pP5zR/LvuSfCdrPupZKtarInI8Bu/4ZnZ0h+HWgg6wXZ
         zT7NuIlnuBjiw5rTt9LKrCABGcB0LDz6tppmCUG5QkTCr/ZYciTTDBzXMzjgm3Cgmv52
         N9iQyPpdTPck44RsGfDLcDUJHAbHSJHJs/BErl0Gd+veM03i3njNQqpmSFMCmM8lPMnS
         /m2w8a4ZTvbHcrKvWnxiOEd7+u1OizBsbHoe7LC3Xi80hcG3raVMySXc8RST1aB1vKuD
         zaEr5+wnvYc7nA1HXv7a0VnWeLHk9+C+3TcJMD3i2LDjryt1GJZW7yr1k5nrTdAouKWx
         Iv+g==
X-Gm-Message-State: AJIora9hfodkS/Dj9l0zEeay66aQkNhPjMo59/mwbSF3fVE0DTHsJxdL
        17Y40+GxUyil3yjxJBtCTpk=
X-Google-Smtp-Source: AGRyM1sLlJLWsvUk72znMxivUzcTmtDNr4UpMHhxFdg57+JaMCuxbs1vlEUFhgd4zUynCIpR2NyJ9A==
X-Received: by 2002:a17:907:7781:b0:6fe:4398:47b3 with SMTP id ky1-20020a170907778100b006fe439847b3mr18633439ejc.513.1657544686868;
        Mon, 11 Jul 2022 06:04:46 -0700 (PDT)
Received: from felia.fritz.box (200116b8266e42009c70ae84c5cabc2b.dip.versatel-1u1.de. [2001:16b8:266e:4200:9c70:ae84:c5ca:bc2b])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906a20b00b0072b2378027csm2634507ejy.26.2022.07.11.06.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 06:04:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm: milbeaut: remove select of non-existing PINCTRL_MILBEAUT
Date:   Mon, 11 Jul 2022 15:04:32 +0200
Message-Id: <20220711130432.1135-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series "Add basic support for Socionext Milbeaut M10V SoC" (see
Link) introduced the config ARCH_MILBEAUT_M10V "Milbeaut SC2000/M10V
platform" in ./arch/arm/mach-milbeaut/ and intended to introduce timer,
clock, pinctrl and serial controller drivers.

However, during patch submission in March 2019, the introduction of the
milbeaut pinctrl driver was dropped from v2 to v3 of the patch series.
Since then, there was no further patch series to add this pinctrl driver
later on.

Hence, selecting PINCTRL_MILBEAUT in config is simply dangling and
referring to a non-existing config symbols.
Fortunately, ./scripts/checkkconfigsymbols.py warns:

PINCTRL_MILBEAUT
Referencing files: arch/arm/mach-milbeaut/Kconfig

Remove this select of the non-existing PINCTRL_MILBEAUT for now.

Link: https://lore.kernel.org/linux-arm-kernel/1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Russell, please pick this minor non-urgent clean-up patch.

 arch/arm/mach-milbeaut/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-milbeaut/Kconfig b/arch/arm/mach-milbeaut/Kconfig
index 6a576fd8521e..f9d1006f9442 100644
--- a/arch/arm/mach-milbeaut/Kconfig
+++ b/arch/arm/mach-milbeaut/Kconfig
@@ -13,7 +13,6 @@ config ARCH_MILBEAUT_M10V
 	select ARM_ARCH_TIMER
 	select MILBEAUT_TIMER
 	select PINCTRL
-	select PINCTRL_MILBEAUT
 	help
 	  Support for Socionext's MILBEAUT M10V based systems
 
-- 
2.17.1

