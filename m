Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03C4716AB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhLKVQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhLKVPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:15:14 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A11C061D5E;
        Sat, 11 Dec 2021 13:14:51 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 13so18396730ljj.11;
        Sat, 11 Dec 2021 13:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNUlnyAFdZfXAW0dqu+wpIr279PiDcPDsUdF+Ee+XoU=;
        b=PReGWHNm/A7etwnGbCdpmm/gpUaT6f/I04HyUfrRGvqStx8AVBsQAX9tA0FSVqgkGF
         alw5JAZApyi020Bne1VOr63aQ0MhLPCcJTQgtRREQsUbeXOXRgbv2CUak8dsOnk5ZTd7
         H7aBSMxI/FWtiLbj8h04KPa8cuADDcAkZhzM7P6zJO82sXeztmUFDQLZkzacwq8VzZGn
         dQez3xVzyQHnP722XHDmNpqJg8ZUYnyIyUnlo76GnrfkG0GeNfcOXUwLMZxMkIu4gMHc
         QVQIXBkKKj8KAOsJJEglJHvpF1OOPjg+S0MzPQuUV5xEIKIDzAOJAcO0UCunDHmIlHmp
         rk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNUlnyAFdZfXAW0dqu+wpIr279PiDcPDsUdF+Ee+XoU=;
        b=sIe3QuRTv0OQxSq1ZIfK4QbxOPTowAKrKQNg9VUBevj03lke4tk4g+oXlenQlx8Gkz
         eSbqXYpkuG4p9blL8+xfG3F8vz7kAE7PT0I64cE+4HuM/S7QwiX3OKg/ehVOWFYj3aWv
         wOmBPHTNIhnqnR50rWCyZwHEvsyV8q1aZCfO4oRVOL+LF4aBbzyXY5I+Nz3T/bnG4515
         cpHIJhUKqqiHPbdA7LYfzVxmu7UrigwYLyx9VXMlTfSrgNHtsaJE7DeHdDw4dVuvqPl9
         bmjDh8WbzWU4LofQrhrlNtCsRMvM09KHLXZXnIL31eVJ9LlVYztukTlWC5vQbZN0pA8f
         1Jmw==
X-Gm-Message-State: AOAM530+31mVPOfiX8qRmqWb6UsTfZbhjaloxE6FWNdwzFyxFuopI4et
        3STxoom4BVHhDthwg/16mAM=
X-Google-Smtp-Source: ABdhPJymU2e8rQHhAnxsnkUfABET8powIsAconkhFxRN/hri4NqoQwDq5C9Ztse6GKQdU+R5D7o4zg==
X-Received: by 2002:a2e:9246:: with SMTP id v6mr20336703ljg.160.1639257289334;
        Sat, 11 Dec 2021 13:14:49 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 27/28] ARM: tegra_defconfig: Enable drivers wanted by Acer Chromebooks and ASUS tablets
Date:   Sun, 12 Dec 2021 00:14:11 +0300
Message-Id: <20211211211412.10791-28-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable charger, touchpad  and EC drivers found on Acer Tegra124 (Nyan)
Chromebooks, display bridge found on ASUS TF700T and audio codecs
found on ASUS tablets.

Suggested-by: Thomas Graichen <thomas.graichen@gmail.com> # Nyan options
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8a8f12b3e6dd..a8093b222551 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -104,6 +104,8 @@ CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
 CONFIG_BRCMFMAC=m
+CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
 CONFIG_RT2X00=y
 CONFIG_RT2800USB=m
 CONFIG_INPUT_JOYDEV=y
@@ -112,6 +114,8 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_TEGRA=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_KEYBOARD_CAP11XX=y
+CONFIG_MOUSE_ELAN_I2C=m
+CONFIG_MOUSE_ELAN_I2C_SMBUS=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
@@ -131,6 +135,7 @@ CONFIG_SERIAL_DEV_BUS=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX_GPIO=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_TEGRA=y
@@ -151,7 +156,9 @@ CONFIG_GPIO_TPS65910=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
+CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_BATTERY_SBS=y
+CONFIG_CHARGER_BQ24735=y
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_CHARGER_GPIO=y
 CONFIG_CHARGER_SMB347=y
@@ -200,7 +207,9 @@ CONFIG_DRM_TEGRA_STAGING=y
 CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
+CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
 CONFIG_DRM_LVDS_CODEC=y
+CONFIG_DRM_TOSHIBA_TC358768=y
 CONFIG_FB=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
@@ -279,6 +288,9 @@ CONFIG_STAGING_MEDIA=y
 CONFIG_TEGRA_VDE=y
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC=y
+CONFIG_CROS_EC_I2C=m
+CONFIG_CROS_EC_SPI=m
+CONFIG_I2C_CROS_EC_TUNNEL=m
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
-- 
2.33.1

