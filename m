Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC404932E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350963AbiASCZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:25:54 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:49667
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238636AbiASCZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:25:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjH84sHkahHVJtbGdITCIgkDuzBuD9MiWUj3If3HSZFTH829aBV+RSTf+vG4TgUT2kgsa5pOT79TQ7EKkU7OPgJSGg89Cf0dGZrBJPQZyU+GhXdQuY12hhH90k5qkpCn96nFptMVROJ4ng4RaQVFwf+3+d0WJgZEZVMiUEk0EXoXh/47sNaw2zp3IsxNN+GJA5lf2pUUXcJtxnvNjczMUyitT2jqUbtDIV47PBZIjKqKxYHtmUrGXrQAppW0QacXv60n9H5sh5zYYtDv3sqPXgh7mpR+ublClnp2nkEWZTXQwelKfMLi/ISR8lHRAjlF+MdzwG2w1qgEdSMHgoI/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUbDiQAKkAKH8/vHypuM7MhKLu5E+o9rPPGfeEX5GEc=;
 b=Iynow4udiVfDPwV1yTmt7zPbZElcLn9SkjkltTLcnKlYDqmkOY8F5WLbucpdIQXxiZT1wquXjsM78EpKfbeIxzbDTZgQcxC8nuMOzIrnohqR1EEr3cN60IL0bJKf4npIDeVC35RW5+4zDIxXoWuMYrK1ij4B8HUykarYTR7EqA/SwoXI1SlXSj9MnLfnPGxiSoVhlLcDir7qfm5ybuENNVfM99tYuBOlpb2nxo/XhhMV8CR47n6qGTkwJWN22conusx2qBgWSQ9ML9kNqlXBJcieErt14axFolFuYO90nEqxmjAbTOzP+eglHd+jeGCWV8KHWYPd+tisBjOY4t154g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUbDiQAKkAKH8/vHypuM7MhKLu5E+o9rPPGfeEX5GEc=;
 b=I0T7LbGS6KslX4Av965tgeX6erJlebAqJgjXVfUEDLxZXYlld4sxAXzlTwIrCK+5q1lAdaEIYEnYb/5ok05yHMMPuka2y50a9itoHwRffJN2J859bkzM+pFcXbCj1nsoFVUDpIL9Vw326+ZtEOPHmlFjkqSrybqo1Cr5uHdYYbg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5045.eurprd04.prod.outlook.com (2603:10a6:20b:12::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 19 Jan
 2022 02:25:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 02:25:48 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/9] remoteproc: imx_rproc: make clk optional
Thread-Topic: [PATCH 5/9] remoteproc: imx_rproc: make clk optional
Thread-Index: AQHYBpwzP9GGJX1tsEmTz0jYXsJFWaxpK0KAgAB+tJA=
Date:   Wed, 19 Jan 2022 02:25:48 +0000
Message-ID: <DU0PR04MB9417B0AC80F41D425F43277C88599@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-8-peng.fan@oss.nxp.com>
 <20220118185019.GG1119324@p14s>
In-Reply-To: <20220118185019.GG1119324@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bff1c1c6-15e2-4fdf-8284-08d9daf30148
x-ms-traffictypediagnostic: AM6PR04MB5045:EE_
x-microsoft-antispam-prvs: <AM6PR04MB5045B6122AAFA11DA199AB1888599@AM6PR04MB5045.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0/VCLvXMfYyCGkE1vBx6M6wmbcz8TzTehLNcE6hVXfUhICLtO3h83PBwULwz+S9xslam4iRPIEIy0zM59mC8/H1TqgCMYrY9tfCCmJ48BsUqbMJ2VQ1Y1E6lnNUHihn+6HFnBZme/2g9PniPYSuGNlqOJ/2BXAPcBZPe9l2yEU7cqLos8jgps4Xa6hSvv2zqpslOyAT3IZuX/Af9UVEXn6nd5T7cDAehbrhsTDi9HuoZJ0DTnsLswUdERASWDwCPb1Hu//UZYv9Ax7L7oNYJZMdlVVdJqVWQAInFnznQ7Yi/3UAys0vl9tvugKFV48HhlwtQ4Nxd0NgocvN8Hj4VE3pfsuJFGUQX2XsWgOl4M7AmjBCdfpHU4Dc0YoIDZWNnRUQINSYNkcsh4+lmRnvTWffGVHKTM/9RCLuMw8NaNqkI5Nr8cdtrJ/lrMEOCp1kS1EtIPHhFn0/JNr2AndJzWTG55GoaoqB4ENNbkhyWqf7rY8rH62+MEWI1eW5OWZwu//rVD8n2fua/lWmTzhhnLSxhhu5Pg4PaxLSk9hMLCbH0w9RFhv7Xnruf9yi71fjtJZ+t5Bhdom3MX/V5wBKF03fzHES4xIAprPxHiDWKjxt+iP64ppzclHgYfmMj81TuZDqsxZFJ+SJ4pWglS+MkmJ4g4qnfyK04ApvpuwEL/HjRB5c3nPDE23WIp69MdI22X99h4kJihshzZIFmHGvew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(66556008)(55016003)(186003)(26005)(122000001)(44832011)(54906003)(66476007)(66946007)(86362001)(64756008)(33656002)(316002)(110136005)(4326008)(76116006)(9686003)(71200400001)(38100700002)(38070700005)(7696005)(83380400001)(2906002)(8676002)(8936002)(5660300002)(508600001)(66446008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tqq4FQRtDFwwNjyZ9VQUKkg7AY3IkDiGfHZ42LuqlDRaDP0LQopynv03aEe0?=
 =?us-ascii?Q?s9y/i7amufJ7mt0T1geS3FHWSZndSN3dgidZZMjWyRX+pMDAPwO9FiUU1OpJ?=
 =?us-ascii?Q?sWq46CzWNKUFSZPfUsH92pgXt20v6OQcof4mwbtBV6vg9vypgh32W+R96Pg2?=
 =?us-ascii?Q?hnEKpbPM/jd3SHHRi9PdV7U7BUTzGY9ue4WYPsT8qcfaDz/Nn1XvmPiQ8n9w?=
 =?us-ascii?Q?9GOgUX0/KT9aoi3zLWACOCxlbGZ9i+9/s03J7vQL8OgFaieLUSPimNQAaq0i?=
 =?us-ascii?Q?oGuy7ghOSwKH4mHyBhzV1W2dEOhnC8zlf7SzHm7nG9Bf/S7w6aw2RRbdOGlI?=
 =?us-ascii?Q?0KSwXytNK9RSmBw5TZNFjZrjeGgiWmSeO3kwP9htaq3oG3t/1cI0RLnrLqQ8?=
 =?us-ascii?Q?iTODpSGewEJaQp5aCyFhh/MqTJNsEo2Kgt3mjJZL+yLXtxMr5X7ZlzePmqWS?=
 =?us-ascii?Q?z5y7HxLhIQe/yZAFQN//Jp/3yIY8yKOWhxQV9VO45iY89PZto6J7fai1T8XM?=
 =?us-ascii?Q?lA2M0kCnRlEFogojGFhWBFBq6Kd3LOUWfHwBdwbPOLmKlgidUpPB+pr99zZX?=
 =?us-ascii?Q?UcaAh3trIXAdpj78+tKornp1q4ZyEiD9/MI+4P0kSMw7hUWtf5mpPX9WA/X7?=
 =?us-ascii?Q?3mh/sa/ZUeKDdMHMtbaDKCDC9o0lIbfmL54V1E2T3tutx/+psDFfd5PMkBOz?=
 =?us-ascii?Q?iXH76AlLZ5aegtahhSCYGFyywNazZjN/D/26sHqyCE3OvrLRtqB2JKBnQPBl?=
 =?us-ascii?Q?vu6mMS0kLEZEn9YOWXqpo8Mlbj3YtBRSiq0Hstz52BB6kJ3FeLfo1/S6XVzK?=
 =?us-ascii?Q?PJqGq6ojq39KUJxW8lGM0WNvfeWxXRDRz7inAZt6zHdAjgtU/4TI/wrf9AyR?=
 =?us-ascii?Q?XtjpKjXICHhPQWf7E3kZeZHcv71KijOU7oqGazhUDZlxKQPsHXHP4olboSFi?=
 =?us-ascii?Q?AndOqPgf9htoVIdK9FfhQOTO+a76XQMl/+vn7GTSap2rJdqSSY0HqjPtltKP?=
 =?us-ascii?Q?HdnQB5dFN8QFQG6EUI6h2txUga7HjrkRFugtou2KeOubGq9FoDol01y6+itU?=
 =?us-ascii?Q?Cp47dNmMaS8TrKULGNTs87e6+AkmhO2hdpKxmDwHRQcqi7ucvf+54vcKH4K5?=
 =?us-ascii?Q?eVAWuRfSar94KEfm7br8CFbFWAeqGUpXKJ0Q2mjif2kc949qWuZNCJ5ky0e4?=
 =?us-ascii?Q?VvRhEV+C7O0s+ARSVCGV7bgVzpF95+O8fyGoy8iAv28PN3eqU9JnBSctCMeO?=
 =?us-ascii?Q?VJW8827R3JssyUdrd1ywPaQXv4KEvI/tY9Wm64KoXXS3s2DlHRi9zlyu47Am?=
 =?us-ascii?Q?318O97CRa2rKInsDUHQETw3sUBXhWs4rk9VNo0bXtTMjQLnvu+YjB8M3IH2I?=
 =?us-ascii?Q?DQsmn2c0pVM+v9c+5MmtZO51vznIPWzkNjdx0tiIPkISXb2RedPUxfhHde9o?=
 =?us-ascii?Q?Hlb9tCVTCXKYwAFUqEbLTktl1VuQmkulGH5iy+Vq3rZ3dFuw+JJVe/+x2ov/?=
 =?us-ascii?Q?ufboJ5fgSp//NjHguImnHbJeCbWmrkc76SPLCsAiyhmJeoj0K1IourG9aaX1?=
 =?us-ascii?Q?YR/ZyqdGp1C2AadLolzpTNaSeKJNdYGy8m4Rv9ueHPkQKcADno1gliSC+zQ2?=
 =?us-ascii?Q?gRYrFagu1ubgw7FxGeBklZk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff1c1c6-15e2-4fdf-8284-08d9daf30148
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 02:25:48.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FU+8M1ABB9mFIfayNMNizSTznOVQvHFVog3Yti2St01YF6UXMy+Pdx+WtqhJU5hkrqcULvJ5CVgmLZFWh1Ojlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 5/9] remoteproc: imx_rproc: make clk optional
>=20
> On Tue, Jan 11, 2022 at 11:33:29AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > To i.MX8QXP/QM/ULP and i.MX7ULP, Mcore maybe out of control of Linux.
> > And in such case, no need clk, so make clk optional with has_clk.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 7b2578177ea8..0e99a3ca6fbc
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -89,6 +89,7 @@ struct imx_rproc {
> >  	struct work_struct		rproc_work;
> >  	struct workqueue_struct		*workqueue;
> >  	void __iomem			*rsc_table;
> > +	bool				has_clk;
>=20
> I am usually weary of bloating structures with flags.  I suggest achievin=
g the
> same functionality with a macro that compares priv->dcfg with the right
> imx_rproc_dcfg structure.

priv->dcfg is some kind fixed settings, however has_clk could be runtime ch=
anged,
because i.MX platform M-core support multiple booting method and it
could work w/o clk handled by Linux depending on some pre-configuration
such as moving M-core in an separate hardware partition.

Thanks,
Peng.=20

>=20
> >  };
> >
> >  static const struct imx_rproc_att imx_rproc_att_imx8mn[] =3D { @@
> > -724,6 +725,9 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv=
)
> >  	if (dcfg->method =3D=3D IMX_RPROC_NONE)
> >  		return 0;
> >
> > +	if (!priv->has_clk)
> > +		return 0;
> > +
> >  	priv->clk =3D devm_clk_get(dev, NULL);
> >  	if (IS_ERR(priv->clk)) {
> >  		dev_err(dev, "Failed to get clock\n"); @@ -768,6 +772,7 @@ static
> > int imx_rproc_probe(struct platform_device *pdev)
> >  	priv->rproc =3D rproc;
> >  	priv->dcfg =3D dcfg;
> >  	priv->dev =3D dev;
> > +	priv->has_clk =3D true;
> >
> >  	dev_set_drvdata(dev, rproc);
> >  	priv->workqueue =3D create_workqueue(dev_name(dev));
> > --
> > 2.25.1
> >
