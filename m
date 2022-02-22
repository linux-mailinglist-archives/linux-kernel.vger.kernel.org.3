Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6814C009D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiBVR5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiBVR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:57:11 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4261B8F98F;
        Tue, 22 Feb 2022 09:56:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEQZd6Pz+txA0qjAeOlEYsVAbQV4Fq6+S6wTuYxSsegOTxfaqM6o5SASGVdtn4NWxrqr+/2zQ86OGX1vbRqL2yS6am6tI5EAbOwtP6Nv3khGRMyIoj/yT9iorlpCASA/2vROFugJB307urL0FpgzoWPi5Vjz7zYeg9MpqZi3xqsoILgXzmNT++GwL/p/wmM0mGkjbxI58tWNZvhBAMH7NbOXyPzqDDJiMVjcSdfB1XXJ90+GJEb+tVrtuJr+wym8YO5kQeVluaLGBobfE5OpdyqHUTfJM0/pq0tu1ZzO6g3BNUWISBkgcALxkOw0pDwNnxtr6IXbB7bYT0s5/tJWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wht70BcrxdIBDlDKsmgyJwTe/e3tGmikSz/aFLU3dAg=;
 b=K48UiOZCHmxkHQ5pf6cTjl1ew9RCQoTYHoCGiTwj5WJLEO+7b/VtIdex7onjAtvrV72KrBj8Ztg5XHiUpKCSL4GXcAHU/ZioXU+aFTjmfPjQPF7IWxTiiq2/wcpCoK+V4OK6Bi5JoR1H0F7d3tKDkKSjfTVxo70E7tQED5R+PXk0SWHizU3YFRP8Lr2ddi94ydnmBzHAVkJhJh0gx0qIxCjCK0taLtk0PBI4yh/69USSPT50Q0sThdHzS3GMLysO6by0qxDwRK+KihxrU5PuKwskZtrgGUMeT7T0sRfbcal+AhLFQfRNoCTOIRRXFrNSBRdDI/0TLygWtVXkzd5X0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wht70BcrxdIBDlDKsmgyJwTe/e3tGmikSz/aFLU3dAg=;
 b=BRwSOlVBTdw3JqQf6402lvBFj84LfR1gaP25fTLVOKqi67YjnXszc6h4ErehYmcXbYfEd4lsMQ3fu6Pz197Unhbcl0l9xxdgnJkc35GETLXdmE9XuvnRGbVBVKL+uaR5EUrlaXbKqM8h4LZJ8W/lLSqaj2wB/FVJsBq2bIyCZfwl2fLDfwggj/DWeBJ1ilpzbqckM+ls8ZK954rGh0msFD6vrT23CKMaZgBEMvSq9JvLtCrvONmU2gfGbAuAcZu4dXXy6l06hKsjXOImGw2siMhVIj9xdR67c/NIIQGQEMp9gow0zXAGxbW+pao+E+UfdMVnjt3spT0NA2fDnfvriw==
Received: from MWHPR22CA0012.namprd22.prod.outlook.com (2603:10b6:300:ef::22)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 17:56:41 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::f9) by MWHPR22CA0012.outlook.office365.com
 (2603:10b6:300:ef::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Tue, 22 Feb 2022 17:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Tue, 22 Feb 2022 17:56:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Feb
 2022 17:56:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 09:56:39 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 22 Feb 2022 09:56:36 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v2 3/5] spi: tegra210-quad: add new chips to compatible
Date:   Tue, 22 Feb 2022 23:26:09 +0530
Message-ID: <20220222175611.58051-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222175611.58051-1-kyarlagadda@nvidia.com>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b6d422-4ee5-431a-dbd5-08d9f62cae61
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB18670633659BF4876071D282C33B9@DM5PR12MB1867.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eH3dPuTqhwO23u7tAZa2fAdjRftYvem3x6W0XI2asU3w1Ob1B/PUBrMeKw3MwMMVAHdAzlR3je/Od3MoJuJBcU/dm6o+ybEiyq8n8RZbl/WJy7Kg4/ezWp6UQVI0+m3+9Ux0ndEV/qW+yc9NRUPJ0NhZ3jrRaYiMVI+1APGVN1WEfvINpLrSoXiP/psLEYA6jlrpGDShlWm2q7pNcFdl0zQ+K6L4a4I6Y0NqiaRXZVUsY9iRtUMjGz1uRs68OTSRIwWYtJb+ojMGUcYrd2aVkpaW1JokbOOI8oIRE+ArdxlDLv99/0zzTmMrRTBvgtVgp2DkcHci/yl6pM10OsZUphpaTGlbWMt9Ey0z+fKX9mC9KtAyM/CKEeuO9fELKR+pV3oGGC6y4ZKqlSdgzu4I0Ks4V+EAbEBBnPfLH2tik4NC+zaLhPgwatXhk8ePsSwUxrYo6Gs8g5IooYISM3LOWf+4MybbirH2ypbbrGehGAaEkUR68gdzML43f/NrgBhqYJMwlfOK0Fk19nYvamoWhrxnWqkl94oj1IitBkCol7HB+Yu9YwkdJlccC27pOj3VoY5K/BjgI66UG+GECC7r0v3bOLd/4q1uydhK9wyGdyd2H14NiZlhU/d7iaVG+X6kcT8hPc2SsG+167mdJ2UI9iL3Mno8UpkryJavYCJJsOXuy58thoP6r2Nw24bezx+2hHQmMtle/6SSWU8yjp/X/w==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(2906002)(36756003)(508600001)(107886003)(70586007)(356005)(83380400001)(8936002)(2616005)(81166007)(1076003)(40460700003)(26005)(186003)(426003)(47076005)(86362001)(7696005)(6666004)(336012)(316002)(82310400004)(8676002)(4326008)(36860700001)(110136005)(54906003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 17:56:41.2872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b6d422-4ee5-431a-dbd5-08d9f62cae61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Tegra234 and soc data to select capabilities.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index a353f2a9abd4..3725ee5331ae 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -125,6 +125,10 @@
 #define QSPI_DMA_TIMEOUT			(msecs_to_jiffies(1000))
 #define DEFAULT_QSPI_DMA_BUF_LEN		(64 * 1024)
 
+struct tegra_qspi_soc_data {
+	bool has_dma;
+};
+
 struct tegra_qspi_client_data {
 	int tx_clk_tap_delay;
 	int rx_clk_tap_delay;
@@ -184,6 +188,7 @@ struct tegra_qspi {
 	u32					*tx_dma_buf;
 	dma_addr_t				tx_dma_phys;
 	struct dma_async_tx_descriptor		*tx_dma_desc;
+	const struct tegra_qspi_soc_data	*soc_data;
 };
 
 static inline u32 tegra_qspi_readl(struct tegra_qspi *tqspi, unsigned long offset)
@@ -1191,10 +1196,32 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 	return handle_dma_based_xfer(tqspi);
 }
 
+static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
+	.has_dma = true,
+};
+
+static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
+	.has_dma = true,
+};
+
+static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
+	.has_dma = false,
+};
+
 static const struct of_device_id tegra_qspi_of_match[] = {
-	{ .compatible = "nvidia,tegra210-qspi", },
-	{ .compatible = "nvidia,tegra186-qspi", },
-	{ .compatible = "nvidia,tegra194-qspi", },
+	{
+		.compatible = "nvidia,tegra210-qspi",
+		.data	    = &tegra210_qspi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra186-qspi",
+		.data	    = &tegra186_qspi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra194-qspi",
+		.data	    = &tegra186_qspi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra234-qspi",
+		.data	    = &tegra234_qspi_soc_data,
+	},
 	{}
 };
 
-- 
2.17.1

