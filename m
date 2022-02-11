Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914994B1B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347029AbiBKBo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:44:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346972AbiBKBoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:44:20 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300100.outbound.protection.outlook.com [40.107.130.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4F5FA3;
        Thu, 10 Feb 2022 17:44:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeO/1YjuRSrW8thjnzyTcg8BEqT2abqvifZfiOIRJeVN23AtJbG8QI1+aFnIsv0c7GOi/rcy2Nv/Ie29+8ICuJSSvBw7IASoeb4zRSErHVB4SLSCsKZyWKr1lt4KFIgc6Le/mx+W8MA3rJsYn+VFMyyEVmm9t6WwGPkz2/Kd0kd4NNXiQtALTEeSdki1nWHS/E4RaU7EWwpkjYE0IdlHSRGwtLarTRjYqL17AO3EP+nl0XuFQZwYySfZPpezvYBSvAaEhu0DYWbzI0qATaZT+OiJfuCLUgxqwgunhYBAtEiV0UXg5owEk2f+Hs6zQvdRqY4GBqoFiIsfCflSI5cFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ym26i91zXYG3NZ5T+ENx691CMP+Yj4da2kmQwEnVa7c=;
 b=NxB8ZJGeF+rqib4Ehh8GoyquVim6X1sEV1fRS/HVJVoUXxRJfzsoKbNsIn0o8ThZC2Zw2DMQIUPIBtqD1XClHFW2MH5IdbUE8KS67h4X2WLMz9bBo/mdViA/TDu+wSZE2gMjX899ecO00QKc92EpK9Nm1EkLBrJwIv41QrBqejL/0zLwQ4rwRddnnJO6rc1bkLrk5a6ktrfc0samTqzNvgPTZTTGSuGcQPWmEzds+did16MzQhkfvCDwM/wK2jxY+OQJacJMAe+imXLzzO3RVxcswMpGuzzcnq85eq6JrfazkuMis/Mt2Xuf2Q42MTryZLcbAegXh9eAXuMnm2Ll/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym26i91zXYG3NZ5T+ENx691CMP+Yj4da2kmQwEnVa7c=;
 b=RdwsIliAMa1Eww/X9o6f44PDM4JuhHreEOezmXk5JrHVIhfJe8QGZjmx62t/8H6AGRw75ya6eckOkV8pkcLVZPYVuSih1FjhhtmnjekRlxoL2V+Y9xRWQH2+UyyS213tI+46II17WB7Aakcne0LkrjhaprrRzO4QDa4icnqw5YE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB3577.apcprd04.prod.outlook.com (2603:1096:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 01:44:14 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 01:44:14 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 02/10] arch: arm: dts: bletchley: separate leds into multiple groups
Date:   Fri, 11 Feb 2022 09:43:39 +0800
Message-Id: <20220211014347.24841-3-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211014347.24841-1-potin.lai@quantatw.com>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37feb59d-47bd-440b-67f7-08d9ed0001e6
X-MS-TrafficTypeDiagnostic: SG2PR04MB3577:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB3577276E3799F7F711F8E2348E309@SG2PR04MB3577.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgO/rC723MnLR4nvznvklAmaUytsmkZPfTuAvWVNPlXojJM3hBUTXOOgnKp0SMs8IG9b//p8ViXQUc4pLcEGKVH2hYgZ6Q4EYpf6MenVHKdhYzCkHw1T80UhNQcU8qwh3Jns8LMbYtnFlZhNiT8uR/pPq3e3kv7XjH4hkoOLm+dY+dhSicKbD4JkHo1GoWKrYaG9FMTdmLX59E0/tPoLm+O0Kmk1JOjICKgiageaBvfH1HZaF2MnFz5WOWJcfYMBpIpxNNHUq8o9gdfd4GY0t9Bo2ghARNoEhKLJr7GMUkbac0niZYnflGupy7lZqgdo2vLzzYsgzpVvZ5yWpdozg33IILmadRonDrGVxuyGsf9ZAm2Ebxtb6YetrHDeKQl0onU2sNdEKLbY1lpxPev7HyuCYOHryAUKziOVycg8lwLeFUvk8yD5p2D2vBUCX+yFzJdZGBIOaI06UHI3l3PLwq4v/utbB9Bf7p1cQy4Ux6RWFIVvmhSjZK2VsV2YNW7NEaUD90zisb4S2fKIpak9BFHEwFpIXXXyMexy5fT40SH1A/07Lv2JoB7GsPtJwRsLBnrubU5TB/DyqwsxIo0JtfMpRoTwmGc3w4SfN3vWlffNbzWjNpyCZt9AiZMqVpzRxRz80gMz4uBnnNe+TN8jLv/DNmKEy8SioPMrQIBDkDHCnnq9en2QnImlgw1IgE1HOu8iqI5MCyXzQ01hBJ7zxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(110136005)(107886003)(86362001)(54906003)(8936002)(8676002)(66476007)(66556008)(316002)(66946007)(186003)(38350700002)(2906002)(2616005)(1076003)(38100700002)(6486002)(508600001)(26005)(6506007)(6512007)(52116002)(44832011)(83380400001)(6666004)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?757bmEpuxcg37Bvc/6UYBZ1GoLO26ZHI6U2uLFomnK3+Cs2B+T4gLlX2qcE0?=
 =?us-ascii?Q?PhwkjjYlLBHkvxk/81UY533J6VPT6qcK6VWYHHQATvWOZZLnTGc9HeMPnBk8?=
 =?us-ascii?Q?cMb5FvPvUJQRWT6E2/ra55UD8zS/NGiAthD+BEWpYIWJ4uu4b8a+Mat72Z8Z?=
 =?us-ascii?Q?S4jwT2xTmQEiwlImfcTdCDKNAtrqbvNr0bJqQbNKJ6iNm5rFSi+m9uLpC57z?=
 =?us-ascii?Q?cSwFFD1gcWqyb9jiOdcK9zR3AHrRSnw5p/01DvKFuivzyGVPBVsDf7Pth4bN?=
 =?us-ascii?Q?kL6poIAgmsLowiTbZKxho9+XUJ6b4uae1XU3gt3cx90edaiCde3Fo3fkwczh?=
 =?us-ascii?Q?b/5Q3iRfoQ2gZGaRiP1B2h4N7aTUm7KwYxjzjYyfVzT5ksY3A/f1tNIG54lT?=
 =?us-ascii?Q?kAN1S5khDdfviG+J1JRxgAe14D0fDdiQ5uzJU7s70Lq4q301O8rvJyCs68ae?=
 =?us-ascii?Q?3SV0hz0Ww1i+spj0rv2hyl55YC2No7kCZxTqPJaHJ8eVEvp8SdTrmVETbdab?=
 =?us-ascii?Q?rSVYcjxU+vIO58X521sYMmbjS8Ur7djSLNtg46ReOkbiFqc4MsYgSx0cVSgg?=
 =?us-ascii?Q?QIwe32Amwd1X/n5xAZxWxFBQrqObpfZrtSo0qIBpbeM5WPVc6LBXB7IUkVk7?=
 =?us-ascii?Q?EvfqaILXaPivtc7sYgK4gFo3x7hBFVVb45QCxYQgshGGdgH0iowy8yEJPoun?=
 =?us-ascii?Q?74K2VsJadkIS8hoNASHC29wGheaspP3njKW8RJ5YzzPQ0FSPwJKtb8zcrKrQ?=
 =?us-ascii?Q?SYzygwCt+gBpltIEQ923xsLIZjSNcvA1ZeANAguDZf36ZPGJNdVcjO/X3557?=
 =?us-ascii?Q?lQRe9UVrqW0YwYs0L70YwonqQl5kxcT40DyDJNxgElk0SBZAIzQVu6NDDc7L?=
 =?us-ascii?Q?ZxJvw98I30H/HKxq+QHwqGDAHljLPxd4PosFdgP+iXwH+BJlenh5l6ixBSu4?=
 =?us-ascii?Q?bXxY6/AQgAVnGyc7u4hpxLmKeXizmIANxXGlkU/pJJ2xqtFm++ni5OTUndJc?=
 =?us-ascii?Q?LqFQalzHpjEUtUWgpqtTy3h/R5EOV8pDgAi9hQh0vy3YnwZ0TIiLn+9JDh+V?=
 =?us-ascii?Q?JTKDqgcR6fIv93KssDqPUzgJ4AI6yrbHA4lj6hF90DoHYV9GkYzQVcktfKE1?=
 =?us-ascii?Q?Rw5ST2saUbPi64ohiV7b3/oi6uMAr65bMxCs91VjfuUJtTg+TmDUJN+/zKJu?=
 =?us-ascii?Q?b7S5Q6X5KLo6Nsdod9c1Z5RFO33f4kTA689FCPJh9ELSt3c7DwMN2ffWCWWL?=
 =?us-ascii?Q?urucC1WuFixRK+JyvqFxgPRlEhf8zERNy4f4ed1fq5mOeSGSS0LvzYRyvZ/B?=
 =?us-ascii?Q?jxzpktueiJsoSa4cb39TgHQ/lKHw8F4mNWnFYPsoHysdoTmjyIvBTP4WrGlX?=
 =?us-ascii?Q?LFJNoWHqoalHFki2mR7OwDq01qLFnWUeogE8cyX8L3O7d+eaU+UBG+DSs63n?=
 =?us-ascii?Q?idjo8dvHZOumSgxvmmNovoF3RnvTJZL3ficzPmh1JXVmyJh7qcYmwylTIZP6?=
 =?us-ascii?Q?ZHerCC5BIh2u7QYXcVQ9pPLSMHXt0Uxt9kO7FIb4MFMoTUYhHtqknEDDx/wV?=
 =?us-ascii?Q?6bzDPxU0+RcRuwA8IFt1FZ2pXIVmRDye+Dn0KRWMgoInAGCz5ClwtNL1P0aW?=
 =?us-ascii?Q?Y5/yOvgJy/DI+pYagaYHJJw=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37feb59d-47bd-440b-67f7-08d9ed0001e6
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:44:13.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INrCpViMiR0eSMhrOPqaFIQ8RwYh8W94P/W1+6Dwz6eRm5WUDMikWmrItmvR85HSUG01Ef2gl1F0OnY+QwtcYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3577
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate gpio-leds by each io expander chip.
To avoid entire gpio-leds bind failed due to single chip not available

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 77 +++++++++++++------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index e77736ed5c4c..ebd2430a3bdd 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -5,6 +5,7 @@
 #include "aspeed-g6.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/usb/pd.h>
+#include <dt-bindings/leds/leds-pca955x.h>
 
 / {
 	model = "Facebook Bletchley BMC";
@@ -53,112 +54,138 @@
 		// Fixed link
 	};
 
-	leds {
+	front_gpio_leds {
 		compatible = "gpio-leds";
-
 		sys_log_id {
-			retain-state-shutdown;
-			default-state = "keep";
+			default-state = "off";
 			gpios = <&front_leds 0 GPIO_ACTIVE_HIGH>;
 		};
+	};
+
+	fan_gpio_leds {
+		compatible = "gpio-leds";
 		fan0_blue {
 			retain-state-shutdown;
 			default-state = "on";
-			gpios = <&fan_ioexp 8 GPIO_ACTIVE_HIGH>;
+			gpios = <&fan_leds 8 GPIO_ACTIVE_HIGH>;
 		};
 		fan1_blue {
 			retain-state-shutdown;
 			default-state = "on";
-			gpios = <&fan_ioexp 9 GPIO_ACTIVE_HIGH>;
+			gpios = <&fan_leds 9 GPIO_ACTIVE_HIGH>;
 		};
 		fan2_blue {
 			retain-state-shutdown;
 			default-state = "on";
-			gpios = <&fan_ioexp 10 GPIO_ACTIVE_HIGH>;
+			gpios = <&fan_leds 10 GPIO_ACTIVE_HIGH>;
 		};
 		fan3_blue {
 			retain-state-shutdown;
 			default-state = "on";
-			gpios = <&fan_ioexp 11 GPIO_ACTIVE_HIGH>;
+			gpios = <&fan_leds 11 GPIO_ACTIVE_HIGH>;
 		};
 		fan0_amber {
 			retain-state-shutdown;
 			default-state = "off";
-			gpios = <&fan_ioexp 12 GPIO_ACTIVE_HIGH>;
+			gpios = <&fan_leds 12 GPIO_ACTIVE_HIGH>;
 		};
 		fan1_amber {
 			retain-state-shutdown;
 			default-state = "off";
-			gpios = <&fan_ioexp 13 GPIO_ACTIVE_HIGH>;
+			gpios = <&fan_leds 13 GPIO_ACTIVE_HIGH>;
 		};
 		fan2_amber {
 			retain-state-shutdown;
 			default-state = "off";
-			gpios = <&fan_ioexp 14 GPIO_ACTIVE_HIGH>;
+			gpios = <&fan_leds 14 GPIO_ACTIVE_HIGH>;
 		};
 		fan3_amber {
 			retain-state-shutdown;
 			default-state = "off";
-			gpios = <&fan_ioexp 15 GPIO_ACTIVE_HIGH>;
+			gpios = <&fan_leds 15 GPIO_ACTIVE_HIGH>;
 		};
+	};
+
+	sled1_gpio_leds {
+		compatible = "gpio-leds";
 		sled1_amber {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled1_leds 0 GPIO_ACTIVE_LOW>;
 		};
 		sled1_blue {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled1_leds 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled2_gpio_leds {
+		compatible = "gpio-leds";
 		sled2_amber {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled2_leds 0 GPIO_ACTIVE_LOW>;
 		};
 		sled2_blue {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled2_leds 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled3_gpio_leds {
+		compatible = "gpio-leds";
 		sled3_amber {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled3_leds 0 GPIO_ACTIVE_LOW>;
 		};
 		sled3_blue {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled3_leds 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled4_gpio_leds {
+		compatible = "gpio-leds";
 		sled4_amber {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled4_leds 0 GPIO_ACTIVE_LOW>;
 		};
 		sled4_blue {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled4_leds 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled5_gpio_leds {
+		compatible = "gpio-leds";
 		sled5_amber {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled5_leds 0 GPIO_ACTIVE_LOW>;
 		};
 		sled5_blue {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled5_leds 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled6_gpio_leds {
+		compatible = "gpio-leds";
 		sled6_amber {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled6_leds 0 GPIO_ACTIVE_LOW>;
 		};
 		sled6_blue {
 			retain-state-shutdown;
-			default-state = "off";
+			default-state = "keep";
 			gpios = <&sled6_leds 1 GPIO_ACTIVE_LOW>;
 		};
 	};
@@ -667,7 +694,7 @@
 		reg = <0x4d>;
 	};
 
-	fan_ioexp: pca9552@67 {
+	fan_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
-- 
2.17.1

