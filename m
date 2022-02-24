Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC02B4C292A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiBXKUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiBXKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:20:48 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C9028A11F;
        Thu, 24 Feb 2022 02:20:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAxLOinN9CcY+jD8Gu/z5kq7vH+W0Yx3N6j6rNIPWF2zdzMroOgr98WM1xw7t4BMiLy/n0qR2yzrRkOM92FJD17ZNfOc0/jvwKMjaHa93slWddoYJNvyyWME39Um5w9qSN75CyxFDD84Dp/zNy2M9B4f0SZs4/DPm6JDYU6A485/H8s257XMfxuMVLKag2vj5oF0qchRUAlFFCFztP6WdkLs5H0AUkdQu00OpaN/TcHHSz2jvs+bynVgMONKHKMbmN6d/0dqg964D2Wu5fLc2oOoy/l5EdjIy3DcuebFYyivBU2vE8WJdcI3A91kM28jmcN9iUtvVi4xaf8eCCLxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBVcgPoFtyX2iIjf00/GfidY9WTPCpYM4gjPChYqyoE=;
 b=LgEWCmYaHLODJ9aMhQIYVn1kTWnj0uksVqSOZwicTRajhKdcOaimaCbf1v4TK6Ppis0/guGV1s/5Y4QyB7Vet6TPYi61tlInWgKKV5z63vmda/I+1m2PZ81uFdSpdBz927dUO/8Ob8DYCiX+YlKH8iZYruy8UnqU2R+V3gLxbc6YAktdFQhpRVhaSHGXYVVyt8WMXLoK7x6sJUU6Id/W9kEQER7hSB0uJ9uzFqAmIAPvf+D4eWGq1qd5n2rBtD8dqmQaqFqP2Hs4LSzTxOdcoA4Vi9wokmCUzGPSv6dsUijy+otizszQ/tsidmRDxDpE8Bw2fijTZAqRN82Joqae0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBVcgPoFtyX2iIjf00/GfidY9WTPCpYM4gjPChYqyoE=;
 b=AUw1BFSoi1dT6SKN41hBHKpsecL+xH7N3Qz7qPzpB6b5aFgIHsH5zJntbnXyYYei3Ph/N/VMTocsmKl/GmguUbouLsP434C0eVQsfaJJjxINHk4s/Km0evhGho8W3p1+d/yAxUpCHd1jf7st8r1LeDn71AK9bmjsCwwk36mHzgk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4848.eurprd04.prod.outlook.com (2603:10a6:803:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 10:20:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Thu, 24 Feb 2022
 10:20:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 4/5] clk: imx: support fracn gppll
Thread-Topic: [PATCH V4 4/5] clk: imx: support fracn gppll
Thread-Index: AQHYKVeDcUA6Pi9WzEOtFHRx7YSdRKyid4oAgAAFNAA=
Date:   Thu, 24 Feb 2022 10:20:15 +0000
Message-ID: <DU0PR04MB9417B2F5C1640FB23EFABF2E883D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
 <20220224082251.1397754-5-peng.fan@oss.nxp.com>
 <20220224095846.GT9136@pengutronix.de>
In-Reply-To: <20220224095846.GT9136@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c477e95-a4c5-4b96-fc89-08d9f77f3fcf
x-ms-traffictypediagnostic: VI1PR04MB4848:EE_
x-microsoft-antispam-prvs: <VI1PR04MB48489A45DA921580DA7D2878883D9@VI1PR04MB4848.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: si4VdWBcUQTgMoprGsnACV/HNU+AGrAbRgWydwGc64lvZEEV1VQMkQNoOOZDs479nh5ALhUKHwbfldIFGLLD2QrfMIKZKR1nhvVH0LnZz7ik1jQ/7oKSlG66hQucPJZHRmq4V0ECbeD/U4+PMALK42PezXaMVAmb5ipanAE2YPGsq2NC2HWabVfrbCzDB2Fq62Q9QJc2bXp9+fWOZWiGAxoFt1TFqXNF0ir+gyr+FXUeOTW+Qbgd5jgJJLOs1Nokn4irt4eiO+lv5CGaCTnuo8sQgiBu0gFizz7f8rscLlNJPOPP6X45pCE3RiC6IPWcfqKf7JDofn1jH+nJNBEvGZWqESozRruxib4ZqNMNJTbJ9nRcVci8Chtg2PD0M3SiKeLeSrSnZUJaGc7jow/Y7w/sQQCe58+bKb6bu5Qe/dGOeBrB2zeJVibmlyOzbMD0mMt06jbYIv5biEAv6nvWVQcSgUTbL2ioaYq+lUtbBhBCjVrXnQxCF5Vz46pZ6OmQQsYnrQkhfUrVWTcRrABkP2vvCCiNyNxGh45jCcm3/xrSUL7MuP/7gpGQhC6+LWXyI/P7yl7lNzeqosSrLJcfOnaW2AB4REgeEBcXK3Ox1OTvYLmb6gxGTiKQgui486Hm8zPXtTcL41OaPwjUn9wjdeGE/q5cq70fCE9hM8cRqwvyJ++TVsR2pGVTjI+qMLX1XNt2UpvcqhYYF+yJnGDMhKliFARtCQmZKQpBP+4PzikqMo7wbHPEOFnYqc3YLvJKIVeOBmwasWZ4BCKmMxBO4YI6gFtwYvGuc1/c4HKRm7I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(54906003)(26005)(71200400001)(33656002)(110136005)(7696005)(186003)(55016003)(966005)(86362001)(83380400001)(122000001)(38100700002)(66946007)(38070700005)(45080400002)(508600001)(7416002)(2906002)(6506007)(9686003)(52536014)(76116006)(5660300002)(8676002)(4326008)(66556008)(66446008)(64756008)(66476007)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pZNd4qSHwYhk4wQ/4fB3LBFC6fjp32mlU4Wyk6if1k7g4g6dqNifzJzro33u?=
 =?us-ascii?Q?5CvqJHw9Wv49qmxTGZu03eX1qcBI89PKR9I8+X3vGzcCzAcjxL372veAdhsr?=
 =?us-ascii?Q?hJLas25RTBq+lVujD+KH9crBLgqsaZbpQKqDOp3yXtcHjRI1Ci/S+YDNdBEd?=
 =?us-ascii?Q?NV3Q9T/WwOV8uzfMfArN/ti+1PwUsClhap20NGY//S+2UAAEms0E0TYwJ3jX?=
 =?us-ascii?Q?ZeRez1CQoKbUdh0DTi58FMEL3gaOgtwCD/cfmdI6HxOGGSCamjVptpf8R/b6?=
 =?us-ascii?Q?8A/Q4nvvOYcXJwI5AlbA6TsScdPdnTHqHB9oXH3KZd293t+TNi1epmW+s9P9?=
 =?us-ascii?Q?b6Wa9TRxJFDG9NqwGZ9mBFiaNaMIL8JR6BWlq4QtGW81e4nPuzkZwZExjLiD?=
 =?us-ascii?Q?zEyFmkVy0tVqRuFVZahMw5Q3yIxAkaaCcGvrrge/EDu9FbE0JdcU1ofvXRx3?=
 =?us-ascii?Q?3RkiO5Z3blzM4G9dznygUQr79LaNrRwlDPVSLa+KjrgCiD1GV5EhoZ/hGLmC?=
 =?us-ascii?Q?kSubMhKQASquJqnx02S8238tJe9UgjUW4ZiYvM3KI6SJ75htoLNDPKRvLLeV?=
 =?us-ascii?Q?rEodaFEHmyoTrV8X2LJInohY/XqMqNcmpcmWPw9kZY7KJI5DQonDe5eBOCiA?=
 =?us-ascii?Q?LaZ5mrIGb7LsFeypGEKpv6LfbKRx3DRKHepF1CZxClgPsUKubfl7YHxdN6GU?=
 =?us-ascii?Q?fsTdcZ2vsH9zIvLIopcZyXsusviVbpMJInYaymMJHBA8KjfU02GzVWpoUSwI?=
 =?us-ascii?Q?VSCUBiNI3ItTAoKSSY8v496BXVoqPsk1YoIi+yUVgaR+agG5YorCUIS+hYSb?=
 =?us-ascii?Q?54H3lV/jxQAbgspfAi/pPy/T0UR9cXTTW1ByOo54PpbMlTgRu0CZhLpasuLA?=
 =?us-ascii?Q?SrqYNR1sTZHgZ1JyMMxKpplpXAQlQkk5ah+X0SXffcKHlMk/98K3jpPSvgMK?=
 =?us-ascii?Q?kaeYMPSeI93PAbwD/WeUecEibaSxOMIfL9FxMM6chTzNPDruPQlUPxHMdgKN?=
 =?us-ascii?Q?8sVNdccl/lXdEztPdqM29CrkJ4JwuwMwk1aptAexlwiD+KOXY1USddZ+ZdK8?=
 =?us-ascii?Q?wnbyY3n+Zr2f39aSd2GPREvcksgRvp9KDoffWMuIs08BkSHsHAiWmiK83lUP?=
 =?us-ascii?Q?ezL+Y1JjzE/s3lK1gOrkFOiYzcTVudd2xqucX9CrnHr76KxS00frvAmV4QHB?=
 =?us-ascii?Q?HsDB6VHJpwRvIUVaM0OGGn8ec6u5/ELT2thZxO+CccNsnrz7mDqtb50NqEsM?=
 =?us-ascii?Q?fLZJ3hcb5UXUIPPtQVAGazkrLZ0Hp/vAG3RBgXshN864QI0O3S2kTsH9Bo1Z?=
 =?us-ascii?Q?yQnwoIBMLW44Z+rCcXYLN6hXUTftVCmhyip0c4sR6ld/nAkgwUP2qg/rI6hZ?=
 =?us-ascii?Q?vBYyAPBEgI91Xi6BIEiJ4BHcaj5f9WeDXL62WHnDQQwrMMNysZKRSdQCrCr1?=
 =?us-ascii?Q?ki98tL5QCywmSAHV64XsP/kxWGl0/MUmI4+m7IzHXFsUgdgcP+DJM/azVFSv?=
 =?us-ascii?Q?FQ9hzOCS7Xv0z3JLStng1sEjiCHlW0ZKqZR4qUOylaRjcwGNPMy+R3s5bl1x?=
 =?us-ascii?Q?q7xFIhbB9OVGNEgtRx7ILkL61PGv+dYI6U782Qw2lUzHtT6/9J/vT1V3UJum?=
 =?us-ascii?Q?vlCCz8c5QmpHWLTxb8jbB4Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c477e95-a4c5-4b96-fc89-08d9f77f3fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 10:20:15.2200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DDVK0Gbn5gNuN7/jygAZUdnDjya+FQLBJIdKuNncX2URPaJliFia4IStDZXwDBUmF7bnKxB6FQfWslp9Q3TFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4848
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V4 4/5] clk: imx: support fracn gppll
>=20
> On Thu, Feb 24, 2022 at 04:22:50PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > This PLL module is a Fractional-N synthesizer, supporting 30-bit
> > numerator and denominator. Numerator is a signed number. It has
> > feature to adjust fractional portion of feedback divider dynamically.
> > This fracn gppll is used in i.MX93.
> >
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/Makefile          |   1 +
> >  drivers/clk/imx/clk-fracn-gppll.c | 326
> ++++++++++++++++++++++++++++++
> >  drivers/clk/imx/clk.h             |  21 ++
> >  3 files changed, 348 insertions(+)
> >  create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
> >
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile index
> > 36c04922d789..60c8a4bb7574 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -5,6 +5,7 @@ mxc-clk-objs +=3D clk-busy.o  mxc-clk-objs +=3D
> > clk-composite-7ulp.o  mxc-clk-objs +=3D clk-composite-8m.o  mxc-clk-obj=
s
> > +=3D clk-composite-93.o
> > +mxc-clk-objs +=3D clk-fracn-gppll.o
> >  mxc-clk-objs +=3D clk-cpu.o
> >  mxc-clk-objs +=3D clk-divider-gate.o
> >  mxc-clk-objs +=3D clk-fixup-div.o
> > diff --git a/drivers/clk/imx/clk-fracn-gppll.c
> > b/drivers/clk/imx/clk-fracn-gppll.c
> > new file mode 100644
> > index 000000000000..b6add3a2e472
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-fracn-gppll.c
> > @@ -0,0 +1,326 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2021 NXP
> > + */
> > +
> > +#include <asm/div64.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/export.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/slab.h>
> > +#include <linux/jiffies.h>
> > +
> > +#include "clk.h"
> > +
> > +#define PLL_CTRL		0x0
> > +#define CLKMUX_BYPASS		BIT(2)
> > +#define CLKMUX_EN		BIT(1)
> > +#define POWERUP_MASK		BIT(0)
> > +
> > +#define PLL_ANA_PRG		0x10
> > +#define PLL_SPREAD_SPECTRUM	0x30
> > +
> > +#define PLL_NUMERATOR		0x40
> > +#define PLL_MFN_MASK		GENMASK(31, 2)
> > +#define PLL_MFN_SHIFT		2
> > +
> > +#define PLL_DENOMINATOR		0x50
> > +#define PLL_MFD_MASK		GENMASK(29, 0)
> > +
> > +#define PLL_DIV			0x60
> > +#define PLL_MFI_MASK		GENMASK(24, 16)
>=20
> Is the MFI field really 9 bits wide? Could be, I don't have the reference=
 manual.
> It just looks like it could be a one-off.

Yes, 9 bits wide. MFI: 24-16
Integer portion of loop divider
Sets the value of the divider in the PLL feedback loop, and the value speci=
fied establishes the
multiplication factor applied to the reference frequency. Divider value =3D=
 MFI, where the chosen MFI does
not violate VCO frequency specifications.

>=20
> > +#define PLL_MFI_SHIFT		16
> > +#define PLL_RDIV_MASK		GENMASK(15, 13)
> > +#define PLL_RDIV_SHIFT		13
> > +#define PLL_ODIV_MASK		GENMASK(7, 0)
>=20
> The *_SHIFT defines can be removed.

ok

>=20
> > +static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long d=
rate,
> > +				    unsigned long prate)
> > +{
> > +	struct clk_fracn_gppll *pll =3D to_clk_fracn_gppll(hw);
> > +	const struct imx_fracn_gppll_rate_table *rate;
> > +	u32 tmp, pll_div, ana_mfn;
> > +	int ret;
> > +
> > +	rate =3D imx_get_pll_settings(pll, drate);
> > +
> > +	/* Disable output */
> > +	tmp =3D readl_relaxed(pll->base + PLL_CTRL);
> > +	tmp &=3D ~CLKMUX_EN;
> > +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> > +
> > +	/* Power Down */
> > +	tmp &=3D ~POWERUP_MASK;
> > +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> > +
> > +	/* Disable BYPASS */
> > +	tmp &=3D ~CLKMUX_BYPASS;
> > +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> > +
> > +	pll_div =3D FIELD_PREP(PLL_RDIV_MASK, rate->rdiv) | rate->odiv |
> > +		FIELD_PREP(PLL_MFI_MASK, rate->mfi);
> > +	writel_relaxed(pll_div, pll->base + PLL_DIV);
> > +	writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
> > +	writel_relaxed(rate->mfn << PLL_MFN_SHIFT, pll->base +
> > +PLL_NUMERATOR);
>=20
> FIELD_PREP

Fix in V5.

>=20
> > +
> > +	/* Wait for 5us according to fracn mode pll doc */
> > +	udelay(5);
> > +
> > +	/* Enable Powerup */
> > +	tmp |=3D POWERUP_MASK;
> > +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> > +
> > +	/* Wait Lock */
> > +	ret =3D clk_fracn_gppll_wait_lock(pll);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable output */
> > +	tmp |=3D CLKMUX_EN;
> > +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> > +
> > +	ana_mfn =3D (readl_relaxed(pll->base + PLL_STATUS) &
> PLL_MFN_MASK) >>
> > +PLL_MFN_SHIFT;
>=20
> FIELD_GET

Fix in V5.

Thanks,
Peng.

>=20
> Sascha
>=20
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.p
> engutronix.de%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C4dc747
> 31b1f34e99946108d9f77c488f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C637812935432676998%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> 00&amp;sdata=3D0MkuXWdHlLdazu63dgaTlqJdf1RJKwZcSeI2dnE0Uho%3D&am
> p;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone:
> +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
