Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779F84A97D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357829AbiBDKaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:30:24 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:39171
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351410AbiBDKaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:30:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhvD/8b08JvbJcGGZkLgRsow+tvjWvvAMf+Bs17xAj4tHVyImFr3rkzipFGLqS/0aJyosrJTcfLelsw+e8n5soZ+xmBQMaUcLOW24OzC5kz08fr83M8kgHfBWizEc93+1lMlCnHFA8k7JnoAKjRmTHoBJ5JvO7o7LwLE7xGbWyyH2x1epN8jpgkpyxzwjl4STfD5v9/2LKuY+1m69JEwdzkmg3WfpqCc8kRry39VbIr8Enz5Da+rLvkKt+TGjUf99zLa37KhuhR+apVvTPP7jkfhm48S0A1a/kEg5vp70eWb3SvtVs2e3Ls4n6HFbQMOOiOBqW/YkOJ7BBH3/SyAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxlFzwpLgj3M9Jj2RVS3E7GwjV3GdiKs+0bNh/Zo8R0=;
 b=La7wt0PxMMQXZmPzzlN1w/uBhvpRVgsdMAK891Ozk4voh0NroaZcCmm+qTPlzOVexz3SJReCdOdVlxleTccsFLRVoNg+7t58dcn9KoWd1g8XhfzjWZaeBgoHnjBBa2Y8Lj+4mzpSNSR6MRJMOuqnuBHtLodBIptVrrz06YkArL3ih7F+Aa07mbeVCAB9I2n+7pOrtcEqu2L0VFSrziRgIirmcfyk8ZVfYgrxU9p1OBg+9NpdSg4wOhSvVNPBeKAU1TnxSFrT/7tCDVz3eqW/hvqEilcaRWdVoP5b9/EuBytEGM/jHrpi+CWGEXEfdWZMB3wrz/a0Xxksjz7af63S5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxlFzwpLgj3M9Jj2RVS3E7GwjV3GdiKs+0bNh/Zo8R0=;
 b=lsjcaBawj5pUDRQptaWJWvx4KHCUqO/ThpLbrr++t2Hu1RP9IMQQ8Sj1JRKOzDS2CS1Qau0uBVNohhmoillS3y90jL7/MXhUjfm1Kz1KqiT3XCMZVahX6w3buYtw0T/hLSq2YC/msXuCQ0btl+QgeLpFuw5gqonQS+FNpVRGXE73wFEjPNB2mTs0GaNkQ40j4oE+N/mHVRvDAfnvpI39pBMtiimt4KK6vL6o5J5GWUjGQb4Fs7YlCSVgvyUDeEeEKHnGnBVJgwPrXwGAxG9jk9ilERqB2tPVYHJs/O3lUy90bEkvx+uaVyPGEj31zv3nhvLRESoVIefGMuMJB8LvQQ==
Received: from DM3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:0:50::12) by
 BN6PR12MB1252.namprd12.prod.outlook.com (2603:10b6:404:15::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Fri, 4 Feb 2022 10:30:17 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::d5) by DM3PR03CA0002.outlook.office365.com
 (2603:10b6:0:50::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 10:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 10:30:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 10:30:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 4 Feb 2022
 02:30:15 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 4 Feb 2022 02:30:12 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 5/6] dt-bindings: spi: Tegra QUAD SPI combined sequence
Date:   Fri, 4 Feb 2022 15:59:35 +0530
Message-ID: <1643970576-31503-6-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fe058a0-2d94-4850-7627-08d9e7c9568d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1252:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1252571DCD5DECD0676FBFA6C3299@BN6PR12MB1252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VuShDXyRF6e4xXW3/QbmBgSKqhlzZvyeQs+5n5n4R4D3rGkZWpVkyEzkA6d9lWEFLFWnT6P32B7NOn28iBqEOLrAgGU7WD9XCIl/6Dlxb7ZwhBF4Ah4E8kvOQ2eY/siVVJ4D0yAB5WVwpnOSu/P2AONckQiS2dYmVauIRMB/jQnODG12iVaadKLU8t798y4skVMKIrQ0Ad+71lnU4ONgwYXblvDTwaaf4z8omYWY2a7qpkbPFZQNoem6EGZBli8avD6Y6n8hbaVTv/7rnbGhpaxsMamOjDdYR9JX3mi6wSY/76XXL4jmBIRinuqar5HK8G/pw1a2hqXgtcu7lOLuOjzX7JcpbX83KQk5VsrpgCR9pSf2JHctaVqpSt6zan0Rj0w/yJ8Qnxx4PNSn/Zz6xpBNXAmhAtVES8Y9hg6F8pdv0q/XPbaxi2zahWXiHWmIM07c+3hSqgHjCVPQeMs3ecUJSYrQEchtca86oVUevX4Yal/HGOxJIMReskz0fS1eLX5KIYYLLLRo+Kt3eV28aN37SoV9CF4AsSuKBn5CNZeD+ioPWCC3rn/t/g0AjW+bF0AU0JkaRwL+hSy+Y7cObmVPPxGDVHkcqkf42FcJZWllRWKSEecFCoGcWJJB88zQHmkvOxgNP6Mhx1T/al1K8qH8Pe/+rtXsRCZnjRhDZNMllCDZfj1OobjHide8qJSAW8Ss2MAfANTR8sOkVRVYQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(82310400004)(40460700003)(356005)(70206006)(8936002)(8676002)(4326008)(70586007)(316002)(110136005)(54906003)(81166007)(5660300002)(7696005)(107886003)(36860700001)(83380400001)(47076005)(508600001)(2616005)(6666004)(336012)(186003)(26005)(426003)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:30:17.4940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe058a0-2d94-4850-7627-08d9e7c9568d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 and later chips support combined sequence mode which result
in less interrupts and better perf. This flag helps enable it.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 6efea89..3767059 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -46,6 +46,14 @@ properties:
       - const: rx
       - const: tx
 
+  nvidia,cmb-xfer:
+    description:
+      Enable combined sequence transfers for read and program sequence
+      if supported by hardware. Tegra194 and later chips support this
+      feature. Default is non combined sequence. SPI message should
+      contain CMD-ADDR-DATA transfers to combine and send to hardware.
+    type: boolean
+
 patternProperties:
   "@[0-9a-f]+":
     type: object
-- 
2.7.4

