Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C4E4F4E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587702AbiDFAKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382375AbiDEORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:17:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51511BCF9;
        Tue,  5 Apr 2022 06:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv+UgOlWnHKuY8eIzzJH+Dkbio0qMDcVxRFPILH7tHzXNXexipOk+FEDg0H5F3XfjwcVrWp/v4scquDwdpw6n0dw9h5fuLaq5b7tLtvYY6+hKVeUJceEr2YCh1hB0si70ZEaHRx3ciQKSvEYoU2F/WJ0uFsds8jr0FoqxFcwFvBD+07UKPSWxdA83gRgTcFYvR7L1TCc4ukIuZTgnlkJDTU3Vp53sZLwEopj5RmYBKhvwV0U22PJb2Y3z2BZx9fF3hFxeWpLo414ka/cviJIuA9lKbtaHwSUCu8S/ps6kq3OWDDxTgUXglb4+Vs4F6AkbiYRy6YYoXRT7uk55ih0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jiZqiuA4bL/Xl4sXyXV/fFxhFrzn1JlNSbgW6WB1YI=;
 b=bxVexal4p09bNddM+nieVgV3IPeYlyvokKeUjCnBKtBvDQBXwTetPuVx6XkXu0Oj63wBYWYRB8fzydAZSe8JIhw1XEVW77KFDVHn7EHJs1V0YCYSHJXjrPZgb6+hBTSqyru+x9hWAqWvUSUF9nLHXtLukn3YwtiCXeBVAZjRnABVgfuUoLCeuwVSuPSDPjC5e2sRElFbzAnFJb6jVgIPNtdkUCIZLL4jgYaQsvEh26c4YP/YZjmwRIWOFp+BZSaPrSIRj4JPZRgyuRKlj8Xmie3gltsCbipuHVvHprjhEft/5fZ262+1QalcqzON3KBdlT3LVkUttqFhOm/Yl9JT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jiZqiuA4bL/Xl4sXyXV/fFxhFrzn1JlNSbgW6WB1YI=;
 b=VnoZZwyYL1GXk65Cch0NN3n49Zo8Pkqr9nG0LzKWwW+6ZLCsS570JgDkoU8cgrG462sm6bwF3d7t3i7n0AklWJPKrGL/PsABxlsAW9LZUFtowujQgnrAft6wKn4MucjfxbkP83Zc7n1O//5uuxGxb8vqej0mCFHorWZ1WRFzz4k7BjkWxJd94CYnlSK+P50ivLTeqfeGz6dPerHdE/LIHR2Z78j0IVO8JhaiEMFhvWVsZYv38+vK8E33rPsgUyxnBfYQXh7rOt8P1BMHdJgmeM35Hq3Vy5Aux4XG9xvFTb+JKwjOnLxMV9Z7XQSoEGMpwXZtNKSkzqRwAirSQMcBAw==
Received: from DS7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::17) by
 MWHPR12MB1806.namprd12.prod.outlook.com (2603:10b6:300:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 13:01:48 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::76) by DS7P222CA0005.outlook.office365.com
 (2603:10b6:8:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Tue, 5 Apr 2022 13:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 13:01:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 5 Apr
 2022 13:01:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 06:01:46 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 5 Apr 2022 06:01:43 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v4 4/4] arm64: tegra: add node for tegra234 cpufreq
Date:   Tue, 5 Apr 2022 18:31:19 +0530
Message-ID: <20220405130119.4697-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220405130119.4697-1-sumitg@nvidia.com>
References: <20220405130119.4697-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a0d1af0-1579-4906-61da-08da170471a0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1806:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB18069EBEED38796CF50FAA56B9E49@MWHPR12MB1806.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zw321ry2odIqITdbSssDdazv89WR6VAk7H4lecQsmHTIzGQ+PMKEtXilrCcNE4dhK0+bWrwJHgGchpJKDI5UIGmB3nZ2A0Cvobfif/adjeTvh8Es/3DPD1wykxYxSiIeF+SSYsYjx3LTpByO80OIzpQHHURvi1xhxYTAISKqO62x0yz+QIyFSEWPlrQ1cj4UzaCdAefddhNijxzwXRPTTvfO3Nf/zgWqhP3CprM6fldqPfOB8psJw9vklyPABZviSuyXQCQwrz2Y521KQbthQFvmnTBMfnpGdduNZ0pt7VLZPRN0uU+Ti3x/MjxllapJJG/kMrWE2yWlEk9/MZDf2efNM2VAAVkhIU8mrLXKACm5cXGtyepyM/GsZbjmujKvHlVhHLLkCqGqQexu1w1ZE4QCLtGoJ4YIQYZptymKOhhcwH9bqtHIz0GN8Cv91rxmOXISKsVWSg3iti1wI3bvnb1dGqb6AnZCBY5v6hHf4k1vE7VzyiNCQQ6I9IozXX2U3UW/jEPJBm4nezTxPJ0L1jrZjLW+fkdp931v+vTCqO9+Gk3v2KLiFscyyPoae7wJ95vz7CoKAzdpp/0aq5g2H1a+ZXduVKx/+Q1Krb8eE8Wk6jO0fZYMq7nT+YdUec3udUQoSBcLRM2YhMI4lNBBbOZaF4FKuYFN6Iv+HotqUB9vl99ITzHgseoy6f2fyDzS4eHfYdieRzkZ80PD12Wfy7ZX8wGNZ9WanzAvjy/62SY=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(5660300002)(1076003)(107886003)(2906002)(36860700001)(82310400005)(8936002)(921005)(7696005)(4744005)(356005)(47076005)(36756003)(86362001)(316002)(4326008)(70586007)(70206006)(83380400001)(40460700003)(6666004)(81166007)(8676002)(186003)(26005)(426003)(54906003)(336012)(508600001)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 13:01:47.8740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0d1af0-1579-4906-61da-08da170471a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1806
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

