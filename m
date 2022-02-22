Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D664C0070
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiBVRuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiBVRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:50:46 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8E3162022;
        Tue, 22 Feb 2022 09:50:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSEsOeu/pi4PTh1PW/OuoPHGk3IojBOE6kjpWW1tDsgiKgQWs8tWW//zZw1A90rDusJyhbVrVItTLeGh8IR4YmeREhpX1a8AiHjvr46GXeTLQwvqGDnd5FqaQDdfALvC30nvb0VA0RuDqnA2JJSMMvmi0ePsvr4sFWZHGgfoR9JK2WJg2eo8IJJEgr5P71EfNYS0csvpbIAypwKn/UfRIt3eTNSCGYWwOq3iYqW+jATUaC6fCq0fjaYUBm87tF9sddPLTlaqADfXAOrcGaD0pQSlM/9xrtbSFqrxU5ywWPk2AZHKOHBRHUQlJAOfZmMMunwHg89+Ea0M2PKX/suuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa9a50z8axd5ANlexAiN4AyVjouQNh4aYAjqck44Htw=;
 b=NMvXmYI+BPHHwkkwhlnr/D43pb0iLBe3q7Fgt/wqJf3PJQHv8sKoVnbvFf3f759X5QkzmN8YgAZXVl7AcaC5/UD19h7jsV/2Xy0S1hiFuuM0JrADXBCs97fLLBS85Ab1tSKywSHYyYLKrFKW3zF2DnITIiHFcbgGPmUwKISGoI3zR2yW66pNy+HulUOP5PXyNqwkM8ko5IT0THSYa6bJGt0uhfgSZP2OqfJKewJU0GvWpT6RzZ6MDtKUuyr0QrGa6ixSnVetz4qFXjQUCjkF0/d507qOlzT8mEptZbEQNSMkkbFo5hSgAy8kTKnCkkQVdlV6h1b2Y3Ww2yEBrJFKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa9a50z8axd5ANlexAiN4AyVjouQNh4aYAjqck44Htw=;
 b=x545O4++S6fknLVNTJS86bnfAKuVDfU9sWHGbyvYS8EgrQ+/dxuL4pq2im2fSuZtQig3C/wErqLwmxvNhkifOugHLmmOoB8bcrhFovpJLYemzoazgbj4wRPM7GHRC09q/ESIidHjidyMzsCBMVEvgQJCgtvKyWF50+B2ITw04IA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DU0PR08MB7485.eurprd08.prod.outlook.com (2603:10a6:10:355::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 17:50:16 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 17:50:16 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>, frank-w@public-files.de
Subject: [PATCH 2/2] arm64: dts: rockchip: enable rk809 audio codec on the rk3568 evb1
Date:   Tue, 22 Feb 2022 18:50:04 +0100
Message-Id: <20220222175004.1308990-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222175004.1308990-1-michael.riesch@wolfvision.net>
References: <20220222175004.1308990-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0108.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::23) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e7507cd-f939-46a3-c163-08d9f62bc8f9
X-MS-TrafficTypeDiagnostic: DU0PR08MB7485:EE_
X-Microsoft-Antispam-PRVS: <DU0PR08MB74854876BF80D19F162B7593F23B9@DU0PR08MB7485.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3WWnb+u2tJe1ASPwBSrb4n4hP0JfyLDosgFN55keb21MqU34f3UzQvbnm2SJeD2iY5DhxKlN8CscP0GeaRj0REyvPmO7tnbNypa5jFtzlwMcwtJj9zfuqMjq+r1w29ATa40DZS530FZQGNY2iZCHggzTvq8/edBlsQZGRlRy8KCVJI2wBL2oARxv8bdYJxPxnRxP2ZcIP2Z8aHTq5pgRF/UKx0e+kZvGkwIebjJHrssErzRg5k6yHIzPDR6KL+6dmAzCf8X/UwYoXSn6fqEiG3nGlOGduijCqWelJxm4Aq4RYa4PrWUPrNGxIUIaVVD5MzQfVVtHU9C661QskYE8+VRNCA73s3nYoBc+xpNnpp/9llv4YM9H6uhW8l3fUlq6lpZtAIUqGu9QgtYcBHDdfR2cgBuZMlYU50gPjqcs62qVhfuoevyItS25qJgwLWWsrU0PoQBNlIfctp757Azz5M1F3c4++TUPlDm7OsmUtjLN9Bsa16r8CKcdEKee+ZJEHau9fiMw2e9nAl2S2wnJABZz8fp1e17qzrl1mfe3seofuLleIVnih7EAYFL6ulgTZoo1VrEf9SlAg8op/7S52hfF70dnTJ0sMIBFGjngFisvgr+XLYarSTRbqD2j7ehTVjT+/OLh0yh5YY2rvODgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(39830400003)(376002)(396003)(366004)(136003)(186003)(8676002)(4326008)(54906003)(6506007)(2906002)(2616005)(316002)(38100700002)(5660300002)(6512007)(66476007)(1076003)(66556008)(66946007)(44832011)(6486002)(6666004)(83380400001)(8936002)(36756003)(508600001)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qAY7kH1hIll19+8r0zWniJ6L7UsQB+7i6sRMvuwf4k5VpxQbbsq9LnYSBxVJ?=
 =?us-ascii?Q?/+OLXP2GB1w2vfsLoImFb6W8EQ+TtBtJ/gtOMbAsfUc/1VRWUWFAxL3ePs7B?=
 =?us-ascii?Q?qyxJA2jyqBw24NKkG30IITl9N6WuJd9Qoy0BS5p1MCHg65sSWX6W58nU0GaV?=
 =?us-ascii?Q?6yzBSnORK+vUXy+RdUvYZiLtEUsLVX+6hkHrb20Fe8K2MW+A96v7lrbxGNea?=
 =?us-ascii?Q?pCqoOlAlBW02uARRxPeNjEL5X3pIiunIbxFBSndENNG2KKHb7INIHob/e9/u?=
 =?us-ascii?Q?zNfPG6Kxtb1WhbMmdM1Ci3+xDo0Qm1J2X1lrTMP3X79snbj88bUryQ9MjVWS?=
 =?us-ascii?Q?pPlHVGOazhR5BW34u50vyoHwQ6TYC0qrt8dOfW5Y00NSYJUnDp+1Pmo/xmzx?=
 =?us-ascii?Q?H9/v2oDl18OP92jvNRIoa97AeCIS6TuT42j6zcntC5b21hVa6cPuiL/37l7t?=
 =?us-ascii?Q?F0DY5dqaX3glzXbCQL3UKq4uQxdDjyH5iOb2ye45l1oxxsFMaWkb3sEDgXAt?=
 =?us-ascii?Q?bFw5ZZyLv1V1cYz0Es9pfBMVDfsUvrMPTg/Y4BAJy0YfXHWcidR/1pknJHnd?=
 =?us-ascii?Q?ENLHbJOTZV/O4FfQCasGbEdDYTKLhzoLqa1JC5MTc+F6u/xZra9zT3E23q67?=
 =?us-ascii?Q?2IJTNvAoG6RkH37vL04UsWE3WS0xwmL4zuuwZhQJUXiKi1/HPXGry4gL4dft?=
 =?us-ascii?Q?AFDUiESabFi9LkwoA8qm7Q3r78VJL3AZGtPH3MsD/Y4HrU5/lD4bSsdDVOLm?=
 =?us-ascii?Q?y6KNQOxGEfqv5LxiM8ha11LqQaJ1D7F+/l3Z2x9F1fbR021KOB1/3yPBokyd?=
 =?us-ascii?Q?8Eovf+2HxLNa8FvtsX8lYXaAgrO+QEPAKWM8Q9Al/bwn0+/3/Zj1shABAld6?=
 =?us-ascii?Q?n5ljEtigtthCrey1cziWKXERxGmNFcr/qa+PkmZb+uTn1hSWEm5kmhZZs3e4?=
 =?us-ascii?Q?Co2vb+HUlMFVbo0MVZ8Xu1lcRUIAq2BoVILnXBZtc3ykHd3p3PMJkWBiKLIT?=
 =?us-ascii?Q?bRL0SKRGG4KCDLPbLrhEsNHmlHGj7DXIOj/dOXbodAzu93HGBBohBpmZcvxX?=
 =?us-ascii?Q?ADqJi5C6kU9hCW8BfBsEndxeE/3DxRI1+RibWOkPIMH/CXsBttWzPnBKnF6R?=
 =?us-ascii?Q?PT0gmEiTuiYk9nyKHU8uynx62RvFhXOGfjEsYWGKCWvBUwM1rSkuAbhiU+a9?=
 =?us-ascii?Q?QjimAr8+3b4zaTWRAh6HLiickeg/jpkhHOYx05lt9OX2hvsleqeZU+XvTpa/?=
 =?us-ascii?Q?qxpGdM1s74APaPVpI4UnrpPIhJ74kHCgS8MddEeo9fIkJgRPUfcqODelBjJn?=
 =?us-ascii?Q?xCN2Ti4pdmyIvXWzfqisNCeuIbC9xD9EkqogW1R5dEGQ5ISxjyoEbfiwjjoi?=
 =?us-ascii?Q?doqfZwnNgCOs4DzBONT1AVUUyZd/Nxf7sGz7ZSBEB/P5/OmASbTC33Nd56CX?=
 =?us-ascii?Q?OzQOFgtNgJUyxlR04r/iyZat3X+RVZ8xUN9KA/phf+3SPHlc331kFOf0J8n+?=
 =?us-ascii?Q?+ODCkBBf2cywdgd69HB1no5GuiuAHZ7+XSbxLMSlO5/3MAQX0fvVcvhsV2Vx?=
 =?us-ascii?Q?v2SYSVh+Iu/hJVuNIylraowDhToyfYZ0IU2nl908M/sgMtKfnFICTG+QmVz7?=
 =?us-ascii?Q?HMbx7AFQucsUcbMjNsFqCV62nJcJ+JG8kwylkKFXnt5I7zfq9fs1XaPPL8dF?=
 =?us-ascii?Q?JpehqVKPe4OITxSULKNGdhIdKlvSOR3TYcbM4H7bdCC3aV2SHUOlv4lm2s9R?=
 =?us-ascii?Q?ehWnrD8tOq1n34kmdXPmGObJyvyvIHs=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7507cd-f939-46a3-c163-08d9f62bc8f9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 17:50:16.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBwDCwdIZWB2TEkY33OzkM/MSxxHn7mirlmn0yDcybEkZ3+OoUwoZneylFLpYegoOlBaEeAOWmUVrZ/ct/3BtHcihiEVQzcUFkk0YbOAPdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7485
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Rockchip RK809 audio codec on the Rockchip RK3568
EVB1. This requires the VCCIO_ACODEC voltage regulator to be set
to always on.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index aaf7b4bed24b..1ed92531e626 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -45,6 +45,20 @@ led_work: led-work {
 		};
 	};
 
+	rk809-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Analog RK809";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&rk809>;
+		};
+	};
+
 	vcc3v3_sys: vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
@@ -165,10 +179,15 @@ rk809: pmic@20 {
 		reg = <0x20>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
 		#clock-cells = <1>;
+		clock-names = "mclk";
+		clocks = <&cru I2S1_MCLKOUT_TX>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>;
+		pinctrl-0 = <&pmic_int>, <&i2s1m0_mclk>;
 		rockchip,system-power-controller;
+		#sound-dai-cells = <0>;
 		vcc1-supply = <&vcc3v3_sys>;
 		vcc2-supply = <&vcc3v3_sys>;
 		vcc3-supply = <&vcc3v3_sys>;
@@ -282,6 +301,7 @@ regulator-state-mem {
 
 			vccio_acodec: LDO_REG4 {
 				regulator-name = "vccio_acodec";
+				regulator-always-on;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 
@@ -366,6 +386,10 @@ regulator-state-mem {
 				};
 			};
 		};
+
+		codec {
+			mic-in-differential;
+		};
 	};
 };
 
@@ -386,6 +410,11 @@ touchscreen0: goodix@14 {
 	};
 };
 
+&i2s1_8ch {
+	rockchip,trcm-sync-tx-only;
+	status = "okay";
+};
+
 &mdio0 {
 	rgmii_phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.30.2

