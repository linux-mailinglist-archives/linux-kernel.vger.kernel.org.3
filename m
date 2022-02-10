Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50C74B06A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiBJGvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:51:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiBJGv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:51:29 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE7C10BB;
        Wed,  9 Feb 2022 22:51:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLW3RoaYHbF8i7hwpswasVhagoq6M297280KCYMLeS0lQHCoYoVeqZTPWYUWirMPdzlZOEP9YImycDwsM9noPs7Dfrs164ix9EiNx6IK8ny+tJBmcM8z0mSLf4J9WiqAqZpm/cdtji6Oo4wcCWrk81/+8502AKj28JzhlvgbZ5lRGJspDNnlicKFRASfoGj05//h99xlP9DN4DaoleON5rA4tF3j4QJQvrD9M0xRWfjKG9jnQ1jgn5MYTt8H4GGS9VBW/D6+w4BfivUUEzHJejeJcOOsNdWLIIMcRYtzZnY51PD4XjwLP8jXGvqQOo9LeJUjk1RGmDOfOWNHZB0YPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUUVQhfwConrFnRXbg04vsbA9foJPiCYRG+HjVc343Q=;
 b=m9xcPw1HYnMgt/XK9ZGM3Mbpklpof+LFLDQPwTWKXFnpETzfzWVkGGyXjIr+JtruV9eN+cE8FxHyoc6LyQE0sK/ZqKUr85fbfwvY8Jgy3E3KQFc/ahKeI/Dq7KLGK7GQ3IgiN98RYRakS68F+JdoAF+qyVAkShEEdR3oeD6ML5U++Z78MO8o2CrruWj667KTWeVt+eSvcD7GW8sjgFQ0A/CbudjWZr97CsWAAl8uiG7BEJpIPcg9+y9szQcZIhU9u5UaJkF5t6+P5KHozOgATkvHdamg66zC+H+h8cO2MCgxA3gHPidxEwg1OyReYXtjFRmbcSuuVFw3+6jeEHTHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUUVQhfwConrFnRXbg04vsbA9foJPiCYRG+HjVc343Q=;
 b=TrpS6dtunzLFzUwhpLnDE1VXdi+gz9lZRu3bEdOl3rrt1RpOtLxcPqEN6ArEDm0DelqOynD+ABTQv7OiYRBegatzv6siKYZRETIqye2rCMB+0T7DBJaEJIQJ8sTeR2hCiTAgWpZdBmmSsYhnnPHCg62fr7NUpaFK/VYzSZWb9MobmMBIdRndYTY8bdMRp/iLbhmd+n175stFpTG9OclgERGpSKsQzBMbOrm0RRCgJNSdXNyyGcQT43nN00cPQXXHFLkEMjwB4nlvs+7Xeo8c/SwS+HJPeODTW33YpVA97Jw5c/zALT7TlBMcB1ApF17AhK6inESqszXFGrMuywhYFg==
Received: from DM5PR10CA0008.namprd10.prod.outlook.com (2603:10b6:4:2::18) by
 CY4PR12MB1734.namprd12.prod.outlook.com (2603:10b6:903:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 06:51:29 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::a8) by DM5PR10CA0008.outlook.office365.com
 (2603:10b6:4:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 10 Feb 2022 06:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 06:51:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Feb
 2022 06:51:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Feb 2022
 22:51:27 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 9 Feb 2022 22:51:24 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v2 6/6] arm64: tegra: Add hda dts node for Tegra234
Date:   Thu, 10 Feb 2022 12:20:57 +0530
Message-ID: <20220210065057.13555-7-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210065057.13555-1-mkumard@nvidia.com>
References: <20220210065057.13555-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b5d74e6-0d01-4e2f-8939-08d9ec61c3bb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1734:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1734CE6B572B1EFC26936CE2C12F9@CY4PR12MB1734.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjT2Rv7+z2hYq9iLnKt1qoqMQwxHbLNt3RUpjuBQkTsMnJ4EC7Pn24wt5VGQCgYQRv8xROWOJ41pO0kL+DxOkSGqzusQ+qXHKaeGuzlHs/xnt3qKyLRSlc4QQov5y/Ggw59RJ3ns/mDvVAcugzA9PVUkjf8JUUv5uvQY6nLeAVm05xnjrAJQY7P7tGUvKaRZPEVmhkw0ctVP4CN7vD+d4fT3/qwP3OwPLliRPGXDEHbA6r8evX6i1xD5RDZ5FGFV1pSyx5VG+9Bkkzyiu7Kn1W6B27RkPlXef5zWjmv11gVU/tYdwcDRhnWxgzhwdclFEEPiRhLC4FEWshvSXTehy7wcayWUVuuWShXwwHU/h+FKLjH7/jf8nJISw7jAEh/q2I1E+n+gBiUOu5YICGXLxmyfz4fTpsQShCSaTlPMgiofXjhTBgZO3MUyn9JeyULohA5QEi9dNhikjZYNmpYPtUFC6bpeO8Xap2HTWY8g7ret7HFj/YxuaVzNawqWDr6ed6bes/fubXlobMD48++hVy7CpKNERP+9AyQ5VAqXmOqv5GtA1OyfeEZQvxa/quRPp9xFctmw7KA8CNstTVbbmd9mIt8PCdlXr1iW071ZhDhAr5NywD7AA9qHp94/Ly0Zi3ClKzq8zNzry+PBfLTpG5NfGWclEZlAbyuIGtTCJqTFz08SJZn6oT9c0wAuyokyvEK66lfsoTFTbAdRKsyY7FG6192W84mRpzks23Ybo+8=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(86362001)(26005)(6666004)(47076005)(2906002)(7696005)(5660300002)(107886003)(83380400001)(2616005)(36860700001)(36756003)(186003)(82310400004)(110136005)(356005)(1076003)(426003)(8676002)(8936002)(336012)(70586007)(316002)(70206006)(81166007)(40460700003)(54906003)(6636002)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:51:28.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5d74e6-0d01-4e2f-8939-08d9ec61c3bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1734
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

