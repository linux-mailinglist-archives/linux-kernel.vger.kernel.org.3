Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDB74B1B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346981AbiBKBoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:44:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346980AbiBKBoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:44:19 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300092.outbound.protection.outlook.com [40.107.130.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366205FA0;
        Thu, 10 Feb 2022 17:44:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScovJ8+rqJqvmd5+vn4A+h0uYv9biEQQSjcTJqCiRVOPey84E5xITnHhKr8x+QYr1K8TFpemUbxBd+orrh8874gtv5dbpHCKda1KcRy4sTOCzolebd/y8HVazcuyQC+FjzatoO243ukOQw+w9KaOcr9Lwyao8WVXG/3omlkSXjqrrTbk/reN7vWxkEOLHFzsQbuSEEumbqUzWbvFPkB7+13ZoRd+HVCb27Olf/jj6U7EYzLQ7ow1nezjEJD0E1Lo/jd96BxThYXPtzXyMChtbJMVoIHk8goitqff4bXfuEHCA+ISyJnjimfPeDTAcK5VI4nXUp9KH4VDuQi611ogQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ODo0f6OUqSBY8DdOCRYNU7UQbznWvJKWHIANZng0y0=;
 b=AHN19XygbWiQiL7xgmZc0jOPrGhqQMGmf0N010jgwGOe9bwimiFNIUEK1N8JF0rq0sD0okltrEmDtAThwB/Qw2z54infOkZKZh4u427G1KaYjKJpQAAsHkvDGY7fA0iMc7B20w4tHuBlLAwUoq8+5sfwJBssSXf9TvhQnL0DrNxXpUGq5DCpVjgddKoBr0GgtSCYvY+z58ZshQQB3fh6tGN7G7dOUzpovmOHAadYMyDZnCV242rPEW6kQRyLHz4wMGcsLufoGnYLvcLW4nO9iFBP3EfRW6OJftOHU6vb+1UPv9GivH66E+S3zfE+L1u4GlNLD6tXibxfOq+QMOV6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ODo0f6OUqSBY8DdOCRYNU7UQbznWvJKWHIANZng0y0=;
 b=Jr0AD0fy9CXHIHtN6luOwjHhQjqTKdeLf2PsEIXmNdxLoUVibS+tFKa17ThCjXuhQ6HM0tD5SjDUSbXbKY8Q8+tR/qY6XJve7iAXaBHCPB7YR0D66JDIoWXAQCCrHH0lgQlcPZc/94Y64vwQMTjQBHz5lgrAzg6n5iID1etCpK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB3577.apcprd04.prod.outlook.com (2603:1096:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 01:44:15 +0000
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
Subject: [PATCH 03/10] arch: arm: dts: bletchley: update gpio-line-names
Date:   Fri, 11 Feb 2022 09:43:40 +0800
Message-Id: <20220211014347.24841-4-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211014347.24841-1-potin.lai@quantatw.com>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a6adce5-8167-4786-8b05-08d9ed00022b
X-MS-TrafficTypeDiagnostic: SG2PR04MB3577:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB35771A87A6228497CD1EEAE48E309@SG2PR04MB3577.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6V6zkZNMhiDaj1y21wdwp804KPjIGsYjagrsAIK40tQGZR+baeQMPzvcSiAVgYFMI6YrkPe13hLif6plIYmjjcVHlFJBBcf9UrMMOxYjqvZ6R1yTXgO8t9nCqPdis9xFSQF8FNayrDEo1OXOFm6q08NUHbpRLh26suS4RN1aaRLflzDFTsFDjxXVkUrgdHgtfvonS1fANeWujzrXw85VPv0DdU9gwaQ0Y5c582tBFHA5DiuL3KX1VIGhYlcjquRYianJQ9UlCvto0bDJcsZn4IltDwSBYk/UHnLiEIFqmf3S4M/XMu2EhWuWRsRkRDKoUY5AC5L/VX2Ek1bR3wxMS4pG0SffYpVN9Y3u16b/nB8K5v6MZuCI6HhCQ10gaZ7Y1RUaujlwh4SggU7DtQ38afYerMLITDv54O9wtPISa5xM4PQi5Ywc5EeLDc8mR3cPrccnthIFXZb0257zTawIFuB5VYiiZbIYCaXiljpWnjSy/y63viE/epsgOIftNZVQ3XTuuvZtwaPfLgcaFIxE/VnwjzCgd09x90AuOVHSZMG4bAFV0wPI3b6h5EJFacUlm+wLbYU9wgkeHG7bLLB+adnDye/nmdsSAZY4w2gGurkA5j4AvnAf/Q9uaUSVd3wjZwpQNpYgsqz8ka3sfCmYvDTVI3onyupw2gJ+FvS4jr9zo/DwRAxfIFo1+TSzEgEq6nf70e50P4JcwxIHdxeAIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(110136005)(107886003)(86362001)(54906003)(8936002)(8676002)(66476007)(66556008)(316002)(66946007)(186003)(38350700002)(2906002)(2616005)(1076003)(38100700002)(6486002)(508600001)(26005)(6506007)(6512007)(52116002)(44832011)(15650500001)(83380400001)(6666004)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9rvG2r0UWGM0YXDKTCu2wtWVg1+hYJOekbna+/NtWAj8W0ZH0kIt4s05x8ty?=
 =?us-ascii?Q?tidGyvybLPNfZ8nVDCbW+z3C0+0kX9IkeHo2Y5SEjmDfkYCrr1jIwKTHMrHH?=
 =?us-ascii?Q?v7zZzwFhOWT8TWGnONFjS7nO/BoTGC+fYX1pPG6972NGdm6aSVZRqVat9UOZ?=
 =?us-ascii?Q?NV5Bdm5EIkGjLd8zgOwkC7z+4IihY8lhEm5vbbEUkgm32yygndm3nzoAb51M?=
 =?us-ascii?Q?wOX8/hm3mMHHWxmdx8Wldxeter/CvXxdDg9QxKIgjMkRzLImLbw8sCMYP3OA?=
 =?us-ascii?Q?Z8B/3jC7un/gPNBSVUQDd3T8KJ0V6n/HobYD2zE+urIh5XNm3thmBIhvdWms?=
 =?us-ascii?Q?m2rq5BBAPVqbmhyawBvVT22HAxgOyiyzx/tv8fPdxR9HSTVcJ+Zx9iPHt2EY?=
 =?us-ascii?Q?uLotomrNBBvb0WvsgpJzqLwdoJoQ1X6NHeB/S2UYnbYqGhaCvSGdRKuxYa1E?=
 =?us-ascii?Q?GQ1Jc8ma2Nabv/iJRiqrcavjqe1Ls2K5TUPsmh+rDVmBvHEGKFn8XFfStO1f?=
 =?us-ascii?Q?thCTli1Gr2OzD/lXTnu24TL/JZNMWVcZumI/8W6qBs93tuPVTrC/DkaGwy0C?=
 =?us-ascii?Q?QdsO9U406Qm07c9ck64s830HeQwJ8bcDuOYgi8XxYdB72TFZLj4bnjRCR0b5?=
 =?us-ascii?Q?aHA/9aOk3HUUwqlbEdfo2IIgpJq68YwYSBe5rWq8mr0npYVJIUgPea9oVU7X?=
 =?us-ascii?Q?tFgSseISDGRklM22kekj5yHzW4ChsHcSvHV3IsoCeY/lRG1w82cUiMgObHlI?=
 =?us-ascii?Q?xoLErprl8lrd8CdJ7KqJ/xHRXttFb4XGzXu4cCGrkOal+FhAV1AxClFfGxEb?=
 =?us-ascii?Q?TPF0kfDiw5aEi30hTj6SQniZdPqmBfcXPW5as9AhWPRTjYhPdnIeIYzUjcN8?=
 =?us-ascii?Q?l9UrSYCRx+odCSw7g0Qf8N5yPKR67L4wL0N1G2UDa9KIxR84TYgoZxu49CqM?=
 =?us-ascii?Q?++znrpfrrCLwnnXg5UHPzYPN2YdTNKrHFUENfPhGZ5kx3O7yDLG49yvBnOio?=
 =?us-ascii?Q?FRBk7Nti6Pf3yfDzhvP75b+mq8FLgi0yFzOeNd9NXvNmIDZsPl8Rxn6gG5lA?=
 =?us-ascii?Q?TsItvuFIx0cdwCWRSrUaTgKUWAdfWmObjSxENY7cD/oTqGZkhFiDLG55+la9?=
 =?us-ascii?Q?IjV33SAAvmmQqfnTLx49S2t2A6wE75Obzf23QMEYGyX2ulcri9hLKQxPaJv8?=
 =?us-ascii?Q?Nj1fHIVhXZks21O/yHmkjvU2hch1w9NGeBbstK4KPfkvR7B0zwXP+2bQg0Ak?=
 =?us-ascii?Q?jaitMRgYOBJ4/quw1NTo0rQ9mHsdim38lgFnqt88Qda1HzH6Egqnf2bg3crn?=
 =?us-ascii?Q?/aryRZcfozgM+sltbmTOGJyOT529j0VvWRM+wOWdUjdt1ZstKTBPPaZ2b0dc?=
 =?us-ascii?Q?iGUEdoELWoB8iKenGqefqjuXK/i0iW4Zaac7gQDGvM+fjFck1qfu/aVWiOkO?=
 =?us-ascii?Q?bUMVmCgWn0oDikHx42x50q8UFxfh8YFR/tvXhVn6eGL29psahy+pOh3mzR4p?=
 =?us-ascii?Q?7cA99djo3JZZ7rxjyW9ho+NNFvuj7zBKYun7tnwQtI78ywz0WECltFPqDzSm?=
 =?us-ascii?Q?hYel4XHJhyAK9ksB+18XRgy+9J3QprUzagjHSLxL/XvIEIBy++rGHHcTDpEW?=
 =?us-ascii?Q?q/VD4nkVB1fpozPnPwoPZgw=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6adce5-8167-4786-8b05-08d9ed00022b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:44:14.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQ4bdhhN3mA7KsfMOUPhI+F8raR9jKW0rEKxEK8FINf+aD1tNMJ7Rw3R64XSmhOwMNu3HeBraossJWbcgyfYcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3577
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update gpio-line-names for gpio0 and all io expander

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

