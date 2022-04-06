Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050974F57A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbiDFHNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343554AbiDFG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:59:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01434E1261;
        Tue,  5 Apr 2022 22:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6MFkUUfDIuvfpoffYFTp4Ra5Y2HpZvKeCSXPBMaGYeHtN+zQR9zccnaGNL2eY1QmuOEBntW0DoeP8YO8ZaOPhNBxau6ml3kr1oX2NoEb5i1y00RjPKY3kEFkGKZf+BhEtReDU1/6zILnEsCg/b5heLfwTo9+RsSTrYgGF5cyjIcPRwOHDN/uJc6te7DeOIAIIRtLeO3fUSobCL89duduD2Al9o5etPxMN0L6SWbtr6Spuh/l1c1k40STMUl3ciB7k9JeYw0KZJLKTVTYuCCnM+k/9iOIOKctJ6gX+yGzHDvFcKVcnsoPUzjcBe6zNjV43wNB7li4sUPiAEqQpwfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAQ89NzmEAr5+1FrUq7z/wZ944Dr6XBCHFVFx+ccXOU=;
 b=H3thrVBlt02osoESZS1x7NWq+qnIp8ROLifJuNaVf8OszSTE4fki7ffJ0nTUXMXR9g/CZqMR5dBeaMwOb1BbZs5JrrVu3spinh3LBp1L/JnvT7QvGTumzqOqeE/v8ij6LHsxTpqdNdCk4nGHLtk3dxUoChU0B5Skr9LAMZJOJTx0XUPbkYSOTOMZOPj3li9XQwGh2flDuN3pRzUeaNBXNWQWxnWKOx85bN6hViLcau/wSIkxEtmP3Tk129eGoB5GXHe5414Ri1XGSLR4Ux+3KKGAWpv9m0RIGLJ9rU4v7xoFYrU4t8/kmrA1TZwP7kMiQK7tOVvijTr6DU2VFSfyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAQ89NzmEAr5+1FrUq7z/wZ944Dr6XBCHFVFx+ccXOU=;
 b=I/zoqlxEKmd2MkNql1eg3bzxLk1IRVjp5wKjmem3Atz4WxMfcveKD5mu8E8BVwmqLhAjyh8ACmn4nSz59KYdsggQ3V2beyJhZO1l9D5wKX7tic2OIFd9Et13/mgdwZDJjZNYlbtm+epGRFlBgTSjptaLRljhmy5+TIItNLPKocCMKnf7I3Lg+Wq7OjIn1SQKvtYx5wHsRn/tQ8Zd5v/G28GU3GvC+6on3stox59LF1B4VKF2sq4j22WEXGYzbsCFwo3fMXjgY5xw28SWwqVLMaRVQCqLeOdjpIDNL7zPF5V5veKbYFOTSn7YN2BIBt19mW3kmkneN2nSk+fPez+yvg==
Received: from BN6PR1101CA0008.namprd11.prod.outlook.com
 (2603:10b6:405:4a::18) by SN6PR12MB2638.namprd12.prod.outlook.com
 (2603:10b6:805:6f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 05:25:32 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a::4) by BN6PR1101CA0008.outlook.office365.com
 (2603:10b6:405:4a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 05:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 05:25:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 6 Apr
 2022 05:25:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 22:25:30 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 5 Apr 2022 22:25:27 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v6 4/4] arm64: tegra: Add memory controller channels
Date:   Wed, 6 Apr 2022 10:54:59 +0530
Message-ID: <20220406052459.10438-5-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406052459.10438-1-amhetre@nvidia.com>
References: <20220406052459.10438-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce56de8-bfc9-4473-c2e3-08da178ddec3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2638D1CE95E598DEE6942F3ECAE79@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mw7kgCc46+PZcpF1z6lqoHGUGuw0sxNbomf41WovYPuBaOW0rhzH/j87KE76S8x8GEdmnf8hfvbYMCHwxDgEyFSXDCr8DuKxjWuUpl9+sMoWVh4v66Wy4Hb0gc6IWbWODXbjd/sSeDPBdKhAdYn9lbnMf8m33hDqlr0i0jk92aXYa4HbwBpSlEOU56RhXB0DdOLuYPV6QLuvpzCbWcZUN6/YO2jrmFLohU9AEknBqAyiyna/F4tvwiJiNgCzOfhVvEZuuhIWBMYUdjEQaSg4EvSzCYOT/DbGUFNBa9mLUhErl7TBjjZ9hHnGo4Kj69RZK21rX8ZTUsYPaBbVYVUDxVnkFOMvJOTUp4W2hueF0Qm9MHqE5NvXEdiDmgcrQJMDv+Teb2HOG2kuM6c2bzOp/TALnd2YbTYApoo9MrOgZVm6pUMXtq7zYxXv6Y+O8tiMzzmpN0/MZGdHhr/Wf2Uf3AcB2PzvFIEe0bASFeWdS8q2rK3N/Ksop0U13yfPVM2nROaUThltc0d04jnkClISNqnajdMSD9UBQEgENG4llHZTzGYRqTXVpHq5T4eYhzGDfXEpZH/4de+xwnj9zHnjPJAPPJT6lkRD2k01xsBS3tzGsss3HPw9VY4MqC4vGcpJVacwg3jAeMtnsvy2b/UJW7mTbNfV1D8YFDL3UNAFDO9rVtexmYD6XN27vAeNsbfrKXx76hHTY24d2FHSMcWjfg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(4326008)(8676002)(36860700001)(36756003)(6666004)(86362001)(110136005)(2906002)(508600001)(54906003)(316002)(107886003)(336012)(5660300002)(1076003)(2616005)(82310400005)(70586007)(356005)(426003)(47076005)(40460700003)(186003)(70206006)(26005)(83380400001)(8936002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 05:25:31.9670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce56de8-bfc9-4473-c2e3-08da178ddec3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From tegra186 onwards, memory controller support multiple channels.
During the error interrupts from memory controller, corresponding
channels need to be accessed for logging error info and clearing the
interrupt.
So add address and size of these channels in device tree node of
tegra186, tegra194 and tegra234 memory controller. Also add reg-names
for each of these reg items which are used by driver for mapping.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi |  8 +++++++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 24 +++++++++++++++++++++---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 24 +++++++++++++++++++++---
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index e9b40f5d79ec..e4499db46339 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -521,7 +521,13 @@
 
 	mc: memory-controller@2c00000 {
 		compatible = "nvidia,tegra186-mc";
-		reg = <0x0 0x02c00000 0x0 0xb0000>;
+		reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
+		      <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
+		      <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
+		      <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
+		      <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
+		      <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
+		reg-names = "mc-sid", "mc-broadcast", "mc0", "mc1", "mc2", "mc3";
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 751ebe5e9506..88a1a5e426ff 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -604,9 +604,27 @@
 
 		mc: memory-controller@2c00000 {
 			compatible = "nvidia,tegra194-mc";
-			reg = <0x02c00000 0x100000>,
-			      <0x02b80000 0x040000>,
-			      <0x01700000 0x100000>;
+			reg = <0x02c00000 0x10000>,   /* MC-SID */
+			      <0x02c10000 0x10000>,   /* MC Broadcast*/
+			      <0x02c20000 0x10000>,   /* MC0 */
+			      <0x02c30000 0x10000>,   /* MC1 */
+			      <0x02c40000 0x10000>,   /* MC2 */
+			      <0x02c50000 0x10000>,   /* MC3 */
+			      <0x02b80000 0x10000>,   /* MC4 */
+			      <0x02b90000 0x10000>,   /* MC5 */
+			      <0x02ba0000 0x10000>,   /* MC6 */
+			      <0x02bb0000 0x10000>,   /* MC7 */
+			      <0x01700000 0x10000>,   /* MC8 */
+			      <0x01710000 0x10000>,   /* MC9 */
+			      <0x01720000 0x10000>,   /* MC10 */
+			      <0x01730000 0x10000>,   /* MC11 */
+			      <0x01740000 0x10000>,   /* MC12 */
+			      <0x01750000 0x10000>,   /* MC13 */
+			      <0x01760000 0x10000>,   /* MC14 */
+			      <0x01770000 0x10000>;   /* MC15 */
+			reg-names = "mc-sid", "mc-broadcast", "mc0", "mc1", "mc2", "mc3",
+				    "mc4", "mc5", "mc6", "mc7", "mc8", "mc9", "mc10",
+				    "mc11", "mc12", "mc13", "mc14", "mc15";
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			#interconnect-cells = <1>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index aaace605bdaa..216a079ba569 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -507,9 +507,27 @@
 
 		mc: memory-controller@2c00000 {
 			compatible = "nvidia,tegra234-mc";
-			reg = <0x02c00000 0x100000>,
-			      <0x02b80000 0x040000>,
-			      <0x01700000 0x100000>;
+			reg = <0x02c00000 0x10000>,   /* MC-SID */
+			      <0x02c10000 0x10000>,   /* MC Broadcast*/
+			      <0x02c20000 0x10000>,   /* MC0 */
+			      <0x02c30000 0x10000>,   /* MC1 */
+			      <0x02c40000 0x10000>,   /* MC2 */
+			      <0x02c50000 0x10000>,   /* MC3 */
+			      <0x02b80000 0x10000>,   /* MC4 */
+			      <0x02b90000 0x10000>,   /* MC5 */
+			      <0x02ba0000 0x10000>,   /* MC6 */
+			      <0x02bb0000 0x10000>,   /* MC7 */
+			      <0x01700000 0x10000>,   /* MC8 */
+			      <0x01710000 0x10000>,   /* MC9 */
+			      <0x01720000 0x10000>,   /* MC10 */
+			      <0x01730000 0x10000>,   /* MC11 */
+			      <0x01740000 0x10000>,   /* MC12 */
+			      <0x01750000 0x10000>,   /* MC13 */
+			      <0x01760000 0x10000>,   /* MC14 */
+			      <0x01770000 0x10000>;   /* MC15 */
+			reg-names = "mc-sid", "mc-broadcast", "mc0", "mc1", "mc2", "mc3",
+				    "mc4", "mc5", "mc6", "mc7", "mc8", "mc9", "mc10",
+				    "mc11", "mc12", "mc13", "mc14", "mc15";
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			#interconnect-cells = <1>;
 			status = "okay";
-- 
2.17.1

