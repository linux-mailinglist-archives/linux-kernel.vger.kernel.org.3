Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E174A97DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357671AbiBDKbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:31:10 -0500
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com ([40.107.237.71]:1185
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234458AbiBDKbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:31:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ef+Bkqts1LGrlKFbkNT0qriR8upD3czkXvlo9j7HTVOsYzG45UxFdVlCGq7E1Aut1FSr6acCNE0bzBoNWPmwTbqhJIA+Q3eX3ocMaHjlmdUL1MHL/a40v+o5EkzVs0A/zZ/8GCtemzBVgrAlGpfZg8UZcwuyWo/3Mf5cP7IyUJtxE8gV6kXiRa3zChA3AbBkB1PHq1IT+U32nSl/jnyfMVNNFyRt0qNqDNq4u97SHP+0ICbbpaUpwaqS+a/0dEB8wpiSodsASWsfcHZMlSvAs1TFBumWD1JEV6CMl3OL7vzLWHzzKsKjh2JYxKZr6WHKGiaR7ToTqHJ8t4W8MoN5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTQBL31gW3bilk2wXMlm10E0vy05SBm3Qn7ePLaT90U=;
 b=J7mLL/W+ZdMoub5b044hUd1okIGGgf2gVI5m3gu2orsw03qcN98Q8SH1ZBEfXhYMdKEaV3ktYprTbmhd7FvkdMX4n2UPAoiAarGmv2zf6ezY6PNKDiqrvSwLjnD1xPpZgZdZ185h8N39mTbxfCOeP3jfYz852DMISfxf81t7ubK4jZRoNj2lu3+6OMZ8SOXlfHxK79WGydxS4DtgMaJPF6TzjGxWT2vA1JmVeTs/ffHf2Zbq7R9PsfvXZbcx3xY9PcWQaZVLIjrDbjlfaVoSFhOMYgUQTNb3E8ahNBT++UIoCj9h+ApZ+njltfsy2RwjwYrJyqocAIA3e13nrTpRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTQBL31gW3bilk2wXMlm10E0vy05SBm3Qn7ePLaT90U=;
 b=XDnM+zoJzTPy2czYGOCtTOOJQI4US8nSwow+SRHtnolEeWC+QnmM2oX7a+8NjBYTtpdEJnSY9w41O5na/cd/NTo6Sf4c/5ayb7MZPbqdieP6LBqMJ8X1N0U0VgYuuVFt4+2buYSpFFaViaKWdMOc0YXoewPmHoYfoJDNpm8FisCZW1xbWUenGK/wU3gwwCo/hT7Claxh+GOR/nGXGUj2F8yqnv9XLDhTAOFWFXvkVlDopQPBiATuhgaF/usICpfC3nRqkYjkKo6hHm7mpN85qR9z80hZJMs4mnmNH4c9d+PkCAgo2PcqEv0Yh21fLXIKdbgXt8S0liHfIJNTAfqTFQ==
Received: from BN6PR20CA0052.namprd20.prod.outlook.com (2603:10b6:404:151::14)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 10:31:07 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::7b) by BN6PR20CA0052.outlook.office365.com
 (2603:10b6:404:151::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Fri, 4 Feb 2022 10:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 10:31:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 10:30:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 4 Feb 2022
 02:30:03 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 4 Feb 2022 02:29:59 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 2/6] dt-bindings: spi: Tegra234 QUAD SPI compatible
Date:   Fri, 4 Feb 2022 15:59:32 +0530
Message-ID: <1643970576-31503-3-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9deb210-fb1f-4c42-99e5-08d9e7c973f2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB43535E8AF4512F9D9E7ABD2EC3299@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oiTcnei9Sr4B/qDcswvB7gY4cjYevEa4tfPMbnNZGJcVq1b3gBxU3+JQJlfwHPEz9wIOkbL1B8h7fFiLVfziBmALJmHXV+GaDvhJKGMpZM0HvuNBveCd2ZmLN16gqcGcisC3r54/SiUsCKB4DfrgyJxWXKlaAhALuNMff5vDBLKjisnk8XW5YMpFw+5bdiJQ1svAer//0a8B29ZoJbrOUTO7+uUwUY2HRFQXGJAOiA+qnLm9bFczUm7SC8DHFCKV/Bfa64vbEbMUrXSXcBDDBsphb3C/R4leDVtE1LwjSTR4J9Bnxt43IztUGPbhtmFioopy4RhekDFK+FK7CsrUgvIzXrSTstDWt9MmPH9Y3+6p+8wPwy2+2ooFQ1/c/umGfIzn+ly/Vxd/OtSqpilXrGstgZD9ZjyzlrqtHeBU++gfUtle3TkRxu0BLcCChJUVvi0pm6pHQyMJtJMco6VMUIuFouZClj3eQVe+UFGqj30+qDxr8mfMZcU016xAg/Zvfgy466N/KfgkWKzgUoydlxF56GmV4RGq3ntPi6B+8/JcFXVl0lIACfWoaU484kp+KYnKZBYm4SpLxCnIPrMDgEGHqvwegeP6n7s01b5ftDnVq7DZZs3boYnbmUaOrOujRZsn3qDBONfLX6JNd8chsCWQu/pMLLkRTbsVLz5NU97A+ihJp3sEOn5apcqjqhbvHwo4P4CsH0G6AscCKAQxQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(82310400004)(40460700003)(356005)(54906003)(70206006)(8936002)(8676002)(4326008)(70586007)(316002)(110136005)(81166007)(5660300002)(4744005)(7696005)(36860700001)(107886003)(47076005)(508600001)(2616005)(6666004)(186003)(26005)(336012)(426003)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:31:06.7638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9deb210-fb1f-4c42-99e5-08d9e7c973f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Tegra234 for Tegra QUAD SPI

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 35a8045..6efea89 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -19,6 +19,7 @@ properties:
       - nvidia,tegra210-qspi
       - nvidia,tegra186-qspi
       - nvidia,tegra194-qspi
+      - nvidia,tegra234-qspi
 
   reg:
     maxItems: 1
-- 
2.7.4

