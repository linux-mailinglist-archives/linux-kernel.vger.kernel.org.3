Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A14DAD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354875AbiCPJ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354854AbiCPJ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:27:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C26165400;
        Wed, 16 Mar 2022 02:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFNzyBhHNOQiJ4bXEJcgwOn2mA4WbmzQD/J1GfdZkV8eCDsI8r3p7JzzlSgVHRuED8FJMHPmQgJdElk5QUe+8guT51XcpqMMZQKa8UPLUmryS3Q2/ZcknRi1PShJ/oDn5r+tyFcxxMV3iDx3jAX1HX6tv1MAZlw9Og8BJ+kdovVBdcenCmPpG+RfKXkp/Ox8tQxp90nw63UuSlqThmL7Dw29eyD/DY1Y1qef5eka/XspxHHxiRt45v6oIXmIraQomNcwWrxGKPfnTaaU8qq2NlAlR7kLFyowv+HR1NW3wTmrlAffMsrFB1pr99lT/GwOw7zxAuGmNnyFVHfPPw3ZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBZxJgPheb2FA18iS8FGwu4t6k8PXIVxnWxHEt2DOZg=;
 b=C/pE63wyfNs2nR+S6SqAsN3u/0bqU1400LoJtXt/6pLJx0SY8w08vjjTu7//LB/NKvn8c4VTcFop/XDsalGZuM38le/aGv5Z0amhwRbxS7cdNEjW8m/3BHAYzID58i9QYfom+JIbu5S193n5AMcQDMegWEym7gA/Y99LzNzP8tlQ7IYWI4y8J4Ldsc/4OKeUY+pRFpBM4HxQj+C9ADoJ2NScH/keDkPKI2wqLoHBaMWQqQkX97cVxTRKS2eJeSZFwIVxkADKsymX2jn7hOEI5eg0h2Kc7lefpydlWAOph9r8LdTeE332O8mK+zxPHno9Kn2XrDBH+FeVHroVut6Enw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBZxJgPheb2FA18iS8FGwu4t6k8PXIVxnWxHEt2DOZg=;
 b=QhCckX0K35LY4FniJ9LtiF/zBBW4GHPv5kamynVnSxaAH/3AT4JoYOaFLFStOg3xk2B+BGKf+1SbgtCqMXx+Wu/B4T6ZP28dZNQDI9y8vh63b9NQyfaGMDxvhMljMrW2OTenbIKvXoOm8XDW4x3Mk1xYO2Xm++IHx9UoxmS4Jite0W0eIDTZANKersTbvliA7h617O6btPeAURwFbe1ROtT9zswMg/4RoZhnxfrumsYVZtYFsJWuqenQBkbCxIhGwx+NVpfhFGoHS/sBR3FqklzsNKWmb4nmhejhGbWrst+gWAsbOUsm9UuGDDig/ZaldwhKi5R/YtsFWjI6E3DYUQ==
Received: from MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::35)
 by BYAPR12MB2950.namprd12.prod.outlook.com (2603:10b6:a03:131::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 09:26:08 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::62) by MW4P223CA0030.outlook.office365.com
 (2603:10b6:303:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Wed, 16 Mar 2022 09:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 09:26:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 16 Mar
 2022 09:26:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 02:26:06 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 02:26:03 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@canonical.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>, <amhetre@nvidia.com>
Subject: [Patch v5 4/4] arm64: tegra: Add memory controller channels
Date:   Wed, 16 Mar 2022 14:55:25 +0530
Message-ID: <20220316092525.4554-5-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316092525.4554-1-amhetre@nvidia.com>
References: <20220316092525.4554-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c07ca52-673a-47ab-edc9-08da072f00a7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2950:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29501C079EBA649071BC66D4CA119@BYAPR12MB2950.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khI0LiGy7OvQwz6eNndZ0tGEoSH3/6Kg7CIhXw2kvCspy3rvjg1Ar9abZ4CKpKqHa/lChJqFsWzD4zlV6JevKo0PCRiwiV9FXoZ8/fzfN12gg9BP79wrTUZ9nF9+9M562m2CRVghuliVO/6ZdOlKh1N1KNgJF2IJFtsE/qb9YM2C86cINt6MokOUkJJu6rUMkLh3kkj3W4CApTOceK7VzcC501LjGF3EffVMV+KrVYIW0ypgpcJul9HpzLMFsXcNAm2xhA8iuHuGowXwakKtQUjFQOlRwCyeU5QFqgz7r7hgnsStJ7ZqXA/IS5fE3k6ZRPFNl+K1Ch97i5TY5srP+4/y1mz1SRP0NoYLRoOAczrPVBZL4I8s/8/RnZv0J0Z8fVkLFtevEZqfpn3uiBMGueLQrOxLEH1Ykc6/MiBTgW+DiGuKg5RR2FJkGfyX2ZeOtv0jx41AuErVFQekp1gAFTJDmaLdH4MORsvWrVhAkohMsgY5wVWu3niG2dFJh9373uJQ7pMv8fKleP3B+w534GwcZVxVil3zp9YLL8X3/jELM0izYebUHz5rUyUz/2xC+kMdbpfPNgDDUVg9FpYP/qIdCeKNkk6PSgOilRR3kzAJoIWT5tUU3/m5Ge4oUE+dOXSpvRWkMxL+AZ/w6fIa1qshvoye7ytIU3oAvtNUAgw89cQCJVTQx5k0reWwWBPvBbMQxrHyQ+9Wx/Vvcm4W6w==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(26005)(186003)(1076003)(82310400004)(83380400001)(40460700003)(426003)(2616005)(107886003)(86362001)(36756003)(81166007)(356005)(36860700001)(47076005)(110136005)(70206006)(316002)(4326008)(6666004)(8676002)(7696005)(508600001)(70586007)(5660300002)(2906002)(54906003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:26:08.1115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c07ca52-673a-47ab-edc9-08da072f00a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2950
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index e9b40f5d79ec..9c14404de682 100644
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
index 751ebe5e9506..8a5342b45159 100644
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
index aaace605bdaa..6e33d2b11384 100644
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
2.17.1

