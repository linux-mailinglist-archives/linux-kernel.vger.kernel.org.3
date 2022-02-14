Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257384B40D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbiBNE1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:27:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbiBNE0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:14 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55304F9C4;
        Sun, 13 Feb 2022 20:26:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcZmOzkeILkgEO+sC5ePHqFC+P1GGS4gAM/Fhec2qM7QM+pRdW7rgF2EWmdeqXOvB87rCpqj13wnaRePqwWegAqopbknl6fJZ9F8i+5wuw1lyjy5KvQSEdPuOolDKQ+aR1A3e7PDpR5aCiLKRsQWqCKJZ93oWzuwv6eX4XxkUrDM5nMm+nOEU+iN9yZAOHr896vK/OG0YraaEGUbp0CJBtzwSvhj57Jv2WWiMpb1esa6ANs9AfZCADa6Y9hFrHt/JUm5MxxjU0TnOr/uopfjGNR+UmHNEGqfr2tahkIgFIu+lBKsPkjDwk4R/EoK/UQPBt3xNBgqywLq1erCpRvqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdUJBmwjU5W2iari+ueVI/TTp3sc1eWteK4je1O4ZtQ=;
 b=l/aaqOI3SOwo/o9FeyFq9hMH56IZ4Kmx9wbrIhNjg6QO6n+zuDNNNkSpoCvusn5iU2f85LAGD/sR+0NtaP8IGz0kptW9QnU0V6MYj8p3QW3LtlNXGHwkq1glcno3icUmNh1eNOFuOHPLfxCFvA0FOtG0OkX5oZIMvG0fjyULo5fwAi9SrBWSY0mIECuEMX1D7L/DlEty/1NmaomicDEiA3xDrZ7hSw9v9IAW90VdpB4SJBODyNTJ8D74xwKtCFHz37G2qiJNGy1Pb8+fBundjmqF1B2BhJEwRH7N74Ndf0UOJ8AHN8l7KZv8P+WyGhJTYh3LoEXtQVJJxD3BP8aQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdUJBmwjU5W2iari+ueVI/TTp3sc1eWteK4je1O4ZtQ=;
 b=seDpWwH9yVQgDthzaF8spSrPjpUr0LzgRttfTis6ujw5yxCNMVOm6xhjst9408ibP6KpS3t2BcO53V53CRu5ZLNvJke1qRTUUYnNi1acbntIsDn9zCVx6KX4xg939/Rt2wZ8PDBZ1uIaO3N7GDNu89BJFpVO4PAvaYRepfkjE3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2451.apcprd04.prod.outlook.com (2603:1096:203:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 04:26:01 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:26:00 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 03/10] arch: arm: dts: bletchley: update gpio-line-names
Date:   Mon, 14 Feb 2022 12:25:31 +0800
Message-Id: <20220214042538.12132-4-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bb8af9e-6187-49cd-f179-08d9ef721965
X-MS-TrafficTypeDiagnostic: HK0PR04MB2451:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB24517CAA4F60DDFD62506D7E8E339@HK0PR04MB2451.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRt3LwzD3jYJHu9YtihaRHwynVkMh2NOvAbzNO4Sq4tc2aLu7HCIyfx1SeE2Hzl2QOdF7vx68FNWiKS4j73VeZjws+oYwDGWr1dzTCx0xPY+UTkvzvfhBURiXdX7qF1mdc1h80b0zZQtVw3QTwXn0A0/8Z0qIwWw/Wkt4UxreXHl4j/G6fHpPaWmk/dAFJzvYExR683VTIw3Pxa/FZpc3A/HR8RcAS8mjuTilg3QOhC5Irofpr7PQKwjZg19lHCoLt1zBTkmW75jPk2D1Ynktx8HSEp0LzlLsnqgTmXAH+veXsVSIW2uJJgF2LQXS8GMoLqKZdWSzllQmsSX++IXWROJVQz8zCzOV1wXoET3TdeQReFmv1H1VKFut3pnZx2HMkFETTNx9RHidfvyDAYbsmDZlQLjXveX3ndi3gkjkz1aJCOIRik1ip+w96XYnlJiCYUkTKIuWRegOyi+4uxy6xxs78w8d9F/5QCrhN8adxfshR3okEE62afyD2cpMHjWsTLtISLvMaN3qECFmmJeIWTBqCsSRKIJzPVU7V+NOulEUVV+Pn2WiGiWiDcUMc0Rp1HnAPzeaSvr2+T4cM7GtL0SIMACb9IRLJLrJ0s99tfgG9IDJScBRpg7h4m9GFYF41QHzjnx75Fpp8rgb1JAwuoKTNWeHpN2RP+S4OslX8nXP5JLKP5p0MNDfAmLwds/JNIiPDCx/Qz0sT77pabSiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(52116002)(6506007)(36756003)(5660300002)(38100700002)(38350700002)(6486002)(4326008)(8676002)(83380400001)(6666004)(66556008)(66476007)(86362001)(66946007)(186003)(26005)(15650500001)(107886003)(54906003)(2616005)(110136005)(1076003)(508600001)(8936002)(6512007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uZthlGl8E0zvbvEEV3qb+MSw5Oewbl7kGn1by2pQjlNKkiOGGdbp2t3+6NjC?=
 =?us-ascii?Q?jLxmuHoHXrZrpPJs0jw9EBaPWltTMbok6oXg6f/79RmH4bfFnVeowowp3HxZ?=
 =?us-ascii?Q?zSGKw3ky80QS6tAMXSlPAT0zk+ypF95D2wVXYQOZgbfEDOVTk/tfRzynzY0/?=
 =?us-ascii?Q?9jVdYjMXEmDylGq4HJGDt3kIeb933Aiu2DFBcgrIUc9A3y76HTKxFubdMS3G?=
 =?us-ascii?Q?//e6MIdR/ktjySESzU+yWQfNUJJBcWPvHTnX7z18uSJytNRi2gl9UT2sKbWZ?=
 =?us-ascii?Q?Robp0Jh0rTmXFMv/Rza9RLPL3TJi1T4gEWnFI4vKvmosvsTiinRmfDwXTnaV?=
 =?us-ascii?Q?oo+CgvRFuzaCPqX/r+wyu9tULSyMTZXo3c0SODxWJBu2L+EeXnzrSSYp0tKF?=
 =?us-ascii?Q?0922MQl0jA9gAra0qS2lIhW91+4eWaJKwTMhFjjv17Z41D+bL1I6t0p8qlsc?=
 =?us-ascii?Q?ygh+iSg/VkW7gQxRu5+FPwx0I3v/2UfjHLDBPBOIBJKWexRU6zvQC8uBnl4p?=
 =?us-ascii?Q?TpEEc7o7++Zr/hqhJSOx3AvoWvDD3BqNLYquPKHr9W2oZxeA/JUm6CwAngB3?=
 =?us-ascii?Q?Jg1b3/kfPA+l/e4VotatCEoyPptuljF8xFO9DdopZtGpTByEyzv9819Lf3O6?=
 =?us-ascii?Q?fNxbwWWcwX5A22aRoMRJoqJaCsqhJsUCVfwuS3cjwE1ShxwqfhvtlpEJ2a7h?=
 =?us-ascii?Q?vKwZLcZyrwM+kjZII+CpthEadeta/W6MkkBqIPz4usefYOC4XI5hAeDqOOHL?=
 =?us-ascii?Q?kFS9M2u4y7A9Bga0ZPW9+eVrX4DCzNU8KHCBh61YqkNYzA/kXP7CNCfU8dto?=
 =?us-ascii?Q?+34M7kA2nJwrY5+PcyK9cdTxYP3LJuPbcuAdw+KSqZVlgfNPJfb55tpxRD7z?=
 =?us-ascii?Q?gnSglVYjsA8Hi+GMdpvWYQ6YgDQVoUMrLlvzVQfttra5u+iXsdrqe8qmzibf?=
 =?us-ascii?Q?OfadD5GPU6GvOgGxvX8E9d97C9+5QTgr9RE6HE2TTSURt6IU1PaBjqfq5CfL?=
 =?us-ascii?Q?bknKk8owulmqtV9meOpQPK5Y0CRPO5VdPBDXJpcYsB9mo4tkZNWdl+QHz9oX?=
 =?us-ascii?Q?qK7wX/GrFCK9onYaz6BaavAmqbfd7teO/3heRWdS/j3bQEKLicE943I0q/QU?=
 =?us-ascii?Q?GHmJTGZ6x8yZkRkf/Ma1RwgckDpNknJQJW1R5wApK6aIHT19DZnN5E8NIU5k?=
 =?us-ascii?Q?EWwLT3MQ3j1QZ02bXiO6BkRThNPkDgHDXofSbHhX0TM9aAe8kd20DUba7nNU?=
 =?us-ascii?Q?GLLcJQjiw89HI4YrxajCW7vm8nyvoSkqqVmlRY7ANCJqR9xL9vqH7CmSdOcr?=
 =?us-ascii?Q?7EfLvwrfmAfobe5ZYd0jvoKH4cYUVpQLwS4mReHly/dHPnrUzGoccE4Suet/?=
 =?us-ascii?Q?Q2XtRGMmwUH7IrZaAbnmQkKXSA6PeW+YZFw0H4rzoU+HZMBuHb7hPxyVAWj1?=
 =?us-ascii?Q?bmqQt/ZSfHrshxKBxQDtp59CxJzxcOwMQdcBhBm/w0B8w7Mb5KpBegsi1HAb?=
 =?us-ascii?Q?ggvdAqrhnEgDvRFwCXoxhGNNdUjZEjWikIQ0OjYJ5E8Hg4kl2U/afPhuuD1l?=
 =?us-ascii?Q?kl63Gk7vfcz/3eH4m8HN6dTBd+ANcafbVMGK+tVJ+2jsy0l9Z6IZcZ6vcs8q?=
 =?us-ascii?Q?rk49WNZELMidJZL3YYQkLaw=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb8af9e-6187-49cd-f179-08d9ef721965
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:25:58.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cmlDhH4EaqEg7PM3gtlaIm26Z9xQvzI5lX8PgMvfWH09Fo9O6VaPdjbR1xPOYGdaiMyBLQRVnvUSXrD5/gHzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update gpio-line-names based on EVT HW schematic

- gpio0:
  - BSM_FRU_WP (G0, out)
  - PWRGD_P1V05_VDDCORE (G4, in)
  - PWRGD_P1V5_VDD (G5, in)
  - BSM_FLASH_WP_STATUS (I5, in)
  - BMC_TPM_PRES (I6, in)
  - BMC_RTC_INT (L5, in)
  - BMC_HEARTBEAT (P7, out)
  - PWRGD_CNS_PSU (V0, in)
  - PSU_PRSNT (V3, in)
  - BMC_SELF_HW_RST (Y0, out)
  - BSM_PRSNT (Y1, in)

- sled1_led pca9522:
  - SLED1_MD_REF_PWM (3, out)

- sled2_led pca9522:
  - SLED2_MD_REF_PWM (3, out)

- sled3_led pca9522:
  - SLED3_MD_REF_PWM (3, out)

- sled4_led pca9522:
  - SLED4_MD_REF_PWM (3, out)

- sled5_led pca9522:
  - SLED5_MD_REF_PWM (3, out)

- sled6_led pca9522:
  - SLED6_MD_REF_PWM (3, out)

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index ebd2430a3bdd..fc0690ccdb0a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -270,7 +270,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","",
+		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","SLED1_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -333,7 +333,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","",
+		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -400,7 +400,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","",
+		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -463,7 +463,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","",
+		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -526,7 +526,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","",
+		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -589,7 +589,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","",
+		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","SLED6_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -727,16 +727,17 @@
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
-	/*G0-G7*/	"","SWITCH_FRU_MUX","","","","","","",
+	/*G0-G7*/	"BSM_FRU_WP","SWITCH_FRU_MUX","","",
+			"PWRGD_P1V05_VDDCORE","PWRGD_P1V5_VDD","","",
 	/*H0-H7*/	"presence-riser1","presence-riser2",
 			"presence-sled1","presence-sled2",
 			"presence-sled3","presence-sled4",
 			"presence-sled5","presence-sled6",
 	/*I0-I7*/	"REV_ID0","","REV_ID1","REV_ID2",
-			"","","","",
+			"","BSM_FLASH_WP_STATUS","BMC_TPM_PRES","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
-	/*L0-L7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","BMC_RTC_INT","","",
 	/*M0-M7*/	"ALERT_SLED1","ALERT_SLED2",
 			"ALERT_SLED3","ALERT_SLED4",
 			"ALERT_SLED5","ALERT_SLED6",
@@ -744,19 +745,20 @@
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","",
 			"","BOARD_ID0","BOARD_ID1","BOARD_ID2",
-	/*P0-P7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","BMC_HEARTBEAT",
 	/*Q0-Q7*/	"","","","","","","","",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","BAT_DETECT",
 			"BMC_BT_WP0","BMC_BT_WP1","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
-	/*V0-V7*/	"","RST_BMC_MVL","","",
+	/*V0-V7*/	"PWRGD_CNS_PSU","RST_BMC_MVL","","PSU_PRSNT",
 			"USB2_SEL0_A","USB2_SEL1_A",
 			"USB2_SEL0_B","USB2_SEL1_B",
 	/*W0-W7*/	"RST_FRONT_IOEXP","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
-	/*Y0-Y7*/	"","","BSM_FLASH_LATCH","","","","","",
+	/*Y0-Y7*/	"BMC_SELF_HW_RST","BSM_PRSNT","BSM_FLASH_LATCH","",
+			"","","","",
 	/*Z0-Z7*/	"","","","","","","","";
 };
 
-- 
2.17.1

