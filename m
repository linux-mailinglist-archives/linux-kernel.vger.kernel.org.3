Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7234EA4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiC2Bkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiC2Bkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:40:35 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834DC31912;
        Mon, 28 Mar 2022 18:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEAju2qQ622xSvfGVRxA0vFhTNQ7hI2AZ8P7QJwLadV7VZjyGjoIwWToeTkwF5bAouhw/QEme96M3OkDTD1ESzHfctvGgL+Ws0WF+dU91cBeAxaNI060DXlQri8zNjZcPvPtBzC/+yAadzGcIYvDFo8sskDOIjgm4KHlY2VtKxycGEM37fDKxK4scTkIDUTIDQw52hSkOyFWxwqIgLAjaC/IOp+BRqJPX8xNhMZsrV2KHe9A7oLCIVNKKz/n/5i1JuAhX9aoEXl7eneZH7Muec0XKfpIz6SfBISDUEMmyvw7RoCkltoLUmOSIIOpVl8aV/kaMY2Au0RquN9cuhffcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7Ddj7S9x8JxygqhrqcIDQU2BAj4yaKSH28dWDTS/oA=;
 b=n2tyHJmQmhauO38geSVHLntJoTPcBla86fp/pX5ttfEdJf7DkJPxxaOuHMLU9lEbgERVljeba4h3jVO9Zx8im/EelcpUwLdjKTyjgp6zzOVK5A67jz+4fpi751lcf8qCbpUZvHSPxfPhBTd2erH9xPSy5AxDd/mSWYEF+Lie/X1eP8CHHzgeRay/2bJt8ACfAW7FtB6mD1junM7UgfbjTtuttl2laM/c06BiStD/hK9nXb72bSef2Rmw+iAyTWbl8AGfXg9yQqdBmqEWCnHL5p7XsPs+kvKk4luDIfPnpYWv1u9Givk9/lV802JN9wp7CYQrnqPaiEhTiLGfZudX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7Ddj7S9x8JxygqhrqcIDQU2BAj4yaKSH28dWDTS/oA=;
 b=zFTCiC1NvVNWt6W80fA8rrrTQmpw49IUF+3fRiT0soCDQCHmO0BPeiY3rfnwrZfXSFtwCbss0U7fERwnEZ/OAHaqjLUoN1sFA9RW+lypI7otNx679RaE+CQvWW7GAT/nA3R1uXo4NEA6grNbSOI3YjzNl2TR8QZI+iEA8U4CwOgg6aAYkrtemD50n4hT8idndkePr7xwTq6vYzfIN2uNbZH154Jkp1BdZSyQBuw89DSg1KAaSaOQ6lZ7SfcpRT78ImY6PugTLbALJhF/ByvGQ0v0RMimRDIhLUKSq2DdyohJSQm9CZKOgyvep7UhMJqYMk30hsunDyPLMND32czOhQ==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 SEZPR06MB5414.apcprd06.prod.outlook.com (2603:1096:101:65::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Tue, 29 Mar 2022 01:38:43 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 01:38:43 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 1/2] ARM: dts: aspeed: Add video engine
Thread-Topic: [PATCH v3 1/2] ARM: dts: aspeed: Add video engine
Thread-Index: AdhCR8wCpelUvlZbQvmFeg0WpY4HSQ==
Date:   Tue, 29 Mar 2022 01:38:43 +0000
Message-ID: <SG2PR06MB2315BF301B03A52EE0D8BB56E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66459143-4aa8-45fa-7c5e-08da1124dc35
x-ms-traffictypediagnostic: SEZPR06MB5414:EE_
x-microsoft-antispam-prvs: <SEZPR06MB5414AA89A40AD6D9F87EFE5BE61E9@SEZPR06MB5414.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWH6HZ2sXUbQ7+GYsjC2w5AQvASOi/lZbhfvzznTBNuBZdf/1CYHrKATgE79f9R6DQH+Hj+Q9lkCsKm668h3zMyHu9rr1hQyyUDLSS1DiERHY4BjLTjCbKfnUIE+fNWjZmmAI/ENLgD1T2WUW+8ojo7fhmTUBsUeEODM/iGmtXd6PAGmxCgYtuLO7kc/jGNikZkL82ZvhdJpI5it+7d50OFD5bFczF4Bh0bKFwI8K/RSGbfApcgUiE+40G9Ib5k8YnzHyjhvR67NFgZmIddz8Jyek5X3oyz5oUknt+MIBah6qw+FK869wMIVqJvZzL5iXtP7aZNv4B2CuQZAtSUPCBd81jBh6qCkD05T6CcVlEMKxDUv/Obo1BcdgzDgfVinuAR/br7UnffLkp5EmqNirM62jfZTcUXJmp94ChQrQX8HaBwrOzueoIFY0+1zYDg7cv+7lwP5hPl1SFovjk2owij+a4bfHj/UwHjb9AO77L/Kszbkq8b9GgyHuq21C5LPpHvslVp66LCOevYMCpvGbiXF/Fqwxxf9RgY3PKBa/rg+YtuZurNn8sBx1y+mPE2B0SsjkZftSo2WYcsxAX5mC8K0+u/QQsMXZMDFG1M+2TO0fMPvWU24ZO71gRbVD1nddT//1GAsjXmF3iIEiONOj578p66fy7cruI+XELKSLcjAbD8u4fSB5CjYqs6nHsRPmgYBpj5L62Du+kJN8vW8WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(136003)(376002)(346002)(396003)(366004)(5660300002)(38100700002)(86362001)(316002)(4744005)(8936002)(38070700005)(33656002)(122000001)(52536014)(2906002)(4326008)(508600001)(186003)(107886003)(71200400001)(26005)(9686003)(6506007)(110136005)(7696005)(66946007)(55016003)(76116006)(66476007)(64756008)(66446008)(66556008)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g1krgwcbNF2vCEVHvIwB9PVNaN9fCwro7iLlHSzuRSEz+8sFhlEayY7UJPUr?=
 =?us-ascii?Q?LW8QsAwOpm14/PeLQiO6oWMaFZhmoXpslcSUfduNa/JW/Bp8IE6Xp41bVtAj?=
 =?us-ascii?Q?kWvPMmPCPYs9/yZTZd3382mLWJIg3klDINJb50Xm7tYzYzQJ9LCk4Azyt3gF?=
 =?us-ascii?Q?/uCENlfoCB40c39TwXKiMilBFbzSueGEmWzJE/N+N/7i8osdLkIw/zo4Zjze?=
 =?us-ascii?Q?qEPCrDEe7SCS/0hwUYF2gb/grzDyMWtgFE5L+rG0qjS356daVf6GnU7IIMKG?=
 =?us-ascii?Q?4V8C8+fazM7ScmhR1v3oCIx9tOVyt3FZdm7MKNwOSukAVznmml9dA0v3iD0O?=
 =?us-ascii?Q?/2ktLs8oyXxn4FJb8I1NoUAJwG/KSwNj9hl2cauXqFBQv3a6COgZ4McqfDAU?=
 =?us-ascii?Q?IajPuaGluvi2ZimMw0Fo7sYreQP+O4FAGJR0mRPm4J/evVZ8v6vF+o1FAt4q?=
 =?us-ascii?Q?EjDvvCQtMMqTX4QA+Au4MFMxttILDCSB+VSffFCByHm/cAisYZIwbiOEWE2D?=
 =?us-ascii?Q?45/7dhjLpCxpkSv9zW7kZA+EBrWobmMrzjAeK3osd4lHqlC/SWwhSm07y+Kw?=
 =?us-ascii?Q?242BnLrMIam+WjGAFW5anFIwdn6f1ACOLm6aPNY95Zyv4REpn8d6bejj75Dz?=
 =?us-ascii?Q?cOeDgZ5V4Mg09+CyXZGLj9huqX8AfhICwa6QrM4F9bqoYKz3n53hzVogebp+?=
 =?us-ascii?Q?ZmOm2cnXGSRfPMQ305dq2wQ9YlzynYDgt/YFv2zYyn0Oo74M2H+Qr8uV+9aY?=
 =?us-ascii?Q?dNrtT8vD14V4H6Qlejio8JvnEfYEL9CY/yshJtXJ7z/foi41cLpCUBxJI3Qz?=
 =?us-ascii?Q?fzb7ne05CrCOdEeIxQoMycSpJ0GIxedW03RBqcl1rXWB2d50nWWLaIsGohp2?=
 =?us-ascii?Q?74kWm6elR3Mbtymor4FquHkz4cTEuMj+34gvsE2N652sYgZ9DAfRVbWUewmN?=
 =?us-ascii?Q?aMsndYNNoQLm2ZzhCNxPFiT2+4EaRiEmcKejvUk7zNIZ1XjR8PIPostHX28P?=
 =?us-ascii?Q?1DkwRpTpr509YpkHWKIPfelqznl8BdugvFa8mWdeFXYJsAjS5q2jPfAO4Bix?=
 =?us-ascii?Q?CFvjwmbnDJJFr3H3UqcJuxQuXoPmKxLGnXR4JJbLAseqVRZy7TNEdjWvfeXe?=
 =?us-ascii?Q?RlB/4YnckIidHr7/pgThgHHlDF9ojOTpgoJM9NSHqydbH1P0Q6iVvhKCGpqb?=
 =?us-ascii?Q?j55xhTSqE6O5dsFZ3P5b94I8BPWNJz/xWoW0bMB2TXxxPjEc1Xn59Z9kSuRY?=
 =?us-ascii?Q?/s4lKS07dprfs1kXMheUCK53owBGuSGyhNEEC1hN+5wEBNxd0jwGQATt4vQY?=
 =?us-ascii?Q?E3GJZnF6jkBgnoJM3vKZ044wtPh5O9ROeeZucBL/E2B3miI8VaOx8QUtLdd4?=
 =?us-ascii?Q?xmg4nnR06iEGR2fEG/oWc92Xq7hwCR+Jmxg4RL2F/ZZaM9BuF3gYv6e5afBh?=
 =?us-ascii?Q?RyGIqcLg6s4SlFRZpsmRhypte3o5+abPil8EUS10N27gm03CHZFb/BFvuR1A?=
 =?us-ascii?Q?6xn09uy8FCHQ3yjpSrWdjLnNd/w+roJEH1EcaKPAeVovse4TZlnX9vS9LWS7?=
 =?us-ascii?Q?OWxCdH13f5kQZowOPBdf+6SX8NnUfxfwHF59Mus/QbxueC2y9pC1VZ3vgYW3?=
 =?us-ascii?Q?lGyChI8M5CwfqQaFn0YX1Q7FrERHZ1zJCL6YC9KSFiB9sJuZsnbqYf/KDQQP?=
 =?us-ascii?Q?bumbuBlVyzIIzCRqbqIish7wn+IJFwKMaqYjMQ/ZstTv55Y3yzsmqVnHq/i4?=
 =?us-ascii?Q?vtZ+hGLtUJAud8VqfC0d8HmS246bOd0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66459143-4aa8-45fa-7c5e-08da1124dc35
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 01:38:43.5927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxsSkE30bMMj8ztYGPuNP0/JMBK89lBkaJKwWFAjqK+ni2xsvDuMtt/jbmWr3XH3sVMGb3dxhLzMKzPkNnGtoVeXPbljVm2WUTBbeLj9uDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ast2600 SoC has an embedded video engine
This node was removed by commit 645afe7

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

