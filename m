Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41757564F7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiGDIQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiGDIPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:15:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7168FB7D2;
        Mon,  4 Jul 2022 01:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7GfuGSwQgWZLb0sGrBqCBHlZdCAGu8HYvpNBG2Mg4jiimq0QwPXNf1EgZlxs+8Pi3odnqbVCm4Ls243MJzusO5LgH+36bhUR/uK3xQkxuhvtPjLQilhYomYFp2MZ+q8DXaBRYfEckjOklohmKzwuRs4YIYOcoO/ZryVuZCUY4/TqiQCL8T14RLOiixzk0qJmkFXV6GGrZGQ9QQzO3gqh7hR2G+GTi8+gqv4tpGhVTw32fHVTkFwHhOkR5A13hPKCPYsBT/v11Ii1Da6jFmrpberOn8AYW0TFvoE070RVn7ZbiUVDcelu5n9iQXnLIhO/ZN1K9YIqKn5q4zabyH0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXIrN3uXHaeCInASd2PmUFVjlPsl/JgwvWPSyYL3Bcs=;
 b=lnnv9vlY9C/9zgIxnIEinKw0nZlxkeYAn0Ue4CgCVHgKW51zBU6OoPJn8N1i/IpepsJhmNqWaBZFnbGcJ5cdob2HVC4kYOHhf+DNFFlImIoXuonBuVHLKa4EsaGaEi6YwmGp7uGTkelmICbAecrICfz5osaVhW5QVQBB2rl7wIps30Qzvf7zzjlO78m9M+SInwMBqWSaKQhVtKJJ8TPCm86AjhsgBywDNAbf/wprJQwDfnXMipAUGZnYywTxgAVF7HmwKbb2/kNVbVlG2cZd1xMrqtRTKTdF786OVBJFJzUjy8FHE7Qjlt4eENVrQHBeaBMYF6y50FrLpNcF4cqR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXIrN3uXHaeCInASd2PmUFVjlPsl/JgwvWPSyYL3Bcs=;
 b=owkqV6hYb/e9HkIF/BW4JYxzDmJlEdzhkQRBrtoE/5haYi/Q1yog5Tql4ZwEL3jeY3lKyLA83W1+R/oYybSe/ha8I/KqORto5Yx+15TuYtdtjOOT9170oooMyvW4OPLxte3+/13SieoW1YlLHZqCMtR8dVWSEgHxy1F/uOhztwDyrTO/JoQqiepo+GkYyLluLRUfXGblQun9Eh0KepMg23R76Zu0hhCpcO1mI0zT5IScy9L5974dPxNfjVdBJTy2vFiGgoxiPE97xpoBh2Cp6Ub/TvTpjaWgfmdxXyypv8x5qIOJtVm5WCox6bkojk9ReaymRw8LTRS8AbkHX6RJEg==
Received: from MWH0EPF000554DF.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:4) by BN9PR12MB5099.namprd12.prod.outlook.com
 (2603:10b6:408:118::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 08:14:15 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MWH0EPF000554DF.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.2 via Frontend
 Transport; Mon, 4 Jul 2022 08:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 08:14:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Jul
 2022 08:14:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 4 Jul 2022
 01:14:12 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 4 Jul 2022 01:14:08 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <mperttunen@nvidia.com>,
        <rgumasta@nvidia.com>, <amhetre@nvidia.com>,
        <akhilrajeev@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 5/6] arm64: tegra: Enable native timers on Tegra194
Date:   Mon, 4 Jul 2022 13:43:41 +0530
Message-ID: <1656922422-25823-6-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
References: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04648dd8-6ecf-491a-5fa4-08da5d952ed5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5099:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YD8oR8df4Fh0BvQVXUgP2TUqIqexwJc+ioqHnOcFj9jSLhMI9JgS5+aWdGaPDZMUlh3HmE/tRARlatD70haScNFGoakYWu+4j9mxkvTI0S7JjRdgqNLg6i+qFoApEEWpOfeZsn20JZxXmhbe0HYmaQHZCyei2Jqnlqedfy6YjnNZfIiKHzyTIMynb+84OwDjV4DXnpkT2aR3IA85LKxhxv7pKTIhp9qCmvznhB3ESPXrlP9EW2dAcSafMM636IULTdyImWZ1h+M0aMtj6dN8Kz4FZs7oMHr8sLF2o4Mv1oo9HOnh7sAMypQLXwMjECyf+luDFwnSX0W0B2LkmpvhTLdhhk1Q8PK6QlDdHnU2+mwrYyyK0LzkFBMm3trFV6LPAa5+1S6jgkqfgB/omLfL5oM24VzMdvpyaUgWRdZv1bO3htD6bm+jhHdbKxP350OUp/n2PisZjmWQ0ywHErXTkV2VSAb7PgOTkMwqoPsYmGyMM5OrpOW9uP6HcFf9KBmsWwD7vneUTlJr8tKyjOJWPE/9KUtZF7KZWJoF3ljaeVbcw5+Mveuz7R55MPeO8lcU8Amct/x9BuHP85zvZcz2gWrAtaPu22zfTw5pi/6a0ON724zW+tgsCQCpdaWt/TCMpa9tsIR4Zxk31RaL/uDIcLk/x/rMr+W8BBjAbek1jaTU1gEu1+Lc/+Ut+LhC9YJPTSSJYjnsXef93axA3PK18OXC1aGWmAdf+WK4Z0ZjMbQnx7ux/BmtuuNyiAcK/4eMpjctCBM8ItzIGJZugZ1aH/UYf4s9/jdtBBSdz1fCzpeGlDp4v/sOreZm+dbNgdavK7DiYVuqK3r4jcIxukWOzXXLzS4hSA4el0lKpixZ+10ERke0IYxjYFD8FQ+oVcZ6
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(40470700004)(36840700001)(46966006)(40460700003)(186003)(47076005)(426003)(336012)(36860700001)(40480700001)(81166007)(83380400001)(70586007)(70206006)(316002)(82740400003)(8676002)(110136005)(36756003)(478600001)(356005)(7696005)(2616005)(8936002)(5660300002)(86362001)(6666004)(921005)(41300700001)(82310400005)(2906002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 08:14:14.2498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04648dd8-6ecf-491a-5fa4-08da5d952ed5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The native timers IP block found on NVIDIA Tegra SoCs implements a
watchdog timer that can be used to recover from system hangs. Add and
enable the device tree node on Tegra194.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Kartik <kkartik@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 9566c6388ed9..4b37aec69448 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -698,6 +698,22 @@
 			};
 		};
 
+		timer@3010000 {
+			compatible = "nvidia,tegra186-timer";
+			reg = <0x03010000 0x000e0000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
 		uarta: serial@3100000 {
 			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
 			reg = <0x03100000 0x40>;
-- 
2.17.1

