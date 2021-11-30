Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16403464309
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345559AbhK3X3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240800AbhK3X1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:39 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAC5C061574;
        Tue, 30 Nov 2021 15:24:19 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id k37so57964069lfv.3;
        Tue, 30 Nov 2021 15:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJyi42euXBD3SLFWkAig1L26OU8nvTPoOeHmCjkl8Pw=;
        b=b2fW6Hqy4+zwe5GTMQ5CSbpbJHw6Nfr7i0foldasEtmGV7CjeBUJZb/tmOqcKLS5vQ
         zPTARxu3mleMSAUAOrQOhrgVLBVcD+deJc2ybg1EZRbZMw5cxM936BvE/VslqdciUjWB
         9ZTnzCmbLLFU0KbXdW4b3s+qdIWbw8U5oS/4+ON/jXDStGdm4Y28wEWLFjIRWf72F+4C
         P1iFViewLxnWLhWLI6qWK9YBTZ2AyeUhTSDUHyaDkiIZgITfl8ZUVX5/WBP2vPcn+3aN
         0eIfAIGuCfP4STL0gw2HA4KJRbYJA0rMIl4svWA1t4aVaRSa90P1DRY0Wjv6V2hIox1o
         gcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJyi42euXBD3SLFWkAig1L26OU8nvTPoOeHmCjkl8Pw=;
        b=YWB+FL70XVwq96w2IfOjKkEe76CWg2DxTmXqo5VgONSNf6Aa82gP06g4gMZkUsli1f
         e+YVYcVFhefoJsa8aIGi3WsDFsLAMfGEBkrKYZJypBGctuvL9mPiwMFNiEZkUxMofVp+
         9sJNjJMbuB1w7RFc/5vNV7pxHUqtbB22bWZWlCLfM7KuSBasbv2uR+Ofi3cDwsCuo11/
         elTjPeAwYz33SK4nr5hHJufnatE4TRv+DA9/UVVG6fIZU6JQc/QEfELCxOnfmlCmMmae
         oaI8GrfkcsW0+q0ari0TKm+Km53QjEKiw3W7xXK4xGp84MiY9LYBqYv+K7xLcEcdav+8
         6C2w==
X-Gm-Message-State: AOAM5339qZ2pFVXNUa48NFOp5Dt1X3oGDTm1Uvts0safParUKHkILi1l
        j8oyB+Wl5M3bH2WYzvUP23Ww+b+LOw8=
X-Google-Smtp-Source: ABdhPJygPfUp3zMHTZduMCen8H47fOt4g0lOm90e4WpJ6p30PH5VS1WsujA8kB8f0A8LcIPyaetn7A==
X-Received: by 2002:a05:6512:323c:: with SMTP id f28mr2222889lfe.462.1638314657494;
        Tue, 30 Nov 2021 15:24:17 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:17 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v16 23/40] mtd: rawnand: tegra: Add runtime PM and OPP support
Date:   Wed,  1 Dec 2021 02:23:30 +0300
Message-Id: <20211130232347.950-24-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NAND on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now NAND must be resumed using
runtime PM API in order to initialize the NAND power state. Add runtime PM
and OPP support to the NAND driver.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mtd/nand/raw/tegra_nand.c | 58 ++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 32431bbe69b8..b36e5260ae27 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -17,8 +17,11 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
+
 #define COMMAND					0x00
 #define   COMMAND_GO				BIT(31)
 #define   COMMAND_CLE				BIT(30)
@@ -1151,6 +1154,7 @@ static int tegra_nand_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctrl->dev = &pdev->dev;
+	platform_set_drvdata(pdev, ctrl);
 	nand_controller_init(&ctrl->controller);
 	ctrl->controller.ops = &tegra_nand_controller_ops;
 
@@ -1166,14 +1170,23 @@ static int tegra_nand_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->clk))
 		return PTR_ERR(ctrl->clk);
 
-	err = clk_prepare_enable(ctrl->clk);
+	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (err)
+		return err;
+
+	/*
+	 * This driver doesn't support active power management yet,
+	 * so we will simply keep device resumed.
+	 */
+	pm_runtime_enable(&pdev->dev);
+	err = pm_runtime_resume_and_get(&pdev->dev);
 	if (err)
 		return err;
 
 	err = reset_control_reset(rst);
 	if (err) {
 		dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
-		goto err_disable_clk;
+		goto err_put_pm;
 	}
 
 	writel_relaxed(HWSTATUS_CMD_DEFAULT, ctrl->regs + HWSTATUS_CMD);
@@ -1188,21 +1201,20 @@ static int tegra_nand_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), ctrl);
 	if (err) {
 		dev_err(ctrl->dev, "Failed to get IRQ: %d\n", err);
-		goto err_disable_clk;
+		goto err_put_pm;
 	}
 
 	writel_relaxed(DMA_MST_CTRL_IS_DONE, ctrl->regs + DMA_MST_CTRL);
 
 	err = tegra_nand_chips_init(ctrl->dev, ctrl);
 	if (err)
-		goto err_disable_clk;
-
-	platform_set_drvdata(pdev, ctrl);
+		goto err_put_pm;
 
 	return 0;
 
-err_disable_clk:
-	clk_disable_unprepare(ctrl->clk);
+err_put_pm:
+	pm_runtime_put_sync_suspend(ctrl->dev);
+	pm_runtime_force_suspend(ctrl->dev);
 	return err;
 }
 
@@ -1219,11 +1231,40 @@ static int tegra_nand_remove(struct platform_device *pdev)
 
 	nand_cleanup(chip);
 
+	pm_runtime_put_sync_suspend(ctrl->dev);
+	pm_runtime_force_suspend(ctrl->dev);
+
+	return 0;
+}
+
+static int __maybe_unused tegra_nand_runtime_resume(struct device *dev)
+{
+	struct tegra_nand_controller *ctrl = dev_get_drvdata(dev);
+	int err;
+
+	err = clk_prepare_enable(ctrl->clk);
+	if (err) {
+		dev_err(dev, "Failed to enable clock: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_nand_runtime_suspend(struct device *dev)
+{
+	struct tegra_nand_controller *ctrl = dev_get_drvdata(dev);
+
 	clk_disable_unprepare(ctrl->clk);
 
 	return 0;
 }
 
+static const struct dev_pm_ops tegra_nand_pm = {
+	SET_RUNTIME_PM_OPS(tegra_nand_runtime_suspend, tegra_nand_runtime_resume,
+			   NULL)
+};
+
 static const struct of_device_id tegra_nand_of_match[] = {
 	{ .compatible = "nvidia,tegra20-nand" },
 	{ /* sentinel */ }
@@ -1234,6 +1275,7 @@ static struct platform_driver tegra_nand_driver = {
 	.driver = {
 		.name = "tegra-nand",
 		.of_match_table = tegra_nand_of_match,
+		.pm = &tegra_nand_pm,
 	},
 	.probe = tegra_nand_probe,
 	.remove = tegra_nand_remove,
-- 
2.33.1

