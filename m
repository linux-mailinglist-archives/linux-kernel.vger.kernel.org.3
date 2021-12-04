Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9776046857F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355163AbhLDOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbhLDOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:04 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A5CC061751;
        Sat,  4 Dec 2021 06:37:38 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k2so11976762lji.4;
        Sat, 04 Dec 2021 06:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+cwXkLuYTguZ/egF0PR3HKcbjBSFy6IZ25EC5llUN0=;
        b=j/nRLfBMh83bJkhX9kKkLg6MjMASwyBr0GXZu60BaXxuoTEiPEjuzogBdZGlgka4J8
         X8HEaoSu45IvmOwqyH78PgKM6szrLRdv+/ijT5pquObXabsfbJPZm4fpOW5F9h6GRMEY
         t6Fk9xa+gAy2Pq+ihRQQZjLdcF5s/QvwgHPeFq8LW+wCLAIylGpE5Roy7YsE43E04Bba
         tfl4N8tQs0bx+3JPhEQj80CJwWDXuSMbA+8by/i4C5us+V0ts+EPDwBtIlDmsg05irSp
         ELhBsJVrP9D+R5nn1uidp4WIhSa+hLi8YfCm4xdnSgBq2Ruz8yVqPaW2HTolTzPMqZc4
         u1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+cwXkLuYTguZ/egF0PR3HKcbjBSFy6IZ25EC5llUN0=;
        b=wrJmWzJNiAE0TjbJZxOVc9HKQdD8/OJQPqneozMS6oDjRrjUxImTC8PlQz8WBK9YEo
         +o4sPUmD6tbEtyYtoED3uhNvNrnFxEbTE7yxFvdaR+bJo1nLx2POfBTMpHsdyjQjB2Zg
         IQklR3ovo6nUlxU2O33GplpGh8lJBmsypOkFXPrSpBLDi2eB80X0L5vEHNRSi8flySMh
         vDabpubBE4z/VGFnygcwrNzf5S5tIHVBjpmrp8b3H33ZExmdhYpZb+s/cGAJHx7uaHeQ
         zOqJMaa7hhKKUIceMhDEUKCEoIfcV2JFESreI5JfTPSI7j5E85FFjaa5J1jhAbFUn2/p
         ynAw==
X-Gm-Message-State: AOAM533czcH7Xev0/voBQtDJ/mAKPljCnHHRsvF4oMf9DunwNG3MLgWm
        bURSHAmT7qO2zV3MMctnKhI=
X-Google-Smtp-Source: ABdhPJyzjPMRg1eQNKV77H8cTJlpAZtummXWT5L9NX8MxCuSuSlCajaCwXqQPQJt0JF2skWo4aiVNw==
X-Received: by 2002:a2e:7a02:: with SMTP id v2mr24889139ljc.227.1638628657078;
        Sat, 04 Dec 2021 06:37:37 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:36 -0800 (PST)
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
Subject: [PATCH v4 07/22] ASoC: tegra20: spdif: Support device-tree
Date:   Sat,  4 Dec 2021 17:37:10 +0300
Message-Id: <20211204143725.31646-8-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
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

