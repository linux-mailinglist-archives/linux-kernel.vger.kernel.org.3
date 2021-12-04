Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A94C468592
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbhLDOli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242187AbhLDOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1881C061354;
        Sat,  4 Dec 2021 06:37:43 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id k37so13823688lfv.3;
        Sat, 04 Dec 2021 06:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhBo+jV3YB73Mp9ZeA7lb5QO9nWQOxbQBa92iKZ/6e0=;
        b=BwPe+OzbZ7dKOFfTTuxevloKnOCl80pz/i++V8VBwFuBWCRqpSnyv2QKvx5Z3RedN4
         B1pKoHi4+qEFCIOXzzCpbeDfrz4Y01dLQPp/LjknHjdwnLBZh6Sn865gAaR4ODf6FgFt
         t0ICnuHAfzRAlyecG9TiM1H/f2X6IAsD1aQ1R5+Ry623OYzljOvVF27dAPc8/zo+vPzp
         fph6C28FBnkygWMrcujCDEsNJ/rPIOLpVlKvzTPlMjPfOATNYKt/fYxverdaXmC9AImI
         c7Lod184D8TZOLA1/gnIBzKMX0NYh9T6g8IEFfOckK5SNQafK02r+X8MI6Is6Oa4CC72
         leVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhBo+jV3YB73Mp9ZeA7lb5QO9nWQOxbQBa92iKZ/6e0=;
        b=bsIlcrRwPO5qrgFKP67fp3gkmigHItxLl+Tqb3+drWB86URUAhHySHzkKydOPi2Hog
         PKe2HQrrW6R4ctC9GSlObssMKCER2C8bgEWRcU7mUfWn11yY6VPmJmjlB1DnI1k5vzTd
         WpwU3zu+pfucvz9NB1xKcVTF14ea9iQGSQBc+Spb9Losn/y0LsZkJgGbtN+ISovRR2V+
         Ir1HJ+O6M8LI0FE9+lBUWBTRUCKdGFY8vZJNpbXhIRUXYNXbmKAsypRyLdqmgskPOdYi
         Wb8UC06wPuvBovKBPmFFW9pQHD5wyd02FC1JvGQSogxehf27EFMI3fuoTAILxF7Qabj1
         56lQ==
X-Gm-Message-State: AOAM532O8HRNDULTPA0DIfr93ekSjsucGrmmwQUru2smygPXPYFGaJoJ
        eyhecnQL1rvyj9bkHcdiqBg=
X-Google-Smtp-Source: ABdhPJwizx5Ul3rqMpA2j4Ys8rZ5a7zgSSSMMSbgmPYAx67fXP338eoBM6QMf29auJAafvmss6WUcw==
X-Received: by 2002:a05:6512:3b11:: with SMTP id f17mr24302743lfv.374.1638628662113;
        Sat, 04 Dec 2021 06:37:42 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:41 -0800 (PST)
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
Subject: [PATCH v4 13/22] ASoC: tegra20: i2s: Filter out unsupported rates
Date:   Sat,  4 Dec 2021 17:37:16 +0300
Message-Id: <20211204143725.31646-14-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support new nvidia,fixed-parent-rate device-tree property which instructs
I2S that board wants parent clock rate to stay at a fixed rate. This allows
to play audio over S/PDIF and I2S simultaneously. The root of the problem
is that audio components on Tegra share the same audio PLL, and thus, only
a subset of rates can be supported if we want to play audio simultaneously.
Filter out audio rates that don't match parent clock rate if device-tree
has the nvidia,fixed-parent-rate property.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_i2s.c | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 266d2cab9f49..27365a877e47 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -262,10 +262,59 @@ static int tegra20_i2s_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const unsigned int tegra20_i2s_rates[] = {
+	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000
+};
+
+static int tegra20_i2s_filter_rates(struct snd_pcm_hw_params *params,
+				    struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *r = hw_param_interval(params, rule->var);
+	struct snd_soc_dai *dai = rule->private;
+	struct tegra20_i2s *i2s = dev_get_drvdata(dai->dev);
+	struct clk *parent = clk_get_parent(i2s->clk_i2s);
+	long i, parent_rate, valid_rates = 0;
+
+	parent_rate = clk_get_rate(parent);
+	if (parent_rate <= 0) {
+		dev_err(dai->dev, "Can't get parent clock rate: %ld\n",
+			parent_rate);
+		return parent_rate ?: -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tegra20_i2s_rates); i++) {
+		if (parent_rate % (tegra20_i2s_rates[i] * 128) == 0)
+			valid_rates |= BIT(i);
+	}
+
+	/*
+	 * At least one rate must be valid, otherwise the parent clock isn't
+	 * audio PLL. Nothing should be filtered in this case.
+	 */
+	if (!valid_rates)
+		valid_rates = BIT(ARRAY_SIZE(tegra20_i2s_rates)) - 1;
+
+	return snd_interval_list(r, ARRAY_SIZE(tegra20_i2s_rates),
+				 tegra20_i2s_rates, valid_rates);
+}
+
+static int tegra20_i2s_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	if (!device_property_read_bool(dai->dev, "nvidia,fixed-parent-rate"))
+		return 0;
+
+	return snd_pcm_hw_rule_add(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   tegra20_i2s_filter_rates, dai,
+				   SNDRV_PCM_HW_PARAM_RATE, -1);
+}
+
 static const struct snd_soc_dai_ops tegra20_i2s_dai_ops = {
 	.set_fmt	= tegra20_i2s_set_fmt,
 	.hw_params	= tegra20_i2s_hw_params,
 	.trigger	= tegra20_i2s_trigger,
+	.startup	= tegra20_i2s_startup,
 };
 
 static const struct snd_soc_dai_driver tegra20_i2s_dai_template = {
-- 
2.33.1

