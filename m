Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FCD466807
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347519AbhLBQ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359488AbhLBQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:28:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBE5C06174A;
        Thu,  2 Dec 2021 08:25:24 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id r26so72788346lfn.8;
        Thu, 02 Dec 2021 08:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+cwXkLuYTguZ/egF0PR3HKcbjBSFy6IZ25EC5llUN0=;
        b=VKHmJthUvjXS59BALwb+ATthridW7xhHVa77qVsv2kC+AI1yk0gqoD7e7ukv/VdpgE
         eopIG8eEd/6R1JvOAEEMrOIyMyhtdTq1mHZsVA8ZtzZ+EK6FX8JC7mUrCiyqU0/3oHs3
         uSVimfLQzh+HuVn/l9jwjsiToGPQGOTPJrR+sUEXvpnydyvUi7IwPVr8UmRiCIZ+A0XF
         zmOH65X+Sqo+a0PTV2+8HOncLJ50wBUOqp1JIoTOXiKiawqGetLW5doVAxtq8jXdfdUf
         UloDRnGPTYX4CBrmG0xb4F2Kw1NSa+rYE8xI244v9jl8/Fob4k5tBG36hOXSR+hvt3jN
         TW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+cwXkLuYTguZ/egF0PR3HKcbjBSFy6IZ25EC5llUN0=;
        b=N/A1GLvgs1Djv6X7hg/UzEWnXoxuwLVKqIK0qrBZNggH4RsQjfgbO5QaY+cpIFkwu5
         tlj+Fz0aMEHd6kcq3G0if4zFO8KXFKAD518Er0ST9hUs/qeMcqORHtMtr/Bi9sLHPP5q
         6LwzlaIvBD2cBLV2L9+mA4T7QEExSoQIH4R5QKUMm6Q6c0+Z9i1STN1mVW9s1MN4OaUk
         HEzTvjUakpIzGee0W02DJ7xhNobdo5/v5fktfXATGiRvv2Irwh69GQyCMEEou5vQ4N2s
         wFt8Vbdd3ocwidtAR1ECs4WXecFAxbFjomtuz/UhKhZJbC3LT2wbzTprk4mEGsbM8A+5
         dO8g==
X-Gm-Message-State: AOAM532KmXFxK3rm5aY4Qapc3aX5gDCd7VlZK9AZ3SetwqDDjzT3VP4L
        KhFvF0Yy+NBgCg2aCmu246Q=
X-Google-Smtp-Source: ABdhPJx4sY5bfWAJiUlJjt+ZI84qUzYJ5TudTm3UCnZQn0koHijjsXA+YonMWOeM5aRlqg5oafHiOQ==
X-Received: by 2002:a05:6512:3e1e:: with SMTP id i30mr12327554lfv.560.1638462322498;
        Thu, 02 Dec 2021 08:25:22 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:22 -0800 (PST)
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
Subject: [PATCH v3 07/20] ASoC: tegra20: spdif: Support device-tree
Date:   Thu,  2 Dec 2021 19:23:28 +0300
Message-Id: <20211202162341.1791-8-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20 S/PDIF driver was added in a pre-DT era and was never used since
that time. Revive driver by adding device-tree support.

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

