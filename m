Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0097C4A97CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357308AbiBDKaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:30:08 -0500
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:41426
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351410AbiBDKaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:30:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZQRfrvwYhQq8yZBXG1605j6FRDTCo8Nz3sIZdR4BI2rqgvWhVUVi54lqtL/wx794B3MPeikWfN2ZcwRJkr4izC4WrJTPiJscNM74ZhFFVah48t1mVUeAgpIISCkyCASkL+RbhbadpLO+FmQa05sKR5CUvgjlkpk528VTA5wKC8O2GhvHuR0dxRD5ieJu4RbiQNaOUaTvVgBlQlsy1BpIPK1B+/pTJevH4N9qaGfbijGrdnhmdWOxejTkaGeaMUVxEe8G7p3utEZ4hg7mJdJM6xaThoGJZ16xw3JXfJHui8fhgXHqbtVFdbZcfoSAD8bUNPAadUHZFZ3h+lshBpVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUQf8IblCJ+Pa2FEoFENqD+0YNJ2N/b82T9uDK/G8Oc=;
 b=Zp3h/8ny1qfjQK/mwOrPTcDcXpflgtIzY8UDXUSkERPqNYWDHCwwe0lH8WwNBcf9E9NFBaWTsoHjRMReyfLswTKo1eHq29pC4Zcq4510NtykzqwIleizkSPGrECTsEtplzzEZrK9NPquweAO7N6W9fV/vMIuqO8flfifNzgTcQI/FGHPOQbUiggzqStHYlBO5AQctTBSnYg0ckXYYbIdB9g6o1LIppjT2S4oXz8LcsfFEB8/EuQYwzX3AFXWzWjjVa/t38icjppbH9Mx8ceMDpeGrV6Etmlcfx7Imv3P0fgQS9/ZQfoTmk/0/HldOik38VKGXyPVSjLtem+vX95U5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUQf8IblCJ+Pa2FEoFENqD+0YNJ2N/b82T9uDK/G8Oc=;
 b=ZXuMtL42zM0myZfp6tGfz4V20N5ow/ErhR0YeFR5bLb6DO1RbUEXK8ojsyoP1p6TXm/LK9l+wv428UzLD4uj8jrEUPUhfOM2WlXSAMlU2kykRqVM/Q5Bv3wEjP8QPZdEVsONb/Hu+fVuxUiH6pcz4iDOidbU53/xgB80USXECCaoLYm+q7NfZJf4WNsfrbpV5BoiuVUlE3mWdx5qO2XX4C1wWUCAmyFJNuPEfaHCQTSLSCmSvAEecqm8UYRpE7GatOycYArYJCewqD+sL8vtzOaBRjTcOD3wmXldOfIT2nHD0yJSu0R8eW04zJPFwZFNLaggUQz9QuOqNGn58fyQrQ==
Received: from BN1PR14CA0008.namprd14.prod.outlook.com (2603:10b6:408:e3::13)
 by BN6PR12MB1378.namprd12.prod.outlook.com (2603:10b6:404:1e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 10:30:02 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::56) by BN1PR14CA0008.outlook.office365.com
 (2603:10b6:408:e3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 10:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 10:30:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 10:29:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 4 Feb 2022
 02:29:58 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 4 Feb 2022 02:29:55 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 1/6] spi: tegra210-quad: use device_reset method
Date:   Fri, 4 Feb 2022 15:59:31 +0530
Message-ID: <1643970576-31503-2-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07a09475-0867-44f9-880d-08d9e7c94d24
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13782C8D1A0C24976177DF4AC3299@BN6PR12MB1378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1e2U3ZBnLVGj9z+E+FNB8Qm8jCDOd3U+7ieLSaZpjCzedODPsLI6nAtJdcHKT9v49v5VwPIjUq0xw/MpRBPLa7vlleY1MpnL9pq6B1mpHU5eI1U2HQTG2IyEDRuUl/pbSkoZwk3h10VBUjUAnKDq6bEKjOgpVzijFSkQi0z6dIVtD9P6Acd2A5BTgbkXuhkZ7IkbLIU4xgCSaYfcVwnosMFPZI66ZtF1wXmtuOoQy46xc9F4L2cudYiFtD9iuw1kp2SU90j8hDt/xD6nQ+h1kqUpqX0UmLEtR6Q1fvlilJIOcBdCUbcN15lBf42I5roVq4H7TNQMnB4OvTpc7EF6qa3CRdJvl8Rio9zdzAzQwM4M/cc0zj8llN6oJTDaS3BvrVuAI4MSVfg2llxqTk4eUGCVMGAMc71bCAuuq06DNyV/HhGygdasohpKHyODSwfCt+FzqHSbdeLazMIP+CiIB9cKTZYc7ISzb74NiclbKjqAQLtztjg1QTTg7Swn131+eHrSZH/O07ukdke+T/SfrYvJYgxr9xX6DV6SOIpgMgvUCvqaa4KIkTg+lvb0l7hY8M4sz9kThun425rbWgUQbXVCeYKLOJkX1/JPXyqrNTYNcZM359VMxaWhTnhD86WiUNY+HMZYFbNgeddrwKTLeZh0r3dUJnjhLNwO+IKIi8AUh2ImfBSaP0bP6GB0LMm6y2CsrQYeG83Z63b3TLRHw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(82310400004)(40460700003)(356005)(70206006)(8936002)(8676002)(4326008)(70586007)(316002)(110136005)(54906003)(81166007)(5660300002)(7696005)(107886003)(36860700001)(83380400001)(47076005)(508600001)(2616005)(6666004)(336012)(186003)(26005)(426003)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:30:01.6599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a09475-0867-44f9-880d-08d9e7c94d24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_reset api to replace duplicate code in driver to call
reset_control_get api with reset handle.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index ce1bdb4..ef93e40 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -137,7 +137,6 @@ struct tegra_qspi {
 	spinlock_t				lock;
 
 	struct clk				*clk;
-	struct reset_control			*rst;
 	void __iomem				*base;
 	phys_addr_t				phys;
 	unsigned int				irq;
@@ -948,9 +947,7 @@ static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
 	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
 	tegra_qspi_dump_regs(tqspi);
 	tegra_qspi_flush_fifos(tqspi, true);
-	reset_control_assert(tqspi->rst);
-	udelay(2);
-	reset_control_deassert(tqspi->rst);
+	device_reset(tqspi->dev);
 }
 
 static void tegra_qspi_transfer_end(struct spi_device *spi)
@@ -1249,13 +1246,6 @@ static int tegra_qspi_probe(struct platform_device *pdev)
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
 
@@ -1277,9 +1267,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 		goto exit_pm_disable;
 	}
 
-	reset_control_assert(tqspi->rst);
-	udelay(2);
-	reset_control_deassert(tqspi->rst);
+	device_reset(tqspi->dev);
 
 	tqspi->def_command1_reg = QSPI_M_S | QSPI_CS_SW_HW |  QSPI_CS_SW_VAL;
 	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
-- 
2.7.4

