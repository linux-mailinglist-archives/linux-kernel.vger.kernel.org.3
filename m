Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB74479694
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhLQVxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:53:23 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58241 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhLQVxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:53:21 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BBA1720004;
        Fri, 17 Dec 2021 21:53:17 +0000 (UTC)
Date:   Fri, 17 Dec 2021 22:53:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Zeh, Werner" <werner.zeh@siemens.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date and
 time
Message-ID: <Yb0Gzb3tdexY7utU@piout.net>
References: <20210614110946.15587-1-werner.zeh@siemens.com>
 <20210624081507.15602-1-werner.zeh@siemens.com>
 <YNn6FqAfLwQ/Wwnu@piout.net>
 <AM0PR10MB2580E68ADF9D1AC6804DB2DF9F019@AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM>
 <YN8ebqVR0JYTurDY@piout.net>
 <AM0PR10MB258011D56CF0A2E3BC0449F99F709@AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM>
 <YbHDSubjFrQXpfRk@piout.net>
 <AM0PR10MB2580E140E290888632566E3A9F709@AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR10MB2580E140E290888632566E3A9F709@AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 09:07:46+0000, Zeh, Werner wrote:
> > I'm not the maintainer for that part of the kernel, I expect this to go through
> > the x86 tree.
> 
> OK, understood. Thank you.
> Any hint whom I can contact directly in this regard?
> I had a hard time to debug this issue and it would be a pity if it will not make it in possibly causing issues for other users.
> 

Well, tglx and mingo are in copy of the thread. You can probably resend
with my:

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

to get their attention.

> Werner
> 
> > -----Original Message-----
> > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Sent: Thursday, December 9, 2021 9:50 AM
> > To: Zeh, Werner (DI MC MTS SP HW 1) <werner.zeh@siemens.com>
> > Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; x86@kernel.org;
> > a.zummo@towertech.it; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date and
> > time
> >
> > Hello,
> >
> > On 09/12/2021 08:05:10+0000, Zeh, Werner wrote:
> > > Hi Alexandre.
> > >
> > > Is there anything more I can do for that patch in order to get some process
> > on it?
> > > Or why is this patch stuck for a long time?
> > >
> >
> > I'm not the maintainer for that part of the kernel, I expect this to go through
> > the x86 tree.
> >
> > > Thanks
> > > Werner
> > >
> > > > -----Original Message-----
> > > > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Sent: Friday, July 2, 2021 4:11 PM
> > > > To: Zeh, Werner (DI MC MTS SP HW 1) <werner.zeh@siemens.com>
> > > > Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> > > > x86@kernel.org; a.zummo@towertech.it; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC
> > > > date and time
> > > >
> > > > On 30/06/2021 06:25:44+0000, Zeh, Werner wrote:
> > > > > Hi Alexandre
> > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On 24/06/2021 10:15:07+0200, Werner Zeh wrote:
> > > > > > > The timekeeper is synchronized with the CMOS RTC when it is
> > > > initialized.
> > > > > > > If the RTC buffering is bad (not buffered at all, empty
> > > > > > > battery) the RTC registers can contain random data. In order
> > > > > > > to avoid date and time being completely rubbish check the
> > > > > > > sanity of the registers before calling mktime64. If the values
> > > > > > > are not valid, set tv_sec to 0 so that at least the starting time is valid.
> > > > > > >
> > > > > > > Signed-off-by: Werner Zeh <werner.zeh@siemens.com>
> > > > > > > ---
> > > > > > > [resent due to wrong lkml address] [added RTC maintainers to
> > > > > > > the recipients] This change introduces the same validity check
> > > > > > > that is already done in drivers/rtc/interface.c.
> > > > > > > If it is not done here, the timekeeper can be set up wrongly
> > > > > > > in the first run and won't be corrected once the RTC driver is
> > > > > > > started because the validity check in the RTC driver drops the
> > > > > > > time and date due to invalid entries.
> > > > > > >
> > > > > > >  arch/x86/kernel/rtc.c | 12 +++++++++++-
> > > > > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
> > > > > > > index
> > > > > > > 586f718b8e95..f4af7b18c6c0 100644
> > > > > > > --- a/arch/x86/kernel/rtc.c
> > > > > > > +++ b/arch/x86/kernel/rtc.c
> > > > > > > @@ -9,6 +9,7 @@
> > > > > > >  #include <linux/export.h>
> > > > > > >  #include <linux/pnp.h>
> > > > > > >  #include <linux/of.h>
> > > > > > > +#include <linux/rtc.h>
> > > > > > >
> > > > > > >  #include <asm/vsyscall.h>
> > > > > > >  #include <asm/x86_init.h>
> > > > > > > @@ -64,6 +65,7 @@ void mach_get_cmos_time(struct timespec64
> > > > *now)
> > > > > > {
> > > > > > >         unsigned int status, year, mon, day, hour, min, sec, century = 0;
> > > > > > >         unsigned long flags;
> > > > > > > +       struct rtc_time tm = {0};
> > > > > > >
> > > > > > >         /*
> > > > > > >          * If pm_trace abused the RTC as storage, set the
> > > > > > > timespec to 0, @@
> > > > > > > -118,7 +120,15 @@ void mach_get_cmos_time(struct timespec64
> > > > *now)
> > > > > > >         } else
> > > > > > >                 year += CMOS_YEARS_OFFS;
> > > > > > >
> > > > > > > -       now->tv_sec = mktime64(year, mon, day, hour, min, sec);
> > > > > > > +       tm.tm_sec = sec;
> > > > > > > +       tm.tm_min = min;
> > > > > > > +       tm.tm_hour = hour;
> > > > > > > +       tm.tm_mday = day;
> > > > > > > +       tm.tm_mon = mon;
> > > > > > > +       tm.tm_year = year;
> > > > > > > +       now->tv_sec = 0;
> > > > > > > +       if (rtc_valid_tm(&tm) == 0)
> > > > > >
> > > > > > Doesn't that make the x86 architecture depend on CONFIG_RTC_LIB?
> > > > > >
> > > > > CONFIG_RTC_LIB is already default enabled for x86, see
> > arch/x86/Kconfig.
> > > > > Do you have any other dependencies in mind I have overseen?
> > > > >
> > > >
> > > > Nope, everything is fine, it would be better if we could get rid of
> > > > mach_get_cmos_time but I don't have any clue as to why this is
> > necessary.
> > > >
> > > >
> > > > --
> > > > Alexandre Belloni, co-owner and COO, Bootlin Embedded Linux and
> > > > Kernel engineering
> > > >
> > https://bootlin.com
> > >
> >
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin Embedded Linux and Kernel
> > engineering
> > https://bootlin.com

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
