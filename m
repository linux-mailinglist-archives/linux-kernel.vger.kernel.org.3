Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA149DCD2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiA0Ioe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiA0Iob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:44:31 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0029C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:44:30 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id u5so1869568ilq.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yb9RPFlZXk0exJR+sY5vDAJxFIK1S93A7qEGnkdG520=;
        b=BqnYSJD2n6g13hS3alh5y7e8Hsm7fjONivNt+k1AS/qm+C8nSQLiqvS8mjBw9htr2X
         Uu2shtOwenkk7kRMEJIWYf5/2HG35qwr5AmQnWbkxZ+SvwFMA+j2LRsPgj12EAUAqF4/
         0+zME0Z/T+FqPcMPi9FhFEFw9HRu5E1bfDaJluu+botSOt+goYQ45ENDd+KAFPO+3V1v
         XkxE112G/8PUdoaJ+plMU0l6sHvnOrwneHBYbcYN+AHUk8D1tmKfYu4gL9chnMZ0DwTX
         p6Oz2+IP2+ncghlLzEnr+cFjOkY+doub1FHbhgdf08OH/4C26VamyTf/ZFX/vGvpiM++
         dJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yb9RPFlZXk0exJR+sY5vDAJxFIK1S93A7qEGnkdG520=;
        b=SGO1BLsp0AWUnyzCMd5b6lly2muDFcX5LGls/UlISTDfMSLeLE6Ws/g7RZyT/3nsWR
         UJUdbl+YdJbQybqEGxgYuHf8GuzuInjheUifav3044ZGN4XXjCnSrDAFur5tFneNVS9g
         OfogIxc5a2EDE+ufupf8IBPoo6X3YcMRLfXdpi3K2yFyc1W7wexOlFYjttHNGrU2I4G/
         LL6vQaILoETLSrUHtUQAJ25r5JU3NWsnvkzcpnLeAbh7yna7gqmcnB/pnKrCEl1MRTMB
         N2XLDdaIbhOqyAI/Z5WlqhAMgHee8hhAw7J8Rc2xV8aWPR7AsY38qumTiGtnZyzVfc+O
         7coQ==
X-Gm-Message-State: AOAM530iedzZ93nSZUOFela3Zf64gr+tTbPAV1xU9ON+qGQYO+lYBnvS
        SJSJkpz8gMrpUIr2706GLbMW9bcWpO2lQQ6i81IhKhv5qg==
X-Google-Smtp-Source: ABdhPJyPog+BC4znr/2I1ICYWPtpAiJ27WV+8fFFZuamy6JoLHNpOLWgfzybJ1gJqU7mTSfaoovJapkyygorrwajgr4=
X-Received: by 2002:a92:c54f:: with SMTP id a15mr1803035ilj.302.1643273070332;
 Thu, 27 Jan 2022 00:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20220125033913.15374-1-kernelfans@gmail.com> <87wnin3hj5.mognet@arm.com>
 <CAFgQCTvbsh5UhefhDgOu8ZdUKww6FQXw-Hxnz5mC4vs0C+WP1w@mail.gmail.com> <87tudq35a8.mognet@arm.com>
In-Reply-To: <87tudq35a8.mognet@arm.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 27 Jan 2022 16:44:19 +0800
Message-ID: <CAFgQCTv_fYqtKYmn4nmXYxBMEZaCKFUQnDTRaeEkQPMBL-1amA@mail.gmail.com>
Subject: Re: [PATCH] kexec: disable cpu hotplug until the rebooting cpu is stable
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:06 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 26/01/22 10:45, Pingfan Liu wrote:
> > On Wed, Jan 26, 2022 at 12:29 AM Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> On 25/01/22 11:39, Pingfan Liu wrote:
> >> > The following identical code piece appears in both
> >> > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> >> >
> >> >       if (!cpu_online(primary_cpu))
> >> >               primary_cpu = cpumask_first(cpu_online_mask);
> >> >
> >> > Although the kexec-reboot task can get through a cpu_down() on its cpu,
> >> > this code looks a little confusing.
> >> >
> >> > Make things straight forward by keep cpu hotplug disabled until
> >> > smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> >> > rebooting cpu can keep unchanged.
> >> >
> >>
> >> So is this supposed to be a refactor with no change in behaviour? AFAICT it
> >> actually does change things (and isn't necessarily clearer).
> >>
> > Yes, as you have seen, it does change behavior. Before this patch,
> > there is a breakage:
> >   migrate_to_reboot_cpu();
> >   cpu_hotplug_enable();
> >                                      ----------> technical, here can
> > comes a cpu_down(this_cpu)
> >   machine_shutdown();
> >
> > And this patch squeezes out this breakage.
> >
>
> Ok, that's worth pointing out in the changelog.
>
Sure, I will update it.

> >> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> >> > index 68480f731192..db4fa6b174e3 100644
> >> > --- a/kernel/kexec_core.c
> >> > +++ b/kernel/kexec_core.c
> >> > @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
> >> >               kexec_in_progress = true;
> >> >               kernel_restart_prepare("kexec reboot");
> >> >               migrate_to_reboot_cpu();
> >> > -
> >> >               /*
> >> > -              * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> >> > -              * no further code needs to use CPU hotplug (which is true in
> >> > -              * the reboot case). However, the kexec path depends on using
> >> > -              * CPU hotplug again; so re-enable it here.
> >> > +              * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
> >> > +              * relies on the cpu teardown to achieve reboot, it needs to
> >> > +              * re-enable CPU hotplug there.
> >> >                */
> >> > -             cpu_hotplug_enable();
> >> > +
> >>
> >> Not all archs map machine_shutdown() to smp_shutdown_nonboot_cpus(), other
> >> archs will now be missing a cpu_hotplug_enable() prior to a kexec
> >> machine_shutdown(). That said, AFAICT none of those archs rely on the
> >> hotplug machinery in machine_shutdown(), so it might be OK, but that's not
> >> obvious at all.
> >>
> > At the first glance, it may be not obvious, but tracing down
> > cpu_hotplug_enable() to the variable cpu_hotplug_disabled, you can
> > find out the limited involved functions are all related to
> > cpu_up/cpu_down.
> >
> > IOW, if no code path connects with the interface of cpu_up/cpu_down,
> > then kexec-reboot will not be affected.
> >
>
> That's my point, this only works if the other archs truly do not rely on
> hotplug for machine_shutdown(), which seems to be the case but it wouldn't
> hurt for you to double-check that and explicitely call it out in the
> changelog.
>
OK, I will update the change log. BTW, besides x86, I have just
finished the test on powerpc, both of them works fine with this patch

> > And after this patch, it is more clear how to handle the following cases:
> > arch/arm/kernel/reboot.c:94:    smp_shutdown_nonboot_cpus(reboot_cpu);
> > arch/arm64/kernel/process.c:88: smp_shutdown_nonboot_cpus(reboot_cpu);
> > arch/ia64/kernel/process.c:578: smp_shutdown_nonboot_cpus(reboot_cpu);
> >
>
> FWIW riscv is also concerned.

I think its current statement is right.
arch/riscv/kernel/machine_kexec.c:135:
smp_shutdown_nonboot_cpus(smp_processor_id());

Thanks,

Pingfan
>
> > Thanks,
> > Pingfan
