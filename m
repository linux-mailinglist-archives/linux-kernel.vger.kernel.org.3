Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AD44B40B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbiBNE0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:26:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiBNE0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:13 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9A84F9C3;
        Sun, 13 Feb 2022 20:26:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E98rzha4uiqTWKOllOspZz4wgD21VFZlFetHd7AsoRw2tr6uQ4Q++/e8reH7pTRdD0PPPzQMVDsPeGcrwBO4Pdk4lGoJLwXCtVz/MLaIMKLXqkhJA10Z3pna5PcJvtGA8xrfI8Ql96DE3tQsUxFZiWPgIpo6GzqUJrf/qxQcCD/TTRIaPwF0u03YCxpjQAsRUE/fmKBbKwvka/SXsJJrcFH3q5u8nH109f7qDfMZ0l+5JnCz4phXNVXhHlo12NhbygjCMmTATeQv69cpGxu4aFGXuFre1ZsEUSLHieMIpx0Z/fIB30ezGaPeCku2NRs1AeFXZ+2Y3Ffsnx0lG0xH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRvFQ7lCwiX8nBe9hFQbKw9ddkl0U+5j90hDCU8eHCU=;
 b=jN3ZAS1cTonprvhQ0NFF/SABa5zuyH/MfQOBNVBlbMMl8Oi6l2nYawqNOMSV9jSQ4Wl8KJt/TNykPlJvAunuoyJTSH+8+UNYbbLvL1HfaJ42MsKNVombTlppb7BvcaY/fr9ay3296iPqXbC0JIYJLIvIIcwfpI8wDI9yypdZkyMA11BMv2pXe/fGsfxrMFpdMPmarhndvUjgprU4nrDAfx+QS+KtYhFJhqUUcISu4i3OxN1dCQlTKNQ9gMo3bzcLZJNAPmNCA3luRmSmad+BwEMKaCWoij2aROHpChi22jIaMcT93OXP/nS66rKm9JgXb5btJHBXvKCT0xRNXrh/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRvFQ7lCwiX8nBe9hFQbKw9ddkl0U+5j90hDCU8eHCU=;
 b=JlCM9btKTESkjNRW88wiOZWf2vEkAx2p77+GAP3u8rMquD6GJPKdPBQFz181HASpGSkprNOEbxQFuqqf70nblxy40vFcY2deUce31sMxsew7O47ATReYVoDPSXpvILTcGRIio1RPVMqyPivO87JTZ8xUDDp0h+MGOG++gV0FE3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2451.apcprd04.prod.outlook.com (2603:1096:203:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 04:26:02 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:26:01 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 06/10] arch: arm: dts: bletchley: add interrupt support for sled io expander
Date:   Mon, 14 Feb 2022 12:25:34 +0800
Message-Id: <20220214042538.12132-7-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 904f4ebf-0d4e-4c0c-1c92-08d9ef721a78
X-MS-TrafficTypeDiagnostic: HK0PR04MB2451:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB2451133390DBD712946BFA598E339@HK0PR04MB2451.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEt6h0eTE9oy2wOVHtm2DNEK2Ku6MTmN4RvWEFE/PF54oQz67R+AXxudPAkHitobJAUiyU9oZ0AfzYxBlNFSz89P8h/x6fcATLTN/ZzgJkN9AxPj6mcLM8ngeBkKI6rqcTmQO7pdyvsAvcnOtkacyBPjZm7dLx/sjZnj+SI1MSJfCVD5fZLsvBeuNpg83gLAlsw4fh+r1UQfYpp0ieKK0vKr2lv1iWpqm9Wqz4pwUhn8IiTVqpM8ylrxbjIDWgdsrYzYlHqRWPCQv+thpNVw6xD71nS801vCwj5Lhu2Wrvwbe4IwwbBJsUNEMEUOigMPL1nUAwWuJfuX9DqQollNIrPB6g9sT8nI0ezfjbeHuTrlMjBNQCwUiTSgQGFKmBpXeghoD79fsKO5vMGwBqYOdXUGDhZNiunr6NqoJzWJafHlU51gaju/uyCUyf9ru7oVCwfZkVDEAZV5mgbPbvtn/iJ6YoYQZWP8I9P1S/yyl27+N9kySIV1mA0FNyYJUMFQXS9/rKBXtC5xig8CEcvtH4v5gAp1tWZz268UlCQvUPQ59eaaPNF5pRVuweUZwxfHceQR4pXIjF6Ftq3yAl8C009+m9Cjdqfjh7WamsbdcUOmHJYMt6/L+8Mfq9oPY0wqnm/x1pQOpWa+8vKCJXnBiTcQoapZl3RyH/bWmZUlLoRX5hHF8V+T7ARTPZQxzhWLARRfjjZ9YsbTvAKzPHU3DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(52116002)(6506007)(36756003)(5660300002)(38100700002)(38350700002)(6486002)(4326008)(8676002)(83380400001)(6666004)(66556008)(66476007)(86362001)(66946007)(186003)(26005)(107886003)(54906003)(2616005)(110136005)(1076003)(508600001)(8936002)(6512007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FUEWY2FloXiQs25AZld08pezXqxQBVf6nLEDeV/tmDKfynbQ6ZHfsS2MvgsY?=
 =?us-ascii?Q?0mG9SCSR9ZjbSTJ/uD/yhjI3gP203EWwFEvkeSQfJfVWqXc0VJXGQphXR6Da?=
 =?us-ascii?Q?3mx5Mi3Z/LT6XqlFbiz7awC+9phNRQR7glLSGolx0OPN36zHJuhjlkD4QMpx?=
 =?us-ascii?Q?SSAOH9ZMW9vVRR1ytrtvPSsy/jnKR11TMN6RpzxJSenoa1otpQqGsgKXbmNJ?=
 =?us-ascii?Q?8yVRQuuZOyWq4wsHpMp9Xm4BOwNvhSSCo55+8nz9GQk2HZxCAq9QtQTJh0xp?=
 =?us-ascii?Q?RC4V3L/eKlS9oeTfHFDbtDP6g8ATqn3MMlx5jws11udC6HTqIbxbvxO6G/4J?=
 =?us-ascii?Q?RVOfsYx4qwGa7+0DUD92a2zxBk9IEK9rB995RyiqMMQKC5QfgO8bXmGBBT7Y?=
 =?us-ascii?Q?fGSZ6gxPnzg1H2cCKQWaQzh06yxmhhKvrAQule4K3DbykI1tDxxqJ3R7OAPG?=
 =?us-ascii?Q?sS6MN2e6gJjsSWxPymvq8V4HmxsSffWw/cwWUjGahbLqYLC76zhVtvwxdx/A?=
 =?us-ascii?Q?Et9q7eVHMf/QxtZezRgX2wTI2/7COOU092z5o/FnvRelzTI+zX4j+K9XJ2v+?=
 =?us-ascii?Q?XgnnvVeICh1JcFQnN9jpoC6ezIJ5s3/UuqjjRpzox56z2FaLfnopD7Pnd1kR?=
 =?us-ascii?Q?F7b0VZJQXeH/xgoRgY0fyWby+4FgIb3i4FpQnXyDevJvHM8NSoz35or9Xy0l?=
 =?us-ascii?Q?FFuyCE/BQ7aDy4e7RDhCGg/LVNZE7Nq4zb5Qs0AOJp33MXJuO+L+Q3o2XRpp?=
 =?us-ascii?Q?hqwm2b28TeTotpvAWus8r4sYG7q5WhxB7kbH1IZp/3Rr8Z5+v+qPzkFOHEXd?=
 =?us-ascii?Q?DEBWZvhdMsYEiviipkQkIDEW/x9pD/Ao62S13kIL9mcElDbsXoEDWU+8iyQO?=
 =?us-ascii?Q?7wNzq0495YDyHlkxqWI3kq+mMiHqidgtp99XqxokhafUnhNCuZ2OnP1rDboR?=
 =?us-ascii?Q?AZgRLG2exqLmyNyAgRbVgPTfCvPwRrzLopBh9f9wgXJwlAabQT+v7Gm2ljdT?=
 =?us-ascii?Q?suYW5VoxzpItimsM5pFcTJ8IukBa/Gy3cCVv31Yisz7TpPCQ00e+wU1j7jdo?=
 =?us-ascii?Q?VtpwA/UUERWUMJ8J6cLcHWnPVwRoxOLwBCCocEWgw/D5Lr4nbvBBNlhYv/tS?=
 =?us-ascii?Q?VpsWC780cGlTKlFOGIlH1xVSb4Ek1VLLYBFfw/xXLShYnYD0MK8ZMkLWZZ1z?=
 =?us-ascii?Q?jJR7MZsY7xOYNmgO9hrcFS1Vdi3pyIlandxll1KrwNzrPmWUv+wv4kkk8rqp?=
 =?us-ascii?Q?F4xkUklds261ObkDki53dDlYN1qXnWzcfVepN120l6DrGqa2ZBzWaR5eJ8FU?=
 =?us-ascii?Q?tclV7S4XebULReiW3iDDPj1JleZ8PjSvShbYWV3COY4Wrt1sq+voubSVkthr?=
 =?us-ascii?Q?FqeFPBvoP/C5XqsjuKR1iL/6/6dxn4Hj29sBvnY7jVszHrIudOnkgmjhzE0b?=
 =?us-ascii?Q?Bund4z3VG6JYhNakTBrCjPlisHsV8YdjkNf9MxmRIrlyTNuPDk9jH1ZhBoYN?=
 =?us-ascii?Q?B/LasnRQ8Jw3MijI7PYlV8ATv0dyW0J4tL1722Uk1fsYvSmkuDDCk2TlkIG3?=
 =?us-ascii?Q?jPs1YxxmTKCfPdDSnJEU7mriCExpO177qh8a5qAs2BZ7IOk1ApjsL1EHF0o/?=
 =?us-ascii?Q?Pqdzf4Y4qJMvMtrdFQ5oPtM=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904f4ebf-0d4e-4c0c-1c92-08d9ef721a78
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:26:00.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph+uh9H0Zd23nU5vVcSHX/GZRRreKcMGWqq3LV46iauGj0g/3soirRIOsDRJ5diAWgkjKU8xt1bwzXV/Pprpsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable interrupt support for all sledx_ioexp, so userspace can monitor
gpio from io expander by interrupt

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 3c54e4a892c9..8afaa8f52c38 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -6,6 +6,7 @@
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/usb/pd.h>
 #include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Facebook Bletchley BMC";
@@ -268,6 +269,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 0) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
 		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
@@ -331,6 +335,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 1) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
 		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
@@ -398,6 +405,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 2) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
 		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
@@ -461,6 +471,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 3) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
 		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
@@ -524,6 +537,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 4) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
 		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
@@ -587,6 +603,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 5) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED6_MS_DETECT1","SLED6_VBUS_BMC_EN","SLED6_INA230_ALERT","SLED6_P12V_STBY_ALERT",
 		"SLED6_SSD_ALERT","SLED6_MS_DETECT0","SLED6_RST_CCG5","SLED6_FUSB302_INT",
-- 
2.17.1

