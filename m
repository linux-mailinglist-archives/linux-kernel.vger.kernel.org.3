Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF64DADAF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354922AbiCPJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiCPJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:46:15 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7063BC9;
        Wed, 16 Mar 2022 02:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPuDySG6OraPU4thxWc1oWt9oqS5c+zrRx1n8fLR0WvgzlrjoylvRSaNfQVRVnoLuj3YGjVcCZ05CwP5gtMqBqGGvNMgQReiQ3r399DQsSJ6sEC/L/va4QHxUqNPxB8JNW4jMmhL+47oBVXfBIrlEoMxiVMQvgM1xCB7UZ+BoYp7h4n7dyIKmuhH7tRaq3/kVw6MCQFhg2QACtPo4DZvEX17NQmIfaICr+POiyQIujSojXxnOsGCewzWsiybeshf6gmwxsPRQQlx5d/1w/S20ExFpCBBw63x5A6IjwCPitaEMaM2NjMxGz3XFfpWJL+89VBbJimwF+/RsqFkU8mQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIdVyxpPt597xe3abzWP7dZI94IDtz7fWlv4Que4PqA=;
 b=L1eqrlvToi7rclL2UzskvqBxILzw4FnoHZYZYmUIH6RRcDIy8BGGOPgMlOaH9GukKlNaXYIHAfHntJYDX+KFwndsrk9/AyEYW4K1h0q+/cssGKuIKWm/Sb2l3cTEg2Wt3P4I5O2DWMRwYTcKPaMRFQEHaJqsSSJhhEv3DGNrluaY02VAI9z49hv2IKN1tO0gYONrV5Vp3CGLomOWGneRXUfwkNnOuRIbtOFqjXNK/7jLv68V6/hrZ/vC3jUik9H8GQx0UEOvJJDGbK7T0fwDOBXf2Wy1fk2z//V/6JPgnx8b3/EWW58+HN1MTDqtMUD2UaEcHIe159chde7ad0I52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIdVyxpPt597xe3abzWP7dZI94IDtz7fWlv4Que4PqA=;
 b=YiQBgUvufhNV7ub4DH2mXQlo/RC8XkC8diaYqTzY6PQJ1KxSGSTvwLfqxlBbVrzAvSwNI6XAob7YX+n46i+Ay9FMThDw6xi8sBN28ZyrGxjca2GT2NgV5CJpEIL/UXa8XOcVSukoyfGq2qJJpRjNBrWlV7e/3H1YXfAa5M9sGcgpDpQhJtdGcGlTzjxmWKfqdglh9fXQIgQoNGzSGq6FTqcaraRWWXm12RoTgZd119S5X3xiX3JDGeJI8lHWqdBE9qAC8WNbgu+LpeeEWhHAHzXrOylLLoIPe26mesG7Hh0q5nKt5J9SFAMCm0GvGZy5GVMFz4uWhXG0tWs49M+5wQ==
Received: from DM6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:5:1b3::25)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 09:44:59 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::9a) by DM6PR17CA0012.outlook.office365.com
 (2603:10b6:5:1b3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Wed, 16 Mar 2022 09:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 09:44:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 16 Mar
 2022 09:44:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 02:44:58 -0700
Received: from anrao-ubunu.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 02:44:56 -0700
From:   Aniruddha Rao <anrao@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Aniruddha Rao" <anrao@nvidia.com>
Subject: [PATCH] arm64: tegra: Update SDMMC1/3 clock source for Tegra194
Date:   Wed, 16 Mar 2022 15:14:45 +0530
Message-ID: <1647423885-2569-1-git-send-email-anrao@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bcd9a7f-7cfd-4ebe-73d4-08da0731a327
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB441681590B47AFB611291019DB119@SA0PR12MB4416.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKmyyskh8S/c9odzA44q7fZHSiudrMvz31u+8aGkvuoAfnVyhIUnMkNxYnWn7vSwLQJDfWv1htgRvYjA7pIb6V+EGrIj1g4huImaZuuABR7Gl8aA4XkCom/ZHagVV26Fla7e6VPMHOnzRf8c6kik0y8COMRKvR5UP3ZKJ6aEmwrOokHaIWeAffh62Uq/NPvE7+0zBXPZk7GiPV53PdWuXzPGZWJuBPdyqng3wuM9hBH02PzDsO/tjK8eBK+BFyp/3QoOFip60AwBmjPL5dP2oGYTGdbPQVmR1hc58++DJ+babkgbjALzsCb8ke1zyDyH7XCqyq6sbCgoy8kJ+uw8Jg5BF99G7nuPC8st/k74wEtMMoUd2Tty2QBPjlZvpirjUOSR7iTLFI0gG55AbfXIRpqzrvLfrCJvwkVYowhwLGPnhG4qE17rXG9KBU/Mbj8mIX2IvLw3zSfQQ9u1xJbQuoVoh32ijZsyZfhQVLgpeDGIReUB63XiwnmFvcrUv+064dMGvcTy+ysht1DIsRgT9fGbD0gwLkpz6syPbr5+X2ckat+W1QStmf3I2nt7P+0JsiidzoUSi/zTHSNgXP+VVj1fYL3WLz0KU8bQVV7XjWuUZdAeImsXLGRM/Pl+/m8aGkT5Sn+kvJNpGiHoFLFYdyfzk+N+lQVEosqOCmDyexDc+5FiQZVeDzizHbD+3RCETctrnAgZfiO7lUII1n/5ow==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(15650500001)(2906002)(6666004)(508600001)(4326008)(70206006)(8676002)(70586007)(110136005)(82310400004)(36756003)(86362001)(2616005)(7696005)(6636002)(40460700003)(316002)(186003)(26005)(81166007)(356005)(47076005)(107886003)(336012)(426003)(54906003)(8936002)(5660300002)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:44:59.7316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcd9a7f-7cfd-4ebe-73d4-08da0731a327
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default parent for SDMMC1/3 clock sources can provide maximum frequency
of 136MHz for SDR104 mode.
Update parent clock source for SDMMC1/SDMMC3 instances
to increase the output clock frequency to 195MHz and improve the perf.

Signed-off-by: Aniruddha Rao <anrao@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index aaa00da..a6e4b53 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -887,6 +887,11 @@
 			clocks = <&bpmp TEGRA194_CLK_SDMMC1>,
 				 <&bpmp TEGRA194_CLK_SDMMC_LEGACY_TM>;
 			clock-names = "sdhci", "tmclk";
+			assigned-clocks = <&bpmp TEGRA194_CLK_SDMMC1>,
+					  <&bpmp TEGRA194_CLK_PLLC4_MUXED>;
+			assigned-clock-parents =
+					  <&bpmp TEGRA194_CLK_PLLC4_MUXED>,
+					  <&bpmp TEGRA194_CLK_PLLC4_VCO_DIV2>;
 			resets = <&bpmp TEGRA194_RESET_SDMMC1>;
 			reset-names = "sdhci";
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_SDMMCRA &emc>,
@@ -921,6 +926,11 @@
 			clocks = <&bpmp TEGRA194_CLK_SDMMC3>,
 				 <&bpmp TEGRA194_CLK_SDMMC_LEGACY_TM>;
 			clock-names = "sdhci", "tmclk";
+			assigned-clocks = <&bpmp TEGRA194_CLK_SDMMC3>,
+					  <&bpmp TEGRA194_CLK_PLLC4_MUXED>;
+			assigned-clock-parents =
+					  <&bpmp TEGRA194_CLK_PLLC4_MUXED>,
+					  <&bpmp TEGRA194_CLK_PLLC4_VCO_DIV2>;
 			resets = <&bpmp TEGRA194_RESET_SDMMC3>;
 			reset-names = "sdhci";
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_SDMMCR &emc>,
-- 
2.7.4

