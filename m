Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB24A3089
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352514AbiA2QY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:24:57 -0500
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:23525
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352436AbiA2QYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:24:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3CG6kZAYCuBtbM1/57VxqdGaKH5QF8ZTwCGvmkTAGdft/sGjdLZaRMaZRau8xFTotwYOzm2e9WLxRLIpOWcsp9s9PVOZsdR+hnJZ4R/4sFfZ8ew3Ae4iuyeZtQvLIDB0bukIFykIPCmaYeRAwlbTYr7qN8zR8e8lv5/HAfSvufwYGg9p9+niwSvufrzE1qDBSkj534/PvlTCidttwEBgtMdvJ3EdPzX7SsJpH6H0siOIkTNCEP8v/3CWBqi0zldTNUtNp08WSTB1wlVkbo0GCcL2uXnS+uZFTqh7T/lSHPQZMBIfSSZJWuxq03I0mvFkgu38wZzlKAFa9g0KsuzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfGLHtMOCEYxdKdY0Jj9vOSzS3BEjrKtJlr76DHKFRY=;
 b=cu+rl+hmGg36vmh10amuB/loVCx4M6S7ogiCtXMlN+QNr3QuSZjUPxbeGl6GXxmaK5gpEbrZyTDx1Mro2DcwVsMAhibxPO/DuxUhPsCQNZAiGbnGuIjsc7Q1xnx0BU4A5xiYGErJvbdZcjKfdV194h4xh16d2c0k7DxCn0hx3wcB/i74g3zPlBekxGtcLUY7RVK2aiM3eHdjcMbEaUrn6zliIwDWMZw1KxL3xsmtHHH1LRB0f2XntvMdUgS6Jyz2bhp0BRAs+p0RsHfs3dcCvxIbY7wjpgReau9MquFWZDwAt9Xhzf9wMyzj+jY/6W2hXDDA0HMkae9NzXf55ViW7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfGLHtMOCEYxdKdY0Jj9vOSzS3BEjrKtJlr76DHKFRY=;
 b=TBp9023x8boc52EWa57B7hpQu4rc2owEGx4xABsHncAQRrmKX88waiO0GIOqqUZaV6xQ6q0X/cBfJopZ6ujeVGLGJGu4PxnCd1Q/MtQhmu4QX4IqjlOIn93vn+8SWnAJL2FRBx9hAAiXmuGP8gGk0ktztaPXBiyrgD7CiVvpZDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AS8PR08MB6375.eurprd08.prod.outlook.com (2603:10a6:20b:31b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Sat, 29 Jan
 2022 16:24:52 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56%3]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 16:24:51 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>, sha@pengutronix.de
Subject: [PATCH 1/2] arm64: dts: rockchip: fix vcc3v3_lcd{0,1}_n regulators in rk3568-evb1-10
Date:   Sat, 29 Jan 2022 17:24:39 +0100
Message-Id: <20220129162440.5415-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::18) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ece8125-0fc4-49d3-c4d8-08d9e343e01d
X-MS-TrafficTypeDiagnostic: AS8PR08MB6375:EE_
X-Microsoft-Antispam-PRVS: <AS8PR08MB63756870944972348818DEECF2239@AS8PR08MB6375.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lf6BU0/WxnWpRIgQgZubxryUmJsu86aC914m8MzW7YGDB+SVE/46VXT6wrhQLbk2uXy7KX9CWzh2OouSDiMG6VHUxgo4vcma6ix+hDuEgDT2tmO7NHhXb++rjypD6/dXbulydhd+Xao7xtxVbBcTStXe7q/Sf4f+VFhbiTMyk68Po65Kqy6oRyssO4yuvvcLKbDeXrn8fEVo/51BMSQrygtYkiKQohq+LEizaF+k8mxC38+gvlVV5FkJH0jX3JAwXhfNXmoZ4dFTQHgCzJ9AESG3Sok+NNiME6V6ln0DEcIvhwgxFBCs64cCPbZeg7W5ZFdi+fvDW/9J/QTgsZqsTKYUnz61pWR7NY0LrgQrkfyPSc1YlxVZe8K1H2dWSEUfg36OtGD8t73alzHZIHO10jzQ/OdOnmR9lBKZE5pZw7BtTn5FWnf2gJAjLQw+0IL8gEy4r3rcp4yalgyrSJUpcn63FpvGNxo1909nqAxTmU2B9clY1cXHFTuNf8Ee70az4dK2FcvpGBa4wNvQrmMC/KK87e7LYIAVjX5P7QgclgOpoU6FkETcYmIz/eJ55wAZr+ycv+SnuSsTU7KHsLRdvXlHNwRmLqYzO07lPpSaZkj62GQUlKH/2lUjHuQJ2is3aaq8xMVAfBKnYUx4qEzXqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(316002)(4326008)(66556008)(66946007)(8676002)(6486002)(54906003)(66476007)(8936002)(86362001)(83380400001)(6666004)(52116002)(38100700002)(36756003)(6506007)(6512007)(1076003)(186003)(2616005)(2906002)(44832011)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gAW0h5b23IwbvQe26fXIAni1ggJRhYbOviEJsS2N85z0ErH1Tu1b/+FEXuNN?=
 =?us-ascii?Q?7LhyF/gb2g+UmQMs32+DdrmudC1xM97HDrIcr4q2rU86ZGDCgzxX7J1jAMJc?=
 =?us-ascii?Q?FFuoUeqGHPTzvECAlON8lTqWQQDjg6RIHp+6cE12iqp8tzbSSYE/QiRAOqYl?=
 =?us-ascii?Q?wD63hXHhN6MEjEdfYAszWuH0esQB0tz4JhPmq8p7KEFB9bKrqRyrxGe+SFkv?=
 =?us-ascii?Q?pPAIordZFA/b3224/r8vdS63epQ/MzkernNEW7Z/0X0/OZ7cESK/ZZb3//9H?=
 =?us-ascii?Q?U14x5gjNgjXuDEXAYzc0z/i7lUkz8gC9ivB4kIjcHq6HzReIxtN79yxP8a2z?=
 =?us-ascii?Q?yK/atYY6wGTwWNH4/SdwpPlw+oKd+ylJDoh/aVEEBD/UnXtkuio0TFnUBIIE?=
 =?us-ascii?Q?cpRRfNo7b9N6Pn3zCP3/0uwSF3lznZGQkiC0bY17t6Im3u/fo9X7DQDtXP9X?=
 =?us-ascii?Q?bPdHbGEY42s2e+wysgR7e7x8ses3Y1qS8Eh6AknXzUV6Yw74EUz6nQI7z/sT?=
 =?us-ascii?Q?C3hgI+t8OnTvOxQpzgMRFz/8IKLWMrvuuQjISk1PRYuJpAQjVstNB7bLPrlt?=
 =?us-ascii?Q?7TPSQwIKNSYVFtg0Co7v0x+MN2luYLslWg9ftMHfCPs639jdw6SCsaJuC+iH?=
 =?us-ascii?Q?mx4otPkAjDZCpI0du3zK7wCnUJOgOUku010Og766kbqsDhzxurgonvNjzj+o?=
 =?us-ascii?Q?EASbz+a5kyzSlcjhRP2MhNExmpiZjWVIhn6Wp0z19+hc/jptcey4fJDdES1n?=
 =?us-ascii?Q?BQv+RN7+tXqGvyVlajwAbt2eWMTv8LbAgupNzV5g5jjdbyit29f8U4F5+jqW?=
 =?us-ascii?Q?bDx2hEtaFptvTcZvJEU0o2t6qS/VTMLjRebb3VJIqkw2ZUNyRNvhK85RGz2k?=
 =?us-ascii?Q?5IhnixNMrhgt6aD9qBiXv4tRDDFUEX7xVGRDLiRVLkeUJM3QHCMLIA2nynGf?=
 =?us-ascii?Q?4PNRgvc2C7CGO4/Oml6vlvtS1DGUVdyS2PWrjVymQTt4otFi6cxRKT7/5PgY?=
 =?us-ascii?Q?JQYTrsTlxeEOnDj5Mz58wD0EtMxmbBpqx+5bBmDTA3TwHvwVFsjWMMLkpbHz?=
 =?us-ascii?Q?plAgV5PGutAO8RjCjp1IDR6vTHelcNtWjcSIVQiPpcMH/lMDje8VAcVtJvZi?=
 =?us-ascii?Q?K9xC/pyWIoORheWyYO0UfHJG5DWv3AHfYXfrBMWziATBmWcaYIkjt3l+ujTp?=
 =?us-ascii?Q?ONsQW3irx2mZWbhX51SOwUlYgpLn5ANJpoh5yRVBMNA/F0SqFQ/uNveM9S6H?=
 =?us-ascii?Q?6JLXoH5lUTwcRiMODCDYhq5BvMBJQNXZpBcOBJbTHL2kkmPJoKBNeI/h2LQp?=
 =?us-ascii?Q?hyxokfeeFUp4uRnaG+Z/EmnoIWcnR11jsWUjWgO0rB/pHIMwn9Jljtl910oy?=
 =?us-ascii?Q?tc13JTzzqj8BZRrkGtYR0TR/oA1DKlBxt9qA5XQwhlJMoCTYDyA/0oc/bR6d?=
 =?us-ascii?Q?EMEpNaS165rh8UxYbH4SDdyJ1opQha1ub691ZXG1C3EdKxKaKO31HZMAu7Jb?=
 =?us-ascii?Q?m5IYNtjEfzIfjgFiQS9W9imDWY11r1InRbiGrZCl9DXusJcYYAuGKV0WAtjy?=
 =?us-ascii?Q?QaeHNdxCVFDieHMZHBdayDgdZAQh9+Aq93OolFwc880xSYvcnTU+2HZXxZxZ?=
 =?us-ascii?Q?VpzQXPEE0b1Pmh55BP/D7KJkD0B/YRm1QORdnnYdhwKDRraqDmA1H7KyA9Pi?=
 =?us-ascii?Q?5xk+AMT8G3R+5v+scdwwTTVJ3clM1v52LXYR4TkSJ2i1fOQG2QmqsQ13idJZ?=
 =?us-ascii?Q?2TihXht2qg=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ece8125-0fc4-49d3-c4d8-08d9e343e01d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 16:24:51.5278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6HBbTpqg1MVecKtZhhDf4vJNYm72Hn+qrAJkQRtWDsg5I2g/WVBJd1TOfP7Wy08fnVyzdViDVCK6CvbdZne3WgXzFxv2bfo/qxWpyPrIEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6375
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The voltages VCC3V3_LCD{0,1} can be enabled with the pins GPIO0_C7 and
GPIO0_C5, respectively. This patch modifies the device tree in order to
reflect this.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 184e2aa2416a..197aaf7ee348 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -56,7 +56,13 @@ vcc5v0_sys: vcc5v0-sys {
 	vcc3v3_lcd0_n: vcc3v3-lcd0-n {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd0_n";
-		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&vcc3v3_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc3v3_lcd0_n_en>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
@@ -66,7 +72,13 @@ regulator-state-mem {
 	vcc3v3_lcd1_n: vcc3v3-lcd1-n {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd1_n";
-		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&vcc3v3_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc3v3_lcd1_n_en>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
@@ -339,6 +351,15 @@ rgmii_phy1: ethernet-phy@0 {
 };
 
 &pinctrl {
+	display {
+		vcc3v3_lcd0_n_en: vcc3v3_lcd0_n_en {
+			rockchip,pins = <0 RK_PC7 0 &pcfg_pull_none>;
+		};
+		vcc3v3_lcd1_n_en: vcc3v3_lcd1_n_en {
+			rockchip,pins = <0 RK_PC5 0 &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int: pmic_int {
 			rockchip,pins =
-- 
2.30.2

