Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3474685A4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355300AbhLDOnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbhLDOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:05 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B240C0613F8;
        Sat,  4 Dec 2021 06:37:39 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b1so13692644lfs.13;
        Sat, 04 Dec 2021 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESFpQKma3lTjqrfmgMQpOMI3AuZCe4KO5QXqe72faX8=;
        b=TicABCYVrH3XMcI4fMyTTUSRh2Nt3KTgl1zeRyN9NtLu7JdR+XRfN9ZZp61klCODxq
         4u9IWbi+uDpSMn61gTc8HflHusdCTlj4I8Hv6lIDEJhiHrilTaJOQI7uwNYzd2WDIbTY
         9N8j5wDP5kRYgrT7m518ozgt7PNCZXWYXHmrKUv3e9jzEXOuMZOJO+KVhT1qCXnk9BD6
         DbRrY7N2E32ZY87cwMR0ZIULsNWXD/llBbn0aToxBITewqkQ8RU2LwSPkcRubbEJDqSE
         GRF1jsSzVC+XDEfwQzaOebWb17jpb1RXhkUTxRDyQOOuQ4vF+miN1+36gLbnut9OSGSm
         s6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESFpQKma3lTjqrfmgMQpOMI3AuZCe4KO5QXqe72faX8=;
        b=XOzDZ7/ePOm5lEBIhMpsV1rRpHH+iS75qksqGk+VeHsz3MZTs94Y1Qoa45MwYgWjuX
         tt0traI02VfUb5QEGnfk3ePJ8Q9O0VE5NgJVJWJMjJ0oznbhX01KfHxI3Bt/Nd7IZWqt
         73O9ceIpL5Izgpfzg1TO3Pb2oxa2XAxE1w6JYmHvQFmbJjvmf9+1pr8AzEVOp2zupJma
         KEYUariPYcR2egzqNN05XgAum7CqJgVFeJvkX4qMsh2dgg5Co7k975/FDkVC/k44knjR
         hWOk91/UkIHgnlXfpGNvenl5b/DBjwAbsTklUJCRCK5/JTr1GlU1WExu+kQalZLRury1
         BBwQ==
X-Gm-Message-State: AOAM530x0uRv1BqvU4R5OY2KeuHfSZqp/huKkpJaKXP+JhRiy1mrvt+C
        4dBxitH1dfi5mZ7tuDmDpWo=
X-Google-Smtp-Source: ABdhPJys4hLKgsE7ntdju7Sbkk/ji7VyRuETbGQmjaZwYZgPdqe7TDx4krj9+KUTS8PX9YlFc/irOw==
X-Received: by 2002:a05:6512:1194:: with SMTP id g20mr23015667lfr.58.1638628657887;
        Sat, 04 Dec 2021 06:37:37 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:37 -0800 (PST)
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
Subject: [PATCH v4 08/22] ASoC: tegra20: spdif: Improve driver's code
Date:   Sat,  4 Dec 2021 17:37:11 +0300
Message-Id: <20211204143725.31646-9-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Clean up whitespaces, defines and variables.

- Remove obsolete code.

- Adhere to upstream coding style.

- Don't override returned error code.

- Replace pr_err with dev_err.

No functional changes are made by this patch. This is a minor code's
refactoring that will ease further maintenance of the driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 49 ++++++++++++---------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 801784915004..d5c618611dbb 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -23,8 +23,6 @@
 
 #include "tegra20_spdif.h"
 
-#define DRV_NAME "tegra20-spdif"
-
 static __maybe_unused int tegra20_spdif_runtime_suspend(struct device *dev)
 {
 	struct tegra20_spdif *spdif = dev_get_drvdata(dev);
@@ -49,11 +47,10 @@ static __maybe_unused int tegra20_spdif_runtime_resume(struct device *dev)
 }
 
 static int tegra20_spdif_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params,
-				struct snd_soc_dai *dai)
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
 {
-	struct device *dev = dai->dev;
-	struct tegra20_spdif *spdif = snd_soc_dai_get_drvdata(dai);
+	struct tegra20_spdif *spdif = dev_get_drvdata(dai->dev);
 	unsigned int mask = 0, val = 0;
 	int ret, spdifclock;
 
@@ -106,7 +103,7 @@ static int tegra20_spdif_hw_params(struct snd_pcm_substream *substream,
 
 	ret = clk_set_rate(spdif->clk_spdif_out, spdifclock);
 	if (ret) {
-		dev_err(dev, "Can't set SPDIF clock rate: %d\n", ret);
+		dev_err(dai->dev, "Can't set SPDIF clock rate: %d\n", ret);
 		return ret;
 	}
 
@@ -127,9 +124,9 @@ static void tegra20_spdif_stop_playback(struct tegra20_spdif *spdif)
 }
 
 static int tegra20_spdif_trigger(struct snd_pcm_substream *substream, int cmd,
-				struct snd_soc_dai *dai)
+				 struct snd_soc_dai *dai)
 {
-	struct tegra20_spdif *spdif = snd_soc_dai_get_drvdata(dai);
+	struct tegra20_spdif *spdif = dev_get_drvdata(dai->dev);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -151,7 +148,7 @@ static int tegra20_spdif_trigger(struct snd_pcm_substream *substream, int cmd,
 
 static int tegra20_spdif_probe(struct snd_soc_dai *dai)
 {
-	struct tegra20_spdif *spdif = snd_soc_dai_get_drvdata(dai);
+	struct tegra20_spdif *spdif = dev_get_drvdata(dai->dev);
 
 	dai->capture_dma_data = NULL;
 	dai->playback_dma_data = &spdif->playback_dma_data;
@@ -160,26 +157,26 @@ static int tegra20_spdif_probe(struct snd_soc_dai *dai)
 }
 
 static const struct snd_soc_dai_ops tegra20_spdif_dai_ops = {
-	.hw_params	= tegra20_spdif_hw_params,
-	.trigger	= tegra20_spdif_trigger,
+	.hw_params = tegra20_spdif_hw_params,
+	.trigger = tegra20_spdif_trigger,
 };
 
 static struct snd_soc_dai_driver tegra20_spdif_dai = {
-	.name = DRV_NAME,
+	.name = "tegra20-spdif",
 	.probe = tegra20_spdif_probe,
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
-				SNDRV_PCM_RATE_48000,
+			 SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.ops = &tegra20_spdif_dai_ops,
 };
 
 static const struct snd_soc_component_driver tegra20_spdif_component = {
-	.name		= DRV_NAME,
+	.name = "tegra20-spdif",
 };
 
 static bool tegra20_spdif_wr_rd_reg(struct device *dev, unsigned int reg)
@@ -260,7 +257,7 @@ static const struct regmap_config tegra20_spdif_regmap_config = {
 static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 {
 	struct tegra20_spdif *spdif;
-	struct resource *mem, *dmareq;
+	struct resource *mem;
 	void __iomem *regs;
 	int ret;
 
@@ -273,27 +270,19 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 
 	spdif->clk_spdif_out = devm_clk_get(&pdev->dev, "out");
 	if (IS_ERR(spdif->clk_spdif_out)) {
-		pr_err("Can't retrieve spdif clock\n");
-		ret = PTR_ERR(spdif->clk_spdif_out);
-		return ret;
+		dev_err(&pdev->dev, "Could not retrieve spdif clock\n");
+		return PTR_ERR(spdif->clk_spdif_out);
 	}
 
 	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	dmareq = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!dmareq) {
-		dev_err(&pdev->dev, "No DMA resource\n");
-		return -ENODEV;
-	}
-
 	spdif->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
-					    &tegra20_spdif_regmap_config);
+					      &tegra20_spdif_regmap_config);
 	if (IS_ERR(spdif->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
-		ret = PTR_ERR(spdif->regmap);
-		return ret;
+		return PTR_ERR(spdif->regmap);
 	}
 
 	spdif->playback_dma_data.addr = mem->start + TEGRA20_SPDIF_DATA_OUT;
@@ -306,7 +295,6 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 					 &tegra20_spdif_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
-		ret = -ENOMEM;
 		goto err_pm_disable;
 	}
 
@@ -349,14 +337,13 @@ MODULE_DEVICE_TABLE(of, tegra20_spdif_of_match);
 
 static struct platform_driver tegra20_spdif_driver = {
 	.driver = {
-		.name = DRV_NAME,
+		.name = "tegra20-spdif",
 		.pm = &tegra20_spdif_pm_ops,
 		.of_match_table = tegra20_spdif_of_match,
 	},
 	.probe = tegra20_spdif_platform_probe,
 	.remove = tegra20_spdif_platform_remove,
 };
-
 module_platform_driver(tegra20_spdif_driver);
 
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
-- 
2.33.1

