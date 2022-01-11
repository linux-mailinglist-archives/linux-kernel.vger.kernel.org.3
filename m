Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6648B605
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbiAKSqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:46:08 -0500
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:44673
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346160AbiAKSqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:46:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk2wKM1QZsDSNw3g+TPZFvnkESYderzCkX5Sgg+BLjJjjdBIk1br3xIF96KtgM+GoPTZdtXwr17p/tSDZLGn4YIcCsSI/Mffcr5pu9qOxMbZiQB0saFZxS8B45wwioKbxKt+ioamNkgBXpWq4HY4HO9Mzx3tf83vIK2KY/HHHZGFicg1YsXxLPIhKKvIqH20q6Z6wAtVAbR4nUAoJWcko7A6iNT2zaxi6pgaGCN/Att4Cprz6bAxuhjqNo46zt0HNuxUB6wXF204vKh/hwjqNH7r4CsuCFSBMXqBXBGi7Bvbrntwxbs98OUUYrg7D9ewzMdogo+toR1lDSmsfgC3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3etfX5PHnvTp0bk5bhFY+ysaRRd+/81Vf6iOcsuXZU=;
 b=MhoSq5Fge3A1SzkXoIQFl6fRcb+WF/77BTkdYZn189ey5Oc1kJDY2cZCU3Q4f0QfkhMq8lBrMflDFz298asRFyLaaAZu3VmaPaEdXcb+5ERyUT6gsQi++kYdWBw7VNsOu2a9HXqSYzJXr0lpLg1Wl13X8sTW5RUa3pPZ/msSzK++ao0prKauG6NEgBkUZO/V3PUKwC2oxXGZHIbQ4eOvbHnutS4XsGZi0N0qKC2HWF5KYLVn+YSmytGkMi6X9RL3PzL/zvKCndO2IEETmK6uiIlHRswa+jbAprbvER6rvtIVb5c5vroIIA0fSTMEw/8JjKMUM0r+sWTLOm3DeJvyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3etfX5PHnvTp0bk5bhFY+ysaRRd+/81Vf6iOcsuXZU=;
 b=pV/2CGd0jBg1sPNdpKetA0ICkS0zPSMS+R7uyCJI41drG3cOXsh/hr1WdoHsPnDiu2RhmE7QsfnKzc3jCt2REvO1XDTYuDgChmEGVsgg/938e3W22ytJBJrU2NrHlQwUKzGzgdemlvXezVPLJRBYA9Bpa/XTnEGaFh+YV+5okRFmvH+A3TecEFZTyzYML+hwgpl7jjJ0bRjyq2x/x1ngpmQ64eyoNP83PPMhGF3tQsXKXD12RwgM3v0tHaGSj0eOW+psxEJ8hqbyuGEjTXfsBjX9M+i3+hA6yufx2t01kzym9FoMoF5qGetYuexRABQvBFQ2p+vFKodO7ltxgNz0mQ==
Received: from DM6PR11CA0070.namprd11.prod.outlook.com (2603:10b6:5:14c::47)
 by MWHPR12MB1247.namprd12.prod.outlook.com (2603:10b6:300:10::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 18:46:04 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::72) by DM6PR11CA0070.outlook.office365.com
 (2603:10b6:5:14c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11 via Frontend
 Transport; Tue, 11 Jan 2022 18:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Tue, 11 Jan 2022 18:46:04 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 18:46:04 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 18:46:03 +0000
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 11 Jan 2022 18:46:01 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <amhetre@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
Subject: [Patch V1 2/4] memory: tegra: Add interrupt mask
Date:   Wed, 12 Jan 2022 00:15:48 +0530
Message-ID: <1641926750-27544-3-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23edda3a-0ddb-4bf5-275e-08d9d5329f4d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1247:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1247CEA957CCAE142BE7B041CA519@MWHPR12MB1247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +di7kRifh0w3+Q0WurfpyaseZsT6fGd7NkvjBGCYAIldPhqh0tY3pVykbM9CrCLgNPq5ysuLcxh8Y0p2Gb1femGewHelLe1LoZYmM40F6ASoR3vwJNb7Ps/J2OGxXrPSezH5Q4bZ6z/ijoZ1xvGqxbLBb+KpIIAco5lsI7T3FTA10UY6flYfieCG9PF2q3ICl+B8bphk/4867Apda5n8I6rz5rsm2Xn/EEN93K22phkuNRl6rWIGTgh4NmEwMI2Pky+n6cMpseFejlcDH2DPJMwlzpbXPj0ivLN5XJ3kYnh9KGj/G22jO0eksL3q8Nl470SB+SyeCkA0hvEYFC+fRPUaEjUPucHR9msQi7eAvjJpQ8qgWESl7b0r+dcbaV9JobhUwtoBB3HZcRxQGynT9WX165Ps99miHt20KyrZwCae0mMwbXlyuZx2/tMUs9Jo1A1hdddb0UGNQqV1EV1KVNtkP1wBV80vjuKZyBlkSO3lTApMLaOSKwGd0It2BWw8VN1Uq+IYt5m8b3oYvN0nozmQmSbfox5gT/9EhQdIs5UNGJGYYZOk+0XdMrIYqDzo9LX2CpeiMVDhOoQg4R30WGAMj20bsZjtLMsLPXugzm0W8rkOEl1u9evrZ4fk10dxoUlw95qakM+suokyqE4ZHUKpciamVxVUXvvtzzf2ayh7MSn9gpA6WEWN/X6Y2DVyC7T/sMyBHArvStFwTnbLPzuiPrMdyCtUPiFdMKaEmMs8W04oLMA3mPJ1W1hSSkJOaW3EVkOEVcjLBHQkoPO1E6q8OR2/ohI9y1sXlb90Fpk=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(70586007)(54906003)(508600001)(7696005)(2616005)(356005)(4326008)(81166007)(8936002)(110136005)(426003)(336012)(70206006)(83380400001)(36756003)(2906002)(26005)(40460700001)(5660300002)(316002)(82310400004)(47076005)(86362001)(107886003)(6666004)(8676002)(36860700001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:46:04.5944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23edda3a-0ddb-4bf5-275e-08d9d5329f4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1247
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt masks for all supported interrupts on tegra MCs.
Update interrupt mask value for T186 and T194 as per supported interrupts.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/mc.h       | 4 ++++
 drivers/memory/tegra/tegra186.c | 4 ++++
 drivers/memory/tegra/tegra194.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index f1fd457..2d4f495 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -44,6 +44,10 @@
 #define MC_TIMING_CONTROL_DBG				0xf8
 #define MC_TIMING_CONTROL				0xfc
 
+#define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
+#define MC_INT_WCAM_ERR					BIT(19)
+#define MC_INT_SCRUB_ECC_WR_ACK				BIT(18)
+#define MC_INT_DECERR_GENERALIZED_CARVEOUT		BIT(17)
 #define MC_INT_DECERR_MTS				BIT(16)
 #define MC_INT_SECERR_SEC				BIT(13)
 #define MC_INT_DECERR_VPR				BIT(12)
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index b548b6a..6766cc4 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -886,6 +886,10 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra186_mc_clients),
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
+	.intmask = MC_INT_WCAM_ERR | MC_INT_SCRUB_ECC_WR_ACK |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.ops = &tegra186_mc_ops,
 	.interrupt_ops = &tegra186_mc_interrupt_ops,
 };
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index 19f135f..76ba3da 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -1358,6 +1358,10 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra194_mc_clients),
 	.clients = tegra194_mc_clients,
 	.num_address_bits = 40,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY | MC_INT_WCAM_ERR |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.ops = &tegra186_mc_ops,
 	.interrupt_ops = &tegra194_mc_interrupt_ops,
 };
-- 
2.7.4

