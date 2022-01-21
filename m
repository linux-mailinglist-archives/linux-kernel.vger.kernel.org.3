Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D79495782
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348184AbiAUBAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:00:08 -0500
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:23461
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347998AbiAUBAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:00:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqGHUWbJw49Pz0lPr8Mr2/E85VJEGKSKAkeiBpKV++DpFtoaQbSAV+yZoquFAZciUILXAs5WUSq4f4ofhsb0u3vynoNk7N2G0DhSeo48nPO4swQEbs8qKRGTKulyOm8kUiu9fiAlKLnarAe1XGPpxuvWsS9zCFfQfy3u0grwfByHNJ3lwGPn/4i+JR19WFrKBhnFMrcApPq1kYYUpg6WujoIqa4GEU5ehejxexpbs6n12xfBZFp1E/nnD/1hhf1l6N4PXJcHszIyUAaBJ3jD9cxozQh7/bL/pNv0woSq6vwI7wY+yEe2ht2QVjgjLnMYOE0xiHlIyItUfJzkiZrHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1axhYqNd6Li9/TCHAkmCceeakD3wuCg4kVc3trFsNRI=;
 b=hZAFQpEKHmKJxzFpZtc5PGqTWb0whfhnsv9R/q2zjuGpK54Znqr/U8V44iG77O/7RI68IYXK8Wf0yJhJfZE9ztwz6wFW2+CuRMbCKyR4DVO/2KUVKTAZf2mpC3ihbQ7TAt5FVWVDOrunqnDqlIJ/BWwwbL3ctLDLadMWOaprZ/lzAKvNgLZTMj2D5lx/W6ospUBBeuQ0kmTOWzHjheibE9TEwL7drlutRbfmGnI7hY5xTskFmC3/LGXCrDOLxlQ7I79mL+FTU316ZjZpi9J5jmgx18hHfa2zGZ/WIqnpx+iV9QnbTHrImnRhNBcnS9gobDIpQrktYSQ8piBW/GRVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1axhYqNd6Li9/TCHAkmCceeakD3wuCg4kVc3trFsNRI=;
 b=gvfe87XxX5ipgSvXaSacNFbvtIdvBVu4TaFu3wxwf/AyFeUqmPOL6v9SaY/Kne19l2SuMlsALUzcCnUloG+sCyxjHeSjhJNsmJgyCOd7x3qgBeI2N8pku1C327Op2AjVCLIbCXQn4a6mMqXO3eSfdFhQW0KKtbVUnkO/cLQ5AkE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8887.eurprd04.prod.outlook.com (2603:10a6:10:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Fri, 21 Jan
 2022 01:00:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 01:00:04 +0000
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
Subject: RE: [PATCH 8/9] remoteproc: imx_rproc: support i.MX8QM
Thread-Topic: [PATCH 8/9] remoteproc: imx_rproc: support i.MX8QM
Thread-Index: AQHYBpw5G5lZZQaOC0qLUf7nnokL+qxsN7mAgAB+hlA=
Date:   Fri, 21 Jan 2022 01:00:04 +0000
Message-ID: <DU0PR04MB94171209E7B16B8FF31099DB885B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-11-peng.fan@oss.nxp.com>
 <20220120172343.GA1338735@p14s>
In-Reply-To: <20220120172343.GA1338735@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32d0375c-15ea-4c92-83a1-08d9dc795c36
x-ms-traffictypediagnostic: DU2PR04MB8887:EE_
x-microsoft-antispam-prvs: <DU2PR04MB8887BC41FEC6F5A5FAFAAF61885B9@DU2PR04MB8887.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bI0qPnV9D/LQExtdXWpQfpkc3Vhet7pcmW6iAbrenk45rDtD19PfyjiDSgud03rHhA5QQ/IR3dW3WciRo8DadUzq9sTRFpN/Sf/EiUoAodyd9w4M9E7bfkVPMQeeKPgkc353G8PHe69r6kDuYN1IM2jGF7PFUmNWHLP0UAakbootEsno6cJv2uICKG1d65H5N1iIXgutGbg8DsgesqlFmx+7vaGAFIKboN8Bw8pfR36q9FQM8mKN6xSUfKkhVyQkqT0NAgpsTvTbBEfASdKDtdu/+j6mxpYjUhpezo7dRLpywOcxn4uaRfrjpl0Eo8K1D2V/fptGAPjFCpq4FrgdrozZbEntk7UEu9LrGXwIWG0BgXpAJvbJhyBpxSgKPbh8r5Wt78BnlbmvXM6hBN2MmvSD4L/Q0RmyKDnpU12dMBSGp+sDEKEnkQbE70oM4kLNElW0MotkkFCL0FaPFz87KI+ZcMpMCyK+pOXdCMPXCWSumQIwX4ZMdSpG9jr1mKI6c8wuysnCq348GAT4r180dvqcKViH8WVpSs8qM2Pqr2GztRYeqwzH9UaIzOjbBY7K/2insEs9O1g6kJmvLPHW45rvQtfDWbMYtYE8ryUDQVAZQfYxwuQm4ZqKv63mNZuZu0JYd1eujWEIUq/I6fq0DDi2viWNzrdjVf7xUzCCnxNejIRklcVm/sL6bm5NpRbisMxTN0oZUaSIJeGIx2I/ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(26005)(76116006)(66446008)(64756008)(66476007)(66946007)(6506007)(2906002)(4326008)(7696005)(83380400001)(38070700005)(71200400001)(66556008)(38100700002)(86362001)(54906003)(9686003)(186003)(122000001)(8676002)(52536014)(316002)(33656002)(508600001)(55016003)(5660300002)(8936002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5z4wkY/AT8PCScQ1/iv8fAEJeKXPMerwmvs0+4+4J3UClFeY2+JGlbig4XIf?=
 =?us-ascii?Q?lhMqn2WIAEWcjplRgdCR0RrP7l3y74mSprvaryDhh6C0iCDRRFvyDgE+I71J?=
 =?us-ascii?Q?qii+i+XpEU/vz//8DCVjRZ9+AyYsL83phZZhQ2blzbYpPDy/SBgp8e9K+BiC?=
 =?us-ascii?Q?Te9quxAEIaPf/jd6n+cxvVQr8QIdAct09yb1F4vwA5xksxLhEpaSlSU6AvQk?=
 =?us-ascii?Q?xzL9ZqW7EMZKjViZd1MC1XY0EM2eqNHoW8cox0U2Qo4BK953U3UyG3IZeYWl?=
 =?us-ascii?Q?dbjkqa/00gtlmA1VtjRjP9UbZAPz1RMTebFfe4JuV6a9oJJjc0mTpsgsc0su?=
 =?us-ascii?Q?4ZM7GqqgFq9J5A5rMV+NPReouWaq3xzZrfyrMUPo7Um8Mo/iJzDokkQw+7nt?=
 =?us-ascii?Q?lakIC2RtxB6uGXmJ6TnS7r6hjIm2mbvbowWw479qUyGltBCSI/slPvq8y6NH?=
 =?us-ascii?Q?GxfTUrSzDzXQFQsoWH8DhNPZnE7n5hi4/z7dwrTCQlHxoa6FxjRH2i5cKimq?=
 =?us-ascii?Q?8SHg9ckX9nbzevo+W1B0sFhDXo2Ll2UPESdkkoerSGTVzgQ9xT61P7LQ7O+r?=
 =?us-ascii?Q?bqZd6ZBZObHObUWrxmrJiBrIXHXocaf5Ghnsmm6npgDk+abxQOvAjBZoE1dk?=
 =?us-ascii?Q?7NEL8qCuzVYxw4PbLcxY5oq93gM2cy9DD6suD+G7+MyuFwnIne2Ly4YeE6sA?=
 =?us-ascii?Q?0zWrMFv0r0rvwRfws7XIS6ZvrfTt8G/1nYDJas2Ls6IgysTlnqeoOfbVw4cW?=
 =?us-ascii?Q?xNW/6Q2frwei8C+hottDQgCuaSSKwO+60zsakTJLvd/wrpL7PidYSwPDS7pq?=
 =?us-ascii?Q?ESE5LbEJf4R8CJ6+QtnAraWYoE4rD3xS5nW2Rg4WpvDIxkeVuS+XM0nPnz9X?=
 =?us-ascii?Q?APq4MisrHK4xyeoC12mfXr0IAc+QUdI+QGhyCbFUp3SdZnJfb+z93+me9L+B?=
 =?us-ascii?Q?yj+Knv1mepvIKh6/U97nJKgZHXM5+RoztNUxZBj651IgWOhG/6W9TD44QZvm?=
 =?us-ascii?Q?vcxndlgyyEJFuDMn12EaUItnjEp7PvrC70RSmdEKYL7Zih/NKXWCgbz8eJX0?=
 =?us-ascii?Q?p7fJ+rrIHTkaGACxl1iUtXJTsHgFoVtGK9mMOql9nQELnM0zXXBUJv+l5Pyt?=
 =?us-ascii?Q?GEFlHu8j7YuWsnKiihfJKyYkiTLU38m+xRM4Po+OOTzkMecsfRDlhB4iqXHf?=
 =?us-ascii?Q?Qw02Ta1CJoo4Pt8StTBDoMpjAxaRPnyB8G8w3fFlkMXjp5fZ5F/XTrK/quvA?=
 =?us-ascii?Q?QcRiy6zZjW3wrnxffL9VkSt//K32gGEezdpf1Wf/U9OjgKVJuylhVE2pjFEi?=
 =?us-ascii?Q?6nWW098dOzwuzJCEtxOhlbO5AmmrBcfm+JxB/RCYgFeyQMhHxT4V1NOroYMg?=
 =?us-ascii?Q?olKpZvWi407C0YoswAA6G47XwHnE9vat0WTEq0xwlfh6TO3JcGFjF6qwkFrn?=
 =?us-ascii?Q?QwjzQw1+5hg/MrMF139tOCx/0NV9nNjGjVdKsp+O8kLkHAElLHdKOL85UODu?=
 =?us-ascii?Q?oguodFVsZ/TDIoYamxAZ+F5kXaeP9JSSHJnFbzUScttWeZpgruIHUe44OXJg?=
 =?us-ascii?Q?y0ZXcMYcOT6vfX4I1zY1R1FQ+Gj+RSl0rQpHv4bNPxL/dYP7bhBXKRRsNWbn?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d0375c-15ea-4c92-83a1-08d9dc795c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 01:00:04.4927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqg7U3akRW5mYmlP+jXzgJMBBn8AQkp8U/aCILogq2aaWNr+feYY4h47y6nB3Cv6elcozxBqL/9If6UO30wnHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8887
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 8/9] remoteproc: imx_rproc: support i.MX8QM
>=20
> On Tue, Jan 11, 2022 at 11:33:32AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Most logic are same as i.MX8QXP, but i.MX8QM has two general purpose
> > M4 cores:
> >  Use the lower 16 bits specifying core, higher 16 bits for flags.
> >  The 2nd core has different start address from SCFW view
>=20
> Are the cores running independently or in lockstep?=20

Independetly.

 This is relevant
> information that should be in the changelog.  The above is an
> implementation detail that should be added as comments in the code.

Fix in V2.

>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 55
> > +++++++++++++++++++++++++++++++---
> >  1 file changed, 51 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 09d2a06e5ed6..7bc274fbce9f
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -77,8 +77,11 @@ struct imx_rproc_mem {
> >
> >  /* att flags */
> >  /* M4 own area. Can be mapped at probe */
> > -#define ATT_OWN		BIT(1)
> > -#define ATT_IOMEM	BIT(2)
> > +#define ATT_OWN         BIT(31)
> > +#define ATT_IOMEM       BIT(30)
>=20
> ATT_OWN was defined in 2017 and has had the same value since.
> ATT_IOMEM was introduced by this commit [1] (that you signed off on), whi=
ch
> as supposed to be a fix for another commit.
>=20
> Now, overnight, both bitfields are changed without any explanation other =
than
> a cryptic comments.  What about all the other platforms that previously u=
sed
> those bitfields - was this change tested on those as well?

Yes. Actually in NXP downstream, the new bit definition has been used for
quite some time and tested on many platforms.

The bit change is just to make code easy to get it is remote core0 or remot=
e core1,
no function impact to other platforms.

I'll update in V2.

Thanks,
Peng.

>=20
> I will stop here with this patchset - it needs to much work for me to con=
tinue
> reviewing it.
>=20
> Thanks,
> Mathieu
>=20
> [1]. 91bb26637353 remoteproc: imx_rproc: Fix TCM io memory type
>=20
>=20
> > +/* I =3D [0:7] */
> > +#define ATT_CORE_MASK   0xffff
> > +#define ATT_CORE(I)     BIT((I))
> >
> >  struct imx_rproc {
> >  	struct device			*dev;
> > @@ -98,11 +101,25 @@ struct imx_rproc {
> >  	struct notifier_block		proc_nb;
> >  	u32				rproc_pt;
> >  	u32				rsrc;
> > +	u32				reg;
> >  	int                             num_pd;
> >  	struct device                   **pd_dev;
> >  	struct device_link              **pd_dev_link;
> >  };
> >
> > +static const struct imx_rproc_att imx_rproc_att_imx8qm[] =3D {
> > +	/* dev addr , sys addr  , size      , flags */
> > +	{ 0x08000000, 0x08000000, 0x10000000, 0},
> > +	/* TCML */
> > +	{ 0x1FFE0000, 0x34FE0000, 0x00020000, ATT_OWN | ATT_CORE(0)},
> > +	{ 0x1FFE0000, 0x38FE0000, 0x00020000, ATT_OWN | ATT_CORE(1)},
> > +	/* TCMU */
> > +	{ 0x20000000, 0x35000000, 0x00020000, ATT_OWN | ATT_CORE(0)},
> > +	{ 0x20000000, 0x39000000, 0x00020000, ATT_OWN | ATT_CORE(1)},
> > +	/* DDR (Data) */
> > +	{ 0x80000000, 0x80000000, 0x60000000, 0 }, };
> > +
> >  static const struct imx_rproc_att imx_rproc_att_imx8qxp[] =3D {
> >  	/* dev addr , sys addr  , size	    , flags */
> >  	{ 0x08000000, 0x08000000, 0x10000000, 0}, @@ -260,6 +277,12 @@
> > static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp =3D {
> >  	.method		=3D IMX_RPROC_NONE,
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
> > @@ -310,7 +333,10 @@ static int imx_rproc_start(struct rproc *rproc)
> >  		ret =3D res.a0;
> >  		break;
> >  	case IMX_RPROC_SCU_API:
> > -		ret =3D imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true,
> 0x34fe0000);
> > +		if (priv->reg)
> > +			ret =3D imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true,
> 0x38fe0000);
> > +		else
> > +			ret =3D imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true,
> > +0x34fe0000);
> >  		break;
> >  	default:
> >  		return -EOPNOTSUPP;
> > @@ -342,7 +368,10 @@ static int imx_rproc_stop(struct rproc *rproc)
> >  			dev_info(dev, "Not in wfi, force stopped\n");
> >  		break;
> >  	case IMX_RPROC_SCU_API:
> > -		ret =3D imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false,
> 0x34fe0000);
> > +		if (priv->reg)
> > +			ret =3D imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false,
> 0x38fe0000);
> > +		else
> > +			ret =3D imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false,
> > +0x34fe0000);
> >  		break;
> >  	default:
> >  		return -EOPNOTSUPP;
> > @@ -364,6 +393,11 @@ static int imx_rproc_da_to_sys(struct imx_rproc
> *priv, u64 da,
> >  	for (i =3D 0; i < dcfg->att_size; i++) {
> >  		const struct imx_rproc_att *att =3D &dcfg->att[i];
> >
> > +		if (att->flags & ATT_CORE_MASK) {
> > +			if (!((BIT(priv->reg)) & (att->flags & ATT_CORE_MASK)))
> > +				continue;
> > +		}
> > +
> >  		if (da >=3D att->da && da + len < att->da + att->size) {
> >  			unsigned int offset =3D da - att->da;
> >
> > @@ -594,6 +628,11 @@ static int imx_rproc_addr_init(struct imx_rproc
> *priv,
> >  		if (!(att->flags & ATT_OWN))
> >  			continue;
> >
> > +		if (att->flags & ATT_CORE_MASK) {
> > +			if (!((BIT(priv->reg)) & (att->flags & ATT_CORE_MASK)))
> > +				continue;
> > +		}
> > +
> >  		if (b >=3D IMX_RPROC_MEM_MAX)
> >  			break;
> >
> > @@ -809,6 +848,13 @@ static int imx_rproc_detect_mode(struct
> imx_rproc *priv)
> >  			return ret;
> >  		}
> >
> > +		priv->reg =3D of_get_cpu_hwid(dev->of_node, 0);
> > +		if (priv->reg =3D=3D ~0U)
> > +			priv->reg =3D 0;
> > +
> > +		if (priv->reg > 1)
> > +			return -EINVAL;
> > +
> >  		priv->has_clk =3D false;
> >  		/*
> >  		 * If Mcore resource is not owned by Acore partition, It is kicked
> > by ROM, @@ -1005,6 +1051,7 @@ static const struct of_device_id
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
> >  	{},
> >  };
> > --
> > 2.25.1
> >
