Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1105A278E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245714AbiHZMSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbiHZMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:18:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBA6DDB75;
        Fri, 26 Aug 2022 05:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juUWhNHqDn2+sPKvVbeVt44WEdJrKQvaxewKza8Q5LAlMLOvLTtCrhsdK+MxAMM9fP9Y/vlNW/1s/hRmEexbbscHo1SGoIBIPdbaj7lB8g9kZMguAgIShNb8rvpFptZxDEFNvrllcClxx9riU2JE25RCBuH5p43XyD+iEWQWohSqOt7wMIXaPnJxAikn+Q1AgM6T/66vc4Dstf82w6z5RGpvgxez3GJDbd7TMYP+SI95URJeYgUCpEHAwjyrZg0klC2HWnyE9JVeMvJuoq9pvfkkT1FATppyXtOAk7i7hkPq7uwK+6EW5trR7lGsDV9KPiy7IcQXt+nIqg7j1aFF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6UKajqs/S/laLntuOMFWN+aKmwPPb05+IjUjthsek4=;
 b=b6flBx4jOa5eT9byaWL/u+EYjqFauyRrclqIPrT89HZjKolgeCg8eY5gTB9gnGCWq8xTiVXRS2m+e6eTqilIlXOmtNKOkxkC9pigWrvkR0bSSnCYEq2at7uS/TPvZeqwc+WHYne+7w36UO5XG8KvSvSBTpXn94KsPfLMdIOGOdarrUNi2WldfAwWqDEL3r/DHIOunSH5Sr0BD9Xxq+6mA0Xw+/HtgjrXzIfUCPVas+gYPhff166Dec/h+bhpyxJ/0U6Ibxwxk8/f8LDW6IMK7TMaKMY/IQ5FcI2lMkZAUQDQQlTfseutsb1RSiYy1TO8yW1fuTe4967MsP2wlZCAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6UKajqs/S/laLntuOMFWN+aKmwPPb05+IjUjthsek4=;
 b=qLGls8ovz/BL5phOgtjgUU06f+0ZktDoJeynUdGIICN4uHwV03ofwXEg3smkuQOnz1EcxtehGB1WAQ5ztXAxg9i3pBXCe/uwuLoWCUhVEREJP8xixDnekVyuCBsFHwv3ZyvpOWwjnlCp4hQwsx3jmi8zMqw0Btci5dQ56TfUmP2wLTV5buxp3H5VJeINg5kQf8movW2M7Xbbb365XuG450FckiaZJcAktkugP67ZPLqb3tjBimTlVtcTJb2EfnHRuGabPdKZgbb8blAhAM9aVYOCRC3673jKN7nM2TwkYIgS6e2bLi8DUg2yhIspo1ibDDBhckuH4kqaj8/PxA2ZXA==
Received: from BN9PR03CA0622.namprd03.prod.outlook.com (2603:10b6:408:106::27)
 by MN2PR12MB2960.namprd12.prod.outlook.com (2603:10b6:208:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Fri, 26 Aug
 2022 12:17:58 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::8b) by BN9PR03CA0622.outlook.office365.com
 (2603:10b6:408:106::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 12:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 12:17:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Fri, 26 Aug 2022 12:17:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 26 Aug 2022 05:17:56 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 26 Aug 2022 05:17:53 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 1/2] arm64: tegra: Add PWM controllers on Tegra234
Date:   Fri, 26 Aug 2022 17:47:45 +0530
Message-ID: <20220826121746.32003-1-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 970ef1da-dfd3-4880-f686-08da875d033f
X-MS-TrafficTypeDiagnostic: MN2PR12MB2960:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9DcQzI9vLmXrc+PbF+T71KMN+/x344EwiEysYIGPr8ied7wunVBC4nXNwI/lLdIRj/1XdDCP0MzsM1dOBstnyY8Pwq+SSxADf5yZSyRaGhPRjvWfZcamjD5RSKMtCK1kAm7WXzNrmDG7B0o69ppe6N+0T4Eq232duQpwfUyJhvvF7gYoxsS81Gt/jScVlbjpmlOeUiklEx+OAsDkMImZIl8i6todxu9z7g4X1g8DXDx7d2b6csVJJTv46lJyBXGyT+BvArciyiQDlqPdC//Lz3+yIJYnSgi7fILU7/u/2aRFKm19P6dwz4kGlygP9+MeUAeXVJzmxWle4+sXkHGl+05mZQWEfnT+efzhEnUWaSZG4GKVrmwXX2TSfymPqGLcJ1s9Ow4/Q1qFzQoOA66/x0T4YNMF7XXL2k9m6KIZVDGG+EcBp1TwLLlLTASOL7Z5OzkkuuxtXDRIdIjQlL/NBZugmr/s3gvUOHbfPZeSbq9+n7XoDkv496ccXt8IJ8S/fk+hCfOahekVgOiqXZZTv95zHzXvecKpYwYbbWehLCG/A5CBumSWYJcEbMYUakCw6tobPm358gV+CzGjtMih98Z+HTIyQN7KHMCVjGg9whOTggerlOQTDIrqyZ8qs1GRRg6INGCoh7LUQKitpUMCsUVpnY3DU3oxuMyOG6pyW8U12KTNf7oc0Ci08LdN/5h+TSIHebYbnP/9cQQGedoKwhfa0/b154NLXZRaug3sCUfrdkNzwC/FNLXauU9emH5Z0SJ7XHm8g3HW4WC4Fm33jKNdCXDDD6uwwZIkPmW/cmAnUTVjR/p6FVKjnRjQR4LiFVA13NN/WymC2ULOYq+8Q==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(40470700004)(36840700001)(46966006)(110136005)(316002)(54906003)(6666004)(7696005)(40480700001)(36860700001)(8676002)(4326008)(82740400003)(478600001)(5660300002)(36756003)(107886003)(41300700001)(26005)(40460700003)(47076005)(426003)(8936002)(2906002)(83380400001)(86362001)(82310400005)(356005)(70206006)(70586007)(2616005)(336012)(186003)(1076003)(81166007)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 12:17:58.0703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 970ef1da-dfd3-4880-f686-08da875d033f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2960
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

