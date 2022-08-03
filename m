Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CF2588979
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiHCJaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiHCJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:30:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCF3D7;
        Wed,  3 Aug 2022 02:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tute9p6V2qN0ajdgBGsW4BDgaUmHzaSkRwid7600u2yUvnmJ2r89xr/NbL1Zx22idLApFTFCJhtM5/iLWbA+22EI1PFGzIkyTA1/ZChgps45Pdo8NCjTXe3+21yUiW/1k4bRm3yA8fNfdpYS6k+XyFbKMwEZeUtLWua6vaeN8gy5QaTjj0a4Pbm38OVmtB4sBG0x+/zOCfC+c/TNXLYZN9REb+tZuYvfExdA3px9bHhypvtzDDYn02KLcY/l4pkdq2Dj5vWsS9wlmgtaJwtJvk1dgRJpybqbf9CaifcZ+HgqaRoexqvMgMcv1gYdu0Kfpn3AJsaV1RKwpDmENzw65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkEanUJqxQluhRSmVsj7wcnQexEOXGUJLSXh64llt0I=;
 b=SiPpoAkC+nCQ2naEFmHiarXrcyHtm3I1B2X94xCFrjWG8t30pYi0QlNVpAu10PLoluS8xxAMULZWW1SsBK1R5kRyo/1Z2gRwkWSIIDin3L4oBb7mhNjNQxf1Uun2UTkxdstSDxXYkOJq0nOdfVe+5pRcdziwLPj/nfeaVPjND1bFNTHPzxemDgKn2nHHnhe278l8Cjizts1/j/gM7JrLIQhyH195XWIsKt2HYGus1wLtLMckbe9Cx7UhyQiLhKI+ZOcMSENaZNAPZRj6lIXYI+GBiKAurLuCWlKEfj+XwZFv2qw/lrhkPnR957/iFqTGd3t9twl8RsbKEUVe54f3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkEanUJqxQluhRSmVsj7wcnQexEOXGUJLSXh64llt0I=;
 b=k9VkWxSv/CQanzSV7BTMFXEnduBUhblxRWvqjyQka6lJam+sWy0gpk//RI74ViUK47NdeuHl+q4qqa767724cwuVqONSvtxVsx/ZM2LCvBj2/aXgYrzNR/whF4c+FwJ6ZA7b1KQEvXrnMKDqDdlGBQ3P+4IGi0fBf2A832lwxuE=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM8PR04MB8049.eurprd04.prod.outlook.com (2603:10a6:20b:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 09:30:08 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c%8]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 09:30:08 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
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
Thread-Index: AQHYpwbfzk8jOQKslUeCbcTMT1rdmq2c1H2AgAANtbCAAATigIAAARNg
Date:   Wed, 3 Aug 2022 09:30:08 +0000
Message-ID: <AS8PR04MB8404A5B048997AEA0BDBBCA2929C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220803065737.14752-1-sherry.sun@nxp.com>
 <d4838245-030c-39b4-df4b-17b3b4c73a5b@pengutronix.de>
 <AS8PR04MB8404990740869737F326D302929C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <Yuo+W2HhOLxnQpf+@kroah.com>
In-Reply-To: <Yuo+W2HhOLxnQpf+@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c126c4e-174c-41fa-092a-08da7532c19f
x-ms-traffictypediagnostic: AM8PR04MB8049:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: baA82ULROXrNwtibNO7LYzGs9MSWbg5Xg/EKp9o3hM8RxiiHOk4QUopZYV/VvipM/t8FWPCcJcuf1xBhgj7O0joRLZYlBwZj+gjU9wlpFpfN8HCqsHfTQi/4ka7N9l0ieAMHaj91INFyp9fS5/m95A8VH4prk7gXFfC2dlurPlWJAMMHN6I52c6lZNGl4eT5GlVgmav6US7cBFbKmAg2UP59+0ek4O0t1Vv/X4iC+F4L1oVv6o3tnIebVFrMJJTSPtigKSrOL1qV/hnXUM1n7KlfJJ8D70sIMLARA8BWsz1QNaH/A8foPAcXYfrcB+65gatkPGS79OH7t1AJRNH/RLC51GtNXSaSAbb1tDzYjtaxJiCvYwTs41EJznckNNgmqHZ4ypCic09IgEFGHXPd6SYH4QI3m6zWxSbs+x85q/ceBIvE2SQL3Td6ctvokMK3SNszaLuPi5dNujR2bcLc6ND+wZiw1MQzpqTQ//toZrUdeyTlbQa7lbNoIupUeK3Su40HIYayiFyKkz6KfIcayY0IpppxRA9ZsMJ4n8jYiXsYAlS9+x0PggVrGltwfafhhKswNSP4CkiNFgwnsk1kI4E7sz3tCUf+SDlNBKGD+V/Dx9XTR0wiF2XxSW8EPvKfkeanQZtXOKPyqlvnn5bCpq5+F2xYaxRosIW9rayy8H3bAi9VPXqBqtc0cMuiOIU+IBYZQBfpa1VUxR1qDdYznRqpvGujM6a48KMS96JraIpkP5d+h46Vlyz71BTNog74BX71H9vLhNPquJhJpxcjSW6GfAfBBmzHB4IubQyqV9J4rL6q5sGmze7lMf4CLOBx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(54906003)(38070700005)(6916009)(478600001)(4326008)(66446008)(66556008)(76116006)(66476007)(71200400001)(8676002)(66946007)(64756008)(316002)(83380400001)(26005)(9686003)(122000001)(186003)(41300700001)(38100700002)(53546011)(7696005)(6506007)(5660300002)(2906002)(55016003)(33656002)(44832011)(86362001)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5z7jQXjfEOVL3QJEWVnZADn8tj5c8Mkvm3ob9yhHtsLHKpIxAXFQ32+IF3Hi?=
 =?us-ascii?Q?/A6WbZPOrYdfrkO8BUk40ypyQ10BE+VLzJW7SssBWjGStcHUd3mbhdrSWBuu?=
 =?us-ascii?Q?B2gbztcL05BVxcw7zPYwu3JcrLceWyj+1UFR3lgVU5c/z2abI53s1tu/eAbq?=
 =?us-ascii?Q?SQ4BDYNhhUpkZ8xSX8PPNr3LhlxFLGcRPJmqeOu7YY80T0xlXVSYfy1FWqjI?=
 =?us-ascii?Q?5KU/yWDC7rJcDBy4FIrXAy7QCYkShQZlWFzRZoY28/GMbZroCSu57y0+m2Q/?=
 =?us-ascii?Q?dxRqSKTQaOeAF8iHGDK1ChuSK6TbFytBSblGNOcn3LrM5dsxsovO/x0fs8Rb?=
 =?us-ascii?Q?rGKzuhbmCxnBOTnUTQ3MTmZig121oYKEH6gTD4BIkV8ZFVmWAAhVl2WuvlFb?=
 =?us-ascii?Q?pr0me8Wnx8rRI8Tyubz0YiCcAninUTLsJfeLMQmbfALqV7Nu/LaXQKgVDyIa?=
 =?us-ascii?Q?9XhWlrLuJN3S6IbCO/dWKJXF7dqoPHgaKY7IZJyGiCDFstLlYIfZBcj1Zgk0?=
 =?us-ascii?Q?qsg/ddljxiaubW5atZ6SFryFFBmPhm6xFNgTMVdSdbiYYVn2S7Fb161Osa0Y?=
 =?us-ascii?Q?9WN3lPk5iQdk3Fia2V0EAo00StUERaqDZ/cppBKB119u87appOtLdNhvdryT?=
 =?us-ascii?Q?/NKoRS7bMrDzMeJoZMkrDhM3nId5j09cWOoRuKL7/SRgg7dPOYm4pMt1Q7n+?=
 =?us-ascii?Q?Zxgb+4u/gCBmFeBsLFXiJC+ZE1vnjqlRC/8CZOnpiHUrcVPOBOF3D1rz33wS?=
 =?us-ascii?Q?K7w+o0VAzkGOy06ytPbB2Wg10FwliPQ7zYorQhyxetgXHLuxKdEQY7wLo3UO?=
 =?us-ascii?Q?hhA+tB2qULxpRSIuoHwM22leQN7/nvGeK/AsoAFx0n9xjOZfp0ID5CUZ7mwn?=
 =?us-ascii?Q?p0QYj898YSNGZSnNVAyPemJqhFY6lh6qWF24vjbvqM6MAdebKElnSwO4hZ6w?=
 =?us-ascii?Q?k+Rjh3l2n8conh7E03cjpgF7iErO3RH0uyy9s8AW1pFw9nsHy4mqfnFWs10z?=
 =?us-ascii?Q?+Qp3VAplOziR4OsfW7YsxnJavMwd0zVm0bHOpEy/+C9Gwh1UEivPf87fax/P?=
 =?us-ascii?Q?Za+k5rEyPE2l6piMF/ocLJmC/e3bAA7eRtC1QE07HE5vE4t7HQTtMQzcv0kt?=
 =?us-ascii?Q?nDQPGCg2m5gHuaDVN9zpGHumLiLXo6P58vAvCe7NYCbtAbj3bozdQt+w0czP?=
 =?us-ascii?Q?iOiKdSELaMKX/SqgQYVmlaeo6qBeWUmRoGoYAD0hFZg4yLpg83gWY7nzhhxL?=
 =?us-ascii?Q?gye3liOSfZN/ZLmRA9sP238RWQu8Fs82D13dLD+CGqkIXXDOj6TNuIPeILU2?=
 =?us-ascii?Q?udfIWvbbR/AQzg0k0d2ZHLXN5go9C+UD9Yzw+MWjwtpGnWr0dDZrZwf7u8Rw?=
 =?us-ascii?Q?jRh3MtiYOoi4NTFhvqb6aharTvweuwlg1+3xe+O0P9hBHYB3eiIUrNnnzkW6?=
 =?us-ascii?Q?PrKW0kRog9xoHnrCT9YBK+IWBP4f7QZvd21dh4N0J7pce8avbDD/k5qUCPCT?=
 =?us-ascii?Q?ImJkv6lF192KVpfW3oR56sqDlDEsJdHwmyKG6IB5KtqffzDi1zfpm/i+juFw?=
 =?us-ascii?Q?O5yHvOLovsr7Y8HF6ViC5sdhoLMbC6716bOzFGWX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c126c4e-174c-41fa-092a-08da7532c19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 09:30:08.2961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mD1XIXZ3UGzG91tV41YbI8chcRnQUWtTTZAoursUMs963DirXSFzHMkZUz8XRW4fW8KMbWV6bKBMo7NI8WOM0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
> > I am not sure actually, I think initialize a struct with {} cannot guar=
antee that
> all members are initialized to 0, it may depend on the compiler.
>=20
> Not true, it's part of the C standard somewhere...
>

Hi Greg, okay, thanks for the confirmation!
Then I think this patch is not needed any more. ^_^

Best regards
Sherry
