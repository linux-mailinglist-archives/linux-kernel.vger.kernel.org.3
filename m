Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610904B40C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbiBNE0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:26:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbiBNE0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:10 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300132.outbound.protection.outlook.com [40.107.130.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C964F47E;
        Sun, 13 Feb 2022 20:26:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wdf0sCPpTr+vzuZwHxXDZjHtCGEQ5i4uOgA41+ZznBhfzAFeYlbtOOzGmaGLdaANP8G9XNtRH5tAL57cKNhV1iu9g4EZrpS4jd6MIs8UeEn2NRpdlUqyhnV1w8ZJ60pqSprH7LYv6tyvj6KaI9RKJl2KQXJ01h06Sv4CNT9HJg8dswrj8srXkq1eqJ5w/N3nJUObDlZyzbL+A7z7dUuBfahosxpqOkV03/6PFQbFowo2HjK+HuzIx20Bq3pYJsFJMP91sTcFfgZ97kXeMpUVPHS8VO0KpjEmfH8XzM2Vnx0cxgpe853QAyRSxs0T2nnHCPSSXU59l0trH9HJvVgCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMP2YqBHAlWOGkvGdU94kNAJu/iajJTp9mhP6z85si4=;
 b=cgJs/onP9U7nRNXadNvb8q6dcs3Cj5lbUIKSo6Aa0e6h1vhvLSk3kzj/Ey0xwpLyWXrckLR9TlMsx56VYGKYrxkDLXBBVKFIvaEIzgOXAAu3xUBqRMNIAafpZgDl0MY2wNbiFxUoFehGi4vGnndpMYt4/3dXCRGB53kCXNOwt0NcnreYcI8n78HcZAfln6Livsk7oO2ncPcYHpD5K9iCZXmFUySCQohWH2MUpJDw4MrprR4tignvitJwoFJSfsuKqpyVThe7LW+XX/VR62jtKWibEtLLvX66KgcnqUcinkNhgz9sI5JoINy/sL3M0j3EVVUo2+a8BtW6gBUrYNdQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMP2YqBHAlWOGkvGdU94kNAJu/iajJTp9mhP6z85si4=;
 b=xbxFUcviuGSZorYTb7k/OjPP76DKo+SBkshnx30jgyWODqwq9F++RYhZQhXlpGbwGwGnDsflxpE8BlH8rm78NqVyZUlfrrcSe8NV4qmCQmsQ43xO/weMICPJc7kTJbqz0JROSni7THh1HEHclRRBSjrNm7JAuYG9E/WyJpPRZ3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2579.apcprd04.prod.outlook.com (2603:1096:203:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Mon, 14 Feb
 2022 04:25:59 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:25:57 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 01/10] arch: arm: dts: bletchley: switch sled numbering to 1-based
Date:   Mon, 14 Feb 2022 12:25:29 +0800
Message-Id: <20220214042538.12132-2-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f432d753-5878-4e61-fe1f-08d9ef72188c
X-MS-TrafficTypeDiagnostic: HK0PR04MB2579:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB2579F802F79ACC633B50BFA68E339@HK0PR04MB2579.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyOWbGx3+IP2/aOvKnPZQgt6g9DA8nONYcKJsWRZdP2DvxX+R8jhAIAcb0qcLP+YwehOuBWQT8XNquh1YWGbzICNU7E2ZP6pyrZGco6QDKTHns8m9Quguk4ELK+x9DFBn8GkwzKmohux8oAmEvXfbAX/tmCQ+pvab3W4JfvpQcBiQqlWpznsqudntFyVE+MwTIS8ZeKqCEdChtBdgvVycJyx0LLXejjtecPnpLGUknPvFjL/qEHgWot8/vTGB3iKyXVhPtvh8hCNnjAdsC0hYi/M2tnrrLpmZuEaWAYsS0nnwhIxNJ/dKXeSMpF9HG3rk89P8lfiMmXSKGM8pjkIVzyNLPhsL+KizRRwRqUa0qmFmJXaEyBlgm0oq7vhh5vuCdC3vrNMZe6LbUXfQsj3UjFd0Gb7UDpBqTbJvD2dI1bX66Nm8y3G9rlXBy6pj4lFhlw7WFm/F6jSJwSIUN5X3fia8paJ+zrKi26pVzADifP8MDciVZYGymQ1MMEFWwFO4RndGO/F/OIunv2JFkS2lJmNtfrHvS4gutzHwPOxCtDVobPXcO8xhOHtdC0KnIKD1jeOM3di6ykTkEaWPbAj3Ah7sDfK5aUVtuzCDtiL/cxLVGl92a85JBkmlOIKpPoItLptHvK2ogwfEoDwIirZMJDDb4PpzNYDf3mdl3O8/8W2Kkw5+JUUdhzWPI9gikTpxM/Qr+1Goz1Cu+hRB4AqEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6666004)(83380400001)(4326008)(44832011)(107886003)(86362001)(36756003)(2906002)(5660300002)(66556008)(66476007)(8936002)(8676002)(52116002)(38350700002)(110136005)(38100700002)(54906003)(6512007)(6506007)(6486002)(1076003)(186003)(2616005)(26005)(508600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DbEq+RvaTAtmw93JWHt3pyRzkMk/4WsKZ6465WnllBN6xtnw2BC1So4Lc9NU?=
 =?us-ascii?Q?1FIRQRVLO5tajKkXtkyZywAanpuq6CIp1NuFRgAq/59A/SKsVRbEXqwj0FCT?=
 =?us-ascii?Q?5h0ZEgUCUHHnjdx6niSs7NKf22yAjNcijiJwTaNSNlQjb6m3RDchxvrdqPqm?=
 =?us-ascii?Q?9cDrqMSaJzebkKv3R8+Cc27KzGdcz5hAJ210dIcg3ub7Wj/MGdhFyjeiNUDV?=
 =?us-ascii?Q?7E6ueEmGBwl0qn2chMHlf+PoVvwsUBdwkiO+aqfKk0rDdX/dJHGoj6rNgjvJ?=
 =?us-ascii?Q?d4kxsccI02kCfwqVr9Kk/H5p8CkqvmWyJXnqveGw4wkIFJXyS2b3mvBJSqqD?=
 =?us-ascii?Q?UoasLC4P4wcDyePvvn3AitYNRK6LfLAHHAJP0iwHXCE7Q41uhXpy49aZm2lC?=
 =?us-ascii?Q?MTTdErvP51kOTkzfdWG31YpfSeQ73xc2LVup6+aItanwkqPk/JTLiYVgpAOz?=
 =?us-ascii?Q?kRbA79yV3TGSPWBy/t30bZlKz7oDh+87z2qqNoOXawcKfVaL5FBweUM6avFi?=
 =?us-ascii?Q?BN2ZgMoK36MiuW8bRgo2OerkS1IzSkq6eg5T2hi+m/4OOoY+/YPR0d3aujUi?=
 =?us-ascii?Q?sO+7CFwRmjxKJXmtQdTiH1h6/e3KPE/wQtr6ow2pVTd5xbSQGRKtnIbgcfm3?=
 =?us-ascii?Q?3mhX//WJe++jbrYBwWrNJPkew0g/KH/3Mle2VH5RrKQOxnK0NP68PpBQl0ck?=
 =?us-ascii?Q?OUsK1F9AOCN5OjCL+eLnIEl4NG3H+PRFd3XUwzrWQdb/a2wG+H6wlKIUC09c?=
 =?us-ascii?Q?ziXmGB4qmx2Yh5eJ3IBNSq2Yt4SrAncrYW5K9QLHJIAM57NG3U3LaEV7z3O6?=
 =?us-ascii?Q?vZUQ+27Rtd6uHnNL7cyFuvXjM0cn5jisPrYVq+xZDRL/0GmTPSL8w0ypyDrK?=
 =?us-ascii?Q?gwaILcb8F72mpxG+gxcshTiHn4O7f5kLFrn81dfs9jYKq/38ZfQE1CBtsnMu?=
 =?us-ascii?Q?1711zzbGqTIHzGfX2Yd/pdTNKry9cKYJ4Ljgvvc9TMk4YFFMCaRWkurzT/RH?=
 =?us-ascii?Q?5hHKYERWkhiTM6XaLDsDb/Utm6L7cYT4G2S/uhSVXyioCBW4l9SLSzNezNp5?=
 =?us-ascii?Q?e36m2G0O/1QubcxuJnvmvoxQTwxQOLT1+4W9g4gLkRXhdI37r9ckDXSnhYHj?=
 =?us-ascii?Q?/Gm34CafGGwou9ghP0aKMi3gE9RZGPz/ukVQVIEoy6pvmjh4cdj8LVUwJPCH?=
 =?us-ascii?Q?EEvzs1T2+ECgVuM41asXiGkfN3mmfkREpkK86xeQ5ZTmblgRpo86Hmu+dFEJ?=
 =?us-ascii?Q?ejlYN0GR8N/mJszHauxEzGUg7ydcETrTx4Sbj8hJlU9ykDuM75TfO8YbQobg?=
 =?us-ascii?Q?XfQGWQAecLi7NqmokTwtkf/vHok3uyltRvB8Z9qPVh/+OSAvQXU5zixcz7R6?=
 =?us-ascii?Q?afEwgwKBQ6YG/ahEaAtB5g4G3yGa4NprotE8gRgfhoxJDLW/R0GcCwI3C1wY?=
 =?us-ascii?Q?3fdAixFqOYlcymGu5EVFQ/bzhqJdHvZ6i8I/2LCA1IDgvQstaRyyIy8qU7g+?=
 =?us-ascii?Q?z1PkNFntTa5rLFR43wmaRbeKRAj61rYMEoBtQ0qhSSVy8SZGd+cZGPc0dxXh?=
 =?us-ascii?Q?mJhoa/J6irVyVrRCwsZVfurUCcOWesWLUBHfftmwm4x7cPqT9WELpDG6yZXW?=
 =?us-ascii?Q?pfXe3C7QB5dFpEgMqC/KesU=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f432d753-5878-4e61-fe1f-08d9ef72188c
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:25:56.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtTB9ATRbyHVHckg/xRGK1GfMzTNytxjjYfB8lmSRWTVTOMTSaxR4zpYDzoMS1w7bZksU7iM6Ef6h3XryLZuyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2579
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

