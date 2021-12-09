Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF6846E51D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhLIJLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:11:23 -0500
Received: from mail-eopbgr20061.outbound.protection.outlook.com ([40.107.2.61]:49982
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229530AbhLIJLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:11:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enm6s+8yIr/awSVXVKafs+P1PjJcbpR2g0QyJU/dEPqlZUehGlogndD/iu7nuRiJJdB6KVwCmYd7D5eqMmfFWTbknEMGWWHGy9R0RUHEm1hgONQbu496SRnDzWNsfKCrgKKNgXt/BNZA+m0mzKsmieqWk54jq/x4m5HpnlgRWIgi0D3p28FeoRRiQ2ulPMK6jD8bC9mMsJkhnYgktzylveXyl9o0uboLrsSOiq04qpZlNtjbc5Lz5jL7z8ynio5ekCyKrqmke9o5wiFjuphxGDzuN36HtBngg/chG0MTCjMQ7UXdo5Wms6DjhSuZF8j9shFLtXaeBhmwbecvEyCcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp+MqqAwFQLrQwnwq1WrhenrYkwZfJhwJ5UkSKueJ7w=;
 b=fIuKJBcJf+fwEudXmOLFPSEpJLaGrZy0AZIldJVFq4/4BI1g1Q01NazmKdFBPIAz2gdwqb7/MOo3CmWt002ulP6qPt8ENlWWoVljnrRTBp32E4PHgOW/NQ58I1PcODgTzlvI9Ps2FDakLkKK2c9tE4vRgQj2iwSLCwyT/LZqfDDYiLl8kv4Ks25ocPZKSXa+DvlDBWM2+nhlgQC52P7XD/VRTR6fzbrguQNJhiBN2269jZOBZzijRV+qUAbqANJmuDDWfPskUZTbYrFhEI3DsK4BkCIjkrLG3JVgOXuRaYv7LqooI1YltrkjQe/aBMUwRAk9bLPwH1PJ8MYU3QrbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp+MqqAwFQLrQwnwq1WrhenrYkwZfJhwJ5UkSKueJ7w=;
 b=NXSRE3+GCB2tat6OI7gHplfFgLfh6qg7EvMs9D7i8DXIpFvOfeqeX1ah0y0B9Ppyq6V3FspSj8XJLAra4o2H1lMHsYUh06cs2CqJJddK8LYrmoUJ5LnL4SuwU/bxHCtL0Dm0lurr2yJ5ZsO0+shch/AFazTDQlMVNjTnjjT7cHikWwlqpxTkAtMw2iQbhDl5HFwOXCCYo3KB+yORF4MlVAVaKCJKxaHjnEdm1Dx3FhDJsjdIsNohj00x9KLYYj+bweFAcmSaNyZTx9hmuGJM2VeED6esWUVTnRfiVoo1ubbi+vFT+vIp7Ab+XoIxPpusC9Udh33qLtza2A69nbKNGg==
Received: from AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:125::20)
 by AM0PR10MB3585.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 09:07:47 +0000
Received: from AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::745d:c075:23e6:c72c]) by AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::745d:c075:23e6:c72c%7]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 09:07:46 +0000
From:   "Zeh, Werner" <werner.zeh@siemens.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date and
 time
Thread-Topic: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date and
 time
Thread-Index: AQHXYQ31AXoAwWTUBE6ivSpoWZHRXqsi3/mAgAbU2gCAAnnIUIADp2wAgPsOCCCAAA1qAIAAAwPQ
Date:   Thu, 9 Dec 2021 09:07:46 +0000
Message-ID: <AM0PR10MB2580E140E290888632566E3A9F709@AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM>
References: <20210614110946.15587-1-werner.zeh@siemens.com>
 <20210624081507.15602-1-werner.zeh@siemens.com> <YNn6FqAfLwQ/Wwnu@piout.net>
 <AM0PR10MB2580E68ADF9D1AC6804DB2DF9F019@AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM>
 <YN8ebqVR0JYTurDY@piout.net>
 <AM0PR10MB258011D56CF0A2E3BC0449F99F709@AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM>
 <YbHDSubjFrQXpfRk@piout.net>
In-Reply-To: <YbHDSubjFrQXpfRk@piout.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-12-09T09:07:44Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=b7a06052-0934-4361-9b9e-e2798125a138;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9b677ed-8dce-4019-81ed-08d9baf35df0
x-ms-traffictypediagnostic: AM0PR10MB3585:EE_
x-microsoft-antispam-prvs: <AM0PR10MB3585F1217A6AB1A9F436D59C9F709@AM0PR10MB3585.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7Yr+23OcEQdU2A82wNZFTSbYH3RUJVM3PmFvO9xOPOE5hwHlEjG0bOtQV9NGkI7w470HaJoogqhHsF89Af/F9KPupffrla7pw/Qx2W2ufpz23kbOkQSz7atMK0/8G2FB5AaPk+vfbrjWNs/PqwvpgYSrgOMgZGT9+e0kv+BTmCsxO0+G1IJSnaCEvz23FxYR2uIXJRtyBEZM7Tm+KkjV/69CsIwF5S79lSqF7i+6b6UGc+G3BNLGsKTwg1/i20bSDPOSr6cv7n/ITczeieK/24P9Z9NOLu/150Sex/VBEFoIp7lf2s7cRau9eNHDN/seSjRSm8WjyKIW0xdtQOOFY2osMjalO83dpyF69BxM0Z6ZJRjI7M2gtERQ4to9mRx+RPgRzF26w1eBiNxHRE2PAx1g+ZH3CvhQBPxee8TH8B1G8kp3EUB+2Nef5uOqXI60W0s6mVMN/YQ96WT1BjilJFZkB2Mo46sMPPpCurHKwaDF84TUtz0vpKkN/yrWMX52cGnb3gzu/YNJ+fP0577wzKb9Y+68/RzeD6pKRSYQcmXhoKcAAdl9Se1ZVqYz7QmnfXSJxaxrFW4+kS8Awf9xrnnu/4jl9rIAy4FYM+ae/Q1ZFqoUq2Q/tvAw4uqZqbEqsGDVDL+b4DAzpe8uuJMkcYiy82qrbROJcE+iroFsb/or5CC+RwBytWWk9a+ail/jd+yt60+CbhptB+EvK+E1PfAaE8txkGZj9ehHcC+gPjVVedEEsfrQCyClnVWJ2XGS57a6F3r35Wk82U5aZBCdPJm/ehYUx5Mzsh5lVR9DLQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6506007)(122000001)(55016003)(66446008)(66556008)(38070700005)(83380400001)(53546011)(66476007)(86362001)(64756008)(38100700002)(110136005)(7696005)(82960400001)(508600001)(9686003)(966005)(316002)(4326008)(66946007)(52536014)(8676002)(2906002)(186003)(26005)(76116006)(71200400001)(33656002)(54906003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ccFkcXNtvUt56Te9Nxrg9U5u5zc+e+TdxOQZyDW8JCr3BbfqiF+z11ScBexr?=
 =?us-ascii?Q?4BARCW/jbiDsziIUuxw8w7SvjuoCTqGF1v+haFDDWT48Mi7q5ALqaD6iQMFk?=
 =?us-ascii?Q?fr1EQVlalLT00lSuaq8AuZvklyIysfcFriDwSORXNcIx7hAcdW7+fOgnK/hy?=
 =?us-ascii?Q?sv75iIOq3yxXQMS7NXYHiR4T/yMJIMl1vd2gEFI60NeJzV2kL+RcZghVpjpU?=
 =?us-ascii?Q?WOJ7ogbhu83NuyBoiSKsBVPelBeeQgbjxYQ6WcQLptldEKykSWmxY303aQma?=
 =?us-ascii?Q?v1KhHeXmT+CuSOr7ZZ7tX5NwyBPgioGDyE6CnRgo9fd6yENzGgfFM15nMsh3?=
 =?us-ascii?Q?0OXXcKAh5XZuXjABIsjXDJ+wd1ecqwjwu7u7SImVkP75mwjzQvFNPpuC6fAU?=
 =?us-ascii?Q?KsLSrtifT/1RRIWkC9BqMAEimwoHc1mQIUqqxAQye0wFT8dBRKZhnA58BiH4?=
 =?us-ascii?Q?/yoCGWkeoyohU4Un8AwpeLw8OauN6n3Br/b+7GtOVlLuuhUYbioYOPhL/Vdk?=
 =?us-ascii?Q?yWsevH9H2EzW+CvHehkMkHOgy2BnVLC09ZRHbSJGrcXNn7InEXl5SgpSs0/V?=
 =?us-ascii?Q?jJtX3cPHV1V4xYgCEBcVUBlS+QFYGUPXX5voTs0lLlS/Q3sF3DNIlvZWuHyT?=
 =?us-ascii?Q?6siFYbcT5qrt/02B6fWPcUYGAKq8JQwuCZ6kj6joGPFa4EEEdpev5LrCli7a?=
 =?us-ascii?Q?A49YkKly0NpsSV2EyZqfksYvUHGyYGNaIZJ9wm0n7h7q1AzueCT6LO/R74Ft?=
 =?us-ascii?Q?Ga+KcQ37CRCe0iMgOIqvGCCzZ4q7Gkfkx4Ie8nHjssYlLG4XFTyWM/L1bdt1?=
 =?us-ascii?Q?0MGjzRGrQcxEwMPLknUdu29/KmA9xhgJ99lfLZlNLs/YNcuDrIZA/CLpa0d0?=
 =?us-ascii?Q?JcCdfo8HRuYHFB8PN3QCPt10H/FBEn928gyEYY4pCjFQb1eoS0iY7QKzjdcg?=
 =?us-ascii?Q?tEnrRLaR8UYgjUt9LewuCH3scUChLVd8h/U0AiAaQwYm+/ffSbqfMGN+NQ+7?=
 =?us-ascii?Q?9Ye8Kj95R8eVyLsyCo/K2smsnln9a2Fd6enPf/Sh9/gCEPEA5xup7xFHJ1Lc?=
 =?us-ascii?Q?2aZif+iFH3GmVPy1asc0V8RYK9XX53SPkozQtxpdhki7oZ2sOYEMOn4fyL1X?=
 =?us-ascii?Q?uUglnW6zNTztrvwAI/a2Xh+leBDjmE3oIUKcXNF/pt2rzQ5ic7UIFqc0MkIN?=
 =?us-ascii?Q?czbChWgsF7wpbZaD0GVC2sgoj1QU/tV5OoQDOTxxoU/C04Mwz4jOrSwmp4C4?=
 =?us-ascii?Q?3qkmaOIs/vy52yFnMQmpMw64489LJVOIAC9Jhy2hRH1+JakLjGfD3bo5MWBp?=
 =?us-ascii?Q?g48Y8ysQz7f3G49f27kAJ5po36V5TQu7erlM5RJb5XjPvaEZQjqnHYPkiAnB?=
 =?us-ascii?Q?tBG252IOdwppqTK8CAA6kJrd6rV7hlbWr3+jc8IynJh0SQbAKWT3WSP+Dybo?=
 =?us-ascii?Q?Xz8LvstQRw5vKRIdLWsnrXcFJqFkAdclFgoEMjnkUlgso0C0X9dFiS2abTFk?=
 =?us-ascii?Q?AxpyXutE6nkJIvJPbi4YrW/Zzj0eFx3CAOFogr2xhOZo9Al6uPuvo2G6touF?=
 =?us-ascii?Q?URbtpYRPcFswz+C/MN2VTGlJAT1L0ennu2LC+6XDff5OFBYKJV62PyciGMJF?=
 =?us-ascii?Q?3KvUIv8ABv55t1vHtqpLX8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b677ed-8dce-4019-81ed-08d9baf35df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 09:07:46.4518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXZOrtTzzKf0Jpre3tPfNMQDUaggHLeClHA1EOxAJy1kRxx2uakk2eR8Yxh2INpMuFljiBe2FoJmO+MJydBtzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3585
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not the maintainer for that part of the kernel, I expect this to go t=
hrough
> the x86 tree.

OK, understood. Thank you.
Any hint whom I can contact directly in this regard?
I had a hard time to debug this issue and it would be a pity if it will not=
 make it in possibly causing issues for other users.

Werner

> -----Original Message-----
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Sent: Thursday, December 9, 2021 9:50 AM
> To: Zeh, Werner (DI MC MTS SP HW 1) <werner.zeh@siemens.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; x86@kernel.org;
> a.zummo@towertech.it; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date an=
d
> time
>
> Hello,
>
> On 09/12/2021 08:05:10+0000, Zeh, Werner wrote:
> > Hi Alexandre.
> >
> > Is there anything more I can do for that patch in order to get some pro=
cess
> on it?
> > Or why is this patch stuck for a long time?
> >
>
> I'm not the maintainer for that part of the kernel, I expect this to go t=
hrough
> the x86 tree.
>
> > Thanks
> > Werner
> >
> > > -----Original Message-----
> > > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Sent: Friday, July 2, 2021 4:11 PM
> > > To: Zeh, Werner (DI MC MTS SP HW 1) <werner.zeh@siemens.com>
> > > Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> > > x86@kernel.org; a.zummo@towertech.it; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC
> > > date and time
> > >
> > > On 30/06/2021 06:25:44+0000, Zeh, Werner wrote:
> > > > Hi Alexandre
> > > >
> > > > > Hello,
> > > > >
> > > > > On 24/06/2021 10:15:07+0200, Werner Zeh wrote:
> > > > > > The timekeeper is synchronized with the CMOS RTC when it is
> > > initialized.
> > > > > > If the RTC buffering is bad (not buffered at all, empty
> > > > > > battery) the RTC registers can contain random data. In order
> > > > > > to avoid date and time being completely rubbish check the
> > > > > > sanity of the registers before calling mktime64. If the values
> > > > > > are not valid, set tv_sec to 0 so that at least the starting ti=
me is valid.
> > > > > >
> > > > > > Signed-off-by: Werner Zeh <werner.zeh@siemens.com>
> > > > > > ---
> > > > > > [resent due to wrong lkml address] [added RTC maintainers to
> > > > > > the recipients] This change introduces the same validity check
> > > > > > that is already done in drivers/rtc/interface.c.
> > > > > > If it is not done here, the timekeeper can be set up wrongly
> > > > > > in the first run and won't be corrected once the RTC driver is
> > > > > > started because the validity check in the RTC driver drops the
> > > > > > time and date due to invalid entries.
> > > > > >
> > > > > >  arch/x86/kernel/rtc.c | 12 +++++++++++-
> > > > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
> > > > > > index
> > > > > > 586f718b8e95..f4af7b18c6c0 100644
> > > > > > --- a/arch/x86/kernel/rtc.c
> > > > > > +++ b/arch/x86/kernel/rtc.c
> > > > > > @@ -9,6 +9,7 @@
> > > > > >  #include <linux/export.h>
> > > > > >  #include <linux/pnp.h>
> > > > > >  #include <linux/of.h>
> > > > > > +#include <linux/rtc.h>
> > > > > >
> > > > > >  #include <asm/vsyscall.h>
> > > > > >  #include <asm/x86_init.h>
> > > > > > @@ -64,6 +65,7 @@ void mach_get_cmos_time(struct timespec64
> > > *now)
> > > > > {
> > > > > >         unsigned int status, year, mon, day, hour, min, sec, ce=
ntury =3D 0;
> > > > > >         unsigned long flags;
> > > > > > +       struct rtc_time tm =3D {0};
> > > > > >
> > > > > >         /*
> > > > > >          * If pm_trace abused the RTC as storage, set the
> > > > > > timespec to 0, @@
> > > > > > -118,7 +120,15 @@ void mach_get_cmos_time(struct timespec64
> > > *now)
> > > > > >         } else
> > > > > >                 year +=3D CMOS_YEARS_OFFS;
> > > > > >
> > > > > > -       now->tv_sec =3D mktime64(year, mon, day, hour, min, sec=
);
> > > > > > +       tm.tm_sec =3D sec;
> > > > > > +       tm.tm_min =3D min;
> > > > > > +       tm.tm_hour =3D hour;
> > > > > > +       tm.tm_mday =3D day;
> > > > > > +       tm.tm_mon =3D mon;
> > > > > > +       tm.tm_year =3D year;
> > > > > > +       now->tv_sec =3D 0;
> > > > > > +       if (rtc_valid_tm(&tm) =3D=3D 0)
> > > > >
> > > > > Doesn't that make the x86 architecture depend on CONFIG_RTC_LIB?
> > > > >
> > > > CONFIG_RTC_LIB is already default enabled for x86, see
> arch/x86/Kconfig.
> > > > Do you have any other dependencies in mind I have overseen?
> > > >
> > >
> > > Nope, everything is fine, it would be better if we could get rid of
> > > mach_get_cmos_time but I don't have any clue as to why this is
> necessary.
> > >
> > >
> > > --
> > > Alexandre Belloni, co-owner and COO, Bootlin Embedded Linux and
> > > Kernel engineering
> > >
> https://bootlin.com
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin Embedded Linux and Kernel
> engineering
> https://bootlin.com
