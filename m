Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260A458EF68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiHJPYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiHJPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:23:51 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150047.outbound.protection.outlook.com [40.107.15.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDCA5B7B1;
        Wed, 10 Aug 2022 08:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxrixJjbrsFqBww6KcZSSL8T4/tMnXbOJDye5lZS4bxr1hB58JgdssO8+xU9BRdhg9+TqJ/JwAEsTCRkIVHHGwRjJoN7m4Gz7UCMWVQtOmejchYOqbP7OYjXNG5SP2PrW4KKcyyyqTG6j2qkYBTzra2kq8AtqzPuBv49FrYTTrhlJWZBiduc9d4wSzw6U0jKdtJ70ki+BIto3sO/NoJwHdwRzgL6JQ+RMwWHKADYd35bq8Bl+VHaAy+0jQDHpmwm0YVmNjbwE/GnRjHdPOK9tWLmKvUl4Yho0uEHxwbeYhsFeOm9I8voM70VPDZAf9+fnESwiyZq1SQ/YZbudS00Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thZVAxL3JQqT8hTOGIG1pOYpdUEh8XmxyhmxpIS+TVo=;
 b=d9u/y6yDCxxA7L7RH6m1cf+lNSzErkyynKCJH+v5UN9uMZqPx0v8L8xtawdoDja83JiBMTFKeaFU7HAUD6HmYb3cxebG+3OyFaTja+tyBT9TpiNaotrX/2yu/qb9gc34h+xrLxE+AnodqLciSOWtcgAC2Xs4hCBEWfhBayB58sjJ6j1o0RJ7sDO2CUN018r8PiZqxdT7QigGeJ2kxh8gRk7EbrI30ASjeksipD4WJ+iTPQNyOEvKdWwXeTtHnXaSbOpxYDcIngUkiRusZspHj/PHD4Ux1w03w4dlMfrGZu9xC4COB1jzWO/EkYkfi9OrBGAqiiVLRvM1u6ca30XNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thZVAxL3JQqT8hTOGIG1pOYpdUEh8XmxyhmxpIS+TVo=;
 b=pN9XdfsF4gth+N7LG9IQovoyAYTSoTY/FUADJVYT2WyPgWx7P58FD16a4exJ1mbK3KjTTljTLxQvGp3DXZNbM05zVzNvZRHL8PhbvoxVxjDUDqGnT9exqxrNayWaE8+8Ikb8CoT0yZLwdT1EjQMoauc3EVPl1E2JQVCfC3Kt+uY=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Wed, 10 Aug
 2022 15:23:47 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 15:23:47 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v3 1/3] dt-bindings: gpio: Add imx scu gpio
 driver bindings
Thread-Topic: [EXT] Re: [PATCH v3 1/3] dt-bindings: gpio: Add imx scu gpio
 driver bindings
Thread-Index: AQHYrL17Pas5Q+nPyEWWoebmGoM+lq2oNm6AgAAHPuA=
Date:   Wed, 10 Aug 2022 15:23:47 +0000
Message-ID: <AM9PR04MB827495CB596427BD86A1522B89659@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220810133005.74653-1-shenwei.wang@nxp.com>
 <20220810133005.74653-2-shenwei.wang@nxp.com>
 <ec6fd9eb-f46d-afa9-b08b-15e202b3a624@linaro.org>
In-Reply-To: <ec6fd9eb-f46d-afa9-b08b-15e202b3a624@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 643fe480-cad7-41c2-9e20-08da7ae45227
x-ms-traffictypediagnostic: PAXPR04MB9074:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nR8RQn1QZ6tjsKlWXjQwGoiK/kIBB4a+/Dd9OkkqhS1aq2DBhKFikkdqIpjjGh9iSQsUbjEzedjXJVH3JY1Xs4hwET4gOy1n3pyes70KqeR9MZGb4ESOdgsSdUBfBhkk7TL79++OIy4CCIKQW52byJ8YyBq72bKrudEkI0QnOgWFubvNU6dbdFrtx4NiQ3ZDzjUeMc2fEmct0t5NNripzR28gCq6iNiE9XpKkfT0CDmV2vs2/0QcyEXJ4IrBEScP6bzGbpgjcjaKQ65p5hFwFtOgiOpbU6QwO4oDackqU3sy2MifztHzG8WlU0HtzmnSQaTJxDljkwB2UdFAGCuTbGeHw1Flf0ZQeAJH0JXW4Ntw/e587nQn1TF8ToWsLFfNXqr0r7iaVCoIP+FngKVWWgVaP/u5a4mua/AmIhEQKuLVsu4f6EWcx1VD9Ogz/lFowXzzGs+Mty2pc3GXIXxUO5ANBTAAicA6bxJJEXqyDuOgi4XpEqR0DgFu48MmcUtZAkGMrKIYoiCvu+2dGiRZ0a3ig43ni9txmX9Tmxj6PoFcjIxVL7cgQDJ4fEWZrIFQyKXVS4GdW20npRE7l4GveQiNWDv+WLCNEonA/l2MqSsmKZ3+MdV28iqI3jly0Uklq9GX+zGS5n0Jm1xJa5d0nbE75O8AUXHoxhLMgsGVD/x/vJeLlIyGBz/Fl1/Gld1REXNJsHQOzKbQpekwJVMk7XbbbYV5jCiMHhl/PNYUOEjSFq4ziH8IPd/+KnO6xCY68rzjcvb0erX1aZHCaWBkqH9lzuO3pj8uq4qBQiqhw0BWBSin55KZMJIONL9vrkTUVNhmNssLkKVg4TmDCKmMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(41300700001)(26005)(478600001)(71200400001)(921005)(38070700005)(9686003)(186003)(83380400001)(53546011)(55236004)(110136005)(7696005)(6506007)(54906003)(33656002)(55016003)(66556008)(66476007)(66446008)(5660300002)(64756008)(4326008)(66946007)(76116006)(6636002)(316002)(8676002)(52536014)(122000001)(86362001)(2906002)(7416002)(44832011)(8936002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yvTkywv8d/7q1MX4X3vGMGRn1vXTNgOsSaXyb1lHNW0z2FMOj4FpdS0rUv7j?=
 =?us-ascii?Q?eTFhzkWqtt3sf3RCA8w6TqlWc3EyNmys2Xy9Ysc7vHpOFZDXAaxW+lTFZZlN?=
 =?us-ascii?Q?Fd0KN1W32r3xpM2ygchka+WMegLu6jx+mug0pGEwPODcTM1u5WO5BEr/KCHN?=
 =?us-ascii?Q?qTPwRSd/h7YC7cIRWLqVHoocAYc6DsdzbnsWsFPOUyBHz7ndflQh4yHT1xZY?=
 =?us-ascii?Q?clDr2NMdbfpAZzWltFv/yv3NG8Oq2BKNjGA/pHI/Wx+kYSEHo0u4IOhab2FH?=
 =?us-ascii?Q?9YPeo3Yt38aB4JloprmSA3wJRcHsIeSxK3DBuD6zr2upnAj2M2aWDjLuQaG5?=
 =?us-ascii?Q?6tnud957d6HEB0xqGpmFCMbPC0sd7/pukQ7DAhiEXGECNybvyDaCamF+9SF9?=
 =?us-ascii?Q?YJZMl5Id9eFOmrU859XHl+A39QC9H0v+aRjLA9ptEzZk0nodwQUmU5KEg6IN?=
 =?us-ascii?Q?++DcFTuTIYW9/C1ilgv0NsGmSi6ck8fUmSXd/t/TI5qfkGrxiecdgGLSJQl4?=
 =?us-ascii?Q?ZY0g5C1ktq4PTo4AKmJyRYxUemghx2IdMOv8Bakp+rWAEt5v0SrUee7UbIgK?=
 =?us-ascii?Q?SSpHHxfAX0b1X+eh4kNOz/P3Hn6BVXKKX3d6oNNeAXpl4GJri+pcQIP5DtXA?=
 =?us-ascii?Q?kpHztCE1aYEPnndeCBt80Nel5bSHirPDnNP2KishRfNi9wAXHYUCreYagWj2?=
 =?us-ascii?Q?spffnOygkQdtmO3fA1JGFHlvc0zLHv42C0Ddysi0cdNUVIEqxiLO76K7oT/M?=
 =?us-ascii?Q?dlN2TpLBubTfcN9fcSyL1sigWdK+rWwRVbUBvtyakHXm441B5Ts1Fvczqsev?=
 =?us-ascii?Q?JaOu4eYFuerqUprjxDXcxPELFT6Sqx9lqy7FHzrSO4Ow7iuUILrPjqra5xfU?=
 =?us-ascii?Q?79Irdbsql1i31T/L8nR7YRsvKD7vGVe2M2AyoiZ4HD/mJapFcUOFtoYnJSD4?=
 =?us-ascii?Q?4YsphSCA8zsHSXLxiUoCrI68pKMhyohve1M/Bcv0CH6ZmGmA6VXAJTNBbVVJ?=
 =?us-ascii?Q?oVrpPiQJ+5K8VdwR90UuDF1FvFkjvx5wzSV4XZZokY0Sj/O0Kcl9yLYVC4/G?=
 =?us-ascii?Q?3guWu7M1Uy4N+Qvvo+U0Uov3J/WxyCu6P3bgehN9vblLdiGJaLzUfs29Mpe0?=
 =?us-ascii?Q?HjZQogIYfDouXv4U4NjM6EyjKH93NdQCnUY4jbupidBAlt3gLODP9OmuN5Kb?=
 =?us-ascii?Q?JHar70lQLP/nzTQh63IJb9mxCzaQr5jwnp1COaWUsrwZoUHs39WNc1RGxAU2?=
 =?us-ascii?Q?x870utWOuAH7m9OhYjohJ/GBNRIaXdPW1GaOwUoC76laotgbqgDOrGq9GuZy?=
 =?us-ascii?Q?sW/0y58npiB+xXU/Z8RiEGfvTOFhmU5CD4Y6DztfJP+HWypkNUIwyKiFNnrL?=
 =?us-ascii?Q?WlZq5XrKmF6D70IcZHeJaTz8qwPU4jx6PtUAkCdiZs6VsO615+mvrEC2fUF4?=
 =?us-ascii?Q?yPGS+HHvTkKQsv58OtH9aV69hla3Ae4qdI42AABLzKL2lCIjzk1M5etqbLWG?=
 =?us-ascii?Q?kfjI43A7Q/1ltPZXbRH1ffYZN/L+nipfojrH2p2ZOgiJpj581BxJ6jcFejuz?=
 =?us-ascii?Q?t1eX6QFuxR0/+rgma5z2slrCDzIiF3yaxsISLUZ+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643fe480-cad7-41c2-9e20-08da7ae45227
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 15:23:47.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o24aJDGt4Bk5LKWoYoQY/MGDS+vBK6A5kTzNxXOp/jugPnSBNIVbyaIfbb+dkyNGYizAc7NEYg1xXZTFIrwgxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Wednesday, August 10, 2022 9:46 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linus.walleij@linaro.org; brgl@bgdev.p=
l;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> gpio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; imx@lists.lin=
ux.dev
> Subject: [EXT] Re: [PATCH v3 1/3] dt-bindings: gpio: Add imx scu gpio dri=
ver
> bindings
>=20
> Caution: EXT Email
>=20
> On 10/08/2022 16:30, Shenwei Wang wrote:
> > Add binding document for the imx scu gpio driver.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > ---
> >  .../bindings/gpio/fsl,imx-sc-gpio.yaml        | 40 +++++++++++++++++++
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8qxp-sc-gpio
> > +      - fsl,imx-scu-gpio
>=20
>=20
> This is too generic compatible and it even conflicts with the above...
> Your driver binds to both without driver data which is even more confusin=
g.
> Make the compatible specific for one, given SoC.
>=20

Oh, that's my bad. It is a typo. The generic compatible should be "fsl,imx-=
sc-gpio". =20
So far there is no driver data required for both imx8qxp and imx8dxl, but i=
t might be
required sometimes later in case the scu firmware is customized for a speci=
fied use case.
That's why I put the generic one here.

Thanks,
Shenwei

>=20
> Best regards,
> Krzysztof
