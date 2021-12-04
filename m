Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D17E4685A5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbhLDOnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244389AbhLDOlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:12 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB03DC061751;
        Sat,  4 Dec 2021 06:37:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u3so13843850lfl.2;
        Sat, 04 Dec 2021 06:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOjZjTQZlhp+jMD4XSw/sLUK6fzJWwcAyuJDWpowbN8=;
        b=BT6hF6T3DsytuOd6SZTcNzXERs13rmeoOu3/mz+D2wWE2AEXMz5AePtAKjON5adhiv
         4Eg+x6YMh0CmlZn29bmGzIUhZXTblIjx+gJIW5X+MLpbWUwJQq3t5PUFtUHEYOqpoXUj
         N/s3bjtzOgj4kf14X1ujZUvJ4TRdA5W+5DWqyx6jGpSj9XZgngr7RYky1XfCqbZpkcIb
         6BQPPAfxfQAUlhDUa9m3O5LiPcRAToD8BYhHqf28PXgIp50KAXh7V9unj8WtUV9aVTXA
         AUhfIcMScoN74mYSp/mdxpnhY6ggEUe2k6I2K7X8MbexqLi+kCyO/lJtkJWGRoSzZ7Qm
         qL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOjZjTQZlhp+jMD4XSw/sLUK6fzJWwcAyuJDWpowbN8=;
        b=5+6xSiPJINyjr8n0jPWf4BeYg9MgIsUbsAKsAZ8cDv2vBrVKMrvJcukk5nXbn/y90o
         Bab5K7FP0eIEZ0V+BAvvci/iivOx85+4nGi+kAOEj0fI+0CYoNeXQpriRoAM3jO3ShTy
         PNyWegddAhgR6Ff0ZM7lz9b6yNThYB12BWZ+XHd8vtt2oZsCorw6IXQfyBC+/HORVehr
         +7zpJ0bg1faCHdgvUr0OsP9AI4+jkE77TDG8wQnWLvVKhU7YhpVs/pgwyLgCEXv8doim
         qahsjOz5dwLrn2bpfY/8W0s/VKaYN8BR1cmCHnTkOtWhATYmW0/IBWaK3FPIDUHY6svc
         BN3w==
X-Gm-Message-State: AOAM532oLJExqkcN9wIMibsz1bIHhrf5Pdnf5Oqm5kspx7vxdrfc5Eve
        FhMfUxiBO9YWFJqEzXyflYM=
X-Google-Smtp-Source: ABdhPJxhAPoQB2zlY6ocg6tiCwvhZiauqouZ0jiz1JFXhJD0zm6ESqo3oOCFAyGe4uYC5aPabMjVTA==
X-Received: by 2002:a05:6512:114e:: with SMTP id m14mr23806948lfg.418.1638628665202;
        Sat, 04 Dec 2021 06:37:45 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.44
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
Subject: [PATCH v4 17/22] ARM: config: multi v7: Enable NVIDIA Tegra20 S/PDIF driver
Date:   Sat,  4 Dec 2021 17:37:20 +0300
Message-Id: <20211204143725.31646-18-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Tegra20 S/PDIF driver that is a part of HDMI audio subsystem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3d509bc13444..172838566ecd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -762,6 +762,7 @@ CONFIG_SND_SOC_STM32_DFSDM=m
 CONFIG_SND_SUN4I_CODEC=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA20_I2S=m
+CONFIG_SND_SOC_TEGRA20_SPDIF=m
 CONFIG_SND_SOC_TEGRA30_I2S=m
 CONFIG_SND_SOC_TEGRA_RT5640=m
 CONFIG_SND_SOC_TEGRA_WM8753=m
-- 
2.33.1

