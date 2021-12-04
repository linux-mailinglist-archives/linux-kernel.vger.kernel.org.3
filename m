Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A334746857C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346085AbhLDOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbhLDOlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:03 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57EFC061751;
        Sat,  4 Dec 2021 06:37:37 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id d11so11910668ljg.8;
        Sat, 04 Dec 2021 06:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAin265JOVL+o94pQxCU+sQvf2Xm5+tMWz8fFEKib7U=;
        b=o1KGgDtQWGDqmjiOgI5S/+RbDDAWjn7RwxNM6FRu5jsCI6H19PFswt6Opnx+0ODTPy
         hPRduERJtyDeRBrnfWfBGmrnXVCtAETHK85vi8EOrBil26r9K1uYi0YEDaG9Yx7axBQg
         XdmehnDB9warwOcBZ5lCnQessgtSijHJA/3I3NnRp0EOuwd1+hAqOkdWnHjNO3yeqXmO
         njnY06XzGevMbhitj2YiGsUwJwnk6d8R7aQYDcc25dvLI8cmunCmpfI1Ad+8sSHjbyLx
         LP5dGS94RECbctBvsfo86RRnIGvpGGX+7TbM91wof82ITDXGsq1vcVVEbxP5/cwGJJ4U
         JBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAin265JOVL+o94pQxCU+sQvf2Xm5+tMWz8fFEKib7U=;
        b=rd+r9vz1DvOgpuC/wN7HBUbo58rsVshViCFY9bagIfIJK3jFcxnninjXYGjYIiJTbZ
         Y7PPAE86UxKJ0sC8trje6pf07wrd3bY/96QO5sYqRoy/Izgtujxf4TQ4RWwf/+m54eaj
         5aqW8VtNbPKSw8e3J6m4Y5eNXAUlw2JyXms3CW+IBFYAQqM0HekGQ3Qj8JoYsfap2UZ+
         CUuu4gpyZBchOe8s2d4nFm29r+rnyHjVc4cWOJEeRl460EomIEKivHzadM/atTTFUtXi
         74xQi2SMx40kRbKOPfJy9JbyEy8SLIDpVR3MC273Fs8+5US8n9ZK1c2H93vOABFQUfP/
         I2mQ==
X-Gm-Message-State: AOAM533QSZFC/06ysO9E/xIrOXLujWjfPNNVqOMOq984r5U9mYUj62T3
        Is2NRXz5Fii8mc7Rr5TsKu8=
X-Google-Smtp-Source: ABdhPJzCs7dQD/cZfTQiFvEEynpqpF6ANm/y7mYxAAce2J3VdDbfVr77o//xAPFMjDRP96a9qUFy5w==
X-Received: by 2002:a05:651c:1ab:: with SMTP id c11mr24347618ljn.378.1638628656252;
        Sat, 04 Dec 2021 06:37:36 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:35 -0800 (PST)
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
Subject: [PATCH v4 06/22] ASoC: tegra20-spdif: stop setting slave_id
Date:   Sat,  4 Dec 2021 17:37:09 +0300
Message-Id: <20211204143725.31646-7-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The DMA resource is never set up anywhere, and passing this as slave_id
has not been the proper procedure in a long time.

As a preparation for removing all slave_id references from the ALSA code,
remove this one.

According to Dmitry Osipenko, this driver has never been used and
the mechanism for configuring DMA would not work as it is implemented,
so this part will get rewritten when the driver gets put into use
again in the future.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/tegra/tegra20_spdif.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 6f0570cde964..e45e371edc42 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -298,7 +298,6 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	spdif->playback_dma_data.addr = mem->start + TEGRA20_SPDIF_DATA_OUT;
 	spdif->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	spdif->playback_dma_data.maxburst = 4;
-	spdif->playback_dma_data.slave_id = dmareq->start;
 
 	pm_runtime_enable(&pdev->dev);
 
-- 
2.33.1

