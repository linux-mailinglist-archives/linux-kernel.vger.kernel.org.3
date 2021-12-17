Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B981247935E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbhLQR6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbhLQR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:58:17 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3B4C06175C;
        Fri, 17 Dec 2021 09:58:13 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b22so6215122lfb.9;
        Fri, 17 Dec 2021 09:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIQlcF3gP50Ac2XyP/mWCT3TH1MR8AJE0l0k33C2rI4=;
        b=U31Jz7S+v6lmx5fTO+U88D6SrE37ODp+9q0365LAbGwqPixsRAWvweUHL1knkSgjxc
         dR9mrquyapfnZDQ8ZNd1f2W7h7y/ODKbkHmhIys72E0VX/dM1CUxUlU9QF26Rrk/UOqd
         0WLY4RHukrOaZ02RrMyfR0BrjoLiqbJFsectgqGMP0lpf5VTdIa6zWGG/U7jMQXDE6PK
         3YIKyAah8jH1PVDFwXVjtI+mWyciZ6Id16W7dqP3pkkkC5Wv3xSZ0WCWQcJPuzOXNzAy
         T8N1Q+IwsZK+1oNI0nnPfAEiboZsZT3ol230avvwaJzmPwmKJTWKxVvbHD2LtBxp7o6o
         BkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIQlcF3gP50Ac2XyP/mWCT3TH1MR8AJE0l0k33C2rI4=;
        b=GFzI/wM3q6l6ZI22o1qjAiSmt/TNnKweYaLkGvL3q1tOgdMdUarqdroNejxjerbTf6
         FMH/t/uRS3saLrcQsIDlrUqIbWF7fthnJGKDvGt7/PY6HRjQMu9S7jsmeg63lyKxFCvy
         2vr1BtpTDwz1HQ7qb9W/z3QeJIfkFiC2P4cCUgbYY5k8ItvnWAXpMkbnZxd6niVhzuMo
         CuwGo29jRzV0CRVO6mgxoN7EJqi0gDL32ky7g0+/4V5uG/DPBquOFpfT8M4zJcWaSbW2
         hID/NMvuq38r0YTOiI1x4C+ff9xjbU1bvcb9E5pVPdRWkL99nCg/pfzEmsCMBNlyH00M
         K03w==
X-Gm-Message-State: AOAM532c0Gub1KseVP9A7h9GAOqQLWjk2Vl5ljNoehhjM4VxCQL963id
        K+PHxYkt69iZcvybNsyUswk=
X-Google-Smtp-Source: ABdhPJyEg+R6x5sc59XnGJjYnjPKD7SF9ULXc8Ov81sZnNr6zNhkgoNGoFiA05i3KxASVuxbn4LMvw==
X-Received: by 2002:a05:6512:5c8:: with SMTP id o8mr2954480lfo.659.1639763891645;
        Fri, 17 Dec 2021 09:58:11 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id w23sm1479244lfa.191.2021.12.17.09.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:58:11 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 11/11] ASoC: tegra20: i2s: Filter out unsupported rates
Date:   Fri, 17 Dec 2021 20:56:06 +0300
Message-Id: <20211217175606.22645-12-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217175606.22645-1-digetx@gmail.com>
References: <20211217175606.22645-1-digetx@gmail.com>
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

Acked-by: Thierry Reding <treding@nvidia.com>
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

