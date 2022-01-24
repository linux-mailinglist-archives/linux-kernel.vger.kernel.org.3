Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C06A498102
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbiAXN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:28:23 -0500
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:4544
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbiAXN2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:28:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONYwqxOmhcxQhKC67XJ0n+AUTqL7I3iUFpwHmqPZMH2e3bhVmEAuU9Nxy/F0KjN7UJuqJFY4YpnI4UQ/hTHCDqo9l1f8W2UZc1a+QoDMzVRHNwnbYZG7d+03o+CkW2c5D8e9GAR+RBkK+RRhLrhJXyckLj9X9aFEbDGPJi0M3+hvo2lZxpwkoLJ4kCCrtIw9Z1aMIvTQegzskP3bG25LewhnDzHDCz93e5Whk7XgxlbRWcUYKdbkLvmn1r8+CivFLB412ahecz/kmMakuOQbAaEfSOb/q3a6SEjkjvQqWFH5KAav2QrcboOMb9VdHXcgqfnC9NdOiXMIzj9+02A4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIL+QT6b03sPMZdKjRi2oT9ip99Xq5Nhf+srC8g/ZI0=;
 b=YkI8/tvVJsKy9pqrstpiRtESEc8ldoL9EhA0Nz8nAJBLWrgS22MtsNAU05a4IQMstwEccHqdAGC3HaeWSpRqp1DuoI3D/Sasuq1OeLVtw5L5AujQcvxbAkWNanqxhbjVZv9gCKJc4WOo1T7KwEcZiaDCl/KS94n8+FWnN2ttn2cFYQnIXFm2ldckLruJ5D3pNwYtXtV0Rtxc5s+FQpGV6K3UzG23FJhBBrOkRlsDij20CcoMyGoYHzJKSDUyqiwk9M1wfiotJTwI7zfNgRrAjqr4q2I8v11Y2yj4wpyBI1NGdSDU9mcir1w6RL59CvYLxTQNuVqUoOVRKdWxKBz5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIL+QT6b03sPMZdKjRi2oT9ip99Xq5Nhf+srC8g/ZI0=;
 b=UBk4zEC7fReVtk+ZWlDER8g4S2GREgXQlGxkNJZ48DBqLoP45KCwDqOAU/sj01c7eMgnw9hbq6Z51DmZoFQDjTQDyQSjxlvQ5cZpOhJtW1scHOuRonRlxV7aV5Mrct9omkkP9ClPUhwFsdoqFLBK1Iieya0Q4TcLos18RqMGd7YhHBHT0jMAdaxV/bYs04sgvf2lc7el2EMpQBtVgj7WrXiJZsBWfyA7jGlpPdpgREOPcKCy4vZyCheyXnz769YZjPwCisBMpQCJHl0S7f7eBQqmXoBXA83i+9V/t7Ojau97BfF8LQctfSzSPsjxHm9Hy8SXSb7UvrrKvYnc8TCSxQ==
Received: from DM6PR12CA0021.namprd12.prod.outlook.com (2603:10b6:5:1c0::34)
 by BY5PR12MB3650.namprd12.prod.outlook.com (2603:10b6:a03:1a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 13:28:19 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::1) by DM6PR12CA0021.outlook.office365.com
 (2603:10b6:5:1c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Mon, 24 Jan 2022 13:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 13:28:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Mon, 24 Jan 2022 13:28:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Mon, 24 Jan 2022 05:28:17 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 24 Jan 2022 05:28:14 -0800
From:   Kartik <kkartik@nvidia.com>
To:     <robh+dt@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kkartik@nvidia.com>
CC:     <smangipudi@nvidia.com>
Subject: [PATCH v2] arm64: tegra: Enable additional UART for Jetson AGX Orin
Date:   Mon, 24 Jan 2022 19:00:04 +0530
Message-ID: <1643031004-4649-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e4fab38-4c94-42c6-22d0-08d9df3d62ff
X-MS-TrafficTypeDiagnostic: BY5PR12MB3650:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3650184FEEBEBA229200C5B1CD5E9@BY5PR12MB3650.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLZ14IHHDZMDmDz8YlUqs9yIpO7CiLfeC5xYhFg1DIxd1AWgJoj2X3AFmVY/kgIgC8FNXtXysQD5bUPYbALUFggIykxfMfciLZru1ujGC+AaBzdvw1CskGcC9IoA77sz4UCiKNH158lbbaJNskQmJo9kPjZYe7CU/K3/7Xbo6GR1/fNLXQhpWvAc+36ZnaijfU10uqraRa1GAXpYK4Z20E4w5RJnQvTi/w59oegXAhBO95GVdpP3Jyyoq1s42jEcJNFzB1WyVQLkEsQYWZd1jNhpc2w61S8PZJV1pzGgWwdJu65J73F1KKdUoPL+ky4U8DaHZZVbccMq4QuU1VGXo6PmcZ21TDtPfiri2QQDhu5aHMJj09Exc3V0t18z83H9+Io7vN+dCXmZKpSws8ADhYZ0m2p1QDjtSY96xWZo0sdbYndmP9uFbIpbWQkWHSM/3rs6Nk3l1T0pMppAHFL2l4I4w/ZNIhWPa0ekf8Fp/OVj6V75B/Q20T/nY4U4bF7lhmg7hPdD86xdB1JfCQWfBa9ysExz2sG6AMAuIiTLwqJaDSevg0ofo+2+m4OTt2G18ZrMHu2UfpOW6zZlW3/qy31A0OxPYwYlFkw3o8p32tDsoDhHWUv8rAkzTIKK3ItkoBijh3M/d4P01UDpvBNTyohYcNXGQKyJNPnBWzrHVWGG0MMZQAOpCIMqZV49EcinBrW1vH6xjDzYPjt8K1aNuYHKokiI/Ix7PQjJOrkGf5cgqJ73PtIyIDMGTIjotYbRSowCdLBH8/id4VymXLZLbCLYTVosE3vQ2cU469RCnCI=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(47076005)(40460700003)(336012)(36860700001)(107886003)(508600001)(7696005)(2616005)(5660300002)(26005)(86362001)(36756003)(426003)(4326008)(7049001)(82310400004)(83380400001)(356005)(81166007)(8676002)(70206006)(70586007)(110136005)(6666004)(186003)(2906002)(8936002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 13:28:19.5116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4fab38-4c94-42c6-22d0-08d9df3d62ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3650
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kartik <kkartik@nvidia.com>

On Jetson AGX Orin, additional UART (UART-A) is available on 40-pin
header.

Enable UART-A for Jetson AGX Orin and change the compatible string to
"nvidia,tegra194-hsuart". This enables serial-tegra driver, which
supports HW flow control and is the preffered driver for higher
baud rates.

Signed-off-by: kartik <kkartik@nvidia.com>
---
v2 -> v1: updated commit message
---
 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index efbbb87..4eda238 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -11,6 +11,7 @@
 	aliases {
 		mmc3 = "/bus@0/mmc@3460000";
 		serial0 = &tcu;
+		serial1 = &uarta;
 	};
 
 	chosen {
@@ -18,6 +19,13 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	bus@0 {
+		serial@3100000 {
+			compatible = "nvidia,tegra194-hsuart";
+			status = "okay";
+		};
+	};
+
 	serial {
 		status = "okay";
 	};
-- 
2.7.4

