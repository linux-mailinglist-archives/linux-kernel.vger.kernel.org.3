Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8464F6763
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiDFR1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiDFR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:26:55 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81FB419DE5;
        Wed,  6 Apr 2022 08:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtWPFw/e1sHrwYnttYnJyfwjPgXo9Eas7FAmlx3VqN+oCFws1ENllFXVQFb3tG/HRtJ03bJ3ng2pW+iXjdi8XNniE2r3E2IVmi4R3TGu3iq2WTgWlK9/A6DWRi27gba/r5PukrMxHmibcEtYQJinuEE/2oxQXiCSTIDBm99b2bQtdZz0brpfts41DPkwTf4Vt9scot5eHW9ANWM/zXJM5TSqFYkQ4lJJhtl01dek5cOxkeidattdYbhVyqwcPvVfYUevdvzoOxdrR9XZ62cKA+UGuNyT8v9ARkpBPq50p+A/6iyq2udNXvcm6RtgIj5IPJdurg+TchKFdkHCpNWcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOUiwSQ0/LGBNUA8BdvFDibBJFJErHHbpVY0nlVJ+aw=;
 b=NdO7S14wa0bb/7M5w3raRm5XvAZmOw8VyA7CGz33qyYp/SaZueoHUFo9cM1MMSyUSlVfLwuYtEpq4On/cyXQL9+HB9kaGuPxi6uDU1AmzGJfBa8qCN6TK8ULV3qMBwOJoM7Co9nqxRZxhUC+r7NSAPWrKf5pQcmmuB77wuHvSKwI1N5naoERAxcaleOjg6dOISNYzGy+R91fCQyvr0Zl7tOxUZ0K0b/R3tOExmvMJy17Wr7Aijr/wpXA66eGZndsa247RLIKd0d89XaW1Vc73/k/FCrW08aluV/yMzgKE4XdZPqqKg1M2yJ+p62OdhtOynb2WoAJ2xPkexIefpnFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOUiwSQ0/LGBNUA8BdvFDibBJFJErHHbpVY0nlVJ+aw=;
 b=ltYzg2uZ9XkBV2CYY1W0uGCmXZ4NMvitb3CVKTeH0z8ONAmyM81d1ZeTgWnpH+SbY0asLpMrCRYt9MJDADdm+RR+ojys+Lh0BTVQKUJRj9mWnyNbxD+Ql1M56lJtNtLHEbI5gwpQlKaOajgBHnQuY2rsH7bTQC/QihSJh7jje3AWJnJcZioN5qixyj1s5vppn4Y97GPeKE0hMCIyLEDsKmUueo2tlHB4HygBizRSm4tizab3aigHvAvd7PPT3QA0vhH78J89XiPVkUKs8Lh86EhMX6Y2+yVu3EG6F0b27R4UZJd0etVH206HNLw47xiL7ptez93sq6I+arZPZfOR8g==
Received: from MW3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:303:2b::7)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 15:27:01 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::27) by MW3PR05CA0002.outlook.office365.com
 (2603:10b6:303:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Wed, 6 Apr 2022 15:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 15:27:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 6 Apr
 2022 15:26:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 08:26:58 -0700
Received: from moonraker.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 6 Apr 2022 08:26:57 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <treding@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] arm64: tegra: Update PWM fan node name
Date:   Wed, 6 Apr 2022 16:26:55 +0100
Message-ID: <20220406152655.264074-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4234bfbd-6d6a-46b6-e1c6-08da17e1e540
X-MS-TrafficTypeDiagnostic: SA1PR12MB5671:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB56714192F4CE0836298E9332D9E79@SA1PR12MB5671.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euQJ4K6rRcWdG/xzOq6sB1AR1vyj8C1fmarEvwcvs9dxcIWLJeYBjOKMwiCQkXlClsWIQ9JA1/xICyYWEZQ3CCNMDTVdhDxTpZj+uLcY+l+WZyCoohPAwZDpWoDD8TErKNmOgFWTtAwZKlQFCbF8X4dx8OOEaZ/LT87hY2rMzAQaR7HyxoX2QhQ2s4ZmAU301FdoXYjYUJ6VLJyGUR3N5c3/IfbN+0hcHSWB+x/Q3SSC2eEfKRaAjsB0dLnrhfluaBGvQ2M57NjT31odlOMDmImsmHXRTAt95nVRQijySC4ZlhGydV7wGmrRpHI+TFyaUN+oZCccdTbwObJSmlT1ry4G7ZQSpNiyMN39y3qX8OVyykJDVAGlhH1DabbejjKbxN03ZXMkMZeETyx1mreY7MWHhIx2nDGQG9xCxmDQYTLOV0PKVfTtFn0987AxJ9S6YasVseB3DWKFfRx/P33uBJX6Hpg4Z9IH97h7DCQy/Pa0IYeD6oiXL8Er/9P2Q1xr6uuqlxm34ehloB+ydrVbxkDqAIYdSP7as2ewHL5VocazcvMOtknSFFLAqwLaf6IKfM9qKPZDZIFrnSdXRB5lROsmEADSXW/0i2XhNWnFigHg7835xwFhU4UT/QaJ5E1VGkY4yek5NmDtDwumQi7z6N58DIMLnlctF9Wkf3SMzSKZQ9f6YC2MkeDNpsMUvUbe1zIb4fFcKHZfz0eHNQaMsg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(1076003)(82310400005)(107886003)(186003)(426003)(336012)(4326008)(86362001)(83380400001)(70586007)(54906003)(110136005)(70206006)(8676002)(26005)(36756003)(2616005)(5660300002)(15650500001)(316002)(40460700003)(81166007)(2906002)(8936002)(36860700001)(47076005)(508600001)(7696005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:27:00.6567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4234bfbd-6d6a-46b6-e1c6-08da17e1e540
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the device-tree binding document for PWM fans [0], the
PWM fan node name should be 'pwm-fan'. Update the PWM fan node name to
align with this.

[0] Documentation/devicetree/bindings/hwmon/pwm-fan.txt

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts | 2 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts            | 2 +-
 arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi           | 2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts b/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
index 4631504c3c7a..7e9aad9ff177 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
@@ -349,7 +349,7 @@ gpu@17000000 {
 		status = "okay";
 	};
 
-	fan: fan {
+	fan: pwm-fan {
 		compatible = "pwm-fan";
 		pwms = <&pwm4 0 45334>;
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 2478ece9e67c..27d28626bf5b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -1989,7 +1989,7 @@ pcie-ep@141a0000 {
 			    "p2u-5", "p2u-6", "p2u-7";
 	};
 
-	fan: fan {
+	fan: pwm-fan {
 		compatible = "pwm-fan";
 		pwms = <&pwm4 0 45334>;
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
index 32ce7904f44f..8033be098f34 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
@@ -1993,7 +1993,7 @@ pcie-ep@141a0000 {
 			    "p2u-5", "p2u-6", "p2u-7";
 	};
 
-	fan: fan {
+	fan: pwm-fan {
 		compatible = "pwm-fan";
 		pwms = <&pwm6 0 45334>;
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index 72c2dc3c14ea..746bd52ea3f7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -1657,7 +1657,7 @@ cpu-sleep {
 		};
 	};
 
-	fan: fan {
+	fan: pwm-fan {
 		compatible = "pwm-fan";
 		pwms = <&pwm 3 45334>;
 
-- 
2.25.1

