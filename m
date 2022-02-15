Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293184B72F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiBOQc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241584AbiBOQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:21 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D56D8AE50;
        Tue, 15 Feb 2022 08:32:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPrT3fm/baMjKRmGCQztMKrOPjWDdpGFj2eaprkSCtsX/P56FaD5UWZinPm7XuliM5zQlos9uiP+tPgzeL/SDdD3X6sHxpgIzS02MkJ3e59N1LmCl6UedpLTd1jmuyVnuI7sEsIYQ+YuU7XywT8bg7EMes5+0JMOzrx2+5U3X1a8GznDh+TbgMNwov8y+pWQCYIQqubgABAvfKW02pC5Zh/leGLu3M4shOoN2+HVR8pGegWSgQhX5VKGvYLTqmVdRrYhKpmUommdpEwfqPkyFun2hxkymd8NJgMl20mKD+V2TaJbyaUDbfG6cApbje5aLmZqfcxPRld9uUM41MpOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ym26i91zXYG3NZ5T+ENx691CMP+Yj4da2kmQwEnVa7c=;
 b=RWdJevYUAE6aCqL43oC0t+KWZHsTdLjS/vgjpRCUhGDwG4bzqPnfsb52etdE08a/zak26GUd6S5L9vh06fD2dTFMVYNiSBWxD+eQSG9GvRfovmAP3TYMaAxiaH8Iy9FiqhACWkZqkftJE7cDheukEwbrFpYIar4qRKQ9z14gTrWc63qlKh2m0dUAqZ42Kf+c3OlhO4cWPaWhLPQv6QIrLc0MTSwr8OwG/qDabF4zRmF9p3ayPAoksV8+Q/A+BbUeAM28EStEYXiUiHmLQb5f1obxBqRcKaCTRmMK2JLML3rVvSigkjNqZQUBI1LH9Zkz1pOsZLq+KlEFg68Qn4zbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym26i91zXYG3NZ5T+ENx691CMP+Yj4da2kmQwEnVa7c=;
 b=RFKNiEbJ+oK4AK8DX2UK+1BAHcA7+Hk98mqdp9cppV3r9+yGInY6ED9dpMl/zC3GGj1x/9u4ig07gdBDkNFxC1MZuutsWLd3eNv2bouFHld7MQJlsrrO1RRpXjZXRm9WglG73qtXHgnNOknvFoEE5bEg+sGz+ZSZwpuXbkf59fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SI2PR04MB4602.apcprd04.prod.outlook.com (2603:1096:4:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 16:32:06 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 16:32:06 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 02/10] ARM: dts: aspeed: bletchley: separate leds into multiple groups
Date:   Wed, 16 Feb 2022 00:31:43 +0800
Message-Id: <20220215163151.32252-3-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd1f38fc-3d29-4871-07de-08d9f0a0b44e
X-MS-TrafficTypeDiagnostic: SI2PR04MB4602:EE_
X-Microsoft-Antispam-PRVS: <SI2PR04MB46024A85A31FDC08BC63CDBC8E349@SI2PR04MB4602.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkhqcVHeMC12saq4nondWszZ5aR0lzjLlKjEQSHkF+Ac5yKIaK5oAXV4BDEtHTnnH0svozrAo7EILkD8d1yK4gbRl63y9JwlxYvmVhEpdGZXw95La9nW3FHlvs8OswID2XUdH7oZDDlwZdqj3P4CbxmnLzPU0ruAIfL+bjbLH6BSPuOwKyM7pAcrFOlGROxJkWDJi/yCO0L7ADRwrk7PPxENRhqOBaOMsMnX1HS1y5G45+9HNTOM2+tW0aCcTGjDguawyZU88Yl4EExVtRaojW7ddQvvZ3MBMxV6v433N55gnu/fn5aZ8f/2cRznpU2t02y5F02oL3nl6fn+DvMc4+wkI2cwDbdnTBPTrx7TwHWFt+ucx4zX5lIH5nCQP7xDpwu/ykaD6cP9UWswaxRBCINO6H3C04JuyYH7u21kmVTKt1tBQaE0r39kBowOBmvrzVAYjz77P2dJ5cGNNWBK3lN6d8gi7es8I6VQj+FDX+5Ulv1ROD8fPo4vjIZIzBENXhhksPxZf6OnX61yZNK61PtJLIRE0TBSdCiKct5U+b0IlTmqBBxpY1JmGjk6xGRaJ2a4ob82EiFrjqH1+O4Kib0p3AbQE4y14Uz13I5XJmZD+OsEb39mIXCIae4edkjZx1lGthjwOFKVBmALXLS16bTniTtcqhCrBuuhxbv4d7wSzyijsN7n15lqGNqYTsgfECMeICXw0FoSbVqD/qxbKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(26005)(186003)(2616005)(36756003)(107886003)(6666004)(6506007)(52116002)(6512007)(83380400001)(508600001)(5660300002)(54906003)(110136005)(8936002)(38100700002)(8676002)(44832011)(6486002)(86362001)(66946007)(4326008)(66476007)(66556008)(316002)(2906002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOA8UYoX/ATN+LR1zi3wgVDc79jMnVbQPmjH1tgF4EYPHY/VWcDFr1vv2zXV?=
 =?us-ascii?Q?smlPn37ZIO6g4UmyzYr/7Ogcf93KinOINmdyJil87iuacrhEqKSYtxUfSJtD?=
 =?us-ascii?Q?3HEFbldJ11HUWEWy6xWGMhBtMU0bKKqDlbyc+UFFQGBe+HOeQwH9X5L08TZu?=
 =?us-ascii?Q?2fNAZjsVA7uEKHWRVht+dC0iGyw0xscxYFRJ/XsL7M+sVSeC7R8rlyhkKj7Y?=
 =?us-ascii?Q?k4yddCdIVwquJZmeon2zC8en6rkKdt8njAW3+PgGwOuMxZ+c1R2SMQ5dK9YI?=
 =?us-ascii?Q?SeCYn/1hJX1jejT+qD+d1hPRN0ULl0dpFoVH9yyeiM2VqvgDmrDY/WVEuVE8?=
 =?us-ascii?Q?bZVoMOtbizooP/HZEo/SLNqHGd32hpttqRnoaZ2Dr3qPh+mINV8tElp9Y6q/?=
 =?us-ascii?Q?tH8gG/vOdhzrzTv2qdSMfxvm5c5Y42v4jNRaXP+EjsZoXQxvM9i8bvduklA4?=
 =?us-ascii?Q?GsusK1VYNr2tAbzIaJooEghynRKqgMYa1JZcgXGzdsI5GVBtKdUjL6ysVjdj?=
 =?us-ascii?Q?mbzLUW4hIEHfDd7KNa7/ef/0UOPwTn2YiiTMqGiLgoNPskJJzm+AhVFhrYhE?=
 =?us-ascii?Q?rXu8pMFux7CGMIcJkYn3o/qGC033BOmGGXZETb2FZQMlnoYiQIqSCrRqcH8m?=
 =?us-ascii?Q?bmNeCGICH18lGBReRGh7zodDEsxSbRAzbAdyZV5gCuAa/p8eL6Mu0zHZgWJa?=
 =?us-ascii?Q?mOj+urqHDb9l8tpTZInmSeD/SXeZXeFOTBJ0jZ84FxpdafKdUBIm2LLOTm6q?=
 =?us-ascii?Q?ONLpXLlGjFyFEjsd8jDMu13uaD0DyMFsOiYGy4R3uRPieD+6za5AY7mA+nED?=
 =?us-ascii?Q?QEFA1MIRbRs7mvJ+XkwqZOoyc5pVmsu68rToGzw5W0qRIISpihCEu0LFUy42?=
 =?us-ascii?Q?I4xPWvRrnd8k8O3kokceiz2Z3CfiJq93pZX291UbXHKpRflTtlhX/OAMb5Ol?=
 =?us-ascii?Q?F2B7+pTRA8YvtzdZ1lVAFH9E5NiGn5U1Enaf0MiszXdbLntUopVaQwIHQ+A3?=
 =?us-ascii?Q?DReX0v5PQIOVNyKo1y4RqY+a4yi2W6I84eDVKSwgudEcDgbKEbA8UZx1bMQO?=
 =?us-ascii?Q?h+ddZcvLv4UDq/MjmOzFp+QZxWtnLw/8nKIQnO3GoYxY7P4foL8vjTrW+40l?=
 =?us-ascii?Q?ZG5Rq+VwnU47j8RRF99MHKeHW1jabYSTdq62Jvhu0Ro9Jn9jAqiEh5+IQ97P?=
 =?us-ascii?Q?OZ/cUdwPRkrkq/f5x/JdXoewOPJQWpIqjtYgt8KGP3Jjo2ncgMhbV8f3SNPD?=
 =?us-ascii?Q?c8YV2BlsWnT4aHdaZzBWxfc4juh+00XNYYZLX/KNNIjQOmtEN8VVLL+gPW7C?=
 =?us-ascii?Q?5XiPI/STveE8cDSB5qweoPDQCEyzyg/yzdIxwPX2KcBDUQ3ud8QJOQPHatO8?=
 =?us-ascii?Q?/0c/jyZho9zRbcziLjLldaRREvG88a1GhYWTKxMM6Dol0jYTKpcnYwhTgI1q?=
 =?us-ascii?Q?n4tPl6I3fcqVlkabwtCsdbLY2shT9CuQdiUg5Xgd5yM/5k84fM8PwpMjhF+o?=
 =?us-ascii?Q?XHLfkjWJQm6SxM+MG54eA4zNQET5rPNmXqgV6HCfDTKUyTVRwQ6yiA6GRpbg?=
 =?us-ascii?Q?tMFpHyro9OuPMQbCc5yyG9WoEexAeIQ53sSmA+Lh6u2LtGPE+9eZ8AOD2TbX?=
 =?us-ascii?Q?JWk/AdfT55LtqYviOiAL1A8=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1f38fc-3d29-4871-07de-08d9f0a0b44e
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:32:06.1488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KknDARdb9ZQleMtwN/Ic6pep1ut33DX/uBHZ+w4roU9Asm6xOtjTHTiipoE83llnhbjHGQJUYVk8/E0rXcUT9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4602
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

