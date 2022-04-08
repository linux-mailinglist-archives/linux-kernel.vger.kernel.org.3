Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF43B4F95FE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiDHMp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiDHMpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:45:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB854BED;
        Fri,  8 Apr 2022 05:43:50 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 238ChmtD010232;
        Fri, 8 Apr 2022 07:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649421828;
        bh=iKuxgrGVd+fv77/+E2WBc3gUiMuSjtK8VQeCFfZseVk=;
        h=From:To:CC:Subject:Date;
        b=nqtDDAQQCFkMKuocCdWqrEVUfQs82TbnFfyXLgcVz7zTPEx99wokxYBwlVkQ3iRsT
         i/ugJKHBLOBf7whvnIsLFvJOmUMD/peNbkBemaUGOT1UulEoNy9vT40vcmbEXkxulr
         R7ErJ6D0n4IbtfeSkxXDwzNCuzi6NQNRU6uUkyvA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 238Chmd0073708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Apr 2022 07:43:48 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Apr 2022 07:43:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Apr 2022 07:43:47 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 238Chi4q046976;
        Fri, 8 Apr 2022 07:43:45 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v2] mmc: sdhci_am654: Add support for PM suspend/resume
Date:   Fri, 8 Apr 2022 18:13:38 +0530
Message-ID: <20220408124338.27090-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for suspend/resume and pm_runtime resume/suspend.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Changes since v1:
- Removed System pm calls and used force_runtime_pm calls instead
- Added error handling at required places
- Added pm_runtime_sync call in the sdhci_am654_remove function
- Replaced pm_runtime_*_sync calls in probe with noidle and noresume
  calls
- Used MACRO SET_RUNTIME_PM_OPS to avoid build errors when CONFIG_PM
  is disabled

 drivers/mmc/host/sdhci_am654.c | 146 +++++++++++++++++++++++++++++----
 1 file changed, 132 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index e54fe24d47e7..131b2b9ae0e7 100644
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
@@ -808,31 +803,47 @@ static int sdhci_am654_probe(struct platform_device *pdev)
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
 
+	pm_runtime_get_noresume(dev);
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		goto pm_put;
+	pm_runtime_enable(dev);
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		goto pm_disable;
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
-	pm_runtime_put_sync(dev);
-pm_runtime_disable:
+clk_disable:
+	clk_disable_unprepare(pltfm_host->clk);
+pm_disable:
 	pm_runtime_disable(dev);
+pm_put:
+	pm_runtime_put_noidle(dev);
 err_pltfm_free:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -841,23 +852,130 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 static int sdhci_am654_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	int ret;
 
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		return ret;
+
 	sdhci_remove_host(host, true);
 	ret = pm_runtime_put_sync(&pdev->dev);
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
+
+	return 0;
+}
+
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
 	return 0;
 }
 
+static int sdhci_am654_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	/* Enable the clock */
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		return ret;
+
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
+static const struct dev_pm_ops sdhci_am654_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(sdhci_am654_runtime_suspend,
+			   sdhci_am654_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
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

