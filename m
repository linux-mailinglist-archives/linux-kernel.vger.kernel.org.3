Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F216F46682D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347960AbhLBQaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359678AbhLBQ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:29:41 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB22C0613F9;
        Thu,  2 Dec 2021 08:25:29 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id v15so858808ljc.0;
        Thu, 02 Dec 2021 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhBo+jV3YB73Mp9ZeA7lb5QO9nWQOxbQBa92iKZ/6e0=;
        b=G7c0XoHf5gU245Jw5MvatV3xgDA1KCQlndpP8LEJPF8WBT4Q7jEdeoD8CpozdUTXSl
         MhMVFXvLZpk/mPFRvAzIKJiqH6FvB/pam6FEwvaWr8mSWkqUdJBCuHOGRmByDGBz7myB
         jDODImY2wDlyS2Dcw/DfUPT90X0wKLTwxaE3nWSZAaY3wN+GNZxzbV9l1W/DC/BGhkBU
         3m4HigtLbESXEXK9hinq0+juRCGfdLVdcc/XMe4e71gaorfABU72Q1joNCFh7SCnv9gL
         ZhAPqGygOi4eRWysJZ+wJpXI29lXdhgczrO1OtyGFRyHvP2gloh3hMVxac64bek4a9SA
         1Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhBo+jV3YB73Mp9ZeA7lb5QO9nWQOxbQBa92iKZ/6e0=;
        b=bA5thlCz3mSY8E0qo7q4TeDyfLWyAVnewQrK0IHvM7aM698ty+kpMSMxresXxGzXmq
         Eo4ryJH/gOUvkxtSwNg1eO/Ruo2IHXtkQDqd5P7UT1eZY7Ca82dymq/EsFNulFpS09IP
         ejRyxvK5orG0lbXgsh9/HJQ3Mbu7iTob446Qa45/dT7flK9mtwGoPKgZer9yGCyFJAKH
         my50j4NGianhOuuciSCytURpTlF1hJoHbGPwu45WyDn72T6peuhHwlSi5NaPESSgGNEH
         MPWYRHmr/bSNsbimnLktgG0s5l9dFWdR6spDa7NKo0HMYS5U7ptcUv9vupf9Tbb6OJMF
         AJ2A==
X-Gm-Message-State: AOAM533uVKV+u7L8ttcA9qxzwU5F5H5g1rV8Oi8iU+v7U9m3YXV+7+9V
        Zv0TqwDcwF9j2OXaZ1AsG2o=
X-Google-Smtp-Source: ABdhPJym7SDKvOvwZ3mF7bphO7cMvut+5WIv5IPHwj8yQJRV7hmnsRueeasXCZ/vjgqliZwQSkNnEg==
X-Received: by 2002:a05:651c:1503:: with SMTP id e3mr12869054ljf.182.1638462328149;
        Thu, 02 Dec 2021 08:25:28 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.27
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
Subject: [PATCH v3 13/20] ASoC: tegra20: i2s: Filter out unsupported rates
Date:   Thu,  2 Dec 2021 19:23:34 +0300
Message-Id: <20211202162341.1791-14-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
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

