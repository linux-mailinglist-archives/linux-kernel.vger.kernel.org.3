Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90325468583
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347153AbhLDOlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbhLDOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:06 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65004C061D5E;
        Sat,  4 Dec 2021 06:37:40 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t26so13734493lfk.9;
        Sat, 04 Dec 2021 06:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yiWw98T7doYf6/KdnKDQ+eJuYvZvxnbIRrcyi8dmlBQ=;
        b=CvIzdumJO57P7zWKTttzFuuWukezUtQ7SVqlCIDYJOCL+DDGJxa5NRlTzP5ufVTyJ3
         WdBnoPEWjyt/yA9/2yfp5uKl97UlOmh+2/vbgRGtRKHmGAzisdMgBlLyKdImPkUtofUz
         q9BHiVvU3wDb+5i1gQYwAeev/0armeUk1a/euDZjUbwA+gB18AP7AOuRBLxcIZpWo4yY
         gdrBt4VM0+pFbydfe7BjRCAckyhxJp2/NNOMC77qDxxxrT2nUvwqnd7zOcVAdIFgFErp
         YiV3VT6GsX1JEh9CqKnVF0BwtNheR9RH33TRbulARC2YxWbmmzy2zZ36Urf0WDOLiKAr
         r+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yiWw98T7doYf6/KdnKDQ+eJuYvZvxnbIRrcyi8dmlBQ=;
        b=BdSgKkTX5OeyECCN35208GYCoz5VOKuo28psQE6ZSAU150VmsXFeF08QTP4KBsIxsi
         13E0JjE1Ou+h2d1ATodsXfCiPi/ozFIFjmFDTFQhx8ceisVfRI3wpZDsFk66etgTLlCR
         PZyyqyc+BbeFP2lF+qXHYdRwIcVEeuGPBbfSnA4DE3wQKl7nZ0SIS4f2xl9U4Pl3tuhn
         x5UcJGWhOsFTY7sSUzNVvM9GM1o8nAtSQJX9WO7Ypv2g5ZvWCfcfmqtnFxcXsGG9G4F0
         EzbwU0nlsTxMMIWkiQIiAeQ8+4Fv/xRy4teD6oKp3AKda7AaBUy4vBlJF08MBfgu5QnL
         m5MQ==
X-Gm-Message-State: AOAM5339GJMc4PclglA4SIQYtkTWumpULchVzNIjGAV2hz3Kcvzywr0w
        ibWTcL0wfFzV9UVWfqPq46Q=
X-Google-Smtp-Source: ABdhPJwGxqR5dlehJ7vaPbP5WBGS9cfxwU4MhdypIIFth3sVfScXSDCGAKQzEHWJmayVj6NGoxgE2w==
X-Received: by 2002:a05:6512:1090:: with SMTP id j16mr23911147lfg.568.1638628658719;
        Sat, 04 Dec 2021 06:37:38 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:38 -0800 (PST)
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
Subject: [PATCH v4 09/22] ASoC: tegra20: spdif: Use more resource-managed helpers
Date:   Sat,  4 Dec 2021 17:37:12 +0300
Message-Id: <20211204143725.31646-10-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use resource-managed helpers to make code cleaner. Driver's remove callback
isn't needed anymore since driver is completely resource-managed now.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 33 +++++++++------------------------
 sound/soc/tegra/tegra_pcm.c     |  6 ++++++
 sound/soc/tegra/tegra_pcm.h     |  1 +
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index d5c618611dbb..7dd263721c2c 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -289,38 +289,24 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	spdif->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	spdif->playback_dma_data.maxburst = 4;
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
 
-	ret = snd_soc_register_component(&pdev->dev, &tegra20_spdif_component,
-					 &tegra20_spdif_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &tegra20_spdif_component,
+					      &tegra20_spdif_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
-		goto err_pm_disable;
+		return ret;
 	}
 
-	ret = tegra_pcm_platform_register(&pdev->dev);
+	ret = devm_tegra_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
-		goto err_unregister_component;
+		return ret;
 	}
 
-	return 0;
-
-err_unregister_component:
-	snd_soc_unregister_component(&pdev->dev);
-err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
-
-	return ret;
-}
-
-static int tegra20_spdif_platform_remove(struct platform_device *pdev)
-{
-	tegra_pcm_platform_unregister(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
-
-	pm_runtime_disable(&pdev->dev);
-
 	return 0;
 }
 
@@ -342,7 +328,6 @@ static struct platform_driver tegra20_spdif_driver = {
 		.of_match_table = tegra20_spdif_of_match,
 	},
 	.probe = tegra20_spdif_platform_probe,
-	.remove = tegra20_spdif_platform_remove,
 };
 module_platform_driver(tegra20_spdif_driver);
 
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index ef1e74d95236..468c8e77de21 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -48,6 +48,12 @@ int tegra_pcm_platform_register(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tegra_pcm_platform_register);
 
+int devm_tegra_pcm_platform_register(struct device *dev)
+{
+	return devm_snd_dmaengine_pcm_register(dev, &tegra_dmaengine_pcm_config, 0);
+}
+EXPORT_SYMBOL_GPL(devm_tegra_pcm_platform_register);
+
 int tegra_pcm_platform_register_with_chan_names(struct device *dev,
 				struct snd_dmaengine_pcm_config *config,
 				char *txdmachan, char *rxdmachan)
diff --git a/sound/soc/tegra/tegra_pcm.h b/sound/soc/tegra/tegra_pcm.h
index d602126c65b7..2a36eea1740d 100644
--- a/sound/soc/tegra/tegra_pcm.h
+++ b/sound/soc/tegra/tegra_pcm.h
@@ -32,6 +32,7 @@ int tegra_pcm_hw_params(struct snd_soc_component *component,
 snd_pcm_uframes_t tegra_pcm_pointer(struct snd_soc_component *component,
 				    struct snd_pcm_substream *substream);
 int tegra_pcm_platform_register(struct device *dev);
+int devm_tegra_pcm_platform_register(struct device *dev);
 int tegra_pcm_platform_register_with_chan_names(struct device *dev,
 				struct snd_dmaengine_pcm_config *config,
 				char *txdmachan, char *rxdmachan);
-- 
2.33.1

