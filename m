Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF34641C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhK3Wsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344963AbhK3Wm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:28 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12040C061785;
        Tue, 30 Nov 2021 14:39:08 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id p8so30609604ljo.5;
        Tue, 30 Nov 2021 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cge4cKwoH4rfWpliovNOORGBmRueDCEgmB9owthxwO0=;
        b=BmTB6JHcnljzEuu2yCHA0JfQvz1OwiX/mK42GIIonarzPnKrQx7mYAKdn+EJjFTwqY
         vR6ki0iIhW1eT8TozO2ryHFuTBlr3jCdF2vaMeEuXR4jNzWZGwJHPM0JRbRe0mT871RK
         qBkTFB6+TicY6O02lFubsGk7qAp4yImZoYHew9zepe7IG1zDFYDuZA9R2HXyChbpWDbG
         hNjP2iWoD60g3I51DbsgCa/6asmzk7l0mdLnjcUNq17kamxdpfedU5rgVIneBLhjoeT/
         3szskEo2vzn5KlhMFn3fzlvqbNWJhBPC/Zsd+gI1EQiw0X5FL1qdHBJYMzEdnGt9CS6n
         XsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cge4cKwoH4rfWpliovNOORGBmRueDCEgmB9owthxwO0=;
        b=q/STkPPOP6cAfdoKDqVys0t8rrFqCluhcy3AmopeDDrmu/rqya8cyjWYFURM4Ch+4K
         AbaVeShx8DmlxRDbdepTUYNu/qta7KOOsM1qQlm933Oq5P2QuJt+LVbX+ZsP7sY4y0YE
         gNviFo7YC5g9l7H5EeiRkwMxhpaNUEQx2t0XMW1xpoa1uFRO7Tg+ynKjfTMRWOGOYvIY
         7rI0y8hTZ6CK7CtMkOYSYJQpMJFHCFhhJhECW1U7HDzKece0WLaiYgE4i4xNqIttQ1qu
         rUsnaRyT9rbIgo3mjI3Qg1nyQLlA41NNObFbcV9UZI8Wu/Fmf+sScbxqQiGSXd8rSVKy
         djJg==
X-Gm-Message-State: AOAM531gD8j8zVJ/Oij5hwwmWYHvvrHJxIA/Bbz0d/xvUSuHOME6mVAq
        BreSmXK7HTbBANbBVNIwzfc=
X-Google-Smtp-Source: ABdhPJyF8x53IQlV6ScOs2wfbhudz+AVWcu2/YzXrOvCwvTz6LtTDp3HqI7P4iKFHxvQ4tRXpQj2oA==
X-Received: by 2002:a2e:760d:: with SMTP id r13mr1646387ljc.159.1638311946417;
        Tue, 30 Nov 2021 14:39:06 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:39:06 -0800 (PST)
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
Subject: [PATCH v4 24/24] ARM: config: multi v7: Enable display drivers used by Tegra devices
Date:   Wed,  1 Dec 2021 01:38:20 +0300
Message-Id: <20211130223820.23609-25-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
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

