Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A28479352
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbhLQR6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbhLQR6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:58:09 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C4C061401;
        Fri, 17 Dec 2021 09:58:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id br40so3830063lfb.1;
        Fri, 17 Dec 2021 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aXAi7CWSEqrGpygWLYaMuBzle5xA6rjl70U8+IK/iig=;
        b=gAf4vyWyDfBTmYvS814WS61PNOSjB6i0X1eYRP0Rt8E5afKVZXPICIFg+8N4+3NFrW
         d32TxT8TIG0FrREeY+jkAPX85b9rF08H1rcxj/bxPs+y4J3hCWVrCT6Ph9+K9nft4UJ6
         YAwnamhOU5dP5HNR0K+ICe9oMHcRVrgHpCSQrPG7N4fUYV5jF8ZKreXCRExWKb67zs9p
         bl7v0Xlu6mSkaSDzl4TgqRQ9uZC4OP+XvfWq/GsQ9W5FU54DZbImeqcLUR3jEKKti1HH
         jQVpeEiNdK7x+lD+vR96JJZ0OekFRP2k0g33yiim+vq2ZMS1QVZ/EnXkMAOddv7NE9Xx
         k01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXAi7CWSEqrGpygWLYaMuBzle5xA6rjl70U8+IK/iig=;
        b=1bzzGNuCKB/nRngeU7Q6KKfFuqH/XPejT2widwKlOVBTEKIkctNKuehRERgw43Jsx8
         7eRU/YyLQF03obse8U4Nvc3uKcyHZ/bVd7N0jN8AHZpUPzmXeQHpC0faxlcZMl3qWtTm
         quIfQpokP2dzsh/Zv7uySSBHRFLwul1H/kvX7idS9oJGY3AbNomusmQwH6jZYrwjvW+u
         KQgydq0t+0QB+xgCxAeNsxkw6OBxU36U8jEAWUU7IPrZ3TDdmH5WwtTJxx0eXsuNY9mS
         l0IolzTkX70vSnejeM1WJuI9n4uz014ur3/v+D4nJ0UDFBrWta6+cqe97MvL3XAXBgrc
         UIIA==
X-Gm-Message-State: AOAM530yh3se2fvv5ELXONupPE9swILxIEukYEEg+YlzanQy+QV9ZfEO
        fS2l2JphEgKq4p2JrQCEz0Q=
X-Google-Smtp-Source: ABdhPJx35Ue2iDa1rMg6didg0FwagKJ9F9E5Stnc4n+YyJyNpV5/4ppZhzZlsSFN2XSSAWQK8ElASA==
X-Received: by 2002:a05:6512:31d:: with SMTP id t29mr3745033lfp.331.1639763886836;
        Fri, 17 Dec 2021 09:58:06 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id w23sm1479244lfa.191.2021.12.17.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:58:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 04/11] ASoC: tegra20: spdif: Set FIFO trigger level
Date:   Fri, 17 Dec 2021 20:55:59 +0300
Message-Id: <20211217175606.22645-5-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217175606.22645-1-digetx@gmail.com>
References: <20211217175606.22645-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FIFO trigger level must be bigger than or equal to the size of DMA burst,
otherwise audio will be played x4 faster than it should be because part of
the DMA data will be dropped on FIFO input buffer overflow.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 57a6c576b91f..e45e371edc42 100644
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

