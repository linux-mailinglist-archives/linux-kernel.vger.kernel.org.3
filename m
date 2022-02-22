Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC504C0093
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiBVR5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiBVR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:57:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7300D387AB;
        Tue, 22 Feb 2022 09:56:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdrpz1Ou4w70wSl01T/Wv7GoRX6+RtIU8+vOxMRy3pcpKxidp4kx3M2JbuF3vGODZN+fIriaRrew1PYw49iEcbDg1SaKNh5th3n/mpmDCY+9IJQHbsOzDGipToZSTfRbST3/tU6r3KN4txlaIdYez+TYFYKr9sbjfSN67OynASSubMFQMU8tdOwaFGzAupdvVcicZDKtp2TJ6rBeYSo0G30a1P07GmOPilfxxYU+QflpDoRdCWFcGVU4/J4b/NcAm3snfxa4Sdd0XKhP7Wjrc7SJ4TBRPO15fsrFCoVcVckuEXWqxfSlKVJdtduipfYwr66FseVst5chwaNbPKEKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDZ+g4JwUvFFt4FupJdrfHr45S4ysMBiSXRHsRO7K8k=;
 b=f5GFaXi9m6AnRJ2jY+40dLbAj+5rkyOAGmRh1n9wcZi+sBENKUG8wK48OhmnVCu34rsve0PH2GIK83jf6DXQOlRhHwvwR+9CUQIPpXIc9nxUPydXfwuaVHS9Ah3CL3nh6hyzXa4uL5QJjzd6qs//hyEADwOxcsAX068x9HRDCZJjnSEh+n/lotxCmHINBVju/qfWhqjo9AutKyYqBOEqqM/4uGkQLa+R6YM8pvykkYAO0APUGdST91HkrQdefuxARmU+rDN2dk9uB9xhIKhTcuvgotWodpLx4wN9Ev6CpFU1ZqE63PCoVloDykhFa8uVLQzjhcbtJs+C8mKRwis/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDZ+g4JwUvFFt4FupJdrfHr45S4ysMBiSXRHsRO7K8k=;
 b=Ig86NqTM2iH94jMb37NKiebvky3agh6b6PCQKvLqMFfKt1GRKvbYRguW6c82aR66b9aXb1816CAtjlRFUyH0e72DKG0w9BzdYQYS4BWqr7c2146fz+m0wSSFclQQVU2h0ytXedOvawnEgsDZOKwayLn5714X12sOUPP06SeyFrVDp9t5Rx30Y439vTtmkMFX3eUaE5VTB8bGKfa2PFWmef8Mp1tcGRZR0LivSteZoILly1gn/3J2NkdeiXr9XMD6u9ZESgt0HzNag0x5v2MLytM/Ak31yjJke5iEgdHz9Fagm9uxIVh2ftmdzuqePoC7AFaZAyS2gRvDOP7+0ReM1A==
Received: from MWHPR2201CA0059.namprd22.prod.outlook.com
 (2603:10b6:301:16::33) by CH2PR12MB4055.namprd12.prod.outlook.com
 (2603:10b6:610:78::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 17:56:34 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::8a) by MWHPR2201CA0059.outlook.office365.com
 (2603:10b6:301:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Tue, 22 Feb 2022 17:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Tue, 22 Feb 2022 17:56:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Feb
 2022 17:56:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 09:56:31 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 22 Feb 2022 09:56:28 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v2 1/5] spi: tegra210-quad: use device_reset method
Date:   Tue, 22 Feb 2022 23:26:07 +0530
Message-ID: <20220222175611.58051-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222175611.58051-1-kyarlagadda@nvidia.com>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83c9db4d-0acb-43f0-3b8b-08d9f62ca99e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4055ABFE068017FF0B76FE82C33B9@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TP4xGLKFTyaN/K5GlxpUMLP9lRbsJv+LZu1Y6CDFT2YnNufQm78ylZva9ONsq4QVM8X4oe59NnZxaPOChSDRIeMVJ0JCHMNrlmiSV6L/JnmQT9b/rRjAYrsxR1vC5hiuSn+eXEpaSLKg3U5OY5MauBohAMC+/E0WXcLkSo4X8QkEPN2uskR9uJFpPj1llSm8nUnj3RFfdUT41dXy9lpYW/5iup5wkYLg9sOrfDro/QvFo/Ahk2tMwQ7txIGTyWxJwsFY61k0un6BqX6QQVDcsRJ3ZTxH78i53MdLlfOLp841mWHIPzwn+HpJhYr1EuLZkyeRFywUrzYRje9mOhdTK47OqBSyqbAsq86of6YvqzK0pG3JeY6WMuzeas+XPrlmdlEtuHAzOmLLsa2ePml160ojReY9eqJ92ZNr/UvHAZXwEv7iQW8G3UUnV4jl9MkNVWo5XQI3+J/BVmZf5u8TYmuQOdUHofvswNqAWylYf8MkStllFszz6+bIT4V2pPrX6I07aOh5qn+2bTpu7iBH6Aj9RaVELXTGSBg1El/mHpOxxueGCUmy8NgyqZMQ24p6wr5TsFXbk2V6sKLEcDcSCWy1BRqcSif2SPzZRmWhkFL8j2KLwid9qVNk5zcV9XBEBu5g59voSI/szU95g3EpwgRwliEMl97ci9WVDAgoZ8Vjow09ya5No7KS6E1taaC6IFsR9/xiL/ERpOQFxxv7oQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(26005)(36860700001)(70206006)(70586007)(2616005)(107886003)(7696005)(8676002)(508600001)(1076003)(316002)(110136005)(6666004)(86362001)(54906003)(82310400004)(356005)(81166007)(336012)(83380400001)(4326008)(47076005)(426003)(5660300002)(8936002)(2906002)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 17:56:33.3099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c9db4d-0acb-43f0-3b8b-08d9f62ca99e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_reset api to replace duplicate code in driver to call
reset_control_get api with reset handle.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index cb00ac2fc7d8..a353f2a9abd4 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -137,7 +137,6 @@ struct tegra_qspi {
 	spinlock_t				lock;
 
 	struct clk				*clk;
-	struct reset_control			*rst;
 	void __iomem				*base;
 	phys_addr_t				phys;
 	unsigned int				irq;
@@ -948,9 +947,8 @@ static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
 	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
 	tegra_qspi_dump_regs(tqspi);
 	tegra_qspi_flush_fifos(tqspi, true);
-	reset_control_assert(tqspi->rst);
-	udelay(2);
-	reset_control_deassert(tqspi->rst);
+	if (device_reset(tqspi->dev) < 0)
+		dev_warn_once(tqspi->dev, "device reset failed\n");
 }
 
 static void tegra_qspi_transfer_end(struct spi_device *spi)
@@ -1251,13 +1249,6 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	tqspi->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(tqspi->rst)) {
-		ret = PTR_ERR(tqspi->rst);
-		dev_err(&pdev->dev, "failed to get reset control: %d\n", ret);
-		return ret;
-	}
-
 	tqspi->max_buf_size = QSPI_FIFO_DEPTH << 2;
 	tqspi->dma_buf_size = DEFAULT_QSPI_DMA_BUF_LEN;
 
@@ -1279,9 +1270,8 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 		goto exit_pm_disable;
 	}
 
-	reset_control_assert(tqspi->rst);
-	udelay(2);
-	reset_control_deassert(tqspi->rst);
+	if (device_reset(tqspi->dev) < 0)
+		dev_warn_once(tqspi->dev, "device reset failed\n");
 
 	tqspi->def_command1_reg = QSPI_M_S | QSPI_CS_SW_HW |  QSPI_CS_SW_VAL;
 	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
-- 
2.17.1

