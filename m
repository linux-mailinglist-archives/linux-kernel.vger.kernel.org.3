Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42853737B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiE3CIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 22:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiE3CIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 22:08:07 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20075.outbound.protection.outlook.com [40.107.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279A85002A;
        Sun, 29 May 2022 19:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI6yyouttMJcO6EuX6sB8R0BRxfo9xQ8PGff3XV4aVm+GpXPCF4qo381QfjVeKdSXCQhDfT/R9gpC4p/vbQhsoAXG5TlfgrYrODEksIrluT3wYVcwoywxcVlBtD0VkWfa3Oxzfr+VIaThfN2ev0C0M83EDZkIPWouz0NvW1DALJQjem+RP+W2cIwrOvaK6Ddi054932/b4d4vlbIA4RHbPxO8Y+zJgdYmcusRFaYaYuVHvB8yXexGzhWwI9V9waZ3od1WelvmxmUI9jqlw5W7FTj2Iiswq8Bo8MoVgc9yPTdP0DlSaXYq5yPpwHlzgklVKBQ6yA9RG0lZpsbs6gjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZnLkgce0XkOOgPhGa84lDBZwanPNwhFh+rxckk3A7g=;
 b=ioDTbpjf+LcirTTBADsz4OJ8iVYL2Ua8U6zn5hwl3qiIGIwhtzElHkPSpfFaTGgDafjW6vjXmaCZ1hME4y6hfwEIb+EJWWs3sY3aTTouxW/cZBBOjEA5sksCwEc/VdntTYMkeDpIhxgjJQRhZjrThbCOL4rd5sR4WJAYMLFMTLUhkXWM4Q6fw+HFfNNaMOXEGrjoEntLt8JOXAOYQ/8HRHKj1RJ+4oCKR6DQ6eNPIouJN9WL6R/FQuzhUPDIlyUDzFX4Im8d1OOw6HBIzLW7rZE3aaURb3fcG9BnrtX6YRaMzAsaXKK5nYNhxmw62Br8Tzib3JG6mzTMAf3XBzVK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZnLkgce0XkOOgPhGa84lDBZwanPNwhFh+rxckk3A7g=;
 b=QAcHYn0segs3OFHrY8jTNQInqBLHmmhouNWs0ZgUpqFzVKq3RtN+uXcgkUDq1+4HY73hkzPIwuiwfDQU3U2AUw/WOjxrs8EIcTnM4uc9ERGiZ7+SsoAJPHwGoCCB1q0PJauNX5AJNZGOdhGCos5sBpjGdV301Vk3upVltWxoyhw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0401MB2396.eurprd04.prod.outlook.com (2603:10a6:3:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 02:08:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 02:08:02 +0000
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
Thread-Index: AQHYcysk8scyJR0TpECnZjgChwVXYq02rbAw
Date:   Mon, 30 May 2022 02:08:01 +0000
Message-ID: <DU0PR04MB94172CDB8AE355ACB0AFF0CF88DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220529071156.2511568-1-victor.liu@nxp.com>
In-Reply-To: <20220529071156.2511568-1-victor.liu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d96e4440-6fae-4d92-764c-08da41e139cd
x-ms-traffictypediagnostic: HE1PR0401MB2396:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB2396EDC49FD71247E3148EEE88DD9@HE1PR0401MB2396.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ohIm6ww8ieujV/ikXfyNAK1vvtWjQywXKCpvEj7fX6xuENkH7GT9NzeUGy4J9xHH+7aDb4T7z0DoiSj3r2v/PCGaRCDR32fnkXbnxiprHOK5eLdidc/mL5VrY4NyBCiAotd+OspyhEzbZPYVgIqh2jmXuIJqkeVUdGMHBAAs15Eb6OfPmbMVo7jw/zMCPtP0tf/yQn5b6BgFukV7K14k+R1n2kmbaJoHVn8g8ce149OgNWSpSAojJ3W7SN8mSnaqzzd6INQXU12L6U2ZpYwCxQycpA/wtrwJWrB8iXk/iyWaHuz7utGESns9KPWoRda2xYhltAvlq25xNgt8vAGaytD0uz13NetrvDGzv6V8sAf3TUne7sUO/qQryEKP3SfRP2ldGGwGs2wv6mVc2zetXrab94+4YjeeBnf8/rgc9Y4L0i1zvlg9PEip+bVA2SzBxuMLya1Pf19B+u3kHrUCF5U6MptDZkmKb8thbdhufAOFtV/Sy6toYFZzIlp9be8HnICGF/fH9IqJLFHvG/TTh6biiSSNzG1xxVEVc3uQ6wUMQTdSbfsnVjx/2Dwb5KiMOhYANyrDhqpyx28OWmfVBd7JEY0JjGF+hDjzGRXNtqDrIgTkwpcorEThy2MEjc2XZAE1FQlUVvTAhFTTLeAmP9+MWgsVk6oOX3GW2SCGrmWDQFS5cjhgP9uYUDraVVvlf2M7WkLCF/AVMLec57dBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(2906002)(316002)(9686003)(26005)(110136005)(54906003)(122000001)(38070700005)(83380400001)(55016003)(52536014)(66946007)(8936002)(5660300002)(38100700002)(86362001)(4326008)(66446008)(64756008)(66556008)(76116006)(44832011)(66476007)(8676002)(508600001)(33656002)(71200400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rZA6rty0imRtJmoa87Mg6kD9nzL7dKqKRqN2+rqOcQUx7NO45zp76LvCyzCu?=
 =?us-ascii?Q?BGLWZ3z0sSoiHJLCNIMvhALdxdDewsLNyuBWKqryLTueaV12qYKG9iIzpI/a?=
 =?us-ascii?Q?ddJG0NTNqZGqRsgEa9uPTd5Kmy58g0Tb1jmR0bwCtkh/MvTnmoGxrp5JyHud?=
 =?us-ascii?Q?wPHO7bLJoGFkEf2FIHVKIg7JFllTaBCesm6w2aZKKh2csLyZAKSXi9yksmdO?=
 =?us-ascii?Q?bWRrQ0GO1EGq2fzem80ncEvpnxnS4P42xRBv13wKiEQmnh9iaoV7JYUyaVUy?=
 =?us-ascii?Q?kBxP3XeZMh3gOq7sy8k/2uwImlTCxXyniUwAdy9Qke0eGYX8L5T/bn1NWX6E?=
 =?us-ascii?Q?HaqNICVaxpMSQHkSI/gPVjeDKcIp+vzIjrU9Ms1YYRAmG0NHzMsgT4mBzqbd?=
 =?us-ascii?Q?YRWI/hFkB5UL4uVOzhO8/wg3igKN+6ryrmkwh8KjeiVS91swdxBdG7hHfklY?=
 =?us-ascii?Q?IXT0um1dsseUuo6xC/+VovtdbBRVz45jOharGOCQOwReSLxrVvmNy9sNV1Uk?=
 =?us-ascii?Q?qXYHKGizG0KVrE39ntd65MqgF6HnsKIKMKfVP4spj7Mk3WeV0ifHkvRqhE9f?=
 =?us-ascii?Q?B7WNr9Hdn98eITxtamSlT/FDW+bWJqAuUyZVdbTYf0hb4TKfub4OLUHCHWb9?=
 =?us-ascii?Q?fZZFlr66CtBi8lY1CfVGRDHVmzouC9BHcQtmpbwWqm9iXKq3XhOHUrTqvM5Z?=
 =?us-ascii?Q?NEf3S8GjNnCRRvKVbGiEv45rgyY56VWz31r+ITqeUrAiCo6eo3EzrB6B5ZzO?=
 =?us-ascii?Q?yM0Qohdqi4/Sj+Gfitzf1e65XvfFUrxBNCNHAtEuCPPbdDcUNy7gJBzsYJq9?=
 =?us-ascii?Q?gAKEBRkS0a1ItIjeWw72DPqw+0m8T88ho9ZOHDqbIgNOim2EFsh20jpefuot?=
 =?us-ascii?Q?/cZK90x8W7/RjB1rlF2atsBmNimAFBmn86JO577shKQtNRb1reB/Jjij8Flu?=
 =?us-ascii?Q?jnt3ptydT6eW5aAPc6+8RlzlkWPGSWskEOfe43/PtHMVaqNcdw8znLvEm2y2?=
 =?us-ascii?Q?pFCRdOYIeF5YbSu/BwYUNhkpRZXbFn+vxWqisOTdIZeZ/1DR3za5W9kMosrx?=
 =?us-ascii?Q?zoVrR/X2tNs11NZ9iEv+fJMrra1geJwmVeJoXB1CDo1HOQTXj5A4aBgIJJQ2?=
 =?us-ascii?Q?DvL149eoksfdhNysy4YNwrUun7idRXCk5zCkpzWy1+YnqzEYKN4RtlkevUoY?=
 =?us-ascii?Q?YcCDvtl81ndXOIPYB6TUu7OmszJvZiSoPtdNdfiHE2mpcgpQiJaMAV26/GmR?=
 =?us-ascii?Q?w6WgVlyPEItVfS3hTrgQ4NuQnEu7VRCwdXqZNNSSQ6oxYNIgytsVZvBq7+yd?=
 =?us-ascii?Q?sIuFepuacBNpxlxjBJEJfQv0JS62mDCtSFJnD9eVZEnrtbgvXp5jBz62SsrT?=
 =?us-ascii?Q?LZRC8mG4d68GWt6tuIYhI2m1P3mWK676ObhFicXTJNZsdhIGPiHZZexL1gI1?=
 =?us-ascii?Q?MU0gzEeSmANtEyoVwwabTYMA0UCmiTJ/IjdScwk54iEhI/Euk3ZvZ8zaGzN4?=
 =?us-ascii?Q?FS/6xdcMzr48Ql6jt4Dk5LtWLMbcYRd5JnckAUX4TWt65S+Ec2297ehMwEnB?=
 =?us-ascii?Q?wfz93k2hjJ3HVM69F6du3O+PrViooDfGYXlu0I/EfLAVctTmw7vDeNiZGnHu?=
 =?us-ascii?Q?PIZHgq3ub6gsBH8vUSWas6i9m3cHi3PwYP28YbatPtqekq4gNd/mBxTzkqwp?=
 =?us-ascii?Q?eBC+4oGU9hvTdP/66fYJKHmGbg3a/CgCazOyhyUjSoEs9nLn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96e4440-6fae-4d92-764c-08da41e139cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 02:08:01.9246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8R+Hvf1E6Rh4UiIOEQOMTn6RFa6LSem/aR0fxkC5ZM/bSsq1k3/CpKSARkY6EzfK2tIP0ztnrFVWL5jBjn10cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: imx: clk-fracn-gppll: Return rate in rate table pro=
perly in
> ->recalc_rate()
>=20
> The PLL parameters in rate table should be directly compared with those r=
ead
> from PLL registers instead of the cooked ones.
>=20
> Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
> Cc: Abel Vesa <abel.vesa@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/clk/imx/clk-fracn-gppll.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-frac=
n-gppll.c
> index 71c102d950ab..762b07dd5a6d 100644
> --- a/drivers/clk/imx/clk-fracn-gppll.c
> +++ b/drivers/clk/imx/clk-fracn-gppll.c
> @@ -131,18 +131,7 @@ static unsigned long
> clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned lon
>  	mfi =3D FIELD_GET(PLL_MFI_MASK, pll_div);
>=20
>  	rdiv =3D FIELD_GET(PLL_RDIV_MASK, pll_div);
> -	rdiv =3D rdiv + 1;
>  	odiv =3D FIELD_GET(PLL_ODIV_MASK, pll_div);
> -	switch (odiv) {
> -	case 0:
> -		odiv =3D 2;
> -		break;
> -	case 1:
> -		odiv =3D 3;
> -		break;
> -	default:
> -		break;
> -	}
>=20
>  	/*
>  	 * Sometimes, the recalculated rate has deviation due to @@ -160,6
> +149,19 @@ static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw
> *hw, unsigned lon
>  	if (rate)
>  		return (unsigned long)rate;
>=20
> +	rdiv =3D rdiv + 1;
> +
> +	switch (odiv) {
> +	case 0:
> +		odiv =3D 2;
> +		break;
> +	case 1:
> +		odiv =3D 3;
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	/* Fvco =3D Fref * (MFI + MFN / MFD) */
>  	fvco =3D fvco * mfi * mfd + fvco * mfn;
>  	do_div(fvco, mfd * rdiv * odiv);
> --
> 2.25.1

