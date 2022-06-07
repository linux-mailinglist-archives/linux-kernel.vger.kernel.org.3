Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA81753F402
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiFGCmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbiFGCmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:42:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B19EB5;
        Mon,  6 Jun 2022 19:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0g2e/SadNV5sGk/R2laYxhBmvFfWhlnKPxxsds6QadlreRQlETezR7++t1SJwhMbnuburlOD9LWIAh9W0eXhoEfY5icRnB29w8GvfAuTgiPYf2vj2AiwehxlXqW0GlNAMyr122+qNRJoOb1+a23I7lswqznAkL4Uj4/9pQ2ewsVv0MvBQ/2Lz1hCmzZDCC1g+fKaqUk1AExrYQuF2RpaxDcDUBDYP6acneaWOFKjtLHOWJRQ29LmDkIVVuzkUuik5V/ryGloalyPj0blr23RyCjHlqC4WZBA6W5D5q2k4xFPOZn2QibVX8Jb4GDdafjMeBwYty+4KxCXRQ+sqKj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZCTM5GcsZOVdulG3Fraj3vJFa1gMuoleSKGXq47SNE=;
 b=YR76WA7jg/c4TUT63z4fmOJLaPm06U7AkmoVTw1YMDFWc0Hf6s6SvNV06q4QthV3+rHOArzqvH3kMkQEqTQjqmFJMs9MOG34yRiGSdCh4n4JZ1Gvo/k5GrVVJgEC6u+I2RR/bwO+jolePJp/g3CcKW/UtHMqvV4QiRnpOhVZloML8kBEqNNNR5LnjZVYUhuwkxREyQJb1xWRzsrmsS2o3Za6S4TfclHr2uZIbPJWCrFPcA0Vxy5K1NFmPxyIZ17qzwjQglo/FT6++nLChs1Wu80oRuaeTcgJMMVzTSCe25bTA/0Lds5WA5wbsldNfuM5DgFwKOEcu+2POHURjlRusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZCTM5GcsZOVdulG3Fraj3vJFa1gMuoleSKGXq47SNE=;
 b=SGbxtFAngSrohyP529H3YOVVKxvq0xuhFFNaoECG9+NDKAjYpdx1+egnALe3YjyFg8R9a3bw1hTPC4E/Zhv17EHZzQgJK1Zq/vMNZFlJ+BhaKzJYjB6XBtsF9/DHQdoF4nXzCA1ZIsTMmMoykn2ZkgW4L3NTvBtFrMDfiepAoyR2kDh3IlPT/JN9ZsHhL075skAbG8S/No5hwzkurY4XzhzMky+OIJau4ca1cCUH0Z7xmbw8nekC3AY1ynDGOj8k1v09ISSpQzo00jvMcOdzrWuscxrRIQDyjGTb1UYvqQ62Ut4dQ187GwnKWwqr98boltUmSar8ilIMMsqt6FAOZw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY2PR06MB3054.apcprd06.prod.outlook.com (2603:1096:404:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Tue, 7 Jun
 2022 02:42:09 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 02:42:09 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYdXpgV+xzTk0fKkKH13lAbtmvOa06KxMAgAAMVKCAB9rRgIABMqTQ
Date:   Tue, 7 Jun 2022 02:42:08 +0000
Message-ID: <HK0PR06MB3202C108F41724E49E2C5C7280A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-2-neal_liu@aspeedtech.com> <YpcYLiJfC6tgP2Nj@Red>
 <HK0PR06MB320263939B2E388481DE2A0A80DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Yp25UVBCNHzeiQOn@Red>
In-Reply-To: <Yp25UVBCNHzeiQOn@Red>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a2a0358-0892-4a1a-7af6-08da482f5122
x-ms-traffictypediagnostic: TY2PR06MB3054:EE_
x-microsoft-antispam-prvs: <TY2PR06MB305472AE08ECC48A993651AF80A59@TY2PR06MB3054.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vAIX7A9n0l5aPAJJfcVMrbyS4eY1HUiT5SffyWs3zLYny2wJzq6L96if+JEyLSChDyeLw8NcqHt149a+oTROB1YjlfsxxzGTGl4wYRwEo1xvpJgAN0DAxbZV0M59J5SRJDLShoDinNGBKOW9g8mZ9jwz6lg/c/NzZKfHlLnoNska8XOysCJFTKyvDHUibnQMBwF2tP9oDsaEn5xMlfeYt6xfOezat7wI0ZlIDjDa6hfdFJhhxbxlE8tjP69Py8Wr6aQReJc4OPv0xXUly1xHQP69xLTr41rUwnGb8YSBvPWy8Y6ROZsWcpwwrMDvPUt33tHrYGQ7Ctc2QNnstlqX/AsE4B4wBFbj7a+quUskZpEUE5WNtCYZrR4enEDDcU6m/OfmKJOrPimN+bNNMS6hw+rwXTDKArnw42dJ2qVr3wjdNAZI/OcYlQ/iO0sbiMsO+838Uu6hPkdFBeF0MCm6G7DD0V7R7vyW0s3E9S5hUxvNNfjdw8qjx2d1TJ34KGnKuDgy1kZvQJxCPD6LLVLOgn61OzNPmT/feADnVvvihAHO9Qej47ZKLRtCTaQ8GgxnNGDofxf7YH0V/D0+kn5B1s8nIFM5H+767vF083QUW20H6C6IJZfoDk8O6h0Bcr7VI4TE7N3SgYtyVxPBTGw6UaNxbawxCm4K2YyxngKlzDJlyW/+bla0PoR28lwr/90OQHRPKJeIJ5b4h8/Q2rdOiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66476007)(64756008)(8936002)(76116006)(2906002)(66556008)(38070700005)(52536014)(33656002)(66946007)(55016003)(71200400001)(66446008)(8676002)(122000001)(7416002)(508600001)(5660300002)(316002)(186003)(66574015)(6916009)(54906003)(9686003)(7696005)(6506007)(83380400001)(26005)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2FDfgiMQDZchzYBtKJ2S9RqkjmghObvYgpyZTy4dC5jem8DyDrF2m37FaD?=
 =?iso-8859-1?Q?GJNVamy9YPNzeXbi+70/uqAHeIJ4Mbj+VzwGj+s4uHJKztTxvbM82P7+/g?=
 =?iso-8859-1?Q?CO56J0+a4rKQ9Co63hC5jWdGKNjmzLCC6KBlZ4z0/ZchE3QJPggypSO2ah?=
 =?iso-8859-1?Q?u5YA13aG8fVraIVfE7uB14OpkOfRCY43VbTtd474crSxPlRXqyvNyGcpoC?=
 =?iso-8859-1?Q?aF71OPrlEfRiVUeGshAEtau7y8kBfWVFQdyePZHcT8aKJgI6hf5qxngYds?=
 =?iso-8859-1?Q?rSK2xWpJGMRnnfp14gPtkHb/G/Bmo+GMG4wRroaG1CyuYTfXqkJPs8bMbP?=
 =?iso-8859-1?Q?qmeIdK4AnZ7BsRGMAOZCcN9UTMYFp2d4rE8kyKHwnh2F2ZgQW9e0Ye4Ifo?=
 =?iso-8859-1?Q?P/ztIis9UrSp73KOrYV/6fjHhLgkrUFYE5Nxp7Gryexytq4xPrDBlIIoQF?=
 =?iso-8859-1?Q?J3P8/zb3exPcvxgBLENljDorU1Ruo0ieKp+6k9VPhB+JEvAP7yU0Ct9g45?=
 =?iso-8859-1?Q?8Uavil+AHGeTJ38SyF2NAEv/jjU5Q/qoc5WkmbCsg82/UmkngRVTetbFXh?=
 =?iso-8859-1?Q?N3X92sdINFZKW3y7BYlu2Scpei+d6kA3QKx4/1AFRiKpvGDb3ZzAOiVjX1?=
 =?iso-8859-1?Q?7lPuTIUslJVNhiKJbagdqINcUINCs2Lfxe9mG9XiKSpkFT5R3brqE+yWM7?=
 =?iso-8859-1?Q?wmTO3Q4tZ0TjFDlAHyRkk0z877MP/JCGBcECkuNsAEjh+bVsTGZbjRIQWl?=
 =?iso-8859-1?Q?YxTpapl0IWapB7FSl1i5TVZXi5PN8KCbXpDUBx39bu6sY3LailtSsXty5q?=
 =?iso-8859-1?Q?K06x4X4bgIktqkY2JsaTK5IQXeYZQkOJ8SmtuyP4MKmffbr3UucEQK0+Ya?=
 =?iso-8859-1?Q?ww+10Eo5LwYUnmKihuz+1/ADMGo9/8ANDH8YjDzHmDjhi1q5ovsig5cNvF?=
 =?iso-8859-1?Q?DAgIVGemlbXQ6z1tCJFizDaN52jDOsLX3WBYKBDbo8rk9+5G7CJ16YvFM9?=
 =?iso-8859-1?Q?jLrXwKt2RW6jgl4Ywd99lv3dbUOfvV8X0mrtJbE8D2EqdL63wM9lS4zWOf?=
 =?iso-8859-1?Q?AfZaHrFcHVHn96DGPUvIyjMq7X3+4DVMwuf9t72d6+PmONQMST5MGxVCeo?=
 =?iso-8859-1?Q?RlVuddXKThMWzBSiA8LjWDCwFTBnG7H1YVdDcjbevGYtKWODwfeCWEJ0xI?=
 =?iso-8859-1?Q?b6qFHNFlmHpCYKRsq/lY9VYH8lqdE6IzUg2Ljy6Nro2bab3lRt9PfO8e0u?=
 =?iso-8859-1?Q?N8rBewcQw2sOZW+0w5jPt+Fa6C5XJmFrsNkQcUB1PkCboYYrpdPzGXoqN/?=
 =?iso-8859-1?Q?EMr4O2XG4HvRQdnSV4k0k+QD3lZIe+fAOjyWv8mDVioWwhjMcmoqcqzB/n?=
 =?iso-8859-1?Q?OrrxHiTjemRUGUnfbjaSpaq70SIJmXZ4Ig/5i1ImF5xj9J9QM6ykddXws6?=
 =?iso-8859-1?Q?5qnJ6FXUQPAJEFZ0ch8C43l5fW9DDr9rFZ/60rW3sL6cjCovS5vQNXzhjb?=
 =?iso-8859-1?Q?wVIpi7he9+/u3pq8Vj6V6+GM7LkXRPdpr3dmikr72mf0+j9lpWIkLLTDae?=
 =?iso-8859-1?Q?0xLXp2Zh9ZTGYHJFGjGd/B3eMcrrgA4LMQLhusNXSuWzy7jvPzicoM3rAc?=
 =?iso-8859-1?Q?0dBgSOWO441M9O/6780d/LMON7d6B7f5QOJwr3CUH/OkpsJO3FWyiB18ki?=
 =?iso-8859-1?Q?q+KFor4PKlpf2zpgnsC56zdSqlrSItLe5UULihY3pjWHuK01hY23Be2xba?=
 =?iso-8859-1?Q?umll4af0Qd67ZEzJoZmSkEAp2ayykCZGyvd4sEtTCVBeYEHXbaJ0vwNUYt?=
 =?iso-8859-1?Q?VvMBmdK+iQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2a0358-0892-4a1a-7af6-08da482f5122
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 02:42:08.7754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6PV1h7tIjAhCE7zKyf1796sm6SLKN0iMnuCVWVKP21McuEnMaS6Eq2Rs2kOpwVg91IitRBxbdenqt/QnlcCMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Le Wed, Jun 01, 2022 at 08:38:51AM +0000, Neal Liu a =E9crit :
> > > Le Wed, Jun 01, 2022 at 01:42:00PM +0800, Neal Liu a =E9crit :
> > > > Hash and Crypto Engine (HACE) is designed to accelerate the
> > > > throughput of hash data digest, encryption, and decryption.
> > > >
> > > > Basically, HACE can be divided into two independently engines
> > > > - Hash Engine and Crypto Engine. This patch aims to add HACE hash
> > > > engine driver for hash accelerator.
> > > >
> > > > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > > > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> > >
> > > Hello
> > >
> > > Did you test with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy (you should
> > > said it in cover letter).
> > > There are several easy style fixes to do (please run checkpatch
> > > --strict) Did you test your driver with both little and big endian mo=
de ?
> > >
> >
> > Yes, I also test it with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy. I'll
> describe it in cover letter as you suggested.
> > And the style problem would be fixed, thanks for your suggestion.
> >
> > How to test it with both little and big endian mode? It would be apprec=
iated
> if you give me some clue.
> >
>=20
> Hello
>=20
> Sorry for the delayed answer.
>=20
> You should try compiling and booting with CONFIG_CPU_BIG_ENDIAN=3Dy
>=20

Thanks for the info. I'll try it.

> > > Also please see my comment below.
> > >
> > > [...]
> > > > +/* Initialization Vectors for SHA-family */ static const u32
> > > > +sha1_iv[8] =3D {
> > > > +	0x01234567UL, 0x89abcdefUL, 0xfedcba98UL, 0x76543210UL,
> > > > +	0xf0e1d2c3UL, 0, 0, 0
> > > > +};
> > > > +
> > > > +static const u32 sha224_iv[8] =3D {
> > > > +	0xd89e05c1UL, 0x07d57c36UL, 0x17dd7030UL, 0x39590ef7UL,
> > > > +	0x310bc0ffUL, 0x11155868UL, 0xa78ff964UL, 0xa44ffabeUL };
> > > > +
> > > > +static const u32 sha256_iv[8] =3D {
> > > > +	0x67e6096aUL, 0x85ae67bbUL, 0x72f36e3cUL, 0x3af54fa5UL,
> > > > +	0x7f520e51UL, 0x8c68059bUL, 0xabd9831fUL, 0x19cde05bUL };
> > > > +
> > > > +static const u32 sha384_iv[16] =3D {
> > > > +	0x5d9dbbcbUL, 0xd89e05c1UL, 0x2a299a62UL, 0x07d57c36UL,
> > > > +	0x5a015991UL, 0x17dd7030UL, 0xd8ec2f15UL, 0x39590ef7UL,
> > > > +	0x67263367UL, 0x310bc0ffUL, 0x874ab48eUL, 0x11155868UL,
> > > > +	0x0d2e0cdbUL, 0xa78ff964UL, 0x1d48b547UL, 0xa44ffabeUL };
> > > > +
> > > > +static const u32 sha512_iv[16] =3D {
> > > > +	0x67e6096aUL, 0x08c9bcf3UL, 0x85ae67bbUL, 0x3ba7ca84UL,
> > > > +	0x72f36e3cUL, 0x2bf894feUL, 0x3af54fa5UL, 0xf1361d5fUL,
> > > > +	0x7f520e51UL, 0xd182e6adUL, 0x8c68059bUL, 0x1f6c3e2bUL,
> > > > +	0xabd9831fUL, 0x6bbd41fbUL, 0x19cde05bUL, 0x79217e13UL };
> > > > +
> > > > +static const u32 sha512_224_iv[16] =3D {
> > > > +	0xC8373D8CUL, 0xA24D5419UL, 0x6699E173UL, 0xD6D4DC89UL,
> > > > +	0xAEB7FA1DUL, 0x829CFF32UL, 0x14D59D67UL, 0xCF9F2F58UL,
> > > > +	0x692B6D0FUL, 0xA84DD47BUL, 0x736FE377UL, 0x4289C404UL,
> > > > +	0xA8859D3FUL, 0xC8361D6AUL, 0xADE61211UL, 0xA192D691UL };
> > > > +
> > > > +static const u32 sha512_256_iv[16] =3D {
> > > > +	0x94213122UL, 0x2CF72BFCUL, 0xA35F559FUL, 0xC2644CC8UL,
> > > > +	0x6BB89323UL, 0x51B1536FUL, 0x19773896UL, 0xBDEA4059UL,
> > > > +	0xE23E2896UL, 0xE3FF8EA8UL, 0x251E5EBEUL, 0x92398653UL,
> > > > +	0xFC99012BUL, 0xAAB8852CUL, 0xDC2DB70EUL, 0xA22CC581UL };
> > >
> > > Thoses IV already exists as define in linux headers (SHA1_H0 for
> > > example) But I am puzzled on why you invert them.
> > >
> >
> > This is Aspeed hardware limitation.
>=20
> The limitation is that hardware does not know theses IV ?
> Having them inverted seems to proof that you have some endianness issue.

Sorry, no limitation here. I can replace these IV into predefined macro.
I'll also check the endianness issue.

>=20
> > >
> > > Why didnt you use the crypto_engine API instead of rewriting it.
> >
> > Any common crypto_engine API can be used? I did not find any, Maybe I m=
iss
> something.
> > It would be appreciated if you give me some clue.
> >
>=20
> Please check crypto/crypto_engine.c.
> You could take crypto/omap and allwinner/sun8i-ce as example of usage.
>=20
> Regards

Okay, thanks for the info.

