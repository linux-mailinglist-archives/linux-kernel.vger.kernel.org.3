Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4BB4B1FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347929AbiBKIEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:04:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbiBKIEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:04:32 -0500
X-Greylist: delayed 805 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 00:04:30 PST
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F391EBBF;
        Fri, 11 Feb 2022 00:04:30 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21B7p1S7008305;
        Fri, 11 Feb 2022 01:51:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644565861;
        bh=4A175SrgYxfzFi5K8Bg8FdyWFPWIpErDDlIkfHdh2j0=;
        h=From:To:CC:Subject:Date;
        b=pcuQtIkgco/ZAYWEFu8TW8TLi5M0CP0GeGenPqiOHZ9a2Vjs2LxRulLvPnOvMgc5T
         bI/sUQt2iELTTVA8CLne83rhxycDgvBA/xHfsbLoIrP5rFZrtzQ1vj4Xqvl6SX2NCk
         rCoUaa+K21zPMkWCCj1JDE8Ek66ppfS4jf0za+yk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21B7p17n092403
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Feb 2022 01:51:01 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 11
 Feb 2022 01:51:01 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 11 Feb 2022 01:51:01 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21B7ow0B042573;
        Fri, 11 Feb 2022 01:50:58 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: sdhci_am654: Fix the driver data of AM64 SoC
Date:   Fri, 11 Feb 2022 13:20:55 +0530
Message-ID: <20220211075056.26179-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMCSD IPs used in AM64 are the same as the ones used in J721E.
Therefore, fix this by using the driver data from J721E for AM64 too, for
both 8 and 4 bit instances.

Fixes: 754b7f2f7d2a ("mmc: sdhci_am654: Add Support for TI's AM64 SoC")
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f654afbe8e83..b4891bb26648 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -514,26 +514,6 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
 	.flags = IOMUX_PRESENT,
 };
 
-static const struct sdhci_pltfm_data sdhci_am64_8bit_pdata = {
-	.ops = &sdhci_j721e_8bit_ops,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
-};
-
-static const struct sdhci_am654_driver_data sdhci_am64_8bit_drvdata = {
-	.pdata = &sdhci_am64_8bit_pdata,
-	.flags = DLL_PRESENT | DLL_CALIB,
-};
-
-static const struct sdhci_pltfm_data sdhci_am64_4bit_pdata = {
-	.ops = &sdhci_j721e_4bit_ops,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
-};
-
-static const struct sdhci_am654_driver_data sdhci_am64_4bit_drvdata = {
-	.pdata = &sdhci_am64_4bit_pdata,
-	.flags = IOMUX_PRESENT,
-};
-
 static const struct soc_device_attribute sdhci_am654_devices[] = {
 	{ .family = "AM65X",
 	  .revision = "SR1.0",
@@ -759,11 +739,11 @@ static const struct of_device_id sdhci_am654_of_match[] = {
 	},
 	{
 		.compatible = "ti,am64-sdhci-8bit",
-		.data = &sdhci_am64_8bit_drvdata,
+		.data = &sdhci_j721e_8bit_drvdata,
 	},
 	{
 		.compatible = "ti,am64-sdhci-4bit",
-		.data = &sdhci_am64_4bit_drvdata,
+		.data = &sdhci_j721e_4bit_drvdata,
 	},
 	{ /* sentinel */ }
 };
-- 
2.17.1

