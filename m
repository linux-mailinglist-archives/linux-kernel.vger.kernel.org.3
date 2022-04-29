Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC7F51484D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358564AbiD2LjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358587AbiD2Lii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:38:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126325A098;
        Fri, 29 Apr 2022 04:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QENsONl9vL/J/ZVy4L5F8yrIFK5PJTj++h9wWXDPNte0CxSHcnsMjyjRdFgbjegxs2x2jpt4UO4K2OkEaslQQEAAvE9iydR7L8keigyoabeCssDmvSUS1ariKbDRQwqFgLHl3B2iKeXoeyHffScRzji70VI/fA/Kt0xcGmqOJJHTnGLMIcJTGBat3wpWbQ/S+Lxz5u9v4Pg18elfkggwzjZaM829DKiSeFSQu+5Cr3SH5FhAaXdSIkTqdB42Y1Qs/soES9dFrES8DUTp3gOPW6K7U5gxw98MsPMNHmQLo9QZOJXdVgaqa6oR28uaxi2ozySaCmg0jLNwOG7ZSRkQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+q/QsjJoAzSBSFFP5lgJZgrw9zQYt6YPu7xh1+ndPk=;
 b=RK3bvMAZHlfaZySv2XYO5hjSqEPAf2NFtBifNFC4h55an+3KsRTtcniNQxIvrVtbuRkNlBwOgeGeT8lNlf96AClNPbcP4n3MrqwMCcU8FlbYgRa/mcglCIVjgGF1bgS42yGbfXkFbNprZtbyxCJUKHw5wQUdnPCm8J9ooEoLD1GrBhK1KIO91rlTOsx+uyQLiO+DSjpqZFeccmCQrQM6h9q8ytiw9GCcMU81MiKVyktgsvLSwDC3OMNCxndqW5J/DzhR+4ZVWxL2XGZQXO+gUSS8hRsqaWFJuwprVjC35haOoibO9FV6X2x1x5oufdtK1b7bOox5jk0PudEM8V/QLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+q/QsjJoAzSBSFFP5lgJZgrw9zQYt6YPu7xh1+ndPk=;
 b=DWo26xkmNjNH52G20VQQiWA82kKyo3LEf63ePMG2Z6R/aL4SY7c4OrgNUurdIq2Rcut1zjrMLJKFQjmTKmo7lHSEdHhgiqXrGzcIX416WMCGq75WxQ+rF5VqQ1Ay5s849L5S2ZclZlLrnjo+ysUc/bieVfA75IGV31Hxp3Z1sjHpFLMJ4raUK/vBe5pVc7sZdFH8wpAape++ccV3jx67hhbpk1DKi77+qEZQS6iFsrvF0aOg+/Ca3s6VcXwjuP382CkDMX/qnob2+/JwwHflRxko1KpDlMCo3FCTkziGo9JHrccRO2R2eboyhStO0s4DpHB8FCYOovmBkbOA5b+rAw==
Received: from DM6PR13CA0019.namprd13.prod.outlook.com (2603:10b6:5:bc::32) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 11:35:09 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::8) by DM6PR13CA0019.outlook.office365.com
 (2603:10b6:5:bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Fri, 29 Apr 2022 11:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 11:35:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 29 Apr 2022 11:35:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:35:07 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 29 Apr 2022 04:35:02 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v10 4/4] arm64: tegra: Add memory controller channels
Date:   Fri, 29 Apr 2022 17:04:38 +0530
Message-ID: <20220429113438.13988-5-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220429113438.13988-1-amhetre@nvidia.com>
References: <20220429113438.13988-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67f8fd5d-7060-48fe-265c-08da29d4511c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5729:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5729B4071C27AE6B1CE9875DCAFC9@BL1PR12MB5729.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHvso1OeheVpd5xPBKwsSc2SOeKMg3J3GAfDdWMh8hf8yfNgeGbciydxiSbubCpcTvjTiATMpNPWOEHY9H7Y0hEQpQJcabqugqLPEFyuW4l+5E2Go7eTc4sVUznvTwdgQ9SGhZYCkLrPgtVD0PyhdtL52QN5WP+IUmudDvKgL7kmktcMEy3N8IRch+7jCciuZAKPG8GJBCnBbKQ/uMT8QQ1qYsh+mYsRcA9v7TuNy7dxlocJLpp65fpY1sE24k0M0mmEZQMTfzVLJDAgoAXIP6Syh+vzCz/+Znd4iSNgWfZcDGc8Vx8gJlgQOMaoQ1dAPZ5iZMr0KPNG6OhO+ytiPsOpN3H5jzvDcTzWI3DMLLeNbld0ce1huP/KZ2ig/ikVjC8Use4GATo+brHRW4rPsui8wvbHnHLlj2Av1OphssM1g8jknT+pTsPEBgSyzlfx5VDq61bPGid4zZStcckaN5d1IolyedZfts00Ceey3yfZ/DPM9213xgH2iW3oWNBzzjNZ6JTwFeX6Yz/lDAI1E0YmXnqtcwgN3gAyq0/NdwM7Ix1WEjk9bc1g3ks53Vbrgn3exqAUhM06JiFhBYuqNDcrmbW6z9QPL5Dmwk3K0HUgNieXFaXP3oFBy7pwrBleetvUHow+/dcIYNNkXjyo8hx5kchSYc2E6vtLd/bZam7lfXpwNXwW4EjZNxOh8Rn6lFUQxZf3rxVkwa9bkipXXISba25jZJ9mA4huliDUI/w=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(81166007)(508600001)(8676002)(54906003)(82310400005)(110136005)(7696005)(36860700001)(316002)(36756003)(70586007)(4326008)(70206006)(2906002)(26005)(186003)(5660300002)(1076003)(6666004)(40460700003)(426003)(47076005)(336012)(921005)(356005)(8936002)(83380400001)(2616005)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 11:35:09.5857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f8fd5d-7060-48fe-265c-08da29d4511c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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
index 2e7faa1e0b9c..0e9afc3e2f26 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -528,7 +528,13 @@
 
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
index f9d343b24597..d1f8248c00f4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -612,9 +612,27 @@
 
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
index 71c21d7d0551..cb3af539e477 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -515,9 +515,27 @@
 
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

