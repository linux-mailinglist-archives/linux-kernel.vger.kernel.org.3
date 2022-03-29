Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1BC4EA5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiC2DZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiC2DZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:25:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10B9DCE0F;
        Mon, 28 Mar 2022 20:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv7hoSUsMVFfdkpq0leQaOmpFPE63UUNJYx882JiFgdAU+PBYCt9PVpD/3pXeG1mrNujBDfIxTSRP8HQfmLiH66bJ9+BdT+xKsJegz/Vz1t1utgqqS7owGpHG9tdiJYZgX/JJdo523eR+KhNQJigYjpDD7jysr4DdoEQEj2oI3ZmXQ6czAtVH4XmYpPKdgRKC3UUhP+KVvQ/YMsL0Xxjsr1+rT6iQcGAo9jGEceZvM6BMIGMGHEyYDjYJE8ixXLhyeiQa5C7yyTeKtqdIPFyBj4R5c3d3MqHWzXu+IeAgmzn71h9+dOiIH65SDy1ywyzwKRm5HH4kprM/s4W2Z/xrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qco/Kz0xwflvbrQWSCeV3o70V6dzqUpKFMdevt5cxxM=;
 b=a64bMwZqed6/dphJ+JQDPCfwTyeok7pSHOj7xJ6m1wEvv8HeuA/vnPoUtS1CNBMz01yglBHxmwoSGFv6Ud1laGLfDqDtBxHqvL7HQ58KDaO4oCm+z7uU8yl6E0fvoaBOf952osRvtEK7urmQVLUoIgWHpvyR6NB+rz4yzYR9rJtoKWyzCY8rNFoOk++6Sv+tLErOFGwPj47MbWmLFNXSNOrYkFuWNrGF4u1B9HANoscz3tWvfivDnORuXo1Rl8hzsriX/9+brJL1czLvH7GCT94b/dmMBp1bY1gmGz84t5L+4cVVE5b+ZQhfPrro1KE4eWy3aFuXQbHTjiI7orLO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qco/Kz0xwflvbrQWSCeV3o70V6dzqUpKFMdevt5cxxM=;
 b=u8PVkaXxSmxiRzQXIWOUwkDuqydl0V/+EbZNeX+80Wykn5roFLt7guF4c6MSqDz0zTG1S+joJHmEH1DvGGW9QeIhyBuNTlAd+IB2QAJ118NB2KMSFx4tDW0/u0fq6eByj4T8FZ2M2p/YV1CECpktgPXE9NMNTfwX0oYurp0/8ZNPUrc2MuJvOme4Zbtlgu2ZKtTJq2ovOszpMx9g4fMsjCYbvcfMj1gIgNnJr/nzTCrDa6744+w8NAe2AcFZnZaOYLSV5aS/3G9Otbo34S/sVNxW9FC/gik6daRc4gpsFWtWC1xtGIDy6A8r/CXlevHGIYI3iSWrsigYJB8UHNTlTQ==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 SL2PR06MB3130.apcprd06.prod.outlook.com (2603:1096:100:36::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Tue, 29 Mar 2022 03:23:51 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 03:23:51 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 1/3] ARM: dts: aspeed: Add video engine
Thread-Topic: [PATCH v4 1/3] ARM: dts: aspeed: Add video engine
Thread-Index: AdhDG/Grc1l2R5iXQdele4d5D4J8Gg==
Date:   Tue, 29 Mar 2022 03:23:51 +0000
Message-ID: <SG2PR06MB2315C57600A0132FEF40F21EE61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e397993f-a9c1-432d-d594-08da11338be0
x-ms-traffictypediagnostic: SL2PR06MB3130:EE_
x-microsoft-antispam-prvs: <SL2PR06MB313017223C5EE97AED2B5F1FE61E9@SL2PR06MB3130.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hXH4lfofJqNMM7F8q2kN7x7g5UBoXXm9p61P164pbYTL4Jwse3eGy5CfiAtuXQ/lqj6nsXUvAYQwgJCzcqRxKuezrNYP9z630A4QH2f3OuzxuSF7RP6BwX/hZgAJohy0j+a4s7LflIlLevCbzZwyiwt1V6zZ/TKu6mCZh/yTj4vmDtSxH0J7Lx9chGKQUHShuvAewOWBdyhczAcdAMvU61/YxZsW7HPPVx5tpQHostKa+Pe181BDM/fusk0fH+kToKb5LKThV7kUQyFWVnV5GRjmP1QGW/zs/rXJVuLe9VD3xwY1OUfzPVV9T5C/TcZN6PtPDZPxJRveRGhYqM+RRkWVz63gI3FGQLCfcFk5LrZR7XnZ7cNurI75APV9x2Q8AkGSiGos2Vrz3BJDhJeZytsOwQIlRrOX9WpwC/7Tymfo0Dv6DquVIvhr7txTbWN2mUvNYkIMrNd2zhP+6Z6f/KlcwY0e/7nbYcvz5HNs43N7uMjzsKbTZ5QtPFkGXrW6UBmuwK8h3Lj+ex5JuKElaNcL2GomVI3af3ERoX57ppmmkjXXB1X4/cHmDDugvvSyTI9nzyKM59mHle8CCbBasWnqqN61IEPtLltEzqiUNiyzv3puS+8Tm81AmYXFmjPctFDrSZtVIcHNlAQdECfxFT1sYG/p4QSueJf1GwjQcplRuQtbb0wjcvRz7GRx7sYdAoNKnxrA7tBLmKBm3sgY+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(366004)(346002)(376002)(39850400004)(2906002)(316002)(52536014)(38070700005)(83380400001)(186003)(38100700002)(110136005)(4744005)(26005)(9686003)(5660300002)(8936002)(86362001)(33656002)(66446008)(66946007)(8676002)(107886003)(4326008)(66476007)(6506007)(7696005)(55016003)(508600001)(76116006)(64756008)(122000001)(71200400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OArYeCMdyX0o3RyObkOC4j/5FAZPoAMDcJabs+Fnmm/I+iAG2STh6BFDDZdJ?=
 =?us-ascii?Q?QVoIPtdUwm5/RgKgnc18MTfbuBwChjvnTDrzRRmRCX3ZQub/ELsV1KXUkfDH?=
 =?us-ascii?Q?9n8w2mFcEbNcCNlaMjo2Pg5FyJEITv+seOm0wLAjKPZ03MMNYL9M9PvYTI1P?=
 =?us-ascii?Q?EzeF0a2A9eAOEbxmnY0quOGtXL7RpzPuk0LHbQni1SdDl3MdDRrKrv0Pu1so?=
 =?us-ascii?Q?XArKF6mPWZs5wDSz72FKxCco3GNUqx2BIDTToKVbk9o2PbvWtrtD+B3Z5A+5?=
 =?us-ascii?Q?OYRS8ySgGbfwB0+y9A7nhYuuMWSmXuXAbMclxh+//+ZKTfuY58I8WV69zNh1?=
 =?us-ascii?Q?1BO2H4TtjMuviDtv3BtLPRamli7hr1d/M0XhTgJnL1Ceb9rOXQJ9hnz5RKQa?=
 =?us-ascii?Q?VFi8mQOimvIX54NkLCB1ThY6nZ62p3JQ3q+AaPf9DjCuoUJROQW9H+XmGAUq?=
 =?us-ascii?Q?nF5VkBu3bccZ5SbI/YZa1Qj7SirTI4WdtmE3lTOO4lgLx774Etl3bE+k4vBH?=
 =?us-ascii?Q?Po3ZQGeo4FW08/bJkjeuLVqPaWlnGH9rkQId/QqmgltpkVotW3RjPQrdqzt/?=
 =?us-ascii?Q?upQiF1s1+Ks80ZNLszfTb9RjS9nyKzg0TcJ9RheW8Vc1oOrNt79yc3gkN9tz?=
 =?us-ascii?Q?Y/D40v27LwxOMfNadBvHhHpwYo+IEj3sFg5SVt/lI6fBqYzg4jZ+dpoScrBH?=
 =?us-ascii?Q?UF41pnFKUWWdQYNeGdaIVoWAXqDZqR27vaSDiOJ+oc9U7iLjEzT3oKYajSEG?=
 =?us-ascii?Q?xG/7GobFiFBhNUctDwghPsAuQW1v/92sqdYnTa4UfYA0chklOxlYPIfOE7IZ?=
 =?us-ascii?Q?Xcicu/cjvGW5z6fJs7lDIpfBmaPF961sAN/narqvSoDJuWV0zdFeP6O3Wd+X?=
 =?us-ascii?Q?JQTcWkazS8a/7ccB+aIi3yDJQHg+p9MtGYamXgt/nUQA6w9zFsYCBF+Sirmm?=
 =?us-ascii?Q?4ROWHYXf8rccS8bDavTTsi71BjovgH1rbstC8xFaqPSDa7zmM8ZdLqv1+cho?=
 =?us-ascii?Q?BZMln94zABFWCiDwmKuhP3dkK5Cyo3ULJWwWOIKk/wkUg+alJb1RO0XTwDo4?=
 =?us-ascii?Q?U7qbEGSsiu5V6IVYUKQIL+y7sBdWlziLP0SgYA8gLMcDCRvnlIUQjdKYYXhe?=
 =?us-ascii?Q?fQSeVUhvljugFx4pDyk9hdvEL75eoKZTWfQovxjFirmuDm24orEvGz+MHifF?=
 =?us-ascii?Q?ZM19/w1SsXmcYm2DCEzy4M7/UsyIxxWBPsOnMbgJQbsQHFutWu61hmrhH6Uh?=
 =?us-ascii?Q?ejsRqKqTi0sZYccXpzqaQiyC9dp4rvTluZ2ufkEzZGS8yNtHb/L7evxqM04n?=
 =?us-ascii?Q?dbqTfZdO/7zsqX+2RHADHeukk+gPDbBGPfMlYdeJ42WDMezlaw4aOtc58Kuf?=
 =?us-ascii?Q?goNU7PpFDQwv9Rby3X9QULj+GCtMEbnMUOkTBIeyjaWUb04pZG3ASBTIlZkZ?=
 =?us-ascii?Q?jMVLinxQxU26osuiQws0d3mC9VmOeiJjM0s9xnHVCztdvvZvvWJSuIcPXguR?=
 =?us-ascii?Q?4rN0XZ2EwwEB6N7JD0XCN7OTaha1TJRzYGyRkbpV2CRPlsORdUqQYLQBqROB?=
 =?us-ascii?Q?6uE6KRCsrr7kbMF82nN4jCJoACsUEK3GgezowfJrI6tK8zTzcwRfmkASq4HD?=
 =?us-ascii?Q?4XazD/shFsQSujQOi5ZbXjPnLGFX3Pr726FQxybF1nUDDC6wEkldIs1wxFkP?=
 =?us-ascii?Q?8bVJ88XTUoCKM60Xom2hBikKlCdrN6aSAwCnfEDtVW9x8F1dfo7vwj+j6Nh6?=
 =?us-ascii?Q?TDQdgN1boyyufIxvW1vTFdG/t3zuObg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e397993f-a9c1-432d-d594-08da11338be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 03:23:51.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hV3PrsJVaAsZXhRM6eHhBvWKS2X1sN16C90RY1UouWaODQwlg+GWWXveHLErQ2DG9kuvvlbTCtofEyrfbjzXgL/SclqlnQCMz+MfcV+TE1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ast2600 SoC has an embedded video engine
This node was removed by commit 645afe73f951 ("ARM: dts: aspeed: ast2600: U=
pdate XDMA engine node")

Fixes: 645afe73f951 ("ARM: dts: aspeed: ast2600: Update XDMA engine node")

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6=
.dtsi
index c32e87fad4dc..aac55b3aeded 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -389,6 +389,16 @@ sbc: secure-boot-controller@1e6f2000 {
 				reg =3D <0x1e6f2000 0x1000>;
 			};
=20
+			video: video@1e700000 {
+				compatible =3D "aspeed,ast2600-video-engine";
+				reg =3D <0x1e700000 0x1000>;
+				clocks =3D <&syscon ASPEED_CLK_GATE_VCLK>,
+					 <&syscon ASPEED_CLK_GATE_ECLK>;
+				clock-names =3D "vclk", "eclk";
+				interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				status =3D "disabled";
+			};
+
 			gpio0: gpio@1e780000 {
 				#gpio-cells =3D <2>;
 				gpio-controller;
--=20
2.25.1

