Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA00597DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242829AbiHRFJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbiHRFJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:09:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE6BA1D7A;
        Wed, 17 Aug 2022 22:09:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a22so504196edj.5;
        Wed, 17 Aug 2022 22:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=AtaRktMmJ7O+rOok05J5XkZ+x3nDvmU7DTZ4t9d6fcU=;
        b=EzsXlF2zbP+/5rsez3j7JzQw+dKBkv6iRiIY3baE+bnDtEatCdw+5CHvvoHto6vtfJ
         Pd6fP1bORJyKOCXLTxmNJynt52Eo4ps2bQiXHtoltDmpKoxvZZ1fdFLS0W5JziETEB66
         iJprltJBHJJb9aK58Jk4SceoJ0GHFbHKuJssoiv0sF6s3D1yowLoFyDdiAyl6RdKIBgr
         Rzl84twyfGHGHv+4GfvgVcAugvBSyl5AsCaOthvMZLX6yyGGsy5sb5vX2j1350/gs+ea
         BuxzYbSIU4mHFyD3aeofIRe+ObHx+fUs1dYwEuiqZiUO4othG2tkz7LuQFLL+IPuk2Mk
         qI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=AtaRktMmJ7O+rOok05J5XkZ+x3nDvmU7DTZ4t9d6fcU=;
        b=hyIxx5Bnc/+sfkwNzl+MT+fhY3tBwwSXNZjChs0y/TIa6POGgD3E389r72qhlHTWrS
         1MLaAN2ddHSYYCS2EtrKijVVZGI8QF4kypDNZGzOFx4JxRL4/eq0BG6fJhJa2kImzgGg
         jnuQwEdHioVCY8UWzqAlPYgd2I4RI0nxgE90cmcngN/gfaSVkUgbEA8QlIXNspCmQXP3
         Ps0358JMaUUwyXZ1WTRhi9dQhYqgpwDCfaiajEOE3P/q5vjZtfRZJhlzSdtrpBgZfnXE
         J+YG1s5uks559e5zGfzWBKTK0Gb7tYUr/JsHHIxZ2V5oIaEYKuaI4Um4NvG9FxwGvP5e
         acdg==
X-Gm-Message-State: ACgBeo1q/gX8Aa0LIfWvRdzGeqC3AZYmyWlTKSnWtLujCVFz14qxUmUu
        jU+8ZE0ABrFatziAufWxK8s=
X-Google-Smtp-Source: AA6agR68cAh7Fz4amKyoAAYSlkTg3vqofJ7Dk+922HdmaM5HfTmcEELrGEKVF5RMs6RZqg1pmX57Lw==
X-Received: by 2002:a05:6402:518b:b0:43e:70be:97cd with SMTP id q11-20020a056402518b00b0043e70be97cdmr948775edd.388.1660799387420;
        Wed, 17 Aug 2022 22:09:47 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7dc02000000b0043a7c24a669sm434898edu.91.2022.08.17.22.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 22:09:46 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] nvmem: sort config symbols alphabetically
Date:   Thu, 18 Aug 2022 07:09:00 +0200
Message-Id: <20220818050900.30062-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/nvmem/Kconfig  | 342 +++++++++++++++++++++--------------------
 drivers/nvmem/Makefile | 120 +++++++--------
 2 files changed, 232 insertions(+), 230 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index bab8a29c9861..cb4036f81a25 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -21,6 +21,90 @@ config NVMEM_SYSFS
 	 This interface is mostly used by userspace applications to
 	 read/write directly into nvmem.
 
+# Devices
+
+config JZ4780_EFUSE
+	tristate "JZ4780 EFUSE Memory Support"
+	depends on MACH_INGENIC || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	select REGMAP_MMIO
+	help
+	  Say Y here to include support for JZ4780 efuse memory found on
+	  all JZ4780 SoC based devices.
+	  To compile this driver as a module, choose M here: the module
+	  will be called nvmem_jz4780_efuse.
+
+config MESON_EFUSE
+	tristate "Amlogic Meson GX eFuse Support"
+	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
+	help
+	  This is a driver to retrieve specific values from the eFuse found on
+	  the Amlogic Meson GX SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_meson_efuse.
+
+config MESON_MX_EFUSE
+	tristate "Amlogic Meson6/Meson8/Meson8b eFuse Support"
+	depends on ARCH_MESON || COMPILE_TEST
+	help
+	  This is a driver to retrieve specific values from the eFuse found on
+	  the Amlogic Meson6, Meson8 and Meson8b SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_meson_mx_efuse.
+
+config MICROCHIP_OTPC
+	tristate "Microchip OTPC support"
+	depends on ARCH_AT91 || COMPILE_TEST
+	help
+	  This driver enable the OTP controller available on Microchip SAMA7G5
+	  SoCs. It controlls the access to the OTP memory connected to it.
+
+config MTK_EFUSE
+	tristate "Mediatek SoCs EFUSE support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a driver to access hardware related data like sensor
+	  calibration, HDMI impedance etc.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called efuse-mtk.
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
@@ -52,17 +136,18 @@ config NVMEM_IMX_OCOTP_SCU
 	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
 	  available on i.MX8 SoCs.
 
-config JZ4780_EFUSE
-	tristate "JZ4780 EFUSE Memory Support"
-	depends on MACH_INGENIC || COMPILE_TEST
+config NVMEM_LAYERSCAPE_SFP
+	tristate "Layerscape SFP (Security Fuse Processor) support"
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
 	depends on HAS_IOMEM
-	depends on OF
 	select REGMAP_MMIO
 	help
-	  Say Y here to include support for JZ4780 efuse memory found on
-	  all JZ4780 SoC based devices.
-	  To compile this driver as a module, choose M here: the module
-	  will be called nvmem_jz4780_efuse.
+	  This driver provides support to read the eFuses on Freescale
+	  Layerscape SoC's. For example, the vendor provides a per part
+	  unique ID there.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called layerscape-sfp.
 
 config NVMEM_LPC18XX_EEPROM
 	tristate "NXP LPC18XX EEPROM Memory Support"
@@ -96,24 +181,6 @@ config NVMEM_MXS_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-mxs-ocotp.
 
-config MTK_EFUSE
-	tristate "Mediatek SoCs EFUSE support"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This is a driver to access hardware related data like sensor
-	  calibration, HDMI impedance etc.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called efuse-mtk.
-
-config MICROCHIP_OTPC
-	tristate "Microchip OTPC support"
-	depends on ARCH_AT91 || COMPILE_TEST
-	help
-	  This driver enable the OTP controller available on Microchip SAMA7G5
-	  SoCs. It controlls the access to the OTP memory connected to it.
-
 config NVMEM_NINTENDO_OTP
 	tristate "Nintendo Wii and Wii U OTP Support"
 	depends on WII || COMPILE_TEST
@@ -126,16 +193,25 @@ config NVMEM_NINTENDO_OTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-nintendo-otp.
 
-config QCOM_QFPROM
-	tristate "QCOM QFPROM Support"
-	depends on ARCH_QCOM || COMPILE_TEST
+config NVMEM_RMEM
+	tristate "Reserved Memory Based Driver Support"
 	depends on HAS_IOMEM
 	help
-	  Say y here to enable QFPROM support. The QFPROM provides access
-	  functions for QFPROM data to rest of the drivers via nvmem interface.
+	  This driver maps reserved memory into an nvmem device. It might be
+	  useful to expose information left by firmware in memory.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_qfprom.
+	  will be called nvmem-rmem.
+
+config NVMEM_SNVS_LPGPR
+	tristate "Support for Low Power General Purpose Register"
+	depends on ARCH_MXC || COMPILE_TEST
+	help
+	  This is a driver for Low Power General Purpose Register (LPGPR) available on
+	  i.MX6 and i.MX7 SoCs in Secure Non-Volatile Storage (SNVS) of this chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-snvs-lpgpr.
 
 config NVMEM_SPMI_SDAM
 	tristate "SPMI SDAM Support"
@@ -145,40 +221,6 @@ config NVMEM_SPMI_SDAM
 	  Qualcomm Technologies, Inc. PMICs. It provides the clients
 	  an interface to read/write to the SDAM module's shared memory.
 
-config ROCKCHIP_EFUSE
-	tristate "Rockchip eFuse Support"
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This is a simple drive to dump specified values of Rockchip SoC
-	  from eFuse, such as cpu-leakage.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_rockchip_efuse.
-
-config ROCKCHIP_OTP
-	tristate "Rockchip OTP controller support"
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This is a simple drive to dump specified values of Rockchip SoC
-	  from otp, such as cpu-leakage.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_rockchip_otp.
-
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
 config NVMEM_STM32_ROMEM
 	tristate "STMicroelectronics STM32 factory-programmed memory support"
 	depends on ARCH_STM32 || COMPILE_TEST
@@ -189,6 +231,18 @@ config NVMEM_STM32_ROMEM
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-stm32-romem.
 
+config NVMEM_SUNPLUS_OCOTP
+	tristate "Sunplus SoC OTP support"
+	depends on SOC_SP7021 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a driver for the On-chip OTP controller (OCOTP) available
+	  on Sunplus SoCs. It provides access to 128 bytes of one-time
+	  programmable eFuse.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-sunplus-ocotp.
+
 config NVMEM_SUNXI_SID
 	tristate "Allwinner SoCs SID support"
 	depends on ARCH_SUNXI
@@ -199,16 +253,18 @@ config NVMEM_SUNXI_SID
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_sunxi_sid.
 
-config UNIPHIER_EFUSE
-	tristate "UniPhier SoCs eFuse support"
-	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on HAS_IOMEM
+config NVMEM_U_BOOT_ENV
+	tristate "U-Boot environment variables support"
+	depends on OF && MTD
+	select CRC32
 	help
-	  This is a simple driver to dump specified values of UniPhier SoC
-	  from eFuse.
+	  U-Boot stores its setup as environment variables. This driver adds
+	  support for verifying & exporting such data. It also exposes variables
+	  as NVMEM cells so they can be referenced by other drivers.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-uniphier-efuse.
+	  Currently this drivers works only with env variables on top of MTD.
+
+	  If compiled as module it will be called nvmem_u-boot-env.
 
 config NVMEM_VF610_OCOTP
 	tristate "VF610 SoC OCOTP support"
@@ -221,35 +277,26 @@ config NVMEM_VF610_OCOTP
 	  This driver can also be build as a module. If so, the module will
 	  be called nvmem-vf610-ocotp.
 
-config MESON_EFUSE
-	tristate "Amlogic Meson GX eFuse Support"
-	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
-	help
-	  This is a driver to retrieve specific values from the eFuse found on
-	  the Amlogic Meson GX SoCs.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_meson_efuse.
-
-config MESON_MX_EFUSE
-	tristate "Amlogic Meson6/Meson8/Meson8b eFuse Support"
-	depends on ARCH_MESON || COMPILE_TEST
+config NVMEM_ZYNQMP
+	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	depends on ARCH_ZYNQMP
 	help
-	  This is a driver to retrieve specific values from the eFuse found on
-	  the Amlogic Meson6, Meson8 and Meson8b SoCs.
+	  This is a driver to access hardware related data like
+	  soc revision, IDCODE... etc by using the firmware
+	  interface.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_meson_mx_efuse.
+	  If sure, say yes. If unsure, say no.
 
-config NVMEM_SNVS_LPGPR
-	tristate "Support for Low Power General Purpose Register"
-	depends on ARCH_MXC || COMPILE_TEST
+config QCOM_QFPROM
+	tristate "QCOM QFPROM Support"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
-	  This is a driver for Low Power General Purpose Register (LPGPR) available on
-	  i.MX6 and i.MX7 SoCs in Secure Non-Volatile Storage (SNVS) of this chip.
+	  Say y here to enable QFPROM support. The QFPROM provides access
+	  functions for QFPROM data to rest of the drivers via nvmem interface.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-snvs-lpgpr.
+	  will be called nvmem_qfprom.
 
 config RAVE_SP_EEPROM
 	tristate "Rave SP EEPROM Support"
@@ -257,6 +304,28 @@ config RAVE_SP_EEPROM
 	help
 	  Say y here to enable Rave SP EEPROM support.
 
+config ROCKCHIP_EFUSE
+	tristate "Rockchip eFuse Support"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a simple drive to dump specified values of Rockchip SoC
+	  from eFuse, such as cpu-leakage.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_rockchip_efuse.
+
+config ROCKCHIP_OTP
+	tristate "Rockchip OTP controller support"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a simple drive to dump specified values of Rockchip SoC
+	  from otp, such as cpu-leakage.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_rockchip_otp.
+
 config SC27XX_EFUSE
 	tristate "Spreadtrum SC27XX eFuse Support"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
@@ -268,16 +337,6 @@ config SC27XX_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sc27xx-efuse.
 
-config NVMEM_ZYNQMP
-	bool "Xilinx ZYNQMP SoC nvmem firmware support"
-	depends on ARCH_ZYNQMP
-	help
-	  This is a driver to access hardware related data like
-	  soc revision, IDCODE... etc by using the firmware
-	  interface.
-
-	  If sure, say yes. If unsure, say no.
-
 config SPRD_EFUSE
 	tristate "Spreadtrum SoC eFuse Support"
 	depends on ARCH_SPRD || COMPILE_TEST
@@ -289,72 +348,15 @@ config SPRD_EFUSE
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
-	help
-	  This driver provides support to read the eFuses on Freescale
-	  Layerscape SoC's. For example, the vendor provides a per part
-	  unique ID there.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called layerscape-sfp.
-
-config NVMEM_SUNPLUS_OCOTP
-	tristate "Sunplus SoC OTP support"
-	depends on SOC_SP7021 || COMPILE_TEST
+config UNIPHIER_EFUSE
+	tristate "UniPhier SoCs eFuse support"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This is a driver for the On-chip OTP controller (OCOTP) available
-	  on Sunplus SoCs. It provides access to 128 bytes of one-time
-	  programmable eFuse.
+	  This is a simple driver to dump specified values of UniPhier SoC
+	  from eFuse.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-sunplus-ocotp.
-
-config NVMEM_APPLE_EFUSES
-	tristate "Apple eFuse support"
-	depends on ARCH_APPLE || COMPILE_TEST
-	default ARCH_APPLE
-	help
-	  Say y here to enable support for reading eFuses on Apple SoCs
-	  such as the M1. These are e.g. used to store factory programmed
-	  calibration data required for the PCIe or the USB-C PHY.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called nvmem-apple-efuses.
-
-config NVMEM_U_BOOT_ENV
-	tristate "U-Boot environment variables support"
-	depends on OF && MTD
-	select CRC32
-	help
-	  U-Boot stores its setup as environment variables. This driver adds
-	  support for verifying & exporting such data. It also exposes variables
-	  as NVMEM cells so they can be referenced by other drivers.
-
-	  Currently this drivers works only with env variables on top of MTD.
-
-	  If compiled as module it will be called nvmem_u-boot-env.
+	  will be called nvmem-uniphier-efuse.
 
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 399f9972d45b..53a6ca1d0e01 100644
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
-obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
-nvmem-imx-ocotp-scu-y		:= imx-ocotp-scu.o
 obj-$(CONFIG_JZ4780_EFUSE)		+= nvmem_jz4780_efuse.o
-nvmem_jz4780_efuse-y		:= jz4780-efuse.o
+nvmem_jz4780_efuse-y			:= jz4780-efuse.o
+obj-$(CONFIG_MESON_EFUSE)		+= nvmem_meson_efuse.o
+nvmem_meson_efuse-y			:= meson-efuse.o
+obj-$(CONFIG_MESON_MX_EFUSE)		+= nvmem_meson_mx_efuse.o
+nvmem_meson_mx_efuse-y			:= meson-mx-efuse.o
+obj-$(CONFIG_MICROCHIP_OTPC)		+= nvmem-microchip-otpc.o
+nvmem-microchip-otpc-y			:= microchip-otpc.o
+obj-$(CONFIG_MTK_EFUSE)			+= nvmem_mtk-efuse.o
+nvmem_mtk-efuse-y			:= mtk-efuse.o
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
+obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
+nvmem-imx-ocotp-scu-y			:= imx-ocotp-scu.o
+obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
+nvmem-layerscape-sfp-y			:= layerscape-sfp.o
 obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
-nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
-obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
-nvmem_lpc18xx_otp-y		:= lpc18xx_otp.o
-obj-$(CONFIG_NVMEM_MXS_OCOTP)	+= nvmem-mxs-ocotp.o
-nvmem-mxs-ocotp-y		:= mxs-ocotp.o
+nvmem_lpc18xx_eeprom-y			:= lpc18xx_eeprom.o
+obj-$(CONFIG_NVMEM_LPC18XX_OTP)		+= nvmem_lpc18xx_otp.o
+nvmem_lpc18xx_otp-y			:= lpc18xx_otp.o
+obj-$(CONFIG_NVMEM_MXS_OCOTP)		+= nvmem-mxs-ocotp.o
+nvmem-mxs-ocotp-y			:= mxs-ocotp.o
 obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
-nvmem-nintendo-otp-y		:= nintendo-otp.o
-obj-$(CONFIG_MTK_EFUSE)		+= nvmem_mtk-efuse.o
-nvmem_mtk-efuse-y		:= mtk-efuse.o
-obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
-nvmem_qfprom-y			:= qfprom.o
-obj-$(CONFIG_NVMEM_SPMI_SDAM)	+= nvmem_qcom-spmi-sdam.o
-nvmem_qcom-spmi-sdam-y		+= qcom-spmi-sdam.o
-obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
-nvmem_rockchip_efuse-y		:= rockchip-efuse.o
-obj-$(CONFIG_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
-nvmem-rockchip-otp-y		:= rockchip-otp.o
-obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
-nvmem_stm32_romem-y 		:= stm32-romem.o
-obj-$(CONFIG_NVMEM_STM32_ROMEM) += nvmem_stm32_romem.o
-nvmem_sunxi_sid-y		:= sunxi_sid.o
-obj-$(CONFIG_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
-nvmem-uniphier-efuse-y		:= uniphier-efuse.o
-obj-$(CONFIG_NVMEM_VF610_OCOTP)	+= nvmem-vf610-ocotp.o
-nvmem-vf610-ocotp-y		:= vf610-ocotp.o
-obj-$(CONFIG_MESON_EFUSE)	+= nvmem_meson_efuse.o
-nvmem_meson_efuse-y		:= meson-efuse.o
-obj-$(CONFIG_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
-nvmem_meson_mx_efuse-y		:= meson-mx-efuse.o
-obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
-nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
-obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
-nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
-obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
-nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o
-obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
-nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
-obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
-nvmem_sprd_efuse-y		:= sprd-efuse.o
-obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
-nvmem-rmem-y			:= rmem.o
-obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
-nvmem_brcm_nvram-y		:= brcm_nvram.o
-obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
-nvmem-layerscape-sfp-y		:= layerscape-sfp.o
+nvmem-nintendo-otp-y			:= nintendo-otp.o
+obj-$(CONFIG_NVMEM_RMEM) 		+= nvmem-rmem.o
+nvmem-rmem-y				:= rmem.o
+obj-$(CONFIG_NVMEM_SNVS_LPGPR)		+= nvmem_snvs_lpgpr.o
+nvmem_snvs_lpgpr-y			:= snvs_lpgpr.o
+obj-$(CONFIG_NVMEM_SPMI_SDAM)		+= nvmem_qcom-spmi-sdam.o
+nvmem_qcom-spmi-sdam-y			+= qcom-spmi-sdam.o
+obj-$(CONFIG_NVMEM_STM32_ROMEM) 	+= nvmem_stm32_romem.o
+nvmem_stm32_romem-y 			:= stm32-romem.o
 obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
-nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
-obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
-nvmem-apple-efuses-y 		:= apple-efuses.o
-obj-$(CONFIG_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
-nvmem-microchip-otpc-y		:= microchip-otpc.o
-obj-$(CONFIG_NVMEM_U_BOOT_ENV)	+= nvmem_u-boot-env.o
-nvmem_u-boot-env-y		:= u-boot-env.o
+nvmem_sunplus_ocotp-y			:= sunplus-ocotp.o
+obj-$(CONFIG_NVMEM_SUNXI_SID)		+= nvmem_sunxi_sid.o
+nvmem_sunxi_sid-y			:= sunxi_sid.o
+obj-$(CONFIG_NVMEM_U_BOOT_ENV)		+= nvmem_u-boot-env.o
+nvmem_u-boot-env-y			:= u-boot-env.o
+obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
+nvmem-vf610-ocotp-y			:= vf610-ocotp.o
+obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
+nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
+obj-$(CONFIG_QCOM_QFPROM)		+= nvmem_qfprom.o
+nvmem_qfprom-y				:= qfprom.o
+obj-$(CONFIG_RAVE_SP_EEPROM)		+= nvmem-rave-sp-eeprom.o
+nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
+obj-$(CONFIG_ROCKCHIP_EFUSE)		+= nvmem_rockchip_efuse.o
+nvmem_rockchip_efuse-y			:= rockchip-efuse.o
+obj-$(CONFIG_ROCKCHIP_OTP)		+= nvmem-rockchip-otp.o
+nvmem-rockchip-otp-y			:= rockchip-otp.o
+obj-$(CONFIG_SC27XX_EFUSE)		+= nvmem-sc27xx-efuse.o
+nvmem-sc27xx-efuse-y			:= sc27xx-efuse.o
+obj-$(CONFIG_SPRD_EFUSE)		+= nvmem_sprd_efuse.o
+nvmem_sprd_efuse-y			:= sprd-efuse.o
+obj-$(CONFIG_UNIPHIER_EFUSE)		+= nvmem-uniphier-efuse.o
+nvmem-uniphier-efuse-y			:= uniphier-efuse.o
-- 
2.34.1

