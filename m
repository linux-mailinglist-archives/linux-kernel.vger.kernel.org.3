Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146754B7042
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiBOQct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiBOQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:24 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0A68B6DB;
        Tue, 15 Feb 2022 08:32:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB8lnksgjM9fb7O+wq2exl/Z9IZBOete8dv48n2bBocT2fnyluS7HDItwhYrLf7bn8Aa4oCD+a9kEJwMJPpe3jvbjkw/IG8gFmLP0/k+E6uRKY+UN1lFAspuhjXR8o3aRCAg4bHihY9OuU3p+KQBPMgw/mygcsz+kPMjnd/bT/rRKlXyOsqCncTu7D/Q8Qyl5z50kTTZ7CupNlesKH48U3LX+eUN2olUB13zwerDxw1+uBH81DOKfqOvpfQ5MygAjnS0HyDfBQGO08AKe0m+SRdNx9Z+eN1myN3vEg0H6zu4rKMCMeGJLH0LibLoFl6u18N/G+qLFti/ORuI+85dMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcumtUcgnUbn5mDwQgyQACaxoAWKLA8B/2Z8YaBJBKA=;
 b=nVoZgzVbxU2X+FFgcS0W8T4sp5KbQwoV19MQA77ULOay1T/Fi2/HJWFPe6gAqA8p3lMnvnSCxb5z9rfPB3VcA2t0U78EiySRBuIqgat8puqaJgqmobf40Oz39OS2rPr4zlJ2IFefL8ork7pEzMLja+5Ix012fULylpIhhM3b2/XTsoEWLcchG6veel3RWDB0H5xlNiAzRgXSqtb9NgPy8nnCTEYpI5svGQDeNRKdzJGxeDYUNYbaJnNnhV0hLSDNzaC4tOdegyHiM/66g2XtAZtaRas6Uv7yRy39hWjF7eFIjboEUIzjx7oaIGAtdE/+rp7bbEXGR9l+Q0H8/QTkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcumtUcgnUbn5mDwQgyQACaxoAWKLA8B/2Z8YaBJBKA=;
 b=RZIRN3oH5m9fRAcKy+rpNUHEjI7p00zFuy96NwX+gQZdKMT6XfigUbOY0i0fCl4k6ZbpWS+L8jJn03NYDxkB3tRmPfwxhh1yGFsBNeTPdZ+jyJfz31B8pSSH/zlJZOVAzggJRx84JPwt3L1n20vVBBU25gyU/I+pa9nWhNWaDHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SI2PR04MB5695.apcprd04.prod.outlook.com (2603:1096:4:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Tue, 15 Feb
 2022 16:32:09 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 16:32:09 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 08/10] ARM: dts: aspeed: bletchley: add INA230 sensor on each sled
Date:   Wed, 16 Feb 2022 00:31:49 +0800
Message-Id: <20220215163151.32252-9-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b09c916-6d4c-450c-63a2-08d9f0a0b5f6
X-MS-TrafficTypeDiagnostic: SI2PR04MB5695:EE_
X-Microsoft-Antispam-PRVS: <SI2PR04MB5695562C295B5C162BB69FC48E349@SI2PR04MB5695.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cExAzWi9vmRk1/+EhMO2mmOZIFEiZsa0nAn9qVZJpkopG2+mFNON2n+bPwpC9825AlvK0rEPKp7738rEk2KeSF06Aom+aeJ/7o+O0Ks1bZxUFnxFaVUkHYaikhTPng5hL2kG1VN2Ay9WNuXgD8qch4t+D/261fuhKLrecNWF80I+0k7e9qdi+ZdmC+hYAQS9r3Z6gKfvLaq8OGAw2wvg8pekUTeAkPvV4ySX1ghD3aGI8BnV9GqGxZxE2epe4JwjwloUsWga40W5sW8cZb+MgWrnlFrOZbEKb+LjDYFFhsTWb0W1jUsKFX/AJuZ773qiIzZpLIw8qbwp+iqmE/foIo8n9qv2sVQ3o2ISWqnbPPea+KFwl70qwaPSpoB4MSeUVJKsP+k7CFfJ6T5p8F9N05Jhdr0w6FC+iR5Np1LI2IGrd2etCXrvP692mc4tOjaWEhIpC6T5tMyAUMiMB6wlgWVlS4zoBPn9bi9l5kkPfvXQIu5w0qk5NpvAL+bLTXGFhD8g/Hx7DaZdeBn8O5Ao+fneUXt3kI+RZyP+3frOjhmrssy1yOAdEZNIl7EL51BlnCSzOC/rfVoH+zw2GSsyj+rd6ZQjlNa44JsOlNuhjx0x7cPyKMN/Ll9pmJrwKrgxjB/nGqCEjySfIDCcct9+JY5inGheCi55nIxoHQ7y4Fcj7qohh/y5XKor7kGiU2h0y5VE7sikvJTf4qDiFjboaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(6666004)(83380400001)(38350700002)(5660300002)(52116002)(8676002)(86362001)(2906002)(6512007)(36756003)(186003)(2616005)(1076003)(6506007)(26005)(107886003)(54906003)(110136005)(6486002)(66556008)(66946007)(8936002)(316002)(508600001)(44832011)(66476007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TRj8oSTx3wu4vmIWlLRxCuTj4YMM76E2epSqpS3YQCMThV17r8PcvUwF89/9?=
 =?us-ascii?Q?DBTO1fSPg553h/ivBR5hWRKMMecsuLcxMIrJyq3mxshUm5Y/C4AaUUvz7l/n?=
 =?us-ascii?Q?U59hnv94BiidGV+ykor5w31j+jfMLOioHCAWZau5Kyq8LJMumgJMwX6oYJyb?=
 =?us-ascii?Q?L49u6UwDWa+cfNjxjV3yNCeTM78NdlSHzlsWCrzDbAiPpJpIfm0iRB5F15fm?=
 =?us-ascii?Q?L5kKfCix7kb9mh1x/JM9ipJ56Jn0Fd5nPgwlDPsFG36mVA5GhN/a47A+G3rc?=
 =?us-ascii?Q?ZlY/dcxJi3ukzcJu1UtCtNdV7KDY0Dt4MAv//ya1SybmhnRdFv8vBM9t1i/j?=
 =?us-ascii?Q?ukRn6FQ5mQwd4mxWaB94yPBaeVNnCqZWRg1UUSv7KFNwGi01qpZxto/yG/2s?=
 =?us-ascii?Q?ZwgauDgzcSnK4THjDoZjW+LkUw0Jm38gG1agK7uxRiNU2O/5woghMop3tS4L?=
 =?us-ascii?Q?lQsWBrj/XaE7NjabROjqrtOhVLQ4OKH2H0U4LzmUrVqN9pFt2Z9w5M+dy0DC?=
 =?us-ascii?Q?FGZ80mJVCIZUeECXnGisE7mUvrNoK+GVr0a1fZVwzT7WeIPc07UWi+DKCyx9?=
 =?us-ascii?Q?Odtt74/Ry1MqgKqygUYrBofCEMCHS4VI09fV53oD97dTflf/EJlRqRB+lK0l?=
 =?us-ascii?Q?WkAIR9DDxRuXWqakVChSDtlhOxaqW4BgqYLAPn66tdSNu+qXsZKeH9ZK0Ksy?=
 =?us-ascii?Q?pDMZ4ofeqKY+GxxoPbmsCZQMtm+ltrUD7leMA7MdL+Fn3LA3cQjRjjoylfYt?=
 =?us-ascii?Q?on2UDXduEeORqHmyDPnZPFd1P/IPH9aQGseAxD4qMkENpX0hjNXLtsTdcwR9?=
 =?us-ascii?Q?l8qsX0juNnTNYiOkOqeUO+i+75djE2vwgD/9A7XpZRF0S/No20L64WchoViK?=
 =?us-ascii?Q?xiPgBlg7yhKEzVjSps+mk5wZ4yxhROYMUMP2CSuZNqlkRb0CMTGxllR46AMC?=
 =?us-ascii?Q?23Y2oYt+gJ8y5A8Ddzy6er8KXhuRQ8HfhbMp7u/vU0mgfJy+6b2g3D8NqkdO?=
 =?us-ascii?Q?m1yV/PI/RuSBAAtahJRzSEkBBJH14HkMU7/X9IREgMfvN1gzSsBxy9bEz9tU?=
 =?us-ascii?Q?w5caGYcULlzhv8B33XSw7QkH+k0Ki/oyUolHPXJD91W2u0FQG87kKL5eEZa1?=
 =?us-ascii?Q?a9DOT3Oy0ytrO6//O5Kx/xze1dyOkk7ZGndpcI3sFQkQMFV67IWzEg4bO/0Y?=
 =?us-ascii?Q?xobqqSeXs57FKtIlG2AKUlZaZII7iO2QBlYEqy1j9I0l34CfjjXQlBiI7SfG?=
 =?us-ascii?Q?OBzfuKANN+nsNdJA5UJcQcuEpFg6/4oiBVzSR5NXdvYUgKM+Ph5I6DpVodLV?=
 =?us-ascii?Q?7jtvyfpVXAP39xnq3YERzvpmADm/qmGrDjtvzn38LGzOvfSp+c4sRozWicF8?=
 =?us-ascii?Q?bAnWIF+mGCceZvkhwFFDxqArMG1doqvG7IphBZUWb+iSlTSft0GfRvy0im2I?=
 =?us-ascii?Q?AP8PLxaJPXCG8OWN9IIFP6rGWhBmQ9EYCZ5LIZJPagvY7BlqfnK0/0a7K1VA?=
 =?us-ascii?Q?sOSRy4xSSlwDlCtodDk5TE2BeoBrM0pXIUg2+YJXZgdyWyYTVawxao/ifRLh?=
 =?us-ascii?Q?tiZ5WEqPDIWQ7VjhDBBHiSTezaDm/9h9wWhQUd/+lsTZYTsgTOuDJeWTGEDT?=
 =?us-ascii?Q?76rATFpsqB2CnsMwekLpO3g=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b09c916-6d4c-450c-63a2-08d9f0a0b5f6
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:32:08.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1Q/O6OLcm9UudAFH9ewjkiEniLHQFohE44pzw/ffOLnCybwAPPaMA72NRoKcXru+mMXdpFil4o9lSuK+9nIWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5695
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add INA230 node on each sled base on EVT HW

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index c9c3ff39bee5..3ab48420b712 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -248,7 +248,11 @@
 
 &i2c0 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -314,7 +318,11 @@
 
 &i2c1 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -384,7 +392,11 @@
 
 &i2c2 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -450,7 +462,11 @@
 
 &i2c3 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -516,7 +532,11 @@
 
 &i2c4 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -582,7 +602,11 @@
 
 &i2c5 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
-- 
2.17.1

