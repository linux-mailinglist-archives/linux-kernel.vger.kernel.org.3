Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D49591363
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiHLQBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiHLQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:01:05 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10055.outbound.protection.outlook.com [40.107.1.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CE36E2F0;
        Fri, 12 Aug 2022 09:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0LXPW3CuGdbqhnz5hyMm3B5W13ljrFk+4lTMmDPYQLEFPoJQdoR7s4VTDwhjGp6tVfC0FEqxBshRj3S/xOjXZT2zh6n/0x78D1Dz/Oy3Ioqlwyro5k6SPVQ7VPohTRWnHvDi/Dd7W0shirlms1mzmZ4F9fI0yWKarWmtmOQXKC2EnBGjFgSwUSHN+cBrj47bcepcqL8pkfAcXQV7iqyVGVbjDoHEPisloStxEvQBbLP70xr0lqjRzyVFcfD72mxNnV3pC/DD9/RKB9n97C+D1IN8Qt/HuKV7mts/pLYMtYNZJDEBX4oqSBaGS26/mZvm1P9QnRK/O7CnCV6tdSbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnGTfC2so/TdDmmJZOLXnHyQA75Dl5RKFPkElybDMIo=;
 b=KfFTvkpNtqT59t+VKYR3TX0uIgfx5jCyxwzx50TgCAScUELUdUg7MUBkXlUF35P6Jug+yoSBUiKWmic7ZGlQqkBpwNMxNG1ClkZzO9Nc01z0fee0TE4esJHqBLc77ZFzzOzv+9KN4bblEzVgMUoz2tvdBB5TC15FtDFHpBaYWQ2A5+vHi0bzpKlMnoXLSEPmNLg//ydh5RW/RpATEdIyjmsp2XADN5bJ3qsoDn8zUbjUCXMzc1I7hjliqNcGB8omHSTJMU6zJ4S6vmTMsHwwUVBSKcm06uGASeJz53G5Hfzr9amhVq7UgkmnfQhm2uoHgRq15akFqp3mwBl5ymhMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnGTfC2so/TdDmmJZOLXnHyQA75Dl5RKFPkElybDMIo=;
 b=GLpihRvHi0OS6LZkkmSSc+f2ZOeaQgj4MVm816LCoGrNXCq3Ljb82eUFcMj4A/qzyOj506LEatL0f2RP6Yr7STihU8PVs7erHsck1h0+tWMNckWdPxWEmYjC2l1os7MLfREYkkHK40YQ61pl8IRDn3yHW5Ricfc6qvZmdlkKqKQ=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR0401MB2400.eurprd04.prod.outlook.com (2603:10a6:800:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Fri, 12 Aug
 2022 16:01:00 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%6]) with mapi id 15.20.5504.023; Fri, 12 Aug 2022
 16:01:00 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Jon Mason <jdmason@kudzu.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [EXT] [PATCH] irqchip: imx-mu-msi: fix platform_get_irq() error
 checking
Thread-Topic: [EXT] [PATCH] irqchip: imx-mu-msi: fix platform_get_irq() error
 checking
Thread-Index: AQHYrhQOP5d6rSqek0SldjlnxCHOoK2rbFaQ
Date:   Fri, 12 Aug 2022 16:01:00 +0000
Message-ID: <PAXPR04MB9186C1B9E2E46A0D9D16A62988679@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <YvXxxGHIf1amGV6p@kili>
In-Reply-To: <YvXxxGHIf1amGV6p@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aa19a8d-aed3-4d14-cd8b-08da7c7bd9d8
x-ms-traffictypediagnostic: VI1PR0401MB2400:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQokNpGOz1HCMR1gASyfyeS6pPeTCJ1v2EGRKBN1Udd4OKzAy1YiZWbZk0tbpL5wuhIsnOcXfREax1flFA7XQ0gIoWkEbGe5F31fCuO0+yJDxJoib0Yd1oXBSQlLj4mz0T5/I2M6k4C3QhsgfGC1wzCzybEIwIaPD+bV4uitefKxasTFeH0Sm5+iH2JlrFfNzIk+6/+iTAYGIrz7Aho++eec8LDy0XwJ04a++fHz5l31wSXAMcWPGm52716ku7WotlaBorR916s05y9IEgXtY8U24q6fRJUrgnnZHvhjeSABMLWFAOwKDRKGY86QaNW8hXE4R+ipbLuRN5Elvk/JSY41AzvjTYTv8EOmMQhfujfGwcr1A8TC9H29ielJdl+Y/cdDO9qI64MkFPmn05t8NjiOn5EVvg73osBLQe9MsznVGL5V7LmrPe3iYfi5mkf4UQhcWscfnTt+/IhTNDzzq1qgspjGPa3gIeHJYHWaBT8o6FPILJ97Ig8iryStY5JKMx4YqOqWUu/hkTHuGv34UazOHDCCJKITEYPEf0z7lhKZ2oaSKAiIXkujhskSOZglelTOv/6428zJZLVJoiTfseD/6HXl5x8A6x0HZvHroxrDbNLNBKglKOykK0VxA4DRb6RUjOKJ5IvymnR+d50agM/vn6UxaUZBktuUU8LQGTBZFkWd45PJ30HywWgqMtw5zdyWaF12eVzN2ZSIfoeRZRky7u7zNAr79w4NATRfH0weh5CHDwNxtXOX9QWJs3eqUn8+z/W3Egnfc3p0O88GbcfxBg75CbX7wWPcaYFZbiftPJtp1kK/jreLQY4HbiSi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(5660300002)(55016003)(52536014)(8936002)(478600001)(41300700001)(9686003)(86362001)(186003)(7416002)(44832011)(33656002)(6506007)(7696005)(55236004)(53546011)(83380400001)(2906002)(110136005)(54906003)(122000001)(38100700002)(26005)(66946007)(66556008)(66446008)(76116006)(64756008)(8676002)(66476007)(4326008)(71200400001)(38070700005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DZCFnEXsduy7n06tQ0ASoOOh9NDXmAPb7SGSpWOzCCF3wJe/kkXgok9sm6Wm?=
 =?us-ascii?Q?yjxrxW6eRBjNeN474SaF1JgGBsC+fc2e8uOPj+9qwCdHj9nQol2nOwd7E60h?=
 =?us-ascii?Q?TsDwV1YdK/9M9izqtMHfB9CFHeKx2HzP8Ux1sAttwz+MicfZ8kTnTbGFiShm?=
 =?us-ascii?Q?j+GOVV+hxTyUyIptwkLySpfTOxwTMxT8bdGsLVnj/thVBZC9CYPzWwOxmiMb?=
 =?us-ascii?Q?lxYdiA7ycIftvmwO6uv0jyRmIqEcpcfNkEC+u9Oq85xPjJT8rwxBHm6Ht6Ix?=
 =?us-ascii?Q?g5wMY0DFhQAFv7Hogfl/FYazh9Pd1+XRIjOorDAzAsH9gKWNGPStPLP9+I9F?=
 =?us-ascii?Q?KJM2e341I3q0WvCS2S/JWFq6OAPOk+uZ0ohLGtefYrezkXcBL6mtjyNyVqQF?=
 =?us-ascii?Q?rcETGDVQGNKuEWLC9koqHqtkk1giYl6J3arEpkBHQ/FT6r92/yV6ZqNTLHwh?=
 =?us-ascii?Q?ITKZ0P3+tIjWB3bu7z1EgojnfI+H1hiI/hV1/hlNg3Pal7kwkoUOKqNWBFEY?=
 =?us-ascii?Q?y7ROqmHl87llSWYAAnmZEwNbyD1YbEPsykEjcdTdR5Q2MaTwaRbfgfQvfBUP?=
 =?us-ascii?Q?8kZOkF6aKTJSaX7tUpgBbvibHT2J6hMLIwV4ZlLIxGAbvt+h2DswAKgBV9Vs?=
 =?us-ascii?Q?Zvn8dzKGJlrfxIWFJ32hMqyLAFxt2PDEf5Kb45ZNhIm7594pMFFEMjuNwJbj?=
 =?us-ascii?Q?RUJ6840ebwEVL94n2HFrbcIMERDBOjaLcnsHlujMOCJkQCwmkiO4CekAn8/8?=
 =?us-ascii?Q?UkqJd4cV5fbqu8VWwSYCj2MRTzZR90bqtr+VuhkqWlrEbeJPtx/kY1H9Hzr1?=
 =?us-ascii?Q?CV+/rm1K3LjbwRaUXVonILabwK17PMpKXvFdl/5JYE7TgyGoDRf0CKrmVuUf?=
 =?us-ascii?Q?NZVLd22ryjEKQgtbfGrQ2k19nM7r895kniCzbEY5U+62ehI/7Ua0aKgo1cqa?=
 =?us-ascii?Q?ATsnYiHbAQKRnqDhj7CSqXXzW5jnIaURNv1E6hPu+nyRVvsMmbL0inSCNbX2?=
 =?us-ascii?Q?btRSs0yTij0hcwDniGOxlGQyyA7okdcqZY3DtgRnaOB4BmzC/+SFIHyJcPJy?=
 =?us-ascii?Q?AB4eEnNA95INLVQ9bUVj9eGi74r4z59jGRjhdKvUUYi+TfrFw46l5VbGvu8P?=
 =?us-ascii?Q?PJbQvU0JsNRrMOK/hs8QUXh5Yhwoy1OZ+ccGIWACC1HIHyiN6Rdd+vBXJvef?=
 =?us-ascii?Q?EO5IH8Sz0u+j5WFpKrdftYlEEEfuwEpcDDAB8tFAXo8dRsp13sn7p94WXJ50?=
 =?us-ascii?Q?EZbigcC3Q8PDSI6bAiJGjFYpMup4l5ouFKKlDBGBbuYfk26mug2kY/VG47LJ?=
 =?us-ascii?Q?AlAcRbV0xLV/xCncjns61AH29iPDYYmLp1qsTf7Iq6RDmjN19uXDeImKSogl?=
 =?us-ascii?Q?xw4QQHNqIFwRAzqn+LiLvoZEKHifyr30axHs/3TpzD91mNyusLICGI22R2c3?=
 =?us-ascii?Q?e0HedU0r1Kdsqq2cVvB49wLMmd6hBS1Sv5DfFx9N85OQEIIFLFqqIQLqtMRd?=
 =?us-ascii?Q?N0SY2MNmqWHEbJLwnAAr04P1a+QJsxvDiPh3sgvO5pFzIeuuXrE6xea30+km?=
 =?us-ascii?Q?kXudanrGdO3Lb0F22J0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa19a8d-aed3-4d14-cd8b-08da7c7bd9d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 16:01:00.3407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kODsa2erBogWmorvgZrPGN3mzKzemHsz5Uvy0IpAbc3TXg7D1/vnICQA/VDGJmuDvzaQz6DAWCWqd6DHT+PYPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2400
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
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Friday, August 12, 2022 1:23 AM
> To: Thomas Gleixner <tglx@linutronix.de>; Frank Li <frank.li@nxp.com>
> Cc: Marc Zyngier <maz@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-
> imx <linux-imx@nxp.com>; Jon Mason <jdmason@kudzu.us>; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [EXT] [PATCH] irqchip: imx-mu-msi: fix platform_get_irq() error
> checking
>=20
> Caution: EXT Email
>=20
> The platform_get_irq() function returns negative error codes on error
> so "gic_irq" needs to be signed to handle this correctly.  Also change
> the "<=3D 0" check to "< 0" and preserve the error code as the
> documentation for platform_get_irq() shows.
>=20
> Fixes: 893ae515ff8d ("irqchip: imx mu worked as msi controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
[Frank Li] Thanks,  893ae515ff8d should be under review. There are still so=
me issue, which need be fixed.
I am working on these.  I will squash your patch into my next version.

>  drivers/irqchip/irq-imx-mu-msi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-m=
u-
> msi.c
> index f7193a6c1245..97f3cdab8f58 100644
> --- a/drivers/irqchip/irq-imx-mu-msi.c
> +++ b/drivers/irqchip/irq-imx-mu-msi.c
> @@ -80,7 +80,7 @@ struct imx_mu_msi {
>         struct imx_mu_msir      *msir;
>         u32                     irqs_num;
>         unsigned long           used;
> -       u32                     gic_irq;
> +       int                     gic_irq;
>         struct clk              *clk;
>         struct device           *pd_a;
>         struct device           *pd_b;
> @@ -355,8 +355,8 @@ static int imx_mu_msi_probe(struct platform_device
> *pdev)
>         msi_data->irqs_num =3D IMX_MU_CHANS;
>=20
>         msi_data->gic_irq =3D platform_get_irq(msi_data->pdev, 0);
> -       if (msi_data->gic_irq <=3D 0)
> -               return -ENODEV;
> +       if (msi_data->gic_irq < 0)
> +               return msi_data->gic_irq;
>=20
>         platform_set_drvdata(pdev, msi_data);
>=20
> --
> 2.35.1

