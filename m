Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2049C16B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiAZCpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiAZCpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:45:24 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF2AC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:45:24 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id o10so18546000ilh.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrGVYU8ii7yjMq4cDJe7r5dIBf64zy/ZpHX9bwBJtMs=;
        b=KsPfUa7i0ZjVAYQ1y1PleSPS3QrmeiPCpusoud+GnkXNnX2sET+TaqvaoQCh2Vz27Q
         1Eo4RW0nN0yshIFiyP1Qq8X6Q+G7TZsdpdwfdcMe6OdvqdRBe2NWNlRa9ws1fRMNxiwr
         QVoSJzaMbrplS5K3iU7Yob/rl2GXxbWZE0YqZaAPNgJb387vLAOqF9FJI9Kfe3PrLBdd
         CNZ3v8R9nFhEW7f3cVrQBeRvXfyEP66PG5kTT3MrBNMzUXr2UdVEAZ/JxZvEK2YDHrp1
         f2wPQeScAMWrW3ot+gwRXYlMv8VP3eFYSaBd2HssYUhFktLI4H2gRreC22FlOcKJzW2Z
         R6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrGVYU8ii7yjMq4cDJe7r5dIBf64zy/ZpHX9bwBJtMs=;
        b=E6qyiIL643tGSC0Kp449Vu/BVc8OlAg5y9furON9UpcdcKchvfsi8n0N/QaRC6atuV
         X+7qb/A2mlE6hBTmLC898XUEDBnhYn7eA5c5xxdhoSRd1UkltY31r9HAX1BdRqou0sX3
         jq+L+1ejnB4wzUgel3gLMY1ETA17aVqe+F7C/R+X8pIxUQOt/20VfEOwWcAWCbQ2WBYR
         D2w6wbGkGsG4Op9aI9H+etu5HVg5bZr1v83ueG5uPlJC1dk+kq6mGbblg/mK79klJYPb
         XaOhu8kk26zPNVihCDFeFkKrQbI7R4fIu2/9VYjdWA+/JZNA06Ij32NEhKRe1K5uS/o3
         jC8Q==
X-Gm-Message-State: AOAM5332JxswO1Zj0JUk9fbYDWcjS728AapvW/S412aw323V1zDdT1x9
        68nbdIEO78lV4CIcE0V4gf3RcH56UcctPkoP8A==
X-Google-Smtp-Source: ABdhPJxWDMq3tO3Ga9vLxYXSL6hbuOSUopJT3r+2jtfP+2kGCfytT08xO6pk2iV62G29NIScNMPc/jSDKezm26My3J8=
X-Received: by 2002:a92:cda7:: with SMTP id g7mr13561068ild.53.1643165123499;
 Tue, 25 Jan 2022 18:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20220125033913.15374-1-kernelfans@gmail.com> <87wnin3hj5.mognet@arm.com>
In-Reply-To: <87wnin3hj5.mognet@arm.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 26 Jan 2022 10:45:12 +0800
Message-ID: <CAFgQCTvbsh5UhefhDgOu8ZdUKww6FQXw-Hxnz5mC4vs0C+WP1w@mail.gmail.com>
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

On Wed, Jan 26, 2022 at 12:29 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 25/01/22 11:39, Pingfan Liu wrote:
> > The following identical code piece appears in both
> > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> >
> >       if (!cpu_online(primary_cpu))
> >               primary_cpu = cpumask_first(cpu_online_mask);
> >
> > Although the kexec-reboot task can get through a cpu_down() on its cpu,
> > this code looks a little confusing.
> >
> > Make things straight forward by keep cpu hotplug disabled until
> > smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> > rebooting cpu can keep unchanged.
> >
>
> So is this supposed to be a refactor with no change in behaviour? AFAICT it
> actually does change things (and isn't necessarily clearer).
>
Yes, as you have seen, it does change behavior. Before this patch,
there is a breakage:
  migrate_to_reboot_cpu();
  cpu_hotplug_enable();
                                     ----------> technical, here can
comes a cpu_down(this_cpu)
  machine_shutdown();

And this patch squeezes out this breakage.

> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: YueHaibing <yuehaibing@huawei.com>
> > Cc: Baokun Li <libaokun1@huawei.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: kexec@lists.infradead.org
> > To: linux-kernel@vger.kernel.org
> > ---
> >  kernel/cpu.c        | 16 ++++++++++------
> >  kernel/kexec_core.c | 10 ++++------
> >  2 files changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 407a2568f35e..bc687d59ca90 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1227,20 +1227,24 @@ int remove_cpu(unsigned int cpu)
> >  }
> >  EXPORT_SYMBOL_GPL(remove_cpu);
> >
> > +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
> >  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
> >  {
> >       unsigned int cpu;
> >       int error;
> >
> > +     /*
> > +      * Block other cpu hotplug event, so primary_cpu is always online if
> > +      * it is not touched by us
> > +      */
> >       cpu_maps_update_begin();
> > -
> >       /*
> > -      * Make certain the cpu I'm about to reboot on is online.
> > -      *
> > -      * This is inline to what migrate_to_reboot_cpu() already do.
> > +      * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> > +      * no further code needs to use CPU hotplug (which is true in
> > +      * the reboot case). However, the kexec path depends on using
> > +      * CPU hotplug again; so re-enable it here.
> >        */
> > -     if (!cpu_online(primary_cpu))
> > -             primary_cpu = cpumask_first(cpu_online_mask);
> > +     __cpu_hotplug_enable();
> >
> >       for_each_online_cpu(cpu) {
> >               if (cpu == primary_cpu)
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 68480f731192..db4fa6b174e3 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
> >               kexec_in_progress = true;
> >               kernel_restart_prepare("kexec reboot");
> >               migrate_to_reboot_cpu();
> > -
> >               /*
> > -              * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> > -              * no further code needs to use CPU hotplug (which is true in
> > -              * the reboot case). However, the kexec path depends on using
> > -              * CPU hotplug again; so re-enable it here.
> > +              * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
> > +              * relies on the cpu teardown to achieve reboot, it needs to
> > +              * re-enable CPU hotplug there.
> >                */
> > -             cpu_hotplug_enable();
> > +
>
> Not all archs map machine_shutdown() to smp_shutdown_nonboot_cpus(), other
> archs will now be missing a cpu_hotplug_enable() prior to a kexec
> machine_shutdown(). That said, AFAICT none of those archs rely on the
> hotplug machinery in machine_shutdown(), so it might be OK, but that's not
> obvious at all.
>
At the first glance, it may be not obvious, but tracing down
cpu_hotplug_enable() to the variable cpu_hotplug_disabled, you can
find out the limited involved functions are all related to
cpu_up/cpu_down.

IOW, if no code path connects with the interface of cpu_up/cpu_down,
then kexec-reboot will not be affected.

And after this patch, it is more clear how to handle the following cases:
arch/arm/kernel/reboot.c:94:    smp_shutdown_nonboot_cpus(reboot_cpu);
arch/arm64/kernel/process.c:88: smp_shutdown_nonboot_cpus(reboot_cpu);
arch/ia64/kernel/process.c:578: smp_shutdown_nonboot_cpus(reboot_cpu);

Thanks,
Pingfan
