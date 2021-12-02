Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2B466834
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhLBQbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359420AbhLBQ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:29:41 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36252C0613F4;
        Thu,  2 Dec 2021 08:25:29 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id t26so72772132lfk.9;
        Thu, 02 Dec 2021 08:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xoWmdSrL/KQfvBR8XqTf6l2aStmvtDPTr1pekFQXZzg=;
        b=b7Bbr/OzV3Q1qZAgibfv0tYYOGOKv/T5cfU04XlcwuB/6+0p/BCp+dtbprefXUcaTU
         MHsGc5Sc0XXS28WPJeH/CSjHGOG+Gj3KmP9kpbTpCa2E/ck5svPTSDWDwYPCLUywX04a
         HAWXpFT4Ji43JFex78SCQJNzEf7TH6+rh3ymnEH9wX+hoWyxkXnjI1l0IieBzry1RWZK
         jfPZpL54Jrdzf4hK9NcouwC5yhvXj6xhGUywbsMxauJKfVudEWlWhpTh43hXIm3H1iO9
         5+wQWTDuvnOVS7l4JfVg8ChgpDInmlaD8n/lBzfLXp5jM7hu++DCMQKipfvlHQHH1ph3
         3Iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xoWmdSrL/KQfvBR8XqTf6l2aStmvtDPTr1pekFQXZzg=;
        b=oNYHICW6eaOmDbSsqqfWz30kli5HxzZK3M9ExIQuS1gEVSR5KyWfimfZLzUqkvVzQv
         K1LQrRZjxxg52siUBii2CF7idHLXTQdIkj6Doqxt+CknoVNvh8q13bATWV6WtSFfJ9kt
         haj/yKSfgNCP8ECmSbJhzvTAqoGjaLyeXMXNnN4QksIkeKBjb7Qa5cAd7mPSdOY80gYK
         jEZIVzvMbaUprGsFajfiVRD/tHYn6jUlW78HkUUBg0DpJz1LsE7LuVINiheUETqyGf5p
         3UR8fvXVu3OCCTeeg6KGiA8X8yMJgDwiqIKg9FL8Jck25b4HoNLY8WIOOKm2OBUpMYNV
         yAhQ==
X-Gm-Message-State: AOAM530309ruZnLxMjzm1e+1fpt5b9ye0+cABdC425iGG8Lqd5ON2Pgr
        tiOJ4eWBd6ivPC3/taFEjDo=
X-Google-Smtp-Source: ABdhPJxUNijaUhRmMLorf/2EZiamZdXDGWpG7aPrU3DQU/9TJKVUVOUe/Fls3hmc9w3rYU99MzIGcA==
X-Received: by 2002:a19:f241:: with SMTP id d1mr12641361lfk.131.1638462327309;
        Thu, 02 Dec 2021 08:25:27 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:27 -0800 (PST)
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
Subject: [PATCH v3 12/20] ASoC: tegra20: spdif: Filter out unsupported rates
Date:   Thu,  2 Dec 2021 19:23:33 +0300
Message-Id: <20211202162341.1791-13-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDIF and other SoC components share audio PLL on Tegra, thus only one
component may set the desired base clock rate. This creates problem for
HDMI audio because it uses SPDIF and audio may not work if SPDIF's clock
doesn't exactly match standard audio rate since some receivers may reject
audio in that case. Filter out audio rates which SPDIF output can't
support, assuming that other components won't change rate at runtime.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 61 +++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index a4aa5614aef4..d09cd7ee6879 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -79,6 +79,7 @@ static int tegra20_spdif_hw_params(struct snd_pcm_substream *substream,
 	struct tegra20_spdif *spdif = dev_get_drvdata(dai->dev);
 	unsigned int mask = 0, val = 0;
 	int ret, spdifclock;
+	long rate;
 
 	mask |= TEGRA20_SPDIF_CTRL_PACK |
 		TEGRA20_SPDIF_CTRL_BIT_MODE_MASK;
@@ -133,6 +134,12 @@ static int tegra20_spdif_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	rate = clk_get_rate(spdif->clk_spdif_out);
+	if (rate != spdifclock)
+		dev_warn_once(dai->dev,
+			      "SPDIF clock rate %d doesn't match requested rate %lu\n",
+			      spdifclock, rate);
+
 	return 0;
 }
 
@@ -172,6 +179,59 @@ static int tegra20_spdif_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
+static int tegra20_spdif_filter_rates(struct snd_pcm_hw_params *params,
+				      struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *r = hw_param_interval(params, rule->var);
+	struct snd_soc_dai *dai = rule->private;
+	struct tegra20_spdif *spdif = dev_get_drvdata(dai->dev);
+	struct clk *parent = clk_get_parent(spdif->clk_spdif_out);
+	const unsigned int rates[] = { 32000, 44100, 48000 };
+	long i, parent_rate, valid_rates = 0;
+
+	parent_rate = clk_get_rate(parent);
+	if (parent_rate <= 0) {
+		dev_err(dai->dev, "Can't get parent clock rate: %ld\n",
+			parent_rate);
+		return parent_rate ?: -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(rates); i++) {
+		if (parent_rate % (rates[i] * 128) == 0)
+			valid_rates |= BIT(i);
+	}
+
+	/*
+	 * At least one rate must be valid, otherwise the parent clock isn't
+	 * audio PLL. Nothing should be filtered in this case.
+	 */
+	if (!valid_rates)
+		valid_rates = BIT(ARRAY_SIZE(rates)) - 1;
+
+	return snd_interval_list(r, ARRAY_SIZE(rates), rates, valid_rates);
+}
+
+static int tegra20_spdif_startup(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	if (!device_property_read_bool(dai->dev, "nvidia,fixed-parent-rate"))
+		return 0;
+
+	/*
+	 * SPDIF and I2S share audio PLL. HDMI takes audio packets from SPDIF
+	 * and audio may not work on some TVs if clock rate isn't precise.
+	 *
+	 * PLL rate is controlled by I2S side. Filter out audio rates that
+	 * don't match PLL rate at the start of stream to allow both SPDIF
+	 * and I2S work simultaneously, assuming that PLL rate won't be
+	 * changed later on.
+	 */
+	return snd_pcm_hw_rule_add(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   tegra20_spdif_filter_rates, dai,
+				   SNDRV_PCM_HW_PARAM_RATE, -1);
+}
+
 static int tegra20_spdif_probe(struct snd_soc_dai *dai)
 {
 	struct tegra20_spdif *spdif = dev_get_drvdata(dai->dev);
@@ -185,6 +245,7 @@ static int tegra20_spdif_probe(struct snd_soc_dai *dai)
 static const struct snd_soc_dai_ops tegra20_spdif_dai_ops = {
 	.hw_params = tegra20_spdif_hw_params,
 	.trigger = tegra20_spdif_trigger,
+	.startup = tegra20_spdif_startup,
 };
 
 static struct snd_soc_dai_driver tegra20_spdif_dai = {
-- 
2.33.1

