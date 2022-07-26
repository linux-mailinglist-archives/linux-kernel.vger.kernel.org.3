Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748F1581601
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiGZPGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbiGZPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:06:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB2D2ED64
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b16so10568654lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=702UKJef+ijroSaHlhvyou4bXF2nWMpJnOXocdF4icA=;
        b=kg0tY+GccxSTnXoaRLa/eQTKkLL/PiW3qt8H7YVYxK/fygHpMIPveekV6TAHhXpjvs
         TClL8/7eooF+t1L7vCCDqqWPWFi79ey8GNFBMzFIMyMPwI22M5WJ7U7pVp2PjB9wwuvb
         0uOAm5ns4OQjq5aCLZaSFoNKhIDLQ9n5aMXwzprtK5Yu7MuzbMkhpAocIsZ7uCzoZadx
         naEDLhGsuj0HhpWyKG7BxbswjKOn2OWFQpAqOknK80cX2Py2HpqYB5bdsI5chn/yvAjK
         o7FHPGTgLxlPQ+O9MDm6v3DlpEw3C10L5eUkaf6jHJ1qw/dfTZNgm+cIzrmcTi1hvGS0
         fQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=702UKJef+ijroSaHlhvyou4bXF2nWMpJnOXocdF4icA=;
        b=mDa2aI8EMFoFyRhSwCaZZE6q/m0OrraLvvYx2hHw6na5tSJTua0pNrGkyBXFF9xQLe
         2IlhtYzuIzHIPrW9VbS9QVVYjlmTGeoAEy5jQKg2lTyELxWCMYS6QWORdXgcDpnRl3Jx
         PEQwuEj4aE92oKgdurZGRevki6VTZZBYyqHmFbK3u/+P2tbGAg2IAez8vtPDmyznvI1J
         CL433/pdL33TdyXoKbHlEuKFTU/PGvj5g+rvYmTdi+3SkhzBZ+K2WQKRPryVHxQP+rkl
         xOTOgd5fAEWEnhaypxC7sXL/0L+C9ayyYrKkBg6/q7NZxVQ6df2ZYiU+a4nWljKsBrLT
         81nA==
X-Gm-Message-State: AJIora9ZLBv0f43GktT//uOjBL82l51XhJx5/YJXVRFrS3D+WVK8qtlG
        fOQgRJ1uo1g1Gc5lSZKt4onPTg==
X-Google-Smtp-Source: AGRyM1ua0glGJ6cyqvRdljJjPEIF3jN7HAKBS1PJ0Q+S0BW4aD51QH+FNQ7NUWN4OHRFb06gbjwOgg==
X-Received: by 2002:a05:6512:10d0:b0:48a:6cee:50d0 with SMTP id k16-20020a05651210d000b0048a6cee50d0mr6430652lfg.222.1658847993710;
        Tue, 26 Jul 2022 08:06:33 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id a26-20020a194f5a000000b0048a95c16849sm836620lfk.282.2022.07.26.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:06:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 5/5] ARM: qcom_defconfig: order items with savedefconfig
Date:   Tue, 26 Jul 2022 17:06:09 +0200
Message-Id: <20220726150609.140472-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
References: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
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
index f02448187eac..1c7c864661fa 100644
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
@@ -248,13 +253,13 @@ CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_OCMEM=y
 CONFIG_QCOM_PM=y
 CONFIG_QCOM_RMTFS_MEM=y
+CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_RPMPD=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
-CONFIG_QCOM_RPMH=y
-CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_SOCINFO=y
 CONFIG_QCOM_WCNSS_CTRL=y
 CONFIG_EXTCON_QCOM_SPMI_MISC=y
@@ -273,10 +278,10 @@ CONFIG_BMP280=y
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
@@ -302,8 +307,8 @@ CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_USER_API=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
-CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_USER_API_RNG=m
+CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
@@ -313,8 +318,3 @@ CONFIG_DEBUG_INFO=y
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

