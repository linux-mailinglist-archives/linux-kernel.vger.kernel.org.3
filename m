Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD804B40C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbiBNE0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:26:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbiBNE0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:13 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB584F449;
        Sun, 13 Feb 2022 20:26:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjxkinYCTrlevtI7eTOSvYaWZIs+HiSVC+PYBw/tHbJXFRBs2GFXnKicgepZdtPYLl1ARYoatlXuBRg5xqA4oEinen+/NMntY6yDP4VP9P8MMIrss7ICRNCzvVXYGmXK0CamKktRlHctCfjQrfhbZSLD9YVbgOw4zNgiUjhWPMWE8NAlVL8EVCKYFi3El2Dr6Yz8vYUV1fsAz0uqEHFNEyqF/eZPEKesmwSb7obotWO1WOU3KO5TN9GsfdoTEs/JksviJtAMq8MIYs8tAFY97ZmSnTJpsOZj+F72i2vNxUH26TZHQTm40DHnaGhHqNSjGQ7rtFZ68Ay8co3cLs/IBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U+qZMiEYQuuwUYthaqKiZ4rPo5rYgpYTpz5r6aqttg=;
 b=KnrbZyCSW57rKpbd2lT/DjH0y4bNh29DyisM5OeNLHbEZBeMzSoaj4BzqtOue9TwHGxo41hmtSGlBpYF+olnpKg1gMD1jCV4DiL1evW+8sSvzFXQJz8ykzAJdwCWtzDiTcJe2QaWO+LEM63qZsqR60sSAE0+XbtuV422ez3p2nnO1dyjhs7oxe6ocHdMF4yHkWT60ILTr2DEfE+PdU7y3nVzN5r6LMomF8D6rZ80RHGO1nuK8L8isLWX4GjQd8dFdB2g54X55uxCgaJnX8sekZ8xnzNjcZ/tBK3tjbn9DBWjPRnWs3n0LcQoRqpwTwB3VkgdS9NWVhJcCXpcng0T6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U+qZMiEYQuuwUYthaqKiZ4rPo5rYgpYTpz5r6aqttg=;
 b=WosEV7K8Fx8YQvAxlx8uixBGQuNnSbuZ+1ftw4E11RoxuLFvVnru3bFuh09Ygnx7aUOna3M9NnIeZUT0Vg6RDjuYahVYbZxnsHX28HXZ+0efk5CyydPTMxC1PC+zs6XD0nEfcAvkbHBPZi70jO9e5lBBOp95Dy1k8i3avXN42lI=
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
Subject: [PATCH v2 08/10] arch: arm: dts: bletchley: add INA230 sensor on each sled
Date:   Mon, 14 Feb 2022 12:25:36 +0800
Message-Id: <20220214042538.12132-9-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 307ef40f-413a-425b-f9b1-08d9ef721b7b
X-MS-TrafficTypeDiagnostic: HK0PR04MB2451:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB245171151669597BE0EF7C398E339@HK0PR04MB2451.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uo9S4v0P2jUYuPeB1kOhm2gKGPoCmv981jAA8x1JWaGf8sM1f7kR8poXKHNrmYJ9HopD9n9X5oCUdX7teQQnchpI8KOhFchss/uSHHxCSXDT2ELuV8UrYavrUZiTw7CoaKIFG+8fVFWmCreJP/i3VrgkZ4+8K3o7/FfMKipcT2tgYY5R9+H97Hmtt7jeLCFTWh8ULRMkRbcNXTJw0LfdRPkmkwQKN8+LxveBsRoUWuJRT+mGFeRsqND8mGOjFt8Ut0OPoqkMXQjflzyLn9XYiR32S3PihBAai4c7E7qXhFM1Gln6+zJhBg7yzJ80/g4JbqnRVUWumCj79VVGrvLJqbZRqYm8F0FZ9OQ2s/uwSlN3L70uCZiaCPgZ1GNz/WlOr17aAFqVdsqAW/1bKsZU8N2Bt+smlIwEe+QJuHzdK9QqPEUVgMb8hYU7uzEa/jY+l4/cGnZizUQ+QDZeTCAM4x8QpXHSDCAj385Fc9to07GzAl+u5K/QVh5q+o304m+1o3RTdhfI3zEOBlxouzflXhZNb5XnMQuqcR5/aDKO9worr+kyrfTgiMwGDLVNmqBXc9sMysO3tdACm2CtNgbxHC+CitH+5LHdAL1org+dq61qSvOkG8+pnoXVFLtb6xazlRFWrhDC17toCYeH31PkEfQYHEPXb/q2dNCJA4aA6Tj/Hlegg0XGUfR4gm0TTm4T50U9FOeas5tt5lgGFhkWIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(52116002)(6506007)(36756003)(5660300002)(38100700002)(38350700002)(6486002)(4326008)(8676002)(83380400001)(6666004)(66556008)(66476007)(86362001)(66946007)(186003)(26005)(107886003)(54906003)(2616005)(110136005)(1076003)(508600001)(8936002)(6512007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kAgf3XlGPn3PfnwrLbAAPt0RvcForiYQ4G0FJsM67iSuL2SQ9O9/XQvxiY0W?=
 =?us-ascii?Q?Ws3xQ4+I/EOt9inIE9zLrk3tEsWXMiXbvs+fmu9P2RBxw1ixMoyf0pgIvzD8?=
 =?us-ascii?Q?175QrVTmh+tLYjp11LmigsukWHP/BBvNg9o6ktiE+vrLYs6GJey0znqMKLvn?=
 =?us-ascii?Q?wJF0XBDoZM1ZwZoOGkTtS0KMSf3gfQTTtiRiesUo/epUWgjb/Pja+zX4nEc1?=
 =?us-ascii?Q?kLaLHpOv4ILsvNfTjXi47Yg+Vmn+nmIHpSoND/zzXGFNodkTHdk2YHpo8fSQ?=
 =?us-ascii?Q?eGyNc5ZbblVTG882iRV6Z6DUmGidM5j5n7RMZ3w4/VMQfKO7KqAUp050mpeK?=
 =?us-ascii?Q?/+adtkVj63JRL4kA4gRdltQ0+Sr/XoE/+O3u0cCeRRqokMumiRJo1/4gtwXF?=
 =?us-ascii?Q?l1Wp86s6dZDFVFe7XXP844BnGLmDV+FRfjz57EY+FJe2XWpmfbwxsAGCE57u?=
 =?us-ascii?Q?ItEfRFhmB1y2JXyd4m9x//DkoiEhvP5BBqFymPcdOnf6I++Udxp7KLHLDnb3?=
 =?us-ascii?Q?Ko83f8bM3BOTBEs1BTVR1V+Mnpl/QZ5PE/yW1CG5aoTMdKa/kwKExkkxy5+d?=
 =?us-ascii?Q?/uUn7fDEgRaTk6jNAP1vMiyLoiRmaDZ+1VappMF6GlzJ/HsM2qo9b+56oxYO?=
 =?us-ascii?Q?Z8RjtK7b03F1QY/kDuV/3J2xAwyj3UcRJwOb+aCKpfVPL6jdiCyEhSKmddd7?=
 =?us-ascii?Q?jZcRj76obIeRs5L8+hFTUiR6yfFgJZ/PnIzB+UIaG4HId5xGrtzHPtUt1eJq?=
 =?us-ascii?Q?1+MgrAjy6lBK3dOI3Q2r3RU4qDPJ1KZOOqoFqXogzX7E/0Pn1UpkA4OPncg0?=
 =?us-ascii?Q?/9R1nq482j7vLif+VFdC+kI3LOBdArcd7q2ZffqyfeNwWPuFghtIIUwPpXKk?=
 =?us-ascii?Q?6J+on3igLnECH7udFO2U3qaKINBL7bpQn2NQfQmlHyT2XITj16/IuXUZNI+E?=
 =?us-ascii?Q?v6Gs8JRU5CT213E6/65Cy3voXpXiF/XdXcT2LWUIblXYbVB6yj1iMNbxCD3+?=
 =?us-ascii?Q?k6wOQAhBfLIMjXQFhPZBOxVXUD+PxuITkgCYC0/JD1HvrsEPMiQpW7MaIyVM?=
 =?us-ascii?Q?IQ8HeYFqxAukypgYNzLwnx8oZlACMuDbDxb0O7oYfyC4ZtPA+gxyqnPb0upY?=
 =?us-ascii?Q?6z4ndtZagB+J6lG0ovxxru2HMQf5Ra9BYY5Mjd/JDmXJRCe6RBVt3LfgROnp?=
 =?us-ascii?Q?uuGetlZYFYrfU9TDlrYBQEb81glJr/jNcst0XHOdwYnHuMn1vNZ4Q++0Gvjt?=
 =?us-ascii?Q?pzWL2JOZiZxPgzhLoFknZa9y47xzUMFjX+1dzHwGQu4WEN+q1MgWA06sE8pz?=
 =?us-ascii?Q?eJ7G2t2tGHK4dcpuQtXGO7/QsvE/sh+dVQ9cavbOD4n21wfl21KUyNHaC/Vv?=
 =?us-ascii?Q?Yhu3ovFY4Yg3U/YvmJQUpn2UlNlLOntIwmwVw3M7UWX5caIv6kc1sKA1N0X3?=
 =?us-ascii?Q?EqC9lUGiGqHBX2UivOeOse/e2TJxUrXzoxkVrK/7X+DU84ckyf7mizFxSPQ7?=
 =?us-ascii?Q?gy527yZrRBeYiXOc9ths1Qy3jLZ0bsYPQdTtLpJSW5lpSw3dMy+MbkKO5lVr?=
 =?us-ascii?Q?meYvsolcQh5qmgM5SjaVwUZnQovLPbWwG/ChsgH4XE2b+NVvBGcrgVGPhzS9?=
 =?us-ascii?Q?nadDxzqNHzo8endAC6FMiBg=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307ef40f-413a-425b-f9b1-08d9ef721b7b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:26:01.7618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zv9xgiMcUau9JcfX5Nh1DQnT5FjdKox/jEddrfpZJi5hx+GU5kKNFLXf4ym3HOT7U7d7Oc9Ox+TPNZ3an8257w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2451
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
index 76c086ea7b71..8c8fbfcbb257 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -249,7 +249,11 @@
 
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
@@ -315,7 +319,11 @@
 
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
@@ -385,7 +393,11 @@
 
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
@@ -451,7 +463,11 @@
 
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
@@ -517,7 +533,11 @@
 
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
@@ -583,7 +603,11 @@
 
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

