Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2605E47935C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbhLQR6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbhLQR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:58:11 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D46BC06173F;
        Fri, 17 Dec 2021 09:58:11 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d38so6371506lfv.0;
        Fri, 17 Dec 2021 09:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XmIaZHgbch9Ndb9r5aHLF0Fx0YU8zrMQcOhUAQ7w2k=;
        b=VjmC0Y9w7NZLdn12GxvPfT3HjzRD7yE5rRR8+dZbQV/YUiLiq1hPZSE7/eXTx6YJbQ
         N5kxA5stjoRrV02Ho0bCFBc+uzBTAvDFIRpRAYDdAq1FJLKPTORqju61N8MnGp0oP7Ys
         ddVZzRfGLRCwQz5b3KrBSBkkTMQ5ITLq3XyBTi+HEatpG4H5rcBoTewdPpLaa1kySo32
         3dhqSW4RutSB4xPUoAvRJfxXZ3d3D0qzY5VADsnVS86Qw6Qoq4qEFv0aFxXCBNVBfQJA
         O2iyhmXY1aliKLREMlsGvJ5/2zBp4AzIg2gaVt3+I/9jNyKx5023sDZ+33Apz2NAhXOn
         tAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XmIaZHgbch9Ndb9r5aHLF0Fx0YU8zrMQcOhUAQ7w2k=;
        b=DYVkeFp0cYrmytS4k+Ol/rwKZmnW9y7gWTk3iAL0E8tY+iRKQvLkglvL1XVP5bf1L6
         N3V5DVNI1x3nmh7+XFLgxRkauGLD9zs21KFueNyNxiBW846EP/M7ru8TOkNeATqxOL7w
         HB2p44+oF5CHvfpfWufCOOOw5vKQTnJwS1wU7oPw8xAQDh7ofnwxE9mJV+TDFS+r6vvM
         xQV90Ncr1B4VJclnVv7jjnbYSQ0a16DgkHSkIkXnratEGTDIKXZGgCU7bWj3dKIW+agp
         EGanf9LHYbl/yw+BCKkf/S74TQHlNHcIIHa6Pebb6aMPhpLLCrb7EBan7foHtYRp4oJ8
         qC+Q==
X-Gm-Message-State: AOAM532t95/wFzuHgfF3XAuCVOkgxMwn5GsAv+ZkR+4NRGlvD2CHgTsO
        VzEMxV/OIgdZ5UEwq0QsDT0=
X-Google-Smtp-Source: ABdhPJyB34TPLVV+Dx09e/VOaPT8n/32uTFbtegwmM16PU133AfDRdQYKVBq3XAz5cM+0dYvrhQ7ew==
X-Received: by 2002:a05:6512:50c:: with SMTP id o12mr3751228lfb.41.1639763889556;
        Fri, 17 Dec 2021 09:58:09 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id w23sm1479244lfa.191.2021.12.17.09.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:58:09 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 08/11] ASoC: tegra20: spdif: Reset hardware
Date:   Fri, 17 Dec 2021 20:56:03 +0300
Message-Id: <20211217175606.22645-9-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217175606.22645-1-digetx@gmail.com>
References: <20211217175606.22645-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset S/PDIF controller on runtime PM suspend/resume to ensure that we
always have a consistent hardware state.

Acked-by: Thierry Reding <treding@nvidia.com>
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

