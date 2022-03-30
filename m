Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32374EBC32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbiC3HzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbiC3Hyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:54:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB92183A;
        Wed, 30 Mar 2022 00:53:09 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22U7r5gg034959;
        Wed, 30 Mar 2022 02:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648626785;
        bh=Tt+jTSihAzqsDNSXeW3/IQ37PK8gBOxGiLfRX9jF/Gs=;
        h=From:To:CC:Subject:Date;
        b=YuECi8m8dOtxlQPFO4CYw5ARPMBvE+VT2YSt4mwq2D6ztFfbsgzePZAvUuTOT923U
         7t7DjKTi5bDEFqUbkJzKv2+PwFdBwQ5JCOMl1wrySIB12mytycvR92CugY3NlLv38o
         p6ZokNucSJVQodhxLnMVirJcv0+kHUsJY/w5pYMM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22U7r5oX007505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Mar 2022 02:53:05 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 30
 Mar 2022 02:53:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 30 Mar 2022 02:53:05 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22U7r2Gx117022;
        Wed, 30 Mar 2022 02:53:02 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] mmc: sdhci_am654: Add support for PM suspend/resume
Date:   Wed, 30 Mar 2022 13:22:55 +0530
Message-ID: <20220330075255.12127-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for suspend/resume and pm_runtime resume/suspend.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 204 ++++++++++++++++++++++++++++++---
 1 file changed, 191 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index e54fe24d47e7..e86df72dfd78 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -84,6 +84,7 @@
 #define DRIVER_STRENGTH_40_OHM	0x4
 
 #define CLOCK_TOO_SLOW_HZ	50000000
+#define SDHCI_AM654_AUTOSUSPEND_DELAY	100
 
 /* Command Queue Host Controller Interface Base address */
 #define SDHCI_AM654_CQE_BASE_ADDR 0x200
@@ -791,16 +792,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 
 	pltfm_host->clk = clk_xin;
 
-	/* Clocks are enabled using pm_runtime */
-	pm_runtime_enable(dev);
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret)
-		goto pm_runtime_disable;
-
 	base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(base)) {
 		ret = PTR_ERR(base);
-		goto pm_runtime_put;
+		goto err_pltfm_free;
 	}
 
 	sdhci_am654->base = devm_regmap_init_mmio(dev, base,
@@ -808,30 +803,42 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	if (IS_ERR(sdhci_am654->base)) {
 		dev_err(dev, "Failed to initialize regmap\n");
 		ret = PTR_ERR(sdhci_am654->base);
-		goto pm_runtime_put;
+		goto err_pltfm_free;
 	}
 
 	ret = sdhci_am654_get_of_property(pdev, sdhci_am654);
 	if (ret)
-		goto pm_runtime_put;
+		goto err_pltfm_free;
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
 		dev_err(dev, "parsing dt failed (%d)\n", ret);
-		goto pm_runtime_put;
+		goto err_pltfm_free;
 	}
 
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	clk_prepare_enable(pltfm_host->clk);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		goto clk_disable;
+
 	ret = sdhci_am654_init(host);
 	if (ret)
-		goto pm_runtime_put;
+		goto clk_disable;
 
+	/* Setting up autosuspend */
+	pm_runtime_set_autosuspend_delay(dev, SDHCI_AM654_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return 0;
 
-pm_runtime_put:
+clk_disable:
+	clk_disable_unprepare(pltfm_host->clk);
 	pm_runtime_put_sync(dev);
-pm_runtime_disable:
 	pm_runtime_disable(dev);
 err_pltfm_free:
 	sdhci_pltfm_free(pdev);
@@ -841,6 +848,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 static int sdhci_am654_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	int ret;
 
 	sdhci_remove_host(host, true);
@@ -848,16 +856,186 @@ static int sdhci_am654_remove(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	clk_disable_unprepare(pltfm_host->clk);
 	pm_runtime_disable(&pdev->dev);
 	sdhci_pltfm_free(pdev);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sdhci_am654_restore(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	u32 ctl_cfg_2 = 0;
+	u32 val;
+	int ret;
+
+	if (sdhci_am654->flags & DLL_CALIB) {
+		regmap_read(sdhci_am654->base, PHY_STAT1, &val);
+		if (~val & CALDONE_MASK) {
+			/* Calibrate IO lines */
+			regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
+					   PDB_MASK, PDB_MASK);
+			ret = regmap_read_poll_timeout(sdhci_am654->base,
+						       PHY_STAT1, val,
+						       val & CALDONE_MASK,
+						       1, 20);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Enable pins by setting IO mux to 0 */
+	if (sdhci_am654->flags & IOMUX_PRESENT)
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
+				   IOMUX_ENABLE_MASK, 0);
+
+	/* Set slot type based on SD or eMMC */
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
+
+	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
+			   ctl_cfg_2);
+
+	regmap_read(sdhci_am654->base, CTL_CFG_3, &val);
+	if (~val & TUNINGFORSDR50_MASK)
+		/* Enable tuning for SDR50 */
+		regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
+				   TUNINGFORSDR50_MASK);
 
 	return 0;
 }
 
+static int sdhci_am654_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
+	ret = cqhci_suspend(host->mmc);
+	if (ret)
+		return ret;
+
+	ret = sdhci_runtime_suspend_host(host);
+	if (ret)
+		return ret;
+
+	/* disable the clock */
+	clk_disable_unprepare(pltfm_host->clk);
+	return 0;
+}
+
+static int sdhci_am654_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	/* Enable the clock */
+	clk_prepare_enable(pltfm_host->clk);
+	ret = sdhci_am654_restore(host);
+	if (ret)
+		return ret;
+
+	ret = sdhci_runtime_resume_host(host, 0);
+	if (ret)
+		return ret;
+
+	ret = cqhci_resume(host->mmc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_am654_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	if (!host)
+		return 0;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
+
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
+	ret = cqhci_suspend(host->mmc);
+	if (ret)
+		return ret;
+
+	ret = sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_put_sync(dev);
+
+	/* disable the clock */
+	clk_disable_unprepare(pltfm_host->clk);
+
+	return 0;
+}
+
+static int sdhci_am654_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	if (!host)
+		return 0;
+
+	/* Enable the clock */
+	clk_prepare_enable(pltfm_host->clk);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto clk_unprepare;
+
+	ret = sdhci_am654_restore(host);
+	if (ret)
+		goto put;
+
+	ret = sdhci_resume_host(host);
+	if (ret)
+		goto put;
+
+	ret = cqhci_resume(host->mmc);
+	if (ret)
+		goto put;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return 0;
+
+put:
+	pm_runtime_put_sync(dev);
+clk_unprepare:
+	clk_disable_unprepare(pltfm_host->clk);
+	return ret;
+}
+#endif
+
+static const struct dev_pm_ops sdhci_am654_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_am654_suspend, sdhci_am654_resume)
+	.runtime_suspend = sdhci_am654_runtime_suspend,
+	.runtime_resume = sdhci_am654_runtime_resume,
+};
+
 static struct platform_driver sdhci_am654_driver = {
 	.driver = {
 		.name = "sdhci-am654",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = &sdhci_am654_dev_pm_ops,
 		.of_match_table = sdhci_am654_of_match,
 	},
 	.probe = sdhci_am654_probe,
-- 
2.17.1

