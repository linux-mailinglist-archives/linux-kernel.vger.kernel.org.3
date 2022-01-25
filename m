Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F374D49B8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346887AbiAYQeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:34:12 -0500
Received: from foss.arm.com ([217.140.110.172]:54266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382751AbiAYQ36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D74511FB;
        Tue, 25 Jan 2022 08:29:57 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A3B3F766;
        Tue, 25 Jan 2022 08:29:56 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: disable cpu hotplug until the rebooting cpu is stable
In-Reply-To: <20220125033913.15374-1-kernelfans@gmail.com>
References: <20220125033913.15374-1-kernelfans@gmail.com>
Date:   Tue, 25 Jan 2022 16:29:50 +0000
Message-ID: <87wnin3hj5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/22 11:39, Pingfan Liu wrote:
> The following identical code piece appears in both
> migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
>
> 	if (!cpu_online(primary_cpu))
> 		primary_cpu = cpumask_first(cpu_online_mask);
>
> Although the kexec-reboot task can get through a cpu_down() on its cpu,
> this code looks a little confusing.
>
> Make things straight forward by keep cpu hotplug disabled until
> smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> rebooting cpu can keep unchanged.
>

So is this supposed to be a refactor with no change in behaviour? AFAICT it
actually does change things (and isn't necessarily clearer).

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Cc: Baokun Li <libaokun1@huawei.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: kexec@lists.infradead.org
> To: linux-kernel@vger.kernel.org
> ---
>  kernel/cpu.c        | 16 ++++++++++------
>  kernel/kexec_core.c | 10 ++++------
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 407a2568f35e..bc687d59ca90 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1227,20 +1227,24 @@ int remove_cpu(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(remove_cpu);
>  
> +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
>  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
>  {
>  	unsigned int cpu;
>  	int error;
>  
> +	/*
> +	 * Block other cpu hotplug event, so primary_cpu is always online if
> +	 * it is not touched by us
> +	 */
>  	cpu_maps_update_begin();
> -
>  	/*
> -	 * Make certain the cpu I'm about to reboot on is online.
> -	 *
> -	 * This is inline to what migrate_to_reboot_cpu() already do.
> +	 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> +	 * no further code needs to use CPU hotplug (which is true in
> +	 * the reboot case). However, the kexec path depends on using
> +	 * CPU hotplug again; so re-enable it here.
>  	 */
> -	if (!cpu_online(primary_cpu))
> -		primary_cpu = cpumask_first(cpu_online_mask);
> +	__cpu_hotplug_enable();
>  
>  	for_each_online_cpu(cpu) {
>  		if (cpu == primary_cpu)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 68480f731192..db4fa6b174e3 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
> -
>  		/*
> -		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> -		 * no further code needs to use CPU hotplug (which is true in
> -		 * the reboot case). However, the kexec path depends on using
> -		 * CPU hotplug again; so re-enable it here.
> +		 * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
> +		 * relies on the cpu teardown to achieve reboot, it needs to
> +		 * re-enable CPU hotplug there.
>  		 */
> -		cpu_hotplug_enable();
> +

Not all archs map machine_shutdown() to smp_shutdown_nonboot_cpus(), other
archs will now be missing a cpu_hotplug_enable() prior to a kexec
machine_shutdown(). That said, AFAICT none of those archs rely on the
hotplug machinery in machine_shutdown(), so it might be OK, but that's not
obvious at all.

>  		pr_notice("Starting new kernel\n");
>  		machine_shutdown();
>  	}
> -- 
> 2.31.1
