Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F32A468AE1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 13:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhLEM5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 07:57:24 -0500
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:61838
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233841AbhLEM5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 07:57:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGmfIR1sTX55NzZ+q4nfinHwzO+1DKRn20Y0SLOSbCb8KrCyWcjmxL75ocxAlndX3cnpuYyBkBqtZGu6CNT7lE1xn/2rDUGdRw5BjqmRFgRMRGc8lfZfPVyl/5JxFqZEAYQfCg+h8qU89LhQuDZzOkaiPBdQMzP7occ79l+VVJMfoi+fJDOZkXNCp47kwH/wGhgNcQy1xvY+3SJnK+4Cxb0XttTpgCZ3oD8R5U8P/Kx1MY+FemUW9avYuhQPMV/GigJjns6o/LHQ2XSLdkahNvKVfaiMoTGF3eJLaedami1tJQ6IYD5wrOTpqs2xBn5pqJDBOBovjN/Ec8VHrnxShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVNInEztrfBN/ar17m/k2oKDAQ/A2xA7R+miuZJ8zMw=;
 b=HCC7/f3w2Yphyyp4Yl1Bl3a7L3/2o1zX5WvE4GSxidHCBV6V/Y0Zv92a5R8UNQMDzHmwWLpcpWtjhSuG7t9OT+lSqKzR3BTDDvJJ0tPbhS9rMn5cDNB7dlucUG2EEBHvynj7d3cRFLADsDJg0lyAUkbFcT58Mv7C0g+p0dxno8sCeLFAww1E5nnOSU7WthWTh+ZbKjET7HSM4EYvmlNvicfaDzlTlNKs0XJTKkom/+7ulDb837LW7VZehR3TRN45Xcx6Wt7DxMUxTcFLbhmH3235Gt3cidBh/uax88zQUvzGSlSMbnneuvohWe7MECtJ+eEMgx27YSNu02XQvQBEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVNInEztrfBN/ar17m/k2oKDAQ/A2xA7R+miuZJ8zMw=;
 b=Nv+7KQwmy4wTs96w46RZbWqtA8HbvFZlv9l9BXjkd6oLXVcGknUM6GTEO+OVc1O017wKqIKETDww6MTFsnE2Lc3CU9yv6XX+szwZ/QhI3wIFPKj7rSfvVcjIKlWnEuaDwB0nHrI39N/rwSS5OO1e46fuC79UGXHB74JiwW6FbBI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Sun, 5 Dec
 2021 12:53:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%8]) with mapi id 15.20.4713.027; Sun, 5 Dec 2021
 12:53:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 2/2] clocksource: timer-imx-sysctr: set cpumask to
 cpu_possible_mask
Thread-Topic: [PATCH 2/2] clocksource: timer-imx-sysctr: set cpumask to
 cpu_possible_mask
Thread-Index: AQHX5rIpXvvERj8j10espZggT53Quawe/42AgATgKoA=
Date:   Sun, 5 Dec 2021 12:53:51 +0000
Message-ID: <DU0PR04MB9417992CCF80CAA4CF78F8EF886C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
 <20211201125030.2307746-2-peng.fan@oss.nxp.com>
 <80578aa9-35dd-02ca-fb07-5895991572e2@linaro.org>
In-Reply-To: <80578aa9-35dd-02ca-fb07-5895991572e2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab90afc9-ab76-466d-70fc-08d9b7ee4980
x-ms-traffictypediagnostic: DU2PR04MB9050:
x-microsoft-antispam-prvs: <DU2PR04MB905083C57E6ECBDDBA11F591886C9@DU2PR04MB9050.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XpQfxmKavIOzHRqGfoUqxNRGZqUw520uTZpwTwNkimXZDiH7x0q5n2aqENxwqQBR36/zDCuJo2p4TJgdxL9BIAVgsE7Z6yR61VhJwVDybaV/NMy21aA0qUn+cIB/NiC0ZxjWTUh7bjNyQIRzLxAKlyzwFEZ9AWEGR5l0r+vFwbA875ajCe0Y28alonX//2Xq1CvcuP7c/QbwRywM7aLopjbtjn9uV/TmvukD4kh0sduSFWvJvjzp082EKMQi0gD0MxMRgWL+kyJf4aYuDjdwbqmoVIN0Zs9NtnAtpMo+nd+Ql2kgy2X7rTh3V4PbFiy9f9WFcC28Tub1AOd6l4+zCm8hdQw1IC34itfjZxhID0wV0Tnz5L7N6HPlqTQs8N81BK0SmnVJdSTa5nk1KnLYBUx377Gu4PizL4zTyu62yLKECcPX/puBw6H2+RuYX5hyMr6HEz5SEqoKMaU7N2WYFM43laSUpFD1cpMnVzfIe/4nUGiFG4o67eVXPjALhqzPHJw9EEZE4e20i89EZdAt1E4HVsdy7bC12w6EC9ylpMfg/M06Ffjv/Gsn8xoJbWbtsKYbm0ga94FMIdRgdGAKc7BxyaXg4phNdiBo9neOw9CpFRdRzy0Xx782+wn23MSPz2UwPBx9z1YvoH9OvSjl59mKcz2ol7CLVZgVs9Bo0hpcQEB46v0o8RPZSHZuFNc7RvFvUNU7oKt5ccobT2hbdOi1F3owHZvRW7Ev1UIeeBAXSIrYMxZ5xSWoI7mXtuWarWrxHkraF98uxPaN3bI9S934bpWpykx3facAyDsyWlo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(86362001)(8936002)(316002)(4326008)(122000001)(38100700002)(110136005)(9686003)(33656002)(2906002)(55016003)(8676002)(53546011)(6506007)(38070700005)(83380400001)(66476007)(66556008)(66946007)(66446008)(64756008)(76116006)(44832011)(7696005)(26005)(186003)(71200400001)(508600001)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?3em1+MK3+az9upTWSd4y7EOXhGaAnW1G8agB+ff2RpAQ/EgqFuEgrXa0qo9/i5?=
 =?koi8-r?Q?+aga69R6cDNbf6/dv4QGf4GLwJMwYP6dTRmB9+/uZIcrK/t8mGD84U8v8kdOgU?=
 =?koi8-r?Q?PLK8s7K+4TC/odkM8YH0+bzSoV8Nr1O1tmk7S0KPI3DYq6efSHVn5xOcP3DLld?=
 =?koi8-r?Q?XNAxicNxaZkZeGsLO2lYmKAxBtkf+0kTbFa/QHhYikIk70o+Q/0XkyfeP0SO+d?=
 =?koi8-r?Q?/yIDFHan+u1uN7vaQlkmOrTJev27O7eMpxJCNjx7l6OB9STK1DOD4SyBc+c3AF?=
 =?koi8-r?Q?o97jzEcjsz8BqLLuG9xJxTiR0hn14L8+iswP8TaoEl2xkPnrnaYPTxHaVdX+iA?=
 =?koi8-r?Q?fe+U+ifhoErdLfBnpamsJ6rPP5c7Gi6PyqSd1zQqP/uobXyM1bCt//g4M3O+aV?=
 =?koi8-r?Q?QDdmAhXstzVQ8kj7xVk82cn15oj9Cwafh2bzZ4OdvGFFGHawLOlkyXNgA1YARK?=
 =?koi8-r?Q?F4kwV0Mr2tIZSOhrJmg8bXGmckm/8Lc75Ey5OrdIu1LG1t56iWkhAOXCNYXres?=
 =?koi8-r?Q?dyI91nkPicdd/GePWvFvIHuj8t2FYnlNkBN5OaGz2ZDFdZSuFXF/+9Khdkw6on?=
 =?koi8-r?Q?p1zuKZ28PwtQceHiwi5iM9vlxo5f4MB0PR8gq50O8/gfBGSJnLm/eHWbhhkf37?=
 =?koi8-r?Q?wb05+8OnLqs+wwGVhAJPffZ93AYJuTkcwyvvKl8qERR7wepIhuVxk4n8vqoUiX?=
 =?koi8-r?Q?PXNnu7qaYmKu6MZFP/RDJlqFZ54aRJV5zJXh79KFatiY8mQG+cCd2P3rCSdswz?=
 =?koi8-r?Q?y8PlqGNPaQeacEXSzsLOZJ9aM3aS5YgHjr3aQmjWDWFUsFioCserjGJrsao9OL?=
 =?koi8-r?Q?Ww7OI6uLSFegoVFFwzYqPvT8zjTtEIwYIyJEfzI1JfThe+w4BeY8SAXjSXEtWY?=
 =?koi8-r?Q?aye+DVbS8Rz49lDk9o1hw3D4dij7ujogGsK+E+4szoQ2CId3CMpxym5p/W2a90?=
 =?koi8-r?Q?q4xHV5ih3FBaqpnXidNZdb8PCfwzfK70yVNrgsEiTXtxHlw7mXdgMAZE7+uX41?=
 =?koi8-r?Q?JdaiNKx/xIHamdCbteFO0hoYeTN0EqNhxkjpvX8UgRqidW6SYjaQY1vOGr+ZKO?=
 =?koi8-r?Q?FpO6fb6BrtIMbP+Eog7cI+9eAyZyT0BNwdcrpcC6NtRvFmxXA2WzH4u/zjPIW7?=
 =?koi8-r?Q?R907MrJildKJzQ7/kk8zfKA1c6zCMdvJZAMGRoEfMmj8C2jfr2l8TasMJ+v6sY?=
 =?koi8-r?Q?IBh+LeW7DWMOHOSgKrrkUsLUFz0faeOsUbUSZKGCtcL7r5ZY98NbC/hS31Q1Z5?=
 =?koi8-r?Q?SkGOLeecAvehTFtG9rIRlY/d/5THFejlgZdGGRpErFExNmVpTwIgSQnGU7/QHn?=
 =?koi8-r?Q?+akc27Dnokv9s4H5Cxb4UFcGZNv4HAWjyQzvhnl0HaHLx/akg7i91VU8vTXs4k?=
 =?koi8-r?Q?jVAcFfWGgx/pyMwEvXpK7sNpKpGJs+9v9Rn41AyxH0f0ygsPZKVc6v38NB+QVx?=
 =?koi8-r?Q?p5HDnVjYe8zCMO3S8HE34DukgvVo7BzCQEOxQ9r1EOOB3FcVK11Lpn5EnJv3bN?=
 =?koi8-r?Q?mfuuQ5fxx1pPoQ5VVA/jy6GCl4BShZB2kf2RxWJ1miDZF/lrn0c9/IOLpYTQSF?=
 =?koi8-r?Q?xlV4uECmBQ=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab90afc9-ab76-466d-70fc-08d9b7ee4980
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2021 12:53:51.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZHczrv5zU9A0vkx4Dyef94hzWaKx6G1/H1gAWXX/rMy7ZrY9SyrVJ5N7HIpQmzMVF3MgpOHeJtBolPLl3r6Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/2] clocksource: timer-imx-sysctr: set cpumask to
> cpu_possible_mask
>=20
> On 01/12/2021 13:50, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Actually we have CLOCK_EVT_FEAT_DYNIRQ, the irq affinity will be
> > runtime changed and no issue. But the system counter timer is not tied
> > to CPU0, so use cpu_possible_mask here.
>=20
> Did you mean:
>=20
> "There is no reason to tie the system counter timer to CPU0, change its
> affinity to cpu_possible_mask.
>=20
> Moreover, the timer has the flag CLOCK_EVT_FEAT_DYNIRQ set, changing to
> cpu_possibl_mask will reduce the number of wakeups related to the system
> timer"

The syctr interrupt could be set affinity to any cores in the SoC. Default =
affinity
is set to cpu 0.

This timer will be used as broadcast timer on all the i.MX SoCs. Because DY=
NIRQ
flag set, the core time framework will runtime set the interrupt affinity t=
o the cores
that needs to wake up and the cpumask will runtime set to the core that wil=
l be
wake up. So even the sysctr initialization use cpumask 0, there is no issue=
,
the current patch is just use cpu_possible_mask to show the fact that the
timer supports routed to all the cpu cores and nothing else.

Thanks,
Peng.

>=20
> ?
>=20
> Note you may want to explain why 'there is no reason'
>=20
>=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clocksource/timer-imx-sysctr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/timer-imx-sysctr.c
> > b/drivers/clocksource/timer-imx-sysctr.c
> > index 2b309af11266..55a8e198d2a1 100644
> > --- a/drivers/clocksource/timer-imx-sysctr.c
> > +++ b/drivers/clocksource/timer-imx-sysctr.c
> > @@ -119,7 +119,7 @@ static struct timer_of to_sysctr =3D {
> >
> >  static void __init sysctr_clockevent_init(void)  {
> > -	to_sysctr.clkevt.cpumask =3D cpumask_of(0);
> > +	to_sysctr.clkevt.cpumask =3D cpu_possible_mask;
> >
> >  	clockevents_config_and_register(&to_sysctr.clkevt,
> >  					timer_of_rate(&to_sysctr),
> >
>=20
>=20
> --
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.l
> inaro.org%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C1fec86efbd5
> 4498106c508d9b57d9e2a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C637740373391832133%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> amp;sdata=3Dq98PLDpC8h7jt%2BjvCeXZAf2F5ZzJsMMS613OSHmjDr0%3D&am
> p;reserved=3D0> Linaro.org =81 Open source software for ARM SoCs
>=20
> Follow Linaro:
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.f
> acebook.com%2Fpages%2FLinaro&amp;data=3D04%7C01%7Cpeng.fan%40nxp.
> com%7C1fec86efbd54498106c508d9b57d9e2a%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C637740373391832133%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000&amp;sdata=3DKmuInvkOIYTEcR4sFHhEbQSJczarvwwm8slI
> GfjCa70%3D&amp;reserved=3D0> Facebook |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Ftwitt=
er
> .com%2F%23!%2Flinaroorg&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%
> 7C1fec86efbd54498106c508d9b57d9e2a%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C637740373391832133%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3DmS9fXmEPB1798JRJWfhEpXcbdWfRiSb5%2FH6cz7
> 9rl8E%3D&amp;reserved=3D0> Twitter |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.l
> inaro.org%2Flinaro-blog%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%
> 7C1fec86efbd54498106c508d9b57d9e2a%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C637740373391832133%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3D%2BlsiYye7ZBW8jClBsZbSHkcbD0hqvvvx0H9SAlUV
> e7U%3D&amp;reserved=3D0> Blog
