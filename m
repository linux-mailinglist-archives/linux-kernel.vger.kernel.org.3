Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E0057D062
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiGUPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiGUPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:54:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF55B7A2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:54:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u19so3526628lfs.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nK7eo+MXLEskh+lx+HdeV3BNsWkHAjEJ1QV6YL7b3Vg=;
        b=fHrYK22jld+8BVs7wpr5LoEjkZ2Exw+qZREIcREQjq293WjKkTzlJjLz0IBWdCDaBt
         L2EAAUEOK9GC6Vuztfh4znR2DDHC5f+5vK+ISsfRlDk8y5bEHFXjpcNJPvFQyGgN2API
         Encv/aBW3k12OXTRV5S1Kx9GJfcPMy0c1ATRd29EU1bz8QqPccpJzbI0FlVDs4GmQ31Y
         WxbyEr5Wtd5lPXd+qjTG/bXO3n/EhzSiDBkZwe6bi1lv2GbLqOpefCkahjNHccmtpgRC
         LKoRmsXHPjEhyrDZpGHlQOaXN6pCYtGu5XH/46I9Tea+SMmBngrV5kssmpAYiNCLgd9R
         yXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nK7eo+MXLEskh+lx+HdeV3BNsWkHAjEJ1QV6YL7b3Vg=;
        b=TtaCSq4ZfN2YakVSK7CRJ+9DJgzSmWTq//DfffHS9d123ZaAePUdbeZ6HJCdGHni9V
         6pskuy3ektY4DLjjb+AEeraDfru9Pzkvaifl/YwR3tIGzqYAHqNZUEjkmkHxSqMELXwF
         NpypdKmyS/ahltv4SFA7foI4M79Bwv+LC7KESn+9b4iGZsBdfLUAR2etYA0xAkl7ra0H
         VqHMvWfCpPLqZvC5rZIDe320rwZsjti2V4VesDI/2Dfx/DB1wynXU88kK2vMqs4bO3yJ
         UXSScVVX6ScKfuLmWZmKKcrFMTksUHGcIUee2KLc2R8/zSMCYpm1Bk4FnvaSh9+AZhjk
         lU4g==
X-Gm-Message-State: AJIora/sxp+9+82/19LT7z73Zy5n1lhSHO9LpD4fioQVzjDrtSYz+JM+
        0UbPSQ/qebcjkl9kK3FhP4Jlpw==
X-Google-Smtp-Source: AGRyM1vMev9j6faej3WCa4orLk7XctYrsywHBtFcqDdAc8hCf4X8gE1tifOcXbdKlPk5OONVCd4jBQ==
X-Received: by 2002:a05:6512:3e01:b0:489:c6e7:71b9 with SMTP id i1-20020a0565123e0100b00489c6e771b9mr22051976lfv.605.1658418843377;
        Thu, 21 Jul 2022 08:54:03 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id s14-20020a056512214e00b0048110fd06c4sm516432lfr.53.2022.07.21.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:54:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] ARM: qcom_defconfig: order items with savedefconfig
Date:   Thu, 21 Jul 2022 17:53:56 +0200
Message-Id: <20220721155356.248319-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220721155356.248319-1-krzysztof.kozlowski@linaro.org>
References: <20220721155356.248319-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_75_100 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run savedefconfig and order the entries, without removing or adding
anything.  This reduces conflicts, as new entries should not be added to
the end, and makes it easier to spot differences against actual config.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 56 ++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 563a396bfb23..b6579b553447 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -1,6 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
@@ -10,29 +11,28 @@ CONFIG_EMBEDDED=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_MSM8X60=y
 CONFIG_ARCH_MSM8960=y
 CONFIG_ARCH_MSM8974=y
 CONFIG_ARCH_MDM9615=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCIE_QCOM=y
 CONFIG_SMP=y
-CONFIG_PREEMPT=y
+CONFIG_ARM_PSCI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_CMA=y
 CONFIG_NET=y
@@ -56,15 +56,18 @@ CONFIG_BT_HCIUART_BCM=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_RFKILL=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_QCOM=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
+CONFIG_MTD_QCOMSMEM_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_MTD_QCOMSMEM_PARTS=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -133,10 +136,10 @@ CONFIG_PINCTRL_MSM8660=y
 CONFIG_PINCTRL_MSM8960=y
 CONFIG_PINCTRL_MDM9615=y
 CONFIG_PINCTRL_MSM8X74=y
-CONFIG_PINCTRL_SDX55=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
 CONFIG_GPIOLIB=y
+CONFIG_PINCTRL_SDX55=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_MSM=y
@@ -144,15 +147,17 @@ CONFIG_CHARGER_QCOM_SMBB=y
 CONFIG_CHARGER_BQ24190=m
 CONFIG_THERMAL=y
 CONFIG_QCOM_TSENS=y
+CONFIG_WATCHDOG=y
+CONFIG_QCOM_WDT=y
 CONFIG_MFD_PM8XXX=y
 CONFIG_MFD_QCOM_RPM=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_RPM=y
+CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
-CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_DRM=y
 CONFIG_DRM_MSM=m
@@ -160,11 +165,11 @@ CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_ANALOGIX_ANX78XX=m
 CONFIG_FB=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_LM3630A=y
 CONFIG_BACKLIGHT_LP855X=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_DYNAMIC_MINORS=y
@@ -180,6 +185,7 @@ CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MSM=y
 CONFIG_USB_ACM=y
+CONFIG_USB_DWC3=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
@@ -196,7 +202,6 @@ CONFIG_USB_CONFIGFS_ECM=y
 CONFIG_USB_CONFIGFS_F_FS=y
 CONFIG_USB_ULPI_BUS=y
 CONFIG_USB_ETH=m
-CONFIG_USB_DWC3=y
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
@@ -218,8 +223,8 @@ CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A7PLL=y
 CONFIG_QCOM_CLK_APCS_SDX55=y
 CONFIG_QCOM_CLK_RPM=y
-CONFIG_QCOM_CLK_RPMH=y
 CONFIG_QCOM_CLK_SMD_RPM=y
+CONFIG_QCOM_CLK_RPMH=y
 CONFIG_APQ_MMCC_8084=y
 CONFIG_IPQ_GCC_4019=y
 CONFIG_IPQ_LCC_806X=y
@@ -229,12 +234,12 @@ CONFIG_MDM_LCC_9615=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_SDX_GCC_55=y
-CONFIG_MSM_IOMMU=y
-CONFIG_ARM_SMMU=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_MAILBOX=y
 CONFIG_QCOM_APCS_IPC=y
+CONFIG_MSM_IOMMU=y
+CONFIG_ARM_SMMU=y
 CONFIG_REMOTEPROC=y
 CONFIG_QCOM_ADSP_PIL=y
 CONFIG_QCOM_Q6V5_PAS=y
@@ -247,12 +252,12 @@ CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_OCMEM=y
 CONFIG_QCOM_PM=y
+CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
-CONFIG_QCOM_RPMH=y
-CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_SOCINFO=y
 CONFIG_QCOM_WCNSS_CTRL=y
 CONFIG_EXTCON_QCOM_SPMI_MISC=y
@@ -271,10 +276,10 @@ CONFIG_BMP280=y
 CONFIG_PWM=y
 CONFIG_PHY_QCOM_APQ8064_SATA=y
 CONFIG_PHY_QCOM_IPQ806X_SATA=y
-CONFIG_PHY_QCOM_USB_HS=y
-CONFIG_PHY_QCOM_USB_HSIC=y
 CONFIG_PHY_QCOM_QMP=y
+CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
+CONFIG_PHY_QCOM_USB_HSIC=y
 CONFIG_QCOM_QFPROM=y
 CONFIG_INTERCONNECT=y
 CONFIG_INTERCONNECT_QCOM=y
@@ -300,8 +305,8 @@ CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_USER_API=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
-CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_USER_API_RNG=m
+CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
@@ -311,8 +316,3 @@ CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
-CONFIG_WATCHDOG=y
-CONFIG_QCOM_WDT=y
-CONFIG_ARM_PSCI=y
-CONFIG_CPU_FREQ=y
-CONFIG_CPUFREQ_DT=y
-- 
2.34.1

