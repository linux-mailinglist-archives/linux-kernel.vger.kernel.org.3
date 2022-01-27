Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600A249DE43
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiA0Jl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:41:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238725AbiA0Jl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643276516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZyJ4J5e+3GKlvkcYQ+urtekvThyzHXZ6mJY5flPNI2w=;
        b=Vd5sZ3dC7/pYBaGh+bF1xyrJq48A3qZZlBSQRvNx7JgVIy6XXx1EfCzkBHtcRJzjMMAoUJ
        t1pyPjjVGGQ3/mFoAMnjD53hTW+xESWPYOEuqMI2aID0CUU/Hah4ZuxVD2WA9FzCMpWtyl
        8JqBRJWi3B7QsASuT6NuSDR4uHHHZBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-Z12YeTdsM2i_9Q-z2YbW8A-1; Thu, 27 Jan 2022 04:41:50 -0500
X-MC-Unique: Z12YeTdsM2i_9Q-z2YbW8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78C56814514;
        Thu, 27 Jan 2022 09:41:48 +0000 (UTC)
Received: from localhost (ovpn-13-51.pek2.redhat.com [10.72.13.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B911105915D;
        Thu, 27 Jan 2022 09:41:47 +0000 (UTC)
Date:   Thu, 27 Jan 2022 17:41:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org
Subject: Re: [PATCHv2] kexec: disable cpu hotplug until the rebooting cpu is
 stable
Message-ID: <20220127094144.GC13508@MiWiFi-R3L-srv>
References: <20220127090215.32000-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127090215.32000-1-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pingfan,

On 01/27/22 at 05:02pm, Pingfan Liu wrote:
> The following identical code piece appears in both
> migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> 
> 	if (!cpu_online(primary_cpu))
> 		primary_cpu = cpumask_first(cpu_online_mask);
> 
> This is due to a breakage like the following:
>    migrate_to_reboot_cpu();
>    cpu_hotplug_enable();
>                           --> comes a cpu_down(this_cpu) on other cpu
>    machine_shutdown();
> 
> Although the kexec-reboot task can get through a cpu_down() on its cpu,
> this code looks a little confusing.
> 
> Make things straight forward by keeping cpu hotplug disabled until
> smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> breakage is squashed out and the rebooting cpu can keep unchanged.

If I didn't go through code wrongly, you may miss the x86 case.
Several ARCHes do call smp_shutdown_nonboot_cpus() in machine_shutdown()
in kexec reboot code path, while x86 doesn't. If I am right, you may
need reconsider if this patch is needed or need be adjustd.

Are you optimizing code path, or you meet a real problem? I haven't
checked v1, but I also didn't see it's told in patch log which case it
is.


> 
> Note: this patch only affects the kexec-reboot on arches, which rely on
> cpu hotplug mechanism.
> 
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
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: kexec@lists.infradead.org
> To: linux-kernel@vger.kernel.org
> ---
> v1 -> v2:
>  improve commit log
> 
>  kernel/cpu.c        | 16 ++++++++++------
>  kernel/kexec_core.c | 10 ++++------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9c92147f0812..87bdf21de950 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1240,20 +1240,24 @@ int remove_cpu(unsigned int cpu)
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
>  		pr_notice("Starting new kernel\n");
>  		machine_shutdown();
>  	}
> -- 
> 2.31.1
> 

