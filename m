Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3949EAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbiA0TFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:05:14 -0500
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:49248
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229612AbiA0TFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:05:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7DIMsOa+VNTE2ONPYrlIOjf0Rj7CdHGy5Ljh14utRJZ2odzkYzFphl9BXK52oLDm2rBGoUNtkaz5hIxFeYlDb/k2VKdCD0sevWBbzwP34qnmKNT1oExI05JPSEOtxrjUDZwfIsHddNAP0W3TSax8VCsgkJ1k/UyVYpUV8G6+FguAYmrl/hUGj8MjvCv9WJ7fDndwoclCSwO0Wn5AW8YwtUbkrhJij6gHA8y9hLBe/b/tp67dC5Sfw6uzmqVY65KtLkZntLyHWMvdik5JhsWI6nbqyqFjT3J+5zrNs0VrC/WHyfWqvdUhqlcqw28b/xFKVQCmKLVlzv+j4pkPe6naA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JigRZhjVEWGDRVBQDBND/0vdpjKoyirNdQHEURcgl8=;
 b=d6UJ/1IVjATZFgGoB+/CJL7DpNnPcmpLfKJVdCMfsgMSQyAA0kQxnykyR/CCrAItonBn7a7ObXXnzCNXxGGjNNOXn8DQMoli+J0N/GDdgWjPMw5hY32YESFVKLKP+65+taw7MpZhNUXVg7CtAOGHIfDMaCCjAo69IfZaaOjyRLJO650e1/FPG1N2MScwx4Unbp1y5lM/85L5UJVIYPHsI9V5qMKdays73EzSQEnjM6boNaVr/Jbx4iuVjHhjxJVIx+oliyF4ZPrcYQe6f1MTpYmnH/5LTUTedsJ2E2e9DgsoI8SBpLIBCTXP1GwuWAURrgqleGQ31MGs4NZa70P+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JigRZhjVEWGDRVBQDBND/0vdpjKoyirNdQHEURcgl8=;
 b=W1We6CAjsbXXdcYK2B6g+eeao06C7XnJuR8r+ipECtPOp0LVCv8Ky7yC8j6DRWs5gtYe8yMPsD0reRS5fPbevQ3jmLhONH67PwJm5AIMYWU+zlH1+6xchMCtWwewjHUf2isGBKCVFQKJqAIBMJHmsEZEh6T41pSgb5ozwUxdLas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM6PR08MB4072.eurprd08.prod.outlook.com (2603:10a6:20b:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 19:05:09 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56%3]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 19:05:09 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: rename and sort the rk356x usb2 phy handles
Date:   Thu, 27 Jan 2022 20:04:55 +0100
Message-Id: <20220127190456.2195527-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0179.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::19) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: add9295f-03c3-43d5-9ad1-08d9e1c7f005
X-MS-TrafficTypeDiagnostic: AM6PR08MB4072:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB4072273E94D9B45902F09BA7F2219@AM6PR08MB4072.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFpF3DzacKitj7jqFIi1AhXJiOpq91R0vkz3aZuS7CZ0XtSFARJSKMNaTlZ7tOMUHWnpCFzAXim6iBpKPun3cpVf4WLoQhXDYR1MFvBQ10kxVjVwbZ8uGuN7llE7UM/lLwYCVeICZvGPl/CffgjEfm0+CUNlK2M9uxrGm9dqga5cmr2RLerYMqJwSWUtXwU4qy7VXPeP1W7V5mqLd0xZ6ibVNDbO88c3UXVdbOwkdZpiFpBAZgOCOhWP3oUD71LX3nSpC8+5RumKBKW2IWRGNpSzZUh94LOufGUv33cbS22WvpgrrYygvn+XEBEmGBcqN2QtmVSMLh1kHSaeKsr4Sz4aNLyO9vXzesUZL4Or89OGfuOeF3BLtyKrl2LX8Sp7XQEUYnOgUDAC9IEyVwr3xXEraPcmoRBUbgaaEBCa70oWAn4GSOONtbgXDgJ0vTuxq2WHeUYz+On2o/iWWSoYUqLXXY0gKsl90TvL/JRY/KGzWDRbVOk9WZUFnaWGHSofH8nZPJvCU5hHx86KiDQmKxxeWZN4NzRrheCnEzUDQWZlaUn5UZRYQW6Otg+ksBV3tcdqtJ3iy+0AXpAxsVvM3ZYNqXnDkh7oPHfnxbHNk8CadD1N2lymfliVwyV9LEVrKcjLmBicZuq9FlNmvnHwBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(8936002)(66476007)(86362001)(66946007)(83380400001)(66556008)(38100700002)(5660300002)(44832011)(6666004)(186003)(2906002)(36756003)(316002)(2616005)(54906003)(6512007)(508600001)(1076003)(52116002)(6486002)(6506007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yBfmw7pNfy48ee8ruI5tNDjIR3IBnJX/hBtVMlsBEU6rp6ZasarytX2KboDi?=
 =?us-ascii?Q?DTfbeRsOHXD8xbxYEJPhRJed+0VRX862fMOY9pmVKaLCULKaP2WA759ToWRD?=
 =?us-ascii?Q?obxw6+S7uBur3F55H973zP95+9xSZvx3yGxQ4SFrK8YsCfEcK/sAgarg7hUw?=
 =?us-ascii?Q?Yu7Il/0vjR0q+330ldhQw+rmF6bn4sNihJZjb/w4vwP6znNbka1I053Yh4/g?=
 =?us-ascii?Q?HkSg8wnKJ12wxopJSGWc/Q/qDlgmcpi9YNX00YtU2fWe0yJGEQdpkNlx2FDv?=
 =?us-ascii?Q?43F2iFNAnTAnVJeZbeRsBz5vxmTWqwbbkoS53CvclxpcqyshE3ZozQMbSMLH?=
 =?us-ascii?Q?USFvk3oiKrAFBFmCwC5zpgZc9aR400WYr63aBX3YSKfJE0nonx2EGgsdgZvo?=
 =?us-ascii?Q?76jLILeSiQQBqgbNMJVLdkNgH6s90FFqSFK6RlBNB/0THrAsgP/yCyMygvBt?=
 =?us-ascii?Q?mLYmfmLKLymXhCMLzj/gVkFC9QqOxbldcd/p+SfHYCoo4KfjBpR2YJYeDoGc?=
 =?us-ascii?Q?qaLNfWOHYIrRtVSxquiGN69kDAsSV29ykM0ERwq44KWEheldjiPeXHvM+NKO?=
 =?us-ascii?Q?aGnnUdTU1RXVRPOSYheEzj5l9EI3BWllej+Ram8tgSECHXa0p8m0jVx049uD?=
 =?us-ascii?Q?FjXsw2e12nQrye/HcEBtLthImqQT6t7d81AuFAaRTMQuEGubW1CYlJ3FWgws?=
 =?us-ascii?Q?aZSlPDiMD1aIGGJabYFtz2qyRuUC3NY5qFIYE6imNB3EugoE7rBRoEw+QGMD?=
 =?us-ascii?Q?6gT/UQKiClD/kneBEP/KPwTRCe63cQNZiystW1Au1B1W7cH+6R49db6uZtmA?=
 =?us-ascii?Q?hpnOmVQGbtKgKJtazOYO/NwWmJi0W1HWhfBeZ/95vogTW8cvn2oHea4bMadL?=
 =?us-ascii?Q?KhGxf9fqjvOFLlqEO62fo1yMrgj9+gWSisa3QdWT+momERc6UuTF0xyd6+Bs?=
 =?us-ascii?Q?Tr8P9zYTJt/wlQATJvXQ7IeMsz+q0aq+REWMLt/1tFe4gV3BW/FVHylI8vL7?=
 =?us-ascii?Q?hRlFnkiUUUTVXmSuN3nL5kRUmyLoMz6+6L8Ib3zy5WkovK9pIUhrY3/BwiEf?=
 =?us-ascii?Q?RULSjnATtc+5rwqZVaTob6qzFmg1SYTndujSSDwxVIZJZeKI1YBDvIa36WR8?=
 =?us-ascii?Q?JBUB/W7p+5J0TOwnzApZVZv7kRLox3aZ2fGac+g5qe+chNeGGxWQoo6B/0vd?=
 =?us-ascii?Q?0QTI8foffY4TkT/bxDCdeCdH2Eg3rS3hNixMmQBR70yGk3tD4TbKiM1S95Ll?=
 =?us-ascii?Q?JZM0mB1n328wTD93GUliz3UnK2GD40i0qX4pkS3NvKiJoroqLWBLSmAunZjt?=
 =?us-ascii?Q?56D36IlhjOUNuTWaFH0XJKYOa/5+CDEid8IiI9hb036sYwY0SLQgv7ZqC2j0?=
 =?us-ascii?Q?0sJoxvfhGF+GikzrQV6N8Kg4sen5UXp3zpXxYqZqEhvcsWsCpl8x57ipktix?=
 =?us-ascii?Q?kVWrIjcgU53bYzpkeBJD0HOTwpdBjqHsZ3SOUlr0mzv6OZiwcoK1N0MxkuFA?=
 =?us-ascii?Q?BjNFBNnjzPoGB9PWVuXMHe0L+c5qztn83I3fzbKil0urbuodVFcQEdzniG/N?=
 =?us-ascii?Q?Fynev7KBaepSOvqtKUfn1tG6HA7iYZNWG1OZgNrw1MG8Rv/WMaffenzP+xdv?=
 =?us-ascii?Q?qTBJseS2O2LJJjzkIEWIMeUjqwyxwCArW8vuIqwC8sC9jdBno+i7kbIarzxi?=
 =?us-ascii?Q?1Vcv04nzrlGCtod61qPeNAElDWodCEP/ifjwj+aL33s815eb8ELg5WUqtTDo?=
 =?us-ascii?Q?4/m74IZeVw=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: add9295f-03c3-43d5-9ad1-08d9e1c7f005
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 19:05:09.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ky4Oswkb2wlIJXRzpB+tcCcjsSuKofuTO8V1F1ThadxtyRhezEjYEGeyhG8VrV8thdSiy4TMaT8VITOjTkcTzu0Ime9MSNt+EsDdQ9WgGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All nodes and handles related to USB have the prefix usb or usb2,
whereas the phy handles are prefixed with u2phy. Rename for
consistency reasons and to facilitate sorting.

This patch also updates the handles in the only board file that
uses them (rk3566-quartz64-a.dts).

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 18 ++++++++---------
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 20 +++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index f1d6bf10c650..3e65465ac7d5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -574,32 +574,32 @@ &uart2 {
 	status = "okay";
 };
 
-&u2phy1_host {
-	phy-supply = <&vcc5v0_usb20_host>;
+&usb_host0_ehci {
 	status = "okay";
 };
 
-&u2phy1_otg {
-	phy-supply = <&vcc5v0_usb20_host>;
+&usb_host0_ohci {
 	status = "okay";
 };
 
-&u2phy1 {
+&usb_host1_ehci {
 	status = "okay";
 };
 
-&usb_host0_ehci {
+&usb_host1_ohci {
 	status = "okay";
 };
 
-&usb_host0_ohci {
+&usb2phy1 {
 	status = "okay";
 };
 
-&usb_host1_ehci {
+&usb2phy1_host {
+	phy-supply = <&vcc5v0_usb20_host>;
 	status = "okay";
 };
 
-&usb_host1_ohci {
+&usb2phy1_otg {
+	phy-supply = <&vcc5v0_usb20_host>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 8ee2fab676f4..69c30992ced2 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -214,7 +214,7 @@ usb_host0_ehci: usb@fd800000 {
 		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USB2HOST0>, <&cru HCLK_USB2HOST0_ARB>,
 			 <&cru PCLK_USB>;
-		phys = <&u2phy1_otg>;
+		phys = <&usb2phy1_otg>;
 		phy-names = "usb";
 		status = "disabled";
 	};
@@ -225,7 +225,7 @@ usb_host0_ohci: usb@fd840000 {
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USB2HOST0>, <&cru HCLK_USB2HOST0_ARB>,
 			 <&cru PCLK_USB>;
-		phys = <&u2phy1_otg>;
+		phys = <&usb2phy1_otg>;
 		phy-names = "usb";
 		status = "disabled";
 	};
@@ -236,7 +236,7 @@ usb_host1_ehci: usb@fd880000 {
 		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USB2HOST1>, <&cru HCLK_USB2HOST1_ARB>,
 			 <&cru PCLK_USB>;
-		phys = <&u2phy1_host>;
+		phys = <&usb2phy1_host>;
 		phy-names = "usb";
 		status = "disabled";
 	};
@@ -247,7 +247,7 @@ usb_host1_ohci: usb@fd8c0000 {
 		interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USB2HOST1>, <&cru HCLK_USB2HOST1_ARB>,
 			 <&cru PCLK_USB>;
-		phys = <&u2phy1_host>;
+		phys = <&usb2phy1_host>;
 		phy-names = "usb";
 		status = "disabled";
 	};
@@ -1195,7 +1195,7 @@ pwm15: pwm@fe700030 {
 		status = "disabled";
 	};
 
-	u2phy0: usb2phy@fe8a0000 {
+	usb2phy0: usb2phy@fe8a0000 {
 		compatible = "rockchip,rk3568-usb2phy";
 		reg = <0x0 0xfe8a0000 0x0 0x10000>;
 		clocks = <&pmucru CLK_USBPHY0_REF>;
@@ -1206,18 +1206,18 @@ u2phy0: usb2phy@fe8a0000 {
 		#clock-cells = <0>;
 		status = "disabled";
 
-		u2phy0_host: host-port {
+		usb2phy0_host: host-port {
 			#phy-cells = <0>;
 			status = "disabled";
 		};
 
-		u2phy0_otg: otg-port {
+		usb2phy0_otg: otg-port {
 			#phy-cells = <0>;
 			status = "disabled";
 		};
 	};
 
-	u2phy1: usb2phy@fe8b0000 {
+	usb2phy1: usb2phy@fe8b0000 {
 		compatible = "rockchip,rk3568-usb2phy";
 		reg = <0x0 0xfe8b0000 0x0 0x10000>;
 		clocks = <&pmucru CLK_USBPHY1_REF>;
@@ -1228,12 +1228,12 @@ u2phy1: usb2phy@fe8b0000 {
 		#clock-cells = <0>;
 		status = "disabled";
 
-		u2phy1_host: host-port {
+		usb2phy1_host: host-port {
 			#phy-cells = <0>;
 			status = "disabled";
 		};
 
-		u2phy1_otg: otg-port {
+		usb2phy1_otg: otg-port {
 			#phy-cells = <0>;
 			status = "disabled";
 		};
-- 
2.30.2

