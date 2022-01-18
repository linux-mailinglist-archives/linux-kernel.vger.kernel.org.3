Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047B749135B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiARBYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:24:41 -0500
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:4065
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229705AbiARBYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:24:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZE1QABYIDXqWHFx8SXnKE/bkoFHPeM+vjtYxmFTlCYdootu4c7CMCvRdaXn3+b7+dvMyggCRuqTDyp4lDNU+0tQJi2TvLDbGZFmRyCS7OC31mKK1I4CEC4M7FkRyhncy7n1O7+ng2+Ekmeqr2AMDJ+ilnAmorS9DlaKsp19fmkmhVVK9Lqto+8QLlzmQqkysFiXhoxJTUZ3RFDRhxNBBllQfLytNsDY6tFZHTuL1zN5cjD6eXdILxOq6dBg/xblfZOiNFw5fcBalxSjw3l7dz/Yz1sd96TvIlXbyTVNZ0fO3jL8gpOc/shwqFSpK0GuhzIbhC6lUTsgZKMOOP5gEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KMx60YHkWYT0h8ZRQjR8Y6XDlfVcTvHRx0XP8SykzQ=;
 b=LD8MJMQf/CKV/RXBgGR8Fnj8c5rk2qLo+jwy1E4QnsktpRGv0iDQqsw9GFKRPX0L6c04C9wmq4blnaLdP7PSPVX77oha5rrfDJobRws5TlNOfQto9GRWpMZd+MM3NDOPrKg8sX1NY+9LdoIyj8QZcX2w0JQLQG7thD/J8sSedQrM5qrVTR0Yn00ij/tHysvXkJnAMcycebEONo9WN2CZBTuZVfSJJ/RVnjEa6uRm6fEatY6PwsqW7CZ3i5CTXwkqLFZ5PmnM7J1uZRcpUKj+L+r1qSSqwuetNd4PmqzHyG0NEGEFoh0LbN/+1m5wDbFEmsWZHebQUPq+HzwFQA8RCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KMx60YHkWYT0h8ZRQjR8Y6XDlfVcTvHRx0XP8SykzQ=;
 b=ERmkJwyUto/3q09xroBWp9Q+lrn9Mol5gDSTr7EQG6j9/MkU+iyu27yjL+bF3AR/jo6p1kOtzHb1zqNHIi8iwB/vau1hw76i7B/o9y/pqwT8OmypZQ+sVRRKg81cavdn8xULqZgdARCZinR8n03cAX6Qr+fkJ2Z+cpzZiL0dgi0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7958.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 01:24:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4888.013; Tue, 18 Jan 2022
 01:24:38 +0000
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
Subject: RE: [PATCH] remoteproc: imx_rproc: validate resource table
Thread-Topic: [PATCH] remoteproc: imx_rproc: validate resource table
Thread-Index: AQHYBpwmO5aK4OtvYkq+yuw1fYEnI6xnkheAgAB0wYA=
Date:   Tue, 18 Jan 2022 01:24:38 +0000
Message-ID: <DU0PR04MB9417BEA67ED9C2185C5C874A88589@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-2-peng.fan@oss.nxp.com>
 <20220117182551.GC1119324@p14s>
In-Reply-To: <20220117182551.GC1119324@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88e54e93-c505-4193-90f5-08d9da214b77
x-ms-traffictypediagnostic: AS8PR04MB7958:EE_
x-microsoft-antispam-prvs: <AS8PR04MB7958CFCAEB4A585B5C9F7FBC88589@AS8PR04MB7958.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hjanMkKGTQFwRJ9D6OoAwNwQMeUxBFReeO30i7S4wYl//l9WdcLa/WV9OoZ0ll1wtmzT5YLmkW/db6fNAfPyelrNZFUese8+D8cLtLdny+DSVp3gK7HoagdOjGyxNxM7t+p1x69tpZoff3SjoSyZMLIWJwbtJ+HhxyuKI7YoHk26agZ0AbVfhdOLCecmye9EI8wV5FADNvP4Glr/kivorCYni1z8wxehzuO/evtqfavjXC/hREotqqPD/5W9YTcLIZtnVayKVyljfOf9FfnbPPYvDRTvgpVVkKPNt4oBJLxYZP4PXa355cMXnlylpAJsjXdZsgk1i4Jrs7df0k/h+WDSKUpsmGh87y/9+TeoHfqyXZvQUp6w2r9vSQkutE6JjeplTprVBpOdEv3OQxPvX0OWOR1Smv1Luw+t85i0CQPRnJwF8lkNAUelBo/KgVukYC+NmHn1drEvu7jwLM2VXALJLCynrsU0zSFoJr6CZ+LSoGCDiVT/+UKD9LFc3wqc990tDzPKXZdKQ32k07bgrdiJ3pCgcF5mFNYzjTTLaCAkm3pJioyVIePYu92h7s8K6f+KJ0lIfutPK1fLgb1cfHM3g9EI+sdLkLMLqAnGPvRom8i/pS/oPGNphIajqDf/VvAxTMVCAbQBT+hmRCv+B19uwPlji6i0Ziljg3PWbIbvcwngxUokZFkhwVoadld/UIxabF36+RU5USvv0QShDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6506007)(8676002)(7696005)(508600001)(71200400001)(186003)(5660300002)(4326008)(9686003)(26005)(15650500001)(83380400001)(66476007)(44832011)(316002)(33656002)(2906002)(66556008)(76116006)(52536014)(66946007)(64756008)(66446008)(54906003)(86362001)(38070700005)(110136005)(55016003)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iwl0VuqGhpPW7at4mpdvEg3kHOK19MmyHnpR2FP4IeGBk4aJW4reAyLiP8yv?=
 =?us-ascii?Q?yeuBxGdVCMyMwYA+ZiTFmonzPdXsDUP48NCZAlWLUOvFs58mBln3FeaQG89l?=
 =?us-ascii?Q?5iJpjnrdk5SYOSRqdOAfxjYjP6CljVnoRTVmXrCROt1Jw1PJR9EzDD1AJ6RD?=
 =?us-ascii?Q?XntGLK7QQMUO0EdEWHVqTMePdHbaVfwWG/8rCdlbFU/ccMnI39dB9tgUBjhN?=
 =?us-ascii?Q?4E29mqv9yOHHigA3RaB3DOiQjuDIV6JZCMjsFE4dJz+YoTNXf3oX+K/4ofEf?=
 =?us-ascii?Q?+CV6/48uxbSyO3Z7ZJlS+MBxQrHJ/VdgGvQjXSShIoiiipITcPcWyM4sgzus?=
 =?us-ascii?Q?VAi3tx9hBWNr1CdynU0EOZmIVhCwPEDAO1rUn0Jb71lgBPO+NWOZKw7cQbf2?=
 =?us-ascii?Q?M7z2UKDTqCQsjE91q4nP3tOmPlcWquDrvFYKtPtwnI4DSsuVjW9FuK+fGUOE?=
 =?us-ascii?Q?lioHR6Zz1EcsA351YTT6otgP+f8E4gX9/+Ll8JxZjbwSO3D2V2svyQXHisS+?=
 =?us-ascii?Q?4BCtAS8PGeDHWHnZF9nDUTuYiKW9JYxNpXCuYY0F/Z9GXI4nj0IZ5otMrIE7?=
 =?us-ascii?Q?lZgowHl4pjNj0e2RDWdwhCPbBySmxUGoJXV6UuBALe81OvVVwiNc7vC9Xas2?=
 =?us-ascii?Q?R2rev77y3XtYVSIgrzM5rtFRyQ/JoAZ8avHpsZtif0Eg/PwgDIqbb9MzN6rm?=
 =?us-ascii?Q?vZJd00xEQhkGyi/9gHW5JLVzSlae4nNm4zW/R+RyLfzj7KhsvbeI7ngVHa4W?=
 =?us-ascii?Q?0q6hOQ8sqEe9jrZTG8JkrfmPiZQCnYkqerqQRABDBlN3GTrKJ3PXTzOMKoux?=
 =?us-ascii?Q?PS7dPr62TO64OroAQn4R4H/ytVXXq6kGTGzaNj2W2HzCFnag0ciWYqYoLtfC?=
 =?us-ascii?Q?Z+nYbQ3N+x2Cfoui/L/ElagnOLbYbcG1tqd+KJUfwKJXRL1H79RJJgzM69T5?=
 =?us-ascii?Q?Acz/vU8pLjQpzBlw4kSSlpKfWG3Dcf/dgmfTWM8NslzlJ+gCWoeCyluBqCgo?=
 =?us-ascii?Q?sWjeAaEeR7Jlfdauxl1KWWj+88C92owyKjbYPXxLBSRSdyYnIzOIZBw07EO/?=
 =?us-ascii?Q?SM/V47hMjLejcjbWJpnc9vuowZ3VXvw8nAhMkCFMrQ7pOyrsdNe6wXlkW8pW?=
 =?us-ascii?Q?mDcfgr9MCUI9hhr8f/Pwp/9Mc4yY1rUGHK88i1/JGSb8cxZF2zc11xs06Nmn?=
 =?us-ascii?Q?mZcwR3TnOigujynvPvTTAkyyuxRtG41DEfTOVhtyaVoLd63thxVhscf1FRvs?=
 =?us-ascii?Q?8+lqAs/KJ2fe0SEwPzvcTlblcbsPhlNqJBBZLULt3kbbZZvuNJWPGZHCHNNT?=
 =?us-ascii?Q?gnF8k5+lLLvRys9h94PJ/Ms7CeGj/o9c597cP6CJOj6wJIMWpPyGYBUbRwgm?=
 =?us-ascii?Q?xuz8iyFQHmKcb2m6hIBXIv36cUxr85jV/Cj73Mfc56no5+we/r+ARj4EDTuV?=
 =?us-ascii?Q?bIWJxFM5QYzGDkeJvDYYUdLxrLXX9mI/QkXgW2F7/lIwA2OMNJUqcEN9Y3rK?=
 =?us-ascii?Q?EQme3/YxFLkqT+XsKPcRi4bktRzYsUIHnrCENJ7qh/OK0vLCyRHaeOGRFAzs?=
 =?us-ascii?Q?YQYDvT2BDVnybxahUnsKiERVlFsJpk+SVoGzw+MYxhkTs0mYC2ir9PSOZspJ?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e54e93-c505-4193-90f5-08d9da214b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 01:24:38.3745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1BFZCnVUAStr93Vxejub1E6Bp+kVG5P2K+LVu6BG2QHmQHNN3cl6ZXYon3+1ZKBIOo+uQju72PJta8BoO19CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7958
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] remoteproc: imx_rproc: validate resource table
>=20
> Good morning,
>=20
> On Tue, Jan 11, 2022 at 11:33:23AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Currently NXP use one device tree to support all NXP released Cortex-M
> > demos. There is one simple demo that not need to communicate with
> > Linux, thus it will not update the resource table. So there maybe
> > garbage data in it. In such case, Linux should directly ignore it.
> >
> > It is hard to decide what data is garbage data, NXP released SDK use
> > ver(1), reserved(0) in a valid resource table. But in case others use
> > different value, so here use 0xff as a max value for ver and num.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 0bd24c937a73..75fde16f80a4
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -490,11 +490,19 @@ static int imx_rproc_attach(struct rproc *rproc)
> > static struct resource_table *imx_rproc_get_loaded_rsc_table(struct
> > rproc *rproc, size_t *table_sz)  {
> >  	struct imx_rproc *priv =3D rproc->priv;
> > +	struct resource_table *table;
> >
> >  	/* The resource table has already been mapped in imx_rproc_addr_init
> */
> >  	if (!priv->rsc_table)
> >  		return NULL;
> >
> > +	table =3D priv->rsc_table;
> > +	/* Gabage data check */
> > +	if (table->ver >=3D 0xff || table->num >=3D 0xff || table->reserved[0=
] ||
> table->reserved[1]) {
> > +		dev_err(priv->dev, "Ignore invalid rsc table\n");
> > +		return NULL;
> > +	}
> > +
>=20
> This seems like the wrong fix to me.  Either use different DTs or update =
the
> resource table for all demos - efficiency should not be a problem since t=
hey
> are demos.  With the above it is only a matter of time before the pattern
> associated with valid resource tables changes, leading to more hacks that=
 will
> be impossible to maintain over time.

I see, drop this patch :)

Thanks,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> >  	*table_sz =3D SZ_1K;
> >  	return (struct resource_table *)priv->rsc_table;  }
> > --
> > 2.25.1
> >
