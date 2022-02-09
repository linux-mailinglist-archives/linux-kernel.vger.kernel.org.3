Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A064AE8D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiBIFHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377710AbiBIEcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:32:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22FEC0612BA;
        Tue,  8 Feb 2022 20:24:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRkWsuN4j04brji8cr5dAoovCJMNcvuEP1+qm+sGyOZFvM1AWmwMGrkDaRk5KWd0OGkmAN3iYeaEwvifgWFWE9h4cQntHRnPKsl1SRvtJmQIXcbuedRBrAriRX9dh1HpqXtbnJQP4inFgBQRk2oRJwIu05hx3hrG4s5UJ0BiTIyntNPO5NcXtDyPXq7ARyeR3CJESdyGgp1G9hR+yzhLuwi82oKrDWtgHxUx9JyJQXZrLHSJgs5EbUXtSPVE8Ne2L/AlU7gX8iwHSPRZR8SLuRnqZLAQ6YCi9zpsrI6FbU8qRwzpvrs8KriUqo3IOa9hitzsH3t1ZYYjUu0X9mI8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUUVQhfwConrFnRXbg04vsbA9foJPiCYRG+HjVc343Q=;
 b=GMrw26siN7mYv5moUbS3eA3m61zLZP5l8xWHRqo4JNXdARG3WT8vtOWIYZYMl8TUHMTMqyb+R4KdaWmrZ6rqGD9Yfgcw1bnX3wdthgN7TAcN83MC89VixjRzMOkS8+Pg1HudZPUAmmZmmfoNCva9Ni+c1y9ttwVWZhLkltl5yb1zgB5w5zSPGdS+fWBc4cItWgo88fpXaWMnXiCHSs0sX2zl7MAIul1oqd9vKEZWkdY7Ndeq1cQnTMn5WrjdQL7frnd+2op4lAvFkkaowZ+Hs+hzYrof3cV8JeFYG4E+w2ccX/qgZEL56bMgn9ndz8d++Wq+Gv5SGK0zFXJmhsF5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUUVQhfwConrFnRXbg04vsbA9foJPiCYRG+HjVc343Q=;
 b=mzsC69WUjMtdE/t1ePs53UlSkmkPE1m0WO8jx8yyEatuqEFwVZE6V5Q97pQVrw1+v1h8csPI9OItnO7oR9TF0jCMZ5BtvBtutu73Z3simYTpv4pcY8dgdrHgUS3kBbDA+/HnWH9wsocbM7YWmrtTGkJ3VjI9vsrpFSHPHCoNPYlyH2OYAXcKvSIXqfiP0yUI/oq4ooMjzaKrJ0wH7tPic4BsGCUym4sV4QNZf58quwYBd1LUy1H5k7+x+3zgVauGamgle1D8x88yToL7TQihWW1KK1VGap5sKG3ueRgtEHiSdRLiBH+Iyi9btdyz0jov+gXp2IcTlooYozppKA1Nng==
Received: from MWHPR13CA0005.namprd13.prod.outlook.com (2603:10b6:300:16::15)
 by CY4PR1201MB0021.namprd12.prod.outlook.com (2603:10b6:910:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 04:24:15 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::bc) by MWHPR13CA0005.outlook.office365.com
 (2603:10b6:300:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5 via Frontend
 Transport; Wed, 9 Feb 2022 04:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 04:24:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Feb
 2022 04:24:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Feb 2022
 20:24:13 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Feb 2022 20:24:10 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v1 6/6] arm64: tegra: Add hda dts node for Tegra234
Date:   Wed, 9 Feb 2022 09:53:26 +0530
Message-ID: <20220209042326.15764-7-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209042326.15764-1-mkumard@nvidia.com>
References: <20220209042326.15764-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90f50707-80de-4f58-f694-08d9eb8407f4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0021:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB002186F4470279FC0DB99EFCC12E9@CY4PR1201MB0021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oo3LRPLmxb/5OYr5WocwwkFTyCjh8ZNaGRU/ixrnGM4GnEXZ0KhTmnikQRIOZyvVk2HdztW/jweCNM2lYfzdwtTvdIkqCN2/sxwvL80iVSiACtRWfDT3I0x0ndlMrwR1aYfhMO9yrmOlLkzzmIEUNnfSXl9pwDtTvxLg4AZrcrcbzep53mgGNtNGuCzN2Dp7Xmslg2TMJQyvfWGGqLgU9sSlkc05+FQUMlSHQ3GoTFHAGL61nfXDoZ7gPTokaaagOJ+PP0xtZWdhuaibU7I3d0Gz+SlEHtMxPYUIUv1t5QIBddg1es+7k9wCAAdHojv5t3yeK9c4scF+0C7pWwHAQGgmmWCgB87pYJPavz4eMRjcDyaXywvMPSDa2kSbl5stMMMrdC0Plyi+RuFBSC2dfC+MU8gSAbqNaPgNIoy3oYKvOLih4drimlXm3uQgNFuXoriIbOhKalVFabNAcW+n/dfrf2HcB9zaUoEo+a4zJGpiMcFWGxv2KqcuN6ziu1VeK9RvI28nC+er8fyfe+AUuKkXERgM2OR3vdafq2WtSEhGjXHHO1OV2BMhAqkuMpXROeid2E7JgFrLs3ZDIpafBMZT4SltdVCDemEiTlawRMxq3k56i6mrydE7FpZ97qhAQ3W/hlpRrCrZNC8J70+2EoPGlP6K7RMsTYdSX8mLEAEbm+Th9e6X1fiJxdw2wyj+HAUZWftu2yt0FmmMW1s6nSWQWXtT/15q0C+R51sI8YA=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(110136005)(6636002)(8676002)(4326008)(70586007)(107886003)(70206006)(2906002)(508600001)(8936002)(316002)(36756003)(40460700003)(7696005)(6666004)(336012)(186003)(36860700001)(86362001)(26005)(83380400001)(47076005)(356005)(1076003)(2616005)(5660300002)(82310400004)(426003)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 04:24:14.9465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f50707-80de-4f58-f694-08d9eb8407f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0021
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HDA dts node for Tegra234 chip and for AGX orin platform.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts  |  6 ++++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi       | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index efbbb878ba5a..792e4a8b272b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -21,4 +21,10 @@
 	serial {
 		status = "okay";
 	};
+
+	bus@0 {
+		hda@3510000 {
+			nvidia,model = "NVIDIA Jetson AGX Orin HDA";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 6b6f15804a1a..d39d41968ffb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 #include <dt-bindings/memory/tegra234-mc.h>
+#include <dt-bindings/power/tegra234-powergate.h>
 #include <dt-bindings/reset/tegra234-reset.h>
 
 / {
@@ -261,6 +262,23 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 		};
+
+		hda@3510000 {
+			compatible = "nvidia,tegra234-hda", "nvidia,tegra30-hda";
+			reg = <0x3510000 0x10000>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA234_CLK_AZA_BIT>,
+				 <&bpmp TEGRA234_CLK_AZA_2XBIT>;
+			clock-names = "hda", "hda2codec_2x";
+			resets = <&bpmp TEGRA234_RESET_HDA>,
+				 <&bpmp TEGRA234_RESET_HDACODEC>;
+			reset-names = "hda", "hda2codec_2x";
+			power-domains = <&bpmp TEGRA234_POWER_DOMAIN_DISP>;
+			interconnects = <&mc TEGRA234_MEMORY_CLIENT_HDAR &emc>,
+					<&mc TEGRA234_MEMORY_CLIENT_HDAW &emc>;
+			interconnect-names = "dma-mem", "write";
+			status = "disabled";
+		};
 	};
 
 	sram@40000000 {
-- 
2.17.1

