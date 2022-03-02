Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601B84C9FA1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbiCBIpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiCBIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:44:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62028B8B4F;
        Wed,  2 Mar 2022 00:44:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhFVzGbO09gMEo98qRTQDLkDLqU9adokWoqelMp6fb7vCvV7VA0/LmiEdKJdhQgAzGbJ/fJyX3mOaTwayajW2PhLW0xtW8oHdFDAOlnzsRKvtsy+lszUKBk4Yai4ij7L9wulg5QmCJ9Lj7TUDA5zrycsHF3jEUOpeHuOmascc9DU7GKWmuoUUu5FepdVkSq7HLTBUEC4LGHUk7H+klq29dtyabhmYy+PLpK6ty603PKuIl0CnhoFXAsR15DPGaZ6PpyDiI+taOLhccA6kSwv+8g1eJ2B6GTWiG1U+2OyQ82z7y5VWwjbS73qarh7Co6rwT3cnGAPYXvFy4WPwfzaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iia9kfB3vKHlJBykfNpsmBGMHHqD6ZVAxqnYk/4p1+E=;
 b=Yc/3MRoR+9/ITNxIJn9a60FHouoSdFTAifYsKW2JDw2WfkpB/rZMqgixG/2Sr8QC7kd9tqzg6igZri+ni+slqWG6a8GTIp72dpiHtKwtKE7XZ0Pq6lpygBX4ZAEf7ZdkN3DSWtFFVFECkIaQfF/zz8hqQ+n3if6A25dK90vpPbtX1xmwCwujJvynCAoSB5OTPnXsq5gqw78QUgIZtF8u91wGVEpg988eHyJ/bQhxDazDCHeCpiJHem0uMFtOizg+hpYVW+nqje6UTNN66gzb4Dh9Pm3t9YE/ehpgMfftEXK1bZvBCZui44Yb7IfsWs+L1hX3Eft+syiaQIwPct48Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iia9kfB3vKHlJBykfNpsmBGMHHqD6ZVAxqnYk/4p1+E=;
 b=an9uTajuxZfT82fNy31eKGThhAgwaWeNYHNEA+K4cVYAP1H5oT1KrD6lcTcvq/6Ox6HojznrK+Yyu34Q4ZBZdr0YaxYgoK28dMwvgpppTgIw3MnfnX+bHOLvJSlXpYx33MrHgP2HWR66qmrg37q7TpiRlJ0XM6WskirWLPkgRQEEF4Q4wLB/F40S0OMEbbwZ6wl6SyaOmaF54e6TicTPqH8f7aA38Ox0UaobcUj3afy9BtC5ieXEbIjcxV+Z/akQ89fngpAiDaKXeQIC1dIRBVH0VH2FkFzQHpQurfgVP6N02lyZwjOYxq4nkL7GzziJs2mIB3eSuDgAiNnK916E2w==
Received: from CO2PR04CA0147.namprd04.prod.outlook.com (2603:10b6:104::25) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 08:44:07 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::f3) by CO2PR04CA0147.outlook.office365.com
 (2603:10b6:104::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 08:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 08:44:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 2 Mar
 2022 08:44:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 2 Mar 2022
 00:44:04 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 2 Mar 2022 00:44:01 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>, <amhetre@nvidia.com>
Subject: [Patch v4 1/4] arm64: tegra: Add memory controller channels
Date:   Wed, 2 Mar 2022 14:13:26 +0530
Message-ID: <1646210609-21943-2-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0932f8d7-6848-4d53-519a-08d9fc28d01c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5034:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB50341602888AA5AFF7B33536CA039@BN9PR12MB5034.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ua+9wnIESBkiBj1U3y8tZOB7aRcoGGtBLzKko2xfAPNA4mT7F8P6cHd5Dv93/5/H0FmF8tjvFWNjybBDde3iuTg9ddZM9xZ1oQAvo7croAcefEiZlL1oRr7GnqtbVxIW53XQiXkQTYAXnO8nCd7RVsA5+oBcbnGYS74+sRIzjFcHjFr6gqNj27RXcyBfBmsd0weRPgDwsJbOrZLsYcoQt8rJfXjLW1XO+d5TO8thve9RchL8JF8TSnmvhohvAcH50U0axzWUXADBsG2WR47sdswIbM+wCo22Md2BN0ku6OQZ7OR1kwfcYjMtySOGWdFLV+uBsLRZnEGMZ/PNGe5ZfZOjS+ijx9E0ltg0eFsvn/QkIUNYnlutfr1SYImLU2um2yYwCpfWsUmUPuf5HzBUiSaPNYiePMEiEwWSaEBeq89zMYLt/J/6o5gRg5kwSiVWtzvG59fQJwdOftf7ZCUTeE4JFcNIds8RlanAemzUlWEDwNsRTVQs7Yuz5vFeK+nwWoSDyxa78mEobax/Mrq0+9DR1iAU8mkKAndidWpszLoRQvTEkHKa4XtFiuhOK+TF67mlRcZxABnPguxBgbPYClxXhwxHuMGwflmNyqRHVlDnJ6lFdPH0bDacNlhxmGBbX+MPwQeWAAsOCGtjlYMN/riegOZMWCxHTFXXcS4qvokuRPyIbBeogPl+sUXaMGUAR5nGEsICjRR6shfz5OWp6g==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(26005)(107886003)(426003)(336012)(40460700003)(7696005)(2906002)(2616005)(82310400004)(86362001)(36860700001)(83380400001)(47076005)(356005)(81166007)(54906003)(6666004)(5660300002)(4326008)(70206006)(8936002)(508600001)(36756003)(8676002)(70586007)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 08:44:06.8950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0932f8d7-6848-4d53-519a-08d9fc28d01c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
tegra186, tegra194 and tegra234 memory controller.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi |  7 ++++++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 21 ++++++++++++++++++---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 21 ++++++++++++++++++---
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index e9b40f5..9c14404 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -521,7 +521,12 @@
 
 	mc: memory-controller@2c00000 {
 		compatible = "nvidia,tegra186-mc";
-		reg = <0x0 0x02c00000 0x0 0xb0000>;
+		reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
+		      <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
+		      <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
+		      <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
+		      <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
+		      <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c28bf4d..e19c56c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -604,9 +604,24 @@
 
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
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			#interconnect-cells = <1>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index aaace60..6e33d2b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -507,9 +507,24 @@
 
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
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			#interconnect-cells = <1>;
 			status = "okay";
-- 
2.7.4

