Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B805D50DAB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiDYH7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241535AbiDYH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:56:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3BC28E05;
        Mon, 25 Apr 2022 00:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3ggTTIG83fS5msJIkFJpKreB5atgjxpuMnXre2ZVPpJgOCE5NVIzvg6QVCP/xogn0hOSfmcfvZkHjJVhY02L6T+/00mvSzXkvENib2INbK93+SOIGdAyIAmX3q39Evam0Gzi77dYbzMyHMUtfFmSQwFdFYVt1iuASKhzAsnuoU3NpxwVmfKCqju/vi9bheOy4BLTaDy5NHvfv4XIpvHev5mBixyRDDmx705dbu1IANKv7MGN50VBOcPN8/Zzv3QUWj1A7eUVvRQMbMt9twjOj5ICrCLfQiKBlfG9HHPoJeAfOkq0x+nxr/+IXbDo0NVm1cIFrupS+H/Pdk5cZibYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anC+ehS2AzQ77VmY1BkzOv8ksueK2k7xrIgl9LTGSdY=;
 b=iwlZ9CakO3G11exSyGC17TBjXtst6CPnMfzp2LgVBCyrV2udmxC2R2l4DCwvKQHuV2DKQpV/suYChTs9HSTclapHJZ/yPU30xNm5r7xJVTtcMu539cRKJ7hJD5RkvCeR87q+QZGaBzRAvGG20BrIkJjccoIe505RTug0rEsxzK639PF00Tt8rIlPNKgPijWUfgnwvUghDHwkwAP9lK6G8LkTUA5bUsTXa8eErShY65M9xF9VnhreCJ5x68qxFx+8rt3/Mv/XrrHpAMVC8KliEeeHkgFAHPmVPF9UcMNmhATdSDDSiaGNUQoAjNccJUDVc27L6L9K4/hEk8KUR5Lc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anC+ehS2AzQ77VmY1BkzOv8ksueK2k7xrIgl9LTGSdY=;
 b=Y6BF/JuvQ3JFycnfST4U7EsQE6y6re5H3dTj3HrDQJYEoU5TiNl9VodLuPFoorAvA9o070NvZopKZaYUhOVyGn44G4YsAsjEwOr7YoUIqP060NSqaaWpLL7W465nKbrngdvZ6vlnCj7Hq5HPdq8WLi26UHxFutELRtytGnunUFQMf1nesLkoa0Vj224+3yxDx7ZnvQtLDBT809uyRrf9MkWip7CWaks1e5MrmmEXHVU07p4luI2kjvBqlDEB6EBiPzhiODBMLKCPLnV5WB8CyZ2UYM+M4L/Ds4GDGYWTeTyvOEvsiFRLUgYDJQM8m7u8gQW0usOsqggHkrD27lk6Ag==
Received: from BN8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:408:ac::45)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 25 Apr
 2022 07:51:23 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::5e) by BN8PR07CA0032.outlook.office365.com
 (2603:10b6:408:ac::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 07:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 07:51:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 25 Apr
 2022 07:51:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Apr
 2022 00:51:21 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 25 Apr 2022 00:51:18 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v8 4/4] arm64: tegra: Add memory controller channels
Date:   Mon, 25 Apr 2022 13:20:36 +0530
Message-ID: <20220425075036.30098-5-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220425075036.30098-1-amhetre@nvidia.com>
References: <20220425075036.30098-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39c65097-e92c-4e75-d624-08da269064c4
X-MS-TrafficTypeDiagnostic: MN0PR12MB6032:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB60328B5833DD63119184397CCAF89@MN0PR12MB6032.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2HUCg85aDOoBRRmZQQH4DPNmOnLskHhd24/XxsSys4CK1+7zHvMsTrB6c/P8t+GRo0HDM1xo1KaNuRSpEhh5H+Mi4wh4TnJSRzglTBWWBcmeVefxkvaje29D3T5wsjvzlfAU14vTUKMYUTXW8E7hcRELYBr4qcojy3izccuvbmtFnzFUdk9p9ovdrowAjs7jR2EIRrtI8QBfTRhodx4xHnERijZBVOPTjmw+gRjETn7D/yfjE1X6KpW95zhF5zAOjKShsWv42LRGrcEemZCW6oUQuiUspst9nM9XheDFCpRPLkG38DLGZnuqtZwZJw2T7XG4Ar1PC6UhhkAGLywtmPkY5VWtCNKn+uUnqNwurcEcfGWH/Ejxd/TMNqZelSe2hVLsdyRsQa8d/4Ju4gzT4IhBdAUjIGJxdYYemAySgkCF3dutHzysH2HmsWn3q/qz9erC78CU3F+JzrGOg2QTiFo38l06ZAKypoC3dTzM1iwxpDQaxyU7Tv2rGsdCRuHrRx/MXG1AxRte0SUTcwum34m65gLBBQ7B2bT1T1D/bDQfeBYK0iszQbnbqrg9P5HFGMUxr3EJC5xpuRF2n3IKXaisYvxZ/7ra2fE1yJ5vo9Wt+xq9cTJKRwtxAjX+bOtERGb5WgmhczZMBY9t7bcK8+mp3x3GquDx8rFQ15Rtc6TXkGpEcEAX5NkQd+s5XPZ6U1hct0NWh9klw9A6T+XOLEBCy2zdzbyQzj3aCMkZe0=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(921005)(81166007)(26005)(6666004)(5660300002)(107886003)(2616005)(1076003)(7696005)(186003)(36756003)(508600001)(2906002)(8676002)(356005)(36860700001)(40460700003)(4326008)(83380400001)(336012)(426003)(47076005)(316002)(82310400005)(54906003)(110136005)(70586007)(86362001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 07:51:23.2395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c65097-e92c-4e75-d624-08da269064c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
Add address and size of these channels in device tree nodes of tegra186,
tegra194 and tegra234 memory controller. Also add reg-names for each of
these reg items which are used by driver for mapping.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi |  8 +++++++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 24 +++++++++++++++++++++---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 24 +++++++++++++++++++++---
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index e9b40f5d79ec..a7b794de1637 100644
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
+		reg-names = "sid", "broadcast", "ch0", "ch1", "ch2", "ch3";
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 1d6be5774fac..26c3a527e99a 100644
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
+			reg-names = "sid", "broadcast", "ch0", "ch1", "ch2", "ch3",
+				    "ch4", "ch5", "ch6", "ch7", "ch8", "ch9", "ch10",
+				    "ch11", "ch12", "ch13", "ch14", "ch15";
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			#interconnect-cells = <1>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 8767dbe2d066..69048b450db2 100644
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
+			reg-names = "sid", "broadcast", "ch0", "ch1", "ch2", "ch3",
+				    "ch4", "ch5", "ch6", "ch7", "ch8", "ch9", "ch10",
+				    "ch11", "ch12", "ch13", "ch14", "ch15";
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			#interconnect-cells = <1>;
 			status = "okay";
-- 
2.17.1

