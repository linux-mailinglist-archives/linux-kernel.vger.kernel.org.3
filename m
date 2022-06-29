Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6726B55F2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiF2BIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF2BIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:08:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60064.outbound.protection.outlook.com [40.107.6.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B8922522;
        Tue, 28 Jun 2022 18:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXqKtwlTNo756MzwFxly3OVPMq4ITNxBP16/zdoeQf9EFYBeFDQps/lMsq5RvIoveSC3i4WaLS8aWwbiu5W9SY+vn+aSu+xs7XeMh1PqpsXfhEIktJGWVaI4wKwwLWI5qjQSt2tRkuOCQ8H21kO0jbppDLHdf1qciiKoe5Kct2KeVGpIol4y1EwyPPPzJ09EzC2BDe3cLLV9qDeQ/NVEfFZ90/xrKOUgroEhAax8DyIhe6Mzom12g6+6S98fkCDBTQe8aYOP1H6emYgezT9wDKtdP/wB/JUgE2tqOyYmhi3QfnjjaKiohXGHI4XUH0K658mOuMzthWxbVNUhVbKKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqzhW9TUvnNvjAAQtMq1JvYDMUHu76pfOwOL6UFcWPc=;
 b=SB2ZVEQWb+Tj57AJxEg4iHOM0Ox4OjR1yFyiI3SS3gWHDPECtCVMysvMLyuPqz6mCfzZ+too60sr1m1OZjDWsRNcJ+0whtXLVY7Jo4xZm9xg4sw6L1llyzJuB0gMPVW5sk2aGqA1zoAPiO6QFeR+i+JrHLuUC4VWRGcjWHMj9Yhb5KrMQe+EzTh3cNwqnmPm+u9pZ3F8wA/uF7bpfHCHymVHbzvrwYrYDZUZlP+xRMDZ/m/LpcYdPkUDIlsIvL+fyLhXDvQPSPxvNNm8Kvau4ExFDiaVzKFZHotiwmzqzW64Ksvk00qxW27fKx3XWIKiqNbSd3EWg+WhTHS6JzLMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqzhW9TUvnNvjAAQtMq1JvYDMUHu76pfOwOL6UFcWPc=;
 b=hFKnrCgxg5qSlPJ1TK08oOU02ahpyM2/EaNEACNk77kePUM3mlSwlKlDSD6olvaO12yXhpJulPuWTKq0ouLhf+ZGPdhpzZq7Ieo1VtaLtIKyzXUypa5dXFkROR7dyZdSWnvKMFE8WUr3y0d3Wcqj6D0C7A8/kZvpO8cWtL9oYro=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 01:08:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 01:08:32 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 4/6] remoteproc: imx_rproc: support kicking Mcore from
 Linux for i.MX8QXP
Thread-Topic: [PATCH V3 4/6] remoteproc: imx_rproc: support kicking Mcore from
 Linux for i.MX8QXP
Thread-Index: AQHYaboRiZ7L/CwovEKY+K/EgZMo+K1lWaMAgAB6lUA=
Date:   Wed, 29 Jun 2022 01:08:32 +0000
Message-ID: <DU0PR04MB9417978F84AA17D084CA19AE88BB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
 <20220517064937.4033441-5-peng.fan@oss.nxp.com>
 <20220628174316.GC1942439@p14s>
In-Reply-To: <20220628174316.GC1942439@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e181cdf2-692e-49a0-7957-08da596be2bb
x-ms-traffictypediagnostic: AS8PR04MB7878:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QeSU9qG+NPsPNi87LrSZ6GDbrA5Fov/jzfHHmRpDi4b35y4k5akqmL68voLppOki2f9dwcNEXD1wThRrz1iDyVw+MWSa3sSV+/EIGph2M6wQanqkgLVuYgmX3Wn85e9lX4PwGIh5UjMXAUr6q2ifBTk9cAxCiyN0ZEVLL/BSRch7y8reriB22wvVD21I14FU0g0XHhiRRMJchia3Kl+r7f1p3S/mEc8sz2abKasM8uHMpks/aGBsE2ow8Wurwbqt3P89dkpF+UiJTXz0gR1fqhjpRqe4mUogQ/GGRJnPBWN41GR9TcIxw2tYAGmsfvRb4cPxVN+CPhHydJSHcrHfBqMgCob54g2l+SA0WxlkkLu468Ahoh8I6xFfhpsD9KX9Z7UQg/ig1Z999r7OTItCNmSwA/WMXE2gedxK8+Z2HPHmTMmiafg9adGPO8ACfrY7EeedYsQ6Y+Ie3pq0fNc+v4YvVVcTdh3wnFaPyPkUFzqa/CBSVVCvwvpAn+sUNZtOLmm9jaxZ/vCcKkW3wyAgcKIU6cYv/fYfX10fWneXeAjbmOZBjpTg1Ou4u8PjKKbkjtRnrh6SbEDxDD3t8UzEz8FjTWVyZHMtgwCu15P/IlNuUx7JIsM+WX2h0nuCLjLuoCAdSVr56QFNC47vU4i5dZa0azhAURTqSVKRejDokTCMN4UOIvBZQq14SF3RP/Bql1pujn8SlIWrW4bCCwCsMyitUlucZz+duXTmScFubb7+I/TSWivLLYK8MVRmVq2bRz+xfQgVblN4dgjWPjckJuesuh6ESYkgEaL7asWgEsM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(2906002)(38100700002)(4326008)(52536014)(478600001)(66946007)(316002)(8676002)(86362001)(41300700001)(7416002)(7696005)(8936002)(110136005)(6506007)(38070700005)(122000001)(26005)(54906003)(83380400001)(9686003)(44832011)(55016003)(5660300002)(66556008)(186003)(71200400001)(76116006)(33656002)(64756008)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+XN4Grzaa8r01/tZAoqQMXCQuX8hiP5mYIi3pbUWQXY6dcgnOu2uJfXpiyon?=
 =?us-ascii?Q?t85E7qu8SyUHPDXuBDr3GqEc3hmn0EWcX5NkA8AUQJn7XW8sXn+ljtLKSdfX?=
 =?us-ascii?Q?jdr+RabR/xLBvwh77CZu9Av/8ZGGdCerFj9x+SQyAfB/2p3b6jcVWepq7lPu?=
 =?us-ascii?Q?a01TVyRswxutsiEsdkgAUUmXjTAtv9uKVn6ahOPhwfocoDXeYQfa0Kp2xbfG?=
 =?us-ascii?Q?Ppypbx+BBsnGT5dshvYvyceU3mwIgLyCKQUwVGkI7RMRLzBM8EkC6s3RRnZu?=
 =?us-ascii?Q?zett4Emh3s3hsBf9PqT3GpnEV9Znfedv6o0rm33LZCfVPOVU0KckeAGH2cdD?=
 =?us-ascii?Q?Aan9GZp16FhXjtVnRUdJvcHPL1WPWOzHD3jZm3E/pjtQMm8jBVBnvblyeDVP?=
 =?us-ascii?Q?0/G3MZodCWvyJV1U39bm7hRpF4Q1y5KNVZj99aOHe9kHnacG05adTwTZ5Ywi?=
 =?us-ascii?Q?c1ACcgFBC4zA3sxo0SshsqXl90iYwHjAYsXYgdQ6k6GNUM2Tqn03NclbqxJP?=
 =?us-ascii?Q?Ha/CQxonXXvqe3RYZs9bHPetVVcxQiJP27OjXj1Okzo14ooGtZrnzZ+TzStR?=
 =?us-ascii?Q?RGAehZK3L8qGxfYfSYgVUlFJnu5LHzpEtHSDTlJTKnSPerYak0o7YS3RxZ6v?=
 =?us-ascii?Q?2F07hu5Uizlhq2JqUaACa20sbBNm91fq1mwW/oHfWhGmxRsC0rsycvK9D/lT?=
 =?us-ascii?Q?qLU1e8B6QGVFYqUVoe+u2oXrevE/NwO4lnpdpmpQgFuUB91MuxxoszJmnxgT?=
 =?us-ascii?Q?GVjXhdpnPB4yK/nm2d1ewSRGOc+mn979kNcBLp3aQYe1q8iVViyTcG+nleel?=
 =?us-ascii?Q?HWZWlp5dC6mni+LtBS6R2zIswvmDJS4L9jEg8biTAOcV/+SkeHAOUVtSVt0v?=
 =?us-ascii?Q?mxTSiNC4o/Nu9m0RjJ+nHXV6K52OiOnM7fTewT03JZIFvKBCXArEZAg+MNJ4?=
 =?us-ascii?Q?Gh9IGqAMWH3Q5NV6wJd47iDO+stNUkXZcZHfjH1StproAGsd4lGTXNcCTfuy?=
 =?us-ascii?Q?/rppi/dLyqMTXPUi2OC8AU97V3DiBsStSN49g0XbpR0HchWD9qU+dk5qYoaA?=
 =?us-ascii?Q?kO2Th6j6OO1c8f554X+76m5lme2owBWqZFKb4QJKFzBlsv+Q3pV/Gy95ybRO?=
 =?us-ascii?Q?2R77mDUjPQc/PcYexqF1M6EGJDzOBd40Ol0iMh+6UKng40wOSiXz1cxnB1ob?=
 =?us-ascii?Q?3gRED/XPy5Dr+HTmayHzVtPZgqGKbeQu98lQhOvOj56bVWgLKJU33k8oZVqU?=
 =?us-ascii?Q?YEGxMdZa9nrlQLjSTGN6rNzg6zzkpLsC9NCxP1TXIgYFfgZlssyoVA7Qwj52?=
 =?us-ascii?Q?3MjqMd1AcTR5cvTwZR7Gk+fNsYsXoDrRMdTpejqhlzopDK6yLJJIIU/est8k?=
 =?us-ascii?Q?YcAyAFxVIBWGX6/sQt24BzyO4oX1tfZUIX9oQ5wABfJ1jH19nGHQ5NKa5EEv?=
 =?us-ascii?Q?C5n48tt9nDkRowNIXI9ERxJIz1jA8D3rBg8FOwY7fQNk99EFeHAEyElcuHBl?=
 =?us-ascii?Q?+nzh8Wq3oLcr6wxsq8UdXqphsOauLbLswMo/b0mnnOdjdyPOX6uNm7kVXQXW?=
 =?us-ascii?Q?L1zpiuXGYZpVPBDrhDo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e181cdf2-692e-49a0-7957-08da596be2bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 01:08:32.6187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGA8GJEV0KcCzOeolRRw3gdvw7u8Z8gQskqlfsohDO0wNryfKHVmIdq3XYG2DFgYGziqdooOo5jf0YC9ld4O3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3 4/6] remoteproc: imx_rproc: support kicking Mcore
> from Linux for i.MX8QXP
>=20
> On Tue, May 17, 2022 at 02:49:35PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When M4 is in the same hardware partition with Cortex-A, it could be
> > start/stop by Linux.
> >
> > Added power domain to make sure M4 could run, it requires several
> > power domains to work. Make clk always optional for i.MX8QXP, because
> > SCFW handles it when power up M4 core.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 69
> > +++++++++++++++++++++++++++++++++-
> >  1 file changed, 67 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 2e751fc90760..49cce9dd55c7
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/regmap.h>
> >  #include <linux/remoteproc.h>
> >  #include <linux/workqueue.h>
> > @@ -96,6 +97,10 @@ struct imx_rproc {
> >  	struct notifier_block		rproc_nb;
> >  	u32				rproc_pt;	/* partition id */
> >  	u32				rsrc_id;	/* resource id */
> > +	u32				entry;		/* cpu start address */
> > +	int                             num_pd;
> > +	struct device                   **pd_dev;
> > +	struct device_link              **pd_dev_link;
> >  };
> >
> >  static const struct imx_rproc_att imx_rproc_att_imx93[] =3D { @@ -335,=
6
> > +340,9 @@ static int imx_rproc_start(struct rproc *rproc)
> >  		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0,
> 0, 0, &res);
> >  		ret =3D res.a0;
> >  		break;
> > +	case IMX_RPROC_SCU_API:
> > +		ret =3D imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, true,
> priv->entry);
> > +		break;
> >  	default:
> >  		return -EOPNOTSUPP;
> >  	}
> > @@ -364,6 +372,9 @@ static int imx_rproc_stop(struct rproc *rproc)
> >  		if (res.a1)
> >  			dev_info(dev, "Not in wfi, force stopped\n");
> >  		break;
> > +	case IMX_RPROC_SCU_API:
> > +		ret =3D imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, false,
> priv->entry);
> > +		break;
> >  	default:
> >  		return -EOPNOTSUPP;
> >  	}
> > @@ -724,6 +735,56 @@ static int imx_rproc_partition_notify(struct
> notifier_block *nb,
> >  	return 0;
> >  }
> >
> > +static int imx_rproc_attach_pd(struct imx_rproc *priv) {
> > +	struct device *dev =3D priv->dev;
> > +	int ret, i;
> > +
> > +	priv->num_pd =3D of_count_phandle_with_args(dev->of_node,
> "power-domains",
> > +						  "#power-domain-cells");
> > +	if (priv->num_pd < 0)
> > +		return priv->num_pd;
> > +
> > +	if (!priv->num_pd)
> > +		return 0;
> > +
> > +	priv->pd_dev =3D devm_kmalloc_array(dev, priv->num_pd,
> sizeof(*priv->pd_dev), GFP_KERNEL);
> > +	if (!priv->pd_dev)
> > +		return -ENOMEM;
> > +
> > +	priv->pd_dev_link =3D devm_kmalloc_array(dev, priv->num_pd,
> sizeof(*priv->pd_dev_link),
> > +					       GFP_KERNEL);
> > +
> > +	if (!priv->pd_dev_link)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < priv->num_pd; i++) {
> > +		priv->pd_dev[i] =3D dev_pm_domain_attach_by_id(dev, i);
> > +		if (IS_ERR(priv->pd_dev[i])) {
> > +			ret =3D PTR_ERR(priv->pd_dev[i]);
> > +			goto detach_pd;
> > +		}
> > +
> > +		priv->pd_dev_link[i] =3D device_link_add(dev, priv->pd_dev[i],
> DL_FLAG_STATELESS |
> > +						       DL_FLAG_PM_RUNTIME |
> DL_FLAG_RPM_ACTIVE);
> > +		if (!priv->pd_dev_link[i]) {
> > +			dev_pm_domain_detach(priv->pd_dev[i], false);
> > +			ret =3D -EINVAL;
> > +			goto detach_pd;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +detach_pd:
> > +	while (--i >=3D 0) {
> > +		device_link_del(priv->pd_dev_link[i]);
> > +		dev_pm_domain_detach(priv->pd_dev[i], false);
>=20
> Same here - why are these not called during driver removal and along the =
error
> path in probe()?

Will add that, with a function imx_rproc_detach_pd

Thanks,
Peng.

>=20
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int imx_rproc_detect_mode(struct imx_rproc *priv)  {
> >  	struct regmap_config config =3D { .name =3D "imx-rproc" }; @@ -758,8
> > +819,12 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> >  		 * If Mcore resource is not owned by Acore partition, It is kicked b=
y
> ROM,
> >  		 * and Linux could only do IPC with Mcore and nothing else.
> >  		 */
> > -		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> > -			return 0;
> > +		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
> > +			if (of_property_read_u32(dev->of_node, "fsl,entry-address",
> &priv->entry))
> > +				return -EINVAL;
> > +
> > +			return imx_rproc_attach_pd(priv);
> > +		}
> >
> >  		priv->rproc->state =3D RPROC_DETACHED;
> >  		priv->rproc->recovery_disabled =3D true;
> > --
> > 2.25.1
> >
