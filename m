Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA595AFC53
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIGG0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIGGZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:25:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5147C1BC;
        Tue,  6 Sep 2022 23:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqSzUJYXfoUMY+ThH+hEyfebBi0XiYMIatjUL54LreibbeJidQlL7wgNxbMiO8YgS1vDnD4m2XcvAWYacadfSMjF6nYql5mg+EU3hLk6YDzsXTCvcnw8xe2rHRSlaQhRWANmiN4lVGwgbwjAz8IQ0tKcGZIT8cSETNk1fQ/HBLW5BnFzXZ3/5gzyxWxkIDIrHz/p1YLO2G0zA97UHx/IJ1OZhlFW4UIfqmWPL0+gRthy039tJbRk/qmK/q3JwL9bJLZts78bFDuhzWD2d6+SVdNL1Oc4FIg6+gww90Af7pYC2YZHe3vQJ7kcoVxFIxkrIGSvDy//LtUK350B8znN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZN8nHAe1WXaPsLpUWMGbfvat2fW9F7u6+zKcA5mSTw=;
 b=ECoKH8hJvMPHalQRYVCC01FaiBDgCyVmM0ZieHHnx+8cYMkjNVAmXkWLxmQvgCF5/X38BNcz2vSMVGXDgiI6e2UfTs9Vv7HGH9cfUgOD+Pc/K9SKSfmh63QOi/Zy0j+A7DxBqOEqt/DOiFTqYREJMHjw5P3ggu6zcAVeNJJtryDJ7S1HKzTXDfZHLgnuw6KvNC2AwF2aUhDtgcL963MUL9XVveuGg24IlEojDSJWj7MB1OxhbifyQz5EuZd187QpQxNpI3tupM+0Kw51OsmKmg8qSr3jFStvrME8N2OTPBsNtW703vbPnBG8R1Fkr6RzHGM2EDDvN1pMeaTBL3/5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZN8nHAe1WXaPsLpUWMGbfvat2fW9F7u6+zKcA5mSTw=;
 b=hV4w5f2EyVcP2RSoZbUHvOUUMiiaGK1TflIbjChFTYdCv5pGvJwgTfejWmzxvqV2IeLDO+O1MbLbb8OsfSqkJZQ53h+62o2ycXq44j08vboYCNnbiea2BDEBc/Nmq9Z6ooGLj5D7WPdb+LFJMyzEx1WorM+zVnh9xergaP32uPD2B3PfwJosM6rattv9C9yktOTrmUMA9Fvkv+MIfWp3jG3UtaehIk5azx3aFa+lc5YAsssYQdrkM4WyNiC2AEaZ4WlLfIUnH69UiWaKJ18ELPFD4dUulSpDZ8sc7icqz6zzNcmG55kYQlfFmXxCgsxfYfhN9FP84dWLjQ3+uoFijg==
Received: from BN8PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:94::38)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 06:25:56 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::65) by BN8PR03CA0025.outlook.office365.com
 (2603:10b6:408:94::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 7 Sep 2022 06:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 06:25:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Wed, 7 Sep 2022 06:25:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 6 Sep 2022 23:25:54 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 6 Sep 2022 23:25:52 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 2/3] arm64: tegra: Add PWM controllers on Tegra234
Date:   Wed, 7 Sep 2022 11:55:44 +0530
Message-ID: <20220907062545.30203-2-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907062545.30203-1-spatra@nvidia.com>
References: <20220907062545.30203-1-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|SA0PR12MB4528:EE_
X-MS-Office365-Filtering-Correlation-Id: ef446641-216b-4819-9d5e-08da9099d24f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OJhd4Ok1S55PylFjXXpbb6347su7CIcJ7VaVBpibZ42upgwsSTdWT4RsRq8TYcKu21KOXXc+RoeFPnJZCO9+0YHhkGVWBavbBDVdk2DuLbT/GUWoEk5oYQGJePtbEYgGKhM38N1Xtr92qh7KULdeB7Z2zZhQI7c/HxD7Tg0aX/xwXAJ6+fSGK3MphuIWSCHzwRI3jP1oH8R4xZIEnbY6SymSmYBKwbkk4dGVZ4+CjjA8AF9Ph6RCdKPyFFt9nwqkTbjF5J16j8X3pIUf9WSU98VaCtwy4TVLKGEFffc9/0PgHWsKta+db1RwUhzYo8HQXkcFgoNqseNsqI4i6L/nn+lrdghzqXneVtSuIQPu/WjBfTMbZG/BVvMUaknRFPPGNwODVlCCycNw9ceATo/CmxYqoLUTE1vcjFy1dJQ0Gb875FeLlRh9GYPCAivfg70v1SMFqgUBW67YlFYVDWZn2e1r8Tkm695QqcRIS+EZKhK3J4r1Zgr49vLlxmWg9LIOdUJU72mljTwfEo/GcXSTzZOxuE/K4qa7rPH5VVPfGUJ8aJHZWCKZs6lCsGNoIcrfgqMMF1NXDMbOTGQzxd7cX7S8neqTQ6rK6pbd1xy6t2CPfq/U5INsDsVomkAq3hVI9mIR87IV1FN68TtDJuiBlRUCudG4jleDcGjawKOuEHlWeK4B1caMR14UZNcaHnkauEKMaOC1TIdDwq00Zuv94xr4OauNah8aS/Fu89It7LFmqq3aSAOi6TUT90nawBn6fdFd5oJcA0JF2FkZKX+F4dL7WF5ODj/dhzR7or3VxHoi3MPhb1RntjtuXutCqyVfggxsUIzq9Qn9cVcwqduhw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(40470700004)(46966006)(54906003)(110136005)(26005)(41300700001)(83380400001)(36860700001)(40480700001)(186003)(47076005)(107886003)(2616005)(426003)(6666004)(86362001)(336012)(478600001)(82310400005)(2906002)(40460700003)(1076003)(8936002)(356005)(36756003)(81166007)(5660300002)(316002)(8676002)(82740400003)(4326008)(7696005)(70586007)(70206006)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 06:25:55.7300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef446641-216b-4819-9d5e-08da9099d24f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
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
V3: Update binding doc and fix compatible property.

 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 80 +++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 81a0f599685f..d77ee9d81fb2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -829,8 +829,7 @@
 		};
 
 		pwm1: pwm@3280000 {
-			compatible = "nvidia,tegra194-pwm",
-				     "nvidia,tegra186-pwm";
+			compatible = "nvidia,tegra194-pwm";
 			reg = <0x3280000 0x10000>;
 			clocks = <&bpmp TEGRA234_CLK_PWM1>;
 			clock-names = "pwm";
@@ -840,6 +839,83 @@
 			#pwm-cells = <2>;
 		};
 
+		pwm2: pwm@3290000 {
+			compatible = "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra194-pwm";
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

