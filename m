Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118F75A65B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiH3Nzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiH3NzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:55:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68F7E08C;
        Tue, 30 Aug 2022 06:55:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id az27so14334866wrb.6;
        Tue, 30 Aug 2022 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aHIK9InC2wOAp/50ukDnR6oTPrR8g9uSSy4z1JjG0bw=;
        b=FeHg1THyXWoMOOpbIuvt1JN2+ADkfAd4QpfykqAKUfMa8khqDRDcT6/WWZBprXmX8T
         guuLOBdPV4RSoJmV69562KdDFu9oUtoVBmUVANd2cBevB6Nrksl4wpon5A72aLoO5GvR
         vXVIktaKRR3j7N7gl6Nm+18KsdoB3nhybuZ/G8e66PKSUdSoPZtHMI+ilsEtgbEbEW4o
         WHYwv7jjypYWapdlX2mOv5EVJFNqI4jqfousNS7Zny4Me2Yet99tCb7UWK3Jnmj75pp6
         vMOTuRdsHGVnJrkd9duX8a2MDkK758Clr8fpAws+HMdmWhUgnhWZNMy80+1dfzpNPEfq
         FBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aHIK9InC2wOAp/50ukDnR6oTPrR8g9uSSy4z1JjG0bw=;
        b=aJJNI7ut8a0W/Y+vUfshjI2ipiwjZsk00CqhMRSQxtbqf2hXeFSHtypDvxmlm8iOFT
         Bl3MlReZXHaP2eQLXcE7H7rk6OhVPqj+lCy4Vhb2n2FM4j3VzD+sHF01U/NXxUVLpwJM
         Npj5dzIkrjaB3POldjtq3vvCaJGzMIKSobUHiN9LF0dplS+raYVKIoxw9BkQOmGQRLN/
         mOGr1pz0ZN1e+hr74i61lnBMWt5B3tM55aGRKuyvajQ8PaUnZNlm27ajkJ1c87rXt4Qu
         KdoudlPMuV0GJWIcPrkje6WJQ0+qctaN976bQf+oPfSadx4pEokP5KZ/ADMGJFK3cdfy
         /w9w==
X-Gm-Message-State: ACgBeo20H6fpOHAKGo2z1ta0hdqVpc7g361UJSoNrzBpyp6pTL7VnEua
        D4U4VFd6TdLauim4/tGzXZ1cjtYJp682oQ==
X-Google-Smtp-Source: AA6agR5ZwvFjV3FIlRBKd32NXVK1oo7ThK2Ec/BpnccGaTRw1mdDUNcRoLHumHIsZpeDwu19oTJBxg==
X-Received: by 2002:aa7:d9cd:0:b0:448:1b9f:d8c2 with SMTP id v13-20020aa7d9cd000000b004481b9fd8c2mr12548203eds.43.1661866872452;
        Tue, 30 Aug 2022 06:41:12 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709060ace00b0073d6d6e698bsm5800938ejf.187.2022.08.30.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:41:12 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/2] nvmem: sort config symbols alphabetically
Date:   Tue, 30 Aug 2022 15:40:59 +0200
Message-Id: <20220830134059.18744-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830134059.18744-1-zajec5@gmail.com>
References: <20220830134059.18744-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

1. Match what most subsystems do
2. Simplify maintenance a bit
3. Reduce amount of conflicts for new drivers patches

While at it unify indent level in Makefile.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/Kconfig  | 300 +++++++++++++++++++++--------------------
 drivers/nvmem/Makefile | 114 ++++++++--------
 2 files changed, 208 insertions(+), 206 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 691375c13381..7f2557934834 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -21,6 +21,40 @@ config NVMEM_SYSFS
 	 This interface is mostly used by userspace applications to
 	 read/write directly into nvmem.
 
+# Devices
+
+config NVMEM_APPLE_EFUSES
+	tristate "Apple eFuse support"
+	depends on ARCH_APPLE || COMPILE_TEST
+	default ARCH_APPLE
+	help
+	  Say y here to enable support for reading eFuses on Apple SoCs
+	  such as the M1. These are e.g. used to store factory programmed
+	  calibration data required for the PCIe or the USB-C PHY.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called nvmem-apple-efuses.
+
+config NVMEM_BCM_OCOTP
+	tristate "Broadcom On-Chip OTP Controller support"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	depends on HAS_IOMEM
+	default ARCH_BCM_IPROC
+	help
+	  Say y here to enable read/write access to the Broadcom OTP
+	  controller.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-bcm-ocotp.
+
+config NVMEM_BRCM_NVRAM
+	tristate "Broadcom's NVRAM support"
+	depends on ARCH_BCM_5301X || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver provides support for Broadcom's NVRAM that can be accessed
+	  using I/O mapping.
+
 config NVMEM_IMX_IIM
 	tristate "i.MX IC Identification Module support"
 	depends on ARCH_MXC || COMPILE_TEST
@@ -64,6 +98,19 @@ config NVMEM_JZ4780_EFUSE
 	  To compile this driver as a module, choose M here: the module
 	  will be called nvmem_jz4780_efuse.
 
+config NVMEM_LAYERSCAPE_SFP
+	tristate "Layerscape SFP (Security Fuse Processor) support"
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on HAS_IOMEM
+	select REGMAP_MMIO
+	help
+	  This driver provides support to read the eFuses on Freescale
+	  Layerscape SoC's. For example, the vendor provides a per part
+	  unique ID there.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called layerscape-sfp.
+
 config NVMEM_LPC18XX_EEPROM
 	tristate "NXP LPC18XX EEPROM Memory Support"
 	depends on ARCH_LPC18XX || COMPILE_TEST
@@ -84,17 +131,32 @@ config NVMEM_LPC18XX_OTP
 	  To compile this driver as a module, choose M here: the module
 	  will be called nvmem_lpc18xx_otp.
 
-config NVMEM_MXS_OCOTP
-	tristate "Freescale MXS On-Chip OTP Memory Support"
-	depends on ARCH_MXS || COMPILE_TEST
-	depends on HAS_IOMEM
+config NVMEM_MESON_EFUSE
+	tristate "Amlogic Meson GX eFuse Support"
+	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
 	help
-	  If you say Y here, you will get readonly access to the
-	  One Time Programmable memory pages that are stored
-	  on the Freescale i.MX23/i.MX28 processor.
+	  This is a driver to retrieve specific values from the eFuse found on
+	  the Amlogic Meson GX SoCs.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-mxs-ocotp.
+	  will be called nvmem_meson_efuse.
+
+config NVMEM_MESON_MX_EFUSE
+	tristate "Amlogic Meson6/Meson8/Meson8b eFuse Support"
+	depends on ARCH_MESON || COMPILE_TEST
+	help
+	  This is a driver to retrieve specific values from the eFuse found on
+	  the Amlogic Meson6, Meson8 and Meson8b SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_meson_mx_efuse.
+
+config NVMEM_MICROCHIP_OTPC
+	tristate "Microchip OTPC support"
+	depends on ARCH_AT91 || COMPILE_TEST
+	help
+	  This driver enable the OTP controller available on Microchip SAMA7G5
+	  SoCs. It controlls the access to the OTP memory connected to it.
 
 config NVMEM_MTK_EFUSE
 	tristate "Mediatek SoCs EFUSE support"
@@ -107,12 +169,17 @@ config NVMEM_MTK_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called efuse-mtk.
 
-config NVMEM_MICROCHIP_OTPC
-	tristate "Microchip OTPC support"
-	depends on ARCH_AT91 || COMPILE_TEST
+config NVMEM_MXS_OCOTP
+	tristate "Freescale MXS On-Chip OTP Memory Support"
+	depends on ARCH_MXS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
-	  This driver enable the OTP controller available on Microchip SAMA7G5
-	  SoCs. It controlls the access to the OTP memory connected to it.
+	  If you say Y here, you will get readonly access to the
+	  One Time Programmable memory pages that are stored
+	  on the Freescale i.MX23/i.MX28 processor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-mxs-ocotp.
 
 config NVMEM_NINTENDO_OTP
 	tristate "Nintendo Wii and Wii U OTP Support"
@@ -137,13 +204,21 @@ config NVMEM_QCOM_QFPROM
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_qfprom.
 
-config NVMEM_SPMI_SDAM
-	tristate "SPMI SDAM Support"
-	depends on SPMI
+config NVMEM_RAVE_SP_EEPROM
+	tristate "Rave SP EEPROM Support"
+	depends on RAVE_SP_CORE
 	help
-	  This driver supports the Shared Direct Access Memory Module on
-	  Qualcomm Technologies, Inc. PMICs. It provides the clients
-	  an interface to read/write to the SDAM module's shared memory.
+	  Say y here to enable Rave SP EEPROM support.
+
+config NVMEM_RMEM
+	tristate "Reserved Memory Based Driver Support"
+	depends on HAS_IOMEM
+	help
+	  This driver maps reserved memory into an nvmem device. It might be
+	  useful to expose information left by firmware in memory.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-rmem.
 
 config NVMEM_ROCKCHIP_EFUSE
 	tristate "Rockchip eFuse Support"
@@ -167,79 +242,16 @@ config NVMEM_ROCKCHIP_OTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_rockchip_otp.
 
-config NVMEM_BCM_OCOTP
-	tristate "Broadcom On-Chip OTP Controller support"
-	depends on ARCH_BCM_IPROC || COMPILE_TEST
-	depends on HAS_IOMEM
-	default ARCH_BCM_IPROC
-	help
-	  Say y here to enable read/write access to the Broadcom OTP
-	  controller.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-bcm-ocotp.
-
-config NVMEM_STM32_ROMEM
-	tristate "STMicroelectronics STM32 factory-programmed memory support"
-	depends on ARCH_STM32 || COMPILE_TEST
-	help
-	  Say y here to enable read-only access for STMicroelectronics STM32
-	  factory-programmed memory area.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-stm32-romem.
-
-config NVMEM_SUNXI_SID
-	tristate "Allwinner SoCs SID support"
-	depends on ARCH_SUNXI
-	help
-	  This is a driver for the 'security ID' available on various Allwinner
-	  devices.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_sunxi_sid.
-
-config NVMEM_UNIPHIER_EFUSE
-	tristate "UniPhier SoCs eFuse support"
-	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This is a simple driver to dump specified values of UniPhier SoC
-	  from eFuse.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-uniphier-efuse.
-
-config NVMEM_VF610_OCOTP
-	tristate "VF610 SoC OCOTP support"
-	depends on SOC_VF610 || COMPILE_TEST
+config NVMEM_SC27XX_EFUSE
+	tristate "Spreadtrum SC27XX eFuse Support"
+	depends on MFD_SC27XX_PMIC || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This is a driver for the 'OCOTP' peripheral available on Vybrid
-	  devices like VF5xx and VF6xx.
-
-	  This driver can also be build as a module. If so, the module will
-	  be called nvmem-vf610-ocotp.
-
-config NVMEM_MESON_EFUSE
-	tristate "Amlogic Meson GX eFuse Support"
-	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
-	help
-	  This is a driver to retrieve specific values from the eFuse found on
-	  the Amlogic Meson GX SoCs.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_meson_efuse.
-
-config NVMEM_MESON_MX_EFUSE
-	tristate "Amlogic Meson6/Meson8/Meson8b eFuse Support"
-	depends on ARCH_MESON || COMPILE_TEST
-	help
-	  This is a driver to retrieve specific values from the eFuse found on
-	  the Amlogic Meson6, Meson8 and Meson8b SoCs.
+	  This is a simple driver to dump specified values of Spreadtrum
+	  SC27XX PMICs from eFuse.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_meson_mx_efuse.
+	  will be called nvmem-sc27xx-efuse.
 
 config NVMEM_SNVS_LPGPR
 	tristate "Support for Low Power General Purpose Register"
@@ -251,32 +263,13 @@ config NVMEM_SNVS_LPGPR
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-snvs-lpgpr.
 
-config NVMEM_RAVE_SP_EEPROM
-	tristate "Rave SP EEPROM Support"
-	depends on RAVE_SP_CORE
-	help
-	  Say y here to enable Rave SP EEPROM support.
-
-config NVMEM_SC27XX_EFUSE
-	tristate "Spreadtrum SC27XX eFuse Support"
-	depends on MFD_SC27XX_PMIC || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This is a simple driver to dump specified values of Spreadtrum
-	  SC27XX PMICs from eFuse.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-sc27xx-efuse.
-
-config NVMEM_ZYNQMP
-	bool "Xilinx ZYNQMP SoC nvmem firmware support"
-	depends on ARCH_ZYNQMP
+config NVMEM_SPMI_SDAM
+	tristate "SPMI SDAM Support"
+	depends on SPMI
 	help
-	  This is a driver to access hardware related data like
-	  soc revision, IDCODE... etc by using the firmware
-	  interface.
-
-	  If sure, say yes. If unsure, say no.
+	  This driver supports the Shared Direct Access Memory Module on
+	  Qualcomm Technologies, Inc. PMICs. It provides the clients
+	  an interface to read/write to the SDAM module's shared memory.
 
 config NVMEM_SPRD_EFUSE
 	tristate "Spreadtrum SoC eFuse Support"
@@ -289,36 +282,15 @@ config NVMEM_SPRD_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sprd-efuse.
 
-config NVMEM_RMEM
-	tristate "Reserved Memory Based Driver Support"
-	depends on HAS_IOMEM
-	help
-	  This driver maps reserved memory into an nvmem device. It might be
-	  useful to expose information left by firmware in memory.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-rmem.
-
-config NVMEM_BRCM_NVRAM
-	tristate "Broadcom's NVRAM support"
-	depends on ARCH_BCM_5301X || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This driver provides support for Broadcom's NVRAM that can be accessed
-	  using I/O mapping.
-
-config NVMEM_LAYERSCAPE_SFP
-	tristate "Layerscape SFP (Security Fuse Processor) support"
-	depends on ARCH_LAYERSCAPE || COMPILE_TEST
-	depends on HAS_IOMEM
-	select REGMAP_MMIO
+config NVMEM_STM32_ROMEM
+	tristate "STMicroelectronics STM32 factory-programmed memory support"
+	depends on ARCH_STM32 || COMPILE_TEST
 	help
-	  This driver provides support to read the eFuses on Freescale
-	  Layerscape SoC's. For example, the vendor provides a per part
-	  unique ID there.
+	  Say y here to enable read-only access for STMicroelectronics STM32
+	  factory-programmed memory area.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called layerscape-sfp.
+	  will be called nvmem-stm32-romem.
 
 config NVMEM_SUNPLUS_OCOTP
 	tristate "Sunplus SoC OTP support"
@@ -332,17 +304,15 @@ config NVMEM_SUNPLUS_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sunplus-ocotp.
 
-config NVMEM_APPLE_EFUSES
-	tristate "Apple eFuse support"
-	depends on ARCH_APPLE || COMPILE_TEST
-	default ARCH_APPLE
+config NVMEM_SUNXI_SID
+	tristate "Allwinner SoCs SID support"
+	depends on ARCH_SUNXI
 	help
-	  Say y here to enable support for reading eFuses on Apple SoCs
-	  such as the M1. These are e.g. used to store factory programmed
-	  calibration data required for the PCIe or the USB-C PHY.
+	  This is a driver for the 'security ID' available on various Allwinner
+	  devices.
 
-	  This driver can also be built as a module. If so, the module will
-	  be called nvmem-apple-efuses.
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_sunxi_sid.
 
 config NVMEM_U_BOOT_ENV
 	tristate "U-Boot environment variables support"
@@ -357,4 +327,36 @@ config NVMEM_U_BOOT_ENV
 
 	  If compiled as module it will be called nvmem_u-boot-env.
 
+config NVMEM_UNIPHIER_EFUSE
+	tristate "UniPhier SoCs eFuse support"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a simple driver to dump specified values of UniPhier SoC
+	  from eFuse.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-uniphier-efuse.
+
+config NVMEM_VF610_OCOTP
+	tristate "VF610 SoC OCOTP support"
+	depends on SOC_VF610 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a driver for the 'OCOTP' peripheral available on Vybrid
+	  devices like VF5xx and VF6xx.
+
+	  This driver can also be build as a module. If so, the module will
+	  be called nvmem-vf610-ocotp.
+
+config NVMEM_ZYNQMP
+	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	depends on ARCH_ZYNQMP
+	help
+	  This is a driver to access hardware related data like
+	  soc revision, IDCODE... etc by using the firmware
+	  interface.
+
+	  If sure, say yes. If unsure, say no.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 7ac988c6966e..bac799b2fa8d 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -7,67 +7,67 @@ obj-$(CONFIG_NVMEM)		+= nvmem_core.o
 nvmem_core-y			:= core.o
 
 # Devices
-obj-$(CONFIG_NVMEM_BCM_OCOTP)	+= nvmem-bcm-ocotp.o
-nvmem-bcm-ocotp-y		:= bcm-ocotp.o
-obj-$(CONFIG_NVMEM_IMX_IIM)	+= nvmem-imx-iim.o
-nvmem-imx-iim-y			:= imx-iim.o
-obj-$(CONFIG_NVMEM_IMX_OCOTP)	+= nvmem-imx-ocotp.o
-nvmem-imx-ocotp-y		:= imx-ocotp.o
+obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
+nvmem-apple-efuses-y 			:= apple-efuses.o
+obj-$(CONFIG_NVMEM_BCM_OCOTP)		+= nvmem-bcm-ocotp.o
+nvmem-bcm-ocotp-y			:= bcm-ocotp.o
+obj-$(CONFIG_NVMEM_BRCM_NVRAM)		+= nvmem_brcm_nvram.o
+nvmem_brcm_nvram-y			:= brcm_nvram.o
+obj-$(CONFIG_NVMEM_IMX_IIM)		+= nvmem-imx-iim.o
+nvmem-imx-iim-y				:= imx-iim.o
+obj-$(CONFIG_NVMEM_IMX_OCOTP)		+= nvmem-imx-ocotp.o
+nvmem-imx-ocotp-y			:= imx-ocotp.o
 obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
-nvmem-imx-ocotp-scu-y		:= imx-ocotp-scu.o
-obj-$(CONFIG_NVMEM_JZ4780_EFUSE)		+= nvmem_jz4780_efuse.o
-nvmem_jz4780_efuse-y		:= jz4780-efuse.o
+nvmem-imx-ocotp-scu-y			:= imx-ocotp-scu.o
+obj-$(CONFIG_NVMEM_JZ4780_EFUSE)	+= nvmem_jz4780_efuse.o
+nvmem_jz4780_efuse-y			:= jz4780-efuse.o
+obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
+nvmem-layerscape-sfp-y			:= layerscape-sfp.o
 obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
-nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
-obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
-nvmem_lpc18xx_otp-y		:= lpc18xx_otp.o
-obj-$(CONFIG_NVMEM_MXS_OCOTP)	+= nvmem-mxs-ocotp.o
-nvmem-mxs-ocotp-y		:= mxs-ocotp.o
-obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
-nvmem-nintendo-otp-y		:= nintendo-otp.o
+nvmem_lpc18xx_eeprom-y			:= lpc18xx_eeprom.o
+obj-$(CONFIG_NVMEM_LPC18XX_OTP)		+= nvmem_lpc18xx_otp.o
+nvmem_lpc18xx_otp-y			:= lpc18xx_otp.o
+obj-$(CONFIG_NVMEM_MESON_EFUSE)		+= nvmem_meson_efuse.o
+nvmem_meson_efuse-y			:= meson-efuse.o
+obj-$(CONFIG_NVMEM_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
+nvmem_meson_mx_efuse-y			:= meson-mx-efuse.o
+obj-$(CONFIG_NVMEM_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
+nvmem-microchip-otpc-y			:= microchip-otpc.o
 obj-$(CONFIG_NVMEM_MTK_EFUSE)		+= nvmem_mtk-efuse.o
-nvmem_mtk-efuse-y		:= mtk-efuse.o
-obj-$(CONFIG_NVMEM_QCOM_QFPROM)	+= nvmem_qfprom.o
-nvmem_qfprom-y			:= qfprom.o
-obj-$(CONFIG_NVMEM_SPMI_SDAM)	+= nvmem_qcom-spmi-sdam.o
-nvmem_qcom-spmi-sdam-y		+= qcom-spmi-sdam.o
+nvmem_mtk-efuse-y			:= mtk-efuse.o
+obj-$(CONFIG_NVMEM_MXS_OCOTP)		+= nvmem-mxs-ocotp.o
+nvmem-mxs-ocotp-y			:= mxs-ocotp.o
+obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
+nvmem-nintendo-otp-y			:= nintendo-otp.o
+obj-$(CONFIG_NVMEM_QCOM_QFPROM)		+= nvmem_qfprom.o
+nvmem_qfprom-y				:= qfprom.o
+obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
+nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
+obj-$(CONFIG_NVMEM_RMEM) 		+= nvmem-rmem.o
+nvmem-rmem-y				:= rmem.o
 obj-$(CONFIG_NVMEM_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
-nvmem_rockchip_efuse-y		:= rockchip-efuse.o
+nvmem_rockchip_efuse-y			:= rockchip-efuse.o
 obj-$(CONFIG_NVMEM_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
-nvmem-rockchip-otp-y		:= rockchip-otp.o
-obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
-nvmem_stm32_romem-y 		:= stm32-romem.o
-obj-$(CONFIG_NVMEM_STM32_ROMEM) += nvmem_stm32_romem.o
-nvmem_sunxi_sid-y		:= sunxi_sid.o
-obj-$(CONFIG_NVMEM_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
-nvmem-uniphier-efuse-y		:= uniphier-efuse.o
-obj-$(CONFIG_NVMEM_VF610_OCOTP)	+= nvmem-vf610-ocotp.o
-nvmem-vf610-ocotp-y		:= vf610-ocotp.o
-obj-$(CONFIG_NVMEM_MESON_EFUSE)	+= nvmem_meson_efuse.o
-nvmem_meson_efuse-y		:= meson-efuse.o
-obj-$(CONFIG_NVMEM_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
-nvmem_meson_mx_efuse-y		:= meson-mx-efuse.o
-obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
-nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
-obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
-nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
+nvmem-rockchip-otp-y			:= rockchip-otp.o
 obj-$(CONFIG_NVMEM_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
-nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o
-obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
-nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
-obj-$(CONFIG_NVMEM_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
-nvmem_sprd_efuse-y		:= sprd-efuse.o
-obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
-nvmem-rmem-y			:= rmem.o
-obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
-nvmem_brcm_nvram-y		:= brcm_nvram.o
-obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
-nvmem-layerscape-sfp-y		:= layerscape-sfp.o
+nvmem-sc27xx-efuse-y			:= sc27xx-efuse.o
+obj-$(CONFIG_NVMEM_SNVS_LPGPR)		+= nvmem_snvs_lpgpr.o
+nvmem_snvs_lpgpr-y			:= snvs_lpgpr.o
+obj-$(CONFIG_NVMEM_SPMI_SDAM)		+= nvmem_qcom-spmi-sdam.o
+nvmem_qcom-spmi-sdam-y			+= qcom-spmi-sdam.o
+obj-$(CONFIG_NVMEM_SPRD_EFUSE)		+= nvmem_sprd_efuse.o
+nvmem_sprd_efuse-y			:= sprd-efuse.o
+obj-$(CONFIG_NVMEM_STM32_ROMEM)		+= nvmem_stm32_romem.o
+nvmem_stm32_romem-y 			:= stm32-romem.o
 obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
-nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
-obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
-nvmem-apple-efuses-y 		:= apple-efuses.o
-obj-$(CONFIG_NVMEM_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
-nvmem-microchip-otpc-y		:= microchip-otpc.o
-obj-$(CONFIG_NVMEM_U_BOOT_ENV)	+= nvmem_u-boot-env.o
-nvmem_u-boot-env-y		:= u-boot-env.o
+nvmem_sunplus_ocotp-y			:= sunplus-ocotp.o
+obj-$(CONFIG_NVMEM_SUNXI_SID)		+= nvmem_sunxi_sid.o
+nvmem_sunxi_sid-y			:= sunxi_sid.o
+obj-$(CONFIG_NVMEM_U_BOOT_ENV)		+= nvmem_u-boot-env.o
+nvmem_u-boot-env-y			:= u-boot-env.o
+obj-$(CONFIG_NVMEM_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
+nvmem-uniphier-efuse-y			:= uniphier-efuse.o
+obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
+nvmem-vf610-ocotp-y			:= vf610-ocotp.o
+obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
+nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
-- 
2.34.1

