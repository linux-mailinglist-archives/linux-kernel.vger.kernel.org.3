Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683FC50E1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiDYNii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiDYNi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:38:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B035BE2F;
        Mon, 25 Apr 2022 06:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKE0pCYWy/BvA22wNbsSMnxoPdqW+4A3UtfdhXWbRhRCUwKC0EyJ1etJmBp9u5jTYN1Bj9T4F5prMKLXbclHyhuCt+FxdxDohpgWfB28t2Kv4G35alS/BlcAaKjSU8p5jTR5unbsH6c01/d2D4WcjQkIVTeGrQ3IQbH92laM4ehcEBCFt7LsM8t//qn4gtDESHFo1gtnqQ+A6Y9GYCQbQWsvkpq4hPtcmrVdTXpi5f3nMjGdsSpcPD5d2lF7dODfPD62VUoKqMEINrzvWsn2a2RQNT+7GqbpQq/Hp40KUcaOSpKia2n/J4xyKx3kU/EWffQNg88sN2k8QRR814RBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X21K86JzoBU+F5yD671+jzpMWwIZ8mRc2ENic36l/a0=;
 b=dalm9KtvBaMfqo//T7vpPM2Ej8fKT8HVckHrQDG0coCPmObIEGlytFZjEU5zAcAG/X9PCPREiPqdZPIkvX4Uze7QqUyVmPUXc/UUfYGdYNXkEWiPpBS6Hu/4QNVsS/xpLk1CEgLDDiu3I66gPVyLQH2Q5ioxSbP7/y2iWmgDZdieUQt2TgiyLz8YmM8tpPgEPLH3HKmje6tEakuj0s7X1mbVPw9oeHISSzKKLnz+3YWrLUFQhJjso5tkl4sXq3Fu2S8RvBE/V8nh4EcDEJa8cdVGQPmQ32OuEPvbh4swEdZp3ywat67XCdYcfEHSGsg3lzC4cshUXsaRBNoV9OIbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X21K86JzoBU+F5yD671+jzpMWwIZ8mRc2ENic36l/a0=;
 b=tLE6GvlU4B6f0fD1UwqGZgtD4NY6qpar0EKMmuVksWOTPe0wSuA6x4yZNGokvtPLy/JB0QPe0vZEiZBrC1SKB+04a8g5qhXT6LBx4qVXbpSTOFfRSL738MiOxosry84Za0KP28vCMKjCzamLpmRLJDFeMLH/zkj0XQ40rUqtVII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AS8PR08MB6453.eurprd08.prod.outlook.com (2603:10a6:20b:31b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 13:35:17 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 13:35:17 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH 2/3] arm64: dts: rockchip: add usb3 support to the radxa rock3 model a
Date:   Mon, 25 Apr 2022 15:35:01 +0200
Message-Id: <20220425133502.405512-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425133502.405512-1-michael.riesch@wolfvision.net>
References: <20220425133502.405512-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba4288d4-2be7-4719-4c2a-08da26c06fa1
X-MS-TrafficTypeDiagnostic: AS8PR08MB6453:EE_
X-Microsoft-Antispam-PRVS: <AS8PR08MB645303EE4B021FDD34CE4645F2F89@AS8PR08MB6453.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMxVanhFQ2ANza6j9v8PSIjxfgQ+p/ygK/r0Xr3LzPooyRF2awAJEnUe4iWon7Ch0JjQ2vr1kTrONQ+v4fJ9FC3XNPPKOE7FSDI0QSUVlUGsCXiQ1XEu5IhOesul325xw3V0P+MgoAYlztvtRHAvtHCLjjIRvZdDWFHwtK7sRp6o1XgCWoR9wZXB5Woa7IIqXcXHhMeMvUKjB8qisdaG6PtfuwN26efjvF+4TN4xECg9/o3x7M72T7yECH5t06zNzsQamTQlhxyVRoThepN7ddLMu0bacbQyYhs6KO04kV1lRaUtvpczk+K3Zn23786j4PFDVsteE5IsDi8yHGz1GsVIEqNZmnAiEDUpogAhAI3OLOJk4Ik2/V+oksMdt5abAUYHltVLqdMZ+zbKSb6vcNY3CEv9FlwBlROKh4Gmg0b8Bm9rWTQDj37nQcAo2/dlug0mmmeSuqX9T/WtXDTB7sykA1i5frYjzZUxzrxScBzB/NtCUSQ1iANL0N0FYLUJydff5hO+AMEVsLsF9mYJ2RoTyZY7lHMvFg0v9ouYhfGr6cxn7sdqRSTlqZUXXycUFYpnR4L7idl2Cbq8mLg13G5RIvE978S/L4LZSDgYMup16PhLxjsfiyhx0ZzYdK9PSsFzO78yzFUDDw39mphhaZi3z6lIaD/goeNErFCFZKiCOiageVvpg5FGeJAKGARgS+NvAtMmcIufAS5oYdSWRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(346002)(366004)(376002)(136003)(39840400004)(316002)(2906002)(54906003)(508600001)(186003)(44832011)(6666004)(52116002)(36756003)(6512007)(66556008)(66946007)(7416002)(66476007)(5660300002)(6486002)(86362001)(8936002)(4326008)(8676002)(1076003)(6506007)(2616005)(38100700002)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jfcRJ0mZP8cdhFy1QS8aIq2ARK7KazFQ94z0QeJZAf4d4NIXH0G9F5igu3+P?=
 =?us-ascii?Q?S8lXyFJgA/OICNVbmgxQNk5bO1kVS9TYroQQs5nGx5vcTGF08tYx5Tomn76i?=
 =?us-ascii?Q?VsBBu6A9Hju2gf70vi7LIRq5Fz8vwqzM9M8RYJm1ldmIXKIm830XUE8M/0ba?=
 =?us-ascii?Q?y2ODl1Sv/EzAxdmg3/E6PynsX98UYCCOy8gZ/UI4QakVJ+7IF4bCgg3+mfnZ?=
 =?us-ascii?Q?hhbOve6UsCMQCSQiQM0f5q0VvPVqEgVz9mjuPnITjVe5V1Inw9BOVCubL379?=
 =?us-ascii?Q?WbQqWdQzj7ar3k24/wpirxmTrKOu3hSBi48PmFy3QyVReI+ZWTwmFME/YNZw?=
 =?us-ascii?Q?GYqZJlRnJaWS5r9/EF6Jj1nJ77EUG1ODB3RG6zX+3uU8tH+3jHmtcMc6n6Ri?=
 =?us-ascii?Q?yGSR63GlSkZC3UkDb/mhEDQ/NxcXwv7vOhcpwK73k6v1++BXNQiwD8bh3RQ8?=
 =?us-ascii?Q?PZvxtnH7ieMzY1cbe/bPKLkroP/vqhYYcuyCY4gwUFlX6GxkVfl4OML3sHRD?=
 =?us-ascii?Q?lDjnwNpMyQdeGSBYXJ7QZMvObKI9psH+ENlj9Uxl1Bw5wADJd+VfU+4eLp1o?=
 =?us-ascii?Q?3p87lSvCya9GWpRz8urUMef63r5Kdpla6oXzle1DyHUP7kx5IXCRqsIM5iST?=
 =?us-ascii?Q?1JbKpSEsXT/e0+cBuJN5m6W9w3bgi5o7po89L1s8/dGAP6zyqf28jare5hRr?=
 =?us-ascii?Q?Rs+anrpYKpH51buwjfJPA0D7qGDTghDNqHONJ00OhQvg7BIZgUTbo6rBuQGC?=
 =?us-ascii?Q?iuck+U8DvgDHo22i6RNDXHOO5Ex6fWsUpG5jRGdEeIqSJxNysJOO/xWe3vUV?=
 =?us-ascii?Q?798Xp77LBnHjEcB6CQxCvDu9AQ/45KDfwJSvBo5iAOrOPq6wDD4axmKWSfu6?=
 =?us-ascii?Q?KZ8dvjo+aJ60O9fg3b1s4/pFX1hDuflCQgzFDv7sBakNJo4UQgsTxZ53v+GL?=
 =?us-ascii?Q?VGmJfcHVSqQkZ+5s6OJpp6moWZSzdrvkSp/2wnYZs7rFiwKEMesLz9SD3WYw?=
 =?us-ascii?Q?KqjH3ZNTjM7Lj1aOET06RnOz74hqgJ1g2e9v6lPwX60TKHLAXkEavKpIkGa8?=
 =?us-ascii?Q?6yLT5OW4F/uhhdLO3D98BtI5P/5GBar3Ut4+LGevC9D/W6ct6KjDThf2aTgT?=
 =?us-ascii?Q?v6zYu/RaYBnuU4jnpRuvNBFuXH7o65rMZRNK2AJ8UAGcdtybGZFCjBpwDO7S?=
 =?us-ascii?Q?HanL+9++CVJzSJm9U9pi5CUyp3K5lxNLMJjxRQBL5awr0kz+PhP8ZXfX/nXo?=
 =?us-ascii?Q?Bst9K6NMb1KvFQ+fJKg9JlymjIoyJn4Q6znY+iFvoCNO9QfVkZs2AY1LPWkX?=
 =?us-ascii?Q?BIaXZIJNwbSd0pHItY7sOMFw2YHIUcI8XL4elBYTUIMzAJ0IcS3wTpl3Gh62?=
 =?us-ascii?Q?PKqD6HCplbMDxXnoZcx83GJp9TKCb35weC2dVqdFQzal0Fm/P6qLBqLZXyZu?=
 =?us-ascii?Q?Ihw/FiAY7JUTuWhMI/WpsLSnqucDBQXiRR7KvXTz3hLZZRBBWwBxg+WrNNhH?=
 =?us-ascii?Q?6KdYBeMFlCxZLC+gt4i6IYaD7B1SnU39tCT76rJj/kUuqI510zGhDrsifiDI?=
 =?us-ascii?Q?ObNykmYIU8CGUgI1wk9tmHVPE4/TB+s7EzO4mZ0Zz45MUB5+qcjx7gN2KrDm?=
 =?us-ascii?Q?sTonXnKV2hFU95khbVaRb2E2Z66rWT1fHvGemr3brTLwVqWOTq6HWZTWkdiR?=
 =?us-ascii?Q?CrX/tnbOOrm75L+tcMLhhuzXqd5tGrJYg8D60VzWCjI5QDcVJwjwQ/7Bf4Ju?=
 =?us-ascii?Q?IOs6f9TmTwNGhkq/S4CmpbEOLkLMZ9Kk/VzVic1QQo8fKIYVsd0M5T0oRzNy?=
X-MS-Exchange-AntiSpam-MessageData-1: 5P+v0ddZTxHjEtWFpmmByns99zJ5aB4HE2lSblfCuHjEZnNlFd2i/CWH
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4288d4-2be7-4719-4c2a-08da26c06fa1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 13:35:17.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlPQRolNGU+XhTP9ywY4EprxuRV4FeyT9KEi26aVgmtMWgCeE4xXnv2zXgu759/qD1bFHKTz/FSCuvOMlb5FiFAqTl2fhgNx6Wb6nRzAems=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Radxa ROCK3 Model A features one USB 3.0 host port and one USB 3.0
OTG/DRD port. Enable them in the device tree.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 53cf444ecb04..d7e2bc96fde7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -96,6 +96,26 @@ vcc5v0_usb_host: vcc5v0-usb-host {
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc5v0_usb>;
 	};
+
+	vcc5v0_usb_otg: vcc5v0-usb-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_otg_en>;
+		regulator-name = "vcc5v0_usb_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+};
+
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
 };
 
 &cpu0 {
@@ -416,6 +436,9 @@ usb {
 		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 };
 
@@ -479,6 +502,11 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	extcon = <&usb2phy0>;
+	status = "okay";
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
@@ -487,6 +515,24 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	vbus-supply = <&vcc5v0_usb_otg>;
+	status = "okay";
+};
+
 &usb2phy1 {
 	status = "okay";
 };
-- 
2.30.2

