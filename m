Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52A146432B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbhK3X3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345412AbhK3X1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:43 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9B2C061748;
        Tue, 30 Nov 2021 15:24:22 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id r26so57904917lfn.8;
        Tue, 30 Nov 2021 15:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udxoZ5sHHyWoGGCNUpfDNLDNjJsYtsk9R/zPM+x/w7I=;
        b=ch2FSpnhpDvD8Jz/nv3PLmV0LWy7ZTaslLerjaww8PWr481n5oce1eWs69G5eZk2Cz
         N2K01kgdZI3seB+o6ro7WqWQCDaLmkwK7ZzjEBVd8DkQARXiFc1RRBXnZ8It14gAIjeT
         2g2R8qySm9tW7sL/AX3Sc0NijjHFpELfh3rJY1GPpH2cIDXaEurwhvGRni7l21bxgb8V
         RqRJDsERFbP4N99ZGlKPzQVXypGAZFmo3QHhXzjey0lyjHSG4qk06Jc56N12A/ivJzpw
         OQD+fSqI39ByaXNHLvwsBGOymQMD/n7kxKEcAfQxMKlwXmF0mq/RYSzwPgvGd6ybEBO0
         giDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udxoZ5sHHyWoGGCNUpfDNLDNjJsYtsk9R/zPM+x/w7I=;
        b=VsJTU039R02GQ8LQ3jCrYLbPC2AhagnvFl0cZNdiom6J69mjhFXXa6Ao8Ab0wqH7Bd
         xlt7YgWeviiutaqApkpOFe16Mf6Azj0Ri1+MbDM5UWI3XYNXHWdmvxdw1xJLuuBWyFXi
         eqTYzcIBioelV9GCqUVV9fBU4ktJmP4mgDyC28GJaNQNh0Rc61jwIrQDlbk3hjLB3idl
         S0x11DrK5pZmOq95ojKM1q54wyYI56BJjW1dcF5Iy8u65FG2d3j5jYCWjMf0fq0ujFhs
         NYj3erNsWgqkQq/NRyoz5qA0XQPuTZh2cda52bEsohhh0DVlwNkZ7a06CVS+TH7Ixc0w
         j5gw==
X-Gm-Message-State: AOAM532/qG97VfKVfiLFTMScGtaujiQsEFiAyLiv+EyUjsiJuwrJH/+m
        QAICQxkHvBtyoNwRIW68Hh4=
X-Google-Smtp-Source: ABdhPJwjzik6wZp1IbZVuQlewW36T4pD8s6w1ySamGx3xs1AzCYMJEDqKeGcXDUMXoG5w5q3HWJwuA==
X-Received: by 2002:a05:6512:118d:: with SMTP id g13mr2302001lfr.66.1638314661225;
        Tue, 30 Nov 2021 15:24:21 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:20 -0800 (PST)
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
Subject: [PATCH v16 27/40] media: staging: tegra-vde: Support generic power domain
Date:   Wed,  1 Dec 2021 02:23:34 +0300
Message-Id: <20211130232347.950-28-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently driver supports legacy power domain API, this patch adds generic
power domain support. This allows us to utilize a modern GENPD API for
newer device-trees.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/vde.c | 63 ++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
index ed4c1250b303..859f60a70904 100644
--- a/drivers/staging/media/tegra-vde/vde.c
+++ b/drivers/staging/media/tegra-vde/vde.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
+#include <soc/tegra/common.h>
 #include <soc/tegra/pmc.h>
 
 #include "uapi.h"
@@ -920,13 +921,17 @@ static __maybe_unused int tegra_vde_runtime_suspend(struct device *dev)
 	struct tegra_vde *vde = dev_get_drvdata(dev);
 	int err;
 
-	err = tegra_powergate_power_off(TEGRA_POWERGATE_VDEC);
-	if (err) {
-		dev_err(dev, "Failed to power down HW: %d\n", err);
-		return err;
+	if (!dev->pm_domain) {
+		err = tegra_powergate_power_off(TEGRA_POWERGATE_VDEC);
+		if (err) {
+			dev_err(dev, "Failed to power down HW: %d\n", err);
+			return err;
+		}
 	}
 
 	clk_disable_unprepare(vde->clk);
+	reset_control_release(vde->rst);
+	reset_control_release(vde->rst_mc);
 
 	return 0;
 }
@@ -936,14 +941,45 @@ static __maybe_unused int tegra_vde_runtime_resume(struct device *dev)
 	struct tegra_vde *vde = dev_get_drvdata(dev);
 	int err;
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_VDEC,
-						vde->clk, vde->rst);
+	err = reset_control_acquire(vde->rst_mc);
 	if (err) {
-		dev_err(dev, "Failed to power up HW : %d\n", err);
+		dev_err(dev, "Failed to acquire mc reset: %d\n", err);
 		return err;
 	}
 
+	err = reset_control_acquire(vde->rst);
+	if (err) {
+		dev_err(dev, "Failed to acquire reset: %d\n", err);
+		goto release_mc_reset;
+	}
+
+	if (!dev->pm_domain) {
+		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_VDEC,
+							vde->clk, vde->rst);
+		if (err) {
+			dev_err(dev, "Failed to power up HW : %d\n", err);
+			goto release_reset;
+		}
+	} else {
+		/*
+		 * tegra_powergate_sequence_power_up() leaves clocks enabled,
+		 * while GENPD not.
+		 */
+		err = clk_prepare_enable(vde->clk);
+		if (err) {
+			dev_err(dev, "Failed to enable clock: %d\n", err);
+			goto release_reset;
+		}
+	}
+
 	return 0;
+
+release_reset:
+	reset_control_release(vde->rst);
+release_mc_reset:
+	reset_control_release(vde->rst_mc);
+
+	return err;
 }
 
 static int tegra_vde_probe(struct platform_device *pdev)
@@ -1001,14 +1037,14 @@ static int tegra_vde_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	vde->rst = devm_reset_control_get(dev, NULL);
+	vde->rst = devm_reset_control_get_exclusive_released(dev, NULL);
 	if (IS_ERR(vde->rst)) {
 		err = PTR_ERR(vde->rst);
 		dev_err(dev, "Could not get VDE reset %d\n", err);
 		return err;
 	}
 
-	vde->rst_mc = devm_reset_control_get_optional(dev, "mc");
+	vde->rst_mc = devm_reset_control_get_optional_exclusive_released(dev, "mc");
 	if (IS_ERR(vde->rst_mc)) {
 		err = PTR_ERR(vde->rst_mc);
 		dev_err(dev, "Could not get MC reset %d\n", err);
@@ -1026,6 +1062,12 @@ static int tegra_vde_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = devm_tegra_core_dev_init_opp_table_common(dev);
+	if (err) {
+		dev_err(dev, "Could initialize OPP table %d\n", err);
+		return err;
+	}
+
 	vde->iram_pool = of_gen_pool_get(dev->of_node, "iram", 0);
 	if (!vde->iram_pool) {
 		dev_err(dev, "Could not get IRAM pool\n");
@@ -1133,8 +1175,7 @@ static void tegra_vde_shutdown(struct platform_device *pdev)
 	 * On some devices bootloader isn't ready to a power-gated VDE on
 	 * a warm-reboot, machine will hang in that case.
 	 */
-	if (pm_runtime_status_suspended(&pdev->dev))
-		tegra_vde_runtime_resume(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 }
 
 static __maybe_unused int tegra_vde_pm_suspend(struct device *dev)
-- 
2.33.1

