Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A54664B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358338AbhLBNx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:53:29 -0500
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:25633
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237001AbhLBNxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:53:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwgmCkgmbN0DpGCEmtCrDlaZ3lfPNyfv22bjSYkXzMPPGurSb8BOBaDZ5EF6K1MbVtCLMVEEHsOpjnabD9R8TMZnIdypm9yM9sGpJzxxiE2gMQyHX3jQoVItKxSQjrybL4q6XWW+kySKhGqs/FjK4dVuxqFx7nB4LlopiXzmfvyQjj93YOsF1prls8CcqoXdzo975mtqTyarydXuxzVy05/UjBI+EWgjJ/7FCUADNukl5ykOYwHDyZ9zzrX5yTPI+vL+dZ0crJdZ531Y3A1+DtFCEZ7yytBaWajwOv5muGzvjgZcwV33A0gQrMrxWDVF2pQzK9346t42OYUajp39yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDAmaJPXuYyjLoauYEyuDfYDiDkshJH1ivCsxmjP6iQ=;
 b=BhF9f37bqP1U929zv41cCe9mB3RVYB82pMnlv58BkOy2NaljqbaPc8KxrvVwEbvN8h7c73D1G18i8P88A/bFbzVE14TtQg0h9PvvpPiWUXIOHFQslpmQm4TH+e1v+oO+1F2Qg8bKGeqZGJ/zRXyeDJ/0O37hBj0OZN2Vj7V+yfArPEZBgrnfLP/R5o+xB07M3LvE2vsvZ+wdWMevU7JSRMjPm0fFipyHK4Hw08e3DQmVHxMDDqeX21G80pvpMwv+oqKdR8Fzo2u6dhxk3klJnFOsHV/Y9nWslPTX23kXhgWrVajnlaiC/mjcUpxjVLGqfSPF/0k4lOj4IN/DKTN+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDAmaJPXuYyjLoauYEyuDfYDiDkshJH1ivCsxmjP6iQ=;
 b=G5gr4+686Ich4a6uKMXWKmEkMQuSTpQXUYBTLsJpVRcJig2C2WDHwcLug98NClGttnVCHpk+QayutHfmiDzrVAO9vMKgPcKHi8vf/XeucweWm9FLNXBItynjHVIvfhBR0ObdsmzrJRpKrDMaKTDt1sPn04MDwyHkHOwWdeakmvEhoe9ayl6dnwZ4PB1Wjtdcnxsocn0M8hok3MYEGR0wZhHA9Dn0asOtX+4qwOdkvG3Ci2dRKqx+NeAEf7SqHiUm909uJntyljA2sXg5Y/aGxfrHOrEY+kpydRNGa9SHFF15RV94v58I62xydTMSHbSycEKCgpMJGR+NsG350zbdSg==
Received: from BN8PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:70::43)
 by MWHPR12MB1680.namprd12.prod.outlook.com (2603:10b6:301:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 13:50:00 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::21) by BN8PR04CA0030.outlook.office365.com
 (2603:10b6:408:70::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Thu, 2 Dec 2021 13:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 13:49:57 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 2 Dec
 2021 13:49:55 +0000
Received: from pshete-ubuntu.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 2 Dec 2021 13:49:52 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pshete@nvidia.com>, <anrao@nvidia.com>, <smangipudi@nvidia.com>
Subject: [PATCH v2] mmc: sdhci-tegra: Fix switch to HS400ES mode
Date:   Thu, 2 Dec 2021 19:19:48 +0530
Message-ID: <20211202134948.18448-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <0a8368f9-8ca2-f01b-2f9e-0c91e3b946f5@intel.com>
References: <0a8368f9-8ca2-f01b-2f9e-0c91e3b946f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2767baa1-dee4-4dbf-45e4-08d9b59aa0ec
X-MS-TrafficTypeDiagnostic: MWHPR12MB1680:
X-Microsoft-Antispam-PRVS: <MWHPR12MB168004728AE10A7F0E2EE23EB7699@MWHPR12MB1680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJzJ27hBFZO4rgA6ttnKLD4YZFuXmtKWo4GlQHqhdI4a/hHfV8MRMa1YrF+gJOJ1hLvLXs49CD/El2Y3mKezqwueI1Kr+SZKqujAkUhUmkjpHqZzZajIR1O/O6UFs+dfkIW9ZxkXoD6AILToW+fmsS65FGUDYuymNAOK/fJbtwfk/yaJcJBVOrsjiykwFLE4QRjtgOvr/OjVuIUElPRtjVmE8CjT2TLJrqbvoN7c9vf/vt17vRGksFoNeF8VcLVa+X4waVHwPkmSoY15p07qeCNFVgdM5eHMJgFtrmEJCmgVmpfU228HPATsr8q/GLyeZcgZJvsG9DPSG3MAxcHidznoV4dJ2lzZ5tYvQLUeGQ/k82WTKtLsn7Jp3e/8UolZR/2k28rEAu64Oxnj5OybBS2E5rLNycty+QnzPqKmjhjG7QTZdqV1ovWhwEyw+V4NBMio57m1FR2+X/4sRhK3K7Km4D4+rdozMWA18/AYY1viGi5YG1/68Kc7hFJRvc8iKE+v/h4MZTij+Z2f2kumvL95HgabXERq/eZRdkh1dY7//cMlCGQhonwWFCdXoj98Aqwnn7uKlR8pIhCaeWCmWiP0RSZCeK8DYo+H0UK15aRy9BB9ZqgKI8Nr0JjMOjOHJruLZ45XQDE+Df1h5LtcEjKVRwZ/PFeBzsGFGhXtYisqetjkzUovBVzkbu1c0zq31ppNX0BJUF2GJlHja11vGBBto6AD6dqvlVBb/A7V1E8yu1XzWjhROtTTE4o3orewl3CGfv/GCX9Zfe+hg8E35Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(6666004)(8676002)(356005)(54906003)(2616005)(86362001)(82310400004)(1076003)(36860700001)(5660300002)(110136005)(186003)(36756003)(7696005)(316002)(70206006)(107886003)(83380400001)(508600001)(26005)(47076005)(8936002)(2906002)(4326008)(426003)(7636003)(336012)(40460700001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 13:49:57.7304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2767baa1-dee4-4dbf-45e4-08d9b59aa0ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1680
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CMD13 is sent after switching to HS400ES mode, the bus
is operating at either MMC_HIGH_26_MAX_DTR or MMC_HIGH_52_MAX_DTR.
To meet Tegra SDHCI requirement at HS400ES mode, force SDHCI
interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
controller CAR clock and the interface clock are rate matched.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 43 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 387ce9cdbd7c..ca261cce9b37 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -354,23 +354,6 @@ static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
 	}
 }
 
-static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
-					      struct mmc_ios *ios)
-{
-	struct sdhci_host *host = mmc_priv(mmc);
-	u32 val;
-
-	val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
-
-	if (ios->enhanced_strobe)
-		val |= SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
-	else
-		val &= ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
-
-	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
-
-}
-
 static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -791,6 +774,32 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
+static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
+					      struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 val;
+
+	val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
+
+	if (ios->enhanced_strobe)
+		val |= SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
+	else
+		val &= ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
+
+	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
+
+	/*
+	 * When CMD13 is sent from mmc_select_hs400es() after
+	 * switching to HS400ES mode, the bus is operating at
+	 * either MMC_HIGH_26_MAX_DTR or MMC_HIGH_52_MAX_DTR.
+	 * To meet Tegra SDHCI requirement at HS400ES mode, force SDHCI
+	 * interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
+	 * controller CAR clock and the interface clock are rate matched.
+	 */
+	tegra_sdhci_set_clock(host, MMC_HS200_MAX_DTR);
+}
+
 static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-- 
2.17.1

