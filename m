Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136DC49F48C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245639AbiA1Hlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiA1Hlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:41:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D63C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:41:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f8so4515203pgf.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8JSlx6VIBWVnwauxQx7Oud6URR8+gEQFFck37TqTxds=;
        b=LVdd+sSpUyAp58gJrQhb3gFy706lbm3J0NaV8OFA3txestV8n5hthOsID+HUYljMoN
         1sWCckK6vWT4EQTa8W/uWc55w3Ljx++BzyfN21+2rvKhn23W0q/3q0BZWJxROaEEE2bM
         Gz13cgOG6mLHiyHLjxa2yIq+0VAAJ9kUSoJosavBr8RtnpVdTVoBf4tpq3kgNaTShNwc
         uhD78k4XgcM4j18+UQSryH5QD3zO0FKrEYypwVrYDVlkONLETq5fuFAWZ+txaXHHdbMN
         /9qR3ZpzOS2IqUxHmzMbXGCapTPndZ7ZBmziUCOycZiJ9oRsiZuLthfh070X6Qj/GzW8
         9G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8JSlx6VIBWVnwauxQx7Oud6URR8+gEQFFck37TqTxds=;
        b=rZxWt8W+9MSQb+tZnL2Js2u5OMmZozUlZ8DM/CSUXipJlODp9ixBXcLvXJxnoiR5pJ
         lsWhN8u1x6Mj8y9btq6CHgG2vfwjvmrQ6yaBg3aTb+9VU6DsCwmkOLehB2lrpxC6AUG4
         2dNjrp9wfgKRpb8POcoYZTaLFII0f9HYwkaVGLlntbFfuBZwetvxDnRiQHbaiX+u/bra
         Z2QiDAoaQQnQWZWkm5Nmi9zqMvImm6yLI2sz0zFc4NDZt5e0CttPGrKLZ4kcYrAlJbDq
         gHL8ct9hc08nkyqk29z5lOm2Lm0sa/fPaZU8dJwwxTZreNQAGwp681s2O+WGWMIYXqpP
         U8Ww==
X-Gm-Message-State: AOAM531UkoJ2+BOxe0ArknYP0HqNAT5vx67CMp8ERveV5Q9e/mb722Ab
        9C+U4gNSDg2fKlRU3qtqaA==
X-Google-Smtp-Source: ABdhPJwz0ooxcn8QlxQLZExpdzDnbiVCBA9HGV+gzGYA+DJLQn+KkmSPfepE6f5aJSn7gSmpmjclAg==
X-Received: by 2002:aa7:9acb:: with SMTP id x11mr6573136pfp.82.1643355704912;
        Thu, 27 Jan 2022 23:41:44 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l191sm19182057pga.65.2022.01.27.23.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 23:41:44 -0800 (PST)
Date:   Fri, 28 Jan 2022 15:41:35 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Baoquan He <bhe@redhat.com>
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
Message-ID: <YfOeL6B4CowkCQBC@piliu.users.ipa.redhat.com>
References: <20220127090215.32000-1-kernelfans@gmail.com>
 <20220127094144.GC13508@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127094144.GC13508@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 05:41:44PM +0800, Baoquan He wrote:
Hi Baoquan,

Thanks for reviewing, please see comment inlined
> Hi Pingfan,
> 
> On 01/27/22 at 05:02pm, Pingfan Liu wrote:
> > The following identical code piece appears in both
> > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> > 
> > 	if (!cpu_online(primary_cpu))
> > 		primary_cpu = cpumask_first(cpu_online_mask);
> > 
> > This is due to a breakage like the following:
> >    migrate_to_reboot_cpu();
> >    cpu_hotplug_enable();
> >                           --> comes a cpu_down(this_cpu) on other cpu
> >    machine_shutdown();
> > 
> > Although the kexec-reboot task can get through a cpu_down() on its cpu,
> > this code looks a little confusing.
> > 
> > Make things straight forward by keeping cpu hotplug disabled until
> > smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> > breakage is squashed out and the rebooting cpu can keep unchanged.
> 
> If I didn't go through code wrongly, you may miss the x86 case.
> Several ARCHes do call smp_shutdown_nonboot_cpus() in machine_shutdown()
> in kexec reboot code path, while x86 doesn't. If I am right, you may
> need reconsider if this patch is needed or need be adjustd.
> 
Citing the code piece in kernel_kexec()

                migrate_to_reboot_cpu();

                /*
                 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
                 * no further code needs to use CPU hotplug (which is true in
                 * the reboot case). However, the kexec path depends on using
                 * CPU hotplug again; so re-enable it here.
                 */
                cpu_hotplug_enable();
                pr_notice("Starting new kernel\n");
                machine_shutdown();

So maybe it can be considered in such way: "cpu_hotplug_enable()" is not
needed by x86 and ppc, so this patch removes it, while re-displace it in
a more appropriate place for arm64/riscv ...

> Are you optimizing code path, or you meet a real problem? I haven't
> checked v1, but I also didn't see it's told in patch log which case it
> is.
> 
Simplify the code path and make the logic look straight forward.

And sorry for bad expression. I had thought I expressed it by (citing
git log)

|| The following identical code piece appears in both
                 ^^^^^^^^
|| migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
|| 
|| 	if (!cpu_online(primary_cpu))
|| 		primary_cpu = cpumask_first(cpu_online_mask);
|| 
|| This is due to a breakage like the following:
                    ^^^^^^^^
||    migrate_to_reboot_cpu();
||    cpu_hotplug_enable();
||                           --> comes a cpu_down(this_cpu) on other cpu
||    machine_shutdown();
|| 
|| Although the kexec-reboot task can get through a cpu_down() on its cpu,
                                      ^^^^^^^^^^^
|| this code looks a little confusing.

Should I rephrase it?

Thanks,

	Pingfan

> > 
> > Note: this patch only affects the kexec-reboot on arches, which rely on
> > cpu hotplug mechanism.
> > 
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
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: kexec@lists.infradead.org
> > To: linux-kernel@vger.kernel.org
> > ---
> > v1 -> v2:
> >  improve commit log
> > 
> >  kernel/cpu.c        | 16 ++++++++++------
> >  kernel/kexec_core.c | 10 ++++------
> >  2 files changed, 14 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 9c92147f0812..87bdf21de950 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1240,20 +1240,24 @@ int remove_cpu(unsigned int cpu)
> >  }
> >  EXPORT_SYMBOL_GPL(remove_cpu);
> >  
> > +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
> >  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
> >  {
> >  	unsigned int cpu;
> >  	int error;
> >  
> > +	/*
> > +	 * Block other cpu hotplug event, so primary_cpu is always online if
> > +	 * it is not touched by us
> > +	 */
> >  	cpu_maps_update_begin();
> > -
> >  	/*
> > -	 * Make certain the cpu I'm about to reboot on is online.
> > -	 *
> > -	 * This is inline to what migrate_to_reboot_cpu() already do.
> > +	 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> > +	 * no further code needs to use CPU hotplug (which is true in
> > +	 * the reboot case). However, the kexec path depends on using
> > +	 * CPU hotplug again; so re-enable it here.
> >  	 */
> > -	if (!cpu_online(primary_cpu))
> > -		primary_cpu = cpumask_first(cpu_online_mask);
> > +	__cpu_hotplug_enable();
> >  
> >  	for_each_online_cpu(cpu) {
> >  		if (cpu == primary_cpu)
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 68480f731192..db4fa6b174e3 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
> >  		kexec_in_progress = true;
> >  		kernel_restart_prepare("kexec reboot");
> >  		migrate_to_reboot_cpu();
> > -
> >  		/*
> > -		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> > -		 * no further code needs to use CPU hotplug (which is true in
> > -		 * the reboot case). However, the kexec path depends on using
> > -		 * CPU hotplug again; so re-enable it here.
> > +		 * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
> > +		 * relies on the cpu teardown to achieve reboot, it needs to
> > +		 * re-enable CPU hotplug there.
> >  		 */
> > -		cpu_hotplug_enable();
> > +
> >  		pr_notice("Starting new kernel\n");
> >  		machine_shutdown();
> >  	}
> > -- 
> > 2.31.1
> > 
> 
