Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6DA47BA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhLUHLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:11:22 -0500
Received: from mail-eopbgr140051.outbound.protection.outlook.com ([40.107.14.51]:19102
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230314AbhLUHLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:11:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/XF/KI6a+LXMrnrNMq+qnd1aZl1NlVu5KNB0o49DVMejHUhkPEcgCTDKRo9cV8W6O/C7safWoDB/rjRTJqN66yPdaL1I8eYGRd4girzu24pHmB3/SyAOPqOAJrwUbyFu36QnUYtqnSTv/EhVtF52xsg36Sw8WVzG81dneGqsPz0vw6c/81p8Og3dXMFBXY0D5BFP2XI2nLHTY166wEOdsovm9lVhOTXa6E97JnUe9vxKLnuOC882slznO++KGZ6KqYykgamsIs13bqkq8tW1jc1EP49Oaeb0FHnl4gKN4fhy0EQ1zxFGtNI7qUBAS6qz1gEcqocMMOQf55MuRBe6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzGDpQB0OBdiFyfL+fWibqJKvM1xc4NjRBST2lw6BuY=;
 b=jFeCIXpnHcibSgQgUdsUCee/lQNrFAm7CZvA5+jFwp00GpTSRSoeWcDRyE/V3jybWVsvc3vOaesnTm5qphkpIKWb2Y9nTsEanzNzh8mw1yJZsiuI6OtQIuJdlMqMKqT1ccGOMUITeL0rzJoB1kBvHafyIx01T0RXvQSdBgu9SFrPp2ZFvOUHlp/w/SmkMETVLqllrYWjZdIUHNcwJ38mcEVMQOJ7KLr5JJgkVGYriaQ3KCVIc7oNbpfY5WUU0uOp9J/zNgupFZ0nkrdPBKIj40lmsWUVCpOdxM2putTy1zQd667e58efdgdVgBQDKJJwEVQ5WtUQHhCcDhWPIaMAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzGDpQB0OBdiFyfL+fWibqJKvM1xc4NjRBST2lw6BuY=;
 b=CkI1lkbvXSFMUa2mv7VA4f/kAvMHHrHEVcW6toKJ8+d9VP2lUudixBJUjdIWMU8Ek2ZxgvHJmcB4m/qrCAOsnGMbW7pjgsW6km36k1BGxChdNzfGz+U+4UQMHCi0PVW3KHrq41eC1+F2erQEfIq+ArBif1dtVBMtbx/PR+gzYqg=
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Tue, 21 Dec
 2021 07:11:16 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::3de3:eaba:ee6:c061]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::3de3:eaba:ee6:c061%4]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:11:15 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH V2] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Thread-Topic: [PATCH V2] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Thread-Index: AQHX9XOY2vhBXwUjOkG1u1Jz5IYELaw7NWuAgAD83eA=
Date:   Tue, 21 Dec 2021 07:11:15 +0000
Message-ID: <AM6PR04MB5623CF67F7F7404852F6ABAAF37C9@AM6PR04MB5623.eurprd04.prod.outlook.com>
References: <20211220073130.1429723-1-xiaoning.wang@nxp.com>
 <20211220105555.zwq22vip7onafrck@pengutronix.de>
In-Reply-To: <20211220105555.zwq22vip7onafrck@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ddf8eff-a556-49df-2422-08d9c4511416
x-ms-traffictypediagnostic: AS8PR04MB8136:EE_
x-microsoft-antispam-prvs: <AS8PR04MB81368D3F3C34A7D691FA10CCF37C9@AS8PR04MB8136.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DKpVs5uEFRt4SCgO//9kMZ/kQlzsvXHfYmmcRp9AVWzLF7859Onopqxh3RlgxhAmi0hp/wEXp0QFFo/YR2dOFwPZgImx82XVwKfqY7Lag59PVNitaNjY3p/mMruJeIS/n8ZS8Di6ckdPpPFebpvbSAX3O9rq029xbODZK6Xf/hCzuXJ7BGOylOUxubSgZpiiUWVBTKQ7GCTxo91gAmPfJ8CvMExF0tm2fBIY1gaf9o8KAOe2Fo2Q3Xt+74oXt8pY/gFVG9EQ5vjnYl2vnv3fz68rOaksW38RZXxF/8ZhZH4YRXy4K0AUfuZCUBqZbtHZNY77kRiHyti4R84FxpCCWRXW6UDO9R+83WzKfXIiVNstI5Awn2BgHITvEuU0OSRaPAB67Hc6a0T6fhJ1IpPglWvm81LR7oL9hiF0sUtWk1lBGQ7ruMqrwlXeJW33bDHWX4FFwKcfXI577iHm97RdzJpUKCgn7I0y6UH/zduSV4A2dG1VRtB+nyHUbAX5KCeXgEYbrSxA+zm9oVkjbHkDBLD0d0RjnBUxC2yysKrQkUaxbI3bqbSsjEY6kUa4k0au8fSYBNwmI5gqb+tHA33fkqSXZYZgb2PFtJ1143YrKdk2hjzM/d1Di5qIC5i/Y0KMxs1qG0BSWk6+e6QESpJIF1OhFGMjDMcXjJkfl6kFJVYOGeo6Dn0eHv8s65QDR7RFWBkeFCDDXnLa1Ni3kPdmfN9oishbcYl9bzpf3xhMfFXdUSi/DybRHTlCeOLtu6y5T3QKCD308RPbpbSXgcwRSdb9FeSN/y68gpWah2IxU1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(38070700005)(55016003)(38100700002)(26005)(54906003)(7416002)(66574015)(186003)(966005)(8936002)(2906002)(508600001)(33656002)(66476007)(6916009)(64756008)(8676002)(30864003)(66556008)(66446008)(52536014)(53546011)(99936003)(6506007)(122000001)(4326008)(83380400001)(5660300002)(86362001)(71200400001)(7696005)(66946007)(76116006)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmVxbmtCUWl3b0Q5aVZBOXY5OWVxeHpmb0xWSjlTR0xJNkk5V0xLd0h1aVhL?=
 =?utf-8?B?S3l3eU9IUFpoUEZzVitodFVxSEJwTHhXV2ppdWpObmpZQnJFQ2pvUzJkNnY1?=
 =?utf-8?B?aXpIaUVQMjl3SWx0Tm00MzN0VmxueEswczJTa1ZaTWl5bVhPT1AvYU9mcWVM?=
 =?utf-8?B?MFRjbUZ1SHlQRzkwYjgxbWd2Uk5zWWFoWHRNODM4UXJZOUV3RmwzZlJDbm5v?=
 =?utf-8?B?NXA1MFoxWUE0RmdzZFBwTFg0bysxR0p4TkxjY0xIY3VZcVVZUG1iSTdIMG5w?=
 =?utf-8?B?dHRWdm8ya0NISWZxTDZyelQ0TGsxV2M0QmZiSnVIdFdKZlZZcDRUd1U3bjd4?=
 =?utf-8?B?L3hUM28xZU9jZWZHZ1NUK3pVcEFtRUNZMGl4ZWRLdzNyS1VEM3ZldjhPYTBL?=
 =?utf-8?B?RkdGOWQyQVo5SXQ3a2VxVGxaL1JPRkxXSGNPRXBncTNZaExxY1RRUGtia3Zm?=
 =?utf-8?B?OUh3OWVydVVwdFM3TkVhS0FzOG9sRmNpdUc1TVVQdVR3WG1qUFZLd2NpNlVN?=
 =?utf-8?B?U1praVZ2SkZUSGk4NXZ2VTVqdUpuUWlmVVdPaWpVWGhGeXlKM1I5a09hRXEv?=
 =?utf-8?B?QnJWb0NTakU3cURFai9Kb1Raa21SRm9FNjBRK0JFTkNNaThmaC96Y1UwWEJI?=
 =?utf-8?B?aXg1RWlJSzJ1YU9uSk5KZ1VpU25oM1M2VWpybWpZY0lhMmtDa3A0aDJLUk1M?=
 =?utf-8?B?Sm1zMzNzZEI4aGRNSWNlZEVEL2cvd2orZTU0TUVEZ1ZjajJZTGYyM05pQ3lr?=
 =?utf-8?B?YUlmN2hJKy9lU1V5RlpFTlBhc2RHbGdhYUgzSG9jL0pNT3FZeGJwVUx1REpO?=
 =?utf-8?B?T0tPOXNNSWE2NHNEMXNPYkxlRzJQd3l4YVA2TUduL1dXeUdNVzNSTXFqbGp2?=
 =?utf-8?B?b3NRWDI5YmZxZlZhY3hzZXR5UzI2bFFOVFpwRlNkMklsRTgybGFDdndlUm13?=
 =?utf-8?B?LzJVSmlPQTB2ckR3ajBUdis4WnpSRk5sd3p0aTUvYzVkY1RSb1VFVkJyZzll?=
 =?utf-8?B?TW04S0ltUjNyZUJ0d0tZd0VtL2hCSHh2UE5zc0czN2VVd3duRURwVnhEc1lZ?=
 =?utf-8?B?eXIvZ202ZUE4QXl6WEIzUzRHdVFHcXpsNlRONXZGcVQrSklIU0k2ODNXVUZG?=
 =?utf-8?B?Nk9PbVRLU3FEV1hlM3NQWjNnaHQvdWZvV1AvSHd1TFNmUTk5c3hQQ00xRzZJ?=
 =?utf-8?B?RnBKZ0NYZkRGN3BDMTNaSUpLSVR5aGFJT0dsbnVpdGRDOWFOaGZhN3RVZUFt?=
 =?utf-8?B?ZGZVdGR1c3Aya3VCalBjRURMRkVMaXRCalV2YzF5TXpwaUNQaEVBT21rUStB?=
 =?utf-8?B?eUJOMW44bE1STld3OXd0YnlBbXU3b21pUDk0ZjByMUZHZm1hVmJHUVVPNUdB?=
 =?utf-8?B?NnR5YmNxZGVlNHZ3SUNXQ1M0T044Si84VFQwNFFWbVJVeTROTFhXT01LUDJh?=
 =?utf-8?B?d2lYQUFwWlQrMmUzZkwweStadmw1dUl0SS9zVCtFRHczNm40aU5GMW16VnVo?=
 =?utf-8?B?Q3I1ZlVnVG52N3ZlYWgra3VEQTJXcTVleGFoL1g3RkJrbzU2L2FWWTNrQm9v?=
 =?utf-8?B?VXcxYTFwd2YzWkVJUEpVMDlQM0JKUFZFZVhXejU1RGVFMjdCanlVY0hSQ2hJ?=
 =?utf-8?B?alBuNkZPc2xjTU9GbHI0R0N0SWJGYmlEZjF6c1ZRdXZXVWFoekVMTDE5SXVH?=
 =?utf-8?B?TlZrblVvNVFPODFhc3RUcW5IZ0xQOHJISWVIZWJic1I4bWhZY2oyWnE4aDZQ?=
 =?utf-8?B?NWFtc0JyK2NjVHNLV2VXVmRPYUlOOXNHUHp1S3FaTjZ3eDVSeCtIT3dLUUMw?=
 =?utf-8?B?QlhHcnV2QjdvaFdvdjJpNlU4NDhqNGtDaFJzanFnWkFST1hLNEJnWkNtN2M4?=
 =?utf-8?B?V2tScFVzQjBtdDh2RnVUOVhXNEhGRjVoVXJoZkVhZkVDWFVmTUlxRkN5aWho?=
 =?utf-8?B?TkpPbmZFRUJRUE96R055akdMa2FCcWVkS1JPTGUxL3AySVJsUC9NS0t3dlhh?=
 =?utf-8?B?aTNoNkRhNFVlanB1bURjbTlBUjQreEpJWlRMdEFvSFFzNXp6VU84L0Z0cEdD?=
 =?utf-8?B?VDlQMEI4VnV2UVViYkgxRXdGL0l5TncyUi9FMW5PK1d1WWxQTFBpZm80ZnJV?=
 =?utf-8?B?WjRoTGpkSi8wOHNYZ1h6MnF1UXAydnZJZ3lPTkRPZ1NvTzlDTU1hV2ZkWFNR?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_00D7_01D7F67C.FCB49670"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddf8eff-a556-49df-2422-08d9c4511416
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 07:11:15.7088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIUVN1AF+YBs/AMHjVXwbIkAsAvMV2fbC93xjWyMDX0HrJHIxLtKvDVYBJudFl7GjtZbHguBAkRamxnIUiqbVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_00D7_01D7F67C.FCB49670
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

Thank you very much for your detailed review!
Please find my comment below.

Best Regards,
Clark Wang

> -----Original Message-----
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Sent: Monday, December 20, 2021 18:56
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: thierry.reding@gmail.com; lee.jones@linaro.org; linux-
> pwm@vger.kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de; =
linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> kernel@pengutronix.de; festevam@gmail.com; linux-arm-
> kernel@lists.infradead.org; Jun Li <jun.li@nxp.com>
> Subject: Re: [PATCH V2] pwm: imx27: workaround of the pwm output bug =
when
> decrease the duty cycle
>=20
> Hello,
>=20
> [added Jun Li who reviewed the patch to Cc:]
>=20
> On Mon, Dec 20, 2021 at 03:31:30PM +0800, Clark Wang wrote:
> > This is a limited workaround for the PWM IP issue.
> >
> > Root cause:
> > When the SAR FIFO is empty, the new write value will be directly =
applied
> > to SAR even the current period is not over.
>=20
>=20
> > If the new SAR value is less than the old one, and the counter is
> > greater than the new SAR value, the current period will not filp the
> > level. This will result in a pulse with a duty cycle of 100%.
>=20
> I read the i.MX25 PWM chapter a few times now, and I played around a
> bit. I could confirm the issue.

[Clark] Yes, this issue is on all platforms which uses this PWM IP.

>=20
> > Workaround:
> > Add an old value SAR write before updating the new duty cycle to =
SAR.
> > This will keep the new value is always in a not empty fifo, and can =
be wait
> > to update after a period finished.
> >
> > Limitation:
> > This workaround can only solve this issue when the PWM period is =
longer than
> > 2us(or <500KHz).
> >
> > Reviewed-by: Jun Li <jun.li@nxp.com>
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > ---
> > V2:
> >  Fix the warnings when built in riscv-gcc, which is reported by =
kernel test robot
> <lkp@intel.com>
> > ---
> >  drivers/pwm/pwm-imx27.c | 67
> ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 62 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index ea91a2f81a9f..3d9ca60e2baa 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -21,11 +21,13 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pwm.h>
> >  #include <linux/slab.h>
> > +#include <linux/spinlock.h>
> >
> >  #define MX3_PWMCR			0x00    /* PWM Control Register */
> >  #define MX3_PWMSR			0x04    /* PWM Status Register */
> >  #define MX3_PWMSAR			0x0C    /* PWM Sample
> Register */
> >  #define MX3_PWMPR			0x10    /* PWM Period Register */
> > +#define MX3_PWMCNR			0x14    /* PWM Counter
> Register */
> >
> >  #define MX3_PWMCR_FWM			GENMASK(27, 26)
> >  #define MX3_PWMCR_STOPEN		BIT(25)
> > @@ -91,6 +93,7 @@ struct pwm_imx27_chip {
> >  	 * value to return in that case.
> >  	 */
> >  	unsigned int duty_cycle;
> > +	spinlock_t lock;
> >  };
> >
> >  #define to_pwm_imx27_chip(chip)	container_of(chip, struct
> pwm_imx27_chip, chip)
> > @@ -201,10 +204,10 @@ static void pwm_imx27_wait_fifo_slot(struct
> pwm_chip *chip,
> >
> >  	sr =3D readl(imx->mmio_base + MX3_PWMSR);
> >  	fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
> > -	if (fifoav =3D=3D MX3_PWMSR_FIFOAV_4WORDS) {
> > +	if (fifoav >=3D MX3_PWMSR_FIFOAV_3WORDS) {
> >  		period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm),
> >  					 NSEC_PER_MSEC);
> > -		msleep(period_ms);
> > +		msleep(period_ms * (fifoav - 2));
>=20
> This changes semantic, from "wait for at least one free FIFO slot" to
> "wait for at least two FIFO slots". Maybe a comment would be good? At
> least the comment above the caller of pwm_imx27_wait_fifo_slot() needs
> adaption.

[Clark] OK, I will add a comment here.
The reason for waiting for at least two empty FIFO slots here is to =
ensure as much as possible that the SAR will not fail because the FIFO =
is full when writing to the SAR twice.

>=20
> Also I wonder: If there is only a single free slot, there is no =
problem,
> is there?

[Clark] In most cases, this situation is fine. As long as the FIFO is =
not empty when the SAR is updated, this problem will not be triggered.

>=20
> >  		sr =3D readl(imx->mmio_base + MX3_PWMSR);
> >  		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr))
>=20
> The error test is wrong then. If fifoav was initially 4 and waiting =
only
> reduced it to 3, you don't trigger a warning.

[Clark] Yes, Thanks. I will change it to " if =
(FIELD_GET(MX3_PWMSR_FIFOAV, sr) < MX3_PWMSR_FIFOAV_3WORDS)"

>
> On a side note: pwm_get_period() might return a value that is too big.
> This could be improved using readl_poll_timeout.

[Clark] Yes, this is a good idea! I can change to use readl_poll_timeout =
to wait fifoav < 3.

>=20
> > @@ -215,13 +218,15 @@ static void pwm_imx27_wait_fifo_slot(struct
> pwm_chip *chip,
> >  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> >  			   const struct pwm_state *state)
> >  {
> > -	unsigned long period_cycles, duty_cycles, prescale;
> > +	unsigned long period_cycles, duty_cycles, prescale, counter_check,
> flags;
> >  	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
> > +	void __iomem *reg_sar =3D imx->mmio_base + MX3_PWMSAR;
> > +	__force u32 sar_last, sar_current;
> >  	struct pwm_state cstate;
> >  	unsigned long long c;
> >  	unsigned long long clkrate;
> >  	int ret;
> > -	u32 cr;
> > +	u32 cr, timeout =3D 1000;
> >
> >  	pwm_get_state(pwm, &cstate);
> >
> > @@ -262,7 +267,57 @@ static int pwm_imx27_apply(struct pwm_chip =
*chip,
> struct pwm_device *pwm,
> >  		pwm_imx27_sw_reset(chip);
> >  	}
> >
> > -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +	/*
> > +	 * This is a limited workaround. When the SAR FIFO is empty, the =
new
> > +	 * write value will be directly applied to SAR even the current =
period
> > +	 * is not over.
>=20
> 	When the SAR FIFO is empty, a new SAR value will be applied directly
> 	instead of waiting for the current period to complete.
>=20
> is grammatically better (at least with my German sense for English
> grammar) and might be better to understand.

[Clark] OK. My description may be a bit verbose.

>=20
> > +	 * If the new SAR value is less than the old one, and the counter =
is
> > +	 * greater than the new SAR value, the current period will not =
filp
>=20
> s/filp/flip/
>=20
> > +	 * the level. This will result in a pulse with a duty cycle of =
100%.
> > +	 * So, writing the current value of the SAR to SAR here before =
updating
> > +	 * the new SAR value can avoid this issue.
>=20
> This can be expressed a bit easier (and more correct) I think:
>=20
> 	If the SAR value is decreased over the counter value, there is
> 	no compare event in the current period resulting in a 100%
> 	period.
>=20
> (This is more correct because decreasing the SAR from 200 to 100 if =
the
> counter is already at 300 doesn't result in the problem.)

[Clark] Thank you for your detailed comments, I will revise it in the =
next edition.

>=20
> > +	 * Add a spin lock and turn off the interrupt to ensure that the
>=20
> The usual term is "turn off interrupts" because not only the PWM irq =
is
> disabled, but all are. I wonder if just disabling irqs serves the same
> purpose.

[Clark] Our purpose here is to turn off all interrupts. I will modify =
the description here.

>=20
> > +	 * real-time performance can be guaranteed as much as possible =
when
>=20
> Disabling interrupts is never good for real-time performance.
>=20
> Having said that I think I'd go for a solution without irq disabling.


[Clark]
The two necessary conditions that cause this problem are:
a) SAR FIFO is empty
b) New SAR<CNR<Old SAR

Code in the following "if (duty_cycles <imx->duty_cycle) {}" is to =
prevent the problem from recurring even if SAR is written twice in the =
following situations:
1. The pwm period is set at will. Our logic is to directly update the =
new SAR value when the FIFO is not empty to avoid this issue. But if =
after we read FIFO =3D=3D 1, the time to the end of the current cycle is =
less than the time used by writing to the SAR twice, the second updated =
SAR value is still equivalent to being written in the empty FIFO. This =
may cause this issue again.
2. The PWM period is extremely small (such as 2us). When the FIFO itself =
is empty, if the total time of two SAR writes cannot be guaranteed to be =
within 2us, then the second updated SAR value is still equivalent to =
being written in the empty FIFO. Because the first updated SAR value is =
updated to the on-going SAR register, the SAR FIFO is empty again when =
write the second SAR value.
So in order to avoid the above two situations, we must ensure that:
a) The total time for writing two SARs is as small as possible.
b) The two SAR writes need to be completed within one PWM cycle.

I did an experiment:
On imx8mp, set the PWM period to 50us.
When spin_lock_irqsave() is not added, a 100% high level period can =
still be observed with a high probability even write SAR twice.
After spin_lock_irqsave() is added, there is a very small probability =
that a 100% high level period will appear. (This avoids the second =
situation described above.)
At the same time, add counter_check to ensure that the end of the =
current period is greater than 1.5us. Then quickly write the SAR twice. =
Period greater than 2us can no longer reproduce this problem. (This =
avoids the first situation described above.)

From the experimental results, adding spin_lock_irqsave() can =
effectively guarantee the code running time during the period.
If you have a better way, we can discuss. :)
[Clark]


>=20
> > +	 * operating the following operations.
> > +	 *
> > +	 * 1. Add a threshold of 1.5us. If the time T between the read =
current
> > +	 * count value CNR and the end of the cycle is less than 1.5us, =
wait
> > +	 * for T to be longer than 1.5us before updating the SAR register.
> > +	 * This is to avoid the situation that when the first SAR is =
written,
> > +	 * the current cycle just ends and the SAR FIFO that just be =
written
> > +	 * is emptied again.
> > +	 *
> > +	 * 2. Use __raw_writel() to minimize the interval between two =
writes to
> > +	 * the SAR register to increase the fastest pwm frequency =
supported.
> > +	 *
> > +	 * When the PWM period is longer than 2us(or <500KHz), this
> workaround
> > +	 * can solve this problem.
> > +	 */
> > +	if (duty_cycles < imx->duty_cycle) {
> > +		c =3D clkrate * 1500;
> > +		do_div(c, NSEC_PER_SEC);
> > +		counter_check =3D c;
>=20
> This needs to account for PWMCR.PRESCALER.

[Clark] Yes, will fix it.

>=20
> > +		sar_last =3D (__force u32) cpu_to_le32(imx->duty_cycle);
> > +		sar_current =3D (__force u32) cpu_to_le32(duty_cycles);
>=20
> If endianess conversion is necessary, please apply it to the complete
> driver in a separate patch. Doing this only in one place and skipping
> several others is just irritating.

[Clark] Sorry. But the endianess conversion here is the step before the =
value is actually written into the register in marco writel_relaxed().
#define writel_relaxed(v,c)	__raw_writel((__force u32) cpu_to_le32(v),c)

The purpose of doing the endianess conversion here in advance is to =
ensure that the writing INTERVAL of the next two SAR updates is as short =
as possible.
	__raw_writel(sar_last, reg_sar);
	=E2=86=91 The INTERVAL between these two lines. =E2=86=93
	__raw_writel(sar_current, reg_sar);
[Clark]

>=20
> > +		spin_lock_irqsave(&imx->lock, flags);
> > +		if (state->period >=3D 2000) {
>=20
> This checks the new period value that doesn't have to do anything with
> the hardware state yet. So this check isn't sensible, is it?

[Clark] No, this check is useful.
Because we add counter_check to ensure that the end of the current =
period is greater than 1.5us. This workaround can only fix situations =
when the period is set greater than 1.5us.
If the PWM period set by user is shorter than 1.5us, then the 1.5us =
counter_check will never be true. This is why this check is added.
A 1.5us period cannot satisfy that the counter_check is greater than =
1.5us, so the minimum cycle for solving(to workaround) this problem is =
extended to 2us.

Because this problem does not happened 100%, and a full-height period in =
such a short cycle will not cause much impact, in this case, the time to =
the end of the current period(counter_check) will not be checked. The =
SAR will be written twice directly.
[Clark]

>=20
> > +			while ((period_cycles -
> > +				readl_relaxed(imx->mmio_base +
> MX3_PWMCNR))
> > +				< counter_check) {
>=20
> period_cycles is the new overflow value.  If the current overflow =
value
> is lower, the loop might terminate immediately. If however the current
> overflow value is higher than period_cycles, the subtraction might
> overflow resulting in the check to be true. In both cases there isn't
> any relation to the next overflow event.

[Clark] Using signed numbers here may solve the problem you raised. =
Thanks.

>=20
> > +				if (!--timeout)
> > +					break;
>=20
> On a fast machine with a long period this might end in a timeout =
before
> the rollover.

[Clark]
No.=20
If it is a long period, as long as the absolute time from the end of the =
current period is greater than 1.5us. The while loop above will finish. =
Will not cause a timeout.=20
If the time from the end of the current period is less than 1.5us, after =
waiting for 1.5us, it will enter the next new long period, which must =
meet counter_check > 1.5us, and will also finish the while loop.
[Clark]

>=20
> > +			};
> > +		}
> > +		if (!(MX3_PWMSR_FIFOAV &
> > +		      readl_relaxed(imx->mmio_base + MX3_PWMSR)))
> > +			__raw_writel(sar_last, reg_sar);
>=20
> Why not use FIELD_GET for consistency here?

[Clark] In order to ensure that the interval between two SAR writes is =
as short as possible. This allows this workaround to support shorter PWM =
period.

>=20
> > +		__raw_writel(sar_current, reg_sar);
> > +		spin_unlock_irqrestore(&imx->lock, flags);
> > +	} else
> > +		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>=20
> This violates the coding style. If one branch of an if needs braces, =
all
> branches should use them.

[Clark] Thanks, will fix it.

>=20
> > +
> >  	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>=20
> Changing the period value resets the counter. So to minimize the =
effect
> of the mitigation (i.e. a busy loop for up to 1.5=C2=B5s with irqs =
off) I
> suggest to do the wait and write SAR twice only if period doesn't =
change
> and SAR is actually decreased over the current counter value.

[Clark] Okay, will add this check.

>=20
> >  	/*
> > @@ -323,6 +378,8 @@ static int pwm_imx27_probe(struct =
platform_device
> *pdev)
> >  		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
> >  				     "failed to get peripheral clock\n");
> >
> > +	spin_lock_init(&imx->lock);
> > +	imx->duty_cycle =3D 0;
>=20
> duty_cycle is already 0 here, so there is no need to initialize it.

[Clark] Oh, yes. It is a kzalloc above. Will remove it.

Best Regards,
Clark Wang

>=20
> >  	imx->chip.ops =3D &pwm_imx27_ops;
> >  	imx->chip.dev =3D &pdev->dev;
> >  	imx->chip.npwm =3D 1;
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> Industrial Linux Solutions                 | =
https://www.pengutronix.de/ |

------=_NextPart_000_00D7_01D7F67C.FCB49670
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIgajCCBU0w
ggM1oAMCAQICCBLkWWZl3+DFMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0xNjA0MDgwOTE1MDRaFw0yNDA0MDgwOTE1MDRaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjga4wgaswHQYDVR0OBBYEFFiVYO5OdO9lIqq97RmpK3qOF50H
MBIGA1UdEwEB/wQIMAYBAf8CAQAwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL253dy5wa2kubnhw
LmNvbS9jcmwvTlhQSW50ZXJuYWxQb2xpY3lDQUcyLmNybDAfBgNVHSMEGDAWgBR54UkB4HvONDkp
QxkyZWE8BthVqzAOBgNVHQ8BAf8EBAMCAQYwDQYJKoZIhvcNAQELBQADggIBAAbOUfjWTDj+hByL
1uNjWcpi78tBzOvltka5EfKCj8uuv1WQVfvugF0RsqzpgfWMwj/EnTVHHrM++avuUtapouyqkq7z
8xBFpWa9nsg8vvmyHPCHoQdBqFaIHjCM/Gr6jVB1boBWaQTMr8FEG7DHlhObshlm3zF26il5NjAS
GhwryzJjD6/oHyKiw1BSxHvhpPc01e5nemXPX3C0pY3tcD1LYurGDWvGHVTH1BIMoOkmTa1EXcov
P3WwfSvEQBnM4Zcu8TIrSb+xu4GutPXM6R9G0vrgyJLUcA3LqThr4uZ5hANjLCCzmMRiOLPKbHfO
UCS+JLaduhVv0Bff2AXY2cOcTdIFYgwUeARrgxyCTjxoLNY96XRGzpdEZhUW3/rwjrZbIBMUvyc8
yONci+Ye1Hd+FRIVwDyRnHOz/KSwvgdIXcLlN/bKJ4ew0xVYW9Y0mGYWgsmHpQYZ5MynGhnmwxtd
GMbPyPehlBS2dLbhAAKYoL+eaoUOqnjildk2wD6gFg125oDysOAqLxyK3VY9kB5Z8Vjh30Lk5B5u
O7oxk3/hG8oEdn4qz61lRl7N8TDhBNHcKAm+ls5BBqZUsONASebHhP8yLkS9pKXMe5bjudLk1XVv
cSsm/iIRJYkdbeTXipBu4gjMQ/OCl+QqFqydDvRe9CQdzPqUhr8PgxxgysQJMIIFrDCCA5SgAwIB
AgIITn4GzGWRAEgwDQYJKoZIhvcNAQELBQAwWjEXMBUGA1UEAwwOTlhQIFJPT1QgQ0EgRzIxCzAJ
BgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMQswCQYDVQQG
EwJOTDAeFw0xNjAxMjkxMjQwMjNaFw0zNjAxMjQxMjQwMjNaMFoxFzAVBgNVBAMMDk5YUCBST09U
IENBIEcyMQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjELMAkGA1UEBhMCTkwwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCj7P72jqfzYGq/
J6jwexnlOfZGxRwwxYu9TlvW8pM1dQAjhXRixRBEhMH5APbZg+rYqbqLQMjI91HU1ueKw2kNCZUT
buyu125GkHyW9mA44Nf/eGGN5NZFnbY8AgjnuAi8qpkIxRa9hF1hmxIo/7hD6USSzz3Kz3ne2nc8
jwR5TO1PepRN+ztNuAPkD2z7XMI+ojtv9eZdOuRYGbCaaoMcGKPAi/PLm4TcxMG6dVkUCXaQP+OI
GB2P7g7i7n3c3LVz1zgh/pe/Pf4MQiN29tQutTIYhq3Al2/DoXFG3nOeZgp7dXLOxjtmT/wyw5m/
OhI8ExJkFZIeP97x8HAMQMp/pdDQEPtnbsBZNRx12TWymGffwcc7ASmMp87E0Zft9JerPYlpG2Vq
a9KgKt3jOsfl/3iFxJUVw/2cX2bcmpHMCZsZhN3OACMqM9FVYCBpkYXxv+VorkCLyAISLvrsO7My
xeS+P38FDDx/KfnE5jnnNGYWjaNTz9uVbL+OwDBR4QEOjgo9EC49tKI63wl/w1sM68MY8rAQLx17
vpLE+Le6WG4VvRDPGxuTf34RPcjHLfjswBlOOL9rzsZ4gNaL6cJYfBk9BISDR7QtWHu5E01vVyVY
gsQX9tIx7fNPetYpYObMKJOff4+Jyq9gztxaJmLeyuUKQgB5qJq/20xoBndcbwIDAQABo3YwdDAd
BgNVHQ4EFgQUkEhTIyp56oSbPT65DuiZdEBeoLYwDwYDVR0TAQH/BAUwAwEB/zARBgNVHSAECjAI
MAYGBFUdIAAwHwYDVR0jBBgwFoAUkEhTIyp56oSbPT65DuiZdEBeoLYwDgYDVR0PAQH/BAQDAgEG
MA0GCSqGSIb3DQEBCwUAA4ICAQCEgqJeyVvGvlbUtkMyrE930h6kWRDQMk/z8I2bk6rIGB8l4okp
kyI8E3HH9QX2bogCom03L3y3UY8ean+KQnaOapWpPQg1S3v0os/sdWvf+3ZKkgltbOnHxlA8b5Al
XiLWRLA1+TeBQMoLeFHv6s4P6JI7nXrczLP8LPOM3X6zJZFV6eluLM+h/yIT1yRmcP1XTn8gvzxq
VIcg2i1ur6jS1s2GgId0S7u797sx1UhPV4e3x+5vkzXRGHODmn+sS7OvUCqIQ4AZhxW8kOesjyZj
cxzXxEtJwGJUen8aqR/dIWJa+L/+iQshAYy6zUbQJU2qvCsr/ok8H3TvUXNmOjlLWOJXn9Q2HMvK
RKeBxoTf7T/MqIA/a+SKZ8cdDvZImThAjQo69EHUYZ4XpStdE7CTo09gQWLHBN1XMcnaE6aonHlJ
FcTK2003XYFPzBA6VilSZelpp38SPa+dWxLmcdxhtGfYC+b8OCawAn/Qik1oweIDNdmbYKkLRzxI
aLiZZhUDs9rH4+cZcFtn3C0rG9GuRWmI0am5cMJZm9cSTHXXzH4DVKog2ifwNLm1uuR8/ZMt6nvD
NmATpoU3ZDHJd0eziTuBCVOobTgt/uijawdJs7mQBtTjgpjDl8G0ukbunGXJXl+v6iQvvRrlJZhM
8+yhyEOrJod4BaCHH9rj74VGNDCCBfwwggPkoAMCAQICCDWXO7CfYZ/wMA0GCSqGSIb3DQEBCwUA
MFoxFzAVBgNVBAMMDk5YUCBST09UIENBIEcyMQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIu
Vi4xEjAQBgNVBAcMCUVpbmRob3ZlbjELMAkGA1UEBhMCTkwwHhcNMTYwMzE4MTA1MjE2WhcNMjYw
MzE4MTA1MjE2WjBlMSIwIAYDVQQDDBlOWFAgSW50ZXJuYWwgUG9saWN5IENBIEcyMQswCQYDVQQL
DAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjELMAkGA1UEBhMCTkww
ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCly7+CWLCDR2fV3flTSlksy/Bs0Y3VZb/X
mmrMFykb9kGrmr7KCrj/OQSpAAzdxmxKLZTa2OIpk4R+PhyzIQlVkVCLBcym2yYSt+TsEygu1og3
v28U53VvN2NbQdpJNv0aQnsJNxvvP8UoqLBzaPndVU0NHXFUGdQ0RoHUDNA6SnqGC6kKCeWTD1f7
/b6LtQKKmTYlYuymD2ysVofS/CuAwXER+zjXLqIFUPvRH/j6y6hq1e+AW/eW0ZnfH+FqTc3WEeSM
mrehrWNKQuanoqhACptwdOR4qiYw6Y9QkrVioOSl1sa65GRhTci8Jbk5mCV2uSKBw5Now1Rp5lQC
/w/dNO2o3iMin8eWz/bpVH4Kp2gC2bPKkETK84UO3Oo+pXMVd+RSXYdnQkZNgRdQR+cjSxQkLIul
ws7UOOfASnwD656iVgiksBK6kbMYwZnkjk67VGgXZu56wSDBv5ZXsdE0BdOZ7NSHetYubh8ChTC/
WXKwgI58YYlDZWQ17k5fM5u/OOXfQVh0NZvoX7EgPIbQDDF+3hxdlykU4ZHcUfhlnk4f5Q2XUjGc
3BWkZKqbMRTvGehNeXJUfdD+NgMbbsdKggtCn/JEwldbH9efntlVc2brditnflexf3WkwcNGhB0k
EwqTJrzXd2CCaESzNIgFgqqiIW3Udowr8qc/BJIs7wIDAQABo4G6MIG3MB0GA1UdDgQWBBR54UkB
4HvONDkpQxkyZWE8BthVqzASBgNVHRMBAf8ECDAGAQH/AgEBMBQGA1UdIAEB/wQKMAgwBgYEVR0g
ADA7BgNVHR8ENDAyMDCgLqAshipodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBSb290Q0FH
Mi5jcmwwHwYDVR0jBBgwFoAUkEhTIyp56oSbPT65DuiZdEBeoLYwDgYDVR0PAQH/BAQDAgEGMA0G
CSqGSIb3DQEBCwUAA4ICAQCHr83XcZ67rjIJvbUQ7xgQWbwycWuQiRADywkqB1mxAhG6Pt4rNpup
D/t3BtH/oAyz+gxGLEBLP2qLH0kMvGhTj4cCyKkW6EkUxlP9U1OGYqaU0s8wv3SnyhbD3BrSNHo4
Bp+FGCb8gLHMGQdtmP9A3wZdQ89tyu+Jjfb6ddDYyZD1XFaVYCs08dDJxrN+xuPv+vmfP80kqDvT
uLTteabsJTnx8BbO+5WjzjaOJcg2o6Ts6rfL3QvtpIdmulELWTif6C/50eZbnyaHGTwiZtpR/oYl
kA0M2u5/ALz/ayS+ar09JRc7lq0aV3r8IIbYSPW+Wygmg7m/cSUMJFMyPWExW/IqbIv16Ju16EbP
aQMzUsRbrYJiwv9nuV6okhAGutdtw0pIQ7PCktcooAagK4EUaPuwYfKlmQamaF8geLXz440WmCJs
LGVtiARAMlFlf5zNuM+PvSzKOedLQJem0IX0UhZaag0HLUw3ChhVfMxAzBUeAq9KxWayGnPA0AZZ
Dmxw6ExfVqNWuPMrhIFJL7aMGuegO+NXV8K5LI/ZmnRk2hzZhSGbpCg/dAp5vlu380ZL52bsXeJk
Q0cP3H5FZ6EZTVnFOnRCCKsbJRmwMMl+G3sCQsCG3Fi0JbevpuYbDO5ubjrd9id6XAMe29d8UtyF
gqXgRA4jgZsZIOdIpNUJ0TCCB3AwggZYoAMCAQICEy0ABoTITdZnifGx+kMAAAAGhMgwDQYJKoZI
hvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREw
DwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFi
YW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPy
LGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MTYxNDA2MDdaFw0yMzA5MTYxNDA2MDdaMIGa
MRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYwFAYDVQQLEw1NYW5hZ2VkIFVzZXJz
MRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGY0Nzc0OTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBANHznadIsUJtpig7vPEcH1aNEgGmH3AFgnuWGvUjN6VvOZY+ZYkTM3CC
N3L0yelllOl+Gcay7YvpGqO9nqcN5gL1N03J1TB3HNr/5TWrSCaqMOv1QSPkEUeREPiZZsBSFzsO
nwfd6IlRvlIA1V2cUWp0Fjo36STU5kK3rL2pRc8d/gNvi7mnDZYeDWqjKMLZZ0sNtLARpTqTSb/3
lXpcBqpZTk3ZWnScPl8R++TLJGthPj9yFaYnupmDY+nNNIUcZ6r3LbJkIei6h/pwhHmtSf3Wmubu
wg17J4Re/kcTvbMPIZW0UjWhv308SVAnKXqdGwwkEuu9J/b/VunbGBkxH5UCAwEAAaOCA48wggOL
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/g5/dGoWovkUC
AWQCATgwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMA4GA1UdDwEB/wQEAwIHgDAMBgNV
HRMBAf8EAjAAMCcGCSsGAQQBgjcVCgQaMBgwCgYIKwYBBQUHAwQwCgYIKwYBBQUHAwIwRwYDVR0R
BEAwPqAlBgorBgEEAYI3FAIDoBcMFXhpYW9uaW5nLndhbmdAbnhwLmNvbYEVeGlhb25pbmcud2Fu
Z0BueHAuY29tMB0GA1UdDgQWBBRYxKNzhWscqOC/ud0suG/yUi2BVzAfBgNVHSMEGDAWgBRYlWDu
TnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9D
Tj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVi
bGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13Ymks
REM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9
Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVy
cHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1
LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUy
MEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZp
Y2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKG
M2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAaAn9Br249iKLJWD1XvLv6LVJiLQLoGrzrog42q7O41yO8tewHH1MWSK2
cvCNid57zecjcG+ksMx5rx3aAZRdK46Klrp+Y35itqtUFX7SM61aHzgiMYkMTKdOh7vsdC1ozd20
dXQnfdFCE/nmL+/gwIsrgm4hqnhzyj4jeTzRcbrT8gNpka1S0EMOWIttQVhZjKgZgjfIri/llOLJ
BxZUOElMwqEf+TV/LbGpA/blSauh6r/TAGchvSCD7qtFXKDflfJ7cDij4eT9quxeeLV0mGE+d/XR
VT1w3LMz5Vxn/dDtc1sjqK8rndId+NDDlMAHKzojM/H3a+vnA5wA03hBzTCCB/EwggbZoAMCAQIC
Ey0ABoTHjbOh79nLVYgAAAAGhMcwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRl
cnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWlu
ZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYK
CZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5
MTYxNDA2MDRaFw0yMzA5MTYxNDA2MDRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZIm
iZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsT
AkNOMRYwFAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQD
EwhueGY0Nzc0OTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALhoe3FOWuzjjD9/K7Be
hpleCj2HEEYOHvkig4BebN0q801BKR09cWoStnTcBMtURWBBiSdTEnAkepBOREeldNcBCLWoFWXE
271/zZqSpYr6prYJsS6TPn3GYj06or5cPHt9A987zY4RoUKYiBiIrtCGYHaAOVtejfjGR5d4dSH8
xkKNLXMEfz6Nr6B4hVTxtdLncf0W/AfrMBgbmiD/YvWXHq6nZBznOIw6VuJ/mDPjtc3gecdskmGN
InTYgQehgqw12qfu1h+0EaOE4rU2jWKVk6QHJts92i757sIJArrzk5CVlVYPOj12+B9sZu0nxNb1
6JSI2uWF9THy1RAUxo0CAwEAAaOCBBAwggQMMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWC
wH6BjvRVhu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYD
VR0PAQH/BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCB
lAYJKoZIhvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEW
MAsGCWCGSAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsO
AwIHMA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwRwYDVR0RBEAwPqAlBgorBgEEAYI3
FAIDoBcMFXhpYW9uaW5nLndhbmdAbnhwLmNvbYEVeGlhb25pbmcud2FuZ0BueHAuY29tMB0GA1Ud
DgQWBBQBLQ/yyAeGQGy0zSw+kMMOxSYRATAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhed
BzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnBy
aXNlJTIwQ0ElMjA1LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9j
ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9u
UG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9o
dHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUF
BwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBD
QSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVj
dENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtp
Lm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0BAQsFAAOCAQEA
JEOJykBxc+lhmC5z9DAhC8WJ1yEGprdYbO0uNzpUhcnE5QytV15hgVmB8QirF5pm9FURW/ce+bce
a63Pqm9CSxI1I2aACoZI8xU/4CKdfB0ZsK1aLy2wbtikwMTH4wSNa85rLA1cWOEILE5hni1lW1jx
Y3GvJrPxT0iJu3r248wV424Es/r92N0GusWhAX3AFks+PuviIkOMJYvZGGUOon4/m5OJ+7GMwSV9
Ghb0FSSOsKYyBSY7ffW5MMT2RWZRbInh7bUuBGrjtPXTj7l5ssX4JIdErFFSneBIt30a0hyGKONn
jhVdOb9TE/+Vz846lfML199KYpVvJUj12sreUjGCBLMwggSvAgEBMIHOMIG2MRwwGgYDVQQDDBNO
WFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNV
BAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3di
aTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwC
Ey0ABoTITdZnifGx+kMAAAAGhMgwCQYFKw4DAhoFAKCCArkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjExMjIxMDcxMTEwWjAjBgkqhkiG9w0BCQQxFgQUTvcS/Cg+
C3F9gsLdG1ClYOEO8pYwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsG
AQQBgjcQBDGB0TCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwC
SVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3Jk
LUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJ
kiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhMtAAaEx42zoe/Zy1WIAAAABoTHMIHhBgsqhkiG
9w0BCRACCzGB0aCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwC
SVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3Jk
LUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJ
kiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhMtAAaEx42zoe/Zy1WIAAAABoTHMA0GCSqGSIb3
DQEBAQUABIIBAIRj0G4O1kdcSXbVWMkQIXHHJMKUD4km3nHY4xCuXkZRFPMAA99TccjGAeO2YCnr
JdLbDSP5zb5akMUjQWWrUrTOaCJ6vUGOeeSBGMfqsUDy0fTgbOUi9iqus7U25ejuMwig7e36wcPG
RtGRfl8EIGKXrsELmFMxz9QUaWdV1C3GBPyPER/xSHjWQ5ShPpFd+agimFsd2C+XMiXm7fc+XQMU
mHvfK5lMTU1/KrkXyj8z/bEAAuVeFtzeU9/c3/NMcEhYPUTAw3MjOg5LE0+wwO7vbSQSsPZ7c6xE
O4xCw8DaLX/O9j0Dji1+podtzxFElI7BLlSE4GaDyYJRmOjNvzUAAAAAAAA=

------=_NextPart_000_00D7_01D7F67C.FCB49670--
