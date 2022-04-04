Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DB4F14AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbiDDMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244332AbiDDMTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:19:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9EC3E0E5;
        Mon,  4 Apr 2022 05:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R93KTNzBWlBlk898LRuNe3wnPULCMjk1G5vwjWj4O7AmjUnYr/ErWbOMM9t8YtbjNhqNBKto35eMmONlRr/+QauQSzfZ2X69IL+YiH0i4v04LiPtgVQzXQ98izic6XV+JNdIKhfO5mwGpsMncedIFzVWZSxjThCsyMVyoVg+HaJJ99ouecna7HXuB4n4VacEWTyMD1qLMxHVVM5jzFSlwfef2zfZ5lFKcJbCHOPmczVJvPm5nsggq0CgKOoCSySgCws1bLEYp8VUB/4IiGOWe1yTJ6xVx/PjSWXei3XGeqNGLeSpiJ49gLYL9t2P+8JOTUV65NBfiav8uArABVxG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jiZqiuA4bL/Xl4sXyXV/fFxhFrzn1JlNSbgW6WB1YI=;
 b=DxstaWaNUVzFOjom8ei1ocCoDvCTS6q9RIZyFKKECf7jm3Bx4LUcsKfGmE997Ygyjbg7wsp8op0lmShPB/hWnv/Q0OXh/oxHlJLcvuSqekKcOhPcSu8Dj4PdnJngu5dz97/x20iPdAvU7hoI9qtT5+Qq+pvnmji7Md/z5mmfNZ+oh/VR2lrNSKCyOgyE3KYlYnZCWSlWj758HLYEPSeoR6cCEkYP6540GON9+vvO8LXgFpyrKkZecUfWPgcxr08pbN7oaGMKl+iNE4Ce2ZtlpSPXuU2UeFanfRASFP3hIlEJL2+b3WJjaqfxxZ6rATGiiDzw4FtFhFBT9NilUzNujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jiZqiuA4bL/Xl4sXyXV/fFxhFrzn1JlNSbgW6WB1YI=;
 b=M0tWM6RcKIOklT150HIhyxmKxMFcxMcSnnJFGs7h6p3WAAa4CFj+K8/p7SE2BHpyWR7vhj8oerfHTRSBlBC55moHiY3PxlVUukE+U1aI6ledjRYAfKKTtzgGkhXLqvLjfdtHM5sN74bpZOdftPLFU0EDlxnXpm5GXxOkd2M8E9zWHqZz/DicsAKikUtcAWdRcRFdJmU7ema0lH223ZDljunmk7qyMT6yIfE+I9KJ9CkYxTIMUtHrZLbb4CZlvJl//zcU181XOqmv6YORmW9wqMDM/+WZ01cujbTC7H6lt4qc4w13dxmEYVX+dQvMu3t79pUXqJn6SMmQlkB4lQIG0w==
Received: from DM6PR14CA0060.namprd14.prod.outlook.com (2603:10b6:5:18f::37)
 by DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 12:17:46 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::dd) by DM6PR14CA0060.outlook.office365.com
 (2603:10b6:5:18f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 12:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 12:17:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Apr
 2022 12:17:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 05:17:44 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 4 Apr 2022 05:17:40 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v3 4/4] arm64: tegra: add node for tegra234 cpufreq
Date:   Mon, 4 Apr 2022 17:47:13 +0530
Message-ID: <20220404121713.22461-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404121713.22461-1-sumitg@nvidia.com>
References: <20220404121713.22461-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1dabde8-a068-48dd-6759-08da16352089
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2507:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2507FDF7C9685977CAD05D93B9E59@DM5PR1201MB2507.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIEiRZhSfXXUIVFYK2GX6rGVkc7FbWsYYWF5IZABkQvzCdNHxeNYkgFqPTW0a+tYeFtXH314++YojHSlwzmDeJT5B1tvdGgdDDw8vRSHcnc6pIEGvjuwp6DETE54o32ioG0UKLD8qdqQHyynuebatvIT/WQl/fk7hV7iESPWgAD3Hl0BowkbbvatqBk8CTELqBQI9DYs17WfEF/0Q9j8dMFSrO9hKRunHQ2qd3pJiu/IMh5MzsA+Z1IneTwR7NtRLOM6LdUPQ+qxsnXT6IdoLb6AphjHuIYWQIMkpDBERw2n3k+ndlr6IH5ueZ5v+c8vTISn74FFR7ve167cDgqKbSmAry8eCRfptWB4WoMeibwMwBCy8wwGuczBTKcwUsd30mWF4ealvuWAO1HMcXrToaxUycrUXd5MQDvRI5FcYXt86Kll+J78iU5JDGOJHN+gyC7Y9eA7N0F/JKEHrghJzXyjBJZIhjw+KXZc/LIZkCOooQhRCOkJIwratQh9B0bUL5FmSW4d0t7KEMe8OBRMnYRLSP70csW7E6SGvtM1WiS3UDvPUDW4R3yBYC2voE1GO0epOZmBcFNUxKtGZoQDStBB8HyCae8mAZg+8KDwEL24UbzsP573FjUkgErcpqtVCoWipa3RNSwfqBnsBbSiWQgm4YLBJr2yqAtS8jT2DBrAq4qT/l+kTiWdmYVG3dFedPQYMSyAZNaWW1E3ZJ14K9/TAHI3dRRvPJYbyhEMklA=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(426003)(110136005)(8676002)(4326008)(2906002)(26005)(316002)(83380400001)(54906003)(36860700001)(107886003)(8936002)(81166007)(47076005)(5660300002)(2616005)(70206006)(6666004)(70586007)(36756003)(1076003)(4744005)(40460700003)(82310400004)(7696005)(86362001)(186003)(508600001)(921005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 12:17:46.0050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dabde8-a068-48dd-6759-08da16352089
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding cclpex node to represent Tegra234 cpufreq.
Tegra234 uses some of the CRAB (Control Register Access Bus)
registers for cpu frequency requests. These registers are
memory mapped to CCPLEX_MMCRAB_ARM region. In this node, mapping
the range of MMCRAB registers required only for cpu frequency info.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index aaace605bdaa..610207f3f967 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1258,6 +1258,13 @@
 		};
 	};
 
+	ccplex@e000000 {
+		compatible = "nvidia,tegra234-ccplex-cluster";
+		reg = <0x0 0x0e000000 0x0 0x5ffff>;
+		nvidia,bpmp = <&bpmp>;
+		status = "okay";
+	};
+
 	sram@40000000 {
 		compatible = "nvidia,tegra234-sysram", "mmio-sram";
 		reg = <0x0 0x40000000 0x0 0x80000>;
-- 
2.17.1

