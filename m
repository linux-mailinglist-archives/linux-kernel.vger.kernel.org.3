Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51FF5378C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiE3JIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiE3JIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:08:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8923F54BE4;
        Mon, 30 May 2022 02:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hs8TbQkD8CbwoiEfco6CL6Z/Eu/rk6vz4ShmIXHqjzfNdLH5CB5kSk58s9X7LEQWnKTO3Ub0pY730oATaNqEmbjUKL79Ox224f4lxW9UWC/N4v8u5W2SQJxQgtoSfInBkSMcvj+lNjyBASIeH0leQh4sHVnA2hIVM+Q7KnWAxx16/PBNSstdEaD17k/JldsXEMxxrOMXc4Uz8ZwMoYpXIOQvXNHmidBmdhWdCdBX1tKUOolbNxkMCM/rGEgkrhAKGjLjvat95L9Qt4wjPaEqeE85Dlz0DgbWTACFrPdOfCj4UIoXLb4Dgk57HR5lRMVhL1yODjptNPLl4q8LbHFTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoGrtKa99HOi+yJX00bYSFJOOEHVeYBBLSjzCEkCOQE=;
 b=Df33M07qLh/7qxPC4AL17Lu+mG7Wz47WV3TFrEqwaDgXUDt9v1PjDFlIT3SYTqIxk7Qnw8NoDsBRx+a8IUwfFx91GfYx4rcvFR1L32CBs1u7SWdcUQMltwdnxdghiHY18eKeCoCjG10LGd0VHJZ+LQOqQf8Qy2rklMdJJICgS51Zznvl/xpBcpq9rBwEpk9GvDCO8viguKMQbQB9aHRISnXJqVHHAsl5HIaiVFihQsRiNRP4fYb+4rbYqjXXZV+LyKmiWMkGpzmooDwWmbu+DkHopryqOLGXQiqV5P6z5Y6Bybq6JlXiexvH+GLkQS60HKHFSTsS+SLp46N3mqpxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoGrtKa99HOi+yJX00bYSFJOOEHVeYBBLSjzCEkCOQE=;
 b=oOmyegNyH5hi/J5O+ubbE8Paw0UJOWvbVphOIOjwblPd//MlwEWOnuXbZSi7uzfSO0oUkQv/hYnzG+7r1wH/DwajrtIrEwan+SnUuNxbMCiS9UKJE2KJtmdj8pEEknHNHo+3iCy550CjWN+EO0SD5uVL7wB/0ZG9crcU3O+gw4g=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR0401MB2264.eurprd04.prod.outlook.com (2603:10a6:4:47::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 09:08:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 09:08:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ying Liu <victor.liu@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] clk: imx: clk-fracn-gppll: Return rate in rate table
 properly in ->recalc_rate()
Thread-Topic: [PATCH] clk: imx: clk-fracn-gppll: Return rate in rate table
 properly in ->recalc_rate()
Thread-Index: AQHYcysk8scyJR0TpECnZjgChwVXYq02rbAwgAB1aKA=
Date:   Mon, 30 May 2022 09:08:45 +0000
Message-ID: <DU0PR04MB94172EA72CC1D6DEFE03CEAD88DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220529071156.2511568-1-victor.liu@nxp.com>
 <DU0PR04MB94172CDB8AE355ACB0AFF0CF88DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94172CDB8AE355ACB0AFF0CF88DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9792dcbd-fbc6-4d0c-dba0-08da421c0063
x-ms-traffictypediagnostic: DB6PR0401MB2264:EE_
x-microsoft-antispam-prvs: <DB6PR0401MB2264E39CB58BB4DD265AEC4688DD9@DB6PR0401MB2264.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PaKKh2VTXhe8whii2vrTH85IJwIvKltGxF1rSt6NSegomxi+nGhIT/nRs0O1guOEbeJmhyudUPi9u/ixKswT+AGY9HJbOX1TCdgKc8p60FOumUPEbvN3N+HrnLfwAEIAPAjZUeLehB01OIUS1sMvT7PtmQuFZwC++vlvU0QXezcpWP2KciPvpuESJxsjVVszLeWhlpNfcgXX67JuCnNVjHiD95AoywnO6ZsJ/Yxeal6XOyy5Db3sXKTJ+ssH0oYozlJrBJNOcvB2m6er2o+81rq7rApnk5p/Ew6Ac2Id1StD4s/VsT2zVDCEWLh5lZY8tz+qYbhrTnyIKDH3fne4oeBC3xuYV264RsT5SXl1MnVCdhsE/HFMWdVfBZbjzJ1XJFo9+742UaJ2Fj9AaGRe+rAKNXFpewzHBFMmAEZx1iQe0evGXHiQyys/lCTpqTaB+/o/RlqVtaqRPB80cwCv5wONTVZnMcx1PAFt2XWs0h4EDEhpqogXNEWwhnFW3F05mQcgsF0UONUWMx08LTWKggmUj4TnzNXaxapDGKVtS2aBiX1YZbn/fxRy3wM2sL+ko+fYjmlSuWyr0QQQrOhGr7KoYJyrCEF9M/Og7BJL25T4aBzE6RS+wbK0KfXSe/B6VsJeTcym/PqNW6A6xsjrRBoW4YEV/+AOSgaFtDcEkGrI6O01MGGMxNFcMpccFGHvZgE3agWUEkeupWxKONyf6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(52536014)(508600001)(33656002)(54906003)(122000001)(110136005)(55016003)(316002)(38070700005)(66476007)(66556008)(66446008)(64756008)(8676002)(4326008)(66946007)(44832011)(2940100002)(2906002)(86362001)(5660300002)(76116006)(83380400001)(9686003)(26005)(6506007)(7696005)(186003)(8936002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RiBi88rETnRb2JfFd8IC5iVUBRgXMaObVst/QNJ9+tolqrKc7S6I2NKGS9nx?=
 =?us-ascii?Q?to4k0AqAicWb0yfWvKmImzo1zvPYjr1xu1YRm4vW34L1nR6b1b2hy5CJ4nui?=
 =?us-ascii?Q?HfkZ2yGyyPq1yn6JUCwLuikKMs9AQRvVIwNcz0ehtEt//Z/YWUgQFkz9eYD7?=
 =?us-ascii?Q?5QME9XI7isXcniguOps0/KOAmm+sqf5kQkoeqLkJfLKaJgNqJRBr6+oGpkx/?=
 =?us-ascii?Q?cRiD+V2jHhnjS1sH1bwDiaMbwcaz4SJrJmNlnLMvfaolWH0LVU88Zw62p8VO?=
 =?us-ascii?Q?FDmiCQIp2/qVggEZLxR8wcnzPs5OoeZvY0kiooqJki7YnL5FE+PN1JfRYdtt?=
 =?us-ascii?Q?SdLW78CIIzzMUX4MEAULYG+d1EiNQ3U+KJgDdSjfY8SBECkSaMStSqJ02g0+?=
 =?us-ascii?Q?70E54JOcd3Kagy/M4VisgE/6kr06nRmFw/to0XIm44LinEzEhkF1rzfIhESU?=
 =?us-ascii?Q?cQ+LH96oun4msW+rNu13PCYeTLwjxSeUqhs0on+MQ2qCMmx2+Pgh0BZRsOh7?=
 =?us-ascii?Q?UYaBA9TNafnM+265AfLAn8qFUezAMIQ6ATJoLwcPlCIc4NcjswJWA45iqfkc?=
 =?us-ascii?Q?oXrY3K41ZyE3xB+a+i+dqNeBtouS1uaJ/wsVC5Jorvc9SldfjU8XJKYtkA+F?=
 =?us-ascii?Q?s1ZnhyVwU3ZgyTGo3b4MOT99CZi7t9sTx+zjskfyB+mkpVumzzhIHrs2OvW/?=
 =?us-ascii?Q?yLu4f66NNQIgIso9WvvAD7YGq5BHp01ZyaVPMdt0S1tFuVq2++PyNRrlofcm?=
 =?us-ascii?Q?18E8ASoaDKYSab9U86wAZPqLpTlGWlckqWPEnZO1J/fHo/WT3MNQGVPWbS1O?=
 =?us-ascii?Q?klaYOE4gTY7acw12xs+siSoEpcfXNs+f87984zSUou6ZmHVHFDmRFU7YY9Qq?=
 =?us-ascii?Q?8MXd1lvfOMlaYW3eRw5fETiO+BXr/XpNjZzNNC4U5QBTd/kypZiJl+qQxoCg?=
 =?us-ascii?Q?Dn6fE9Co4fJz2ll+xgRuGMeHVW3bKXydMGhMyUzpWkQRyJOTGZIHMN9Jd/F+?=
 =?us-ascii?Q?ZO2LKQcO2K0qf9b4zx8idArxo2oGumqaWIvraD/YRaMNvkVp1Eeg2+im89QV?=
 =?us-ascii?Q?ijVFCE99gEiOjBG9DKniSJALOgoYshKLyU0dVk+vEg5wnlctCzxTANyDMOy7?=
 =?us-ascii?Q?8mM4d9KZj9cHXks8GQGpbZ2iwRSziaFTxtY5wEw4TIca3CVTEWxOA2xLThFF?=
 =?us-ascii?Q?RonwfoEo7l3CvCIeD3PI1fi/Sf6wq1NzSADCEUrB1u3OgRU0fMUn3ty3nrj1?=
 =?us-ascii?Q?EJB1qXuKYNS1mzDiOCWFLRO3IWqHq46UBdND1tsqz2ewJAmp7Yg+jNvdKRas?=
 =?us-ascii?Q?jtfWP93jl8SO3B6ozYC7HCNtkQAszgDJKdmC6YnXnCCj4N3if84T64NnxeOB?=
 =?us-ascii?Q?dqP5YJiTfYhA/yoIPXSNwPcRXyz5VjqQGYB3LIKN+xnHmlhwjR+QDPBBBjaJ?=
 =?us-ascii?Q?MZ1hiYqhGDprXnPX6XzlIpxJSc87r2V8KkjYXFCWmbqVnxMRdjxWYHL75ogJ?=
 =?us-ascii?Q?0un5vOCpgTdT1iZI0hZqnPqonMLoS5lRncSKEpwAld+w4tFy6GayQG5OKeM8?=
 =?us-ascii?Q?YGSr9+KRX+QTHqDadkIbUtNmR8UlTAFB/OI+aF0LT5OPpxFjAWQuqdGrQFyo?=
 =?us-ascii?Q?Uv4Zr3C6Jts2cIKrHi02aFeZw6R0D9bViSQhdzmK32vWnXccWIZkan0ttUOY?=
 =?us-ascii?Q?B4xt0DwHoILbpc921Hjyef5XPUywXBfwSHQJNMBgdwvth78b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9792dcbd-fbc6-4d0c-dba0-08da421c0063
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 09:08:45.8783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBGUrjPzvPq0oOjxGzJ9UVG7o+K96+qJ++paRH9ZfY5oh5uCv4elWe5uephHvgfB9luxzropa2gn1CH09/xXYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [PATCH] clk: imx: clk-fracn-gppll: Return rate in rate table=
 properly
> in ->recalc_rate()
>=20
> > Subject: [PATCH] clk: imx: clk-fracn-gppll: Return rate in rate table
> > properly in
> > ->recalc_rate()
> >
> > The PLL parameters in rate table should be directly compared with
> > those read from PLL registers instead of the cooked ones.
> >
> > Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
> > Cc: Abel Vesa <abel.vesa@nxp.com>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
>=20
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>=20
> > ---
> >  drivers/clk/imx/clk-fracn-gppll.c | 24 +++++++++++++-----------
> >  1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-fracn-gppll.c
> > b/drivers/clk/imx/clk-fracn-gppll.c
> > index 71c102d950ab..762b07dd5a6d 100644
> > --- a/drivers/clk/imx/clk-fracn-gppll.c
> > +++ b/drivers/clk/imx/clk-fracn-gppll.c
> > @@ -131,18 +131,7 @@ static unsigned long
> > clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned lon
> >  	mfi =3D FIELD_GET(PLL_MFI_MASK, pll_div);
> >
> >  	rdiv =3D FIELD_GET(PLL_RDIV_MASK, pll_div);
> > -	rdiv =3D rdiv + 1;
> >  	odiv =3D FIELD_GET(PLL_ODIV_MASK, pll_div);
> > -	switch (odiv) {
> > -	case 0:
> > -		odiv =3D 2;
> > -		break;
> > -	case 1:
> > -		odiv =3D 3;
> > -		break;
> > -	default:
> > -		break;
> > -	}
> >
> >  	/*
> >  	 * Sometimes, the recalculated rate has deviation due to @@ -160,6
> > +149,19 @@ static unsigned long clk_fracn_gppll_recalc_rate(struct
> > +clk_hw
> > *hw, unsigned lon
> >  	if (rate)
> >  		return (unsigned long)rate;
> >
> > +	rdiv =3D rdiv + 1;

After check more:
According to doc, needs add a check here:
if (!rdiv)
 rdiv =3D rdiv + 1;

Regards,
Peng.
> > +
> > +	switch (odiv) {
> > +	case 0:
> > +		odiv =3D 2;
> > +		break;
> > +	case 1:
> > +		odiv =3D 3;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> >  	/* Fvco =3D Fref * (MFI + MFN / MFD) */
> >  	fvco =3D fvco * mfi * mfd + fvco * mfn;
> >  	do_div(fvco, mfd * rdiv * odiv);
> > --
> > 2.25.1

