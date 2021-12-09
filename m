Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4629F46E3B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhLIIIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:08:49 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:2011
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229436AbhLIIIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:08:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHJbCBr8GNFK8SvEKfXh/JdpwkvyVgZvf8bmjUveIN4hW1oA/xOmHDow+v+Ki+r1kw8jALwhnUyR08skceHj9c+q3B+ZXf8q4sfhPO9WQVSuaJXfDpxYJ9VxW6xf/5u9ZRm9+mKRFUBZAnDjpX+NMfVayv1O/X9MjwJMaP8XnJjKsPRCjt0Y5GgB6NW0mmJ+2GGyvBmV6RRiaT9FlxQhegtCcl4w9eJKaZIUPqFcUk7lxuYvSw3v+/Po+QKhy6TH6GcEzHtgtzfN0ZzEOf3a79e9Uouio9jLsi+hiANWWxSOXx8xL2quNv+sQYeEgR6tOOWD3pbag8fd2eFglrycag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROtPOPqHWmHhXUx63GNP+yhmZpAxf6yGGtpRvmfbCME=;
 b=Cwn+uACsGSPP7pbfMvXRifxdiHZaxj/6Z1B55Nx+isqhs99Eo50wTKPTLyHDUIaBMzzrxcQAwaVBEGv4/QIg+AsrYTlZjrWcCMjzRDYkKtKJVvR9stnr4d7tUKlJfSuAQok0QSTzCI+YcmDf7VP1aT6ucEExbOa3YMldYWZRzzmAC05k35kqteC/Qgk508K6EQusZee4PCwkbVwLtBweFB8dpyM8tgpXp2ByZF1DBANVsBMpoh2cKAeXYgpQMOC8nSioODUK6eIsDOfyjSaXgHT9fKs8LeYOPsBcJ1fNAXE3m5YkHbdVu09Cj+RX9gNf2zMypIIq4gdyPjsIplMPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROtPOPqHWmHhXUx63GNP+yhmZpAxf6yGGtpRvmfbCME=;
 b=HhDmlNSHtn2osok1LB34TR8JyXankjtJi3xP/xdRCcmGmYYp5HL5kbgfHFdSqEfhnXEuezGGdhWOXQspQxzT4tztZrVCIJn66Yo+2JbOqzNYSx93jrsMWHtMGMP/iwJI/iOkcZxraFLdzp6+RTDsic/JKMKxqqLLVhhaMkOgjJYs4k8Ieb/7McIq0QsKEatBGF2jNVBIeix5w+lKx/J3Fzany+jNnybs2j1tmtxM9cKQ8a7tZmol2EomrWLfH4EpmaDS11c3q8P1ni42ToPMhYsmNvF8wu5z5ozGHoAMfZ7CeI63r3K0/pE5pNilcidSj7QUPxcKKP8xJUsok1f6yg==
Received: from AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:125::20)
 by AM0PR10MB2772.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:132::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 08:05:10 +0000
Received: from AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::745d:c075:23e6:c72c]) by AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::745d:c075:23e6:c72c%7]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 08:05:10 +0000
From:   "Zeh, Werner" <werner.zeh@siemens.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date and
 time
Thread-Topic: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date and
 time
Thread-Index: AQHXYQ31AXoAwWTUBE6ivSpoWZHRXqsi3/mAgAbU2gCAAnnIUIADp2wAgPsOCCA=
Date:   Thu, 9 Dec 2021 08:05:10 +0000
Message-ID: <AM0PR10MB258011D56CF0A2E3BC0449F99F709@AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM>
References: <20210614110946.15587-1-werner.zeh@siemens.com>
 <20210624081507.15602-1-werner.zeh@siemens.com> <YNn6FqAfLwQ/Wwnu@piout.net>
 <AM0PR10MB2580E68ADF9D1AC6804DB2DF9F019@AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM>
 <YN8ebqVR0JYTurDY@piout.net>
In-Reply-To: <YN8ebqVR0JYTurDY@piout.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 550beee6-4088-4bd4-e08f-08d9baea9f39
x-ms-traffictypediagnostic: AM0PR10MB2772:EE_
x-microsoft-antispam-prvs: <AM0PR10MB2772B3094D99D4DCD475BBAA9F709@AM0PR10MB2772.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVQ2EgZEFBbpgHDKcTpeHTX1H87Vr5UQoqSOYXt6mJ5dp97VVloZRXGxniu7oz7KPnFJBtMgXgKugqlYK2C80eLe6c6XRMDdqm0LHUqfpc2PQ+PSjFIFQzh8vNPLM37qv40O3f/sBILMQWbwipqpPwiWu2gscSIiDTEKrhRCTlgGnR8fZa+a5sh+3Ps8Pvm3T+oDSbkX8Y/PB3OZ08h2oXa3dzLX92Z4VQVIthM1AGIjjYg8BKm9/RCiV174yaHzCdVZKo+NhEwI038Y0NbDKcMhjVGk8J7AXFNI5eMJOBxJvu5uXa2UxX42G2HouDN4z86E9QmEEcdQhs/lbqovGTkXtYDSCpEL93t6Kq/SgUO3FJdflihDE4izcCKkxDWp1Ze6p1fXGswsIQRxnslqaRZhRtjHFu1xY1ihu5w24m1PErM1qmgAe5X+aeAPwrZoqboQGD5fGMJDcWFiP3rHRUYORNxnRKlqfsE810r8X5nw4bM3ftX+rsKZ8waaS6UDaM/B+gPz06nCxV7CyHxJmhleleEejOvNmn4Td8wqvB3hvxYnf3w1mFoOKlcvPo5jVMIdiNbpggC6qS1+gVSFT+WpieNoneKIJ1awJGiMNFK4mflX/drHhMD644rXaONuB2zgyQzWIMcL/DueI/DN2DLXUYDStjCnq+TbNal4Kswx5G7r/NnFuA6eNHObn2EaV69SC1C6pabW019vs9KH3Dknv1hY3viRm9NiK5kLlvJglXGr4UOGxCZxZe5vbsqIbys5wpnHXZzXtWK7ZkCukalB+AvX/2EEdVdlE6wAlg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(54906003)(8936002)(316002)(2906002)(9686003)(55016003)(38100700002)(7696005)(508600001)(6916009)(5660300002)(38070700005)(53546011)(6506007)(966005)(71200400001)(26005)(186003)(8676002)(82960400001)(83380400001)(86362001)(33656002)(66946007)(76116006)(52536014)(66476007)(66556008)(66446008)(64756008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v+C06ga95HNJhc7bwYYMdjDuZ8Qvo1M7AWJ+uJfaiJPokGwaDqLIL8Gai/1x?=
 =?us-ascii?Q?6qHgDf0fcUvo16dUr6BB8bLzG4DJnkTJscMVwel1BR0eWSw0JHq6XlnkWDpQ?=
 =?us-ascii?Q?mfBUddYKbT8tMO0FtcJlZgGeLPkoVuw9mxVyV3hxeVC3F89Oe7Qxb9phSYX5?=
 =?us-ascii?Q?D4GzZlvx61mulO2asmFm93Yrph/Dw7DqDjR8GwGbn55CNs5s8svhlX8FcjWk?=
 =?us-ascii?Q?RbjUTclGjrHgBj3XgH919RQKLHV2n0OThFUJojvvXb9dnhZuFPvf+IaSFfcX?=
 =?us-ascii?Q?hB/9WC/qBjx7zJlVPeMA0EjnsS65A6JDZvWX+9S0FfMqgzfaBxDwEzr+LXG8?=
 =?us-ascii?Q?m2gbKMPrxKfSukfB5yAbEPF/Bgd9b32GYZAebGaQIoRfK8y1LZkNq79CSDZX?=
 =?us-ascii?Q?S/MbJLO+gWgK7UjOBMOvd79X+cWZJM4CvSc+g+S+hc6L5QZ29CvRTsZdjRRY?=
 =?us-ascii?Q?lwZO8FFFZNMGjb6QF6D2BzXOHLYrjFo6ErdzSK6VGsrGYsYOBXoefP9Hm4Cm?=
 =?us-ascii?Q?swiSegpQEtNOXUGxZGywBWjZX9u2jtAWyq49P3ea/rZ3u9wwn3tyS15BqdNq?=
 =?us-ascii?Q?K5+GicYjjOBgk7Owb6uhI8pfGlGNUHM5ZqF3gEAdFDBZPk5Wrg1HbbA4MqS+?=
 =?us-ascii?Q?bKhlvp6S7XAU1aTjFquj80g41RqcdI0hgJln0FDrExOXQlXhMV1zSvD3FBmL?=
 =?us-ascii?Q?LcIS3QUIbkU4H376Pefz7Jdn/PuEdR9BP4egxr9w818fjPoafotyw7IpBuq2?=
 =?us-ascii?Q?HAP+LGZ24qK7FBGM5he/pij+f7NJHy0n3P5XFsve/W6NFuUm2fcGDLY7ZZib?=
 =?us-ascii?Q?KrggoGH8r1B7GKyv+piyYIl/pNVJcjSDLH0HzxSFU0W/EYDJNwWyVJtd/3SX?=
 =?us-ascii?Q?5vzO+ojKAWBWD/FWIl9Gae8JF8yoUVmlDzYnzX34N3R0ooOU66D7pzWQPPv7?=
 =?us-ascii?Q?aHNM4d5CTB63fzpo1tVILRc/RJMenIvGiDrKzF0DKwnb1DUMYMcfg1dZVPhg?=
 =?us-ascii?Q?kpRY/0MTi22JkjseIySUnaoEYB/G5QVflIZVIR+dmkpzEFDxHWq6oj8I5i6x?=
 =?us-ascii?Q?ZRwLQN+ODEU9q7iy5EHrAFc5boefnfX+T423um0qoSzd1YcsKZeuOsC85tTs?=
 =?us-ascii?Q?iujuIWD2sW88HyeiAGEt70QosGKr+G8M4R4O5S8Cep4/hlGuVwrsoPYIg6t3?=
 =?us-ascii?Q?33BMeKxzeuQus5uguWwS1IxE+nEu3ZQFdf9kHyV/cAhgl5+H81LGDE6n7dGO?=
 =?us-ascii?Q?MEccMLn0d6S2g+zW8w2XYiFf1bylx3j3rOLVYNTwH/Dne8swIGiAn/eYSTqq?=
 =?us-ascii?Q?se4nR5Np029qgmh4IMxTa8zyaT44aoWlqxV6wW9HYIwccbxhA0LPSOjPFZQ0?=
 =?us-ascii?Q?gxA4zsmVpLApcVT+a/FFjLkjLJlYs6NuMsIpeoXuSap+aJqqmxI0BWIW3LLc?=
 =?us-ascii?Q?R8EDbdMAi11/DEh1U1xsbSLHwsD1QNwa0So8AntOFcdDdaYuxWAnwUWukejI?=
 =?us-ascii?Q?/VjBhUk8ikDrPX+XdZU+57VrwzrjDM310NC4+YUyGhKEblr8jDW9WaAIrm1D?=
 =?us-ascii?Q?YkGu00Er4/B/KqFk2MmQBxVs4cWNAu17BO/A9PZN75VelTOHWaUsdxuDI9MZ?=
 =?us-ascii?Q?+87xYqfH5iYlZ/WKG0qLeMY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 550beee6-4088-4bd4-e08f-08d9baea9f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 08:05:10.5230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YUwMkH+yl8+GE8sr/Vz5geuG/b3w74ft2yjo082PDbD5jDy8vWAc8EOxexpMi27igXrfMHxToZrPC8ZqPwUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2772
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre.

Is there anything more I can do for that patch in order to get some process=
 on it?
Or why is this patch stuck for a long time?

Thanks
Werner

> -----Original Message-----
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Sent: Friday, July 2, 2021 4:11 PM
> To: Zeh, Werner (DI MC MTS SP HW 1) <werner.zeh@siemens.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; x86@kernel.org;
> a.zummo@towertech.it; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date an=
d
> time
>
> On 30/06/2021 06:25:44+0000, Zeh, Werner wrote:
> > Hi Alexandre
> >
> > > Hello,
> > >
> > > On 24/06/2021 10:15:07+0200, Werner Zeh wrote:
> > > > The timekeeper is synchronized with the CMOS RTC when it is
> initialized.
> > > > If the RTC buffering is bad (not buffered at all, empty battery)
> > > > the RTC registers can contain random data. In order to avoid date
> > > > and time being completely rubbish check the sanity of the
> > > > registers before calling mktime64. If the values are not valid,
> > > > set tv_sec to 0 so that at least the starting time is valid.
> > > >
> > > > Signed-off-by: Werner Zeh <werner.zeh@siemens.com>
> > > > ---
> > > > [resent due to wrong lkml address] [added RTC maintainers to the
> > > > recipients] This change introduces the same validity check that is
> > > > already done in drivers/rtc/interface.c.
> > > > If it is not done here, the timekeeper can be set up wrongly in
> > > > the first run and won't be corrected once the RTC driver is
> > > > started because the validity check in the RTC driver drops the
> > > > time and date due to invalid entries.
> > > >
> > > >  arch/x86/kernel/rtc.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c index
> > > > 586f718b8e95..f4af7b18c6c0 100644
> > > > --- a/arch/x86/kernel/rtc.c
> > > > +++ b/arch/x86/kernel/rtc.c
> > > > @@ -9,6 +9,7 @@
> > > >  #include <linux/export.h>
> > > >  #include <linux/pnp.h>
> > > >  #include <linux/of.h>
> > > > +#include <linux/rtc.h>
> > > >
> > > >  #include <asm/vsyscall.h>
> > > >  #include <asm/x86_init.h>
> > > > @@ -64,6 +65,7 @@ void mach_get_cmos_time(struct timespec64
> *now)
> > > {
> > > >         unsigned int status, year, mon, day, hour, min, sec, centur=
y =3D 0;
> > > >         unsigned long flags;
> > > > +       struct rtc_time tm =3D {0};
> > > >
> > > >         /*
> > > >          * If pm_trace abused the RTC as storage, set the timespec =
to 0,
> > > > @@
> > > > -118,7 +120,15 @@ void mach_get_cmos_time(struct timespec64
> *now)
> > > >         } else
> > > >                 year +=3D CMOS_YEARS_OFFS;
> > > >
> > > > -       now->tv_sec =3D mktime64(year, mon, day, hour, min, sec);
> > > > +       tm.tm_sec =3D sec;
> > > > +       tm.tm_min =3D min;
> > > > +       tm.tm_hour =3D hour;
> > > > +       tm.tm_mday =3D day;
> > > > +       tm.tm_mon =3D mon;
> > > > +       tm.tm_year =3D year;
> > > > +       now->tv_sec =3D 0;
> > > > +       if (rtc_valid_tm(&tm) =3D=3D 0)
> > >
> > > Doesn't that make the x86 architecture depend on CONFIG_RTC_LIB?
> > >
> > CONFIG_RTC_LIB is already default enabled for x86, see arch/x86/Kconfig=
.
> > Do you have any other dependencies in mind I have overseen?
> >
>
> Nope, everything is fine, it would be better if we could get rid of
> mach_get_cmos_time but I don't have any clue as to why this is necessary.
>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin Embedded Linux and Kernel
> engineering
> https://bootlin.com/

