Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55D50F2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbiDZHmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbiDZHmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:42:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878FD1353B8;
        Tue, 26 Apr 2022 00:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN8HbouCzTn5ugMMeEsKZmT4jqtPJXIdhURVsjM4cEZCkdrgv3TwD3EEv1fjmXedRUEW09hCoUhFZyjVOiCeSfyFRNniSknI7R51AWuCfuNZsNZO3ttGr7th0IoAK/fFoPPQ+bsWt3AHyqVS78+3H5q9UpNUq4wuFjnY1WT8J4EZiBtyZ9w1K6SCOvBsD7s67I8vqHqXWdZQf6njz/SNegxkiskO16a7GCoU53IzvFrE6sBr8GAAp53j09eLnMTp75V5oTYXTSfLVKZh0l3SaCjeR9z3hqfwIBFr7Fp6f13mSC93W6Sqn3ouSXdRP4pS6bJAO3lv+21QPyVPquYcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSWNXPZ5JdkGyK56sc34phNfkcm1OWBMQxvKxmpdRHQ=;
 b=OkY0iiEf0u6fhPxH/gLGsRqSV5R7ItJR31LvFbYpvua6rVptcU4xQV5W+KvuIRYUrW1+sf5T+LOgsehGArHdhlG/GcCt9dhO+9JlaoEE43vfEf2UqJuOU5T3DbT4mkrRN7/eLWrFHgyxZ26hGVJPvowBrZdThBgPYlOC37O0JL5YBzLLGZ22A5mzSvAe3weRj7Qaja9pl9nb/uG0CcpMljsF27gHVXb8xUoO0T7URmPVpV+nlQiCbq3QCb9NbYRuT/gdlJNbzFtXH4fLWfMRiLn1AZgyi8sTU+BuAI+ZBsXYv/rn5GvU+7RQLsJ7x4gZgFiNj1rIt5KG25trM6jGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSWNXPZ5JdkGyK56sc34phNfkcm1OWBMQxvKxmpdRHQ=;
 b=Dl9rjE8haNNBoqmVLfuq3i6aKhFXNHfSRc21x03SgibSXtBlhB/I91jtpi8cVwG+gQ1fbFlpgSE6UKStRJCE9HoRYShb+V9hOfO1aOGiXpOZSowiXTZKLxDtRycK32M/auTrbKDSU75PNmvf/X9G3SlyhLQz+BhNCqgFWlJ63yo7GnV+xfU+hwrts6YFat0DV+21yQpakC22wpJNQnitu5WKFYcgu0buNQ8BQZKOnAvwq6BjDudoWMzxgrjD1qpfdvhVFo+I0dciXW7wLX25pC2Zj79NJVxNc6WYAzN5pO7h4EqDpe1kJN8ZZdunQbTQvlOw05eIr6jWwtsW5hVhiA==
Received: from DM6PR07CA0037.namprd07.prod.outlook.com (2603:10b6:5:74::14) by
 BY5PR12MB4642.namprd12.prod.outlook.com (2603:10b6:a03:1f6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 07:39:06 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::8) by DM6PR07CA0037.outlook.office365.com
 (2603:10b6:5:74::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 07:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 07:39:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 26 Apr 2022 07:39:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 00:39:04 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 26 Apr 2022 00:39:01 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v9 4/4] arm64: tegra: Add memory controller channels
Date:   Tue, 26 Apr 2022 13:08:27 +0530
Message-ID: <20220426073827.25506-5-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426073827.25506-1-amhetre@nvidia.com>
References: <20220426073827.25506-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2645b929-9287-4de0-40fc-08da2757d7c4
X-MS-TrafficTypeDiagnostic: BY5PR12MB4642:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4642747CB95C7E07F52F5103CAFB9@BY5PR12MB4642.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYcFp29dXOPB5q2ggbJHs0JuGdw5Yj43E4WVyltpdfXDA2FaFM6jTp8Efr8APLTZdbRFnj3yWX6AJw3sGK8AmblYfvSRgD3VEQ5RgOko3Y9F9w/l3ir8ueRrCIbAVOvLlz+8PV6TP340wgfHhKUKtFNTIi4VdwpIDwXh/a0+aSBFH9gQCAGaj4XfMNvFb9B9aDOY83/trc4sYsjGcz/i7ATn2b7jni1IEp4AnO3X/PMLwlXt9/sl24onGJHyBwHUmNz7HNXA88KTt7Pi4k+zpfR9fE8Bw4ULWd5MsSRGR3tfJlVPXW9pYLM0JOrIbabToqOzB/g2WonUQllwXpWM9BORMHuz0zLtKDqX0tmH414jjJAWXfijCoPtsT54eo0qzjqGH0kJfuhAA6svjngfSlUFe3sH6AMFaspyywi3e+fMZrOH4jNuz0HIFf2Pd31scYNX/8Y8NgDh+E2XlaeG5y0ZjKTbuNZ6Xv/xb3CLwb8rOk2I9OL6LtR8QC6enPLg5je31hWS6Q6JNgyHrDeX+XuB86aSx5S8UroHknH06BV38q9aT3h1JVoY8vsRlIz38AmzGO58v2Xt9RW0vKUVQJvZI7PkvxNWEviRyj4E5LZXVr90aETfEExiFEeygGMUC5iazalp+QjCerR0kaTU5H5/1SeXoOO/4tTXrSmB5X0b2YrMlsxzPTnHdd8ZYvpnTbVML/coAG072kzmMRKQOQbPPXNf6/PRahTVF+TIPaE=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(7696005)(336012)(5660300002)(426003)(83380400001)(1076003)(8936002)(186003)(36860700001)(2616005)(107886003)(36756003)(26005)(82310400005)(47076005)(6666004)(4326008)(508600001)(110136005)(316002)(54906003)(70206006)(70586007)(40460700003)(8676002)(356005)(81166007)(86362001)(921005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:39:06.0853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2645b929-9287-4de0-40fc-08da2757d7c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4642
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

