Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679E9564F93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiGDIQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiGDIPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:15:23 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7AB1FA;
        Mon,  4 Jul 2022 01:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJCaFps6FN5gP3n4g+I67IbG8o1vGcb7ew930up1/Mkk2vzPy/frxjS/HiNcSJLQDr5mmiZf0/Yypx/9Vsh5hQ8Hw6ZWzcFS77BP9trJXjdmV+q77qpMYke4dHler+LlrC1gvUrNDsfeHJT0FSiF6EswalrR40eTizqCCWhXtA+UsApJk7/1LiWhL3ACxCZgGZFgjfsL7KomBN3gh/+AMkE3Y2DMHWjoq1y5hpTmB76itjdWDaT3wQ8bwhFtJd+f27KOT+6zdAN647fQDI9pPtU1+9x7SQ84LbsXHu1h/KYZcThnIry6VYd/9fPvg98jFCuNSG9Z+2TRy91I0PPbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9WVzM7NxBw0OAk9OdScaj1tfTOaBvGBi+xBegen34c=;
 b=MNugAywVFx5gG54l3USOzbOzej5DBmvezPudAoP7FPUIHIfiLy0cJmelxxnr67OcQxDntjKMJdeGAT0PVCPIRf53dZBOuz+j+oJOquCIHeuncU/FRwUUhN0z6PbsKJ4ZXo36xUTFOIbR8+VobOOFNjYfXQ8o3BPXFuDdUQt3BFBHkLb6IVk36a0UcdszqGTvZoYYBHWf+dO900xwGIqEbW8/gG8qtC6++K2xIJmiALEQVxmArSuwmTI0Ebxs9a+TgoXj7Zz44CdJNMq52u/aEPI+W3P3OfwJnSRbib5LnluKU6cJX94MeeiHegymKq+Y+yjpJRcwncYpwpT50DXIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9WVzM7NxBw0OAk9OdScaj1tfTOaBvGBi+xBegen34c=;
 b=tgMyswvshDXpZ2N3mo1nKcnw4BXGRIhFqT8KE6xXJz+w5bw2UjsXqasF17MqLt9ldtiKAE3t0b3tsjWq7PHw5T0Od+NUvXNHOzj7jepFNASxNSNJ43eSK+9XSvr2l46Snc9518+6T9KRMhAhSrnb/ZzdKDXfu0Ulhfmjg+7JkyZY9JthD2v9fyYrmdN+lPuMw6uSsItMiz75qd5+rK+ZMKCQ5pVOqZ9ypU4qU+IUS3FdCuTLFC19gW1H42JDfaSJZuteOcX1UHqnuU/0X8QA9VMxSBsrjO+Q/bxGHrKKTA8Z8XJ0A7CSPDs0F3+5FtNZgacFoPE+68aBHJtPzIixEw==
Received: from DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17) by
 DM6PR12MB2921.namprd12.prod.outlook.com (2603:10b6:5:182::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Mon, 4 Jul 2022 08:14:19 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::10) by DM6PR01CA0012.outlook.office365.com
 (2603:10b6:5:296::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Mon, 4 Jul 2022 08:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 08:14:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Jul
 2022 08:14:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 4 Jul 2022
 01:14:17 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 4 Jul 2022 01:14:13 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <mperttunen@nvidia.com>,
        <rgumasta@nvidia.com>, <amhetre@nvidia.com>,
        <akhilrajeev@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 6/6] arm64: tegra: Enable native timers on Tegra234
Date:   Mon, 4 Jul 2022 13:43:42 +0530
Message-ID: <1656922422-25823-7-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
References: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c20cb25e-6d3e-407c-9385-08da5d9531d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2921:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+j953AfCmu01Sd549SQ3ClUw19YrwO4JzfMZo9WmLYvkczjNiGQEK/+TR3CXydXvXwt8RVgjQ4u6s6/BwzWBlvNR0v0dXlEAA3yhnS9EscrfKetJ1NrBgPiY449mFxAHzpiZRfoL3s7sDTJppkwIwQ6bqj9+QFs7cS8UYanYnt1JHsKYGMXe8LceaVbNPyP5MkmD6K+5mqOaUiP1YTVpbP99W60+9Zs/8y8BhpC/sDtsvPKOFm1UPZqZtSTKL+TZADwxP+3VKi57Pi0y6sPX/S6jKo5wx+hOtnQ/ng1Xt7zM7D4gsyePtSP0rxWBZvfCM+am1atVWgv21plDAIbS/wlKrq1HQSQm39gR44Tyq6nRFhvV83cxG3DrGFDsgDnQlSeUNuYemfzRkVY8laUFaP5H0wIKSArbYH7C2I/dgUKbSDNzaSBMcgZuGGgU5dP+ohlulxK/ORxyroO/73VwI31dRXgxDh9jcnPQqT1Ddc7kuleBG0ceqX1WkOxGvDmUUuBtBmQvU6KGYyFBQz0b2BbIgSsxSLNZFZCfhxPxB8kTHzdCVKn8z7a9NIT+aN7GZ6uO/gNG/B4OG36rLJ+F+dr5kAYiEAOlkjm7Bih/+jvuNzlwolFpc1bvZEffEsNGkbTHfAb1rJK2oQ04ti500ZVfZ3LdDciHQ+I+82iM8cuIl0PAnnRwKu5iHdRwP4h7W1mPhofpKPoWpdeGvQNiqvgqyPrXT8sI/mOayF01SHWUZfKlwG+kbkHV5sZzeqirxYer5qyLTtuInT+GI0pgHDeACzxMYr+WvJaj5alU1yMv+sTdqjM0weSTlw5xoGa5SOeTopCDEBSzxVoIzb1eNdkhVrDMORgt93MY5WGzxZYkGD7OnnOq+KspFTGghiR
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(40470700004)(36840700001)(46966006)(47076005)(921005)(336012)(83380400001)(426003)(356005)(81166007)(186003)(40460700003)(82740400003)(40480700001)(36860700001)(82310400005)(2616005)(70586007)(7696005)(6666004)(41300700001)(8676002)(26005)(110136005)(316002)(478600001)(2906002)(8936002)(5660300002)(36756003)(86362001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 08:14:19.2778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c20cb25e-6d3e-407c-9385-08da5d9531d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2921
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The native timers IP block found on NVIDIA Tegra SoCs implements a
watchdog timer that can be used to recover from system hangs. Add and
enable the device tree node on Tegra234.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cf611eff7f6b..aa8ceb3c329b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -519,6 +519,28 @@
 			status = "okay";
 		};
 
+		timer@2080000 {
+			compatible = "nvidia,tegra234-timer";
+			reg = <0x02080000 0x00121000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
 		gpio: gpio@2200000 {
 			compatible = "nvidia,tegra234-gpio";
 			reg-names = "security", "gpio";
-- 
2.17.1

