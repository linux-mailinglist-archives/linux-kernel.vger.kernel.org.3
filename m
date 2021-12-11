Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC34716AE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhLKVQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhLKVPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:15:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40989C0698C4;
        Sat, 11 Dec 2021 13:14:51 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu18so24276474lfb.0;
        Sat, 11 Dec 2021 13:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cge4cKwoH4rfWpliovNOORGBmRueDCEgmB9owthxwO0=;
        b=mtcITI6HAKA2/1OyhGxy70tTAz7jnk8ufG76N6ybdDwPF52yqmZEZ+sqfqAq8/RJWj
         xP7PVCdkQnDxlGfK59NBilH3s0KLvl4s6EZD5gKKbVctk7k7UAv8FR92Ohoh5vGib/Te
         ghTFHf35IY3nvjReIhZ0I8BkdEzjiFWbRrut3dZvmvPmboYO9MopI28TQHAy6rxHU4I3
         VLPpB5TNXJsDNcVjNpwCh/U3mrp5+BVC7eBeCJF5AEXX+XqixT/gjRt2mK4h+WJ0So8M
         RWWDFr8A4NdbprZZc3a+IMfkKKcBtOhofvof5m6PRYQ/BQttw16nBDY96PHP0LUsNdcy
         sCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cge4cKwoH4rfWpliovNOORGBmRueDCEgmB9owthxwO0=;
        b=ve9FCTQupgW5kg2Dq6EIUAGdEu/3fyvgcquzSy4bsbr8tX5nhtleFw/9kjFSxdstZ4
         GBML9SHwqYxm6LzLuW9y3UOuIu8ziLPjJBXUKL/slqVRWmMjr0RaaEIgLi4FGjIixpdC
         Wx7C/Qv0x/bohzB20z3R/pz5CIbsY6zys56aoxO2yl98RT/Dg61RFG142Az5tVLj2TUh
         upIyaCaj48fd1abCXJvG8gpL/oh/1vHS4Me+i4y8YXVb+kst9TLBH4rW+pr+yPorJ4FA
         xUrLr3pPIaf+iLM06iqnXGiG5xwOOGZr6YiOhPzyjweqCrB/cxS5l/07I5iJ5E2TLEAE
         suCg==
X-Gm-Message-State: AOAM530lrhATvviS0A//Ea9/WJ9CQffhXZB4PyiTj5RjDoCu9RDZaHAO
        9axP7JB6T8dRSZxP1MqslBA=
X-Google-Smtp-Source: ABdhPJw3J4lUPY92u2nGl6KaYE4sg+acNG2onelI91fxHfxiwjIOTMjxabRudqNQyERlR/3xZOYQ8A==
X-Received: by 2002:a05:6512:3f20:: with SMTP id y32mr20247147lfa.353.1639257290291;
        Sat, 11 Dec 2021 13:14:50 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:50 -0800 (PST)
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
Subject: [PATCH v6 28/28] ARM: config: multi v7: Enable display drivers used by Tegra devices
Date:   Sun, 12 Dec 2021 00:14:12 +0300
Message-Id: <20211211211412.10791-29-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
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

