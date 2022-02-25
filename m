Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95D84C41FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbiBYKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiBYKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:10:34 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6951AAFCD;
        Fri, 25 Feb 2022 02:10:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCUDlss+BIirQiHAu5cujjIurqDWPOGyxabjey9q4OkAZsL6jmF2tmfuxAuJU2JE/85LxjS9KtORjYNMVm/DhMswWLuwJZujEOQORsRLAjevIaxd8qCEXWxDHOdiHJvc363FyBg3pcisVEH9PDASdhglfyLwlouvQmrpFZu/9vRUclRAF/dXmqUZWyuzGggJo5QEyFpRn7TcWaXDIcGUIvaCMGs50h+uDsDCdEDyN3Y0LFpv/nIfd1GUhbsFC6BBxSTBQipE2eaDsZCxtCvSCLrhk2d1k4tsFl/rXlADGz4J3K3Pu8tgS2zuNUqq0HB9TPSnKpdcpELYKm+JGIEuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2hy0gggWr5QKXqecMb2eMIzCBlfH3egOPfe0BuqMaw=;
 b=A6sDJIVlE2wnH8/otRIyKjuv/DwPUtlXEo4RJ+zfPfPbEpYIBRVrGLNj/kQqUAuMEWQ68Sk8grjdvB/ehPKPll6P10oQ3VRf3WLWs1GXI3kVbo/RruiJn763YIel1s1wLdGMa4wHve2S/BW9eQnXL1v2NjeDryKBKz7brqaLDnqpeAT7dBrCBoBWmbRW7iGSTsSfdFqqyaEAAWnX6+02LKBVzk52fRAxCjIvchFaNZOv/zEakFpOWf/ctdlX50gieESmX+INkWe07hWI4QpyT60J6xvOW+J8V1CFyVEDwW5/9S8SVI0nnqEu4SKfIwrMMutxRmUurrOT/IJm0pCLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2hy0gggWr5QKXqecMb2eMIzCBlfH3egOPfe0BuqMaw=;
 b=pp9Mpc2X20IqcehK8HPHjCsmdrn6/j+g43bK2kBnKuvy59qJ3r0oRp2Bkawoe/4QssYoJ/uvVroOKLiCdlVj0Bz5qszydFZdnctakjd11VGd2g5d3v7tGb6kPi9xjP9k6YobLPv0mLP1sxWpB9jdjuqrwzSdAIpLVrMe/tCFbrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DB8PR08MB4169.eurprd08.prod.outlook.com (2603:10a6:10:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 10:09:58 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 10:09:58 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: add the usb3 nodes to rk356x
Date:   Fri, 25 Feb 2022 11:09:42 +0100
Message-Id: <20220225100943.2115933-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225100943.2115933-1-michael.riesch@wolfvision.net>
References: <20220225100943.2115933-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0556446a-d23b-49f7-2104-08d9f846fa21
X-MS-TrafficTypeDiagnostic: DB8PR08MB4169:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB4169CE094A14C2F281515A65F23E9@DB8PR08MB4169.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mXVVPww+xH8FpLYhx3V9YY+I6GjU7/9GpW/oGv1lg1crfmSEfeoPr3ufZZ6n7XKgnwv2shLt4nbjoNgXOX6PWuhrEdKV55VE3YZGB0b2PuAspW6fsMpdM98/a4QYKzcQ5TKKry94fb7zIQq99gH1ZQIQWyxw3eR7iX+o4wfVmo56B/BxxPygM5TiUdSA8mjg9jT6t4biQJ8swixoxoLWuezLS1wcSWzfAvNdVm3bfOTXnYzRAvBraCpGnLkTPA+QALFKGpeHp+kxXWrQA4Fup86uAD+slY/1sHFL/DiEDWM3BuY7GQfHgHXZgPcUVwShrHC1ZG8BDLOXuRzt/1a+0qO9Vxc9GG5c93QC9j6rrlK+Te9Kfylx/ir10DJFKAHHEZf5kTfrHc60Ir8fjfR6dyyp66Ji0FNG6OJ8WDAKVH4N7XD/f3l1/X/SQQcZK50f7qt5bcjKobNmZvO2pY+Syb20Jsv99WsRCCWx9vueFIcpGaBteSziofGd/zyYqCSTWTURw5j0fYPJKhfkwrlnwxpfBnoj+PQLGFGyXEgiCeCz4+FNI6YWigc+yIZQCN7Up83P28aWzff9A2VmjAz7JDjvQxlzrgTOMuwfT6ZiNYCSB2DZcwGvf+NqjXBBfCERsPTGnDdDM1XblOOyC6zcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(346002)(376002)(136003)(39850400004)(366004)(36756003)(83380400001)(2906002)(2616005)(186003)(1076003)(52116002)(44832011)(6506007)(6512007)(5660300002)(6666004)(8676002)(4326008)(54906003)(508600001)(38100700002)(316002)(8936002)(86362001)(66946007)(66476007)(6486002)(66556008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nK+HlinQ/xEe58E3YJdrNx2lSZQhNDmhiJ3VYHsu3Sjo6yG5uQJcfGx5dhna?=
 =?us-ascii?Q?tVbtTVuusi7m4nCr+pMU1K9y53tBppRePGd2d+96TSM+u9yqMOFjgqyXKWCm?=
 =?us-ascii?Q?gkano26tecplMJHabjuXJ13N2fK+10WlK5ifRUw6Jo4I4cx99VyDTecuaVpx?=
 =?us-ascii?Q?tv12iPQXX4Y5FTgtGQb8fya746mOIFb51NmaC7pEbvQH7bk+3f1BP+a0XEy2?=
 =?us-ascii?Q?CKQGpJTc2LSEVdBG2m3QPj8QuKKRfCSkMjdM47r9PR9ouF5ZHFDE4ox/6ivR?=
 =?us-ascii?Q?JRSUbQvN1f3uNaX8cDTPH6BrCvAc/vpZE6soZlJd8PVKd3goJG5kh8I4I1sG?=
 =?us-ascii?Q?swYSDomBb7kb32bbrSY0EoQXj73mEOVdfEMfr5VNCNgzt0ErK9wwwzeFGhow?=
 =?us-ascii?Q?jz081gHIKX2IUmgKQQMCyzRT4ZXHGExELXJ9KCnMFx47XDCQc3cVlBnDZaAO?=
 =?us-ascii?Q?R9VUHVFl7cSGgRcZvSY+WU+I8YLMs9EdHovmTS0MNwrknINnTM7Ls5PzhrHl?=
 =?us-ascii?Q?1Vl7VkPfClCXuqJ10Pj2h+lBYuysHNo/tluM2druFa0HKFveulM0bZls0TDk?=
 =?us-ascii?Q?6BOcXk+NaeukNtzU5rjNTsZbNhk75N8W9fw1DBvDbg4gqbILpouCY1dib/hx?=
 =?us-ascii?Q?G7UPCsVIqgsGeP66hxguKPZrcVRYLNirfRsY1woYIFIIDOjPB21ZCr9IDW5z?=
 =?us-ascii?Q?KZQZ7QRIQDeT4292XyzPm4H83RCZU5fS6eT5iZ6Mh3Jx7BDSTTvISPwcWXh3?=
 =?us-ascii?Q?L6tJjUrLl1nPNSr+UlmvNryXkvjjpBVTP63DBtdKpFFYa8l7orfdQMQ+GP+s?=
 =?us-ascii?Q?u/hhpenwKoo+nUtbL/z2hIxz3DNCd/92R/93eqlohlw2W366ayCJ2TGLZWTH?=
 =?us-ascii?Q?JlYWMY8O23ZgVbzBW0cF8Wgumckaw5k+JIesNmmAw+22RRtnm7s4jJei6jfI?=
 =?us-ascii?Q?Se2Z6KoapLb559n2N5vSzXpK6J1xo7ttbJq4AxQT0O9K61xLcimM3LZg4C25?=
 =?us-ascii?Q?FbzcJfWcoPVRSC1uDiqhhXh9p8k5vI8uL7/cuz8xlTUBmiueL6Niav+tvgi7?=
 =?us-ascii?Q?gj/XEARWkIES18kyZbgOX+AhHPI/ShHAqkpovqXSsk8xLDO4a3CwmBhf7L26?=
 =?us-ascii?Q?btyHtlHxJ5pYpV9Wscog1G1DmpAapr3LDBUxfULg+AxR/pKTqguUDceBdHYk?=
 =?us-ascii?Q?8wosV2FCmtbxW34Nww1HsQ+PfEH47F4Nr/5HhBTiT2ByygRGSQB1iAMT4LWE?=
 =?us-ascii?Q?Jb+N9XDmM7fZp7MGtPlJ071auQ1vBPlVHD5R+fwL3HOBcjRA/SagEcyk+T6o?=
 =?us-ascii?Q?jkR2cVlwCgTipy5UFVIW5xz4y3eycBzRvEPS+/Aylq2CHZTTh7vQmOMVl8tB?=
 =?us-ascii?Q?newgEpQFNUNhdmcxiXCpCZQWuR74rXchkhqXwdsW/rkvoavQ9zLSn9Y3rKQo?=
 =?us-ascii?Q?54dfGarZkVeFAcZaetQw28uuNUJJI6HvG+PYXtnrkFTEhrhE/e3mGp9/6Shk?=
 =?us-ascii?Q?z9cVn/EZSN9CC82awVC3otxPIcoAJAIxekLePNjq/Thh7qWYAbvpQsvI5XjC?=
 =?us-ascii?Q?gRQ7S/2BqFu8dMbBCBVjRPn4QdFjR4FjinZRoiVTEBeIW5UPaOhdYoafw3bw?=
 =?us-ascii?Q?zf10NJKw+MktY4eRWw2dpIz1MtHw4EhNkLeaMFBpBILmh0QFJ55YKVJIwJFA?=
 =?us-ascii?Q?moNiqYAQ7Fpzd08CxpDT8asaA22OXCECrIPm58yIBVOQUS8lqtA5C7CQFWCo?=
 =?us-ascii?Q?I7kgYI8SE80yCKdrNTcFcHZ2U95gXWQ=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0556446a-d23b-49f7-2104-08d9f846fa21
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 10:09:57.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g108RtgXp2s2Mi+5MyrLK5/hok3YKU1ZiKBCUVXDnmfVouo9f5LullBAcPxA75hgE1hfotVIKhc8e1lgHjGEMxdU6R16APNhv+t9DzbrP0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip RK3566 and RK3568 feature two USB 3.0 xHCI controllers,
one of them with Dual Role Device (DRD) capability.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi |  5 ++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 58 ++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 91a0b798b857..0cd4ef36066a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -116,3 +116,8 @@ power-domain@RK3568_PD_PIPE {
 		#power-domain-cells = <0>;
 	};
 };
+
+&usb_host0_dwc3 {
+	phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
+	phy-names = "usb2-phy", "usb3-phy";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 8b9fae3d348a..b46794486037 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -230,6 +230,64 @@ scmi_shmem: sram@0 {
 		};
 	};
 
+	usb_host0_xhci: usb@fcc00000 {
+		compatible = "rockchip,rk3399-dwc3";
+		#address-cells = <2>;
+		clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
+			 <&cru ACLK_USB3OTG0>, <&cru PCLK_PIPE>;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk", "grf_clk";
+		ranges;
+		#size-cells = <2>;
+		status = "disabled";
+
+		usb_host0_dwc3: usb@fcc00000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xfcc00000 0x0 0x400000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "otg";
+			phy_type = "utmi_wide";
+			power-domains = <&power RK3568_PD_PIPE>;
+			resets = <&cru SRST_USB3OTG0>;
+			reset-names = "usb3-otg";
+			snps,dis-del-phy-power-chg-quirk;
+			snps,dis_enblslpm_quirk;
+			snps,dis_rxdet_inp3_quirk;
+			snps,dis-tx-ipgap-linecheck-quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,xhci-trb-ent-quirk;
+		};
+	};
+
+	usb_host1_xhci: usb@fd000000 {
+		compatible = "rockchip,rk3399-dwc3";
+		#address-cells = <2>;
+		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
+			 <&cru ACLK_USB3OTG1>, <&cru PCLK_PIPE>;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk", "grf_clk";
+		ranges;
+		#size-cells = <2>;
+		status = "disabled";
+
+		usb_host1_dwc3: usb@fd000000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xfd000000 0x0 0x400000>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			phy_type = "utmi_wide";
+			phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
+			phy-names = "usb2-phy", "usb3-phy";
+			power-domains = <&power RK3568_PD_PIPE>;
+			resets = <&cru SRST_USB3OTG1>;
+			reset-names = "usb3-host";
+			snps,dis-del-phy-power-chg-quirk;
+			snps,dis_enblslpm_quirk;
+			snps,dis_rxdet_inp3_quirk;
+			snps,dis-tx-ipgap-linecheck-quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,xhci-trb-ent-quirk;
+		};
+	};
+
 	gic: interrupt-controller@fd400000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
-- 
2.30.2

