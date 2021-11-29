Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C3B4613B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377202AbhK2LQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:16:18 -0500
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:60000
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1377515AbhK2LOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:14:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3GTzH4MG7rEiun1CLRG6JfRGVjKSWsaqywFZxt07twlElK2Ji/ePry5WAqQk8tLApXB0cBVLOz76pMyTtgsLW5VwUP3b4uXTRzNAU8YlmytTsQFItFrBtSmCLMtsvK0HzdV6kAYq5xvTXd3RD/PgB4Dr8eoKU1RAiZq6koU2yn9r2hpCSark89fBUJUfDpvMESPfuYMvKrvV73qoz1ZWTCkvhk0lqm7ZW6tKNDKocvSbbDJ24fLfZyWSNUzR/SoJIztSyeBG5D3rSf3pRgZPr7xwRkd4wKK1O3YZg6O7rle/KTDi4HFMA1LMENTiul2Ku+yzAVyKd332Jsbz9tj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alyEU86dkOxvLx875lzJsYqt1M9oKg6gcUwO6YTfhtY=;
 b=TVA+FrpvHL3TuAYSPhSlkzuHZ2FIucneW7WhjWWpwhTpS3sl3qDNIhfIXo+xKHD5ryDvB5eTRpmM/Nq5uj0VskgQH3SzRau9VbauIas+r97P/7a8s/AW26ZvHFcdhHfUY9Qdg+OlMRsZqoe6Cml28q7DSAC7PZZoMFGZTZESE/7vNBUY0uT0ADbSYf8h0wixX59JumENFTSzxkEZI1WpmPkezeLGa1AIaJEKCuVnerv8yyG0S54uehR1q6WpqFfGFzh/PQEOEFVrEeV/qD34fxN80YsFeKvlEQLDZYRKYSkH5ZfJCRDPazBKE25M73SDf/+5Qz37fSFwsp+n/qpgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alyEU86dkOxvLx875lzJsYqt1M9oKg6gcUwO6YTfhtY=;
 b=AfeoFiYtGj26RscTGKpLnQ4w+SeTPuzI15qbpGM98o06IWn3z/l8/EDRqMRPGxTSuxb8S6+g01k7qMIlD0322MxgD+lNjbkAWLeVbzQVOlxhkZ8Y9sKxlkTVT8Kv4141ikMmzUt20qTiDSNYG25otOcYnh69tW2wXNU4j+t6T6ovw3y9zfzJm+cxJcT+bW7FoSjbX89dUPegYGr2OxoInAr9v152QqvBByoXMa/nMH5cOh0R0sdURY9yPwDVuU3DzzPUZzTOWCU5Qq4UhYPCuk3mqC3Dw7+uy5rlba87MWShSdnP07eQjhg6x+/b13tHXq8k8/RobC/T7nfefvhZRw==
Received: from MWHPR08CA0059.namprd08.prod.outlook.com (2603:10b6:300:c0::33)
 by BN8PR12MB2883.namprd12.prod.outlook.com (2603:10b6:408:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 11:10:57 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::39) by MWHPR08CA0059.outlook.office365.com
 (2603:10b6:300:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend
 Transport; Mon, 29 Nov 2021 11:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 11:10:57 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 29 Nov
 2021 11:10:56 +0000
Received: from pshete-ubuntu.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 29 Nov 2021 11:10:53 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pshete@nvidia.com>, <anrao@nvidia.com>
Subject: [PATCH] mmc: sdhci-tegra: Add support to enumerate in HS400ES mode
Date:   Mon, 29 Nov 2021 16:40:47 +0530
Message-ID: <20211129111047.5299-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7863385-f600-4c5c-c684-08d9b328eb2e
X-MS-TrafficTypeDiagnostic: BN8PR12MB2883:
X-Microsoft-Antispam-PRVS: <BN8PR12MB28833493DF2FF6F7F70D467FB7669@BN8PR12MB2883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUQlhObVwHqMgetAF47ZmGibG9pzekHPfmB9KCX8Yk8Hj3LAPJZtV8PAsemi0qKu/zAQqMM7U8txwpAfwE2q2ngzzcmwu7IC1h/21Fpb+H1Lz5gg2s1QdcZRwl1I9AcVK3iNEncgCOmRSHl/Klr1xtH2W7zGNThCF9pvFhBTndNIvGuWWohcQVYZAlz5loid6gu/xJgB6jQrDzvooDSy1lejMeONTAXkucaPpLziz2pKbivSmBdwFuDa45fjP0uXEoOBmuht9vpwTMz33e1439YYw8nuLp+Rb/CkcOPLo2cqdOc9VoGu55Ai+iS+Hujpazz7bYNcnK83AxQoWvwWW6npWuraOd9FGnRaAYRAQpcqRoiDaLnVq4zn90XaHcC8CHA6nOC5S2a3z3ldliElwTkN1Cr6m6dSY2ghL/xhthNu2SVDEjTQ4A+O/5//fEw/ySE91H78pVo87BLegJCeXTptScjFqcCkMpfXPV2BXA38fVlE4e1Ffcl4bQN7Y5r9IO5vPlXlJ5yyi3gLhu74+3t1iSdH2XWOftptbcZKMYK1bX+bxeKMo0WfWSi4ChfUMTtTtW6nZrTGwYkti29VCvsp/tHMVRZe6P7aqyTwI5CIrtKhnBtskmrDQC6sei8PgrgmZW8SuSLIV/F9Eqxd2o88cacxy2xg3JGETVxDcDyGP/BnVlZFE0wr9F5eDX/WC67cjBt879nmfcSbycdsoQ==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(2906002)(1076003)(83380400001)(5660300002)(8676002)(70586007)(426003)(336012)(107886003)(70206006)(6666004)(8936002)(110136005)(316002)(26005)(54906003)(86362001)(186003)(36860700001)(82310400004)(7696005)(7636003)(2616005)(4326008)(47076005)(356005)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 11:10:57.4241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7863385-f600-4c5c-c684-08d9b328eb2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2883
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CMD13 is sent after switching to HS400 mode, the bus
is operating at either MMC_HIGH_26_MAX_DTR or MMC_HIGH_52_MAX_DTR.
To meet Tegra SDHCI requirement at HS400 mode, force SDHCI
interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
controller CAR clock and the interface clock are rate matched.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 387ce9cdbd7c..d800396d1112 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -123,6 +123,8 @@
 					 SDHCI_TRNS_BLK_CNT_EN | \
 					 SDHCI_TRNS_DMA)
 
+static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
+
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
 	u64 dma_mask;
@@ -369,6 +371,16 @@ static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
 
 	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
 
+	/*
+	 * When CMD13 is sent after switching to HS400 mode, the bus
+	 * is operating at either MMC_HIGH_26_MAX_DTR or
+	 * MMC_HIGH_52_MAX_DTR.
+	 * To meet Tegra SDHCI requirement at HS400 mode, force SDHCI
+	 * interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
+	 * controller CAR clock and the interface clock are rate matched.
+	 */
+	tegra_sdhci_set_clock(host, MMC_HS200_MAX_DTR);
+
 }
 
 static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
-- 
2.17.1

