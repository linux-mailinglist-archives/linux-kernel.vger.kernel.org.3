Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B94479354
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbhLQR6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbhLQR6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:58:09 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C771C061746;
        Fri, 17 Dec 2021 09:58:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id t3so6172253lfe.12;
        Fri, 17 Dec 2021 09:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aa9yOoBAsbVbHG/p5jLgnwkk1qHi5k7LSoJyKHkxWf8=;
        b=Hp038EhPsEX/h9Yl3bv4AclbmQNLVpsMCwmu+Kap3o46DhCTol4mS+RxfvPnIndB+W
         337wZ6Qeji9i20vF3dYXIufPjaTC5zEeeAro27XaYktqAqdzx0f1sHUNaoz6723np3C8
         tg9prHr8luMRr9nwPCzZ3pvGOeNQgXohRf+7ACcOEOuseMgIKL11x5na7fzW4cJ1JP6S
         /NwIqyso0eqSOfGhK0+AQJnpPQPVzcexsSRgHr8Q9QsrlgeiEcD5LUQAtD5m3BNWNRk8
         MrAxR5p/h/W80Av/jEoAOarE7gcJCdBMjO1G/cCh72JJvu78aVRg1JJediQlhSHXHNiu
         Dp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aa9yOoBAsbVbHG/p5jLgnwkk1qHi5k7LSoJyKHkxWf8=;
        b=7zL+yjLQ+s+aSsqiXxK0sj8R9eUwVgFFR6cwzrp4kdJuT++Mx0VTOdHVOReCw3rRtk
         3Ufd5r/6UGz/PTKr18sZwbvVfoCDSJ8BkVcjo7Y9I5AT9jkfQLV/2sSdUPS2n7ygHeZY
         GNQThUBcmFncRJwj8jEnmNgK0ghJZ+n0FxhE2w2kzseNRRjG+YfvVgs4GDJnPyNz7zP1
         8aQsbs0HUkCejz51GIJvJy66EVdJDjaoa5XMkjYcfXaLZSfm0Vx0S5HUUnTa8n8xV7Fw
         cDBUN15QlYuEOgkhT/EK5x4E1yKxUWUzxwj1dqPaoTyiwH+L8n5D7nvpE9rdwpCtDCqd
         05zA==
X-Gm-Message-State: AOAM532MpoUSkSpvgzZItfllnUA9pm0t0baRE+v19r4xreMguFchee0w
        WodK0l3RyGr0DvtwhetzqNLd6BUZYtE=
X-Google-Smtp-Source: ABdhPJxDbG9C/hfS2qMWQsIB4NCcsWLXQr40hT4oghlO4QZ/abjfdAKcGOjou7Lqh1mV0z92cH0Wuw==
X-Received: by 2002:a05:6512:b14:: with SMTP id w20mr3659502lfu.164.1639763887504;
        Fri, 17 Dec 2021 09:58:07 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id w23sm1479244lfa.191.2021.12.17.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:58:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 05/11] ASoC: tegra20: spdif: Support device-tree
Date:   Fri, 17 Dec 2021 20:56:00 +0300
Message-Id: <20211217175606.22645-6-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217175606.22645-1-digetx@gmail.com>
References: <20211217175606.22645-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20 S/PDIF driver was added in a pre-DT era and was never used since
that time. Revive driver by adding device-tree support.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index e45e371edc42..801784915004 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -270,7 +271,7 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, spdif);
 
-	spdif->clk_spdif_out = devm_clk_get(&pdev->dev, "spdif_out");
+	spdif->clk_spdif_out = devm_clk_get(&pdev->dev, "out");
 	if (IS_ERR(spdif->clk_spdif_out)) {
 		pr_err("Can't retrieve spdif clock\n");
 		ret = PTR_ERR(spdif->clk_spdif_out);
@@ -340,10 +341,17 @@ static const struct dev_pm_ops tegra20_spdif_pm_ops = {
 			   tegra20_spdif_runtime_resume, NULL)
 };
 
+static const struct of_device_id tegra20_spdif_of_match[] = {
+	{ .compatible = "nvidia,tegra20-spdif", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tegra20_spdif_of_match);
+
 static struct platform_driver tegra20_spdif_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &tegra20_spdif_pm_ops,
+		.of_match_table = tegra20_spdif_of_match,
 	},
 	.probe = tegra20_spdif_platform_probe,
 	.remove = tegra20_spdif_platform_remove,
@@ -354,4 +362,3 @@ module_platform_driver(tegra20_spdif_driver);
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Tegra20 SPDIF ASoC driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.33.1

