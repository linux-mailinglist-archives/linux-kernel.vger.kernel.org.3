Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532C45B1818
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiIHJKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiIHJKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:10:09 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B871A193C2;
        Thu,  8 Sep 2022 02:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtfcLO89oPG2he7EjV5WAohdtgZyO3skYETIKUMqUvZ5XpwxYtbUOtOGcmP13E7dIzV9ZMJTsBNd7g8KOIEMlTx5x5gjOGP1b2/pyXN6CmN9FwT4d8U/OmHY2ZDBujcu6hLggZcMl4/fcyUX7zSAg+UaUY9G17Bf2BmLFOJOOrNpfQzb0j3xfwRqhucVTyDzPfINzhrczOmgt4CjhbucaiVL02BTd5qdP8J0W+c3Ee9+5oFdRfVNNMcW8F8ylvT3sddz1mxNbbmdl4FufATdrounKE4FAXXEEfefLHNuWZAs1TjzM6M/10j/NwIQn4K5O5/gvdlNycTOYhEUbG0NKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmIWa4XXeNc/0QWjLl/d8gbLFEsQ/Z9zrDxwLmlBomM=;
 b=D/N441/2e3s0NTJSaneHc/P1mvuozVhbVRZcEcC9e/O7xPRaiIJXVWvlnp9oRkfTU+eGLXfdSEf73uRD3yr2HuIyKiQqWysd+RpRQr07euckWNjpDXY/yd43wKWW2RTOlsqJtNVAwhOj9+3FwEkd0E7BnWHYMiPSy4/fxiAnWnG7F7p6zynzWf8qqaSYRHGFZJIvJHD8r3RebFg61mnmmgQ9VljlZzJa0pEk3Hz4QYbMXbmymaI3A1e9VCZ/iNezLPr3xVNS5c7sAwD9tYMB76haJVQQ2FGNExwaOVQCVN1LjMWm5Bgbql6BiXhllXt74HjG33DNR+hiJ5ZIaKbAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmIWa4XXeNc/0QWjLl/d8gbLFEsQ/Z9zrDxwLmlBomM=;
 b=mteB79iSCitnWy439BFzVLZsrnHEIHWXCZBqw3JDwDRY/c1Aky/BNX9P5lDmzYlVpkv3Vga+RgjPzaSPkCizfiIJByy8TQUSNMdIqMnrpGsh4dmuCaDw06IvN6szSjYdZPNbI7tm1+d/s2B1hpDhWHay3bbrfDki+UGf8/0gl64=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by AM6PR04MB5574.eurprd04.prod.outlook.com (2603:10a6:20b:28::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 09:10:04 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2%9]) with mapi id 15.20.5588.012; Thu, 8 Sep 2022
 09:10:03 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
Thread-Topic: [PATCH 2/4] usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
Thread-Index: AQHYwsihSZs59KCGmka6WpnUnAKPLq3VP1lQ
Date:   Thu, 8 Sep 2022 09:10:03 +0000
Message-ID: <PA4PR04MB96408D56303E7F88D85FE3F089409@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
 <20220907144624.2810117-3-alexander.stein@ew.tq-group.com>
In-Reply-To: <20220907144624.2810117-3-alexander.stein@ew.tq-group.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1c1f8d2-98f4-4cf3-3659-08da9179ea98
x-ms-traffictypediagnostic: AM6PR04MB5574:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZbaPamu/r3yofFP0//tQx2be+4L8vdIVTZfPe+Iwa8TpfC4AgU074m9rKEhQMoIYRv/SUkMxlpGS2wutzyHsLPTi5zbkjZmFkZXJcPm9oZBknDI1so2cPrJeX06nQCSYUbC1RNQmfcYmykxC74VVPYVNfLe2fmD6x1ZeFy+9UQHnDn0fh/MObjoo83JTGlDYlwd0FdLl37iP7LE1bAPHAoP7zzAS4yk0Bfz/MC/csQBCrKfqnDDFwL6Tj445Ii9X90tCC1416OEQtkJl/buqC7C4zVSOl1gJFBKv12s6zbcASOPBoYTNkxB54S35gnWpevOiSxfInqlXfIfU4ISuoX0dKQ7MaVm6FFcNRY9eXDi/om75k2VI0YDgqhOjCTjrLOSOwrRtwz0pXEmhRTlh7vn51wqvwJlLDwV/mKKaisN0IAXRkJ+1Vk/kcSUwm8mXY+7kzp4tD/ZHtpLCnSP5FzyTWlomGxaoPPev8KVMQpe+yojbPZLqahX5HMANd5f/LbcJ3nr0U+yqCv6aCLH7E6EEtcqulS8RjTii7+mnq0udiUg4dto+OSmdw28+BzAO+TRsZ/q2vomlMmAMDVd7DL7ZHtoP2UV04LNuTPvdv5SGuKFaURFkXDlOigMtNhlR2wrNZ0GvQgC0a9AMENZGz+XENiHcZlk/UHMgpZXzwYXa1Zr7mUBbmZpYgO4m/ixx8AjXSZixR434FKLDuqNEMv67/of2M7HYTFq7kCNZ/cR3tO7x4itzTVqxGyerEFyrqiOdWljepfCrxNsX0zYFDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(7696005)(38070700005)(83380400001)(71200400001)(54906003)(186003)(122000001)(110136005)(86362001)(6636002)(316002)(7416002)(52536014)(5660300002)(8936002)(76116006)(8676002)(66446008)(66556008)(26005)(478600001)(66946007)(66476007)(44832011)(4326008)(38100700002)(55016003)(64756008)(9686003)(33656002)(41300700001)(2906002)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X6tbgNLZBYsFDGseog/LiZ+ixwIE1hxx8Y+/rXMzmaHbsiTIuWQb0Fm8O7TY?=
 =?us-ascii?Q?4XP0ZfvwhXbg/7eDjIuXlUZST+5X5uy4QSiP5xkC+h+i2j/g0y+v96KG1Otl?=
 =?us-ascii?Q?xBpEMnOLmtZw1QRTidrMl/vryUKotzWQoajnV5c5O2P0IYQU6ro/1acMyS7a?=
 =?us-ascii?Q?64G/ScE6CjGaT1M/n9iL6kKOpyi+pzU0HG6MX/pj5cFdexy1gRhpFUcspISI?=
 =?us-ascii?Q?Ryl8gzfjhhyMs/mu7MO4RXb5sn1qINSkVuK3bDSNvdeYKJl4nwIYnzIxzbhU?=
 =?us-ascii?Q?z7HHv1pXTc80gEkGPsZj8VaMDBQU/dzRNhnSyNfl6Yhpyh8elBymrsawvN33?=
 =?us-ascii?Q?iij0p44paehP2KmW4cCAaLtu/4x1jy14K7trGXE74hwkEc8x229pfVfi13lL?=
 =?us-ascii?Q?cDvlla9mH9YI4ngmr0PJJ1TE+cogVhHYAAY+6GJF3nMUbuSsbdFLlXIQS/31?=
 =?us-ascii?Q?FuT9Q+vtKy4mBg14INr0u5ovhUZAX1Ei5967ENH1MEF0d+WdDOb797C7uTDn?=
 =?us-ascii?Q?fes9/9DkbbgfTrCv+ccMO7bzt7QVh6w4uBLOZFEoP175ypeRyjuwQ2vBVjo3?=
 =?us-ascii?Q?05ta4sABQvqkTjrpUUhxGp+fJ9E5hiYORMZ6h4MMrGmPkeaTb45RTGXdt5c1?=
 =?us-ascii?Q?RYivVhUBOjM6dnntDin9f3TwjQGFBCDZYKfW3DDl2HbyuHkyiLl5xmIEws6i?=
 =?us-ascii?Q?/V9KTNN74DFd0LXwEqbQP40GpuukMYq8Ef9iefBtPzlb8qMHnCNgUB+MR9Jp?=
 =?us-ascii?Q?XezJ7YobkagTOserugKp19nqoV2eJNby4VC405VHrWJrN6K9H9BtLqz/8jNZ?=
 =?us-ascii?Q?Ka6pmXzsy7BHGMK5pMY9iXd0FQzaGmEeAfOx+0Ghm3UJKbyGj2/i+vhFJ0qX?=
 =?us-ascii?Q?F5pj5VaWh9ihb9xRp67edmArkoNagM6YizNC94uEXxx6pVXpyldp2EVV4wBu?=
 =?us-ascii?Q?/BoyvlG0izxKrXH3OGFuejdYzN6258hxe2is4aMG8kUsup6SS7BUm4RqY8CV?=
 =?us-ascii?Q?Mb52tJVU9keMeVypW6xOARHVpu4hnmuw1GRafufYaZaXPLqmW20jD08I2eXM?=
 =?us-ascii?Q?BzM3sSW0VNhflgSJif3PTJWABFtjRyE6kj2ZFo0gqdYRfR5+ZRt0q1oYFX8o?=
 =?us-ascii?Q?WCBTkgvHccT3Zb8k8e8rCnIBsvFongL0Tt5t0oiUzHor+FG9hypSFTh9hqCy?=
 =?us-ascii?Q?BsBNYOn4usUz4wRrYP+P/SJT2fLiILseY5/3Xc67QHXdIdPjoRJRaomxLRSr?=
 =?us-ascii?Q?c/gHKW5UECTDq96f5oRVtINxwfUiszzozmQapz7/s7efAbBS6T+01lULU74c?=
 =?us-ascii?Q?S6w67qS73qTx2lu0O0+4M+VBkcBMZt8JL78GRrLMMGI1HtabnbIPBBGmofiN?=
 =?us-ascii?Q?Ck1OdKZi+XrBxJzIgIgMtNTbLlRr8KWU5BaGkAC/l/HAIIHKhj27jnZIe5vG?=
 =?us-ascii?Q?p1n2kpUbUJNq8K9LQP5jsy7Mn2MyIvdN9WzyU3Zrh7JUAncRidtdfUZLjNAw?=
 =?us-ascii?Q?pnsV0vcjDO4q1DirGJGuMxnTCkvrvjUp6P4tj+y8USVrZcMjggFz91v6ve/a?=
 =?us-ascii?Q?C/v4eHW0R6p0uGnNDkA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c1f8d2-98f4-4cf3-3659-08da9179ea98
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 09:10:03.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oH37ObJQ28MFg4EooeVBMAOsp4bVx63nnxFUw2nX2jP5jIR3OMx62wrc2Kj2qP3N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5574
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> Sent: Wednesday, September 7, 2022 10:46 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-imx
> <linux-imx@nxp.com>; Jun Li <jun.li@nxp.com>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>;
> linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH 2/4] usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
>=20
> This selects the SOF/ITP counter be running on ref_clk. As documented
> U2_FREECLK_EXISTS has to be set to 0 as well.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Li Jun <jun.li@nxp.com>

> ---
>  drivers/usb/dwc3/core.c | 8 +++++++-
>  drivers/usb/dwc3/core.h | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
> 8c8e32651473..12e8e7d34cb8 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -408,6 +408,10 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>  	reg |=3D FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
>  	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
>  	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
> +
> +	if (dwc->gfladj_refclk_lpm_sel)
> +		reg |=3D  DWC3_GFLADJ_REFCLK_LPM_SEL;
> +
>  	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);  }
>=20
> @@ -789,7 +793,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>  	else
>  		reg |=3D DWC3_GUSB2PHYCFG_ENBLSLPM;
>=20
> -	if (dwc->dis_u2_freeclk_exists_quirk)
> +	if (dwc->dis_u2_freeclk_exists_quirk || dwc->gfladj_refclk_lpm_sel)
>  		reg &=3D ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
>=20
>  	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg); @@ -1525,6 +1529,8
> @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  				"snps,dis-tx-ipgap-linecheck-quirk");
>  	dwc->parkmode_disable_ss_quirk =3D device_property_read_bool(dev,
>  				"snps,parkmode-disable-ss-quirk");
> +	dwc->gfladj_refclk_lpm_sel =3D device_property_read_bool(dev,
> +				"snps,gfladj-refclk-lpm-sel-quirk");
>=20
>  	dwc->tx_de_emphasis_quirk =3D device_property_read_bool(dev,
>  				"snps,tx_de_emphasis_quirk");
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
> 4fe4287dc934..11975a03316f 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -391,6 +391,7 @@
>  #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
>  #define DWC3_GFLADJ_30MHZ_MASK			0x3f
>  #define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
> +#define DWC3_GFLADJ_REFCLK_LPM_SEL		BIT(23)
>  #define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
>  #define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
>=20
> @@ -1312,6 +1313,7 @@ struct dwc3 {
>  	unsigned		dis_del_phy_power_chg_quirk:1;
>  	unsigned		dis_tx_ipgap_linecheck_quirk:1;
>  	unsigned		parkmode_disable_ss_quirk:1;
> +	unsigned		gfladj_refclk_lpm_sel:1;
>=20
>  	unsigned		tx_de_emphasis_quirk:1;
>  	unsigned		tx_de_emphasis:2;
> --
> 2.25.1

