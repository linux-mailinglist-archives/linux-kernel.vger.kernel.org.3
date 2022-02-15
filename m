Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B694B7380
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241636AbiBOQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbiBOQcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:22 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB038A6CC;
        Tue, 15 Feb 2022 08:32:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLxPslF9DHWRq74KjZUX/EawNlj07V+TmryVl+5kQ8FJtWjW8s3h0lrUCM4kZF7HfraB+nQzbjKxXZlNSDm0dphdqBSCbSDI0Pt0EXzMF2KNQdCBZSXNSp8v0jVVSd5I6ubUMVm+lZ7yCbzNRFoMNtznQzBZj4+1sWUEnhY5AAFupvVfZJp0licrjhfVjzoYdPNUwHbul00wHVMh1ORpoN3a/Wcn3h+hXdJelS+qRBoz35AHnE4+mc0bR9A1wQYG9Vxo0SCAHbNuQJYQ4biVU4dSQqQYJOMvc21FJPuE2oxTfh7v9g97KGXFSwYIL60OMTy31IyLxhZq9y6WoKLu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMP2YqBHAlWOGkvGdU94kNAJu/iajJTp9mhP6z85si4=;
 b=mfv2D4pkErQt4Kla7kIDG4VRLdeQ7ubM9GLvwdGiEu9GOK5eg1uHIxoMf3rsjWKNE9ZmWPvMZW0XuciFrTljWEbcAOoUBciTXEl1Y+7wZQPbZRYX/5KC/ciyTEzaQXT+yy78Ov8LxuzKyPWRGMtWwpqggX4mHpFiYgNun8qjXJy+IXXoLJskW1MKsNqbsv4HzWzSjm6hvtmXDo2wZK/Hp0F3lAbgB+uv1ioxWhqG+t4gZSas/GMROJN3opMNqKEXh5jaNhGOqUpYE7EkXd8AOsSEYExNljb9IFT9gzTds7Rb+TOzUvRQwa+aKj/3j3xjtrjwSUFBLAtMh6Wij8LNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMP2YqBHAlWOGkvGdU94kNAJu/iajJTp9mhP6z85si4=;
 b=Fq2fNJ/Mx2ObfDe9ukfm112bwoDvO/cF9oNWa/KIBGin/6EmcrxzbetmMNLn/sFD/5TG2XhcZ+OlhyovLX33jKI5sLQRSVgA0dbtXdmJ1KWwzfdmswsCI+8CAyHEybtUMy084+qdvKIJ4nudZJq/rLSLdZCS1JSfTeYtJYKifco=
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
Subject: [PATCH v3 01/10] ARM: dts: aspeed: bletchley: switch sled numbering to 1-based
Date:   Wed, 16 Feb 2022 00:31:42 +0800
Message-Id: <20220215163151.32252-2-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 810c4729-602f-4fbc-827b-08d9f0a0b406
X-MS-TrafficTypeDiagnostic: SI2PR04MB4602:EE_
X-Microsoft-Antispam-PRVS: <SI2PR04MB4602D89FF46AC5D927A747088E349@SI2PR04MB4602.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iuflWkZJzG3zvcs/GQ87n3h782vhise4Zd5BoSb50wb1YqydScEH/q0FYBL1o37c06AZ4Cw6jPPQkAGW8U6r3SumXDV8zI0l2iyWymmEP3D9O263llp7PZclUqaOY3r2ZBgMURBgtc89tAwTVNuLO0/SpB7Wx5bwUdMtlyt2yddLFivTHv07YmsZgQv6Nheq2pW2Yfeji4aBh6kE464P0ky/CeGDHVdjmHX9+85bEQ6WF+0O2pu6Rm9Vy6kQm1iYpCzMarGk6vcnAUX886QhFlJTrZNjCM7tWo2xjNKH7lDZtF/7Rcs4Qca5AUOxHUEe89GSHMxyVqfDJ1o6l/i+Z3bMcJtxjIyoB4mBIw/vG+WD14wi8J9Ki2h/zPjWPd7ZadwPyQreJmC/USBKd5VEa1gi6xM8xK4qqdlHLIcPvP5fFZ0uWdfT+lYFPNYgxdvofZW/leUT35ILdGIyB1+Y1fk6KF3Qk8AlgRM/U5OzWoOHIkR8lo0++Tsd63Q4IxqebNUlxNjIk96n5S6XUUORZblY7HlO6lSGpFnJ5J+TAWR2SYQmgGM+TN5ymrS2Ye5oRiLIvN6445ubNA6xcVxwtlnODXgMtUZeDVxUGVS+aEE8DuSrtb/vbu5JDeP3L+Jw7tpfpl/6cFaZ2hnRRXsJc6D9z1TXE8fcLgjTgFaSuSN95JnLYaXhh+bayN/9MFmkQvGSQ56AnIYklxzT/zKheA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(26005)(186003)(2616005)(36756003)(107886003)(6666004)(6506007)(52116002)(6512007)(83380400001)(508600001)(5660300002)(54906003)(110136005)(8936002)(38100700002)(8676002)(44832011)(6486002)(86362001)(66946007)(4326008)(66476007)(66556008)(316002)(2906002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErhVzygLoVkJOjcZYEw33kBkEHxkeITbbHfpzIjz4BVsmRmKiDKmqg2UKhyW?=
 =?us-ascii?Q?dMnKgamlsLlWfyvkeLL4Mi1fOOkJnxSpOUFLmaq9YRDvgbt7pWG1VI6vbyQ6?=
 =?us-ascii?Q?agn8xDh03zMlQPWE0m0cIPJypDb35+bdnsbt9wT0DbLj82SHZZCeVq0jv3U1?=
 =?us-ascii?Q?cU64OmsRV8BwDsB0BS778TbyMlyIxEoOT6LTfSbdJculWTVgMVwBhDIkqYQM?=
 =?us-ascii?Q?IG/PttG1XJQqXIB6vyzVNrZNPpc0fKZdvLEAAk/57d/IwkyqXTYG8xcuU0DI?=
 =?us-ascii?Q?kmvNGu0sxW2wqO3jyTP/x0UmTQjZfqtAgKEUGLO/u/U9w8zPrDkK64k0RMyc?=
 =?us-ascii?Q?24myC/UlZAMf+Za8safC+2AYr93ZfAqpWlZ/JFXq2qiz2t3qe6Zz/cqNBTr/?=
 =?us-ascii?Q?D5OURK9qS29IGbmX0yfn5fVnlMk9SJPKpjXLml5UEL5oFxIMhCvJjOVbWnX+?=
 =?us-ascii?Q?zFfF8MnsbQiy48PeySkbmfFNzy3Q8Uj+CrE5yVVKpZRqPYdwoFESex6mqkOS?=
 =?us-ascii?Q?h/UbEi/EURwLM6ru++bFCV2zlzJH5JmUfJbwa7l7u+B+YKiQZu913Us2viTD?=
 =?us-ascii?Q?crpJzG3WKschaldFsyCPAFpXiI8tT55tHsqyVndw3vagR3idLZXi+OsXhKPk?=
 =?us-ascii?Q?zbm/v+WdxNpLOFwffy9HEwEWwOFPKKx0ohofWZdi0cjP0kwLoCTlwJ47NON3?=
 =?us-ascii?Q?JzyW20kiT0ViYyXQ43PQwFHqZ1K7lb7xTIia+jTqRtCVpoZq20yP7n1xO6EE?=
 =?us-ascii?Q?o3Emmhxxr4OufvpzXV7PjpsrUqrPlQrW1PjBNfB2i3Xfk/GUfrCLTugBPKlE?=
 =?us-ascii?Q?wPuXD2KPI8t6GQbUgwcjjdXIsL1zOvTf+xPEm9sYHiBGngHjbCZHKbeqcpow?=
 =?us-ascii?Q?4ycvvwmspQy9bacCcPhEoDw7rrKmsLpdj86V7aPEUc4lpCUi1WYelKWopVmx?=
 =?us-ascii?Q?ksBrBDJCt1SUbXNgPO/SsD9+80lNLCnmra53ASUZYIebffIc6/BomN1hGQ7C?=
 =?us-ascii?Q?JBuQNAJA4V/OiAQkTYlev3KUbyiQ1C1MOqQwtICRKJZ+goKisVRkE5Y2N3ew?=
 =?us-ascii?Q?aowK7x0Y6KcxqbcKlVRtEH2gPG+FsGoYGsc4w5pTA83LKZ19Lv2Wa//SQzbT?=
 =?us-ascii?Q?qUWOm39fqHvnJLaCLeL4+M5oewzS9BFW8xfAaZkiruWgZuwBU8WLTnLxZ4Nc?=
 =?us-ascii?Q?yiYNZ008vlKGyWGQ77YEyekehFZtDKuzLyAqsPVQ1bndknY2ZQDqhdCUDAIZ?=
 =?us-ascii?Q?45eo/vspKdYCbcuwLkM7i5W/1J45xdTO5X+qdDYIh46PrmIE53m8b3yBXLFm?=
 =?us-ascii?Q?g8GejHZbxq8xC2wa4dmn33i/kPNPzSibKq2xEDvqM6aJxBSE0Zb7xUo9/LDt?=
 =?us-ascii?Q?vybAnpOBzfS3fSAlLGHhMfFC4s+MOpTwA4pyqP83qwBIxa7SzErzcSsl4GVT?=
 =?us-ascii?Q?bXBUzoVziGFaFxs8mPrKdIPlUoMzvuNJB2A0WZelygI5aOrLpEKJvOPujDG2?=
 =?us-ascii?Q?mD/n1kKMp3+y3TXKf1oBCPa6UmIST6KHUmDKpCUQtu+VWUkeudfDQZcm2hKb?=
 =?us-ascii?Q?YhtgGGuRO0JOHeAe1P8CHGJECEkuvNVzX1zBS4OA8SxEBFrAjTudgIz+KGpm?=
 =?us-ascii?Q?ePYOe9KinWvb6T9TrbYy/ic=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810c4729-602f-4fbc-827b-08d9f0a0b406
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:32:05.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tu2OGCaVMJOe/MJx7ECBr1VYy+zrZDzd799VZPxaGkYtDk0snLY1zGH0DS6e2lfmb1zGbNaI2taOVp7yNgkpkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4602
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch sled to 1-based to meet OpenBMC multi-host numbering rule

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 128 +++++++++---------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index f973ea883b97..e77736ed5c4c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -101,16 +101,6 @@
 			default-state = "off";
 			gpios = <&fan_ioexp 15 GPIO_ACTIVE_HIGH>;
 		};
-		sled0_amber {
-			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled0_leds 0 GPIO_ACTIVE_LOW>;
-		};
-		sled0_blue {
-			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled0_leds 1 GPIO_ACTIVE_LOW>;
-		};
 		sled1_amber {
 			retain-state-shutdown;
 			default-state = "off";
@@ -161,6 +151,16 @@
 			default-state = "off";
 			gpios = <&sled5_leds 1 GPIO_ACTIVE_LOW>;
 		};
+		sled6_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled6_leds 0 GPIO_ACTIVE_LOW>;
+		};
+		sled6_blue {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled6_leds 1 GPIO_ACTIVE_LOW>;
+		};
 	};
 };
 
@@ -219,7 +219,7 @@
 		reg = <0x4f>;
 	};
 
-	sled0_ioexp: pca9539@76 {
+	sled1_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -228,13 +228,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED0_MS_DETECT1","SLED0_VBUS_BMC_EN","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
-		"SLED0_SSD_ALERT","SLED0_MS_DETECT0","SLED0_RST_CCG5","SLED0_FUSB302_INT",
-		"SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
-		"SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","power-host0";
+		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
+		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
+		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
+		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
 	};
 
-	sled0_leds: pca9552@67 {
+	sled1_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -243,13 +243,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled0-amber","led-sled0-blue","SLED0_RST_IOEXP","",
+		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled0_fusb302: typec-portc@22 {
+	sled1_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -282,7 +282,7 @@
 		reg = <0x4f>;
 	};
 
-	sled1_ioexp: pca9539@76 {
+	sled2_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -291,13 +291,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
-		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
-		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
-		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
+		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
+		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
+		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
+		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
 	};
 
-	sled1_leds: pca9552@67 {
+	sled2_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -306,13 +306,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","",
+		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled1_fusb302: typec-portc@22 {
+	sled2_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -349,7 +349,7 @@
 		reg = <0x4f>;
 	};
 
-	sled2_ioexp: pca9539@76 {
+	sled3_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -358,13 +358,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
-		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
-		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
-		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
+		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
+		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
+		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
+		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
 	};
 
-	sled2_leds: pca9552@67 {
+	sled3_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -373,13 +373,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","",
+		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled2_fusb302: typec-portc@22 {
+	sled3_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -412,7 +412,7 @@
 		reg = <0x4f>;
 	};
 
-	sled3_ioexp: pca9539@76 {
+	sled4_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -421,13 +421,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
-		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
-		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
-		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
+		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
+		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
+		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
+		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
 	};
 
-	sled3_leds: pca9552@67 {
+	sled4_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -436,13 +436,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","",
+		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled3_fusb302: typec-portc@22 {
+	sled4_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -475,7 +475,7 @@
 		reg = <0x4f>;
 	};
 
-	sled4_ioexp: pca9539@76 {
+	sled5_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -484,13 +484,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
-		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
-		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
-		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
+		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
+		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
+		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
+		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
 	};
 
-	sled4_leds: pca9552@67 {
+	sled5_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -499,13 +499,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","",
+		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled4_fusb302: typec-portc@22 {
+	sled5_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -538,7 +538,7 @@
 		reg = <0x4f>;
 	};
 
-	sled5_ioexp: pca9539@76 {
+	sled6_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -547,13 +547,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
-		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
-		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
-		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
+		"SLED6_MS_DETECT1","SLED6_VBUS_BMC_EN","SLED6_INA230_ALERT","SLED6_P12V_STBY_ALERT",
+		"SLED6_SSD_ALERT","SLED6_MS_DETECT0","SLED6_RST_CCG5","SLED6_FUSB302_INT",
+		"SLED6_MD_STBY_RESET","SLED6_MD_IOEXP_EN_FAULT","SLED6_MD_DIR","SLED6_MD_DECAY",
+		"SLED6_MD_MODE1","SLED6_MD_MODE2","SLED6_MD_MODE3","power-host6";
 	};
 
-	sled5_leds: pca9552@67 {
+	sled6_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -562,13 +562,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","",
+		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled5_fusb302: typec-portc@22 {
+	sled6_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -702,17 +702,17 @@
 	/*F0-F7*/	"","","","","","","","",
 	/*G0-G7*/	"","SWITCH_FRU_MUX","","","","","","",
 	/*H0-H7*/	"presence-riser1","presence-riser2",
-			"presence-sled0","presence-sled1",
-			"presence-sled2","presence-sled3",
-			"presence-sled4","presence-sled5",
+			"presence-sled1","presence-sled2",
+			"presence-sled3","presence-sled4",
+			"presence-sled5","presence-sled6",
 	/*I0-I7*/	"REV_ID0","","REV_ID1","REV_ID2",
 			"","","","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
 	/*L0-L7*/	"","","","","","","","",
-	/*M0-M7*/	"ALERT_SLED0","ALERT_SLED1",
-			"ALERT_SLED2","ALERT_SLED3",
-			"ALERT_SLED4","ALERT_SLED5",
+	/*M0-M7*/	"ALERT_SLED1","ALERT_SLED2",
+			"ALERT_SLED3","ALERT_SLED4",
+			"ALERT_SLED5","ALERT_SLED6",
 			"P12V_AUX_ALERT1","",
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","",
-- 
2.17.1

