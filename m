Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDD449EC35
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbiA0UHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:07:08 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:8578
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343798AbiA0UHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:07:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/NVJggK82hS0kT+92BTxUsi5+ZX+FbPLPlHsemhHk3K4zANBaUdSVcM2xRnI0DpVI/VT/3Csl/0fWT7tV6GUx10GGu/SjlxS5CERC7/PvywEVCW7S4TyxGm0Dj6u9WdSPnQVYsXBsfLM5decLB/7ahU50uVKSSUPHb36iYcJ92jGY6VosfrLCo+zyotKi5/nIzfgVT2RRZh6j+gzW6NbR00/KiPHa4CiLEu9/VribDsE1uQTbD1yXf9VFT4dGnu8j8cCnxyom/w9Q4O26JWfUhL6f7E6tzIph45oieETusLC585LbAZ3qvLwp42aA7z4r3kREKfLimKaMvRwGN2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjmO1aJ02YXPHvIBw2dQ4CZxCglLwtE81S5gVBri/f4=;
 b=WaETHt5m42PwnQI8XLgBMsJ50FoiwqkpUDJ1lYEzacXCnQq2C+gcXr1UXxW/4QLWyH+df1FfT+sZapjyGA0KoqWmpM2VfGYOYGjT9mhdMU1w/aE9dSjHkuDdFbMwnnR+dthLV7+8/ff5MRUjeouH2kEh0cWkHApO30gMaQDVR9FDHjwBqZSR7xKqKr9s9IhLePuk66de9SDMPYERJIil/AY6gVzMY2WkeUVpZzpG647CCqVcysbm6mBzZN+J2iZXy0loYuCAZe3x21LSKa3TxTTLLIKWZftOzucBSLhkflYS7fKL0I0+hJhVJJPl+Jdu+7VSKjgqPQsTEWiSysqEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjmO1aJ02YXPHvIBw2dQ4CZxCglLwtE81S5gVBri/f4=;
 b=KktodpScVguZ2T7yJ2e/M+JZgMEVoivSq2SCkkUIkcz0uq6Sax2nWnuE8JkhPzyfXKnAZGI2q0n62G6EKzgsxon0jJeW68zQS/vaPPNWJni7t8gmD1s4n19r4PaEF0xdEvdXe90oBrF6bleOAQk2Ey6tnsHjWvFTUxMzwio9y6udRynntJKtLqcqhCQutaH3XukNfPI1iXQysYphoOo++vsdprnjjJdSPAg41/NbleyQctu5Nm8OH9JoMaYlHcBKPWraJzwv7gOJtaJGMSWuZzZ2ghi7RW/lqL2NOfhyoMLwxDvMPq3lzGU/tnzKsYlf+5qghivbEduCLpWsFxDMWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB3747.eurprd03.prod.outlook.com (2603:10a6:208:4f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 27 Jan
 2022 20:06:57 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 20:06:57 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/7] arm64: dts: zynqmp: Move USB clocks to dwc3 node
Date:   Thu, 27 Jan 2022 15:06:35 -0500
Message-Id: <20220127200636.1456175-7-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127200636.1456175-1-sean.anderson@seco.com>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d0d9533-6908-44af-f042-08d9e1d0924a
X-MS-TrafficTypeDiagnostic: AM0PR03MB3747:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB37471B6C9877505461F2473496219@AM0PR03MB3747.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMvZHa8AolUXDJkqeXZ5Q+9v+aFAzZw5AT8aasZVKKioUHEcKWB0rZOxBwf0MEpuAel+tO2ibOL3ebCjmHL7GFV+a6rIL+c6JhiYcGyDhJ2QVnK3SWl1NSP92gDu9TTpdptReBv4Biejq+4ZGrMpdS1mR8WcFud8mUZeEd8+zhEpqYM5dnwZVELSkAJotwY+hBQEGAxKY/ZjfnBwmxDmSGLEUOc3wEsXt73+nINEE3cIWf7nsZ59coFBksTKOJyhzfFr47d/Rmiyv7mECcHn6c1pIzTg48ooZizrGcTsOqm4iSJze1a0MhEriValVpPWcG0dIZp0Ih6YCiTmGXxOibJOfAbTwEBCygLhRz7/yTcB/S7XlUWkrv6eNAhROduLJD8KcrPnqM3ZjuWWcWDyyKfXI0jZu5EzMmTjB08SPU41Se74G5eRpuYkNgSLznFbPjYoLobHLZhb9dCXGpbLwiSCGxWe9HlwnqFZF5CVOTeN0mXp+GS7WVsJbSo8+xC/cp7Y437py2PbqNjucMUFGHcgRh+FZmy/fHcTKhmJ7UdTWytW2J0W/ykol2TJGw1HbMyYFxnBIuuI6AbN1AXJ8lxjh//O18AclNMWbyl+y81a10ScyDps6PGOf3Iq49OhOSvJpFEG1KQjApyPTv9vD772LSrqiIA1vv4UMwcOhviD48FkW9Bq/h+T97ZuSCg3QaEnJPNrUD0xLn3jHXYeqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(36756003)(52116002)(6666004)(6512007)(6506007)(2616005)(186003)(26005)(1076003)(5660300002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(2906002)(44832011)(7416002)(54906003)(86362001)(6486002)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Had5sFbY71h2jma+E3it2v/hshjy19GUP/Pby98Y8luly5B63M+vSOHYHU90?=
 =?us-ascii?Q?mQIuni8c68RpgvxWYAW2PSz3K60NHUVD51EelwtiU2jN4gRu3N3pfd1EY5zm?=
 =?us-ascii?Q?5WIwmYp2oB/jgQjJ53kwUJ04ya9K5vfwgjxDTUfyhtVzG4PltwD63v7hacxl?=
 =?us-ascii?Q?QWGzaxEzbpCgaYDbVVAcms/5/ANNX4nVy+tSJQlk/6kM/8SzoLkILg4Xzopb?=
 =?us-ascii?Q?M9qznRGFU5cqqfLQi42VAu/FXsqZfZQmNyjeqpB+Y9KDrbHWbYIoQqvTd2R7?=
 =?us-ascii?Q?ukk6u8KhzLMx+UiUtfJcwJ2ChpKZC/q5q+5wwlHkaD6/b2c7I6EqS/7aeY8Y?=
 =?us-ascii?Q?muGtbc8fvsuDLBllVg4dc7hkYPWAflmnEUDbf/vVQi6OKQpvBnYbQV67POYz?=
 =?us-ascii?Q?T0yzdKdftN6fg8khC4u77k1nKyb9mpUmys3KlVpDrVS9dnp0cjAlqBLmk9yx?=
 =?us-ascii?Q?cyeoRGccczwH2Yrk+xCfmhBrOlFZjPnMqy4Qq1KshxrypDnjff9lMURry24n?=
 =?us-ascii?Q?F2ghTEnQS5lKxL2G+WixtPMWbqsj0Tk9vU8qfjj6Zuspned0OGGNr3X4MIVB?=
 =?us-ascii?Q?9WkQVFbFs0qAtICq9IlgIeUjuEXmY0nF4zgVa2Px4iSC8hzf926Ds8vC9KFu?=
 =?us-ascii?Q?IfkRtCcTzlpnfPbvJBxdvsFAoro2E0IqK/X9XeUDmr0KkjXETtTCNUVw9HyH?=
 =?us-ascii?Q?PcCEg7fOQsJ1sAYVndAChoz/5MHWLjcz9BKBLb+9RXr/4H7f2XtU6A4c9FNM?=
 =?us-ascii?Q?crm6jWpOXsOjuYtCOrhoIqmKzSqWfKDfxCGSsN/gdYpqrV43hmMLcxcaYiGR?=
 =?us-ascii?Q?SuYxeL2svxeiHNsCtur1kvtDXjo6A6b5mfxLM7NgUXZppKwdcvEJrlEFsEXH?=
 =?us-ascii?Q?/KE1qkVZhaNPYdNY4woXAZ4gyzbD+xPrF7LK/CZ5rtjY3dFzFmhhEP0LuJzV?=
 =?us-ascii?Q?0yN1nqat9gj4K+aF37GPuuqjFqhSrnEcWxzgPyE9v9/x6DaDuvLJseSAMjNR?=
 =?us-ascii?Q?aVWGa21CnvgoS6k7kbZhCywXPaiLgw0W3xE2kVSD6ecN4TIK4t4xC12xPi/8?=
 =?us-ascii?Q?8C7j2pWivZcgAujumhE/2Og8+CbPf/n2XaFmMY8IQIFgkBSacEgYMPB8at/Y?=
 =?us-ascii?Q?RTc0yO0P/72nwAoxIzd9Jy4/bl85os8bFNLztCRftWHSyzKGwS2Ex5dUr7tP?=
 =?us-ascii?Q?J2IZ0P/7yRQ5BkBNGpW/VDJLUr9Lr/wbJyCDl+JomwP4rVJfYqK0bR+SuD8+?=
 =?us-ascii?Q?5vvc6O1Zl1VC/nOU1kFnwfPo1KDMhL2VyjzOMnH2d8tLqEBpfBtarrRZ62XR?=
 =?us-ascii?Q?tGm8BukpfOlpaONqKwAtubF0Qq4bLZznQs7dyeKLbQtd9cNrsP22FHQwbZUp?=
 =?us-ascii?Q?QxZORrS1pnGTC9YqHblqO/4dA1qMaR66AeJ0rK3jL54vqTZC+k8rtJd+BXCU?=
 =?us-ascii?Q?teIBn5Y9VU+L0SshTQFGgDilUb4vFqa9ZnzvZzTMWgWDOD6J7zpo8qg9WRJq?=
 =?us-ascii?Q?41kQq3UI4ABM/qPGN3bR95wtTCPEhTaTFofwOu0DEH2IlG+xCSGbR0YQ8RYX?=
 =?us-ascii?Q?OkGvzPrw4rqTJK/JJiE4wSMfrr5INOnFb2lE+KfNQj2JsUVMwUBoFGSnlN67?=
 =?us-ascii?Q?BCtLjmt3LoVGLFk8jSe4QKU=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0d9533-6908-44af-f042-08d9e1d0924a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:06:57.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JizCKAbbeQ1d8t7PbUH/3sU3HaTC8X2WDQfcOdmOCV4j+yY2F3Wby70tT8I/++d0JEnH0hXzEsIRN39sezOkuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks are not used by the dwc3-xilinx driver except to
enable/disable them. Move them to the dwc3 node so its driver can use
them to configure the reference clock period.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Robert Hancock <robert.hancock@calian.com>
Tested-by: Robert Hancock <robert.hancock@calian.com>
---

(no changes since v1)

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

