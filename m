Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C202D46DA1F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbhLHRmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhLHRl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:58 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA27FC061D5E;
        Wed,  8 Dec 2021 09:38:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id z7so6985343lfi.11;
        Wed, 08 Dec 2021 09:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cge4cKwoH4rfWpliovNOORGBmRueDCEgmB9owthxwO0=;
        b=ErzBxi85BIP+AYHPr4fn6B94VWyhu5N1zR3eB1dEycpUAM5T1+hvBdnUO/zyRTEhPP
         jQ16wXqmbF/7/ocINmwcWkle4TdY0RzhXD5K/6DSmw9RZ5tAvlmPZhX+joG3ZrzDQ+/7
         E1sCqcOeLFikxqOPsNcDpK0mdNjyc7484mtOFxkRm1tgdCz0SJRKAwbA3lWTkkDkserp
         ekWrtNINNWh8DLFOpNt5e54inFgA1ZI7vYEChYis8Yg/km/Qr62fCtLDtETI89xY8utu
         e05f9T107YlWQgmVM8FpGE2QJyONV/z/6b93x1cvDwNGh+J6av/1gallQuD+Mal4WQCQ
         MI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cge4cKwoH4rfWpliovNOORGBmRueDCEgmB9owthxwO0=;
        b=fdqWE/cLYxQ4Z0U/puMw2D/TsgYoUbvWIDpd6JMMmpaujTrl88nGaseOGQW4VHASqE
         bdB5xzki635RiAXNZauiY/E9zJDj26dGlFocG+zfgthC5h9o9NQG9HF5D5C37ajJWlje
         RM61zWIPyoAteNz1aqp43J5R1JmpNytaFmkD4vP420uAkDdiEXhH1kaIXuQvgIMfjupF
         NhEKHnhBMNwaVVZSSh1I1Z2E/4QK4NdduRPbXb0Dc86s9cPwQA4ZXzpnD9V0t3IKQwBq
         JF6f24ytwsrdluzfcfb5VxLn2lmOv/1vhhJ4vzZJhu/rV466TRyCl99DCyGclAHU6Qax
         lBNA==
X-Gm-Message-State: AOAM533nkq48Uvxnx6un5bXTpzwCKoxZCI7HcK/iVdJIBGtXUq67EJyq
        m05VmViJA5XZdRn9eiNhweY=
X-Google-Smtp-Source: ABdhPJylFtOrVdTv9tqMVILENWexUCyHOfn3aGit1OE5SgsKIolT3BXE7n57CDqobuz1lt18pnvgVg==
X-Received: by 2002:a19:6454:: with SMTP id b20mr791542lfj.469.1638985104227;
        Wed, 08 Dec 2021 09:38:24 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:23 -0800 (PST)
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
Subject: [PATCH v5 24/24] ARM: config: multi v7: Enable display drivers used by Tegra devices
Date:   Wed,  8 Dec 2021 20:36:09 +0300
Message-Id: <20211208173609.4064-25-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable display-related drivers used by various Tegra-based tablets.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c951aeed2138..3d509bc13444 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -382,6 +382,7 @@ CONFIG_TCG_TPM=m
 CONFIG_TCG_TIS_I2C_INFINEON=m
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=m
+CONFIG_I2C_MUX_GPIO=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_DEMUX_PINCTRL=y
@@ -680,19 +681,23 @@ CONFIG_DRM_FSL_DCU=m
 CONFIG_DRM_TEGRA=y
 CONFIG_DRM_STM=m
 CONFIG_DRM_STM_DSI=m
+CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
+CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
 CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
 CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
+CONFIG_DRM_LVDS_CODEC=m
 CONFIG_DRM_NXP_PTN3460=m
 CONFIG_DRM_PARADE_PS8622=m
 CONFIG_DRM_SII902X=m
 CONFIG_DRM_SII9234=m
 CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_TOSHIBA_TC358764=m
+CONFIG_DRM_TOSHIBA_TC358768=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_STI=m
-- 
2.33.1

