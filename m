Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119FF469810
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245556AbhLFOLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:11:48 -0500
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com ([40.107.244.51]:56513
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245505AbhLFOLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:11:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vrzp0wi4SCvJ+6CfIIL06hc93tUfj6GGBgpoIaF9Zc1VUCwZZXsxpqOnnaU0Uou3VD5ICYBhROBHQ6shfopoPYlsI0ve4m6C5N4QCGwdJ/zTj2AyJUHb4ZaxlpN8Ri4c/6EwxkiraO10m+Ieg2m9Jq+DjMgVl9Z6QhafIRlTKfq/zWSxtl9zdS6QSaMr4PrMzAKrJhupu9hzXq27lmR09zCXnnE5BflfGGHp8pVviao+hs+AZFKJFtEneKIsL0sxt86g6a6AQqyjhfIH1fCrXeigCtrgU1Re86KSYPR09X139Nm3/xCVYsamfxysn/iO36tXJYDM9wH0OJwB+fqqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woNyZCiC7JmxGyUsn8ZpV0UJnuw59WQypiTQV8Q9OHA=;
 b=NpvklaD5gL9TgdGsAgo6NfOuSztE2GAZ/QbhwYhDY3vVrAiD50foxpKmnfxfn42awxxH9EBGYl+eC6fTLCsiqZ9w0NYPYqSZOhmsSOZyX1bOGzAYBcpF0ltG7KJEBMRD/0geqfeTblspFus6dZEEv+BgcoXsrtJkmNKAjcTjNv3ssohrh8zoR5qGb/NrTwoRJoiyTP9eREztHigZ8JB4AEuJesV1IztyteX8U8tH6Wm6Xtfr6enFqixDG7fAkrldeFqakA69o7o+muSMHBRd5nexGtfXgVZoiqYVHgD2MF4qhNT7jqKeXA5ua9iQ2MdkvgDDVUtS59NBl4PZc31cmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woNyZCiC7JmxGyUsn8ZpV0UJnuw59WQypiTQV8Q9OHA=;
 b=ChxgV/NS32HQbF1DZ22KtIGPJiPFMQ5LKABjdnbw73C8avLKUyCblW44Oaa7zIbUSaFVf1dLLoMWUM8se8EoaVUl9cxFHgR2/mmJzszN7N4uGpjwci6kCgtK2JErstKCrNcZLqG7GmYUx6YULvdD3YYFa43tHAQjz5w/8XqK9btEV+flKoRIO9+nbDraob5FNKgXZnyXuCxrAkHg2YklC/U3vupIrRi2zT1xUrqznSHmcFejkP0d2AEp3EIv/q63owhEBMxGK2EvCY8fLHSDIZ0NjnM6X+HlaeggX7lnOFuL6WpKgtRC1gE02I/3+DJzW5ALwkOdZqouSlcPq/9Mpw==
Received: from BN9PR03CA0379.namprd03.prod.outlook.com (2603:10b6:408:f7::24)
 by BY5PR12MB3924.namprd12.prod.outlook.com (2603:10b6:a03:1af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Mon, 6 Dec
 2021 14:08:10 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::46) by BN9PR03CA0379.outlook.office365.com
 (2603:10b6:408:f7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Mon, 6 Dec 2021 14:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 14:07:10 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 6 Dec
 2021 14:05:47 +0000
Received: from pshete-ubuntu.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 6 Dec 2021 14:05:43 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pshete@nvidia.com>, <anrao@nvidia.com>, <smangipudi@nvidia.com>
Subject: [PATCH v3] mmc: sdhci-tegra: Fix switch to HS400ES mode
Date:   Mon, 6 Dec 2021 19:35:41 +0530
Message-ID: <20211206140541.17148-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bf629e1b-c61d-37e7-8802-b6d778f89c21@intel.com>
References: <bf629e1b-c61d-37e7-8802-b6d778f89c21@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a47afdad-65a5-49b6-4d16-08d9b8c1d5b2
X-MS-TrafficTypeDiagnostic: BY5PR12MB3924:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB392467AC5DB155FC7CEDDCFBB76D9@BY5PR12MB3924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDzgy/JzkvUPHMUORQnwf+r2NsuhQiJgMeQyPlEzzlubfkM+Z7MxcwAlr6n/PHzCNz29ccBi4N0qWsdJdJJiX/elVRXGa+7IRuLyNTdUt5bNxBjsxPgZ43jgh6wSQNmNsZq5fzA1dPxe5xIL+x8Cee8D/8mTFopwcHY0oEZunQOYVdhHOjcvta/+SfjdISLcUK4okUajuZyosHAC0nMU6CQexo8a1ZmicsJmVy569HVPZ8+tBI7f9rwuMMcxPOK+GYxSjGo4751lRVu/0FTbJv0S7VS9t33hnO8CZh1HiFvt3Q4vkJNO4yDxqb3itvYwJQouSCSX7jq8GepDg/R9SFjt8tTvXqinBhufrzHfx9/h6DSfHIBq9/vuN3/nhco7APtCG/EQrnNNhKYr2RnbNLke10fHu9nDvvoLjJ4WuW5c1aWC8wRGArOxHDHn6rTyyVaVRW+oPNenEUa98LuD3kZ4/9G/jpvmT4HQeKds80dkPXRsWjIs2CAwTRWlq+Ta21avG4yMXFNybQOh9pgJGPPICGALKo16c8+7Mc5qw5KhO12t4Oi8j3SWwq6KSL3NJlPpqwAHYTlww++uhNMfqQpilZop0nn3f9vrxhnU56IKEX4u1fA2FY4hzJW65LtSb+JQtYQ4EamTViR+130YPLY/KR14yuzONJU1/U6qefamvsrALpLXMMCJnQ7uEi6c4NevDyikOrfXXjbTiSgpcABqeGRd0uMiupb6ie4L01zdyl2OPQpxOrg9UoPl9/xRYNOfclbdm7DcgJ65xvX5BA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(47076005)(8936002)(107886003)(508600001)(26005)(36756003)(83380400001)(5660300002)(186003)(426003)(336012)(4326008)(110136005)(2616005)(7636003)(70586007)(70206006)(2906002)(40460700001)(7696005)(1076003)(356005)(86362001)(54906003)(82310400004)(8676002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 14:07:10.0438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47afdad-65a5-49b6-4d16-08d9b8c1d5b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3924
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
index 387ce9cdbd7c..ddaa3d9000f6 100644
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
+	/*
+	 * When CMD13 is sent from mmc_select_hs400es() after
+	 * switching to HS400ES mode, the bus is operating at
+	 * either MMC_HIGH_26_MAX_DTR or MMC_HIGH_52_MAX_DTR.
+	 * To meet Tegra SDHCI requirement at HS400ES mode, force SDHCI
+	 * interface clock to MMC_HS200_MAX_DTR (200 MHz) so that host
+	 * controller CAR clock and the interface clock are rate matched.
+	 */
+	tegra_sdhci_set_clock(host, MMC_HS200_MAX_DTR);
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

