Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F647CD74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbhLVHQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:16:05 -0500
Received: from mail-dm3nam07on2072.outbound.protection.outlook.com ([40.107.95.72]:32736
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231422AbhLVHQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:16:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbEgZzHKOnq/GfEk8WzBFsRS8ohOthiY7+T42HylzUehXG0mM55FDXy/MFNfvjjZuxGMkX6RUCB1/TWJ0KWGQ/KW9kFdSAUyek3crIZrbD+h4dauTB1+38bJt5TUpyRkGVL5/CgLmn+BZE+8XZbQDQvTC30qeCrKBB7cPcqzu2AFq7jhPxzBzSG+O5TuCP0cuqJclQu2LIhlgZ9XNHOfh4OWrwCh3x6nZUoumelu0q/jHdr0Am3ZY0fsftprIVyF2uARB3HDn/W7tTzbjdQVoJexe5J3/rTKKU8VbYwfyK9RbK1Tp8IFGxX8GNpw2T8xzC5dC/uN5FYMXCn/28Mzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZsc4ge82UU7J91zcme+atha3HcRIdW62igeHbRURTw=;
 b=XBeeigyNUnEK6P1GwbSM68IEBz4U9ctQ3lraCEEi5kngH13c/Z+xYN0iWQnOiH3NsTQ0Li3+N0QAAOEcfP3ZUSMskYbwi++BCtD5yfKZmNOIkMqMWdetSgrOG2bvNVySggdpqeYSbtapcCBP53Siyk4/WH1/ygY6PMp0rVO5FyFf8btg02efEzktyULT0rrIQizw5RboOifJ/gqCSJE3mNfrYNvF95qEmwU2200sFIqtn7AS9PgKB3tBYDqM8cWSMQqu4lZQ2DseOwGoa4vpJhqckY3oq0KRPEVJBzm9L9sH0+X5a6jy0TAORn0QXRxwShDTx5BDW9/dVhf+x83qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZsc4ge82UU7J91zcme+atha3HcRIdW62igeHbRURTw=;
 b=U6NxR3y6RAcjSVSETEaygjqR+PEyXPrttPsNuLeJvkqPyMkFM/j+sQAYMJcp8sSNIoMY21sDQweJRpA8zQyTpKFWT9H/dBAvpX2/3OsgmyCahzbIc7m12qWWp23LV63YM5kapkIe8Ijt6Hkqe6mFCwf9MwmBC5zlD6aqEM9Kjrcc5MatKRFL8qqTbgEBBx4fmIU7a+eznwVRfyn5qSLseuyj5ZcPCt2clJbGKKt8TlPqMLJC6CwIu1n8gYuki0gMRIp0mClUeOqjEthTJ7tOONPbN6gkfwjEG0RPJODQsUKedK0g7Hjr3iyMUVCISexOeVRZzNKSTguz5mKahM8VCQ==
Received: from MWHPR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:301:4a::13) by MW3PR12MB4571.namprd12.prod.outlook.com
 (2603:10b6:303:5c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 07:15:59 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::4a) by MWHPR1201CA0003.outlook.office365.com
 (2603:10b6:301:4a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14 via Frontend
 Transport; Wed, 22 Dec 2021 07:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 07:15:59 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Dec
 2021 07:15:58 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Dec
 2021 07:15:58 +0000
Received: from waynec-Precision-5760.nvidia.com (172.20.187.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18
 via Frontend Transport; Tue, 21 Dec 2021 23:15:55 -0800
From:   Wayne Chang <waynec@nvidia.com>
To:     <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <spujar@nvidia.com>, <mchehab+huawei@kernel.org>,
        <skomatineni@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wayne Chang <waynec@nvidia.com>
Subject: [PATCH 1/1] arm64: tegra: Enable Jetson Xavier NX USB device mode
Date:   Wed, 22 Dec 2021 15:15:28 +0800
Message-ID: <20211222071528.144472-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 948d5103-058a-4070-5f33-08d9c51ae782
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45711739114852F68B070ABEAF7D9@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:91;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUgWGwdgkGeoKGO7VqgJBnpnpxh0XFJTMn+qQQnTD2n78PXFRRf8ZoFZuKRVyb8fOHz6MzmwmQM5K8kA1Kr2V8D3RtWCqyqDdIMh60s3cPSxmg5Uq6bAxajBgYByLHuPtjdGY4T4bC1CeGvfvChAEZD5RbqgoWK6bBct5HbnTVciZBUGWpu/3+p7m9mvf0oaeaJKY0FLvCqTCdYSaX6/fldLfwQh+2SsofrVhEKY45l1OjqS4yV2GDWbLL2mxQiahv3JXOtcIkrXFq49ZVDcB4tFx3w8YqacDkQ/uxPEma/Ase7Xh+nLVcj6JGrGr//AMY4B57aueyBNe9+ciiwBjEmuPSryj5UHGnDt9m2kOHhkfq1dLMy+Gkqyo8Yl9CTk/4wgJXTW9+xBOuWJT1w4QxLN0koN1Zk8OA5389F2xUMIljplhtPKaj9qKaEMkZH0O10M5kpU6Wl1im55RbK/CfwH5vJ8kKjQBIT1fUeK4sNJA1OaiHC9DP+u41S+u4Mjj43NVSo+A0i+rr+P9gC6LqmlvYKKN9yc3fKQC6I9pRqwxVweWYINCmc+x2l7Z69XEPKN+NJ9UavJMscWMxN6yy7e7Kh7+qTSq4weXTYTKiDQopGO761Lf40FUg5qfqP1Bdh3/9//DD+oBN1LlUxnqPqZGq66RX8gz/9Acgj4I17WxR5GavsWf5F5XfHlcAP+rJQlPDYO/OE4foZGpPPHUDQnRX58TFFaTAwH/Gk3UiloA11RhZm8x+gxyMAXmDVRAG16dSrAgqOkAJCzVavoSZoM+7w0NUTzT3w+IPpnRqD9oeTSO2fzeepkSwgdJ0p+r+L6qAIi9FLxuDPZsxxeBw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(6636002)(36860700001)(1076003)(426003)(336012)(2616005)(70206006)(7696005)(4326008)(107886003)(508600001)(70586007)(6666004)(110136005)(36756003)(356005)(26005)(5660300002)(86362001)(82310400004)(316002)(54906003)(8676002)(8936002)(2906002)(186003)(40460700001)(47076005)(34020700004)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 07:15:59.2288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948d5103-058a-4070-5f33-08d9c51ae782
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables USB device mode at J5 micro-B
USB port of Jetson Xavier NX.

Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 .../boot/dts/nvidia/tegra194-p3509-0000.dtsi  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
index a055f17218bb..f4733b98fcaa 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
@@ -1826,6 +1826,10 @@ padctl@3520000 {
 			pads {
 				usb2 {
 					lanes {
+						usb2-0 {
+							status = "okay";
+						};
+
 						usb2-1 {
 							status = "okay";
 						};
@@ -1846,6 +1850,20 @@ usb3-2 {
 			};
 
 			ports {
+				usb2-0 {
+					mode = "otg";
+					status = "okay";
+					usb-role-switch;
+					connector {
+						compatible = "gpio-usb-b-connector",
+							"usb-b-connector";
+						label = "micro-USB";
+						type = "micro";
+						vbus-gpio = <&gpio TEGRA194_MAIN_GPIO(Z, 1)
+								GPIO_ACTIVE_LOW>;
+					};
+				};
+
 				usb2-1 {
 					mode = "host";
 					status = "okay";
@@ -1874,6 +1892,13 @@ usb@3610000 {
 			phy-names = "usb2-1", "usb2-2", "usb3-2";
 		};
 
+		usb@3550000 {
+			status = "okay";
+
+			phys = <&{/bus@0/padctl@3520000/pads/usb2/lanes/usb2-0}>;
+			phy-names = "usb2-0";
+		};
+
 		spi@3270000 {
 			status = "okay";
 
-- 
2.25.1

