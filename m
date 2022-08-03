Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7E5889DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiHCJwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbiHCJvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:51:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4A42AF5;
        Wed,  3 Aug 2022 02:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D69NXH7KHQy/H9iYXswLofSfMFaFkH2TV/xZGFNnkqm743LMAWkSp9o8LRuOAYwMTiNWj9WXCQXndWPpmX+yRZXM/E0jOA6TVgpcVm1Nlh9rnrOmjmupDw30ii+U1V+/cm67iajpN4tvFUxbfHhQUtPqNsg6ixnaD5PfwCBKGni6DdYIJeD0YrMVMmLJRcut7VfagYExOcJJ34KZF8fIEeOi6hrKzyBU8zdotLhOY6sTsHI98RtPh+WdbbQznQJr0c5u1KKNHaergfQ2y6RMI1/rfmQtPYjqtO8zYke9F4uxrnre9noIBANtWSH6MLWmFi8z4XVsDKgv8aC3xuuwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSRg+V5XZcRZIfJxulo6Sfb0a5hKAdniQiZ4cZzNNOA=;
 b=YNp7dtMwi7ZbRGZpIucykqdtRnNw/MqFk1Q+IQNYsi+RZdXyQimvKOtRNhfW35xzSpef8yu8nA8fTDekQvZB7gA+kakbUxoaLEO8+suTi6powZi0Hj9gd0EAkh+DYD6HNM76KkMVIz/AhpYZiH+iRpme71uImYP3A0uPQB5/QGzdbkDytyW7X9FtGe/Lu7EA1CLKK/02i6lmfM1pD+L25ZLvDc8POSy9xNxJQiIzLQE5G7cjGu2gVjoMcEAQQjvYDIbKexzl5lo5dUWxVnykToZTGY+Ch5Mb8aWNWEqcOAnTPwVXNEQM+0X269VaD6N62wsIQXg3GVO5ZgLRLuclPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSRg+V5XZcRZIfJxulo6Sfb0a5hKAdniQiZ4cZzNNOA=;
 b=LThPnxZFebyB8N+3uOgJinRvpRFmWMIjUr/UYlOZ0ZUQsWrvtnSHgxEPLUN8n6LHQjHBASXPJuyx3Xxcrrnqtf72+kYxeUbX0qcySBj46hWNRTJopK9qr2SEosCn0jhXn3qlg1J8UMh410JTivjb/1aLof9DjlBKrtneqnU5NUA=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB7PR04MB5513.eurprd04.prod.outlook.com (2603:10a6:10:88::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 09:51:00 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c%8]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 09:51:00 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: imx: initialize
 peripheral_config/peripheral_size for sdma config
Thread-Topic: [PATCH] tty: serial: imx: initialize
 peripheral_config/peripheral_size for sdma config
Thread-Index: AQHYpwbfzk8jOQKslUeCbcTMT1rdmq2c1H2AgAANtbCAAAnwgIAAAatA
Date:   Wed, 3 Aug 2022 09:51:00 +0000
Message-ID: <AS8PR04MB8404DA3B296728BD75D8D6BF929C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220803065737.14752-1-sherry.sun@nxp.com>
 <d4838245-030c-39b4-df4b-17b3b4c73a5b@pengutronix.de>
 <AS8PR04MB8404990740869737F326D302929C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <20220803094041.cmjublrg3nu4odlt@pengutronix.de>
In-Reply-To: <20220803094041.cmjublrg3nu4odlt@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa185540-d96f-446b-5416-08da7535abdb
x-ms-traffictypediagnostic: DB7PR04MB5513:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c+XUqHj0EtT2bOQaYcrMQ7GV2X08oemNYe3Sj+xNGNPKjaxbeMNTvMMIsEKWBbXin+QpclnLbivobDm7Mc//kZylNyDAcj+CS/eNZu4oAS7GocceJ8crZ8iWF+SgATB1S5LSqi8GA2q6PB72o0e6PZY+HJerRDiQYHSbRZEk4qbtnYPCLAY+8eE6db72UvVcE0E16jEKHNoME55KeHsh0ZbQFIy+6dgZCuxgZgXHfdKaoa6OFhNBYr/zoi+dFkzFHmS1U2ye3NvYrs3lKHaXHVK7qzrw4GXuX7UZWcsyl1d5SH25OTQpnj6tTk8UdRwByS5JhtZ6X3DPE9Je7NOetqAZuSJCJq1iiodmMqW5Ly5QGMeJRR9seufr+biasqAgia63a4nr8h/NtvtXRJY84S4kHvcL9gUddUoftlSC5a597DwxCOoF9YxLvENGryLqZBxv4U3T1hjF6kTb8z5PQJdcSl2AZXz3WKd4d4sQIQw6WB/rp7qivZguPWeRom5OGADT5Jid9cx7I8LrmZZNiwvlA2DCjyQiXbhbIc3sk9Jhe/TWtinAf7mDk92l9lP9K1TFfp27pwvtZp1UFINVFi9bJ9mV0dr0CVV5SVZLcL2FRz9nI4Hc9K6gleD5bCsBFFckWyvnpL0V+50AjN9wsEitEGyemZXfjYxQ5gOLqikkEwpFjLHttpoT+BsVhgwQrhAsyf2ChvYBqKEdYFyximLORpxZs8JQW69viVMTvgW/6pHEj7QqibPQTuKVBH16Ytz2sPlcSKebUzhoDW/1L9K1M6dodpk/xNRtyivXDgEg9NaTzxFKANn2J83YVbLX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(83380400001)(38070700005)(86362001)(122000001)(38100700002)(64756008)(66946007)(4326008)(8676002)(66446008)(66476007)(66556008)(6916009)(76116006)(316002)(2906002)(8936002)(5660300002)(44832011)(54906003)(52536014)(7416002)(9686003)(26005)(186003)(7696005)(53546011)(6506007)(55016003)(41300700001)(478600001)(71200400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wiPzHu0I/NHWUwoFhGgNhvFONepaXORcgIlJdKQ8BCQnhhPNiBgezh0bqj?=
 =?iso-8859-1?Q?AeGgLsjrByw7Ix3no/M2vjlzaiP8vebQa2FjEgfOLzjXssDQlm1tbSKXIM?=
 =?iso-8859-1?Q?HrMua7pHsy6lZY5tsgXBsz6A4oYkNUF4l5YrzO2Wo2As3y+drrn97R5hJk?=
 =?iso-8859-1?Q?11vD/dFd+Omi52p51mQ42GL7ru2dCoI68qYxhk58cOKxsArFQ48PA8PEOC?=
 =?iso-8859-1?Q?StGn6uQqDtiQqY9c8i2xH94lWoIIeNgJVKL19aJ5dTZXZecn6OMnNBJKAO?=
 =?iso-8859-1?Q?PLeuutKJH3jHJAwKM+cGn+vpS2ZAmKk7PqtHvvyOCMCUelAIEuXG4udYoP?=
 =?iso-8859-1?Q?dLFM9elwt+jDEzIDz0MfpbWbLwMlZprDeY/DVqpC0GpWLjGVFPry5jRe9W?=
 =?iso-8859-1?Q?lzrUv0ET8lVIyokSJlIqTGwzzqEQH1tzVoJexVk2N7SxbtgxAgPADl8AD7?=
 =?iso-8859-1?Q?9//IaTOOFZ8IoZqyOIauOHou/5bv9QlzQr0FpXj54Wi/8KtFuYPp8E7uDV?=
 =?iso-8859-1?Q?KMDVQtpBe8jhhm2QW0Xamhk5CSH21R45r8DansVmI3Z6fiUVki8ddx9xmV?=
 =?iso-8859-1?Q?Tq2kUizVz4B49A3S7fhig5TeUfxp+nfzkCKmdHPC6PIbb0wEid4tKKKH1Z?=
 =?iso-8859-1?Q?oL4mXslsDXSybfedv8meu5cIcmV/tqU7XaOEVHMau8/EmGJ67mXE69k/wz?=
 =?iso-8859-1?Q?KuMHu7a8NRPAQqImcn1xZOtA/SvC/BUjpu5ZDzGH+yJ6r1WA5uln+bGr/J?=
 =?iso-8859-1?Q?ugCkxj1Y3HHAFF8l8X9M+qKnN/BNKFi7sWv3jDeEVGw7IuFHYFhv3GAp+8?=
 =?iso-8859-1?Q?2eSYtHO2qO+tURhl2rZFNor1LMzcnccDQyhNpS+zgziyES9SAxpQXbLTpq?=
 =?iso-8859-1?Q?IG+XmTbCK/GazsjlY3JL9m5f1TSmHOoh93JUmPxIN93isNrO2og0lfWVYe?=
 =?iso-8859-1?Q?TzO/6O27LHvkvnMTsTFQNfCFX2D+F0JNVDY/c8Ux3gOoZ3VcN6pHLoDnJM?=
 =?iso-8859-1?Q?h6usWn7wIvneIzwekLsVecAEA9AkhwxjoUa5L94h2Q2hY6gH1p+Z91k3Ha?=
 =?iso-8859-1?Q?98C5VlERyvBbgC8P54bUGX9PIHccwJ3nYH5ZN2o/yAxzcO8ig6D+4EpCE0?=
 =?iso-8859-1?Q?ReEyvTe3lCSJvVZB8MjObYYA8//OPv7wqWrcM6V+WiyzZ1eHq5nCp6Os4L?=
 =?iso-8859-1?Q?h1mxqAUbdSOJm8WAjVdFqx89PB7ANcRLOINeo6UzeRehs3SjW0WyrY9Qy/?=
 =?iso-8859-1?Q?NufpJo2C9X7qBMDLC6vQg/f5xcb0mU5Iw8IIXTOMPaeD7WUtvYKSDWYxq0?=
 =?iso-8859-1?Q?xztgxxCMzWfiorK7EUePYFjLSb46uxaCsVAaR0dWP5YL9EsECLfGtn+zh4?=
 =?iso-8859-1?Q?m5NYqCHagoYwprtQpG512Hn9zcQh1RUMKMuI5OLPOXjK6niTkBuCCYzzjt?=
 =?iso-8859-1?Q?oTuDTZH96B58sHV/J05z64p+cG93mCs+6WZREGc7+ih+RXxLnt1sCGmqJk?=
 =?iso-8859-1?Q?GqmvN5ToT8+KRTcD1tZ/lSyC4uEfceDVk3EN/LXLXQIHBatDLmMs7fUZ2f?=
 =?iso-8859-1?Q?1x7gADbfWVvdewrktgknTRnSKrJagXOnFan6IBCtmxOZ73ri4vuVv1CGi0?=
 =?iso-8859-1?Q?OtfhXiPFbrampVc68prH/XfpuvCUASN+Cq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa185540-d96f-446b-5416-08da7535abdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 09:51:00.3184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05dogl+fq2W+pUHKFj8aLGC4gtosAm/XplOkF/l1fPCnFViv5j1wU6ddDUSQDR6xQlkhhDalPSrd4yhz2ijmoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: Re: [PATCH] tty: serial: imx: initialize
> peripheral_config/peripheral_size for sdma config
>=20
> On Wed, Aug 03, 2022 at 09:15:58AM +0000, Sherry Sun wrote:
> > > On 03.08.22 08:57, Sherry Sun wrote:
> > > > Since commit 824a0a02cd74 ("dmaengine: imx-sdma: Add multi fifo
> > > > support") adds the use of
> > > > dma_slave_config->peripheral_config/peripheral_size to sdma
> > > > driver, the client drivers like uart need to initialize the
> > > > peripheral_config/peripheral_size for sdma, otherwise, the random
> > > > value of local variable slave_config may cause unexpected
> > > peripheral_config and make sdma mess up.
> > > >
> > >
> > > If this a fix, please add a Fixes: tag. I am not sure it is though, s=
ee below.
> >
> > Hi Ahmad, thanks for the comments.
> > I don't think this patch is a fix for a specific commit, so we don't ne=
ed the
> Fixes tag.
> >
> > >
> > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > ---
> > > >  drivers/tty/serial/imx.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > index
> > > > 522445a8f666..bb8c2a712e94 100644
> > > > --- a/drivers/tty/serial/imx.c
> > > > +++ b/drivers/tty/serial/imx.c
> > > > @@ -1320,6 +1320,8 @@ static int imx_uart_dma_init(struct imx_port
> > > > *sport)
> > >
> > > This function starts with
> > >
> > > struct dma_slave_config slave_config =3D {};
> > >
> > > >  	slave_config.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > >  	/* one byte less than the watermark level to enable the aging
> > > > timer
> > > */
> > > >  	slave_config.src_maxburst =3D RXTL_DMA - 1;
> > > > +	slave_config.peripheral_config =3D NULL;
> > > > +	slave_config.peripheral_size =3D 0;
> > >
> > > So these are already zero-initialized.
> >
> > I am not sure actually, I think initialize a struct with {} cannot
> > guarantee that all members are initialized to 0, it may depend on the
> > compiler.
>=20
> I'm sure and even reverified in my C book[1].
>=20
> 	struct mystruct variable =3D {};
>=20
> results in all components being initialized to their default initial valu=
e (which
> is 0 for numbers and NULL for pointers). This works for automatic variabl=
es
> since "Standard C" which should cover everthing that is capable to compil=
e
> today's kernel.
>=20
> Best regards
> Uwe
>=20
> [1] C - A Reference Manual, 978-0130895929
>=20

Hi Uwe, wow, this really resolved my confusion, thanks a lot for your confi=
rmation! ^_^

Best regards
Sherry
