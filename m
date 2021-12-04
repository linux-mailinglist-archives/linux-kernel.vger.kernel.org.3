Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218BB468578
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbhLDOlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbhLDOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:02 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DDDC0613F8;
        Sat,  4 Dec 2021 06:37:36 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id k23so12005796lje.1;
        Sat, 04 Dec 2021 06:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwvCc+bauYKKq4pTyZaKz2pCnGZty8ijk6MykhM6LJk=;
        b=MwnAiF1hA8qPui8uBQGdO1QBhwpf9UaaCTkNu4NfLgfurHRoHvhXVPPodgEa3+LnvN
         tx5Ifc0/OMgQPfebiwxigxcDyBqZPGROwr20EmKTJo0G4yYB9ZVYru0NFjdrX1GA++cv
         BpRq9aWv+4fr7g9ZaayBTiTTifjEnswsXS5iHz5wLj2oBmmz4I3p9UuaoYlbcKgD9NJD
         H6ZmEu0gL1cF0UfTPmLKrMmaVxQOde8W6OAoOnFoiZD4o31osb5XXEwJt1gu8ea+1mYy
         bPMVTHQycS8tCBNMKCcqTRAA3AtU09/2jMOTPdc/wQKDEh9d5RfanRRv5svEcYfx/CnC
         L3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwvCc+bauYKKq4pTyZaKz2pCnGZty8ijk6MykhM6LJk=;
        b=64FantPwEFAumPy6IEKLsWZilIAU2kUCvsOIXm+jV2i2YoIUJh4Ih69PP+XjtC5jpn
         uW/6wZ47ODnLnALVELF6TWTY0tbyqOPNjU94aNXpKZAt2mDDw/R+sYLiy/iBG3jLm3Ze
         yhC5nMNh7PzZkcQ9uSP1F4GUcM874x3JhBp1t6R/D1f559DC8AiWXFvFIS14kEXHKzOb
         xbk9IAGgfvEYCwlWaF3pUWCLS+K6ybr8/oTvJIABSBwhbNypBNd7HP7dSIXujhkqWlJ1
         hRzQJDnWwrKn+vpPA/2xqeNYcBt/ih8Q3LN+XgQUIaBQdWPAmZboh5K1Z/TjbXguU6sV
         ClOQ==
X-Gm-Message-State: AOAM5304YpYh//+xQDAym9kLVbkEHpQx/qhQCv/dbm13g59FlKpXt0sI
        NIFnTcgHGWB/Ds0+84S/5Y8=
X-Google-Smtp-Source: ABdhPJxugszshWasYaab4cAMvs2pl1LYI0Q/HrfsQBMp21wQUS0EVtgxwr/15TP8z7dXNiyzZ03jCg==
X-Received: by 2002:a2e:8997:: with SMTP id c23mr24092207lji.530.1638628655314;
        Sat, 04 Dec 2021 06:37:35 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.34
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
Subject: [PATCH v4 05/22] ASoC: tegra20: spdif: Set FIFO trigger level
Date:   Sat,  4 Dec 2021 17:37:08 +0300
Message-Id: <20211204143725.31646-6-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FIFO trigger level must be not less than the size of DMA burst, otherwise
audio will be played x4 faster that it should be because part of the DMA
data will be dropped on FIFO input buffer overflow.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 7751575cd6d6..6f0570cde964 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -69,6 +69,14 @@ static int tegra20_spdif_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(spdif->regmap, TEGRA20_SPDIF_CTRL, mask, val);
 
+	/*
+	 * FIFO trigger level must be bigger than DMA burst or equal to it,
+	 * otherwise data is discarded on overflow.
+	 */
+	regmap_update_bits(spdif->regmap, TEGRA20_SPDIF_DATA_FIFO_CSR,
+			   TEGRA20_SPDIF_DATA_FIFO_CSR_TX_ATN_LVL_MASK,
+			   TEGRA20_SPDIF_DATA_FIFO_CSR_TX_ATN_LVL_TU4_WORD_FULL);
+
 	switch (params_rate(params)) {
 	case 32000:
 		spdifclock = 4096000;
-- 
2.33.1

