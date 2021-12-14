Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30654474187
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhLNLgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:36:44 -0500
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:51937
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229723AbhLNLgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:36:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imVjAW7FFwC3oitNFeiVDrbIBL9rAt6ZK0VPpl9zZQHuemBOn/Sm/Wu6ZcybylRLHa5liz4bQZKiwa684FHwtAKklz6MomvjXW+vACapfnWyBGCDrQK+KHrnp9tclIraR2IvkhOpT0ihdc1odBpVbywtqOOmb8PKAjLhTBUhxAs38z/8Mam1R+iMH24rM1nOX7tzQLa7Lsf1gkRX0nSl2Lha0vWmfxAhIKDkGUeQEAvTQrnIpj7nJ6fnj2zJ4yAfdQa4T2aZx4cfDeFdOhXuxXUk0Bv9So4hr/L4vgnuTv5wtCiXwwNnIivl4khyBrMtZ9nMjp7ULVDoNF1NNlee6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmoH2vBu93IMGEPKc3CqptdyoIFBmfmHCXhH1Uss95c=;
 b=MFf44CeI44wyboG+t0j31QanGmTKYBJAT54o7TbbrsETx5gSX1mmz4pl0w2rV+VhNhVpWQu1p/dDJo8IKeeQ+W3U2GMFJG2dninmFY2ZDViSB5a4K3V5AWe4s9/YeT/tpc2gtXXBfhZUpWKw3046VVcNMNwCm90TCa3X3DuStekYYvXZkAYrsx/ImLAsGLWJWbw6msLXaxn6suTeOXynpxfprFOiQZo3UU2VC7RnhW4smWM4P/IAFYP9oGZVpTsyl9CDes0uzHPAE6zTOUxisrqKx+ud5S7T973RhgGI9g2ma3DQ80lUQzckqI8RjyHcK5N6q+mskd09HE8SsWcpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmoH2vBu93IMGEPKc3CqptdyoIFBmfmHCXhH1Uss95c=;
 b=AIZ6w55D/ZlZTEqCuM5cqIPLnrqVf+UlPN7x9XnhyC5rkwy7EFg0s2Pb9MNEoIcALj7LoOIVPmOvFrW4CuyrBmWmkUyviXewcvEbGqyZOoNmlHFAzVe0nh1qRSYOnyn7FbV/aYKn328iljJdLBDcJap9F6OVqRg8NLNJXT88KDp7vV323TQo31ZnIopLylMMTdHwySSh0l3xsQsXC2GHdtjE5iOXsM+TCfKKLm+6QCew9OHs5HKrLuG9R85oYXOBf3IfG66tZ5zgN7opvKoSz+PVKXRXkwiaKglLehRamYkCdNB9zeaFLRBLeIzYw0Kc76qwHlv/SFUrysa15oRi/g==
Received: from MWHPR10CA0020.namprd10.prod.outlook.com (2603:10b6:301::30) by
 MWHPR12MB1184.namprd12.prod.outlook.com (2603:10b6:300:f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Tue, 14 Dec 2021 11:36:41 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::5b) by MWHPR10CA0020.outlook.office365.com
 (2603:10b6:301::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Tue, 14 Dec 2021 11:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 11:36:40 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 14 Dec
 2021 11:36:38 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 14 Dec
 2021 11:36:37 +0000
Received: from pshete-ubuntu.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 14 Dec 2021 11:36:33 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pshete@nvidia.com>, <anrao@nvidia.com>, <smangipudi@nvidia.com>
Subject: [PATCH v4] mmc: sdhci-tegra: Fix switch to HS400ES mode
Date:   Tue, 14 Dec 2021 17:06:53 +0530
Message-ID: <20211214113653.4631-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3dd2473a-00ca-4c62-e17f-9392cf74cda4@intel.com>
References: <3dd2473a-00ca-4c62-e17f-9392cf74cda4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f9c7689-74c1-4c5e-3441-08d9bef5ff60
X-MS-TrafficTypeDiagnostic: MWHPR12MB1184:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1184A27CB4BB5584866EB234B7759@MWHPR12MB1184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Gq+c8GmXVIb1qDtu2mGNFHC1DzXz8VbX+M2yMeR+tYpIsMoAGmw3QmmoXjgIW7WbH4j0OSS/ZrmW1xag6kl80wVZ1L7QlFY8El6UG5UUL0ZpS00ABAk5KgLxkfBoPNvpIB3Z2PMWTbfdOkZ4Oke3XUSH5anJMwseyl5MePxtYZh85YqdoU9hjsAl9kqmG9FZCYyNfAzoUUfuL8bOj68XAUGE826quUJLixsBDQFElstKd014rU+LwyRQ5Jq25q+dUVNmx9FTb3O1MNsUdSJszxSSXQzGP88cMtRqBoc8RYM7YR80ftDNTiOqf+L/IYTH5WQUfS8pOo2Ju42V+svEEQjtaguPG0RhEz1n/8LBaDEXePHiagxYCpwBWQvNJGndWqAVCNrirJ0E5QVupbzywRy9XbdW6o9ru4bDFqGQSC/zKzC/SPqCKY+5jIY0lEMUUr7ETdTJugz+cc0Yjgk2vxqYp/G0i8QKeVN18C4zrqPZ7d6UznpSkRcb4nGQUzKZb31R3u0PypV1x9XSiol1QaTwsOm1AFPYLlEMHBDt1qrT8mak/9cjmT+m8Om/Rsy4uZ3ndujUx2ufWhna4IZriFXfPMOT7712112edxcWBWEA11/My0tM5SXS+xMj7K+G47hK1Yea0z4rNwyUYg76OD5gu8QmfvrW7Sz1l5xlXZoCqbjdbE1LzFPORRmXpjNBahHArJn7qtpPivubApgOc6tcvwJU6rkxHxFo0e4DJxuOvfEh1I+0u9A1J9/+adyasniFR57Ql+g6aX7it8YetgL3p2uZKY99Mze3Kz8Yl4=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(2906002)(26005)(2616005)(508600001)(356005)(7696005)(82310400004)(34020700004)(186003)(36756003)(40460700001)(5660300002)(107886003)(110136005)(426003)(4326008)(86362001)(8676002)(316002)(6666004)(54906003)(47076005)(1076003)(36860700001)(70586007)(83380400001)(7636003)(8936002)(70206006)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 11:36:40.6802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9c7689-74c1-4c5e-3441-08d9bef5ff60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1184
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
index 387ce9cdbd7c..7be6674eebd5 100644
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
+	if (ios->enhanced_strobe) {
+		val |= SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
+		/*
+		 * When CMD13 is sent from mmc_select_hs400es() after
+		 * switching to HS400ES mode, the bus is operating at
+		 * either MMC_HIGH_26_MAX_DTR or MMC_HIGH_52_MAX_DTR.
+		 * To meet Tegra SDHCI requirement at HS400ES mode, force SDHCI
+		 * interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
+		 * controller CAR clock and the interface clock are rate matched.
+		 */
+		tegra_sdhci_set_clock(host, MMC_HS200_MAX_DTR);
+	} else {
+		val &= ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
+	}
+
+	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
+}
+
 static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-- 
2.17.1

