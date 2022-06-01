Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED79539FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350902AbiFAIjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350881AbiFAIjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:39:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5314A3E4;
        Wed,  1 Jun 2022 01:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZUjfn7LEo2JPnDXnimbVc24LwsGxn26h9cRE1jKIr5INdTHkxLA+2EDnncSlKcNtk6mIyxydFRTJlsvcf0RFuGrezWZU28EkPCaT3cFMOdTR803LpClJq3XRjhwjuftGbIKYRfnEOyO5wG/8kSHZ6zC4WE8UJgqE7AGDquP3U2r+MA82bXd/877PBduWv8zva5isl3QmBdMSJCdy30yzQrILg9c6a/P0wcxJep89ufDruaEL05sf0yCNlR9Z7v5yp/5SAmsZzi9IIcfTFP90xXyE9ukmdMHgvz7IdlcGDyy9skynHLQTp4aWNS8kvAUHpvW5M1eLiKd37mSGP4lxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx0rECBceaPY/rSXTBn7Zd22X8zybUB+Meoob4xdLDM=;
 b=UXifTROntA7kMKmuv+YsdQKnq7WRgf+ZZiqdG8CMRDQYeQprZkKVkwOC1bg9Vws9B7Cmf+RmrcQyZiZq2pnUcMSbaR9KKBylaib59QAF2VUlE6nlfEyo8qofHiqHdKXNCp8FIPeEis0qZlL8iznFYRIAetz4gDduppSU0FbVy7QbqtFC613+aczSnlpE6xIYqvLEvtH3klpRE1lu6Te2Z0+NKZKOHT0yZT7DuJacvbp5/WX2STOUgLViT4HBzrMrk8jqA5xaR140jEtdcG3QU0KX6Z6JfRZcKVY82+kaamQ10CaXFBuDxl1IZuw+UlX+JHfTv/8AlFYl4mjbJHhMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx0rECBceaPY/rSXTBn7Zd22X8zybUB+Meoob4xdLDM=;
 b=iYGH5rDIHU5ORmOVwunSZzKuSZtkmyFtLWqd9Y/T2HMGNaAl0xIoghMI606RsR7UWOkplE4RjQDxCfgr4jDQj66WR29y0zh+UJV2SWgv3QV4R+nvRTZpPh+ifvcjhpLcqXzXtHkNxkqkZhZ+qKzPyAIW+Kh50B9SS3dCmfPVFqsAJrvY7EnAmAK1DgXIikl2W5Wi020OlP6GfavFSbACiBP/YOdBYHSLvdBR/UabGZRqL8MPOxJcyQzV3ALuqdll7BHv9YmfVOxV8xWPzm81IQgqsX64eayJWjzg3NDF4mUhwYrN5CoYVp2GPIYsXHBq9Oy0/VNUgKUOH9w9doPEaA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY2PR06MB2446.apcprd06.prod.outlook.com (2603:1096:404:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 08:38:51 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 08:38:51 +0000
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
Thread-Index: AQHYdXpgV+xzTk0fKkKH13lAbtmvOa06KxMAgAAMVKA=
Date:   Wed, 1 Jun 2022 08:38:51 +0000
Message-ID: <HK0PR06MB320263939B2E388481DE2A0A80DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-2-neal_liu@aspeedtech.com> <YpcYLiJfC6tgP2Nj@Red>
In-Reply-To: <YpcYLiJfC6tgP2Nj@Red>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f6ab55b-97d2-416f-54d8-08da43aa2777
x-ms-traffictypediagnostic: TY2PR06MB2446:EE_
x-microsoft-antispam-prvs: <TY2PR06MB244623C5FC5191B07A32DF2680DF9@TY2PR06MB2446.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TFebl6toBv1EIMz1dxYtoRtWprzv8a897HwJwIqDJaKFIkLC2zH9ZyrqDaKgDasf9uwWSWlywfIGdaN3dMKjct9gPJtfEvLAJkUW+pGgSEoh0RlbhLNXOee/MbbT1iZVQ8GTo9L60J6eL76GmGlVWNJo9am9VUeFwDVLOZZ3hUOan5sACyyndmXxPOpl3CgpGTOtOH+Gp3b67QGoWkOXlopsxwAfvdDaFnJJwcQ0wOcTAn5LNUydSv+lYJWaQ5NeU/lT77f6p/pTmTQALatMU8eA/Hyl2pAPvWOuvY+B20PC1W6rIeHjlegYjQKn9fwiwkpXznq8D+tVX5SdXQ7gJ4gfTNXOZSs4vkUMcfCPxc4P5y8b3tT1bcB2kWLBae0mVos2q1wgR9lbLZeMLYtYbjitC9H2pXUArhgjWkr5/+iFS1pEyc8Rkph1lSjxn6D2JbHa1vx9DoZX1TIPShwpb+FQGWngH4DupTx/mLfMNZehdKNHGj8v5RWPDkx/Bdy+at+hdEpw5FnfSwcai9LgVkpGSs0QIaVWOmrh3A0eKeDaERvmfdO7lANy3l4vhV4acGSpYCTK6Njbirg4a58pk4QDv83DwDpRZqnkQPJJEFV8xpI8ryF38Hzk2alu21gBU0FhB37WFiMK11yqs3LOBk/e0jJXrHshsIZAjekq/9cdAyJTxtK2drBMsWqQJoy3tS1EgTSAFoR4tAotFmruLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(8676002)(508600001)(55016003)(7416002)(86362001)(66574015)(8936002)(5660300002)(4326008)(71200400001)(316002)(52536014)(66946007)(66446008)(64756008)(66476007)(30864003)(66556008)(6916009)(54906003)(26005)(38100700002)(9686003)(2906002)(6506007)(7696005)(186003)(122000001)(38070700005)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X4NXKKTt3ciaQqDYzeCFGRwOYDm9Bv0vnaoDIuM+FXyf2VrR+sS2bnmw43?=
 =?iso-8859-1?Q?GRX5GECvr6pFJirR+crswh5P1Qy/AX9IboRDG6wpd1m8eDcYkTA+5wQaJ3?=
 =?iso-8859-1?Q?cPOeQni4NlGr/SBq6Wd/IUsASlN28I4oTfJZsir6pe/ArrdCE4+oZjZMoJ?=
 =?iso-8859-1?Q?UZfhBLXPld1b3L3y+2QVR63l/fXLv+FD0DpanfuXMrNaPSmzzmI4FNDZgl?=
 =?iso-8859-1?Q?ss0TzM/5R/rzRnMiIFrpBneOkEhfIE5htbo9KXwcLHMtf/dSxFnyCRHSB8?=
 =?iso-8859-1?Q?pjknShmUaO+POHVDAK+WibcifnjQnluVrIe2heo0EeCwVIOBLvErhGNoaY?=
 =?iso-8859-1?Q?v3j1FJS6YF3/CHDfKAGszCeBm8xkRZYvWIjHcI29CLntLEeW3WknaSoYp3?=
 =?iso-8859-1?Q?59LANBJ1r9nxcUuZBYs2sLWRpi8BKyNLTXa8Kdd6uLaCmm34fNz1ZNgbbZ?=
 =?iso-8859-1?Q?Her+VJsfiWN749dHjeiy2kaqEDI89ChaA+jjK1MD06Qzlg+ny5N7aOcO6y?=
 =?iso-8859-1?Q?CBuvh6T5KDtK4UGyjsgZQ9LOLNGXgT9qqxe1PQdA5gyxsfs33u/BkZJxEO?=
 =?iso-8859-1?Q?Z8ALoyI0jFYkjPKvGqnJszU2N7reKH5FJS1bmhe7FR5HgBjrjcCOCmrMIz?=
 =?iso-8859-1?Q?ZAIMpe3rcxfXy8/REUVfpvqUpL0Gv/ASaDOSn436au9iHNPoUkH0vTaAks?=
 =?iso-8859-1?Q?WkNsjo5vu1KJu50saKE7+2dgAJMdl2eJESPFNsLIpFkIEdfGuldWdDBTlC?=
 =?iso-8859-1?Q?OVERinNreqrS5syVjJy/+EEkSA+TfTN8HVgtzgUYlKnOv/vsmAvVZ5A0gB?=
 =?iso-8859-1?Q?pkeO9fSAI6OJkB+quK2JiMa81k9b+pUaPAwVqxzEWXKBdLu5UkJEtxD04j?=
 =?iso-8859-1?Q?FSLBRuDSNRmr9qPIZkDHyAOCYtj6GqEEqluXsSPFpvWHyqS2+KUEsD92XW?=
 =?iso-8859-1?Q?yLEBs4XzpVqmVwAuqwTtG5zZXoX+Fy57gR7gAur0T7Ls0KM+ycRgcJK/GP?=
 =?iso-8859-1?Q?eOOe2VLujgkLJFLclsQ/KKaZsYXgjo6x07AJJ9cX5dabC3/JBUyVFTONW9?=
 =?iso-8859-1?Q?cHEjDzIQ8+1YhOBszORzfidpBV8WaMf5pVBs8GLZroJk867TueSMywzrxC?=
 =?iso-8859-1?Q?dVD8cKMfd3GVjFGZ/b8PBH7/ZCCTeo7SpwuEVRdRPc2SX0HQL9GXKB26jK?=
 =?iso-8859-1?Q?SBVqhoKtqW1tE90EhYloN5MzrQs4AWQJXS5yItcXSZeEjbPF+GHhHcD2+w?=
 =?iso-8859-1?Q?+35xQVWrLsvRziWQkptQ/8hodooquYft9BNOg/4Kn2H5/ux24Y0RczTbVA?=
 =?iso-8859-1?Q?mJlJoFB4pzAt+Hsp1xDtiZG8PuHWISIGNrNEqGPysRak1Sh1yRozN//65U?=
 =?iso-8859-1?Q?cXgf3DE4vUSysQKx3Kl1Y0pmlitsedf7Uz+1uNkjlaR8LAcf72VyruDDr/?=
 =?iso-8859-1?Q?TcpSqluH1puB3tMCZQlDspQStnp7m8dAiG8K9j8HmUNNmzmPlaln6dcr3C?=
 =?iso-8859-1?Q?k0zaA7TqXf9Aqf57UJwFaNnjPXSlukKYGmMa4IxHzlDEUKOzLX66n++PJe?=
 =?iso-8859-1?Q?q5EgXhPPkMwA6rFrT6L3uzPoa9XdfMk4JwQ04G0SmxrCPvGyWIpQB3nK0i?=
 =?iso-8859-1?Q?/RNuIO7IrI0/7dwV0l59LbdVc5Hc3J/1OL2LxFmqkRZdVL1JTSfwDlzH2e?=
 =?iso-8859-1?Q?yJ6EFs3F9LOf/Z3dJRTvWGSJ4f9WrrOTk15vnkVka3E6pbr4zz3ploV0jl?=
 =?iso-8859-1?Q?HsYGXNhQeNNQ5wX810NOgAmEoI+LfkFuKCO19kLzzoITzWImwbBD9OkRAp?=
 =?iso-8859-1?Q?LQweJ1cMdw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6ab55b-97d2-416f-54d8-08da43aa2777
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 08:38:51.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5z7delTlo7EXbJmJskXd1fLsBhEnuWzgxKiWrR97DI4Hrlj62sJJUlO0tB/jvXtQDYIj8TtxJR7Pvtc/Sce3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2446
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Le Wed, Jun 01, 2022 at 01:42:00PM +0800, Neal Liu a =E9crit :
> > Hash and Crypto Engine (HACE) is designed to accelerate the throughput
> > of hash data digest, encryption, and decryption.
> >
> > Basically, HACE can be divided into two independently engines
> > - Hash Engine and Crypto Engine. This patch aims to add HACE hash
> > engine driver for hash accelerator.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
>=20
> Hello
>=20
> Did you test with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy (you should
> said it in cover letter).
> There are several easy style fixes to do (please run checkpatch --strict)=
 Did you
> test your driver with both little and big endian mode ?
>=20

Yes, I also test it with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy. I'll descri=
be it in cover letter as you suggested.
And the style problem would be fixed, thanks for your suggestion.

How to test it with both little and big endian mode? It would be appreciate=
d if you give me some clue.

> Also please see my comment below.
>=20
> [...]
> > +/* Initialization Vectors for SHA-family */ static const u32
> > +sha1_iv[8] =3D {
> > +	0x01234567UL, 0x89abcdefUL, 0xfedcba98UL, 0x76543210UL,
> > +	0xf0e1d2c3UL, 0, 0, 0
> > +};
> > +
> > +static const u32 sha224_iv[8] =3D {
> > +	0xd89e05c1UL, 0x07d57c36UL, 0x17dd7030UL, 0x39590ef7UL,
> > +	0x310bc0ffUL, 0x11155868UL, 0xa78ff964UL, 0xa44ffabeUL };
> > +
> > +static const u32 sha256_iv[8] =3D {
> > +	0x67e6096aUL, 0x85ae67bbUL, 0x72f36e3cUL, 0x3af54fa5UL,
> > +	0x7f520e51UL, 0x8c68059bUL, 0xabd9831fUL, 0x19cde05bUL };
> > +
> > +static const u32 sha384_iv[16] =3D {
> > +	0x5d9dbbcbUL, 0xd89e05c1UL, 0x2a299a62UL, 0x07d57c36UL,
> > +	0x5a015991UL, 0x17dd7030UL, 0xd8ec2f15UL, 0x39590ef7UL,
> > +	0x67263367UL, 0x310bc0ffUL, 0x874ab48eUL, 0x11155868UL,
> > +	0x0d2e0cdbUL, 0xa78ff964UL, 0x1d48b547UL, 0xa44ffabeUL };
> > +
> > +static const u32 sha512_iv[16] =3D {
> > +	0x67e6096aUL, 0x08c9bcf3UL, 0x85ae67bbUL, 0x3ba7ca84UL,
> > +	0x72f36e3cUL, 0x2bf894feUL, 0x3af54fa5UL, 0xf1361d5fUL,
> > +	0x7f520e51UL, 0xd182e6adUL, 0x8c68059bUL, 0x1f6c3e2bUL,
> > +	0xabd9831fUL, 0x6bbd41fbUL, 0x19cde05bUL, 0x79217e13UL };
> > +
> > +static const u32 sha512_224_iv[16] =3D {
> > +	0xC8373D8CUL, 0xA24D5419UL, 0x6699E173UL, 0xD6D4DC89UL,
> > +	0xAEB7FA1DUL, 0x829CFF32UL, 0x14D59D67UL, 0xCF9F2F58UL,
> > +	0x692B6D0FUL, 0xA84DD47BUL, 0x736FE377UL, 0x4289C404UL,
> > +	0xA8859D3FUL, 0xC8361D6AUL, 0xADE61211UL, 0xA192D691UL };
> > +
> > +static const u32 sha512_256_iv[16] =3D {
> > +	0x94213122UL, 0x2CF72BFCUL, 0xA35F559FUL, 0xC2644CC8UL,
> > +	0x6BB89323UL, 0x51B1536FUL, 0x19773896UL, 0xBDEA4059UL,
> > +	0xE23E2896UL, 0xE3FF8EA8UL, 0x251E5EBEUL, 0x92398653UL,
> > +	0xFC99012BUL, 0xAAB8852CUL, 0xDC2DB70EUL, 0xA22CC581UL };
>=20
> Thoses IV already exists as define in linux headers (SHA1_H0 for example)=
 But I
> am puzzled on why you invert them.
>=20

This is Aspeed hardware limitation.

> > +
> > +static void aspeed_ahash_iV(struct aspeed_sham_reqctx *rctx) {
> > +	if (rctx->flags & SHA_FLAGS_SHA1)
> > +		memcpy(rctx->digest, sha1_iv, 32);
> > +	else if (rctx->flags & SHA_FLAGS_SHA224)
> > +		memcpy(rctx->digest, sha224_iv, 32);
> > +	else if (rctx->flags & SHA_FLAGS_SHA256)
> > +		memcpy(rctx->digest, sha256_iv, 32);
> > +	else if (rctx->flags & SHA_FLAGS_SHA384)
> > +		memcpy(rctx->digest, sha384_iv, 64);
> > +	else if (rctx->flags & SHA_FLAGS_SHA512)
> > +		memcpy(rctx->digest, sha512_iv, 64);
> > +	else if (rctx->flags & SHA_FLAGS_SHA512_224)
> > +		memcpy(rctx->digest, sha512_224_iv, 64);
> > +	else if (rctx->flags & SHA_FLAGS_SHA512_256)
> > +		memcpy(rctx->digest, sha512_256_iv, 64); }
> > +
> > +/* The purpose of this padding is to ensure that the padded message
> > +is a
> > + * multiple of 512 bits (SHA1/SHA224/SHA256) or 1024 bits
> (SHA384/SHA512).
> > + * The bit "1" is appended at the end of the message followed by
> > + * "padlen-1" zero bits. Then a 64 bits block (SHA1/SHA224/SHA256) or
> > + * 128 bits block (SHA384/SHA512) equals to the message length in
> > +bits
> > + * is appended.
> > + *
> > + * For SHA1/SHA224/SHA256, padlen is calculated as followed:
> > + *  - if message length < 56 bytes then padlen =3D 56 - message length
> > + *  - else padlen =3D 64 + 56 - message length
> > + *
> > + * For SHA384/SHA512, padlen is calculated as followed:
> > + *  - if message length < 112 bytes then padlen =3D 112 - message
> > +length
> > + *  - else padlen =3D 128 + 112 - message length  */ static void
> > +aspeed_ahash_fill_padding(struct aspeed_hace_dev *hace_dev,
> > +				      struct aspeed_sham_reqctx *rctx) {
> > +	unsigned int index, padlen;
> > +	u64 bits[2];
> > +
> > +	AHASH_DBG(hace_dev, "rctx flags:0x%x\n", rctx->flags);
> > +
> > +	switch (rctx->flags & SHA_FLAGS_MASK) {
> > +	case SHA_FLAGS_SHA1:
> > +	case SHA_FLAGS_SHA224:
> > +	case SHA_FLAGS_SHA256:
> > +		bits[0] =3D cpu_to_be64(rctx->digcnt[0] << 3);
> > +		index =3D rctx->bufcnt & 0x3f;
> > +		padlen =3D (index < 56) ? (56 - index) : ((64 + 56) - index);
> > +		*(rctx->buffer + rctx->bufcnt) =3D 0x80;
> > +		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
> > +		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 8);
> > +		rctx->bufcnt +=3D padlen + 8;
> > +		break;
> > +	default:
> > +		bits[1] =3D cpu_to_be64(rctx->digcnt[0] << 3);
> > +		bits[0] =3D cpu_to_be64(rctx->digcnt[1] << 3 |
> > +				      rctx->digcnt[0] >> 61);
> > +		index =3D rctx->bufcnt & 0x7f;
> > +		padlen =3D (index < 112) ? (112 - index) : ((128 + 112) - index);
> > +		*(rctx->buffer + rctx->bufcnt) =3D 0x80;
> > +		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
> > +		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 16);
> > +		rctx->bufcnt +=3D padlen + 16;
> > +		break;
> > +	}
> > +}
>=20
> bits should be __be64

Got it, I'll revise it as you suggested.

>=20
> > +
> > +/*
> > + * Prepare DMA buffer before hardware engine
> > + * processing.
> > + */
> > +static int aspeed_ahash_dma_prepare(struct aspeed_hace_dev *hace_dev)
> > +{
> > +	struct aspeed_engine_hash *hash_engine =3D &hace_dev->hash_engine;
> > +	struct ahash_request *req =3D hash_engine->ahash_req;
> > +	struct aspeed_sham_reqctx *rctx =3D ahash_request_ctx(req);
> > +	struct device *dev =3D hace_dev->dev;
> > +	int length, remain;
> > +
> > +	length =3D rctx->total + rctx->bufcnt;
> > +	remain =3D length % rctx->block_size;
> > +
> > +	AHASH_DBG(hace_dev, "length:0x%x, remain:0x%x\n", length, remain);
> > +
> > +	if (rctx->bufcnt)
> > +		memcpy(hash_engine->ahash_src_addr, rctx->buffer, rctx->bufcnt);
> > +
> > +	if (rctx->total + rctx->bufcnt < ASPEED_CRYPTO_SRC_DMA_BUF_LEN) {
> > +		scatterwalk_map_and_copy(hash_engine->ahash_src_addr +
> > +					 rctx->bufcnt, rctx->src_sg,
> > +					 rctx->offset, rctx->total - remain, 0);
> > +		rctx->offset +=3D rctx->total - remain;
> > +
> > +	} else {
> > +		dev_warn(dev, "Hash data length is too large\n");
>=20
> What user could do with such message ?
> This seems like an unhandled error.
>=20

Yes, I have not consider this. I'll revise it properly for next patch.

> > +	}
> > +
> > +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg,
> > +				 rctx->offset, remain, 0);
> > +
> > +	rctx->bufcnt =3D remain;
> > +	rctx->digest_dma_addr =3D dma_map_single(hace_dev->dev, rctx->digest,
> > +					       SHA512_DIGEST_SIZE,
> > +					       DMA_BIDIRECTIONAL);
> > +
>=20
> All your dma_map_xx() are not checked for errors.
> You should test your driver with CONFIG_DMA_API_DEBUG=3Dy

Got it, I'll try to test it with CONFIG_DMA_API_DEBUG=3Dy, thanks for your =
suggestion.

>=20
> [...]
> > +		src_list[0].phy_addr =3D rctx->buffer_dma_addr;
> > +		src_list[0].len =3D rctx->bufcnt;
> > +		length -=3D src_list[0].len;
> > +
> > +		/* Last sg list */
> > +		if (length =3D=3D 0)
> > +			src_list[0].len |=3D BIT(31);
>=20
> The BIT(31) is used on lot of place, so you can use a define.

Sure, I'll replace it.

>=20
> [...]
> > +static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
> > +				     aspeed_hace_fn_t resume)
> > +{
> > +	struct aspeed_engine_hash *hash_engine =3D &hace_dev->hash_engine;
> > +	struct ahash_request *req =3D hash_engine->ahash_req;
> > +	struct aspeed_sham_reqctx *rctx =3D ahash_request_ctx(req);
> > +
> > +	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x,
> length:0x%x\n",
> > +		  hash_engine->src_dma, hash_engine->digest_dma,
> > +		  hash_engine->src_length);
> > +
> > +	rctx->cmd |=3D HASH_CMD_INT_ENABLE;
> > +	hash_engine->resume =3D resume;
> > +
> > +	ast_hace_write(hace_dev, hash_engine->src_dma,
> ASPEED_HACE_HASH_SRC);
> > +	ast_hace_write(hace_dev, hash_engine->digest_dma,
> > +		       ASPEED_HACE_HASH_DIGEST_BUFF);
> > +	ast_hace_write(hace_dev, hash_engine->digest_dma,
> > +		       ASPEED_HACE_HASH_KEY_BUFF);
> > +	ast_hace_write(hace_dev, hash_engine->src_length,
> > +		       ASPEED_HACE_HASH_DATA_LEN);
> > +
> > +	/* Dummy read for barriers */
> > +	readl(hash_engine->ahash_src_addr);
>=20
> Probably a real barrier function will be better.

Sure, I'll revise it as you suggested.

>=20
> [...]
> > +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> > +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> > +
> > +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg, rctx->offset,
> > +				 rctx->total - rctx->offset, 0);
> > +
> > +	rctx->bufcnt =3D rctx->total - rctx->offset;
> > +	rctx->cmd &=3D ~HASH_CMD_HASH_SRC_SG_CTRL;
> > +
> > +	// no need to call final()?
> > +	if (rctx->flags & SHA_FLAGS_FINUP)
> > +		return aspeed_ahash_req_final(hace_dev);
>=20
> This seems like a forgotten todo.

The comment should be removed.

>=20
> [...]
> > +int aspeed_hace_hash_handle_queue(struct aspeed_hace_dev *hace_dev,
> > +				  struct crypto_async_request *new_areq) {
> > +	struct aspeed_engine_hash *hash_engine =3D &hace_dev->hash_engine;
> > +	struct crypto_async_request *areq, *backlog;
> > +	struct aspeed_sham_reqctx *rctx;
> > +	unsigned long flags;
> > +	int ret =3D 0;
> > +
> > +	spin_lock_irqsave(&hash_engine->lock, flags);
> > +
> > +	if (new_areq)
> > +		ret =3D crypto_enqueue_request(&hash_engine->queue, new_areq);
>=20
> Why didnt you use the crypto_engine API instead of rewriting it.

Any common crypto_engine API can be used? I did not find any, Maybe I miss =
something.
It would be appreciated if you give me some clue.

Thanks

>=20
> Regards
