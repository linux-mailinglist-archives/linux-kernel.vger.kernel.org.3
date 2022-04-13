Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9EC4FF3EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiDMJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiDMJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:43:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36036695;
        Wed, 13 Apr 2022 02:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTNehAjbixJ2BRHKOdS3UaKAbqvA1m2txj/XxU/pl18LpWnhU+qspwUK+6xaT+r1zEpa767hNebo3mx9FSQXgThhQKVKP3Q2xZr6MCNsgQ+NGU+QJHaeduLtOITKaV0E0/0KRwVNoSKxg5C37ryESMfgNa14+9mc+3rj7LYnpQtbJZiFBCOkSO2q4Cx5RT29knNevmzbT9E+QluK4wQRsedvZhjgoZv26Gfd3bAC5EhstEkgWANL2cbVXyKyjcUFLAhoeVh286ChEkBiFmpUdIgo6jUeg0qE9ptAnpSce0NHusshpbYRqydzh0t3Ar9owA2H4bG0KRpk6JWC3yqXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSWNXPZ5JdkGyK56sc34phNfkcm1OWBMQxvKxmpdRHQ=;
 b=H07/cBxhpSL0bpC3T1QGL8VoUFGaS1Mxnw2ESwHlTVKSJtJxg0wCvKdBQdEkF6t8j7rMcbUHCAl0+RQ0Ric1/aye3FIRVa78s68W0iy/G8EZxWIoFoyTdHYDqihtljzdrOK2pyRA4i+RqrEa+Igt2AXCO6ohTO4v+tqMkZZf0J2i7PbGlwIgApwVbfqsbJT1jqQ1Y0fhTL1lAe8AC9fvFT7CzSBuPlcNzDlfVmRmK9QNjSGhi5QO5j+1sXBDWxSed7f3kMF4ds/GT8s/CWknFsJFFeQUM7kdwjIlrNPJ51nr2n/29PGlen6C3cXzGdTKtuAKvxkE6yYfhN8BzMHQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSWNXPZ5JdkGyK56sc34phNfkcm1OWBMQxvKxmpdRHQ=;
 b=px5reanFlPsFfe0hdV0EyV10YaWNUkPK41HqLk59Jjw1p69PSnWLgw5FvB/iiY5T1aW+yt/ldzLtERoi8VYWnuZgDmzCrkzDIE/gyuFSeegq9kHNLeTQDSuNcJDzp4QjZ6zPOicybGPV8gMwU6rGbpKTfz7c9mE7Hi1E1iQ1ayzI3aAH4R/HpDByMz6g9nJoDsreP5X0LfzpOcYnTCpPXuVd5kDtlip9xi3hU9CXQkqmF1MueqYmGfaGMDifxGEWvjrSbzVuBCQFp3+pg8XQiLTU5yuTd6zH0pu1QjWw7XfL+n8Ulj6OFO3K7oo7D9G/C7K++k64ATn4JcFHlD/eZw==
Received: from BN9PR03CA0951.namprd03.prod.outlook.com (2603:10b6:408:108::26)
 by DM5PR12MB1673.namprd12.prod.outlook.com (2603:10b6:4:e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Wed, 13 Apr 2022 09:41:18 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::6c) by BN9PR03CA0951.outlook.office365.com
 (2603:10b6:408:108::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Wed, 13 Apr 2022 09:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 09:41:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Apr
 2022 09:40:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 02:40:53 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 13 Apr 2022 02:40:49 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <dmitry.osipenko@collabora.com>, <digetx@gmail.com>,
        <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v7 4/4] arm64: tegra: Add memory controller channels
Date:   Wed, 13 Apr 2022 15:10:12 +0530
Message-ID: <20220413094012.13589-5-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413094012.13589-1-amhetre@nvidia.com>
References: <20220413094012.13589-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c99011a-ae13-45be-db47-08da1d31c27e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1673:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB16731C8DCF94CAE002983A34CAEC9@DM5PR12MB1673.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERKHfFs7tEjLvYqfjp1Z6wyA82AUPXx/PeT7dB79YrE0FoFfSPMO02qI3SDeMMcm7+gFesVbVz1jNg/2n0erasPFbXwKX46eSEFM7dhLXoee9GKrYf9r9mbwpg+bzvQPg5vO0Y/L7RDKdVYM5oy4GHs8VHg9PJXHHjYRT14mAUztL7fUkpnIC6Fq/Nvc6TXx4+ziCmo1tWUw07IHf4iMYv/LkfCn3XKoJntp1TtVv/Ay9NwGbUwWFGhHB3FWu6jMT8mYNycxmJEdcZmv95JbjvG092LVp3MTQg4CfS6kznk1z2B9AN8bHx2ZU5Lk9kyyweVyDRCbn/Rdiqwi/djAa+YmwYhjn60+BjtxmBpLozKjxQxMr3axHRbiGk5YAeK8rtVuYUdDPetZrKlCSkaJfOKdBUubx+fGpIzakWTgsIqJ2RCrToeItuD4R3etT2E0RKGMpkmHa72szD85LOUiTdlbpM0bMyshVb3iM478GGsx5qoG5nhwwaqLcHO3397Kq3ZkhvBh2amuuw7qVkI/TnaT+bngY4a6G6ykEhCVl/M6uRImhSxqVtTXD7/gYPGqlTeau7JFxz93vv0eOZ3F+Chn2rRoe3YJRFlkmEEzhCNIF/xbiVhELXqarbpgcrDKuubDQwqHuO/zjGnCTziwdwG0r+GsgifXNSdR78Fan2BzOhmdRDW0Ig4AhZfZ2PHKO+tfF8XKNHJNCmnxjKcwBW1mpTnNSw7jpC2raj9mWW+Vb9nOgpPAF0vVwGGFwDNx6ouEhGPwAothl4masQCqWw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(8676002)(82310400005)(2616005)(5660300002)(6666004)(107886003)(1076003)(8936002)(186003)(83380400001)(70206006)(70586007)(4326008)(336012)(426003)(36756003)(36860700001)(921005)(356005)(26005)(81166007)(2906002)(7696005)(54906003)(110136005)(40460700003)(508600001)(86362001)(316002)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 09:41:17.8168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c99011a-ae13-45be-db47-08da1d31c27e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1673
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

