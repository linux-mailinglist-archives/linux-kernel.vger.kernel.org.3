Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809504BB901
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiBRMSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:18:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiBRMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:18:23 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226ED294FCC;
        Fri, 18 Feb 2022 04:18:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/DIs9ZdmQjc5veV7echyMVS0G3ZDwACgFRdB+W+T4N0HuHvUi/YD1jT2iVgzYzwiMOh3glcW90wGT+1DHmWOUA/hTOkIkqxRbOv338yUK9Av5+qP1ogOJP6AAqeiLjGDIpneMwshpxvqt7NEs3veBttNaBYjzSZQ8eLyUchLa7DVDo1yWIdufAuWE9zi4A2I5x3PXU8LtBha/mPCCBtBWpwvUGtkJhEN/5gxC6OHn920IVeOL/7e8Vc8ROWnokMXqT2rpKct4bSc86CT0mlP1d01X+tofaNQ3EGMW/yhjhsfeW1e7x4btGZU3NrOopK/PB5vaOueElo4KlDq1kfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjNndLZ7oDcnGiZ6yBpPbJ50crBgvrrghGer3OqGcHk=;
 b=k2HO+CoXZ7Gl2aW2hH/3ScRUmzTLrOnWWZVKLfksatrdZMCi9eYFZmpNcdDvUd40F4imaDb2h2dIY8DDhJ6PrEskQrdbg2AKuj819qBzLB+SB3BY2Z4UeE6Aegg0C9Ex7F4BklIUH9etb86cFh1RtVma+YsCOm/zeJU26mCCGnk5Yz3FC2kV8QRbU9CGLuFXzBl8FDQ/QosYaWgW6/RBfcYZnj8rAK9dBOUWn3I5dro56Uz/KUZU7Kfkx2DEbKqaaFtxq9o//WyZbr6roSsiFbetzhpcxNrFFmp8iRCZgwa8b/xc3WmZDLnjEZITEW9L3zzeaw7gSSllu0BmWcK16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjNndLZ7oDcnGiZ6yBpPbJ50crBgvrrghGer3OqGcHk=;
 b=jll7ZC1xWASlO4MWArN1IQqfPRKQBBnpc+Vw2NX8eRaiHXH/kihL8EsXQnVjeoAnr9c27QTzOEkQHzL+pujIVMswqVLIyJSCNI2iRi6XEbgTa8Db0ApLNH6DnXXOI8znyajf4DQdRTaCA73AtL1+INIgPv4Iaz4tjF3xPWDAmV0GG5uE2zI/51Ij9yhvyEyWzcU/oTsElwodpd/eiv5Gsx4kobXbb/WCf5nncxtK46P0P0MAwKnn1DOo5rhJcdRSR+CF3kR/tfTBu1qIeVICuI48U/VJ191cwW4QGbZmtTz1sA9giH1Q6wRlbQH0YQ+gtf6NI+u5+BIsoIr+afzycQ==
Received: from BN0PR04CA0086.namprd04.prod.outlook.com (2603:10b6:408:ea::31)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 18 Feb
 2022 12:18:03 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::96) by BN0PR04CA0086.outlook.office365.com
 (2603:10b6:408:ea::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 12:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 12:18:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 18 Feb
 2022 12:17:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 18 Feb 2022
 04:17:57 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.9 via Frontend Transport; Fri, 18 Feb
 2022 04:17:55 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <krzysztof.kozlowski@canonical.com>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] memory: tegra: Add APE memory clients for Tegra234
Date:   Fri, 18 Feb 2022 17:46:29 +0530
Message-ID: <1645186589-25118-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d21ef22-4c14-4224-8a0d-08d9f2d8b54e
X-MS-TrafficTypeDiagnostic: PH0PR12MB5629:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB56290EA36F4781A1C089AF9DA7379@PH0PR12MB5629.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsjL/ZfmqdA+VAKp69HwEHI5xQqnwb7cvFHI2lMcTTf8g9ZkfNW8neMhlHB67UFpdScskcDdV3XX8uqrNFFIo3s0SrO2NBr6Q/Ouk5jvksTcSi8p4XN4vUY/+uY7A2+falIw40SWvFX91Ij6U/gv7yD0siFAt4exabFC3GDRSu9Jk5Rr5BUMLEL5xP/U7FcFCuuKzCI4B0VXibIiafB7iR5ePL9O9pspTTCUvsGoCSYfrYq992vmoEvEJGrvSkfuP9O6+8pvUbKMX4/cm4yfLnyOrsimu73fP0e7JQQX40f1XAkMhxnZl16ruGFR5vHZsl5xyO5rQB6uly25N7PbuGQQDhNhlMyWm2COZLdjKc1sSsuhFxy3B2WdfT3PU3wuvKTNHuHx52iwBfSEHj3xNA+vqi6BavCWkXzHl4aQksCLx7PbLLp1txrv4EXH2dJ614OLpeghQ3mfvN1oWK1n+GvH8pdrVXSbHgoCK/wfDXg1OjMukFK1ouKzXJCZ5aPgrKmATeSiQ3Zypzqk0wrl/zNRIWoGzH/BihLRru+X9Jt2FA6G8eQG9Jam47eFKvgfN+pYLaFvn8r90TyBmu0sWGymselpVz0sBBbLIOkC/NZNpPLPshIUh+IepZYyEcitQDzqxD0Bk9K76VWBajJ6wu+KJV6ihUN7rdZct+ryks6oj+8r+N8iwucL5z0Iezu7A19gTW/9GWoUKEKyrZRSuy+TQVM1BX3HvCbd/Lbgtbedc4AdNZM9vJ+ao42yT/JQgi5yWOh1GLGYaKCiXxi9iIVgnPNhVPXxA1jY1xfkl7g=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(63350400001)(47076005)(83380400001)(107886003)(5660300002)(86362001)(966005)(508600001)(6666004)(63370400001)(36756003)(36860700001)(2906002)(4326008)(336012)(426003)(356005)(186003)(70206006)(8676002)(81166007)(316002)(70586007)(54906003)(110136005)(26005)(2616005)(7696005)(82310400004)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 12:18:01.6441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d21ef22-4c14-4224-8a0d-08d9f2d8b54e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the memory clients on Tegra234 which are needed for APE
DMA to properly use the SMMU.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 Please note that this patch depends on the DT binding patches of series
 https://patchwork.kernel.org/project/alsa-devel/list/?series=609494&state=*.
 So please consider this patch once Thierry picks up DT binding patches and
 provides ACK on this.

 drivers/memory/tegra/tegra234.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index f7b24ba..1d19cb9 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021 NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (C) 2021-2022, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <soc/tegra/mc.h>
@@ -170,6 +170,26 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x4b4,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_APEDMAR,
+		.name = "apedmar",
+		.sid = TEGRA234_SID_APE,
+		.regs = {
+			.sid = {
+				.override = 0x4f8,
+				.security = 0x4fc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_APEDMAW,
+		.name = "apedmaw",
+		.sid = TEGRA234_SID_APE,
+		.regs = {
+			.sid = {
+				.override = 0x500,
+				.security = 0x504,
+			},
+		},
 	},
 };
 
-- 
2.7.4

