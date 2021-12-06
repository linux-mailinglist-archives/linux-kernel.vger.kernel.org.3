Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A81E469597
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbhLFM0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:26:36 -0500
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:50113
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236658AbhLFM0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:26:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii9zbrfvb1btG+KA+TO/E6WGoCAzQt9icU43T8dZUi7ZD1rlPW7Rczj3HOs8fyPQ9J4gOUryY6Ku4/pkfWlcTHbbFFHxJq907il5DgL9PwFPWCu1sm7y/EsZZIzI0tVK/CmNxvihBBNpnDTGBNnkYX3ej6Czkkv7gBPKKpa3vWfi3Jh5NIivJ66v3OzjggxcUuJCU87fbBDg3WR87v6ns/pb80Zy90D7GAXDaVhGyyN8U3cdnMEBxUqRba9dfAAg0ieJ4Wt8lGSG7PGIOSJf793eJZ4zIrVLLiizSQk+FJHTV7BENb7CfrjTOx9eUCCXIJjGFHOwoMDF51aufx9HhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f6peKUSZmpB5YLgGMxyuOT+kx4Dq/aZoxNioLshOgs=;
 b=evwxrvny1n/TWcSAa6P2O4rM9SFKNTUqEngFzH/jxWUzZkHWcp8JREm/2gzAr8Kik8R5nAl2suXoSW5HouJVF9xnWbRpxqF+v9w0G1qJqpxtP8lHpwisNaAR4762TMR+jEuam092tzPC/Ju7rjFG49TovOlqCWHaNi1dBxfnXuP3V9wP54awGG9MT9vZkdYXmCsFf1E4MYT6sohuri9J5VFYbcxG8e+VA8Lg+PTEgY74aPtEva28cMBH4czbW0EtJkm3Zwq1Z9LEU3BjiXG/xB6kO34h9woUrnn97jgCYX8CfVEQWgHFeuC51/miWgM0wDnxOtxGQeTlKGj43Hy3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f6peKUSZmpB5YLgGMxyuOT+kx4Dq/aZoxNioLshOgs=;
 b=fRPv18AKF9a8lq6K2Mhr17QexHtypUQhOmhvWIN49QpzKDRI0w1Nc2XL+aFKh+YhhXPfLMSkezcUyiKzoZFX4WnULLyhfJLDIMZRQYH4yf7lsxMyyX2YCxDMYAt7dWM8CVinyEb9U/mP8dcgYzxiceqcVyyWknwFT/aJkOhPoA4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8805.eurprd04.prod.outlook.com (2603:10a6:10:2e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 12:23:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 12:23:05 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        =?iso-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH] soc: imx: Register SoC device only on i.MX boards
Thread-Topic: [PATCH] soc: imx: Register SoC device only on i.MX boards
Thread-Index: AQHX6pYUsoprkzANFkGiGnubfC+N9KwlYphg
Date:   Mon, 6 Dec 2021 12:23:04 +0000
Message-ID: <DU0PR04MB9417887E5C06F599C2048B14886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211206113828.42523-1-stephan@gerhold.net>
In-Reply-To: <20211206113828.42523-1-stephan@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cea6a24e-3c41-4aa8-72d4-08d9b8b3277a
x-ms-traffictypediagnostic: DU2PR04MB8805:EE_
x-microsoft-antispam-prvs: <DU2PR04MB880527C9E5FFE66FA76F1AAF886D9@DU2PR04MB8805.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTM6ccERPAMec/DMzSv607Vt69PniChcQGfR+BMQbBsBu4yPI//hLAr3bxE0b2XHqgmUpXRDWeNz+TDu566n/9zElv3utnCjqbW/kLhWwbTEvIdBG2Cz2SX+aSWbj6batl229V5rKPCQ/lGdQpL56qEZO701OtLWwDWvm+aGQlrRsLRDhAEKtdKm3LyFCXI5tmA2+OYRU0AiYA/dCbO49YXtrwiyetiF4s72qKhqn79/+L07XOIF1w57uxvn2EejnV4njj4xH/uUnSXcU9keq/5R2TXkGMyOZroa7LNWNC9f7bzXVyh2v7gScbkBLwkRZIbntY7Lf/Zo2rhi0xwUfzwks/rsA3zAHrDo+j0jCs1lzf9LnIGebp+IFi9A2PrB2WfHY6yiGMtSqbCahx7QqnwDquAAklJgpYtmRJyZpi5reNpFVQ7bP38pCzGN/PJgVfU8KYSqcVbtqxQ6KOjrVkXON76wL2iWzP+yxLxcmu1cyEQpvUm1zhdkEPFGqbKyXT2E6BK6q8tHAVDzy9mKyGx9Kf0n35l1fefPDWhaQaoaiGPqbPOdYdHVFzD+92qDV2IzCmtT3wyeqc3uNRzckq6oUqytDVBGMuyn2BByY/RpD/er7HnsC+76z0gYsoIJ/nU4SUJYOHRzCie4kdYA2ugZAm/dKPNLp3+7PTriYf+C1UY7kjvA21pOnN5TkJF3nPO8e92R5yYwFOE/UT3udZ5FQpfqsJCrWDP2knv2JKf5VgkzPb3kyTIZpJOxrXS3B+1bdUSKfi40tekbOKgxC2mJf/ClLhKWGhpGxCRWWzA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(66946007)(8676002)(76116006)(4326008)(55016003)(316002)(66476007)(86362001)(66556008)(66446008)(64756008)(52536014)(45080400002)(38070700005)(7696005)(7416002)(26005)(44832011)(6506007)(38100700002)(54906003)(508600001)(5660300002)(122000001)(8936002)(9686003)(966005)(33656002)(110136005)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eArf81zHjnuB3UUj/OQxDdRSxzyJjREnCXBlciogc8Y3XJcxiPe+FaIlw+?=
 =?iso-8859-1?Q?DeIyv8IhMK7nyx6yf/4LTwrsq0GQMtiLafM9/ZonmfhenAIuovJdzoVvO0?=
 =?iso-8859-1?Q?PhT8wgWeoZPpNh9OoCHU//5xbJbmP6xcg82uf9VNeBXumCGM2cZfYEC4iW?=
 =?iso-8859-1?Q?73GIVKZormrFzoEPKi9A/aJBVRq+1GySRLseYwIiXey2VUjQF8rcHmyBfy?=
 =?iso-8859-1?Q?WHSwp88Vk/gBw2onUAld1yZBc89lygi+2859M3Sd2Dv5IdF6dK4tcaMplP?=
 =?iso-8859-1?Q?eRo25oo2n03VRchP2SuBZka18x35NvxULIZaBipVKQJDwo3kF5mxwdMBvY?=
 =?iso-8859-1?Q?x4R+LAYYF1TDWiPSvttB75lL0M+jiyX7Fi7iuHakt6rEbbn2IrgLl063f4?=
 =?iso-8859-1?Q?u50eV3dM+0IMR9b8ynsIxLU2kr7/7rLUg7G/Eo0n9Vme24q+PW7Q++EqVu?=
 =?iso-8859-1?Q?g83kYh/w8foYppsOwdP37BdPwqviTz+SH1697iJ+9FKOFOt5XQApB/zqL5?=
 =?iso-8859-1?Q?1O2BTLC0webBd+RAwE3Z9ZcWWtF9KSTOficOB90x7QPJnuTs/0FCNTFnOY?=
 =?iso-8859-1?Q?cC7QppyUGTQyRGufezGbh0jviA/tdb2EudL15PzpNWOiZLDtGs5vSOqnvj?=
 =?iso-8859-1?Q?xstifJ7w/aQHZ+f7C86YiMaz1rQa6uLk0UB4CdOHV0CV05RDowtClDLFmI?=
 =?iso-8859-1?Q?l32o+xBtwcMlAgtVD2lqx+inl+PLul7nmLvkl4uqEUfs3HoIJPzvVya/IC?=
 =?iso-8859-1?Q?hAT/8iNunF94BW9eDFSqUr1dPZTeTc9QUFlYVjWGiEBKKUZBCDDxjj9f1l?=
 =?iso-8859-1?Q?opNEdpj29hqf+lio3xHaJ/TJ9DXC312ZvUJzE0rIziu9F+S1omoIV4KVVr?=
 =?iso-8859-1?Q?jTxLdbeUJQzaeANqD2HtwMLiEzHmjWWn1qC+ZWRTBBnQOpWjIlyfX3kwt2?=
 =?iso-8859-1?Q?qFloMh8Y8apl+lkR5eHwshjPq1NcAp5oSbc/sUyp/y7OwLi2v1mn4+zCSz?=
 =?iso-8859-1?Q?8IqFXCT3aBQGI7rMqI9ntclOB8t0yQP2gnv7px+deIms1v1eMKE1Gmiuhw?=
 =?iso-8859-1?Q?qLt4kOZREmgfneBKTwKzO7PTy3VLONvgkZcrPuWu1A1krlBBLNX+rYD2xf?=
 =?iso-8859-1?Q?DLNFZl4WGqGC5eCd1zOEjp7N6CgH5wd1STOpwlAdtNM82Jn0qV+8ZX6kqt?=
 =?iso-8859-1?Q?hhYv7PR2rSfyQciOY5T/aSAXzPdrJgiaSe9pDkghLrFtwsX1hOwiVtr6/E?=
 =?iso-8859-1?Q?57FFU0rX42WcnNonuDHOaBtPquFXPQIgdFlgc/bHZmP3do1ykAYPVZEg2E?=
 =?iso-8859-1?Q?8oAPpAmFdWibLcoKHuQCNnD5QKGrucBOSvU732Bz49M3ubo0lahCiqv1/r?=
 =?iso-8859-1?Q?Q1fMBhlZzTjhjlfq3Bw2LhTbzHl8AMil7AKz9Z9jBUez1F4MEp1b4vd+uX?=
 =?iso-8859-1?Q?VKYOHsIzTjJKHWdTe6LQyfResSfQWQg+m3OmD9mIGjKDOH6qGsrEmHFsyP?=
 =?iso-8859-1?Q?hcOW8D/FBO1aVr4yQq/4otfm3G2Xsg5U0IgG8NsEWLrQdSrBWpGJGeIh3i?=
 =?iso-8859-1?Q?4idhURjlDM+APR+q7YwVQ32wC1h0IQ6V5WdpCv1CGx/Hn/3UvP6+6p1Ncl?=
 =?iso-8859-1?Q?peKWIdg+Whx+f/UFiamI/SMYG9VtC8D3Cy4dvT3IjP5uGGwC5lkKngKl/F?=
 =?iso-8859-1?Q?Qs8Sv34/gUKsGPQpwZM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea6a24e-3c41-4aa8-72d4-08d9b8b3277a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 12:23:04.9414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2kJIJ5B1l9m2VAzEZchxIjq69hvv2XF89e1rYtbYE/s3Eo4clOT9SHibWg3tMlP5mxirphMYXA3GcOy6uiZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8805
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] soc: imx: Register SoC device only on i.MX boards
>=20
> At the moment, using the ARM32 multi_v7_defconfig always results in two
> SoCs being exposed in sysfs. This is wrong, as far as I'm aware the Qualc=
omm
> DragonBoard 410c does not actually make use of a i.MX SoC. :)
>=20
>   qcom-db410c:/sys/devices/soc0$ grep . *
>   family:Freescale i.MX
>   machine:Qualcomm Technologies, Inc. APQ 8016 SBC
>   revision:0.0
>   serial_number:0000000000000000
>   soc_id:Unknown
>=20
>   qcom-db410c:/sys/devices/soc1$ grep . *
>   family:Snapdragon
>   machine:APQ8016
>   ...
>=20
> This happens because imx_soc_device_init() registers the soc device
> unconditionally, even when running on devices that do not make use of i.M=
X.
> Arnd already reported this more than a year ago and even suggested a fix
> similar to this commit, but for some reason it was never submitted.
>=20
> Fix it by checking if the "__mxc_cpu_type" variable was actually initiali=
zed by
> earlier platform code. On devices without i.MX it will simply stay 0.
>=20
> Cc: Peng Fan <peng.fan@nxp.com>
> Fixes: d2199b34871b ("ARM: imx: use device_initcall for
> imx_soc_device_init")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Fr%2FCAK8P3a0hxO1TmK6oOMQ70AHSWJnP_CAq57YMOutrxkSY
> NjFeuw%40mail.gmail.com%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.co
> m%7Cba6334562b49404f88b708d9b8ad36b5%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C637743876348146819%7CUnknown%7CTWFpbG
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000&amp;sdata=3DmAeB%2FvXO4cUbcPPLBH14LkDzxMz2w5SLj
> iNEZhjgFuU%3D&amp;reserved=3D0
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/soc/imx/soc-imx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/soc/imx/soc-imx.c b/drivers/soc/imx/soc-imx.c index
> ac6d856ba228..77bc12039c3d 100644
> --- a/drivers/soc/imx/soc-imx.c
> +++ b/drivers/soc/imx/soc-imx.c
> @@ -36,6 +36,10 @@ static int __init imx_soc_device_init(void)
>  	int ret;
>  	int i;
>=20
> +	/* Return early if this is running on devices with different SoCs */
> +	if (!__mxc_cpu_type)
> +		return 0;
> +
>  	if (of_machine_is_compatible("fsl,ls1021a"))
>  		return 0;
>=20
> --
> 2.34.1

