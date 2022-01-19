Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10E54931DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350572AbiASAZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:25:17 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:23461
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350435AbiASAZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:25:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3kBK7elVWJTlCIcBmMKrmf2FX6dpR+p4NaQRhJvBdPtNabpB1erIsZXTIo3IpLjC6JfNH4ZVf7w1WPRBZbaDdEJd2m9+Ll+i4v+kkIUmmjQSMUYP6o2oC7QyyWiNrhSw195v4KG1pW0ktyXzYBJlh/p3WvBUoLJYpB3eHfnPvHvJYrMagIxZLcbP1B8MU3SWxsVzZNY8C3oOou5vr4frKS7GPEDOEeMKzvd3pOWqWNnWqNVh6Nwm+yKhqDiHewwhME0Py6QS0HG1Rguos6mpuxwMjUrxWZViO2MhE14MiB/R1fZ9BzSNZlF2/TYRGp66MLPWLfu76ogkxhitcwJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE4ms0mJkGD4q+RsaVntUx4tenjq0pg6AafjxL5m3UU=;
 b=enmo53Cl2kGRLmq/gP8PYmFaOSHX2Pm8sSV/1jKBixFiDj5JzUNvcVa3TNG/tXfw8HSvrVVWw4i8s3JCc+WeSsSwUHyzx2uG0J5FySAYSEvemdjgfundVWaNfzPgow9DStCCKoums6DL4Jc1yJ59i88Ysqwy01DRE9pYlxchmupzh2lbv6ZntmF9iE3j0ETEgU0lIMSJ710kmLPuPEkLTV2whxJeMKunwfxGh96Xqs1+PLgRSToy3wKKrUsUruMGRpcH5JgSMeln/C42oZvB7XWpQUv0AfL81dBv1h4Dp3NDMdPISRgPrnvnPqNgYuECNuDMwhVoiHFN93o2BDyWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE4ms0mJkGD4q+RsaVntUx4tenjq0pg6AafjxL5m3UU=;
 b=SW6KC+vJpiY2td3abRj8/sgGvOnjwV7CuApWg71zvhYXbM+kGLIbcvMda8FrjPwT65qA5TkQSGsgPvK7smEuv3+ENV1Ia3qI4rTbPan2xV4ER2w6ulG829xrUBWJIxTZ0evSSqp4MkxoBAnVeJuxAw15rbMEr6L/N3ty24OrIyJAtDpJV9Z9qLVRwgPsorEH/7zwpOPlIp4rFgGoy42po2g3wodQF0cEx98lvuRJZbyT96FXVF5SRtVZDPr9ZvXvzyDquT0Hvit8wmOc5gmyi+6PH3I5kdw8dy2WkDtg1a096eCyf5cEHHsbqqc23SH4K50R3kplTqvy9t811BkKkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB4373.eurprd03.prod.outlook.com (2603:10a6:20b:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 00:25:01 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 00:25:01 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/7] arm64: dts: zynqmp: Move USB clocks to dwc3 node
Date:   Tue, 18 Jan 2022 19:24:36 -0500
Message-Id: <20220119002438.106079-7-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119002438.106079-1-sean.anderson@seco.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46af0496-dea4-4967-8e6d-08d9dae221c6
X-MS-TrafficTypeDiagnostic: AM6PR03MB4373:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB43738B778CC307039D74E0DA96599@AM6PR03MB4373.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPxnidMQ1O7UuFznybNWEtZflzcDVDgrUJmWo8QVOhN+bC9GFSsIGto1VJ3HHjldqNMD8gCvvEwUk+ecSaBxu/DbIJO76i6BOzLCroDqj0kCOpvVh+599sFPIjrxhM1UD13uUKEYxo5s8jM6VkG0FC4bb+B6YiaCHfkog1daRLJqYJei3XddiRclK6rV6Fi9EfICLtVALjXvuh/XoFvtS0nIjdGNQaSd4KO4M+4djvtrVfZ2sJi6lK05rr2HVJyIPLrm6KuQ0NxdbH6zc5XELXTrwF8H1VhnTUVvyCBUluVGrlB0f3Eh2o6ZDqk843nZwMFuoZptl5VDm9KH6SpF1w9brslm7B9gofyoXVvPU2Hj0Wc5YZAAKtmUftsaWHzGr7boWI7+Od3tMuOJDBZXsEUE1SpCNTXGSwZUTTGYxG+ejCMeEIbZisLGuuG90bDiQRq2y2x94NQNwfQingn7aGmg8FswlL944fYBzAGpeYGBio2DQjS/6nlwJEc7YqF1XxKsD1fMKMubU7aWGlYSHQQKLUcp77KdaIilqUksikMPDPIrlu8d6AUMx5XjwL0DOkChFtemFS5CKaZ/R/sl0YC5sMNosMKLZ6nrHqa3pw/eOoexYP9h4lWttBV3T8FpaIoPKij8Itip1e+eAbJNSVNRbya3HEvJZXrWmCBWsHR7JaldYIQ/eEK2DPnN/yqMhZoTKK34E2XO6qR0pdEkhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6666004)(5660300002)(186003)(4326008)(6512007)(44832011)(6486002)(6506007)(38100700002)(2616005)(1076003)(7416002)(66556008)(38350700002)(52116002)(54906003)(66946007)(8936002)(508600001)(2906002)(83380400001)(36756003)(26005)(8676002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2aNxkiX7Npt/egBfY3DpFrLOYg4zm7po0df3PvDP/ywqiajluhi8/VDn6wCE?=
 =?us-ascii?Q?UeR6cOc0TpZdO92FaXxefNRWWTwOnKbDLjkpxOJW/74YV6ETiGZtcgL9wurT?=
 =?us-ascii?Q?Chk2NUOger3XmwrN7Vc24G25FCvtPKUWvP2hRV6LywHONhuFubVHq38+2gbd?=
 =?us-ascii?Q?krRNUTnPneEDr6B01ZnBUyt4A8naA4S+F6ptfvs+BqVIRiy0CrBbkujyVKlg?=
 =?us-ascii?Q?i5kzYYUOpEKA1xjzmiEJaYOKG1dt4rquw81VcoSoHV84xiBG3ykr9carFjkS?=
 =?us-ascii?Q?eRwH1iIDor7LuM2VocLjMAXRVSUJ2ux6aZfVxMuQ+li6xAOWQflr/GZkFYgB?=
 =?us-ascii?Q?x15lIgbBdQZmZPoxdpIN2T/X8O7jLGU0AhB2ec6RWSOouU11u4LrvqPx5J3B?=
 =?us-ascii?Q?KxWa3bgnoqYzlZpue9vpt3JSi+7Tfyo9GCc4oeextVOqi71WrWEgOP91VcV0?=
 =?us-ascii?Q?cl2IK5+/DYPlmU3WF8xgMICXAMZlV2fdSY8a1Ed7cKJgiKtkfi6r4a2H4zY8?=
 =?us-ascii?Q?nIWREm/TBXhBi5zi2IZHvnr7B+WR/8jbNqKlwS0JICrH1M0pHn4qw3f647yM?=
 =?us-ascii?Q?+otvPIcVaBpLMTJnvbbBATD1/t+dqE0VTS+ev8m365ztn1MqONX9/YUIpmFY?=
 =?us-ascii?Q?pL9aaDZgEbs6YfyKSm9ERuL5U5sH6W/O4atuvCVTiEPk49/aaVD+2dsx3UOc?=
 =?us-ascii?Q?oqGjEOx434dSg/Wd6n1TGKXAT3nTYxB4yGtP0T2mmSCi+hXPbPvzNBq/pQw6?=
 =?us-ascii?Q?76sUHOEhKmfZYMpHTrzDliJSSs5xosGhZCBfT7wPJHpoB6UBXopj9rnXFIWK?=
 =?us-ascii?Q?1wcu32EH57A3MSCIsQpoO3ttBrAB6VhZeyzrZxwcPj6hjXut+h11AMaC47ud?=
 =?us-ascii?Q?k7INWwCW6edSLMiEf8TMSINmpryT2rHehce3jZyL1VnxGG7yRMKqyoQO+uES?=
 =?us-ascii?Q?cb4/t0I2HAtB1Po+oS2vm+Kl1ETYpLMTVCIAGP3URlIuMXqqNV9S8O/f9t3J?=
 =?us-ascii?Q?BKrNg5vKwgO4YGhqeBWM3w6Untm5gg3FLtvGZNqd8coku8L57KWZQHgIuZXA?=
 =?us-ascii?Q?/EtJ6lUHknEc0y+iweiq8/JBry9Tbeb8dgipjvn+4GC6UIGQ3i1uTviAcQO7?=
 =?us-ascii?Q?t2IpP9XM2u0eBXnAwPeHFndipZyVs7zlCACaoBD4nuZxhJfRR7lL0+/XCLuX?=
 =?us-ascii?Q?PQhbfMrojmaOAszjdzjNjhvNeAYGunL7+iRdSjycnCBxlQHM/lTSVHS3LzYp?=
 =?us-ascii?Q?EwGnfkJdnN5bxAgrpflZPSrBxwguWhm/vltXK1rrTEJPe2weUZmIF57UIQi3?=
 =?us-ascii?Q?OHYTQGYOICMcEd00COL3foQQ4p+6CGW2Upn5y4AgLX1SmbIt1bW7UtQ7rmtP?=
 =?us-ascii?Q?B6XBdP7h8/u4lyCi16bzZI/TBDxa3iZACQiEcAqzYWlmpm3FsJsjiD0xdEVR?=
 =?us-ascii?Q?XTIBE9rTn8lEvOH3oHLJ+oVJnw5JJDwoPWPj9LyGqRpGzgPv0UmVa8iCcWdM?=
 =?us-ascii?Q?TcMHWfnAgpFBM1nTL4Tx+m/n7d7GMAJW4YysrjgIQ6h0HtLz74+uw6qHlbb5?=
 =?us-ascii?Q?l6MKE+Yb1thePlhNMAV+JSnu1z+ueqL003H14VUITtZC/v9FiOQuRGzOqh+7?=
 =?us-ascii?Q?8KfWSavJFEO4IRZa+A/WiHE=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46af0496-dea4-4967-8e6d-08d9dae221c6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 00:25:01.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mPRm9AEXhMR8LeHIX/fJ27NOQgbJyWvSvWuq4gXgp1FGS65l3Nsff2lKESz2ydOXBHoSzJFQsS2XaMp3Ot8mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks are not used by the dwc3-xilinx driver except to
enable/disable them. Move them to the dwc3 node so its driver can use
them to configure the reference clock period.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
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

