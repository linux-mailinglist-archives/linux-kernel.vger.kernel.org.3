Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F755F2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiF2BTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2BTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:19:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8708227FC5;
        Tue, 28 Jun 2022 18:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYPf7aZN9Y2CxXjq9EBmHhkohDsuI6f3tOw1OOGNJZbza6c9Q5ZGSp4hFjakEdQddGv0C8bSr8fiCxUBR1Z9mGtBbTtLvoEmDOk6XF2CyO3FjnBawoph+X11Sh9L/eo/3n/ftbx1wmdPSoWdnzk73O2pvf7BUQfz+SZYyugSr30Wp1hZzlVUZKmczytBpwMH5RP/sobMIOn9JfQQUKa5k923ffOeaFQXu3W7Bx4HUeOIcs4QER127x+7ZgTRAA+65bNrv6dVON2Jy/0pvDeM1Ar9Y2wtP2lwYeqQankHwDairJiLUymc7aoQlWjJFgPwkzAf0RW3AElVozd1n9cH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o3VfQMbZ4J8K6b5zExH7ywJ0tr+S3KzMnuoAGJsCi8=;
 b=Yxm0NyiLt1FoZiQ4A1dnrMiGxFLw4/n/UWlsSWcVO4g703ACQgOuMBwb35+aRLVQvwTxMUnkKnd8wheLslJEmPSolqS+ZuyS9lnQG0XRi0IOepNh7xglbLXbTGtTHirO0YVtuZvHaWy1dKLUzdsYtjq65h/mEcEuYyNNlduLmxPUEIuOv6RXfZrp0ioNFMTOHqfqElzz3MVwSm3i+wI+EYu5gW9PUQiHEreegcuMk70jYYuC6iEXhaeIZci2qIQIyoRflaiEypzv7LXTLaa6QI1Ov1r+ZLol4UB1lOnD+zw4hi8LUFB8MIwn6WVIAwYI8pe11XfE06kIM5RqO0zW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o3VfQMbZ4J8K6b5zExH7ywJ0tr+S3KzMnuoAGJsCi8=;
 b=iY+ZIx7MSsExCdNKPrGonopUT02RtrGnq9UygH/0xe38zPfs2h1CyKHcrs0pLeSi/dv72XpeFQf3XfEXeWhFBlMWMwp4OyaMmt0rmnltJdEvCCGsyO6TpHoZfCYeMeaZutfeVaEf5oCKxTEHh1z+Yi0dpLONZTFO099uow8MNbo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7359.eurprd04.prod.outlook.com (2603:10a6:800:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 01:19:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 01:19:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 5/6] remoteproc: imx_rproc: support i.MX8QM
Thread-Topic: [PATCH V3 5/6] remoteproc: imx_rproc: support i.MX8QM
Thread-Index: AQHYaboUibatUS8jaUCM9p1WPWa0B61lXyOAgAB3BBA=
Date:   Wed, 29 Jun 2022 01:19:36 +0000
Message-ID: <DU0PR04MB94172F057A00F55C2E53046088BB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
 <20220517064937.4033441-6-peng.fan@oss.nxp.com>
 <20220628180257.GD1942439@p14s>
In-Reply-To: <20220628180257.GD1942439@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee6adf74-ab92-4bfe-a490-08da596d6e8a
x-ms-traffictypediagnostic: VE1PR04MB7359:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUVHL1eYkLgINx8h9KZpkbOO11nrv2QQBKbUwMVg00vE/g2G3cLD4coWIvG3gZ1uWEoks9gY1LGyXsiIwlYM83wLEZjVTcO64+q3zDYi1yBbc1oflbKgEwqCP96pnUfrdCatM+8Jn6Gn20XvuDhVpbikmaneCyY+fMODlcVg3cnwOhXRO2BE0MF9+NmY2NWRJB4GZrS3ih82JsSTpbFY0jTU8bnX+kO7W+BHyX8bf3QxNSBMlUpVZRCTPjxNH7YaziIJwEpFpym/uSwNHHvUJtFdDon92AvyJHniX+Diy6mGxRZf7s8Vsa69zhYtL5DLA0/A1jmP1wNCEEUmcrND7Xo45cwwhSFZN2A3veG2Yr82fdWKqigkqOBuIF9DCmSq9Erp/+QE1I+FiehWkoSHhqv3Cn8yppOu2jb5RX1IgFrHy6ZT6/4TwL0pnOAbvBZiJG5sMktO2DGYugKHnELqbhkJljWA7Nea8Pq8sjFPPueS7tTisXMxpr3A52e2zU6ZlY+dbf8/2ukOUn1pO6ZYxY+cEKTeaUO/8wRi6fh0DQykC/1sJbyJ3gD7pok06NouBI7uH0uPv0AQyW0BKUj9PZmILMXmMow3kaVsz/LMQ/kAh5NI63mAQ27yo3Yo9imrenxjwfnMtEf7wwQ6lOBE6g/JaIJyo1mOvPysI/XW4uv8HE/kuw4z9pkUidJeQOAwxiY5sQO+sPHCEKNLxRDC8wNE6nml68DQkZ5YzrynumMCFbaeQFtO8bFw7UHqtcVKaLz8Lyn5auLXiGKSpwZip+r0BaNyScBFXE0N/wbZE3Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(7696005)(478600001)(66476007)(5660300002)(55016003)(66446008)(52536014)(110136005)(9686003)(76116006)(4326008)(41300700001)(7416002)(66946007)(186003)(38100700002)(6506007)(66556008)(8676002)(26005)(64756008)(54906003)(71200400001)(38070700005)(8936002)(316002)(122000001)(2906002)(33656002)(86362001)(44832011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OkN7s3XguPafaCfkY6SzwMO5jMxLjXORkExyRoi7q3VENtbvPeci3SPsoVtf?=
 =?us-ascii?Q?a+jmpoJOo+aoVRG84ubKTSAyTZ6XDRYGGZHS9z3/1fdXYszEf/g5zi/uMlpU?=
 =?us-ascii?Q?TEEZu2bXeT5kq2D3PinNnvQT11ch5nUq8mnU/EiMOhTwFBJsdplely2YqbPj?=
 =?us-ascii?Q?Fy6KHjxgR1Tr00fvN4498P3RZnMz0JRKD7MZVcZz2v9P3qvErQvK+UgjWHJQ?=
 =?us-ascii?Q?CSLevEZMx+l/Bsue+WmRleVZQMSJIp5AdrdkfH90hzQ6rj/uKJioYQM45Al0?=
 =?us-ascii?Q?9C/Y6/u9Gl4kkHYhgfSOTa9+F4WtMeT+w10yZtsWjKY345AgYXcvJQfsycs8?=
 =?us-ascii?Q?LhhplC0N2CFbus3cE5jPAyrl7ZJg/0BqutXxAf2sKIaRLqEfE51UJVFTJD65?=
 =?us-ascii?Q?E0AYuXlDK3kms4ZVwzW6jhfRnVg8BXl81nBn9fhP98Jp6vbfc6/vqkSk0INb?=
 =?us-ascii?Q?t6Ph+Fth/opGBaN1GvIzy5TsREw39ibIvo/5UZ1pguguM+fU7PVsvri0dQ6t?=
 =?us-ascii?Q?UrZAqnvIfps9vk/Pn+tIYgxCjdp/y0bykVJw/S3iz5WJ1BoFjF5cUGbt6ZLK?=
 =?us-ascii?Q?40z/45cqz9Th2zwxBdbeVwvun9i39zepC31nvkxqIVUnhFjoowPbkB7FN25l?=
 =?us-ascii?Q?x3W5e3ueliLNQc8r7qsSL0oxg3eFmjXX6WF/PwgEi44kXurnHkxGMxN2YAFz?=
 =?us-ascii?Q?cqhfHusMiQjeNNohDB8HgF/AFrhw5rlboH6nm5MeC/4K/4IDVD2rovlSCdTz?=
 =?us-ascii?Q?DNUJtAZZ3YPYFB5jca2IadVLD9mZ1GZpXj//KEktdiujigJCvJb82+xf18lT?=
 =?us-ascii?Q?5hG0CrtnAlX93K18OS9nl2i2Qqu98/7VHaGfMW8+ja3A/M+zJ4y7D/6hPTzx?=
 =?us-ascii?Q?D61ppIsd3eZCbsGu/yXIoqn6KtIkT6dGCvyriELoB2RqZQwskCv1AYliifLO?=
 =?us-ascii?Q?BNCAqO6VbCVmfpUmQ9qtqbh+PXg4E5v0UcCMi7Y81gFFWHqQk+PUSvxXgCvi?=
 =?us-ascii?Q?SNS88bQUYg/UR1jD6fnnXBF0ctK7TIlhFh2prEcYdhlfq5OYPiXtiTFJl07k?=
 =?us-ascii?Q?UVFpkoEgvtezkbVogn6t9hjCIvhPmrQmh0Ijt90CtQJwEsZYuH//mUO0qHiH?=
 =?us-ascii?Q?M1Wh8NGnER9T6NvPnZH/y1cp/HE+jHulB09TjnUTB/PNzjQ0sWsuFB4M+Wtg?=
 =?us-ascii?Q?AsBzPJEpzOPTcy4IXGd+ugK+GTw8dsNIU+4bAMZJ67J++tIjQXCLVQNJmUiU?=
 =?us-ascii?Q?DC4WVnXpQpotfRRl9G9LCq478bahib6VCxqSzmRhPaqSkPmFvM7Om9BkKNad?=
 =?us-ascii?Q?uU07GYgIxJEal/bxTvJ8YCJSqg2SQa88ViFsRxkGJR+J/7OQkRa/ZMM5ja3v?=
 =?us-ascii?Q?hclnY2GEVsHG9RqMbdDBDroAaVvoQgVZtAYqSJHKA26EppODHuo6yU99YFeQ?=
 =?us-ascii?Q?AtaI3PytqmsI21HI1RiaE4w9CUT7PUocVkAcuEfdlE7rI0HZ/rP4Oe/VXLvQ?=
 =?us-ascii?Q?514tAMpcoA5Yk/UWTGOK9agkj08uHfc222+PLJ6m5t7PaWRAJjMSRa9JTf0L?=
 =?us-ascii?Q?cjbTYy7UH4953aWSoAQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6adf74-ab92-4bfe-a490-08da596d6e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 01:19:36.6920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ITHsU9j+ny1+IKJmZfNAMLidI8xi8b44V7bcrjKo6WxaEBTIcfjvBQ8VJNOKc7OayiuwIQQOHUHut+lNuDX1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3 5/6] remoteproc: imx_rproc: support i.MX8QM
>=20
> On Tue, May 17, 2022 at 02:49:36PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Most logic are same as i.MX8QXP, but i.MX8QM has two general purpose
> > M4 cores, the two cores runs independently and they has different
> > resource id, different start address from SCFW view.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 41
> > +++++++++++++++++++++++++++++++---
> >  1 file changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 49cce9dd55c7..8326193c13d6
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (c) 2017 Pengutronix, Oleksij Rempel
> <kernel@pengutronix.de>
> >   */
> >
> > +#include <dt-bindings/firmware/imx/rsrc.h>
> >  #include <linux/arm-smccc.h>
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > @@ -75,10 +76,13 @@ struct imx_rproc_mem {
> >  	size_t size;
> >  };
> >
> > -/* att flags */
> > +/* att flags: lower 16 bits specifying core, higher 16 bits for flags
> > +*/
> >  /* M4 own area. Can be mapped at probe */
> > -#define ATT_OWN		BIT(1)
> > -#define ATT_IOMEM	BIT(2)
> > +#define ATT_OWN         BIT(31)
> > +#define ATT_IOMEM       BIT(30)
> > +
> > +#define ATT_CORE_MASK   0xffff
> > +#define ATT_CORE(I)     BIT((I))
> >
> >  struct imx_rproc {
> >  	struct device			*dev;
> > @@ -99,6 +103,7 @@ struct imx_rproc {
> >  	u32				rsrc_id;	/* resource id */
> >  	u32				entry;		/* cpu start address */
> >  	int                             num_pd;
> > +	u32				core_index;
> >  	struct device                   **pd_dev;
> >  	struct device_link              **pd_dev_link;
> >  };
> > @@ -129,6 +134,19 @@ static const struct imx_rproc_att
> imx_rproc_att_imx93[] =3D {
> >  	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },  };
> >
> > +static const struct imx_rproc_att imx_rproc_att_imx8qm[] =3D {
> > +	/* dev addr , sys addr  , size      , flags */
> > +	{ 0x08000000, 0x08000000, 0x10000000, 0},
> > +	/* TCML */
> > +	{ 0x1FFE0000, 0x34FE0000, 0x00020000, ATT_OWN | ATT_IOMEM |
> ATT_CORE(0)},
> > +	{ 0x1FFE0000, 0x38FE0000, 0x00020000, ATT_OWN | ATT_IOMEM |
> ATT_CORE(1)},
> > +	/* TCMU */
> > +	{ 0x20000000, 0x35000000, 0x00020000, ATT_OWN | ATT_IOMEM |
> ATT_CORE(0)},
> > +	{ 0x20000000, 0x39000000, 0x00020000, ATT_OWN | ATT_IOMEM |
> ATT_CORE(1)},
> > +	/* DDR (Data) */
> > +	{ 0x80000000, 0x80000000, 0x60000000, 0 }, };
> > +
> >  static const struct imx_rproc_att imx_rproc_att_imx8qxp[] =3D {
> >  	{ 0x08000000, 0x08000000, 0x10000000, 0 },
> >  	/* TCML/U */
> > @@ -279,6 +297,12 @@ static const struct imx_rproc_dcfg
> imx_rproc_cfg_imx8mq =3D {
> >  	.method		=3D IMX_RPROC_MMIO,
> >  };
> >
> > +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qm =3D {
> > +	.att            =3D imx_rproc_att_imx8qm,
> > +	.att_size       =3D ARRAY_SIZE(imx_rproc_att_imx8qm),
> > +	.method         =3D IMX_RPROC_SCU_API,
> > +};
> > +
> >  static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp =3D {
> >  	.att		=3D imx_rproc_att_imx8qxp,
> >  	.att_size	=3D ARRAY_SIZE(imx_rproc_att_imx8qxp),
> > @@ -395,6 +419,11 @@ static int imx_rproc_da_to_sys(struct imx_rproc
> *priv, u64 da,
> >  	for (i =3D 0; i < dcfg->att_size; i++) {
> >  		const struct imx_rproc_att *att =3D &dcfg->att[i];
> >
> > +		if (att->flags & ATT_CORE_MASK) {
> > +			if (!((BIT(priv->core_index)) & (att->flags & ATT_CORE_MASK)))
> > +				continue;
> > +		}
>=20
> This is very cryptic - I just spent 20 minutes looking at it and I'm stil=
l not sure I
> got the full meaning.  Please add enough comments to make things obvious
> on first read.

There are two generic M4 cores in i.MX8QM, so core_index is 0 for M4_0,
and 1 for M4_1.

In the memory mapping array:
        { 0x1FFE0000, 0x34FE0000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_COR=
E(0)},                  =20
        { 0x1FFE0000, 0x38FE0000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_COR=
E(1)},                  =20
        /* TCMU */                                                         =
                        =20
        { 0x20000000, 0x35000000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_COR=
E(0)},                  =20
        { 0x20000000, 0x39000000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_COR=
E(1)},

ATT_CORE(0) means it is for M4_0, ATT_CORE(1) for M4_1.

Back to this piece code:
                if (att->flags & ATT_CORE_MASK) {                          =
                        =20
                        if (!((BIT(priv->core_index)) & (att->flags & ATT_C=
ORE_MASK)))             =20
                                continue;                                  =
                        =20
                }

Taking M4_1 for example, priv->core_index is 1. So when it need translate a=
n address with
ATT_CORE(X) flag, it should ignore ATT_CORE(0) entries. Hope this is clear.=
 For adding
comments, how do you think:

/* Bypass the entries that not belong to the current remote core */

Thanks,
Peng.

>=20
> I am done reviewing this patchset.
>=20
> Thanks,
> Mathieu
>=20
>=20
> > +
> >  		if (da >=3D att->da && da + len < att->da + att->size) {
> >  			unsigned int offset =3D da - att->da;
> >
> > @@ -815,6 +844,11 @@ static int imx_rproc_detect_mode(struct
> imx_rproc *priv)
> >  			return ret;
> >  		}
> >
> > +		if (priv->rsrc_id =3D=3D IMX_SC_R_M4_1_PID0)
> > +			priv->core_index =3D 1;
> > +		else
> > +			priv->core_index =3D 0;
> > +
> >  		/*
> >  		 * If Mcore resource is not owned by Acore partition, It is kicked b=
y
> ROM,
> >  		 * and Linux could only do IPC with Mcore and nothing else.
> > @@ -1008,6 +1042,7 @@ static const struct of_device_id
> imx_rproc_of_match[] =3D {
> >  	{ .compatible =3D "fsl,imx8mn-cm7", .data =3D &imx_rproc_cfg_imx8mn }=
,
> >  	{ .compatible =3D "fsl,imx8mp-cm7", .data =3D &imx_rproc_cfg_imx8mn }=
,
> >  	{ .compatible =3D "fsl,imx8qxp-cm4", .data =3D &imx_rproc_cfg_imx8qxp=
 },
> > +	{ .compatible =3D "fsl,imx8qm-cm4", .data =3D &imx_rproc_cfg_imx8qm }=
,
> >  	{ .compatible =3D "fsl,imx8ulp-cm33", .data =3D &imx_rproc_cfg_imx8ul=
p },
> >  	{ .compatible =3D "fsl,imx93-cm33", .data =3D &imx_rproc_cfg_imx93 },
> >  	{},
> > --
> > 2.25.1
> >
