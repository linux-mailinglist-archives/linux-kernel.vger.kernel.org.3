Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8613B58892F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiHCJQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbiHCJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:16:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B0C20BE3;
        Wed,  3 Aug 2022 02:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAPSdWFGUqRBf2E6ze/3mbj5SQcRKVvG52ehMft1302vXuj48Mb10lFGoBbL4xa5mMJS+K4a666hz6sGOGT24t3nRBDzkF1ZdXaGsdfCzXr9VHBEtnECVHfOJgErLivtBax2Yn4N96kCKdCIlIn5/HfnCNyNFxsKl3y+6jwl+ypK6gAn0N4jSwis6305WqosVaeWjjTiIZhM0V6ogCGwUEH8NnVU/FLwRYdS/zDhGqp7dqfF5ToABw9SxH/boOijCC4yMTtmRGfJXuqFJ0NQyUL4eQ4IO3zmynpnIFNlAloa8dXGQ4gz9Jjcz6JNj/QXW0he2MR4WKkniLe2aMQs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksX913rz74wIYA4DcjrMrQWV6mtS8BqoyE8iFIbtzos=;
 b=c6UUvDPf+njx9SzCXcsl7zsC0cH1H1XVVneYgA4PTF2+VbvWmRMuX22QCOacqvMZHskXNOTk7i7ipKEKD+vrSYZ9vkPw8tqnf+jOcja66Ygf8qGgQXiSJDVvg386LhGUKrZ91wiL1HypzPJEMbQwKt37/8HzkTrMPS3OSMU7Bko8yGYu17vPagoaj9OOSP8wgM1XnmnhYH6c1nPW5Lp66MZo6b5TP2+ZoWyWRMPv7v3qFBEPXNzOxOquzyfEXAt8wWN1+Bgy4p1Y+Cy/jY3fp5ELQXw5j5WPiYy1JFd6wPMEOhFdliXP3gzx2etfzZPXScZDqMm2g7biqskSgXzbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksX913rz74wIYA4DcjrMrQWV6mtS8BqoyE8iFIbtzos=;
 b=Kcqu5EO0IpZCsKd/TNh+pN6iNnX7KPaLPYXc3ixG+ZhUybbr+ZnLaRAMym+HXQwp/p4ykDVg9zrfo4sppTAqWckSXtgmvgjCoKq0FhcwN5HmiSgA4++vG/Yl2yNjWJmTkeew2Q9DoOJpR2u9fdaj70piqZ1fFFGllLZff3aUvOo=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 09:15:58 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c%8]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 09:15:58 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: imx: initialize
 peripheral_config/peripheral_size for sdma config
Thread-Topic: [PATCH] tty: serial: imx: initialize
 peripheral_config/peripheral_size for sdma config
Thread-Index: AQHYpwbfzk8jOQKslUeCbcTMT1rdmq2c1H2AgAANtbA=
Date:   Wed, 3 Aug 2022 09:15:58 +0000
Message-ID: <AS8PR04MB8404990740869737F326D302929C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220803065737.14752-1-sherry.sun@nxp.com>
 <d4838245-030c-39b4-df4b-17b3b4c73a5b@pengutronix.de>
In-Reply-To: <d4838245-030c-39b4-df4b-17b3b4c73a5b@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c61bc0cd-82a9-46ad-5c05-08da7530c70a
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/3b8DgN12bmbrQIdRMR1BmD5DeIeeWDcyMALzHue/6mqYGwIu8tmm8ss2RVXijLrDAQq+ezi/IB0yQEuNruenZQgVo5JB9npREg7dWDaFN/vpC62nkDUoTyqqZbRyORrT9BFDAPMzi9hvySLZ5EXrNYNcNgYmfU1/Bkg8LYzDParhdYpNfAb747UoYzzjGZW4lK76utXsMhY8UGk9IdAMf1xi+BgIgj1cdw/Dqh6w/zmpMRb0Q6+jmfsg9DXyz7WvRZwkm21VSidcWHTFsgUSE9jL8LXpFM03POVrwmDVqVzd8TGUQw/TyiOy+bn1EGbSLfm3cKfWF2ni/lzAJKit/1E0h4QiC6hfFxfvgx8ewwRndD60rkVV31YrtRFV0H/09eaq0fLjpu5/GrMqdI1odAuRHrVtQ0jHOZD1AzLRx7Y6nabQZs5c3dmcImBxEcqJF1gg2TuNFGm7HsPZQGcRMduQ/2dJ0MRykzDJ1JxL3NiI0OGRVtaePpMs+7a1mdP3Vl1frdUP3D9tHX1/h9iyBWswyShLS7fv6+5/UL7NLget/73vk7pkvKU3QV3xM8SAPgRLBorz9zwJQqqkRYseLTIWoJmuWrknx2dFBYiKQ4H7/OOnWP71zf5HFnXjqkavXDDI9qSuLdafk7UurNjwmMfcPjwRdsAGrBWboSPcBpP7xc3ycUfzEJmPmwAGd/egbWwF1uf39oTVWOEORfxtavsWRv047FXgK1QquteqRJEgx+B3OpAa2Ir8rEMY7500saSiqCW8GMKGPbvUabi2M0aRTFklVfANO8cK9Z0uKEC3SXw8xZ4LD0RvBAqeME
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(41300700001)(478600001)(33656002)(55016003)(110136005)(54906003)(2906002)(8936002)(122000001)(5660300002)(316002)(44832011)(38070700005)(6506007)(38100700002)(66476007)(71200400001)(66946007)(66556008)(64756008)(86362001)(53546011)(52536014)(186003)(76116006)(4326008)(26005)(9686003)(8676002)(83380400001)(7696005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SSsIpr20e/CV3pizIhdE5UgacHiw+g0PyuHtEATjVIUfPBQsqHvoPOxK93eq?=
 =?us-ascii?Q?fuBhAjg8mhR0kzueWUv2HOxazQWX1FBfdfR/GM3L/RQvszTZ34gh3cWZ3gZ2?=
 =?us-ascii?Q?bFyiviIdEorQvByhNo85sbmDhmsKSynDh/GvItgfv6ARknGh9+vkb7KPT4N/?=
 =?us-ascii?Q?iPNGi+hMe6iAazEntzS3aropczmg3vmgHnd/YXCSiqkiLDPpAhJXKadHDVTe?=
 =?us-ascii?Q?hPOYTCwDoa/IY6cbbJRdTvqo7e1pUVbr3QROi/RwfjHR9Qf666Z79+pgCYw0?=
 =?us-ascii?Q?iCiUd2y7ApIp/DyYsMGAnp0tBV3e9pdljzqmFjvbWwUtxEVdRfE4oXG+8cHg?=
 =?us-ascii?Q?4zcDyGTONZM6c90uzFVgw3Q2SSJNbD2HXrCTw9NPL8EFcWy94LHHANIaHQbn?=
 =?us-ascii?Q?KteaSC5/yNWDrcDhb5IoSF1lrmJciL/7FNO0hDzs2Jd45JBFX7setOy5WYGF?=
 =?us-ascii?Q?AQDqdaUqiyGb+wTse7vrH9FlzUvsZ70A1dENAcevga27fALubV79CaTHJI6v?=
 =?us-ascii?Q?0j06ZihjBz16Sr6EYIaomQiea75EfVefISqwT5m6hlf6fKqEUKMdCeFbNqFS?=
 =?us-ascii?Q?H4tLwXAjuE3JhEOU8Gh3qI3xzHXvc6kdQG+m5Rh3jfY6hcyzW9fWXep9oUCc?=
 =?us-ascii?Q?5HYBoLxvL6Hx7sZ3p2KZiu9IEyc1L+cLruSrg1JTxDO1J8nsHG4ZHdQS9FET?=
 =?us-ascii?Q?5tRSyagl4ziIPKlxVBTLdBEmirdA9gRlvcHA60BNKT67vJ10KEC3vvafZ+fM?=
 =?us-ascii?Q?H3X0N4RVmBEukgfyYKZBPsNBhqxwNIlMMWDB9NE05NhQ7YUVG9p0jfT4ceDj?=
 =?us-ascii?Q?GxW7G7zKgSktrqAfhxPzXUQ6QUwL0Mcq/Hm8jjBOmjPa5aWVw2aNGR9sDRcL?=
 =?us-ascii?Q?NG2F/7/NPr+s/PtksBuaisIEjotxCxdjI31RTE5awxaUmAzcHtjzBfQoo5Mi?=
 =?us-ascii?Q?RnB6CCszHTfRlJ1U1VSgeYQZLLQ6l3ZoopzfVgGLORWHEwiK3q7VSTDAtOaG?=
 =?us-ascii?Q?F2Fda/qrpmHP/GOgVtiWRietsprEG+es9yujRATjcHG3LTVAv4hBy2MOJUgW?=
 =?us-ascii?Q?32kpkoOnCjp5yQxn8xAPDC+LwdHb8j5qWeYpOZRA12587eKoh2iu7La0QU5z?=
 =?us-ascii?Q?4qD9ufcS7TdvZqLfOi+IGhRfmTBwD8W74UtgAV86vXoFN5CaB0rjMm1RHsJR?=
 =?us-ascii?Q?XKU8qOLRnsfUsG0iLeyqiJHfiLtYUzAc3tFwUeU3N8wBXol0DKoG6yAVPHCD?=
 =?us-ascii?Q?FLtex8hcK5Nd759pPqjjsKsKff9kFwW2mG8Ttja12fGsIGyUB6n6bx51oJVS?=
 =?us-ascii?Q?YxmIzG2CKWVpJITpSd+61GBdX3tvGc6MFLtyR7zd+U4bPXl79CepUSfdSyyi?=
 =?us-ascii?Q?f8IYKarr/62UW6/W6HRcPeu8lDMDrBSPJi5ZeKBSApGLNx9SGJc2YhVKa3qC?=
 =?us-ascii?Q?pZj+rYVVIK26CokkkF7MxGJNCeVvUw4LYXAkQhkgscby2jhm78oaPNsCm+XB?=
 =?us-ascii?Q?n9q8OhtD8apPt8NyaKEGtveY5PTxJWK/n7pGxR2n/l9YvfcRI/dGS9nIINul?=
 =?us-ascii?Q?WRpa3tHeivJY+HjVwIIWI7xQvrwMz79/QHdnWqu/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61bc0cd-82a9-46ad-5c05-08da7530c70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 09:15:58.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxK7dlnKmvxvbiMbKGD3JiDaD1DWOhdmScdaP90GFqmHxmJ9Qm1ay3wpABpxA/xn+XlcM72BpEK11K2+jcE/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 03.08.22 08:57, Sherry Sun wrote:
> > Since commit 824a0a02cd74 ("dmaengine: imx-sdma: Add multi fifo
> > support") adds the use of
> > dma_slave_config->peripheral_config/peripheral_size to sdma driver,
> > the client drivers like uart need to initialize the
> > peripheral_config/peripheral_size for sdma, otherwise, the random
> > value of local variable slave_config may cause unexpected
> peripheral_config and make sdma mess up.
> >
>=20
> If this a fix, please add a Fixes: tag. I am not sure it is though, see b=
elow.

Hi Ahmad, thanks for the comments.
I don't think this patch is a fix for a specific commit, so we don't need t=
he Fixes tag.

>=20
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/imx.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> > 522445a8f666..bb8c2a712e94 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1320,6 +1320,8 @@ static int imx_uart_dma_init(struct imx_port
> > *sport)
>=20
> This function starts with
>=20
> struct dma_slave_config slave_config =3D {};
>=20
> >  	slave_config.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> >  	/* one byte less than the watermark level to enable the aging timer
> */
> >  	slave_config.src_maxburst =3D RXTL_DMA - 1;
> > +	slave_config.peripheral_config =3D NULL;
> > +	slave_config.peripheral_size =3D 0;
>=20
> So these are already zero-initialized.

I am not sure actually, I think initialize a struct with {} cannot guarante=
e that all members are initialized to 0, it may depend on the compiler.

Best regards
Sherry

>=20
> >  	ret =3D dmaengine_slave_config(sport->dma_chan_rx, &slave_config);
> >  	if (ret) {
> >  		dev_err(dev, "error in RX dma configuration.\n"); @@ -
> 1346,6
> > +1348,8 @@ static int imx_uart_dma_init(struct imx_port *sport)
> >  	slave_config.dst_addr =3D sport->port.mapbase + URTX0;
> >  	slave_config.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> >  	slave_config.dst_maxburst =3D TXTL_DMA;
> > +	slave_config.peripheral_config =3D NULL;
> > +	slave_config.peripheral_size =3D 0;
>=20
> Not sure if this is required. If preceding dmaengine_slave_config() indee=
d
> makes clearing necessary, you should note that in the commit message.
>=20
