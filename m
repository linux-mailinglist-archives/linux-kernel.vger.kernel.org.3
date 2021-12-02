Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1F94667F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359506AbhLBQ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359446AbhLBQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:28:46 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E695C061757;
        Thu,  2 Dec 2021 08:25:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id i63so764749lji.3;
        Thu, 02 Dec 2021 08:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAin265JOVL+o94pQxCU+sQvf2Xm5+tMWz8fFEKib7U=;
        b=pLQ4GJmoBOJuH7wLOkufv40oGn+6v3Gytz8bM59miPiudq6sFxymrpgus4KfVo/Rgx
         2um5/3RpKDCATnI9f9SoujwYqxlxpSSh1bYp7EU7phmb3XldHo/1H5lKDnlSaWqtGNQn
         WuiFjTv79YtRFAcAtKQtgmHpoxO+GA5jrjgtPdQtSH3kar4oAzrCjWE0BjIZ1aO3iKyu
         jevLCOpllTOA+bHXXOcUfrwtcziyuvKzGU1hRi2XoVpddsMTIJe7JlVC+3lU5lA0g98G
         4bTrwrRxbAsfMZet31PKmGihDNbFS02bDeAlNTDN6sn4XAqCwlNGoorksOYpqZBjS2tc
         u01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAin265JOVL+o94pQxCU+sQvf2Xm5+tMWz8fFEKib7U=;
        b=md58GABZuG+uvv1zRl96YLcAjUzksP5SpHjySnKEUcJplzytvodD/dSIdTDDy6SwW7
         wVyNwRiu3jQlyYbSM2/eImsGQkmD98LNtKk1ytvV3LFFL/ND9RRS3p20x3dVq9MFQSIO
         m6TItMAguKVx2c85sMro6fkB9yrLcdub0nJiZs76z4lmvy9lw2lxiHbyJRoax9NVNxGI
         JtRY7U1kNM66JBRlZWsAv7nei6OOH6d/jOe34oGR/pEbDUctcB2Z+K4OkEEb2P8AsiMU
         YFxZYEzPnJlFekWjR4FRtuUSNAIjvZyH20VUuLdz4HvQUD8QUDofABo5+8Z0wc6YSeXC
         Z9mA==
X-Gm-Message-State: AOAM530Kzdl0sPBgxaLxAyd9Ap+dl8RuRtMPEvUktnhxHt6657sIlQbl
        njarvcSp8h9L8dhUB/SXsppYqrSWGHA=
X-Google-Smtp-Source: ABdhPJxgWCKXWtE9NQnfcQEL8rdvlyRa84HGrFT6R25Bd2ruhzIx24D62gwZG3WFq54S3UptLypkqQ==
X-Received: by 2002:a2e:a378:: with SMTP id i24mr13292701ljn.290.1638462321626;
        Thu, 02 Dec 2021 08:25:21 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:21 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 06/20] ASoC: tegra20-spdif: stop setting slave_id
Date:   Thu,  2 Dec 2021 19:23:27 +0300
Message-Id: <20211202162341.1791-7-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
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

