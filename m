Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1248D1CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 06:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiAMFQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 00:16:39 -0500
Received: from mail-dm3nam07on2055.outbound.protection.outlook.com ([40.107.95.55]:52481
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229456AbiAMFQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 00:16:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMPcqX89KNdADipN1ac447bipO++AtQpbD+trmtaP67XtUzNphZEJ7qXOcQF5SmGv+AmmQqARgQAPiDQajzhlZXzKw/qk+AfQkr+PRcCwEbY+s1PZ9dzfSNKX81j2AacyU/LF94FJxBHx2QiKjQa/ug4m43M8TI6pUmfzJL1AKiqbPn5OEyuA//fqmhSJiojrdArKQnyEf5i4XqsDqTC5PYJGwdPl7uGvL3vZIMXbCj7ZOXKhZoFQMFiriqLdDfn1pFCpN3+N0Uia10kTBhh1bXY5QwthnnGlEeyFJj7/lhdilSMOkkq1PAMp7DpATijuFklNWH4ItzBNO92Ciyrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYJzpDGy59gUZm+amZ6ah1NV5iH+zT46nIXpxj1mxmw=;
 b=oPYWhy8fEv+hbt4770i5+x91/gkaXeeewNLCrw8BtP8D2uGH+RMn7XJSQQDBieEIjJqx5i7UbRKMfrNy+7MLNFlhP10qR6GxHRgZ7y1RvcnQXK18NPL2fK9OMzxyLcvo5rGq750yEKxy/ewyj6FbBBO3Ab3+KknQ2vzskEYf1nd4l1Kv8vZV/6RsyPE2U2Z7FCPBm3w4rMjbCBmbJU0y3xk2kEDD8y8K3jzW7skcdrK/E/13xwiRlav+VRvp9gVZJ0n3H/vyHKQIcOJJGqZE5x9zkNJzEMhTtmsWwK7zTGrozfK19Mh7yHRfS5tR56LpYhL5+3ohBWNm6MnECh/Z6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYJzpDGy59gUZm+amZ6ah1NV5iH+zT46nIXpxj1mxmw=;
 b=GLw/VGA0xNRkgfJF+AIGXklBf+xxe1+iu7VplIhxjgLn1VJi8zSxgkJ5P6YEJpj9J6rGBys6utzeb6ZbmKD+v7l+a7m80xIqN0iUT4CRlhY8k9sMNaIBARMgkzQIZQMqmnM1hjlDqe/efzn63g0LO/wyylLt4EnJvqqDGP+cg60xUUQf+Z3o8qmYzN15Ucp9UjaIFXBdsH68uRuQMtemfn9oAanTGWLOFoBDaioXKOQZb/sNijOlFO9V1qD77SvmDigE/cXvr/YgIjY+jf2W3/HVELS+c9aPIEDEMpDaTyYJxI653494lrEZt3XpKV0W7Di6GSFiuNrKM64Sr+m48g==
Received: from DM5PR19CA0003.namprd19.prod.outlook.com (2603:10b6:3:151::13)
 by BYAPR12MB2792.namprd12.prod.outlook.com (2603:10b6:a03:65::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 05:16:34 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::9f) by DM5PR19CA0003.outlook.office365.com
 (2603:10b6:3:151::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 05:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 05:16:34 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 13 Jan
 2022 05:16:32 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 13 Jan
 2022 05:16:32 +0000
Received: from anrao-ubunu.nvidia.com (10.127.8.13) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 13 Jan 2022 05:16:30 +0000
From:   Aniruddha Rao <anrao@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>
CC:     <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <anrao@nvidia.com>
Subject: [PATCH] mmc: tegra: Enable wake on SD card event
Date:   Thu, 13 Jan 2022 10:46:09 +0530
Message-ID: <1642050969-21152-1-git-send-email-anrao@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f69e3fc-7337-4a78-3ec9-08d9d653dde7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2792:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB279242CB0BF3910AC23ADF9CDB539@BYAPR12MB2792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdf3nVv+9HFb7v79IW7TGxfPTXxREC9O3PxerNr5f/H+RDyLyWd88TcpWpPPK0iDCKalKWsCv9HdniV9XDUjkcMXCw2ZAjblySprewlVtq9dZ4EELGXtUasvycjofr9ncstsElp7p6LTVho50Ffi7du83fzn/48bWY+orjk/HlPoN7u3UGbS+RCnaLlwwNnTkvjfcvU58zxb0ByST5oqgUAA51jyNVw3DLyYTlt1Ezi2h7LuHevCHEADHnIezPtX/l2cFmumlPDx0Y4l4bSIihAJD8E9gMjDyf5N7nES+4oAiY5VLTsvCW7H/afpysxoEdQgjduLtwmVyv+qg44UaM6AONeOqyuFxBzSWjjTMfH2bMBA5xSrblrjLBVHSusqAWT98NKyjYcn90j9BVyxQ1WSDMrALadhAvSjpDZfMlPIXE6l+7x/c7KCYhW16K0Oy+iacgMVZTDRW6QuNfoUv0ijEY9VMxM88iy/M3FvbUIi4RoD+XAguw3eJQxcSCeyH4IQmtltMohpKdLiXO67WLz58T7weapQyQ3a0hiHuCy2JcgNnHy5pKvYbN/okMUnRVd1jGxP9AgctYDiOoG8cFdxwLftdJIhaZNT6omJonUyza3d4Hpk/FYEAF4WvxNkaZcNzJvDBGZfRPX1H3WWaEvKKDICLe5MNcoeRAPfjP29VeLpG33wWfNjzbAeZHAZGvn4Tw9yzyBjoEyoEUL/hxdQ2Z4w3SfPoLPm/obLidmOGwgfo9Po4Y62xjzxq5edr/rxjSToRVIpeP0Z403wkDrAajQVLDk1e1GdAKdrWz0=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(86362001)(36756003)(508600001)(2906002)(186003)(40460700001)(2616005)(47076005)(107886003)(110136005)(8936002)(82310400004)(36860700001)(7696005)(54906003)(356005)(26005)(336012)(316002)(70206006)(6666004)(81166007)(83380400001)(8676002)(5660300002)(70586007)(426003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 05:16:34.1778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f69e3fc-7337-4a78-3ec9-08d9d653dde7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable GPIO wake source on SD card detect line.
Physical card insertion/removal event should wake the system
from suspend.

Signed-off-by: Aniruddha Rao <anrao@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 35ebba0..5c84bd5 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1673,6 +1673,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	/* HW busy detection is supported, but R1B responses are required. */
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
 
+	/* GPIO CD can be set as a wakeup source */
+	host->mmc->caps |= MMC_CAP_CD_WAKE;
+
 	tegra_sdhci_parse_dt(host);
 
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
@@ -1840,7 +1843,7 @@ static int sdhci_tegra_suspend(struct device *dev)
 		return ret;
 	}
 
-	return 0;
+	return mmc_gpio_set_cd_wake(host->mmc, true);
 }
 
 static int sdhci_tegra_resume(struct device *dev)
@@ -1848,6 +1851,10 @@ static int sdhci_tegra_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	int ret;
 
+	ret = mmc_gpio_set_cd_wake(host->mmc, false);
+	if (ret)
+		return ret;
+
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
-- 
2.7.4

