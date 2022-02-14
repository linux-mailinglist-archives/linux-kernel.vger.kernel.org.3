Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206434B40B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbiBNE0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:26:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbiBNE0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:11 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300132.outbound.protection.outlook.com [40.107.130.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A984F449;
        Sun, 13 Feb 2022 20:26:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtsQwKq30gFDbr7lG8CBv1WBKeyWXHf3uiJNpzmUzFVeUdAixZyEDnbjJW4AywAd9hKMVNFWBXLpzUY3ou1nO7BSaXlm4PtOWNyuDCstBYi331q6qJZlN796fKL6mEm2cCdafiyFxYl/nZ8K05A8VC0IbUbCsktO3hOrWAm3mx8CkPsvhr6oq9U3pv2/arehdyUC+AzltxgKtA5ARArEcY7E3WJggrM2aAh6HSPSNGZp0IhfpvGaXW0kmZImQlZzVE4QfiqvNvPfTb9oYtnQF/Lj3qAcwzUp8VRVjVGnwdaU34LF3gFIUmhnBuWeRJEQnebFcLvxkodDkCSFUgrxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ym26i91zXYG3NZ5T+ENx691CMP+Yj4da2kmQwEnVa7c=;
 b=XgQ2GmxotpR3z//3X9AupAUCq6Bo0bYqvN2RcPHHgxCn/ul9eOpdOsLQwcHXl+xFCeVhGqOUig2ATXr/npNjUjBffO3iSfl2ArcsFgFLwuxTGrI2I2iHMHSBFWRw/FEb0s6masah7Fwejl2y6XUAmsFK3dlbNLIJuJ3YqR8yuN9bF6ntWHN2EI1fFwoBt1vaCUO6KYhM2LE7Z4vMa+nipkNIG+AyUlt3Z4uIzntnEaqsRT+wr5mgYRwNaPdh8fUU5OYCuxk9qWZG7oORV7NTlUwqWy5aE+eJu6D4C6y8dBIO8kd50dDu+J2aTeuCoKtXc3nkGBgdGMhASmIEoVrilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym26i91zXYG3NZ5T+ENx691CMP+Yj4da2kmQwEnVa7c=;
 b=swp3SODLUIKfS2y8cxrog9dCsYWAiYfTbACScWZLfTNu+0uahU5RU8RHM4WEQQ7xAblBwAK0mSG6NvM4QXkf1N5Bgy8bBZiPsry432XJ9rpL3Fd/2rb09SI0ILBV57qk5LHGS00lzzh0wYyIbPY4WPDDcPhd5+ZW+7bzRJOHNC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2579.apcprd04.prod.outlook.com (2603:1096:203:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Mon, 14 Feb
 2022 04:26:00 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:25:58 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 02/10] arch: arm: dts: bletchley: separate leds into multiple groups
Date:   Mon, 14 Feb 2022 12:25:30 +0800
Message-Id: <20220214042538.12132-3-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b52aa814-a5bb-430b-d000-08d9ef721901
X-MS-TrafficTypeDiagnostic: HK0PR04MB2579:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB2579A5F39E728A924828D02B8E339@HK0PR04MB2579.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2YEUYiJWtoB4eGZQTL3miniuGkWDgTTmB1uAQ/eTrqvrj0BKJl4FOFoQneKUIVH3T+VigdNbajxbzDdUL0VC0ZgEF7vmcZ2JfPyk7VnU8PARHmvhwke57QMVYfSruSVq+A3HTQjnOLNvnB3mkzdl2V4YKK0F7Uoa4jBApLmlQlANZBfF3/I6iNElDUAHZ6+yFG8gSHG7mkdZY8NWwE3od4Ma/c759NT9KFmc5D8HMoqYchu3k7NpANdzDbGFF0aQ3l8T2R2G5QCWFLwQYeiZpq1/7U9NTd1+AgCjJwcDqeCRsN7PfpHPObPHP4ICYIG/PybjxxqVBDR3eskw9FzxjtF26sd5/0Uv53YnLCpJ1QCSLe3J+kyuqSsK84lu7U7D+J6DKApVP9VVxdp/rqiRLIUs15si16c/yPNLsRRKnffvxu+thZQpLIBNjz+8luGvGQMxIlVEz3MNPlyG4CY1S4BwizlNK14NK8WT5hhpG2HHeIj/OiIgW8403PjS1/VOG1NImKoDNJBaOlkov/d6mNfUY/+bEe+zsAFDeaQDTduRUqX6nUSP1CyrNRHPfJ+aSd0CngQrDzznuDof6zNJJ0oE7QUlfna1krY8Tko1S6e9FtPSGj4n0NzTTApd6ECEMj7+AKGRgqIli0qm8E59d0YwuShMC0tT4xjBmoGaLoeVkreGzRn5+EF1yWHSyZsMuioyhO+guUawhSHiMSgvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6666004)(83380400001)(4326008)(44832011)(107886003)(86362001)(36756003)(2906002)(5660300002)(66556008)(66476007)(8936002)(8676002)(52116002)(38350700002)(110136005)(38100700002)(54906003)(6512007)(6506007)(6486002)(1076003)(186003)(2616005)(26005)(508600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?04Zsi9NTFqPL/wUf51he4nbQNJKGUyN4nCCrpJpmVlLF3se0RXALTYea1mxY?=
 =?us-ascii?Q?7sjYk1o7gd+Ojb0otxvtP1ECHuGXYWhJHTrlSYEICRHj/CqdU+4oX1cTH9z3?=
 =?us-ascii?Q?xDVHHLUQmDMOJNZvhxZJEa2niWaUYOh8J9KCQ8vTqM1ojU7jgl+ePA6IVfv9?=
 =?us-ascii?Q?gAvueiF3L62Yk22mdoAcJy38H5vXx1/nQNAsgl8SVFVGHkU8rVkXWlWaeSLq?=
 =?us-ascii?Q?5KMyqzHTaBH7/aIE+iu3M7dqpzYdnLgs+1n43dHi4ogVB9fTU+5sfH4UFJ2H?=
 =?us-ascii?Q?d3jFbocsNTpBRyexUh5yp1/U7RWNK/bg/wvxxeJBrdwLhZwKv11CQCkioNPu?=
 =?us-ascii?Q?Y35WrmXRhy15HHOHyaWS7uS5daqeJ6Psvcfwt7UcUTgdrbVpS1IhhCJ7V+1+?=
 =?us-ascii?Q?CcD8NJojG224KKZZcMvr0KjC0s0g7ARngCQHH5J0qWLNxnW5jXauemanqEHD?=
 =?us-ascii?Q?Pexrb+Qt5iBnX25AQAV1e8h2YBDToVys1Xy3gPg41Dg4eXYZjH4LEqeOg4nr?=
 =?us-ascii?Q?80OUfl0xnAxn95cQ7Ir1fBpRI1Nm9n4Z+6kO3ru/d2PuQdcUqFJy9aPJahH9?=
 =?us-ascii?Q?/BPL6gAuDRvEzyR81iMR83R+Q4o5gi2ObAXo9iD77sSPXeskLAoJeV/hVtbm?=
 =?us-ascii?Q?K+VZduIeGC/dQCecA6rDWWPxVvpp3obbQRbHJyRB6mR4wwp1kQUgP0QPqcsa?=
 =?us-ascii?Q?ug99eTr5ST70VzAlidYhh2wl8mZ5dmAdb3h01nQ/2T80zC00126WsQ2bEVX5?=
 =?us-ascii?Q?UHh++/EuoAbEYP0JhdO6cUF2jtSOgS7dfXFmO1847k0h8Rl9r7EYrhP81AUs?=
 =?us-ascii?Q?gor7WBQbq8Y9yDyXDXo+pNZWugsb9SJxlNNdAtqmOe/qXb/L/4+KwPNsQTd9?=
 =?us-ascii?Q?NlLPWOvC13DvKHEO/IZ6ibZCZ7GbDvZaXJY2VufXK27PlAqBgPCsuzansGHL?=
 =?us-ascii?Q?BKscql7WrAwcoXV/DrSU7SGQIf+9vd8+LsqNeqCMzqtx6zhStXZPIEAfghiR?=
 =?us-ascii?Q?h8MfUuyfiE1RhgUo04XWq4nGWGi9nM233nLyeXVe101TAelY+CwLxp8S/9mz?=
 =?us-ascii?Q?9nB3X9WoJ4NphxIajKu60dvdLl5+YUJvz8izcClfV5cdbqSqLEXO4t9VhiEj?=
 =?us-ascii?Q?5tva6O/jAv5hlp1OQRRTQTGZ+0hX+8zih7oiGuO9+evq4g83Tc/zW+IneTIz?=
 =?us-ascii?Q?/D+C1CkSz3z/3mP8AL31GGrnm+AjLAWX4iU1lDf7LDrTIcYGjo+zJOUZ+xyR?=
 =?us-ascii?Q?kGlYQrxrqpJY0o+2kYNgKi8V23zEjmCtt485GxJFlmDGhpbDHd8oawdsmMS5?=
 =?us-ascii?Q?zfFoASnS+U5lFnh3JQDNlsTFMCMjcwjvEylHdKkIzyZYz6GTXqx90dmsb96r?=
 =?us-ascii?Q?sQgdZWFTpTqAWwqmclABg0dxMjUKpOBkLbUroNk9uZpqGi5x/gX70iHSRy6w?=
 =?us-ascii?Q?fCIGFxznBWzPCnvldy3qzT7SLvN3km2cft456L879vlI52PLKwbFyT6CS8Ra?=
 =?us-ascii?Q?tkItwS0GNIWSNHJY5tXdf3boCQgsAjzh2SE6upLex1wlwTUHBExZwdee/jGa?=
 =?us-ascii?Q?0moP+sXoCPtqEtqJ9q7YFinpuBrN8UWOPnaf5iijSlL9mThQ45SnleFyCGLC?=
 =?us-ascii?Q?JtFBHmKCPF7ldDgfb8/37cI=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52aa814-a5bb-430b-d000-08d9ef721901
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:25:57.6682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIQAyCzsDVgxehUA5Rvof3vyU8g807Tk7kwQlWIbFU8w+8HuZ8iLYLt9QoqR43R9pc9fc16nKqF5ZB1ye7u79w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2579
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

