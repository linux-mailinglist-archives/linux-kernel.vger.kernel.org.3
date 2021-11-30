Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30A04641BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344885AbhK3Wsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344960AbhK3Wm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:28 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4E8C0613FC;
        Tue, 30 Nov 2021 14:39:07 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id m12so5947502ljj.6;
        Tue, 30 Nov 2021 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Np9rJa/x+DcWdS9hpvbDCt1l75oIF3jEHtZNJTv9nI4=;
        b=bcXiqoDu31oa0s7cZTUq5u+8PWKxgVlBgWiZiOUvWgSCg+t6zbaVr2NlWPJ5uB5QnX
         IaIXwiAGy6YjnwHIFI/6GXMZnUzEucgE/4UcAMFrfpEJFNBg0PYf0LwPfpb62xaZ2jfj
         gIvQThHhPIx6FqmorqBOzbKvvFct72/6vrFPLQB2B2ywqvoLpZUD4E8XMrPEt7MpUAPt
         zYdpxloTM47Y0igbnw0kwcGGEjmjZToOCFfAuU1yLYgRcOW9NKEENKipyyHv6JzgvcvA
         T9eFQCngiZ0M0ti+5rbJFeASi0Mecaye9w4/Sis9JSwZcWhTz0hRryQ47QmtYhKvtS7F
         wRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Np9rJa/x+DcWdS9hpvbDCt1l75oIF3jEHtZNJTv9nI4=;
        b=33h27040ZLhZIX4SjTHZ9YJv1CRFbVTSKgwoKBd29G0/vnYlaV0CNC6oI2bpRfMYjM
         5BRJC+OVorHpgyBmWO9CdjUFh6Mr7zdH6skzKAaa+1b62+1VqgqSYL3emdiSDUOZYm4n
         suSYUL2ZeJ6LTw8Xbc+MYFhv597RkBdigtKJLg+0Z3/CuW0AnbiVnU3ySsdI8riHPoxt
         EGOiDBpDCXQrlyfjQAa2k7vuAXljVE6VXjvwwPr/Zfq0H7NIjcObguKqI6fO5LHaQFYo
         9H/iHRjLL10xkzlzPP8YQDQJwdTohwkod3qYDAI3uLm+6Tk4e2G6d11UScXg6AyYJEJW
         5HyQ==
X-Gm-Message-State: AOAM532Dr6QD6zKe/uA/bs/x+l1ObD8o+sfy7Okedq1BC8sfACLnzEUu
        UnUYbyp8nZUJkoB6eolxrbY=
X-Google-Smtp-Source: ABdhPJwk/cbzH//Pv+3PrxD0Cl1O7T2jpdBFfVR13WL/wSsn6/ij+YwWRtd7lAYeUf10cdBGCUNSyg==
X-Received: by 2002:a2e:81da:: with SMTP id s26mr1755507ljg.63.1638311945393;
        Tue, 30 Nov 2021 14:39:05 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:39:04 -0800 (PST)
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
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 23/24] ARM: tegra_defconfig: Enable drivers wanted by Acer Chromebooks and ASUS tablets
Date:   Wed,  1 Dec 2021 01:38:19 +0300
Message-Id: <20211130223820.23609-24-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable charger and touchpad drivers found on Acer Tegra124 (Nyan)
Chromebooks, display bridge found on ASUS TF700T and audio codecs
found on ASUS tablets.

Suggested-by: Thomas Graichen <thomas.graichen@gmail.com> # Nyan options
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8a8f12b3e6dd..25bfbf11420a 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -112,6 +112,8 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_TEGRA=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_KEYBOARD_CAP11XX=y
+CONFIG_MOUSE_ELAN_I2C=m
+CONFIG_MOUSE_ELAN_I2C_SMBUS=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
@@ -131,6 +133,7 @@ CONFIG_SERIAL_DEV_BUS=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX_GPIO=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_TEGRA=y
@@ -152,6 +155,7 @@ CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_BATTERY_SBS=y
+CONFIG_CHARGER_BQ24735=y
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_CHARGER_GPIO=y
 CONFIG_CHARGER_SMB347=y
@@ -200,7 +204,9 @@ CONFIG_DRM_TEGRA_STAGING=y
 CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
+CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
 CONFIG_DRM_LVDS_CODEC=y
+CONFIG_DRM_TOSHIBA_TC358768=y
 CONFIG_FB=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
-- 
2.33.1

