Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2125D4932F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351000AbiASC2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:28:35 -0500
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:56008
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238636AbiASC2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:28:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMNWiEBPpkXaEpCW42085hkoDKmXHPnt6zXIdwP8AJ9TrWEmGP80kjA03W8LP7VPVl13K1tNHmvWye23vqxmf4itTXFge+z6Bdy4CUTRMHRLk3tURea1d553WnX7IXuhoST4CQ/unYHbELOxRdMlt+hr0REHN4UMy6EZEzhc34r2cutNVwXzQD+j1ZdQUEIjBzbnvRKav2cVjR1Av7ddyUF4+KPx3Asbj3eLqjEUHhQiWSrCQQjpNtJx0w+ETtmtHiSGPckq28kwWt7l113jC7R2HWOPzhltQpGY7xFAhwBRoCaXvS4VMEQY6j4+p/+yQMOVgP2xqtmKcCyKl1tj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DySkXGajEHg4mKWzz2wXq9bwiCpprjz5GfZ7biiqV7I=;
 b=K0RHYQRTam+RKnv4YR6jk4HDKaLQDK/Mxh6ImKdyCp5wNbL13qvjdgNbA8GHykd7iWMKpwPEAAajc/wqSua3iDyevaL7P73BgWsc8mOgBKO7ctM+9Ux95gv+dNYNZCqAVn9IZP4Wjy4YnGu7g7GYlKLXYPbt366NG4AZuj/nrxUv6JfSMQpKotqq/gpqu3x+OpaiSc+J/jq+/c6IqNceLRf583R6qMPEb9cY47/Cvt1hhhWJ+XbDr9hf9JO2PN+HnZCPflQzwBO4BjehzIuDbw3zQ8v3QZmNagy/IT/dC7Tqi4gLNIBmr77NTlNW1SB5BHyul6ushcF4cUFgrcLA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DySkXGajEHg4mKWzz2wXq9bwiCpprjz5GfZ7biiqV7I=;
 b=QNIvz7JP5LpiNgJMOl9RHpWqfKjFBFBpo2wKghQaTxKKfXPc6BF0kQC9KmB28kn1TBQMWhRtl1L5O44NKK69bUr0iy3SIkPDmlI23iNJ3Ybea8oDLDzPkz2Q3jUPBgDTer+zhO9AnQx18gKh9rcSDBCZjPnT3uGdb7KA2ni8oTc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5045.eurprd04.prod.outlook.com (2603:10a6:20b:12::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 19 Jan
 2022 02:28:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 02:28:31 +0000
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
Subject: RE: [PATCH 6/9] remoteproc: imx_rproc: support attaching to i.MX8QXP
 M4
Thread-Topic: [PATCH 6/9] remoteproc: imx_rproc: support attaching to i.MX8QXP
 M4
Thread-Index: AQHYBpw1XSm7ohRXCUiPzYJqNJAQmaxpLUKAgAB9VcA=
Date:   Wed, 19 Jan 2022 02:28:31 +0000
Message-ID: <DU0PR04MB9417335FFEBEB5CE91A5A67888599@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-9-peng.fan@oss.nxp.com>
 <20220118185729.GH1119324@p14s>
In-Reply-To: <20220118185729.GH1119324@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1feed45f-888b-4d93-e4a9-08d9daf362a4
x-ms-traffictypediagnostic: AM6PR04MB5045:EE_
x-microsoft-antispam-prvs: <AM6PR04MB504516149BC3320652BBA45088599@AM6PR04MB5045.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /bTVodWnku6gUSurmsrjQ80Sq1tCvkwipd9nWkyzY9Ls6iWGpQow8KlNv8AduVI/oJdLEl76UasheirlEBjAvfWoTL9wMFrtSLKa5P8qZZ6AAyjhduddRZkF3bcnnhE9Aru0tLrhYFfc1jn1SflDJc3wm18+Ul0dxj80fRjCMC+qBRs18OxAugvF6Q79nDnaYkN3EVzpAZJFsuXxMwQmPh5kGb9JHxfyfjVKddhgyPl3rRN8L3IhVqi1J4TXeiAWn1+uU+jfC1OeIgJ93GNVSFWUCqh1m405WnLqBDo2Ld9dMs6ZNuG2zvAYWQUckhaYgZYklSKPP1VSXAUbOiNEDHT14MXok3hv/Fp2E+p+PDrtUayo4qwRgd9Ib/HUgmvHzxW2O6dxj2NnCVeyxsf+Rtik9+In/zkRe/6mFlBOatNW0yS7Xv5G2HJj6dm16yCM2dXZ1m0gsah6UYVUhoq8RyMDUUnVq/GiG2fT42Xrz/3hbXXEnhVbrEsUK06jkkZluIQNzIVvZ2klT4GBW/+aqDOOyfy4g/ofqGnF8sWLY7fYt9bEII1clwc3LUa3oc8YD6qXyw40x7YAHLLZQOk1gbAl72Wh1W0KhUK842DpwvMOwKTAthbev8WywqP6ryALm7ACIIx+dFG/TyroKbJDQIZtjpt1GvMtBu5xcu8g6U7NgMZbWwAvzntGzfRndL50Nx0XiJLiLndgAy2ai3/ApQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(66556008)(55016003)(186003)(26005)(122000001)(44832011)(54906003)(66476007)(66946007)(86362001)(64756008)(33656002)(316002)(110136005)(4326008)(76116006)(9686003)(71200400001)(38100700002)(38070700005)(7696005)(83380400001)(2906002)(8676002)(8936002)(5660300002)(508600001)(66446008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gRvSRDV9nEcabyJeSY75mg7IeDm3IHZ6SiEY5L9qfIn+oPWi+vISC2//n0rB?=
 =?us-ascii?Q?MIRCbIxLYLPIZEDbHeZzKxBOloJtldaCTk2vMfxIjd3lEfcvV4coWNfTHyJX?=
 =?us-ascii?Q?iRtih69cJx3kF3/R2fYRRHl9Z40s+/NhtwBSSZd9z1hzy5OHU4P3VlP6xp1U?=
 =?us-ascii?Q?9y49vmwi3lBOu3LDM7d2yH0NsfDlyTYLsPYh3kfJVWRhi1RohEgpgvK6CULn?=
 =?us-ascii?Q?tV84vZh1ZeSsp6HtiiKel+SH5mEUlXIVTwO8YwQNlw9UqIWf4dld160aqxxk?=
 =?us-ascii?Q?IydOmymh4oqcT/i5SJNlbA/c9AJzUo2U3ojzKy7gGix7rk78rxyZRp5CU5no?=
 =?us-ascii?Q?lHwMfP+39QFrawN7viUummtlkWyKHcjbFpbtCTFChAO1d6N+ROQH4n9/77dd?=
 =?us-ascii?Q?iDi+G4wIrbhyEbfmQ8aJ0l19YeRQzzX88pvNOzwl5ZUf5aJXtLEd4Z4GhytU?=
 =?us-ascii?Q?paLaIa7b9GNTjuuk5qwtctEEUFw8mbsJqzrskM1FzVbyDx3ruKMfy9Uj9QHZ?=
 =?us-ascii?Q?zGUBEdLwhV42hNDoQxS35vc9JK6v7mpgbJR8rEH48HWNP5h68WlRrDJQGqoK?=
 =?us-ascii?Q?TA3MKr0tfc3v/H55SQrUa5CckpoczyqDZCX+aSxXs5yHtyhuCQ9jNlUQDVOF?=
 =?us-ascii?Q?muXiP7yBuyTf+rFNV10RV0Bz3iLwW3WYKw/PedsdqL8sWOk4Al3NvZkWucHu?=
 =?us-ascii?Q?MJPivUadVEVCTctUEESVo4+ZXCMURhpw+iPd7mV76qp8wIYCe0qPK1HTUTod?=
 =?us-ascii?Q?hkvhjzHjFU7qg8LH4TUKW9NvUIGLleORqhsHiyB+Qgado9wpaPRmPp+KVqSM?=
 =?us-ascii?Q?I7D9NgCEd/bbFnhCpwV4Cl0rn/r6JAeVZ8Zo3WwuCZS5N95RvdMke9liCKoX?=
 =?us-ascii?Q?0JrOksJmN3pSWBjXY3L0ehEQ/1VsXwjlFad+KbkHPsRI2IEvo1TaYKWAWxWa?=
 =?us-ascii?Q?0PV6KEgwSnqjZCWp70SzmGHcikboZHglYIDjP/Pnbt9YrjZ7WbuUkrifurVz?=
 =?us-ascii?Q?tVhTTZvPfo5oft+5QCRA0U+2wigTT8otONHrCj/Q5+K0J9vXgPzNkMh/xX0s?=
 =?us-ascii?Q?UlpgT2R7leYL65poD8CjWAErDJZlibSxEC1OfIeFrNk9CdpBBzSXuuP48aSN?=
 =?us-ascii?Q?TkKIcm5XM/Y3e3p7Jnt0ed2aHFsCLH2t1UgEa6CM7XiMCrkgiA0OWDq8Wpci?=
 =?us-ascii?Q?SAbZGTwkcNs3+s9Dt3f/1P+YY2TSwqhrQV3NPItrUUy4EIlnEfNeX2MfXCjp?=
 =?us-ascii?Q?pEoXQkove0rJFztxm3lWgv30Yrp07zN5egpL1QnkXfssjKfOVPxneDjOOqju?=
 =?us-ascii?Q?1P6GsDR1gc/XWhDEA4Q90ZCKGN/JffsomfxxheFmLCuyzrSBATCBSAd9DaRG?=
 =?us-ascii?Q?ApqKjC+ajM3pBaV8NgcK9WxbVSz02Pa0pbcVzb5A5uYa4VbkmAe9fWy/fk6+?=
 =?us-ascii?Q?f14I9Y57gmouYCYCFjyinmuoXoEGvYFqSmwSl2/+MEkWXbOMQ/i4zSWW5nAe?=
 =?us-ascii?Q?hVrF9sS/OD2AwXg7+p3vn833fduS/uWALdxPPAstBo+qiuP6VOM7IXwYHng3?=
 =?us-ascii?Q?3xTEaFNk0j53L71slR9n8gxPNmKNgQcLgHQCCqhICrfDMa0e32lUTaKVa3wX?=
 =?us-ascii?Q?wYRAl+7EbLj1s6rRufqXTlQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1feed45f-888b-4d93-e4a9-08d9daf362a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 02:28:31.5424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdkD12OOmk2G6gtPoOxeOmBuoPp3LhqgwNwkABF2MQF1ml+BDb+e1CKmy2YMzPIWev0CfJcGBwjLX9yBoedrqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 6/9] remoteproc: imx_rproc: support attaching to
> i.MX8QXP M4
>=20
> On Tue, Jan 11, 2022 at 11:33:30AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When M4 is kicked by SCFW, M4 runs in its own hardware partition,
> > Linux could only do IPC with M4, it could not start, stop, update image=
.
> >
> > When M4 crash reboot, it could notify Linux, so Linux could prepare to
> > reattach to M4 after M4 recovery.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 96
> > ++++++++++++++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 0e99a3ca6fbc..5f04aea2f6a1
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/arm-smccc.h>
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > +#include <linux/firmware/imx/sci.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mailbox_client.h>
> > @@ -59,6 +60,8 @@
> >  #define IMX_SIP_RPROC_STARTED		0x01
> >  #define IMX_SIP_RPROC_STOP		0x02
> >
> > +#define	IMX_SC_IRQ_GROUP_REBOOTED	5
> > +
> >  /**
> >   * struct imx_rproc_mem - slim internal memory structure
> >   * @cpu_addr: MPU virtual address of the memory region @@ -90,6
> > +93,23 @@ struct imx_rproc {
> >  	struct workqueue_struct		*workqueue;
> >  	void __iomem			*rsc_table;
> >  	bool				has_clk;
> > +	struct imx_sc_ipc		*ipc_handle;
> > +	struct notifier_block		proc_nb;
> > +	u32				rproc_pt;
> > +	u32				rsrc;
>=20
> There is no documentation for the above two fields and I have to guess wh=
at
> they do.

Fix in V2.

>=20
> > +};
> > +
> > +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] =3D {
> > +	/* dev addr , sys addr  , size	    , flags */
> > +	{ 0x08000000, 0x08000000, 0x10000000, 0},
> > +	/* TCML/U */
> > +	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
> > +	/* OCRAM(Low 96KB) */
> > +	{ 0x21000000, 0x00100000, 0x00018000, 0},
> > +	/* OCRAM */
> > +	{ 0x21100000, 0x00100000, 0x00040000, 0},
> > +	/* DDR (Data) */
> > +	{ 0x80000000, 0x80000000, 0x60000000, 0 },
> >  };
> >
> >  static const struct imx_rproc_att imx_rproc_att_imx8mn[] =3D { @@
> > -236,6 +256,12 @@ static const struct imx_rproc_dcfg
> imx_rproc_cfg_imx8ulp =3D {
> >  	.method		=3D IMX_RPROC_NONE,
> >  };
> >
> > +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp =3D {
> > +	.att		=3D imx_rproc_att_imx8qxp,
> > +	.att_size	=3D ARRAY_SIZE(imx_rproc_att_imx8qxp),
> > +	.method		=3D IMX_RPROC_SCU_API,
> > +};
> > +
> >  static const struct imx_rproc_dcfg imx_rproc_cfg_imx7ulp =3D {
> >  	.att		=3D imx_rproc_att_imx7ulp,
> >  	.att_size	=3D ARRAY_SIZE(imx_rproc_att_imx7ulp),
> > @@ -491,6 +517,11 @@ static int imx_rproc_attach(struct rproc *rproc)
> >  	return 0;
> >  }
> >
> > +static int imx_rproc_detach(struct rproc *rproc) {
> > +	return 0;
>=20
> Is it possible to detach the remote processor from the application core? =
 If
> not please write a comment that says so.

No from my understanding.

  And shouldn't this return some
> kind of error so that users don't think the operation was carried out
> successfully?

No. This is to match patch 3/9 to support M-core self recovery. After M-cor=
e
crash reboot, remoteproc framework just detach and re-attach.

>=20
> I am out of time for today and as such will continue with this set tomorr=
ow.

Thanks for you reviewing the patchset.

Thanks,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> > +}
> > +
> >  static struct resource_table *imx_rproc_get_loaded_rsc_table(struct
> > rproc *rproc, size_t *table_sz)  {
> >  	struct imx_rproc *priv =3D rproc->priv; @@ -525,6 +556,7 @@
> > imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct
> > firmware *  static const struct rproc_ops imx_rproc_ops =3D {
> >  	.prepare	=3D imx_rproc_prepare,
> >  	.attach		=3D imx_rproc_attach,
> > +	.detach		=3D imx_rproc_detach,
> >  	.start		=3D imx_rproc_start,
> >  	.stop		=3D imx_rproc_stop,
> >  	.kick		=3D imx_rproc_kick,
> > @@ -671,6 +703,22 @@ static void imx_rproc_free_mbox(struct rproc
> *rproc)
> >  	mbox_free_channel(priv->rx_ch);
> >  }
> >
> > +static int imx_rproc_partition_notify(struct notifier_block *nb,
> > +				      unsigned long event, void *group) {
> > +	struct imx_rproc *priv =3D container_of(nb, struct imx_rproc,
> > +proc_nb);
> > +
> > +	/* Ignore other irqs */
> > +	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group =3D=3D
> IMX_SC_IRQ_GROUP_REBOOTED)))
> > +		return 0;
> > +
> > +	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> > +
> > +	pr_info("Patition%d reset!\n", priv->rproc_pt);
> > +
> > +	return 0;
> > +}
> > +
> >  static int imx_rproc_detect_mode(struct imx_rproc *priv)  {
> >  	struct regmap_config config =3D { .name =3D "imx-rproc" }; @@ -680,6
> > +728,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> >  	struct arm_smccc_res res;
> >  	int ret;
> >  	u32 val;
> > +	u8 pt;
> >
> >  	switch (dcfg->method) {
> >  	case IMX_RPROC_NONE:
> > @@ -690,6 +739,52 @@ static int imx_rproc_detect_mode(struct
> imx_rproc *priv)
> >  		if (res.a0)
> >  			priv->rproc->state =3D RPROC_DETACHED;
> >  		return 0;
> > +	case IMX_RPROC_SCU_API:
> > +		ret =3D imx_scu_get_handle(&priv->ipc_handle);
> > +		if (ret)
> > +			return ret;
> > +		ret =3D of_property_read_u32(dev->of_node, "rsrc-id", &priv->rsrc);
> > +		if (ret) {
> > +			dev_err(dev, "no rsrc-id\n");
> > +			return ret;
> > +		}
> > +
> > +		/*
> > +		 * If Mcore resource is not owned by Acore partition, It is kicked b=
y
> ROM,
> > +		 * and Linux could only do IPC with Mcore and nothing else.
> > +		 */
> > +		if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc)) {
> > +
> > +			priv->has_clk =3D false;
> > +			priv->rproc->self_recovery =3D true;
> > +			priv->rproc->state =3D RPROC_DETACHED;
> > +
> > +			/* Get partition id and enable irq in SCFW */
> > +			ret =3D imx_sc_rm_get_resource_owner(priv->ipc_handle,
> priv->rsrc, &pt);
> > +			if (ret) {
> > +				dev_err(dev, "not able to get resource owner\n");
> > +				return ret;
> > +			}
> > +
> > +			priv->rproc_pt =3D pt;
> > +			priv->proc_nb.notifier_call =3D imx_rproc_partition_notify;
> > +
> > +			ret =3D imx_scu_irq_register_notifier(&priv->proc_nb);
> > +			if (ret) {
> > +				dev_warn(dev, "register scu notifier failed.\n");
> > +				return ret;
> > +			}
> > +
> > +			ret =3D
> imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
> > +						       BIT(priv->rproc_pt), true);
> > +			if (ret) {
> > +				imx_scu_irq_unregister_notifier(&priv->proc_nb);
> > +				dev_warn(dev, "Enable irq failed.\n");
> > +				return ret;
> > +			}
> > +		}
> > +
> > +		return 0;
> >  	default:
> >  		break;
> >  	}
> > @@ -847,6 +942,7 @@ static const struct of_device_id
> imx_rproc_of_match[] =3D {
> >  	{ .compatible =3D "fsl,imx8mm-cm4", .data =3D &imx_rproc_cfg_imx8mq }=
,
> >  	{ .compatible =3D "fsl,imx8mn-cm7", .data =3D &imx_rproc_cfg_imx8mn }=
,
> >  	{ .compatible =3D "fsl,imx8mp-cm7", .data =3D &imx_rproc_cfg_imx8mn }=
,
> > +	{ .compatible =3D "fsl,imx8qxp-cm4", .data =3D &imx_rproc_cfg_imx8qxp=
 },
> >  	{ .compatible =3D "fsl,imx8ulp-cm33", .data =3D &imx_rproc_cfg_imx8ul=
p },
> >  	{},
> >  };
> > --
> > 2.25.1
> >
