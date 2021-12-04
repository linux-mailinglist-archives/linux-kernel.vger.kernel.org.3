Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E5468588
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355176AbhLDOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241120AbhLDOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:07 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A2BC061751;
        Sat,  4 Dec 2021 06:37:41 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id k37so13823441lfv.3;
        Sat, 04 Dec 2021 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSjFB49gbB2f+fQJJWWmO/v+TRpxSfz0h1BJe46+OzM=;
        b=cEgwEMj9W1a/YeZ7WxGAAy8mxPRHPC8JYO027a7EZBGPZqwxGwkdfcva5EYSvcNt0z
         zQDWua8Blc8mooTD2CKDnpHrA1assl4Ne037m3vCtRtNlChUy/E/2vvpZDpRov5yaD2H
         5uGAwiFxg0LIlxcX7tnbF+kLJj2aCDHpEmcafrXNXYjAHDQX0yCedDTlGUwQYlzWYIg5
         /Mk+e8GDWAkjxJoRKzRagFKOWrzsKAsYlBCDJ/xLvQVDIbNfLyDuDR4/Yc/TRlafyOwE
         6XZy0HEdn7JiA4OURdY9UCZmBsfsYFPy/E+E7aIuGucmWIYTOO/xva5+oZX53K2Dt5Xp
         1MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSjFB49gbB2f+fQJJWWmO/v+TRpxSfz0h1BJe46+OzM=;
        b=2p8ejPk4vBPtsvjoPDBt+pzxzAX0EOUjFErallIa3JG241LlPL7rUKG7Vh8vjGtVr/
         tfLU0KnrrSsq5thnxa8jF8aMsRgZvBP5pZXa9RpJ/vTbHKc966lo4yK3ZcwCrvYzytV9
         +UlK8B9lR/yZO7gM6Wg3LSiQR0G1hrXVgBfrn+s0iRDkfQMnhA0Nlr3KvIH/Rgj7qbvs
         uMTvTyw6xpImdH81xk15bUdYPk+wsLg9sHQsL1CCSMLcDlc0aFBwKb1+uiF6mwthIKqC
         89+nustuv4cDx0WITQrEcRPZ9zTE/qNOmQpe5dKuSZTDPgUuvwPk8mHi74Tp6KkGX3Js
         D5gg==
X-Gm-Message-State: AOAM531aGADaPlB8AnAh+zxf5eSRYil/oSOmCKABHs5OxlJRNnJsuSsB
        G5MWR1gBzX4JNa+WqqtcUIc=
X-Google-Smtp-Source: ABdhPJx3Rc09ke2ooHghJt63sw7/8doQgtBD+kIz66rR6Kyzfxdj1uRFMyIp8vRWVPEsTUEOaEVcwQ==
X-Received: by 2002:ac2:4c81:: with SMTP id d1mr24285043lfl.588.1638628659547;
        Sat, 04 Dec 2021 06:37:39 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:39 -0800 (PST)
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
Subject: [PATCH v4 10/22] ASoC: tegra20: spdif: Reset hardware
Date:   Sat,  4 Dec 2021 17:37:13 +0300
Message-Id: <20211204143725.31646-11-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset S/PDIF controller on runtime PM suspend/resume to ensure that we
always have a consistent hardware state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 32 ++++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra20_spdif.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 7dd263721c2c..bc45a0a8afab 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -14,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -27,6 +29,8 @@ static __maybe_unused int tegra20_spdif_runtime_suspend(struct device *dev)
 {
 	struct tegra20_spdif *spdif = dev_get_drvdata(dev);
 
+	regcache_cache_only(spdif->regmap, true);
+
 	clk_disable_unprepare(spdif->clk_spdif_out);
 
 	return 0;
@@ -37,13 +41,35 @@ static __maybe_unused int tegra20_spdif_runtime_resume(struct device *dev)
 	struct tegra20_spdif *spdif = dev_get_drvdata(dev);
 	int ret;
 
+	ret = reset_control_assert(spdif->reset);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(spdif->clk_spdif_out);
 	if (ret) {
 		dev_err(dev, "clk_enable failed: %d\n", ret);
 		return ret;
 	}
 
+	usleep_range(10, 100);
+
+	ret = reset_control_deassert(spdif->reset);
+	if (ret)
+		goto disable_clocks;
+
+	regcache_cache_only(spdif->regmap, false);
+	regcache_mark_dirty(spdif->regmap);
+
+	ret = regcache_sync(spdif->regmap);
+	if (ret)
+		goto disable_clocks;
+
 	return 0;
+
+disable_clocks:
+	clk_disable_unprepare(spdif->clk_spdif_out);
+
+	return ret;
 }
 
 static int tegra20_spdif_hw_params(struct snd_pcm_substream *substream,
@@ -268,6 +294,12 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, spdif);
 
+	spdif->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(spdif->reset)) {
+		dev_err(&pdev->dev, "Can't retrieve spdif reset\n");
+		return PTR_ERR(spdif->reset);
+	}
+
 	spdif->clk_spdif_out = devm_clk_get(&pdev->dev, "out");
 	if (IS_ERR(spdif->clk_spdif_out)) {
 		dev_err(&pdev->dev, "Could not retrieve spdif clock\n");
diff --git a/sound/soc/tegra/tegra20_spdif.h b/sound/soc/tegra/tegra20_spdif.h
index 1973ffc2d5c7..ff4b79e2052f 100644
--- a/sound/soc/tegra/tegra20_spdif.h
+++ b/sound/soc/tegra/tegra20_spdif.h
@@ -451,6 +451,7 @@ struct tegra20_spdif {
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
 	struct regmap *regmap;
+	struct reset_control *reset;
 };
 
 #endif
-- 
2.33.1

