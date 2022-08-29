Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1535A4AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiH2MDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiH2MC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:02:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7D286B79;
        Mon, 29 Aug 2022 04:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TixmucmKBRYiphwCd+ixc2JRASB+E4ERxPRB4P+7F1K8RWdag8BvwWRhfR3D4b4Vm3MBtdSuFoF0eUsiHkL64VMIKaqZ1ARQP1wwIIfJCeY5spHHWM6Qpl5VOFYlNMQ3xCHD0rRh94lPAQIWNNhON8CGTua3NEjlPgrX2N1Gn+BpC3aV/KtJ6b5ARKWhFMO5CxNA8wJRhkI+9o0a+WSiRjSMRp90bECIA10k8lDNnSiDaFS+xUTNoyz0PYeoxOIQaRhyfklX0Nb41PGz/yNLSJdCvtBMFR+es1oHbowWX+3xPbHnI0aeUBVaNHpg3cQPnhq9tnkQUVfVhILJJ47duw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6UKajqs/S/laLntuOMFWN+aKmwPPb05+IjUjthsek4=;
 b=m/qc+4s/ZWEuvWYOdx01woMJDavbnnANxA/lqqNXpn7yZAvhwiKlJQ9djqrz7znm2j6tZp+Lo5rlDC++MmfKN7Ky1yGWlY7sZijjbd1mGWCiDJ8semh1A44WS1lCv1lNLjb00hD4VBrR6SMbeMcAcsbD9s+SwmtLEHUYnkxeFkimrlNymBUtc9lhDCN411zQmXq+2Uk+2ia8D/IyvChX/1bks9whti7gPv/Z/Aqr2lWnGHx6qBM5SjL7aVSWnxVrascqrXZP8021QLa4UEsYkZgNFMa9dQ0CYm+q0nZ/kMBE3/xXMkHI3RcAEvQPuF6CXu05nCtpnIudhv/z3zMYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6UKajqs/S/laLntuOMFWN+aKmwPPb05+IjUjthsek4=;
 b=pKDLD5LNfvq+t1KqaXnOmHUA+OJ81j96KJt5TsjjkE3KhB39sDoxP09PWYZdMoiEliDvSx1nQLOM1UM6mltNw1axu8UotdvVHkCLVDs25p+LmX4sQHqy3vbmql05okxXsYG3R3x6prtfPx67s+swCxqXfpLhkMK7ceANlGsdOH6Uajk1A7nsSJlxlHQ3uSPON/fyMEcTNuL1iYvii3WPioyTrUBV0MZLEdaNUJzGQOGkbem2IVdoAZtvudyZLw3iFFtOQzNsVhuDl1w6x3efE357ePWLbCfqFCKZf5AMnTwLhgmoZFrzP9qa8V1hSb2mvAIs2Tn6XRLuji2trok2BQ==
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by BY5PR12MB3649.namprd12.prod.outlook.com (2603:10b6:a03:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 11:44:39 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::ad) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 11:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 11:44:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Mon, 29 Aug 2022 11:44:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 29 Aug 2022 04:44:37 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 29 Aug 2022 04:44:35 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 1/2] arm64: tegra: Add PWM controllers on Tegra234
Date:   Mon, 29 Aug 2022 17:14:31 +0530
Message-ID: <20220829114432.19566-1-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ec5f4c-06ef-4eba-a779-08da89b3db17
X-MS-TrafficTypeDiagnostic: BY5PR12MB3649:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bl74q31oWeyfgOsiZcKRQ37Vtek1kNi4JKUPvQUiX2qeabL4uIxqg3M8ffZX1DtWcZIe/pbUdRR63SmrgiZQP3lA2LUWWMjYjr2osV6KMxRFMBDK6szzPxiE4FUNXfmn6e3D46oVLvI0j+qQrMkUD5JBKIxRQ2nA5+O+IpL1+3DTwKtYntgQKIjbqZRdjwIti+BtnuDwlJq4x5wLDiU9CRdqE4adZdkfIsj+mq80BaPtkRAo9B193F4CDIOUeDbmBW+/C3NpTEq17MYssKk3Q2k4YxaRYpLU2guIKJKK/UDj34Uta5qaAES1n3gfhxWWcwpEGMYTFsUwVl8FDdHhc5E5RrBgVnZ2UV/QJAovmI98i/GjW6KfiK95pvPGr57nBTVafsdW+kOO2luJR8HzEPnTiAOp6rQ3ZV78294XtO8Hi6KahGm+BE+BUd4yD+6sl05aoSDUbkQbv3UuRIZqoj/bKGoPgF+yX7KP7QCvt1ZOmUlm4VSLMDAJhjx0xiZW/0ESMAFS8pmpYteD+9rjX47dvtliFTCaBDzPsSjRVsd55cCXPJb1p87xbbC0qrrT5zhgqhYPoEJLo33HimK5Xx9loF0aFQAyyHNmSgyM0AUQD8TNTw4T91tzr9/2BRLhbBNM5+8YkSGx5PAbfLkiECzOqQg/lqHlUoldP+HSCPJ2U78AUXJ1d3KdRyrbhWQZRZRfjV7fGlJxn4fK9Tn3jgwrXHCxtjP6znjanaBfUhCB3Hr3H0KhRxwmrHg8RUF6qT2uLFNbmi8NC/ARIe5Ex96q4lH+S45rbn+LBfKf/b3jjwzjwIZVl8OSOs21hMw8QWsI+SJjwD78e8sv+UgGZA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(40470700004)(70206006)(6666004)(70586007)(107886003)(2906002)(41300700001)(7696005)(8676002)(8936002)(40460700003)(336012)(4326008)(2616005)(40480700001)(36860700001)(186003)(83380400001)(426003)(478600001)(47076005)(5660300002)(86362001)(1076003)(81166007)(356005)(26005)(82310400005)(82740400003)(36756003)(110136005)(316002)(54906003)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 11:44:39.3008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ec5f4c-06ef-4eba-a779-08da89b3db17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3649
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra234 has eight single-channel PWM controllers, one of them in the
AON block.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 84 ++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 81a0f599685f..c2dc651f0842 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -840,6 +840,90 @@
 			#pwm-cells = <2>;
 		};
 
+		pwm2: pwm@3290000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x3290000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM2>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM2>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm3: pwm@32a0000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x32a0000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM3>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM3>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm4: pwm@c340000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0xc340000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM4>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM4>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm5: pwm@32c0000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x32c0000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM5>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM5>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm6: pwm@32d0000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x32d0000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM6>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM6>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm7: pwm@32e0000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x32e0000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM7>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM7>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm8: pwm@32f0000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x32f0000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM8>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM8>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
 		spi@3300000 {
 			compatible = "nvidia,tegra234-qspi";
 			reg = <0x3300000 0x1000>;
-- 
2.17.1

