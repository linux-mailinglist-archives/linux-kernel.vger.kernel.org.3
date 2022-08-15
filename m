Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CAA592CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiHOImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbiHOImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:42:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD70DF3C;
        Mon, 15 Aug 2022 01:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgH/6b7pKPMMYcR61MhxRvDfKfwjornoNZYXc6tYx6oEy7+H8x3lum1/qw5J1dikKL9p4WPAKKFg0/SuwJOanuDXCRF8wE9N8qRtmKviQmgIU33f5yRkNEyUhsFhB3fW3OBHorTXuAbJmST/0bCJCXkdJO1mkyzkGKjmhoaIOu/i6aV/MKBwlHeS8p09oZYCkD/v3fQUnSftSjwnPBPXgqbRK34YAL+tiS/9Ka9TN9y2y2BS5t6XSV2iGeFNruFoVb1lNucSHlLgeBIkOQ+tiO4ApmxO7FEpzlLRb3a0YlEk1d1nB9G0cakMrXzpyNoSzqx0dWmbU5T8URXxTqdBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YHkAj/5zqnVYolMdCmEODoGJ7YLxmqa7eOfirxM0Bg=;
 b=GByhFdh0YNLXtO15Wros947TwVgdUuwZbE9ch0R2+2kkF+/76C5LFgRYiO6gOaiOVIo9wjQJNA3dQ4yv3JAET4jFyUkfmNcu5fi7ZIcMwdYbudmstCP+VrQzh6tm0/k29LTPUvvwv0vmNcfaLKUGN3pzDZAcj6jK3CISDM0wCJ3orEFYumIJkyF3JAXIGBVmAEZh4zDHF2Y2VSTfhbQnszrEekNvYjtrhsXEQMp8W+Gw0MD48eaf41x03QNvp9NJJfFA0TueZL6X4TtEYLHxvtlSWJ0k4oCj8iwHnBrBg0LqnUA1uEfMlVqXeuxEvsSjrf9foxZcPYZvjyMpBBuXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YHkAj/5zqnVYolMdCmEODoGJ7YLxmqa7eOfirxM0Bg=;
 b=msJL7XgCOBgXo1PFne3LdscKjawD3J9KXsfAQcTZL7iF+Z/2Uxra/Mi+Uy8FBADG/q1Eoo1f4U3dAnlOsAogKFlZpBLnnrv9FpXtVmkQBe4nNAB2ceDItlLFzeDP3xBJWCaFiNGiJnH/nbWvbVv52cdn7EQyIN/c4axH1MmZkqc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8343.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 08:42:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 08:42:14 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] clk: imx: support fsl,protected-clocks
Thread-Topic: [PATCH 2/2] clk: imx: support fsl,protected-clocks
Thread-Index: AQHYsFgDLxkQYZ2Y70OeYSKTcOb6hq2voocAgAACVvA=
Date:   Mon, 15 Aug 2022 08:42:14 +0000
Message-ID: <DU0PR04MB9417531C84DABF32C9B61B9088689@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220815033632.1687854-1-peng.fan@oss.nxp.com>
 <20220815033632.1687854-3-peng.fan@oss.nxp.com> <YvoEtKd7GCL865C3@linaro.org>
In-Reply-To: <YvoEtKd7GCL865C3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4ff115c-a0a0-4ec6-1c81-08da7e9a0dc0
x-ms-traffictypediagnostic: AS8PR04MB8343:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6MfK730REmMJ/YyfCEDZz6AfcaE2aT3t/eWocEG5+QGlz5VAKPI36VA9uTburLqi4hNLRDeEdgxnRTN7eWP6jzmur4B2ZvGdqisiGSt2B60LM47AD7wQwea48RVtvBKfTOQ7DVjx7myL2023aJ4f6uZjiJV9MhRjxH1SZUC985HkPzpGrZ6Q4uN/G1xNA6von0hGhxVWBMff9gAi2KsLjSR/s1n1Hv90/hW6dvvny4wBZCCDT4CV/APQW9mxIhGjlqqwZ7rxXPhUvtkghxwKQELSqMDeHC3ZZk7YYBGBHbV8gIemK6Z7LxqYXRZFBycfKLig9denJe7LyPf+ryXPhC3ooTo8PLg4caII/xO9xzfYh2IfqE+5fhpp5QkviQdAG6OZN1v5riFffNwc24iyc2gCMiQ5D5rPRRZYWFKoDwMwuHUEWewjjHK5y4llzyROlj3ASup4YaIqxGpkQFfg56Gh5I3A5e3UukCfJmm4GHSOhS/Q4HMEMXIjbDwx5jkNx4hMG5ZFnJ0ijpZVEY8/xhlNILCgN240qytmR9HUnitxu9l6/Y+2vECod6lOo4xgsmiArOcMLSXhi6floWErLHPzVHUCI85LYekN7JMZ8XAsmxAtU9dpKs0Mn+LLX8nvgHvw7VQ3K+3hgLNnpWA2uzxl2LdtpLVOclQprgTz4VdcPRGPwdHUf0Km61tZqTZTsbpYusBGiksOlnKxL8RTnSFJTyQN35fO6ttC4myeFEXV53pC7uez789NNg8BjLDo82qjikoMFrg5NqXSEU53UPsQbjpSWe2Nl40dAaDv37VVWriCsbbXpispJOzPrRC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(2906002)(83380400001)(9686003)(26005)(66476007)(38100700002)(66556008)(66946007)(76116006)(6506007)(7696005)(186003)(53546011)(64756008)(7416002)(8936002)(52536014)(66446008)(41300700001)(44832011)(33656002)(5660300002)(86362001)(478600001)(122000001)(110136005)(4326008)(71200400001)(38070700005)(316002)(54906003)(8676002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?blBz67DVRaAODCFt524D137OW2qjMI+n11SQw1/g83Orl3UoCiZApxedQraM?=
 =?us-ascii?Q?L4G59yvZBph0i6yXQdjucodzXqTp9ytx2aQv4UQMHIWpnKpvqN89r8Vh295y?=
 =?us-ascii?Q?aWM62vmHPN+4PavcmhEMuLCKkdzPh/EeRsVTUr0wxytSXirx95TuvRyJdmoV?=
 =?us-ascii?Q?H8NDqTM08EGcbRJzE3wvGNd9wTKODaiaoJECmOGfxZhmYkidTwrOO/LWqatf?=
 =?us-ascii?Q?1a/aAEUwCs2qPJFcNn3HbqN3ufmWCc7HwGiSReK3RuhqPEvWOpCLfz9DxNPo?=
 =?us-ascii?Q?sn+zIrLhXC+X8nPsvublq6BXh5HMcMpQTGAgzcU4eQvYsRD0OP9pwYZcGKXW?=
 =?us-ascii?Q?AF0x9SVwCxAS/2wrQvvs+OYZIw2nA+ImqMEvHYeEKx+LnfB80qnuYymGRoUN?=
 =?us-ascii?Q?+j5ayK5IsxUxiakGuPKDaDuz4ODwPYwv5kF2tW2MC76s4xLjGk8f6hYcFgl0?=
 =?us-ascii?Q?E1W0IcTNZZbWhP11zQ2ZwT+x+npCFPVSl5e4szzBV1VCbjZh5A6L3a+IvogQ?=
 =?us-ascii?Q?fmh6cwkFd+RpAhnsVhTPNG13FBbL0XJkrqtOQ4N7Vyf7PK8SpJUfV1uy/BFv?=
 =?us-ascii?Q?mLUPRqBu93MhQnpBA02x4IvYoc9jxVaYJjjqsfuT/4lLeA2XHTASqR1OaveN?=
 =?us-ascii?Q?J2DIVm3qr5U/0zqyj471k9FkoaTVW8xm8qJdhZ60mKzVVObL22Y+5xMxovbP?=
 =?us-ascii?Q?Zg+QQg+AMteymt40GJX5BK+pxLQdvULvYWH43TFDikHtkBDE95MZpyf1tBvN?=
 =?us-ascii?Q?Gm/W9SJ6LOyG8T/nfRlMc8XzEXmIK2RMgamUFkwQi8qo/aZjJEvjQpMx921e?=
 =?us-ascii?Q?KkcshDS5wwAKBT48hZbDyVkCiIv1bWoG2TzKzEScG4wH8n3B15Ylf1+sl9o+?=
 =?us-ascii?Q?mGRNAmvl8NXjtcA1H/9OG4/f/uNV6MG3Kzp/UjC0pszAPvVw1YtjaODZcXxo?=
 =?us-ascii?Q?fit1MpICl9zdSr1PiAh9FMRlRNzarVccy2N/g0/aNz+smw1CAjZ03boCofnO?=
 =?us-ascii?Q?iX4OVOTd9banbImrl+HfLpdrck28HDbqdjKOVpTf0OewJZgSHjkuOfP3jOqw?=
 =?us-ascii?Q?G2J5U7N6qkq6Y9DlOTnb55lEyHVLxVArJGbfwyrhJCOInyLVSa3CikLqt7YX?=
 =?us-ascii?Q?Fe+oid1k8KFSkMe0vzbV8LGTUtv+LknvVzSKVVLa6sK3KLYhlZQahS3zI5L7?=
 =?us-ascii?Q?a67CEurwAiMkdzfM3KDaGAZ6CzGy6dREQLKNyyuccPUxDmmeq41Y0bRD1FuX?=
 =?us-ascii?Q?5xsGN2X+8NkBnba4hOXBosGwp4Eei7VVgAINF0UWdF+xGAl72We4f6xvMfXP?=
 =?us-ascii?Q?/rcfh6tn/wZT/orh6BxyrlwKr7fqz90m1z3D4YhWhuNUj+9TvJ9rQQfQaRFR?=
 =?us-ascii?Q?lKyZuNy6k9N94yXS30K8hQhawzSON3SQUJvaWnjt6g90/l+ZLxu88vLx031R?=
 =?us-ascii?Q?036BHN8mN2onPCwZko/AqpL5fcwzwUG3EFgBjoBoXvWlIPDzO8sxhITOwJJ4?=
 =?us-ascii?Q?dqPWovvClMkxIMDhsdruZOr337tG//X26lPH60L08INoHmZtMtUaC1BeZFX9?=
 =?us-ascii?Q?Xeh0fPgzAQzCUwd9Q1s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ff115c-a0a0-4ec6-1c81-08da7e9a0dc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 08:42:14.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yR97KOXo96hBqVq0J4k8c8psgBwsqOyBBKUGvzRtbxRx9BQwyaqjaBHOhUVQOzaGRYKNeFOlJABCbFf8GVD7Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/2] clk: imx: support fsl,protected-clocks
>=20
> On 22-08-15 11:36:32, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > For the clocks listed in fsl,protected-clocks, enable them to avoid
> > Linux disable them. This will benifit root Linux and inmate cell run
> > on top of Jailhouse hypervisor, and benifit AMP case.
>=20
> Nitpick: s/benifit/benefit/
>=20
> AMP?

Asymmetric Multi-Processing, I mean Cortex-M run together with A53.

Thanks,
Peng.

>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx8mm.c |  2 ++
> >  drivers/clk/imx/clk-imx8mn.c |  2 ++
> >  drivers/clk/imx/clk-imx8mp.c |  2 ++
> >  drivers/clk/imx/clk-imx8mq.c |  2 ++
> >  drivers/clk/imx/clk.c        | 21 +++++++++++++++++++++
> >  drivers/clk/imx/clk.h        |  2 ++
> >  6 files changed, 31 insertions(+)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mm.c
> > b/drivers/clk/imx/clk-imx8mm.c index b6d275855b36..24ddb1620bce
> 100644
> > --- a/drivers/clk/imx/clk-imx8mm.c
> > +++ b/drivers/clk/imx/clk-imx8mm.c
> > @@ -611,6 +611,8 @@ static int imx8mm_clocks_probe(struct
> > platform_device *pdev)
> >
> >  	imx_register_uart_clocks(4);
> >
> > +	imx_clk_protect(dev, hws);
> > +
> >  	return 0;
> >
> >  unregister_hws:
> > diff --git a/drivers/clk/imx/clk-imx8mn.c
> > b/drivers/clk/imx/clk-imx8mn.c index d37c45b676ab..57c486317d28
> 100644
> > --- a/drivers/clk/imx/clk-imx8mn.c
> > +++ b/drivers/clk/imx/clk-imx8mn.c
> > @@ -604,6 +604,8 @@ static int imx8mn_clocks_probe(struct
> > platform_device *pdev)
> >
> >  	imx_register_uart_clocks(4);
> >
> > +	imx_clk_protect(dev, hws);
> > +
> >  	return 0;
> >
> >  unregister_hws:
> > diff --git a/drivers/clk/imx/clk-imx8mp.c
> > b/drivers/clk/imx/clk-imx8mp.c index 652ae58c2735..a95862cc04a4
> 100644
> > --- a/drivers/clk/imx/clk-imx8mp.c
> > +++ b/drivers/clk/imx/clk-imx8mp.c
> > @@ -713,6 +713,8 @@ static int imx8mp_clocks_probe(struct
> > platform_device *pdev)
> >
> >  	imx_register_uart_clocks(4);
> >
> > +	imx_clk_protect(dev, hws);
> > +
> >  	return 0;
> >  }
> >
> > diff --git a/drivers/clk/imx/clk-imx8mq.c
> > b/drivers/clk/imx/clk-imx8mq.c index 882dcad4817d..2868e2390667
> 100644
> > --- a/drivers/clk/imx/clk-imx8mq.c
> > +++ b/drivers/clk/imx/clk-imx8mq.c
> > @@ -603,6 +603,8 @@ static int imx8mq_clocks_probe(struct
> > platform_device *pdev)
> >
> >  	imx_register_uart_clocks(4);
> >
> > +	imx_clk_protect(dev, hws);
> > +
> >  	return 0;
> >
> >  unregister_hws:
> > diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c index
> > 5582f18dd632..307da8bd5243 100644
> > --- a/drivers/clk/imx/clk.c
> > +++ b/drivers/clk/imx/clk.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/bits.h>
> >  #include <linux/clk.h>
> >  #include <linux/clk-provider.h>
> > +#include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > @@ -214,4 +215,24 @@ static int __init imx_clk_disable_uart(void)
> > late_initcall_sync(imx_clk_disable_uart);
> >  #endif
> >
> > +int imx_clk_protect(struct device *dev, struct clk_hw * const clks[])
> > +{
> > +	struct device_node *np =3D dev->of_node;
> > +	struct property *prop;
> > +	const __be32 *p;
> > +	u32 i;
> > +	int ret;
> > +
> > +	of_property_for_each_u32(np, "fsl,protected-clocks", prop, p, i) {
> > +		ret =3D clk_prepare_enable(clks[i]->clk);
>=20
> I might be wrong here, but wouldn't CLK_IGNORE_UNUSED have the same
> effect?
>=20
> I don't think we should circumvent that by adding vendor specific dts
> properties.
>=20
> > +		if (ret) {
> > +			dev_err(dev, "failed to enable %s\n",
> clk_hw_get_name(clks[i]));
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(imx_clk_protect);
> > +
> >  MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> > dd49f90110e8..3f8099190b99 100644
> > --- a/drivers/clk/imx/clk.h
> > +++ b/drivers/clk/imx/clk.h
> > @@ -22,6 +22,8 @@ void imx_mmdc_mask_handshake(void __iomem
> *ccm_base,
> > unsigned int chn);  void imx_unregister_clocks(struct clk *clks[],
> > unsigned int count);  void imx_unregister_hw_clocks(struct clk_hw
> > *hws[], unsigned int count);
> >
> > +int imx_clk_protect(struct device *dev, struct clk_hw * const
> > +clks[]);
> > +
> >  extern void imx_cscmr1_fixup(u32 *val);
> >
> >  enum imx_pllv1_type {
> > --
> > 2.37.1
> >
