Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C7F468594
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385273AbhLDOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243923AbhLDOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:11 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1760EC061354;
        Sat,  4 Dec 2021 06:37:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b40so13728803lfv.10;
        Sat, 04 Dec 2021 06:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EtOyhR+C1wJvZU8wiedXGMGVSqNvvqifEMJLMiQgAVc=;
        b=L03nVmUkPndyUU9tH/MALMgelYXGq/p3zt1TwG85FzYAseUNRDA3Wt++ILbpd77ILA
         4h/eaUBsM7RuKPKX9HRitoYOaG972G3Tj0QD2x5GrL29nvVfiWDYaTbtjc6wPKEBt5OZ
         bs2vBX9my84twKztxReOEw9wZGY2Q0Wdl+DEtX3IrPr0S1+OuH84nzq6RCzVPfM2s9H4
         ImfwLYJ5UgbqMWS182Xz8bbwmTpCQqfQOFgEMnMm4tgMJQixPDHPkUsOgqTgLSrsumHs
         uIF/MuN0yVQ9trti88zo6x1k+eHN3ASLkkZXAlpdAbUhKhED2EZ49hlAQTbnJmuzMB5x
         b0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EtOyhR+C1wJvZU8wiedXGMGVSqNvvqifEMJLMiQgAVc=;
        b=PSuBsv5y03lb4fFQxKs5uc6pt1wRa+CSGoa8/7RGXxg11Qjgzy11ytTphey/2iHuGC
         py71g62dg/KCbAKed/f4UlutFnYDrVAbtbtqDyZognAe7E1v+Dw8k4I8aLKeK2tgQoRD
         6AiB9AHVBTUhDy9hntcHod1WhDmlqgYjQUurA4vyB4d0jpCi/hbAjewHWDLMswX+oy+M
         kPL2gcDDu6n5ect8Cx9ppANN03KkflFd0cnAP8khvgT7TEk+TumoRTLHQZ8nbKNFgeMe
         jzd4mhPEcTkGsqZ2M63whyMmGzhflss2Bw1E0PyLi70x5soMvrHIqG7abu8DLMmV/zJi
         Mqog==
X-Gm-Message-State: AOAM531DnnOj8p5ung0C4Z4UNPpxqbJ0DHw2lhQAqjd9godFQRoWc+Z/
        bRIy5PDUrcXvvvLBZI3/D38=
X-Google-Smtp-Source: ABdhPJy3QZudcRw4+yAZsC2/f4x/IcXmNDw0MftkOoWSdyIFIT0Dxo2x+Q+GsNwZwzdapu8R11Xzpw==
X-Received: by 2002:a05:6512:b8e:: with SMTP id b14mr24281414lfv.654.1638628664460;
        Sat, 04 Dec 2021 06:37:44 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 16/22] ARM: tegra_defconfig: Enable S/PDIF driver
Date:   Sat,  4 Dec 2021 17:37:19 +0300
Message-Id: <20211204143725.31646-17-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Tegra20 S/PDIF driver. It's a part of HDMI audio subsystem on
Tegra.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 736a0d25900b..f8b40cfdfb3e 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -239,6 +239,7 @@ CONFIG_SND_HDA_CODEC_HDMI=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_TEGRA=y
 CONFIG_SND_SOC_TEGRA20_I2S=y
+CONFIG_SND_SOC_TEGRA20_SPDIF=y
 CONFIG_SND_SOC_TEGRA30_I2S=y
 CONFIG_SND_SOC_TEGRA_RT5640=y
 CONFIG_SND_SOC_TEGRA_WM8753=y
-- 
2.33.1

