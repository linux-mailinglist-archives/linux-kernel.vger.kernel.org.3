Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD9848F31D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiANXjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:39:47 -0500
Received: from mail-am6eur05on2053.outbound.protection.outlook.com ([40.107.22.53]:47328
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230163AbiANXjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:39:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdcIvk84+ihOhkZTNWsPwmo29NDERAJpkfgeveb9380TIZDAzprtQ8EXTGKg0/c+TdeanJQu5QO/2Ew578Qv5L6HbyA+oodZqLmMhvfMlmxnjJXwTIhFzudGmHRFUfiZK2SSz6mXWqj6Vl+LZL3U1fbCClMfakaPEq2AC7114gabGVam7QDJsmuIq3soturVtHjB+9PxjtPz5HrqMvCuHQfSzodvBrUgCKb9zBImWervfbGfGJlKUOIFU0ZlnkaJfeLnvRqSGuGzg4S4mqMDV/rYHgrGqZ0SFX7KAw1lli28LnK8pX4grfMRq7RceMp0zJKbX9cFMbyKZ7vco8QBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rFItfKQiGHwl3FGbMA8IsLJFeRbOk9WecY6ahF9Ui0=;
 b=AovS1TQz1Up9Dsa9Skbb/DXdD8cjeX8+hh4OyEaUMR3djlCoF2Pr2xxKQ4R904M678g09gzevlpVglRFt5yB97rRdUht/FTIG01UakRHA+ekTnlNkjYWUaWQYqHF+DnguVX84HS2NGEqtRPI5i7tuvW5p+0aeT2HOfBXVQQNUBML7g82Co6tWkjMALSJblwSqNHCWbjQhW44ulmUyHNCklb+vRFBRduG7wt9oXwGQEE3B0bErJ5MG1eHg2idVzD1inXYf9Zc53ua/gL6Mh0aEaAFW5IbLHOcv/7IDi8TmFJ1ro4ywBPaPH8XbjR+4nmse0J3HHxsF/0JuC1KKD7lKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rFItfKQiGHwl3FGbMA8IsLJFeRbOk9WecY6ahF9Ui0=;
 b=KTt2zOwOW0UpZmu6gjyanF3oUhv8H+isy9GqOuMXTqnamNzliszoIhYssl1n2w++3wqvMhButq8hhTtKEg5Xq3EUx9Y7+AfOfvZl4YrxX7roLxY2pOyvQKMnsejhsVodmGkM6L1emv4lviZ0XG+vy4ln/QpDwBxg9M+hcti25SE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR03MB4336.eurprd03.prod.outlook.com (2603:10a6:803:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 23:39:42 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 23:39:42 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] arm64: dts: zynqmp: Move USB clocks to dwc3 node
Date:   Fri, 14 Jan 2022 18:39:03 -0500
Message-Id: <20220114233904.907918-6-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114233904.907918-1-sean.anderson@seco.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b27e6774-8edf-455b-163e-08d9d7b71ad1
X-MS-TrafficTypeDiagnostic: VI1PR03MB4336:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB4336652FD1196E2FF9B6BB7296549@VI1PR03MB4336.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kyTYFUxjuQ1j/Mj2IA9sbwYBzA8bGN6NGI8gFjPAu/0HHc4cSE7jiVXB4HS2hXS27tTyC2ZvH3MGOmCmY7nIhdy9rHp9JbEqIB4j4YMpU5Tn9QcMT2S+GwuGFG/bsqsd5LAUmBOgBqFy1+sHkcyg/h1CDxRhSHIKviCgaWVTTdE5bXg+R/HFyXmdVL92z3G5TziX8fk/01FQ17db0u0HFHznl3DtaGbF0z38CUQmdhqls+ebaeu/tMM7pPg66bq/6WZxbC83BqFsVxc95r0+BXKmNU8ctbxlvLA6rgD8Ad1mkMNUia++3d5+elSWqFoyzBqa3vU7eS1CBJ2VtXjZnnRMPDnuMD+xJa7iEkkltikYjBXIL/lLHDHv+IJmDPXyqHpCeOltQ68R1hWJbPKq/w+SnZzXpbi2xexRwnUt9IX262i0BjuJlO11avkSDrknVqHr2zcb0AwFMByFn9fh+58c6xEcT6DhT6737w44rmIYtd8z88kq+PSK0BYr2NlNaDOEUrkFmkgunNEENGmPX7mfhvV679/Z8r4Z+H/NN0SOhQPSpCzgppI9ahAmeiE3XmWIAe9DpTZyemzpuu5XGGVkK+jm4cU7YT9LZDJ2D3rRf08LuEiv5Co3qYaTOKeMavx/z8DGPKr/1K2GqcnPxhncUExA6OcgzcG4hUO2qw1NrTmtB5BhiZOcXYO8Ymcn6pWcEU01RtQGwVzsentnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(8676002)(6486002)(44832011)(54906003)(83380400001)(38350700002)(66476007)(52116002)(2616005)(7416002)(66946007)(6506007)(86362001)(38100700002)(186003)(6666004)(2906002)(36756003)(5660300002)(316002)(1076003)(508600001)(26005)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nuh9JEaOwaliOkvPNjgIRLqRcJZfy5G59EircYzf/dNSSVJHG4QbWIaBA16U?=
 =?us-ascii?Q?RfU1mGly5/tTi2r+razuHRofmelcsNi8Fa8EZB8ZLXbj4UkR5gQTChjf2kOC?=
 =?us-ascii?Q?Vys3qP9YHLzUC5f+F5MbQ8cvjNYZlfmL4YH45D0GGVuUtJzzbBd8tq8x5TBe?=
 =?us-ascii?Q?V2/lzvpDzxR/k9KNxmQhP4NlXizGJXCkffC3gVvgEvFa/sd41PjWCtiolAJi?=
 =?us-ascii?Q?iQj8baJBz0cSjWrd9575IlmRqCmy/kfE3zYCZ+oIrTdWQHcPceJfJWNcopD+?=
 =?us-ascii?Q?J9Dv8z8j0f8RWWvp3DUYbY+q9Th/iI47uwg9Sey81QnpDntOztk6qgdaDdit?=
 =?us-ascii?Q?7NBYpi1otEO6PWtWWs26aroed21vuXxeXeXq8W+P3KtQ/O0E2cQQ/8UCCBJt?=
 =?us-ascii?Q?ObqU/m54K6A++deaQqsxITBmvPORwnlzveE4d0Vq8SkUwbgfvVx0iTM3sfTv?=
 =?us-ascii?Q?ZMw1n6fnVU60w03NzTwJBSiyS//Hh/2OojsORGCu4B6hf6zfVVIkYvSPW1dm?=
 =?us-ascii?Q?B8ofWXDca4GzCMuMSoMytvJHtAGcVQVgmHMiYRAAd4a7qRrpbYHU/5QhelNG?=
 =?us-ascii?Q?ltp6wC54bgiIFX/xVqTlWaurqOhjQUK2UgQNCDH/z8fVDshdXpCrYeiO1ulA?=
 =?us-ascii?Q?FgOtUUbgGFmvdOFIOC+RnU+RPVbMaGkMuTWK+kk1eZaaFWSQAcXQhrQuMV33?=
 =?us-ascii?Q?2DyNBwGm9HBtLGsqicf7lVRiPiPqJJsmBlzSxp2zHybwFz4nRLBmnqctDZ4J?=
 =?us-ascii?Q?BvEGZhuENasgAhdOHVBUa80PuCmmV1Y/0sZx7N1E1LSQu0i5P048QkGns8bF?=
 =?us-ascii?Q?iKgcj/wDtw4NEr3Sa6SVCk7/CYDyTFnj+7VTrG+aB0PDsnoxPqKS8xkJ0JmV?=
 =?us-ascii?Q?/ISooZRYH95ev3WHsX4Cl88tefgduMdIKnqM9J28+S3ycKqPLfQK5J+7WOoo?=
 =?us-ascii?Q?FWbH1P0SgWHyxuwe92jiQ3oVFCuEkSGVe8iPdyx2cVD3N7d4d/PCfzOTAeHI?=
 =?us-ascii?Q?jD+arViAJfEDRaTyvtkg3zwaQ3/OC62yjmh4yUZARremiYtjuIIE6qSomVZJ?=
 =?us-ascii?Q?GQHCjtNL/+hn1VygZEzaign52YTr93+2phUwRT1DJgURY6H43qy4BmAlZBP6?=
 =?us-ascii?Q?1c3AMoGrm9yQ6xra43BdVi0Aef+Pc34Z9AOdBdQeNUN4C/RoFTI/WaGtx53g?=
 =?us-ascii?Q?rsSjAf9H3qycEjpB9W5R1HsXgeEY02uV4Yem6z5k570SHluZ1ftaIXZ3K6pE?=
 =?us-ascii?Q?L3bLv+rMVR4PdpEG/F0zQQL66W1BL7ElO8BHkCrnfFPE/zE7M8BpoGK6amVW?=
 =?us-ascii?Q?XqiL83G9zIdy8LObaK9C8jCvUnOAYkfTCf1+v7sLhyaj1LhyanB5cN0W2aVv?=
 =?us-ascii?Q?JEXgHPXXQQz7o4pa3w5/THBVJBk1QaJ5ifna/kDIhyd3iBbRkBUBJNBOCelu?=
 =?us-ascii?Q?XI/r2qFVHRY0c+u/XV4DrF6E5N6JZDSGREp92lZOIKh5xb1MQor5107OPwVp?=
 =?us-ascii?Q?t4blCq42k2YfRWzqOvfWSxnDUYRcbyITQGtdXlKxfm5lputTmnOIhQBaCJEm?=
 =?us-ascii?Q?jmvUpEFY271U7MSIUvHFAAUm9CjuCAq7yFwMZ1j/w4Y1tu/9ABuQaoEY4WxJ?=
 =?us-ascii?Q?mO/0Bq0J+fTbsLTo3z50Bhs=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27e6774-8edf-455b-163e-08d9d7b71ad1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 23:39:42.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIY230Ztc1oPV8PF12ebOdjq0sTb93xiKwpAUf7fgCzu+MvCwAD3R1gGhzZ1puYAxPjOpz0m7ZaOgSzt6YSVyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks are not used by the dwc3-xilinx driver except to
enable/disable them. Move them to the dwc3 node so its driver can use
them to configure the reference clock period.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 1e0b1bca7c94..8493dd7d5f1f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -223,11 +223,11 @@ &uart1 {
 	clocks = <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
 };
 
-&usb0 {
+&dwc3_0 {
 	clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
 };
 
-&usb1 {
+&dwc3_1 {
 	clocks = <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 74e66443e4ce..ba68fb8529ee 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -811,7 +811,6 @@ usb0: usb@ff9d0000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dwc3";
 			reg = <0x0 0xff9d0000 0x0 0x100>;
-			clock-names = "bus_clk", "ref_clk";
 			power-domains = <&zynqmp_firmware PD_USB_0>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
 				 <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
@@ -825,6 +824,7 @@ dwc3_0: usb@fe200000 {
 				interrupt-parent = <&gic>;
 				interrupt-names = "dwc_usb3", "otg";
 				interrupts = <0 65 4>, <0 69 4>;
+				clock-names = "bus_early", "ref";
 				#stream-id-cells = <1>;
 				iommus = <&smmu 0x860>;
 				snps,quirk-frame-length-adjustment = <0x20>;
@@ -838,7 +838,6 @@ usb1: usb@ff9e0000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dwc3";
 			reg = <0x0 0xff9e0000 0x0 0x100>;
-			clock-names = "bus_clk", "ref_clk";
 			power-domains = <&zynqmp_firmware PD_USB_1>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
 				 <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
@@ -852,6 +851,7 @@ dwc3_1: usb@fe300000 {
 				interrupt-parent = <&gic>;
 				interrupt-names = "dwc_usb3", "otg";
 				interrupts = <0 70 4>, <0 74 4>;
+				clock-names = "bus_early", "ref";
 				#stream-id-cells = <1>;
 				iommus = <&smmu 0x861>;
 				snps,quirk-frame-length-adjustment = <0x20>;
-- 
2.25.1

