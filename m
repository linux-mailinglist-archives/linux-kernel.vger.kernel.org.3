Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080314932E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350942AbiASCXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:23:53 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:25300
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238636AbiASCXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:23:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enLiTFf4MpC2iBDpKiS5apVitB9BRrsTsJqmeDxJGgwF2yen+JbAzdGdAT8UwPvxLRJTgyrIspWpA1e+BgC9GTIZwNS3cLp3Z+o4T9GSfB3pBxbl6hz/ZfYM/Ysf9Ep8BLSAuCa35Mh5A5uHoJW1ZlU0/MkVuGNqz3V06EL+wB+QD9uKI9LDf4ZabWvwT+R7tuTvURQoC279B3zlDw9JpuFj7Gc8uPCwkCNEsIOSzuq/+e3m1qCnZTvauPTx2qM1Cvi5eKPGZJolDlBbnchfkkMxomTX4G4JO0Mx+3WD/FfWNenZX3N4vGpRhHuuogjsFuxacRALW+C1GkF3ixAiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEwdvlBEHnF/i+GNjt2xJ79Wcrn9OzzLqQ9ZqtzDf1E=;
 b=Pb3xl2BV9Cm/QFSzWsieC/2CWBiR+STflXvjwOQULK2FjOR/b3CgBp+kaOI4VgjVNDGUgcpQkElg2QlaKiUZhDbEmUp7lD5ladFdqkIT+UN+JQ0gt7pZjTQIUCFu2PlPXa3KTUdLvbfOl/6mRp/rKpBujjUwdxgvk9/qXSSmIWKJ43OfzFKLt5R9uX7VGY9ubi5T9crGJl8IZ1S5uFhPdmH+bIO+RD8gl98GvBzgqflqJM6vpy8AjicXKpuzt7GqguRsL8WiGzHGYGOrBDR+wfHiF3RzBXIVoYzJPJ0436T+avr107axGr27jlr7moneQK7egeTOyjlLQF+nmeCb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEwdvlBEHnF/i+GNjt2xJ79Wcrn9OzzLqQ9ZqtzDf1E=;
 b=KBteQS2IWnSA9B/QDqXYwIGPIMPw9PCvkJS3OKuKRgTgDZ3RyZQ9F2zqB7cNKNBmEZ+g6IdnzhRCcCFVZOdmn4dlSmf4ZZd1G4UfXv7AUTu8ayUvwYYXK3BvdHz+5UDjh2cuQdBPWSJv2onTA0EsAraF5lDkcJl2usMrbFt4xgo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5045.eurprd04.prod.outlook.com (2603:10a6:20b:12::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 19 Jan
 2022 02:23:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 02:23:48 +0000
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
Subject: RE: [PATCH 4/9] remoteproc: imx_rproc: ignore create mem entry for
 resource table
Thread-Topic: [PATCH 4/9] remoteproc: imx_rproc: ignore create mem entry for
 resource table
Thread-Index: AQHYBpwxAGEEQF/QB0+CG0e70/T7QqxpKmAAgAB/JCA=
Date:   Wed, 19 Jan 2022 02:23:48 +0000
Message-ID: <DU0PR04MB94170EA5A17F44FC7F9F124588599@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-7-peng.fan@oss.nxp.com>
 <20220118184710.GF1119324@p14s>
In-Reply-To: <20220118184710.GF1119324@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47c30104-315a-4719-5bf3-08d9daf2ba21
x-ms-traffictypediagnostic: AM6PR04MB5045:EE_
x-microsoft-antispam-prvs: <AM6PR04MB50453C33778551A5CB489FF088599@AM6PR04MB5045.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5TErhJyrGDi6QmojWWCp918NA9W2Cja10U2UgrO71h47pFX9gAStYmbfOxNO+smRl3uOPXCczDA5jfRzWNr8hPulr/KZFpn8r8bgsZh+6eYzob97dz3vSFzbd/vHutxkf9aKDVWFsPaVTX+kemgIyTECDPZaXXB3GB1OT8n+iqt6iU+uMs9B7XDiRbLJbZoS0k3REwMx+vTtzF0rLOXJQMbndmVGGE5kCXyyXkHllVerOeUreI4Nyv5jTIxlYd8Ji/lzP8fGO3KrpxEPrC6ghVE151bGwaGNYHLlj8x5SxPJGpB1QtiJjlXOpQubHBiQQAhNXcJJJOCvyt3yikq8XnGeGlha2yhrgsJTEwu0RqJP9tksRuvQL8bSsL0feEKVzCOQL1di/nvOwU6EwGlVJEGy1xNShutX//NwDyf1PrP8kCJcltAlI1nbVAe8TvD1zrACGap6lmU/j7eMXDI8WVVaUxoFOs7i9jBvJ8m0Z6GZ9213ist9tlWM38bg3cyfx6S1eboCrX/S3TBhK2i7UUeZ7EiNkIz3rux6BhfpEx5moEwvo6Qr5yoXp7qX9nqLMBfgpUd3OEIRHI6awvNACejXzycNbH6xhIbj/g/sILF4t6fItVuuD5mD2otwWUZI9THhC+um8A7XlAn8dUBkmSTO1K3TAcN85mQbmXvfMMqrb3ISsyrgnBo/qyOYXZsXe5m66Y10eKrgdnzWb2+vnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(66556008)(55016003)(186003)(26005)(122000001)(44832011)(54906003)(66476007)(66946007)(86362001)(64756008)(33656002)(316002)(110136005)(4326008)(76116006)(9686003)(71200400001)(38100700002)(38070700005)(7696005)(2906002)(8676002)(8936002)(5660300002)(508600001)(66446008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VjE8W09sw/N6cN4aoCT887qOHIcx+Rftq8v3XV0wCnNJrRmbChxVbAUGKlj6?=
 =?us-ascii?Q?wAGAT30CdS9jfrZgKOR8ZpHL6gX9m+y0312dBi6OWj6X/lCWCBcvtwabt6Bl?=
 =?us-ascii?Q?Z8N961zYqtM+XQvLP+61Sl54Ez+2YcclzmFXjCZbE0DnMpR2Jc9VjFrU9hSU?=
 =?us-ascii?Q?jhK32J8Yy2RuOKDj4l49KpNOyUkRbbGQk6q2X6moUvUOoVrY+QnRVWECL0wS?=
 =?us-ascii?Q?scYOgj8J6egaERDzpz8MImYtAht6XgGHjBngipuwtzWabEEFdJlfCLfcxQGK?=
 =?us-ascii?Q?XiuBgIlZpeSXIAsjooW4zLBT95e2lf/mrrqwxOJk9Ycjis32wVoNuaRbvwMf?=
 =?us-ascii?Q?0LWR3JDRYJhrdDMbQWa4rOLBgi6pdZoEoAoRRBeodB6qYLOedlOJjHar7C2D?=
 =?us-ascii?Q?Dj4/sxbHdlimYNLT0jun/8Wd+u0HetZLxvSsqlNmEZgJJvtGxFb7oIDADmII?=
 =?us-ascii?Q?4B3pF4I2cmMszXvJYiMcw+lcersS3JV5IFzCn5DSmg3fi+E64uRUiRLSP+gu?=
 =?us-ascii?Q?wFKJ5yzISBH7f8dhThFCmy0pvrlnmdF1DS9gMoEbVCDeaYRm9bBpomTgEG+v?=
 =?us-ascii?Q?8loFLf6N/gov7GRUpU/xOTypvhsZgwTZhi/Ht9TIcKFsq7KIKICiGx5u3r5n?=
 =?us-ascii?Q?5w93I6rsle1E9cSB85KGMD/RrrIIUItT3Wr2Bi6TIxZYN+L3noBs4WOWVIZD?=
 =?us-ascii?Q?rpIjKRQSgod+Fa/0Q+aKpHXYt0m8sXZNs1MupUgftCaP5F2porHrQKuIZ6ht?=
 =?us-ascii?Q?9yI+IQUjPm8exuYe2gyLKlcmbR18oi2kdxSYd6xqg0SsUApCmaW8Yjgoia24?=
 =?us-ascii?Q?6/KlFwoytWKd4yiw7f0ef+dQc/2cWuLY27ccev8rK61ZapW8OyTNSuphmfFD?=
 =?us-ascii?Q?3DEdMK9c/2T8kitRuTjHBr0FZqrrFMfn4G+doRkOLllZE9nTxHArbWqjiFbJ?=
 =?us-ascii?Q?K7GYfWWp3JndlW4JWljPgvZrN0AYpoxJHepSnXhHAkky+tT8yk6BAYyVRPtf?=
 =?us-ascii?Q?4ZCdbdc3ab7nJnbtnSUsMiuBicsbzZRiUMQGao3KbIfn2MKiIOTRjfWJYOOt?=
 =?us-ascii?Q?+iPywHxhh+D/fF4q9N0Ljlrp65QVg3BtL0G/ETYOlOCTdYBNIcjZlmbz1diY?=
 =?us-ascii?Q?bteAGXkZskCVZvGr3BuO3eQm4+XsK0KDxFqoZrjgPRPaXjFducXuw3/V+/qc?=
 =?us-ascii?Q?uXBiQCNzDzViGXFNJKzLMWUpHobwREnu/oV/tdt0mH15Q4sYTLajUSBE2zN4?=
 =?us-ascii?Q?0Gyo/b0LcbDXhEy0/8FJHszcMaRP6pcbV540if3Jckch0SZyGhiq0G4InIUM?=
 =?us-ascii?Q?DN7D/sqBR4/IZ51x78h74isxZQwv7YjsCAF4VsEQk9TxGavmSBADey5oQoba?=
 =?us-ascii?Q?gnsUjKS1E1ga1E6PNR2RX7/ed93xGagKLX+gXWHB9Scg9fC+N4wDw13nXFhN?=
 =?us-ascii?Q?xaPTUwyymZ0xnG0qX4pEJGLM1GxSb4Ahl9lL3wu4GpaP7Qaj0UFWWRlec2vC?=
 =?us-ascii?Q?S2AqEgWUX9ptLFymoDwc2pmbpKy+T5kL2UfzWFqmXkaBWmDqWgolw3QULhCW?=
 =?us-ascii?Q?gkAyJ9ZSqOOoLDuDp8U6ru/fz0O8JybUwW88Ikr1HrLH8srlECdXoATfXy2o?=
 =?us-ascii?Q?H+YVp/2YPqQ6SQjvxzfTMcI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c30104-315a-4719-5bf3-08d9daf2ba21
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 02:23:48.8699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1h3n5PM15IZyNO2WltPYk0oFtJkX3KCumTv98hl25XkKdvuTUA/OmM+njSI8LnRIMeLnbVcEVfpMLXHJ3rPgFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 4/9] remoteproc: imx_rproc: ignore create mem entry f=
or
> resource table
>=20
> On Tue, Jan 11, 2022 at 11:33:28AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
>=20
> The "ignore" in the title should have a capital 'I'.

Fix in V2

>=20
> > resource table will not be used for memory allocation, no need to
> > create
>=20
> s/resource/Resource

Fix in V2.

>=20
> > rproc mem entry.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 75fde16f80a4..7b2578177ea8
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
> >  		if (!strcmp(it.node->name, "vdev0buffer"))
> >  			continue;
> >
> > +		if (!strncmp(it.node->name, "rsc-table", strlen("rsc-table")))
> > +			continue;
> > +
>=20
> This is a bug fix that should be in a separate patch with a "Fixes:" tag.

ok.

Thanks,
Peng.

>=20
> >  		rmem =3D of_reserved_mem_lookup(it.node);
> >  		if (!rmem) {
> >  			dev_err(priv->dev, "unable to acquire memory-region\n");
> > --
> > 2.25.1
> >
