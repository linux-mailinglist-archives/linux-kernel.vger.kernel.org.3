Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4DF59B7FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiHVDav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiHVDa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:30:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E6A1D331;
        Sun, 21 Aug 2022 20:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krAXQu7f2Znduo0Olv84ZiTXl3dw4dudGP9lYBgMr3v5X5booxVnQY+crYCkH3kchAtUh+cqySvIBozjtv22iYZFb6jyUZZSgxieXUVn8fbvVoQPYPHBDAke+LfD11SqqXsEY/GRbG6M++++W0zt9uGWRn2dtf+71kgpkUT1Sg49Rn9TpuQwg1bNLdbEYbh779t1tG3U20FKpq77hE5zic9jpU/NAP5cq3SA6tN5C8isCnbgA9vOOonwgX44CHcTpHgGMPaVqYiqIlJW267PWWX1WbrIT3TSgNHZFyBevGWCvG5VQvig3jO+hIIcxKPN6aETvPRO5JSjR2/X3Uwnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhBO3xv7DbIx1DnFyNIuGuGMf76qsduqspZRn4QEiW4=;
 b=FvfmsH90Kn4psNtQSIXSFgFWc90WZDZ0R0dCgbCTFBxCEMY/6CimLhx/9PhyNhQJTebntYtqVneS4jsTzv7JkizYXsMuJkQk67+k9DEPknEu0j9Qv+sNs7AGnvZyeDLblicaOCSvQOCltq6BGn3t/gCOSm23mGGbYr2cMtgoYzymsQlDDUC7Gzr1WB7ygFsOfDViuTJk5YJYgBJublcaXRrsobUavJPlFtkhS4mY+/Ae1Aac54kS+8mB6qzdAqZJ2dml2NwXdJ8+UwuqLtATdv12ySWAC7ovhJ/ypXYW6Btsvk4JV5j8OtoMEU6YmkHlmo0QCSUgF2+7Kh6nsgeM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhBO3xv7DbIx1DnFyNIuGuGMf76qsduqspZRn4QEiW4=;
 b=VuOnf2v1Wpg9Z1CrA2FuoXYHqkoSMqTQGfx/Jx/bKYohjSSYnwGYDbiE0wWgwuq6FlZuvrPgNwW+Mdrt7vZA3/JaIri07JDYAaH8mL+Ohs3dsfggbeepcLSHDoM/tTCu7fCzOtSQDTmf1Rt4ZHPCYsX/4YtLIYNmYXsog/QddfU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5481.eurprd04.prod.outlook.com (2603:10a6:10:88::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 03:30:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 03:30:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V6 3/6] soc: imx: add i.MX93 SRC power domain driver
Thread-Topic: [PATCH V6 3/6] soc: imx: add i.MX93 SRC power domain driver
Thread-Index: AQHYm0HxIxwAJLuCs0+ffYiCmB1+XK242rSAgAGcoAA=
Date:   Mon, 22 Aug 2022 03:30:24 +0000
Message-ID: <DU0PR04MB9417A946B41236793F56FF3188719@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220719073541.197788-1-peng.fan@oss.nxp.com>
 <20220719073541.197788-4-peng.fan@oss.nxp.com>
 <20220821024919.GJ149610@dragon>
In-Reply-To: <20220821024919.GJ149610@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 912add2a-b605-4b83-8ed7-08da83eea677
x-ms-traffictypediagnostic: DB7PR04MB5481:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bHA7ZJA/GM5nmYzs+je4itwwtHEarvGYkWrnTz9sTJsqKZ/7chjQhzP/9gQH9yDT1++KTdukkwEIAoWVGgukVHZyaF7PuPth/Bp8Tp5vBJO4qZDCxLGNhADWz1fdmE8Kne99gSeq+l26GgHVjRoGj6AAF44UtAYdXpN1Cq4F/7cphILGaLRi6RJ2QWrxffOl4dAWMQu+iHEADWDa0uSljJzuAjj4Ei9cYOwPGKRzW9+BUQhCtVH3J1Z6VknKvtTsDAP3tdo4mTexsAxBslXq3ROq5Vqa5owI5UVMZ7tQ7sC1h9v9UmfQbnk2B++vpekiQ/KnPiOWlOjIx/uD77OCRctYpb9pAjai/v34VNcmj9L3p+hTLTCAjFEUg92H/K7WmRavIidIXeNizYdEBjaccZXki0cIAgcoaqW1RmnxMA5YMlhsJx1pCZ3tGUiSUALtivxfpJmQBYuQYpMLnzEHI6yUqvIEcG6okbsoKvWpFCpp+t7A4eur+58D1Ak3CNpJExOFkcp2VAGXQ9KO2CLwk8PVVlZpsoWj7D/tbxPPlKt4guZmPOmEvpOFiaQiPBaQk+t63e1Trxy0ulfvh8Ao2/2CC4T+bYAlCjAA/hlrbiMXZLkQ//MO/CIf+mFePLqum06yjCUzzTWs0jIk/SFOH+iMrKEdk5rW5+K57cs1lw7FU31c90G3pxa1cYp05OrCOqFwZhsI2a9SgElbML5ZE53nBdXf3ZxClfnFYkBeV6gfvVl1DaBiHTs5d/EhkcZo7DhxZ87OCr8yBWj51nhW8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(6506007)(7696005)(41300700001)(478600001)(71200400001)(83380400001)(186003)(52536014)(26005)(9686003)(2906002)(8936002)(5660300002)(44832011)(7416002)(55016003)(316002)(54906003)(110136005)(76116006)(66556008)(4326008)(66946007)(8676002)(64756008)(66446008)(66476007)(38100700002)(86362001)(33656002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gmu9Pv/LdseOF5JHDH3Hk/1KtjAB9cXoqtNQVBmnNOBfF6EecYIW0THWuBIs?=
 =?us-ascii?Q?FKoLDRTS291JCzMUM/y4pANGg8HBPHAtjCljfRQpxez94ilEF7nMdvv+2/Tf?=
 =?us-ascii?Q?3Ylmog3ppMZsvku9hbDTfFqfnG47gOy31fYLVIuoFffoKZMOHIgLigNwqfya?=
 =?us-ascii?Q?8ybjSa0gDvT1VnhrELf876Wmbs3oNGdxp8btX9GHKlydyK0bVvwqsdOOhLuS?=
 =?us-ascii?Q?8oJDwOGbwX9sJuBQtKnRZPu8kz898KHMBcuq0jE7SgTV6utFck/PF2st5pBA?=
 =?us-ascii?Q?V516w7seLCWk0bjDbr0grJTLqk5Vd9et93fURhQW/Oac9tus/kczoFLaPSjC?=
 =?us-ascii?Q?9pW3moxIGxcGZZGYS0ox8f5tgLIAjNPD4IG/bxAaILmtvGXhv16Vl+t2HJAj?=
 =?us-ascii?Q?046z3RWgI3MVlobzKJ0qxfCn1wjfU3lxh7qW4KmrRQrNS5C12i7mfA/EJsSP?=
 =?us-ascii?Q?uyYLRet2tQAvRb2lumpbEN5LBJSQp28lVm37JY8pK/iXgHrv0ogBlkJyr/Ri?=
 =?us-ascii?Q?ZNfoaY2n9oaoMX6puDA7qkSIFcTOHue72uKIyOKaTf00OwHpQzwy4yzuvkRW?=
 =?us-ascii?Q?DUb6ZRK79rSK+MHWFcuoysqe3xCp3rZD3GFBDBxuwYJdCQsH3OXSObeSuMnb?=
 =?us-ascii?Q?gTevdvIKig+OqC2uGc6pTTnc9FLKRXYsmOfhbLOPIx6kUJvyuFCcTJi2yOop?=
 =?us-ascii?Q?0xR2U41bCa1bHORoCZA6l5N0GHOlbdxJry4y5QPCozbwTDF+/4+vKK02c3TA?=
 =?us-ascii?Q?b6jwwZdRt75yV728BUq8NxYYUsuCBPg1lJChnO1nQEVEB+3JZ5n7VQw3PC98?=
 =?us-ascii?Q?4sHE9eMYmgMt1ZJe12ucF5vHrVWwbeeW+A04nUWUx3S69qBIBY0zkF0ZdkOL?=
 =?us-ascii?Q?7Kg2dO2c+5E4y6hrF3NE3nUCNvQW3xc38wS2GL3CshrX5vNCFvSxK8E4BGDT?=
 =?us-ascii?Q?T1x59mdRK90WHU09DHGoHHgAbEoDhSqq8sYKCBF+ZA9WTqUfSiRfU2jJc/5C?=
 =?us-ascii?Q?gyI30XlCEfbAOjaSiq30idiril6GG04FAN/9CgMgEVt7QK/uS/tVH9k6dKvM?=
 =?us-ascii?Q?grouNdhdx61n03KFuOIQBYZnrPedx4362BYeJ2yIOMHJjb3Bhy9Q3Ona5NS6?=
 =?us-ascii?Q?Im3yfRQnA+x65RBeGtZL7XGtxDl4CnAajuhk+zFogfHeG6AcRWTwr2UpcLow?=
 =?us-ascii?Q?8fs6yCihx+Rfosb9NUNGn93YwvWEpMrhTL9DwwIEhCxdDH9kyrau52Ey6g4I?=
 =?us-ascii?Q?kyElNHUAEH1goBZ89XYAUhh42IXp6BKllgYN5R30wDQKCttiStiscYzBvUuD?=
 =?us-ascii?Q?lbSe9uWCfrf+OIZWHwPrn+jE4tmTd4qSqjnw16blq5rU/JnnlEih63SGaOb0?=
 =?us-ascii?Q?pJy96fDR+86ORht8SurITEJLcFvS1QWRTpCTlDj+vPyOMHuo1DKKbwiuoQ0E?=
 =?us-ascii?Q?61HFmHqzuk87RuJbPi98/eyD0wXau5DqBBIP1GbfXDDhQuhemFfOl0AScpXY?=
 =?us-ascii?Q?wsQquh2TzfkphdS6GaXeub5Itq4GdIO0mxrK45rgllGIcapSwLOxyyFWazan?=
 =?us-ascii?Q?ksAHSsoSms++V96vyCksFs1OfCtHICbMlOBXVBsW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912add2a-b605-4b83-8ed7-08da83eea677
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 03:30:24.4186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UMFFLWEhUnt3r95jI8TJhK2T+dv8ywBX20gyIGX3Ui7Dy9jucpE/cvMGF9pFgbiFlLHsVmv62S/tPVVLqnApVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V6 3/6] soc: imx: add i.MX93 SRC power domain driver
>=20
> On Tue, Jul 19, 2022 at 03:35:38PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Support controlling power domain managed by System Reset
> > Controller(SRC). Current supported power domain is mediamix power
> > domain.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/soc/imx/Kconfig     |   8 ++
> >  drivers/soc/imx/Makefile    |   1 +
> >  drivers/soc/imx/imx93-pd.c  | 163
> > ++++++++++++++++++++++++++++++++++++
> >  drivers/soc/imx/imx93-src.c |  32 +++++++
>=20
> Shouldn't a reset driver go to drivers/reset/?

Although it is named system reset controller(SRC), it is not just for reset=
.
- Deals with all global system reset sources from other modules, and
  generates global system reset.
- Responsible for power gating of MIXs (Slices) and their memory
  low power control.

The reset feature is actually being handled by secure world. Currently I=20
use the driver to populate subnodes, otherwise the mixs driver
will not probe.

Thanks,
Peng.


>=20
> >  4 files changed, 204 insertions(+)
> >  create mode 100644 drivers/soc/imx/imx93-pd.c  create mode 100644
> > drivers/soc/imx/imx93-src.c
> >
> > diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index
> > a840494e849a..4b906791d6c7 100644
> > --- a/drivers/soc/imx/Kconfig
> > +++ b/drivers/soc/imx/Kconfig
> > @@ -20,4 +20,12 @@ config SOC_IMX8M
> >  	  support, it will provide the SoC info like SoC family,
> >  	  ID and revision etc.
> >
> > +config SOC_IMX9
> > +	tristate "i.MX9 SoC family support"
> > +	depends on ARCH_MXC || COMPILE_TEST
> > +	default ARCH_MXC && ARM64
> > +	select SOC_BUS
> > +	help
> > +	  If you say yes here, you get support for the NXP i.MX9 family
> > +
> >  endmenu
> > diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile index
> > 63cd29f6d4d2..a0baa2a01adb 100644
> > --- a/drivers/soc/imx/Makefile
> > +++ b/drivers/soc/imx/Makefile
> > @@ -7,3 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
> >  obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
> >  obj-$(CONFIG_SOC_IMX8M) +=3D imx8m-blk-ctrl.o
> >  obj-$(CONFIG_SOC_IMX8M) +=3D imx8mp-blk-ctrl.o
> > +obj-$(CONFIG_SOC_IMX9) +=3D imx93-src.o imx93-pd.o
> > diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
> > new file mode 100644 index 000000000000..48437c303b78
> > --- /dev/null
> > +++ b/drivers/soc/imx/imx93-pd.c
> > @@ -0,0 +1,163 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2022 NXP
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/of_device.h>
> > +#include <linux/delay.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> > +
> > +#define MIX_SLICE_SW_CTRL_OFF		0x20
> > +#define SLICE_SW_CTRL_PSW_CTRL_OFF_MASK	BIT(4)
> > +#define SLICE_SW_CTRL_PDN_SOFT_MASK	BIT(31)
> > +
> > +#define MIX_FUNC_STAT_OFF		0xB4
> > +
> > +#define FUNC_STAT_PSW_STAT_MASK		BIT(0)
> > +#define FUNC_STAT_RST_STAT_MASK		BIT(2)
> > +#define FUNC_STAT_ISO_STAT_MASK		BIT(4)
> > +
> > +struct imx93_power_domain {
> > +	struct generic_pm_domain genpd;
> > +	struct device *dev;
> > +	void __iomem *addr;
> > +	struct clk_bulk_data *clks;
> > +	int num_clks;
> > +	bool init_off;
> > +};
> > +
> > +#define to_imx93_pd(_genpd) container_of(_genpd, struct
> > +imx93_power_domain, genpd)
> > +
> > +static int imx93_pd_on(struct generic_pm_domain *genpd) {
> > +	struct imx93_power_domain *domain =3D to_imx93_pd(genpd);
> > +	void __iomem *addr =3D domain->addr;
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret =3D clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> > +	if (ret) {
> > +		dev_err(domain->dev, "failed to enable clocks for
> domain: %s\n", genpd->name);
> > +		return ret;
> > +	}
> > +
> > +	val =3D readl(addr + MIX_SLICE_SW_CTRL_OFF);
> > +	val &=3D ~SLICE_SW_CTRL_PDN_SOFT_MASK;
> > +	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
> > +
> > +	ret =3D readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
> > +				 !(val & FUNC_STAT_ISO_STAT_MASK), 1,
> 10000);
> > +	if (ret) {
> > +		dev_err(domain->dev, "pd_on timeout: name: %s,
> stat: %x\n", genpd->name, val);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx93_pd_off(struct generic_pm_domain *genpd) {
> > +	struct imx93_power_domain *domain =3D to_imx93_pd(genpd);
> > +	void __iomem *addr =3D domain->addr;
> > +	int ret;
> > +	u32 val;
> > +
> > +	/* Power off MIX */
> > +	val =3D readl(addr + MIX_SLICE_SW_CTRL_OFF);
> > +	val |=3D SLICE_SW_CTRL_PDN_SOFT_MASK;
> > +	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
> > +
> > +	ret =3D readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
> > +				 val & FUNC_STAT_PSW_STAT_MASK, 1,
> 1000);
> > +	if (ret) {
> > +		dev_err(domain->dev, "pd_off timeout: name: %s,
> stat: %x\n", genpd->name, val);
> > +		return ret;
> > +	}
> > +
> > +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> > +
> > +	return 0;
> > +};
> > +
> > +static int imx93_pd_remove(struct platform_device *pdev) {
> > +	struct imx93_power_domain *domain =3D
> platform_get_drvdata(pdev);
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +
> > +	if (!domain->init_off)
> > +		clk_bulk_disable_unprepare(domain->num_clks, domain-
> >clks);
> > +
> > +	of_genpd_del_provider(np);
> > +	pm_genpd_remove(&domain->genpd);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx93_pd_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct imx93_power_domain *domain;
> > +	int ret;
> > +
> > +	domain =3D devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
> > +	if (!domain)
> > +		return -ENOMEM;
>=20
> Have a newline.
>=20
> > +	domain->addr =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(domain->addr))
> > +		return PTR_ERR(domain->addr);
> > +
> > +
>=20
> One newline is enough.
>=20
> > +	domain->num_clks =3D devm_clk_bulk_get_all(dev, &domain->clks);
> > +	if (domain->num_clks < 0)
> > +		return dev_err_probe(dev, domain->num_clks, "Failed to
> get domain's
> > +clocks\n");
> > +
> > +	domain->genpd.name =3D dev_name(dev);
> > +	domain->genpd.power_off =3D imx93_pd_off;
> > +	domain->genpd.power_on =3D imx93_pd_on;
> > +	domain->dev =3D dev;
> > +
> > +	domain->init_off =3D readl(domain->addr + MIX_FUNC_STAT_OFF) &
> FUNC_STAT_ISO_STAT_MASK;
> > +	/* Just to sync the status of hardware */
> > +	if (!domain->init_off) {
> > +		ret =3D clk_bulk_prepare_enable(domain->num_clks, domain-
> >clks);
> > +		if (ret) {
> > +			dev_err(domain->dev, "failed to enable clocks for
> domain: %s\n",
> > +				domain->genpd.name);
> > +			return 0;
>=20
> This is a case of success?
>=20
> > +		}
> > +	}
> > +
> > +	ret =3D pm_genpd_init(&domain->genpd, NULL, domain->init_off);
> > +	if (ret)
> > +		return ret;
> > +
> > +	platform_set_drvdata(pdev, domain);
> > +
> > +	return of_genpd_add_provider_simple(np, &domain->genpd); }
> > +
> > +static const struct of_device_id imx93_dt_ids[] =3D {
> > +	{ .compatible =3D "fsl,imx93-src-slice" },
> > +	{ }
> > +};
>=20
> MODULE_DEVICE_TABLE()?
>=20
> Shawn
>=20
> > +
> > +static struct platform_driver imx93_power_domain_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "imx93_power_domain",
> > +		.owner	=3D THIS_MODULE,
> > +		.of_match_table =3D imx93_dt_ids,
> > +	},
> > +	.probe =3D imx93_pd_probe,
> > +	.remove =3D imx93_pd_remove,
> > +};
> > +module_platform_driver(imx93_power_domain_driver);
> > +
> > +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> MODULE_DESCRIPTION("NXP
> > +i.MX93 power domain driver"); MODULE_LICENSE("GPL");
>=20
> "GPL v2" since you have "SPDX-License-Identifier: GPL-2.0" claimed in the
> beginning?
>=20
> Shawn
>=20
> > diff --git a/drivers/soc/imx/imx93-src.c b/drivers/soc/imx/imx93-src.c
> > new file mode 100644 index 000000000000..6f14c241538e
> > --- /dev/null
> > +++ b/drivers/soc/imx/imx93-src.c
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2022 NXP
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +
> > +static int imx93_src_probe(struct platform_device *pdev) {
> > +	return devm_of_platform_populate(&pdev->dev);
> > +}
> > +
> > +static const struct of_device_id imx93_dt_ids[] =3D {
> > +	{ .compatible =3D "fsl,imx93-src" },
> > +	{ }
> > +};
> > +
> > +static struct platform_driver imx93_src_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "imx93_src",
> > +		.owner	=3D THIS_MODULE,
> > +		.of_match_table =3D imx93_dt_ids,
> > +	},
> > +	.probe =3D imx93_src_probe,
> > +};
> > +module_platform_driver(imx93_src_driver);
> > +
> > +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> MODULE_DESCRIPTION("NXP
> > +i.MX93 src driver"); MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
