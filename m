Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9714B1B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347109AbiBKBot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:44:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346995AbiBKBoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:44:23 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300100.outbound.protection.outlook.com [40.107.130.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69DA5F93;
        Thu, 10 Feb 2022 17:44:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUliPbWo+2pFF6XCuT8B25teqyJ57vu2gGJknsk3u1bBuedpiRfnrj3rA3Dn/2+ifXRg0FfyOMnTtJ5pEYmJwYKFd9dko50Q6GemYg1/9u4w0vDf4vM+ORbuzeQVQgu9bSJfgxVadjHYC77eASYsVRdKJ9QGVCOJaWFv3i8bzUoHvrrTDusKl3RI8tUTNTkifSkLuU6RuDr6QtD+aG36vGOlVNE/LP5N5ar1jk3Q1uBz6idrbK/GISdLl36DtaNNppP9T27npuxzomE0jhXrbp3CGtofWeSibPMM0dP+uAYe/TlGCTG80cWptZLCQJnxKYuh/wKhmujeaQApCU78mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0989AQrgtAi+w58RU2gYi9NJlJnSHgb/LxQ+6jxmXo=;
 b=NDU1yGW9scolC52yJKJxVHnY+Sg8wfLr/tfK9MRJwA/ErndLpVukze8xk1NNJ5sGAgI8bdT6lS84wRK9Sjn/Y9UTmbor9tmagLHM31l4ltZvqHJ8WwUKqeiAVenXF6Uu2xsd7CgeObEOml7mIDxZEDP78UdwoMDPx1z9HDu7Tw7binkmQbOcFAWkH0paJ0QmDn2sRdxjrl0qfQhdK74E0sNrociEtgXP55Rro4zFnLhdc+0ZeiDdwtbSwl9UBal/wh3tj59coCZnVr2f3D8Kqf1pCVDv57z51Vcz3ni+Dkp/r+HUM+naKpMOtJBFgOKHmjntkw4SMjGqWtDA2xrdGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0989AQrgtAi+w58RU2gYi9NJlJnSHgb/LxQ+6jxmXo=;
 b=WwPcPIGZBvFcLRwbYyxIKon5GJV4QUY2Bo3XU1iUT20P2H2ualSXXYNC7Ug0E22TZNGYClfSDiRJ8v9stP6gJxbTtkSQM4L6inze94FHSNAWhFiSYGKQti8z+iFFAKxQL8pHc4gBjFg5+zp/HUfyom0nwnhkDb+jh+BoSBKxPW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB3577.apcprd04.prod.outlook.com (2603:1096:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 01:44:19 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 01:44:19 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 10/10] arch: arm: dts: bletchley: cleanup redundant node
Date:   Fri, 11 Feb 2022 09:43:47 +0800
Message-Id: <20220211014347.24841-11-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211014347.24841-1-potin.lai@quantatw.com>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88f2fd1f-245b-41db-a54d-08d9ed000435
X-MS-TrafficTypeDiagnostic: SG2PR04MB3577:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB3577935DB1FC933E2993BAFE8E309@SG2PR04MB3577.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgvXX8Hd7GZOtYoEylFIfDDcoOrWKCi/ulj4rARrN09SclxLUw8zcd/kTifY0A40IJiXT/tJrDiV02MiLgoeAtRMeww5Gih2IaiYYf9t9alNyQrwoa1BUfMJUoyev6CBBjahK5F9PeojTEOkvkABDXwe/qJYM1Ah1FZnfsZxEFuUIHHut0J6zcJv9ZeQI+z8REv3GD6w5AyRKUpC6L+4GStLj4GSxKPaNhKa6R8xR32xHq/ejPr8JehcIse2y0vESNYfs5MDVB2g1DcNIWcpwvtcb24N+AcvWILI0O2uoh2tHKhIudLfyaNfU9PriVG6UE2xHN/BA45bQHpYpP5rafL/PyaBfmh4uZWavA3IAhwAa8M30bFaTuhoYjUryfzFTxNwgbFGsWi1U5kzTljYnYdwr1+IkMJassz4LYoP5rQYND1jj5/6eQwa8Od/wnIeYMCkbf03KkxVyOYx1NlHqfP1ubs+kYFUQyorjopggAEpUBwijxPEvCesr937VSZVm/QWeOZf+orpTuHB+xIR9UxdR5D2jnL3eH4xQzCYXi0xI879taaWnAcc7UQ+AQcWrwSP/3tO4Qkjjv3dSyejvlll7JyEUCI04wszN7WNYcpmM6woY87o66FFdqiODTYuaD9Tb9636srTj1tkbSJH/XXfW07oK4FbZR5RPGXbd8GBLi1pFMro/DJYjEF57EC1Rkd1QNiAXmVo3jUbQKJqkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(110136005)(107886003)(86362001)(54906003)(8936002)(8676002)(66476007)(66556008)(316002)(66946007)(186003)(38350700002)(2906002)(2616005)(1076003)(38100700002)(6486002)(508600001)(26005)(6506007)(6512007)(52116002)(44832011)(4744005)(83380400001)(6666004)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V+vivwykLngGOcZk4B+XwfSQ0qcqZn+56qurf+gnm7nJ6/kczJuMvNug8e6l?=
 =?us-ascii?Q?po9A2idLKn7jwmhL4Oex2QtF95RhpJONoqWZ8rp4zX/3WOxm5DpWwNX6/6Qd?=
 =?us-ascii?Q?NxXmrmeNE/4/He5N+lbzRP3yvQQMulhtzQtB0jIbOMzjchauA3Q14usJ01kG?=
 =?us-ascii?Q?VD3VIpj/WoM1XTPNjJ0z8+rfb/xpWZlcnzJtX8tuASu/u1n4EFxPAYhKbzwK?=
 =?us-ascii?Q?Cvw7YvEqTtJMzved63hvvsDUWUhX0QJVSs8FLwjlN12bKaBsqe+LpqTf6Bbo?=
 =?us-ascii?Q?J6xX06X7RBE68Lbx78iMENJ88M4DooXmLptq0Kk+aO1JYm2pfze3zpYAPohR?=
 =?us-ascii?Q?SNU80yVFPomL/xmDv6BZquWMPZCbZpaaqiwnJzlqyrh8BBGBB4Jj2BmM38bW?=
 =?us-ascii?Q?Gm67sj15uKymKorPSKtEfSNuAPLLT2rOV8wjM9YfOTp4eDF1Zr8ba3abCWyU?=
 =?us-ascii?Q?FhOpzyCf0vgYLll87HkcfWe8UBsfRlQPzUCvdt7kdzMgz8keNm2TDlkxBr2j?=
 =?us-ascii?Q?i1vLo+8IGma2dnn+jTU4vQROwev2CUTEKHowsqL8ZW8ZP9LQ42vVSRfG1uS1?=
 =?us-ascii?Q?FKA72L9eIwY3IqMHR3h0uL7dSC7gVqLuTPjPU8NS9EOKbksgf2+RWqXWl+Xu?=
 =?us-ascii?Q?sh0Ad7xy2tUCYVGy2htYSHBhk3mxcVzZ25WyI8su6LhnWhPznTQpbg5BzERf?=
 =?us-ascii?Q?CP8pDvz6ukV4E5oGrIWF3ATsvpqiIyTFCFVuq4ivYg6EFki8XmrQbLtdSwAC?=
 =?us-ascii?Q?+TWGECrjT4qsvwK7J35ZoNF2t9YcsBXvQpmJoLYuesSWLvxH39n9VYeGEUKc?=
 =?us-ascii?Q?9jFHKneO3l+Vcnp7lJlcnr8jO5dlDdRxS+Ul7UbatlAfvqPoRW4enOREmSwY?=
 =?us-ascii?Q?iKG/9LsYtYl8eNgtM4WkZpCnVCnhT8t66llCGsVZCeAjQ6kgKW7WDYId1SnD?=
 =?us-ascii?Q?NQSiKagfs+PmOKLhbarlUV05PTqUCfZSUgcwf01JbSDHyzeYDN8s3rv1jlTx?=
 =?us-ascii?Q?9N5B9s7j6FTgtTbWPKabOCRGHeB4EwASQ3td3Swfym5rzkQQba/Gb1w0atD+?=
 =?us-ascii?Q?iPRcbjz208wqiQaX6wv52VdhywSl7Kqkq2lcrTJvVeKhnnuWKlTBoLE6riF7?=
 =?us-ascii?Q?tVZtZw5WOrnMeIz6P9uCBLiUeT2Zg6yw2W6X5BbntjrS4Y7djqKMhqiRTagV?=
 =?us-ascii?Q?Jg42yzneiwMDAjjQAE7EEcytonw6m2Zd6slHaR5svD9CSJZMHGgNdShYCg5R?=
 =?us-ascii?Q?9nNnSmfA/31sG1D+U6tHssWwuw6ot1xGwugWPktuW1kYSinCHsZLPQef7dji?=
 =?us-ascii?Q?pZ8eST6oX6ONR7Jxhd7ZVz45KH7Jyu+qvKofo7sNa4D1kd0iq+X8YlBxL97n?=
 =?us-ascii?Q?SCH1QLUjQQfFbMvs2J3DhKQU8zspUPQGC76R/STYCwtnbw2hrRyC5Zys3nrp?=
 =?us-ascii?Q?x1wUfdw7GAYo4AdYKYsJLDOq9fI6X156OaOCy3boX9jLpfv4Zkc9cYPu7nOO?=
 =?us-ascii?Q?mw68LK1CY/pRrKnctU+wC/wZcUlyosH2YpTmlSk+MEoNH4maeUqvp5GqWOmD?=
 =?us-ascii?Q?wRnL2zr2EpzF6+rr2ft4lcWi3+nxIr+EAeCKN5qY1tLFM7HY3tq0Qf9PvbBZ?=
 =?us-ascii?Q?195+iug3WxPzbX2s5nQuuQo=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f2fd1f-245b-41db-a54d-08d9ed000435
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:44:17.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9qV3D+2KBoBvBRCtK0fbIwvvio1uq4fhHjZx6xbEeVs7wVU++glropCiLA5Yf0Tmzo1iDRFrYAM+S4yqQiCEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3577
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant i2c1 node.
Disable in-chip rtc, use external rtc (pcf85263) instead.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 946107bd8bc7..fb62a67cfeed 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -205,10 +205,6 @@
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &fmc {
 	status = "okay";
 	flash@0 {
@@ -387,10 +383,6 @@
 	};
 };
 
-&i2c1 {
-	status = "okay";
-};
-
 &i2c2 {
 	status = "okay";
 	ina230@45 {
@@ -680,6 +672,7 @@
 	};
 
 	rtc@51 {
+		/* in-chip rtc disabled, use this external rtc instead */
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
 	};
-- 
2.17.1

