Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C5C49CD50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbiAZPGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:06:48 -0500
Received: from foss.arm.com ([217.140.110.172]:45758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235639AbiAZPGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:06:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81F0D11B3;
        Wed, 26 Jan 2022 07:06:46 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDC643F793;
        Wed, 26 Jan 2022 07:06:44 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
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
Subject: Re: [PATCH] kexec: disable cpu hotplug until the rebooting cpu is stable
In-Reply-To: <CAFgQCTvbsh5UhefhDgOu8ZdUKww6FQXw-Hxnz5mC4vs0C+WP1w@mail.gmail.com>
References: <20220125033913.15374-1-kernelfans@gmail.com> <87wnin3hj5.mognet@arm.com> <CAFgQCTvbsh5UhefhDgOu8ZdUKww6FQXw-Hxnz5mC4vs0C+WP1w@mail.gmail.com>
Date:   Wed, 26 Jan 2022 15:06:39 +0000
Message-ID: <87tudq35a8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/22 10:45, Pingfan Liu wrote:
> On Wed, Jan 26, 2022 at 12:29 AM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> On 25/01/22 11:39, Pingfan Liu wrote:
>> > The following identical code piece appears in both
>> > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
>> >
>> >       if (!cpu_online(primary_cpu))
>> >               primary_cpu = cpumask_first(cpu_online_mask);
>> >
>> > Although the kexec-reboot task can get through a cpu_down() on its cpu,
>> > this code looks a little confusing.
>> >
>> > Make things straight forward by keep cpu hotplug disabled until
>> > smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
>> > rebooting cpu can keep unchanged.
>> >
>>
>> So is this supposed to be a refactor with no change in behaviour? AFAICT it
>> actually does change things (and isn't necessarily clearer).
>>
> Yes, as you have seen, it does change behavior. Before this patch,
> there is a breakage:
>   migrate_to_reboot_cpu();
>   cpu_hotplug_enable();
>                                      ----------> technical, here can
> comes a cpu_down(this_cpu)
>   machine_shutdown();
>
> And this patch squeezes out this breakage.
>

Ok, that's worth pointing out in the changelog.

>> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> > index 68480f731192..db4fa6b174e3 100644
>> > --- a/kernel/kexec_core.c
>> > +++ b/kernel/kexec_core.c
>> > @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
>> >               kexec_in_progress = true;
>> >               kernel_restart_prepare("kexec reboot");
>> >               migrate_to_reboot_cpu();
>> > -
>> >               /*
>> > -              * migrate_to_reboot_cpu() disables CPU hotplug assuming that
>> > -              * no further code needs to use CPU hotplug (which is true in
>> > -              * the reboot case). However, the kexec path depends on using
>> > -              * CPU hotplug again; so re-enable it here.
>> > +              * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
>> > +              * relies on the cpu teardown to achieve reboot, it needs to
>> > +              * re-enable CPU hotplug there.
>> >                */
>> > -             cpu_hotplug_enable();
>> > +
>>
>> Not all archs map machine_shutdown() to smp_shutdown_nonboot_cpus(), other
>> archs will now be missing a cpu_hotplug_enable() prior to a kexec
>> machine_shutdown(). That said, AFAICT none of those archs rely on the
>> hotplug machinery in machine_shutdown(), so it might be OK, but that's not
>> obvious at all.
>>
> At the first glance, it may be not obvious, but tracing down
> cpu_hotplug_enable() to the variable cpu_hotplug_disabled, you can
> find out the limited involved functions are all related to
> cpu_up/cpu_down.
>
> IOW, if no code path connects with the interface of cpu_up/cpu_down,
> then kexec-reboot will not be affected.
>

That's my point, this only works if the other archs truly do not rely on
hotplug for machine_shutdown(), which seems to be the case but it wouldn't
hurt for you to double-check that and explicitely call it out in the
changelog.

> And after this patch, it is more clear how to handle the following cases:
> arch/arm/kernel/reboot.c:94:    smp_shutdown_nonboot_cpus(reboot_cpu);
> arch/arm64/kernel/process.c:88: smp_shutdown_nonboot_cpus(reboot_cpu);
> arch/ia64/kernel/process.c:578: smp_shutdown_nonboot_cpus(reboot_cpu);
>

FWIW riscv is also concerned.

> Thanks,
> Pingfan
