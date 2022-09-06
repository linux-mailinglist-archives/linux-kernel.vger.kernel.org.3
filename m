Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576065ADCD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiIFBQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIFBQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:16:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F9067141;
        Mon,  5 Sep 2022 18:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcM7xqtI2CYCwppx0vvWnzO2UWf7j0U83DFr8g58JJy/rG9i51WKzkqFaHX5DPaSo/Ox8K1DvcNkO5BBnzPzzu2hONmAJ34GGPSU+pZ7TrX6ipUHlTHBEZiYEiz7tCCD2uAvG7uFSnlzTL8ZxU78/JEHaUsWwdrkBR5nBCB3XwTq8BwGpEIBeJfixbkHv5mzjJrH0msS6XEBapXbH/au/wY8jIuh6JTBPPEJht0ommjlkmTJQHEFdIwZd+LMW6H7MKgPSc/FbqBI6r7PHEEqDypyiBpsG7lfFl6gfzeAVuJMIyL64bCqc5dxybznhvn1VNd8Z2y2JuZutQjfoESYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/EiDc2sTe07/CNC74bvPQfmJFMgdY+RrVxkwzaMsoM=;
 b=mJnqMKIpkHtrZ0MzYvTjVheb8lMT6OL+Q0KBfdq5LlPA5trpcjwk+JuRMiGvaULOEv0JqJ8AtYcl3uhF2/QzkLPrGvMXL0Q4nfTRO3//KhuP4eDh2JmW1xFtxcT3S3HN+HRpirtnVlNbYxkAsWgwVZQYhNaQKbM1T/sbwRi6t49I9DhO2zEZyHxsREfH014Lss37przCkFcwbKUXnxwWmjgh0DNUxa7BXEr3AVk8KkgGlqE3XsPMKRLzCeQgEpsgAUY6W/21A8cb7WWGjSOz3WbJl/lNWg8HWc/wE9pu05ab/NmsyqRK1+zKIpHauRcC10wKwwI//gazcsjk0sGNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/EiDc2sTe07/CNC74bvPQfmJFMgdY+RrVxkwzaMsoM=;
 b=MaHAPLUBiCd9VDa58bNTV+DhN2LxNFFThQc6V0RH99crBX+rOJ5Z9iJga3QmL1QPzuqphLNK5qz3hpj3bwGIQIWnyJFyAGRzOs3vOqwph/cHTaun5Zziul3t78YJ6AE4ejv1Vf0Ilv5A4UzSROptaCHw0bbiyKhF2PFY1/fNZbE=
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9)
 by PAXPR04MB8526.eurprd04.prod.outlook.com (2603:10a6:102:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 01:16:30 +0000
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::38fa:c0c7:75b2:39fb]) by DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::38fa:c0c7:75b2:39fb%8]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 01:16:30 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] pinctrl: imx8m: kconfig: Fix build error on test compile
Thread-Topic: [PATCH] pinctrl: imx8m: kconfig: Fix build error on test compile
Thread-Index: AQHYwXkGSXqbDG3mdkqwLumVr+JmKa3RlgEQ
Date:   Tue, 6 Sep 2022 01:16:30 +0000
Message-ID: <DB9PR04MB8412C5E5640C8119FC5FD742877E9@DB9PR04MB8412.eurprd04.prod.outlook.com>
References: <20220905224408.346425-1-francesco.dolcini@toradex.com>
In-Reply-To: <20220905224408.346425-1-francesco.dolcini@toradex.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b07e790-9f33-46fa-d87c-08da8fa56e0c
x-ms-traffictypediagnostic: PAXPR04MB8526:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cz3SEKTw6xNlvZeA+tqYlC8F8N/0GAl6iKK1Ze7F/RWhiYb1jiZD028DfD18oPI6J/7i0YdJBThnih1EuqRD9YzNuJ8WvzGYDbHJEZ+TBfg9l4t/zxMqhsZYPOdfRdSbnmccKB1TcXn6/eUZXOlbyz25PzIVL7vXL/9u0BygGW6MKhLFTlrijsmDyy+vjy8b7xRCVddgQFK0OmEA6mGholD8BUc/DPfr9iKuSWgDAmVHBr1s12WIXhoJK+WixhJS6vErpHkyto3+OkcLGKzyKdnmGAVqI0gUlR5qUk42gODKxAW84QdfwAqgWSQwAJ+Ma47AQjj21fegjzySeEhiSySySPoaH7jgKM3BJ8+aYqcsgGHolFLL/yM/Z715nlSQBhcyCzAhd9A4Htb/uvEAThnOmBvkOruloxxDUzZ5ZNuz282dajMUg3pzBxjQYGKsk5aSQiZEfM2MnTNBIlzSNKc9PNWnUsmLP2OuoEe2lBSNEpijYDFtvML0zLAlfqGO6uo0npk6c2doieIkUQUIATw9mb9J8CneOQemWSsG+1d2eLJDuW/bfkRcZBAc0NdCCo/FucAlm90C6sf8YoEfxYDW0djRd2853swMsz1ns4hTtFZpQaE8yzps19gB2+1rI1wgt0vMMvL9Go7fUiGBINW6qN7Ex+o5loqezOyN/F5t0ilGsPaeMJFDPNCn6w6RWC7K2R4VIdSsC6jlNMSgDdUUi3T8VvB281c6DGXUEugU2cOKB49BFvOheLcW7D1POH++mR11JKqtDyx5h+qK7WGhB4wenXVzMx4ZXkDWhDE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(33656002)(76116006)(38070700005)(478600001)(66446008)(66476007)(66556008)(64756008)(66946007)(8676002)(4326008)(26005)(2906002)(9686003)(8936002)(5660300002)(186003)(52536014)(41300700001)(6506007)(7696005)(122000001)(86362001)(71200400001)(110136005)(54906003)(316002)(38100700002)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pZeNHvRm6qOKKC5f0M1Di/kS3b7oPoyi4IYB13nEpEjbv0JJpfOGxmAVRXwv?=
 =?us-ascii?Q?jCj92X5glQcBdNQuMejsBAIaFVn/H93X5CDRggd8YGpnE2QJDeSki7/J6eoe?=
 =?us-ascii?Q?vz0cJaeYGkE1P2CZPcokejDC6P5HCQZR3opinC/4U/lENjTZL5l0km+7nQ7c?=
 =?us-ascii?Q?qI9LCHj8V8UU/l/w1Rfint2X6cFonA2JlXEGUb1RLQJJZwcKcHrabJVrLysq?=
 =?us-ascii?Q?3FC0CqzOXxUyXYIoBNKiVx5QQ4z4lgyD2X63218W/vylE4yU7dVBTGwSSKJc?=
 =?us-ascii?Q?tUZNcJDopfVJRmBLfzaQdFcl3nmvaeYpIaApnPoVrOGcXIu6edjy2uHLKESw?=
 =?us-ascii?Q?urSdXnOMvAj0YHwkmdZ7IQg/JnIUo9xJddxy+wwTp1FZ2u+ROUqg05tno1MI?=
 =?us-ascii?Q?XxAK8Z5lfTdKye0RCPKat5TGi7mM1qlvte94tYS/QXApnVA1amhj2FGzFuCp?=
 =?us-ascii?Q?5/X05sUtq6hOdaFbZyetTIO64ljP+kWi5EohQg95KieJiL7vKNfm2BvsuGBN?=
 =?us-ascii?Q?U5lCldM9/edLuHUfJhsDlCbdRZ1L/tRTqoTLGP5tHCm7zJK5sYcvAXAZPeiz?=
 =?us-ascii?Q?urJSFA0yxE/ghlW9TOUV0QncQ0LZZkY0Ik9euK/Pccwbto+toCAnEGEvWVMK?=
 =?us-ascii?Q?0VYqdMf5g66qA3wHVtMDlOMX4kULS0v4/KsM5SrnojqNhb2RFk623KgKhwNj?=
 =?us-ascii?Q?4Aa1JmfWhq6KJtsPZ8McjXybKyJh/ROLH84BiIuYbJ6mADnX+lIzBJJ1sS85?=
 =?us-ascii?Q?p/yMoK3gl1P2kQCsGWWAkTNCUnUG/h4zhkoRpNhOICFucizaDLCtVyLjdjW0?=
 =?us-ascii?Q?DCGMcbSdi8iNSQQh1QX/58/X34fDBhVoEAoTl2xUd+FdZGV3UGGdB/ZgpOGf?=
 =?us-ascii?Q?0ICzupQIuW95I6lRj20jZCB5TY32VSNMNQwPPlFjiDTCFo5CitqopZkTAgK2?=
 =?us-ascii?Q?txffgAdGq84o3qk7k6irP5BEvhuGfAQeoaVCdm8ITAOQNMOOIdPHsmNbl0+J?=
 =?us-ascii?Q?P25tm6X8Al8ZZf1KC4WR0pUHNcmmmS3s17B/PgP5XC1Kn2Oc52LZJ9stpJaA?=
 =?us-ascii?Q?hEgPXBVKFGMmxtEin2WuOdKrecSUkBZBbeZwX13obRgy11RejuW3+ECy221j?=
 =?us-ascii?Q?Loexto1ushF00ElHJPseTTez9AoUWvGIvXJ/nx/iSGD7msZmWqmoGszLERQ1?=
 =?us-ascii?Q?sqbLiQW0YWnu1Ohpj0IVoO5/lPpCwuTVLswlc2kGbZA0rzQ2VCBkkYzuG/ol?=
 =?us-ascii?Q?A+2bfSvCdbK7xEehAZjPUXdllaT6WaRdXeoBkUQ4wQTMq06KW/k9MApT1H7L?=
 =?us-ascii?Q?9QuAyryVImZiWFKD6xk8J+sXAwCev2/IfZ521T+g0/ChTk2EEj+M5VTPKy08?=
 =?us-ascii?Q?FnOE2lbuSLytl7dUeZVgkW4IlUJZNdYLubfMvqM+8JhsunK+BBrevtholPoU?=
 =?us-ascii?Q?ziKsUZBU7qY7S4gcgdUoKKE0FSJgsvUMrZSmdLMOos8Rcixhf/V/w4dz5V3O?=
 =?us-ascii?Q?lcuqX3sIPDiDo9Seugxzi0JOVW15Iz4HOmpdhXC2CFIeaIBLGLXxaHQGHHOr?=
 =?us-ascii?Q?PgFJDRmyNvKCl+IABrc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b07e790-9f33-46fa-d87c-08da8fa56e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 01:16:30.4433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6xMH+Mno+t2iT22b5vVFdrc3S6w0x1pPpTN0n2i6oYX6ehIJFB+bDH2JR5kzA+ZPVGtGEw5fVCxXYn5QoDSnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8526
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] pinctrl: imx8m: kconfig: Fix build error on test compile
>=20
> PINCTRL_IMX depends on OF, however the dependency is missed when
> selected by PINCTRL_IMX8M* (it does not follow the indirect 'select'
> statements), select it explicitly.
>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Reported-by: kernel test robot <lkp@intel.com>
...
> Fixes: 87c2a29a6bf1 ("pinctrl: imx8m: kconfig: Depends on SOC_IMX8M")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Jacky Bai <ping.bai@nxp.com>

BR

> ---
> Linus: I did test on s390 and it's fine, but the topic is tricky for me .=
..
> ---
>  drivers/pinctrl/freescale/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescal=
e/Kconfig
> index 365fcff8e470..7a32f77792d9 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -119,6 +119,7 @@ config PINCTRL_IMX7ULP
>=20
>  config PINCTRL_IMX8MM
>  	tristate "IMX8MM pinctrl driver"
> +	depends on OF
>  	depends on SOC_IMX8M
>  	select PINCTRL_IMX
>  	help
> @@ -126,6 +127,7 @@ config PINCTRL_IMX8MM
>=20
>  config PINCTRL_IMX8MN
>  	tristate "IMX8MN pinctrl driver"
> +	depends on OF
>  	depends on SOC_IMX8M
>  	select PINCTRL_IMX
>  	help
> @@ -133,6 +135,7 @@ config PINCTRL_IMX8MN
>=20
>  config PINCTRL_IMX8MP
>  	tristate "IMX8MP pinctrl driver"
> +	depends on OF
>  	depends on SOC_IMX8M
>  	select PINCTRL_IMX
>  	help
> @@ -140,6 +143,7 @@ config PINCTRL_IMX8MP
>=20
>  config PINCTRL_IMX8MQ
>  	tristate "IMX8MQ pinctrl driver"
> +	depends on OF
>  	depends on SOC_IMX8M
>  	select PINCTRL_IMX
>  	help
> --
> 2.25.1

