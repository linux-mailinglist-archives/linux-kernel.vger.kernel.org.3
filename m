Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7941946DA1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbhLHRme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbhLHRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CEC061746;
        Wed,  8 Dec 2021 09:38:24 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z7so6985267lfi.11;
        Wed, 08 Dec 2021 09:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Np9rJa/x+DcWdS9hpvbDCt1l75oIF3jEHtZNJTv9nI4=;
        b=o/l7BqD5E6YYndsRUuP2PPRmmhXTQAdKSg8MuRsgRdo8Yly/wdTUi2axBOlrf6AD7M
         h6XnCZJsyPGlogblsEfddodhS2J5+yLNaBYNw6tlu5OrpF53tfra3/LXkQ1PiUhcoH/7
         EitVxT/ZVNrC/wIbEaV7oX0RPG2aIXN4+HVnbV2QOlcCROfRsxe1k+DDzQ+6r28z4Lje
         9QrFkqxgKol5soDWH1fT4p+WAny8w6Dz+BUrNxgoRS9OFZm8+mRwM6rhiXxLLTHqeP0/
         1tAnWkVsh5vlOptxzUEh8JydI7/qWM7uzPkahok07gEOStYNkgHTKk3n7rnJKvMbcTyX
         810w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Np9rJa/x+DcWdS9hpvbDCt1l75oIF3jEHtZNJTv9nI4=;
        b=2/QUCtSfCdCMAzGFznejWAwXG+WqqM8bZxizvPpvZrUZcGJAGoTxzGdjRCjPFlXeeW
         uEbmoSqP+wCsutnkDVaUMHE3ymkQZVpOjykTkfyF/DIbakcUvkwGaR1dGtpJQC4qJ4hB
         /PjZ2jNGJ3NkYbJXEYFQqDvqAgH3WLsMt4VGh3O9aArPla6/dOEvromeqUPx4vGJGgaC
         wj6jCtfF5NDs8FLyKvhbINCtHKKhIv6t5j58EXtaCzowNKuGOU2lkDqPI1q7a+9+tvtP
         k/QPyL4mbBtG3Jry/Fa66AwXFQtTYZA9KkdCCUU8cc/JWXUF2MYRiMZOfuUJUzyM4o1n
         e/mg==
X-Gm-Message-State: AOAM532fqpCSU2WZEyQ5EusJ6tq4SEKdNdpoCJeJ/LIDkFhfRjaC3fdK
        yAPf2e+0iEAPbx/dgAWEieg=
X-Google-Smtp-Source: ABdhPJwSNE/n3zk3jNJkp2C6VnD6MMwD/n1fAeme++K150uh5ZLlW9DCBLcSjhTcPBebAelyzhdGFQ==
X-Received: by 2002:a05:6512:2ef:: with SMTP id m15mr854207lfq.268.1638985103270;
        Wed, 08 Dec 2021 09:38:23 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:22 -0800 (PST)
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
Subject: [PATCH v5 23/24] ARM: tegra_defconfig: Enable drivers wanted by Acer Chromebooks and ASUS tablets
Date:   Wed,  8 Dec 2021 20:36:08 +0300
Message-Id: <20211208173609.4064-24-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
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

