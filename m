Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AEA4656E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbhLAULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:11:02 -0500
Received: from mail-db8eur05on2046.outbound.protection.outlook.com ([40.107.20.46]:54499
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352849AbhLAUIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:08:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U96z27fIUIf3iQFaAf0K91BkZPpd65L1ZVK1B/c/mtSxgjZG9XAtgdosR7P8ThCbzNQJXBxJO/L75IzQD6SeU83lHhwkwF1BAyBLbxeuI68tG2HIt8MhiWCc21SY/S9J2Q9YSVVyRQXkxBVKNYNd7qYBhoWq7i7M+Jh/PtK0+MOn8fSz6ubUK/Pj17Q6ZxON5uYQEKJ8+ef2ZbYE6GkwssE6E+K3lBP2D/mNRwZifHWSe2UYD8WZV1Knfj8mNMuqHRLD/RijEdlcyDCY02CxZV6ep35w+eHxAZKs06WSGeblxc4fKmp4utlNEJcyntVVvvjvyh2O8Vg5VUgAXGzSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI7mGU6len4tqyLg6+ewLwvaYlqzono/ZUiOqqsOvYE=;
 b=j+EegpQvLaAXQP+0tAUsyE9uO2iAJd1GEDHcL8Rfz7rYPM8WOyUfiqBux4qKYyRl1IXW/m8pFs66kMI4Z6dNu5b3gGIfDeA41Lk0RGoCD+MBLELxxUX2LzFEFNmkIXUr+pWDy5jE3IB0+fOmhubuJKgd+l6hOGtWs1Qtkg9tnvtr0E1oWkSUWc++SLwhn6ChMcPiFsmcOHC3mmU8XMb8SVl+bYfOoSS7GZcmHQ4pN6Vr0u4hxq2+bhq7g2MibSluOQsJVBiM0uPVjWL8buC6Ntc0y+hwg0Wsv3leiIP6IpYwy0Zvg1+WKP+FNqSc1DQndO5oqB+9BeMK7RkXXvKPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI7mGU6len4tqyLg6+ewLwvaYlqzono/ZUiOqqsOvYE=;
 b=vcWkhtAb1CvRipYIYN2U1eHiJcygMzAuLrEXm0/OFJmiqpT+jknIBD7uLO8q+v7zPIhR22DrmvXh1zgIl3EMQIGFjXWIBc571XdCW4ZWtRSMm6wtHDyLTHEQkHpr37qb3xjyMFJ1GIMK4lPLYR0yAMmrL0EBPCZvDYyMCy4to7s=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR1001MB1125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:63::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 20:05:08 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 20:05:08 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 2/4] watchdog: da9062: reset board on watchdog timeout
Thread-Topic: [PATCH v3 2/4] watchdog: da9062: reset board on watchdog timeout
Thread-Index: AQHX5oucZnRw3eiBrEm6X8WjUQIv26weD2Qg
Date:   Wed, 1 Dec 2021 20:05:08 +0000
Message-ID: <DB9PR10MB4652EF562CD20FB72FDBD71880689@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211201081512.3580837-1-andrej.picej@norik.com>
 <20211201081512.3580837-2-andrej.picej@norik.com>
In-Reply-To: <20211201081512.3580837-2-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58f1996c-1a4e-48db-73ad-08d9b505dfc3
x-ms-traffictypediagnostic: DB6PR1001MB1125:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB6PR1001MB1125B15E33A9ACDDDF2E46A2A7689@DB6PR1001MB1125.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qEEnGyzT2PtfdghjIu9W6w9xQdsF960WE5hBO2JK1hfBgdZLozPjxM/NJVpAyJBiP+5EAzd4t4bXJyTlfV0ErEPyeoFuREA4KpnR3/7iUd/IKXDj3pmB2Hqwbr2AzwafBfemDFFrlIdWqR2G5VRNtb+MDBYDBbhoZHQbwl6QaKwD1KbnYoNmaAt6kvVo0Ls6kcuRc+fgfIpfIrCHMasiUSRKdvWzVDBxiV7sRK/W4xJBkgu0rsI1MbBZpc8BXJB/pupXPlzm5aY43/RHnopjVzgbZ03Fsk2qKw+nWTJaJGpBRn3eDr39Zf2aeZ/8umQe2LlkaDxvWDE7i99/59EM1Glc+GX6xDo6ZObZhN0dAr1u/SYRBZKSIBbHK/Vd5eNIJ5dXcEoioBVvXGpSMcn7ara2aHtcAKDpqObYFc01AWWV0DEnzNsjJ2/OLi/Vq9wp5fkr6yim3H78fLSDj9DpJHJMxzmJbdBzk+IjMHa/A25Qvaaj42mb6IB0nuOf+TbW2J9ivwOSGYfgC0FDse6rz33Gt3aL5X4SCKj9/NUR4FY9HExsAFFx9NwP3yarZ2Zwnbtzd68LSIFJxw3lzW8BT54u1NtFKDkv8gtKtvd8gTxB3n/bcW+5mGmlyKUxrswcELlRccJT41L4WpeM/UESDppV4XFpL+BA5EyNxgyNBMbW9i+ZWGiwxtAN7eaec5XV1tPkmudyoDELmwun+A0pEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(55236004)(7416002)(122000001)(498600001)(55016003)(86362001)(52536014)(33656002)(6506007)(5660300002)(38100700002)(53546011)(4326008)(66446008)(8936002)(66556008)(66476007)(7696005)(110136005)(54906003)(2906002)(186003)(9686003)(71200400001)(38070700005)(76116006)(64756008)(66946007)(83380400001)(26005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VzDwZUqdw5sxuKvT7bkzL4wjLm6HEYRXvlAqSJvibEQrDeqpCFaePZYRQM21?=
 =?us-ascii?Q?yNSnV1Th+XwWIJgf/Sd+iwuZogS8eXyfvyO1K06BjxkkAomU0/oU00u1uN0o?=
 =?us-ascii?Q?8iqaBzRdcMnPZrYrCQ86C8v0f5JDIHKL5G2J+buqbfJj8tlPq6P4ilqW42UW?=
 =?us-ascii?Q?TQEAF797bWOZbNb84ENaj1v2aXh38Jl0eib3LxnUj5fsfOuKw7vRoiS/Evw8?=
 =?us-ascii?Q?+AeszdwR0EfbUY9bVh+2rTHGtNHBbktCQ5b1wSYnLNpnkqp6neK8A1YRWQF7?=
 =?us-ascii?Q?+cHp6u4elgrvHlPJhSefmN9vrcsQc2Fp32jZSlElWDuAlBa65h7NbTtLqSpD?=
 =?us-ascii?Q?e4pND63CBg4RROg8n/ObVhPWwDujRLR+j22ySsKFnpFtfvwfw525M5wt9+Yj?=
 =?us-ascii?Q?QHadsbxdIv/MEdtv8BPqCTGiWvUP3IJiJdV06F4ljO87U0/OYmBDg7BNUq0b?=
 =?us-ascii?Q?kRlwmp9DpuJ3RrMwmHHBBbq8y4VNaBK68gav1JyEhdeGOWFnyhrAFkRuhOFq?=
 =?us-ascii?Q?ZgeHny8KPlktRoT10TTmuHgVASeQYc1Ct2/ow8LaHifGmnZp+Y42ZxqAtJcc?=
 =?us-ascii?Q?uHHH2Qn8uIApp14Ee/5DK/9Stht52ENHfj5B8+VTXv4FRpX0HTeD1sD7v8Aa?=
 =?us-ascii?Q?2VpUhg7ZYK0h8GPcmUvogghHw/SYBiWNLxB4r8gqY5c6Zfgap+xarXoQN//y?=
 =?us-ascii?Q?Pzrtv6iyaZSPumOzeOhtVmuFoUv8P/X2xLd9NfGljEgCNKAL447a6C7GpAaV?=
 =?us-ascii?Q?xAoVIlUdvQHDDvPcgpiiIph/k5/1k3kFpJWSNEF3yyHtMdnzzZVq54yhYTDw?=
 =?us-ascii?Q?33ymmFQ5yz3q8JHr+/OfcEOmH28QZ/Wr5lAsvk4kBwBiNH7EG43ZfCuLVAgg?=
 =?us-ascii?Q?bNn7H0ljW2zezhQifiCgfJFznLRZV/SEpoLa+DeZdXK3m1fyjfzHkfsTaYtP?=
 =?us-ascii?Q?ZDboQxaEg8UQylYO7vJJTI3TKjIHHZLPLhe7v90SR5WFWV7XZRoochdj5l6s?=
 =?us-ascii?Q?desR7HMt0ccaC3k0yDDKlkCvMalEWQTz5vowOpFwNHOgKgYRY65G7QwuNejz?=
 =?us-ascii?Q?uiW+RueB8AdyTGpnPr4FtUZZTddNQyw/8fH7Hssv8STvovS2zidObe9H84br?=
 =?us-ascii?Q?G74T23RYP0U3Tt7UgEgkU+ZnG7+0bUN94zC2dKxbS7ROAKuB91iW/SadYkfF?=
 =?us-ascii?Q?wpbtD3C+9FntME02dRWpvvQGaCIzscK5MLSQQfsj+DkeqvBU5qBdNW7xIVRB?=
 =?us-ascii?Q?QhoO72Z8tEhPhYkA4MEppHymqSAEqvQd0uokCYgNbai26AUSLNjj6X9pH8FR?=
 =?us-ascii?Q?hw/J8I3qbAn2lgmY2WxC1bOt46QnyF/DNTun10Zpe9bCuEKZ5MLZH8veCIHG?=
 =?us-ascii?Q?fT8N6XIehX9Sk6hMAE+oDAwAFheJJbXA/i3P4JHh/AOaeQnwvWCn1ADds7Ow?=
 =?us-ascii?Q?shbEcG0nRi32Wa4jVFHMfXsFjCeevEeYjjGvBimFgMl6rBYCTW6ZdwsANMgK?=
 =?us-ascii?Q?8cr0nohBp+8+Vh5jXqn4Tf9i5FGZ/AQOVWVQpwy5B72Zp5kZzfsARLD7Ikg5?=
 =?us-ascii?Q?rqw5mi02cPcoKc5k5UcU9UEy4TDcP7ltiRKN2Kb+4MgbcOt9Dk/UeVd8Bat6?=
 =?us-ascii?Q?Ni9YEP16Tde9NTK9+IPecxzFyC9rr66tJhR68KGNFrDWD51Hm6SBrb+6ki5s?=
 =?us-ascii?Q?qv86nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f1996c-1a4e-48db-73ad-08d9b505dfc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 20:05:08.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRzopcZYhdxFaD2R+sjpdYk2i5Js1xDrcq7BbVIDsRFWunxb/gfPCmBeSH73zy899XLchv1drYdYjuwrRyFL771vj68aU9lUC2b44mZrxVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 December 2021 08:15, Andrej Picej wrote:

> Implement a method to change watchdog timeout configuration based on DT
> binding ("dlg,wdt-sd"). There is a possibility to change the bahaviour
> of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
> clearing it enables POWERDOWN mode on watchdog timeout.
>=20
> If no DT binding is specified the WATCHDOG_SD bit stays in default
> configuration, not breaking behaviour of devices which might depend on
> default fuse configuration.
>=20
> Note: This patch requires that the config register CONFIG_I is
> configured as writable in the da9062 multi function device.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
> Changes in v3:
>  - no changes
>=20
> Changes in v2:
>  - don't force the "reset" for all da9062-watchdog users, instead add DT
>    binding where the behavior can be selected
> ---
>  drivers/watchdog/da9062_wdt.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.=
c
> index f02cbd530538..e342e9e50cb1 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -85,8 +85,33 @@ static int da9062_wdt_start(struct watchdog_device *wd=
d)
>  {
>  	struct da9062_watchdog *wdt =3D watchdog_get_drvdata(wdd);
>  	unsigned int selector;
> +	unsigned int mask;
> +	u32 val;
>  	int ret;
>=20
> +	/* Configure what happens on watchdog timeout. Can be specified with
> +	 * "dlg,wdt-sd" dt-binding (0 -> POWERDOWN, 1 -> SHUTDOWN).
> +	 * If "dlg,wdt-sd" dt-binding is NOT set use the default.
> +	 */
> +	ret =3D device_property_read_u32(wdd->parent, "dlg,wdt-sd", &val);
> +	if (!ret) {
> +		if (val)
> +			/* Use da9062's SHUTDOWN mode */
> +			mask =3D DA9062AA_WATCHDOG_SD_MASK;
> +		else
> +			/* Use da9062's POWERDOWN mode. */
> +			mask =3D 0x0;
> +
> +		ret =3D regmap_update_bits(wdt->hw->regmap,
> +						DA9062AA_CONFIG_I,
> +
> 	DA9062AA_WATCHDOG_SD_MASK,
> +						mask);
> +
> +		if (ret)
> +			dev_err(wdt->hw->dev, "failed to set wdt reset mode:
> %d\n",
> +				ret);
> +	}
> +

Personally I'd stick this code in the probe(). The value won't change once =
it's
set, and that seems the more logical place for it in my opinion.

>  	selector =3D da9062_wdt_timeout_to_sel(wdt->wdtdev.timeout);
>  	ret =3D da9062_wdt_update_timeout_register(wdt, selector);
>  	if (ret)
> --
> 2.25.1
