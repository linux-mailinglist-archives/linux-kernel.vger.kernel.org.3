Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD34AEED5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiBIKCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiBIKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:01:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7367CE0E9166
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644400578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0HK3B5yNAKajVmotOojuc2NAUachNqSXS/dwZrea2Q=;
        b=MiDrZ4gltHXcPb2OxwVx9YGPFXU+Fkzhwtx4xlhFhmrlqjMbsCGMyNxbOSxtbh4ghg8Zkd
        VL6i50ttptJVhE0TuXA6tPcvJxM6z/1leb+GntFlBdKO2Ov7E3JVlWuEQv4v5FJklgAamb
        1XKsUwUfxU36GB+Z0LCVo7k6OyWwdiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-dGDdDviNNj6gL9uAMi56kg-1; Wed, 09 Feb 2022 03:44:16 -0500
X-MC-Unique: dGDdDviNNj6gL9uAMi56kg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47C6419251A0;
        Wed,  9 Feb 2022 08:44:14 +0000 (UTC)
Received: from localhost (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39FF91057FD5;
        Wed,  9 Feb 2022 08:44:12 +0000 (UTC)
Date:   Wed, 9 Feb 2022 16:44:10 +0800
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
Message-ID: <YgN+2gAoeyp05MV7@MiWiFi-R3L-srv>
References: <20220127090215.32000-1-kernelfans@gmail.com>
 <20220127094144.GC13508@MiWiFi-R3L-srv>
 <YfOeL6B4CowkCQBC@piliu.users.ipa.redhat.com>
 <YgI5AFoL4b/5MJEp@MiWiFi-R3L-srv>
 <YgNt4slCVxHRex8z@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgNt4slCVxHRex8z@piliu.users.ipa.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/22 at 03:31pm, Pingfan Liu wrote:
> On Tue, Feb 08, 2022 at 05:33:52PM +0800, Baoquan He wrote:
> > On 01/28/22 at 03:41pm, Pingfan Liu wrote:
> > > On Thu, Jan 27, 2022 at 05:41:44PM +0800, Baoquan He wrote:
> > > Hi Baoquan,
> > > 
> > > Thanks for reviewing, please see comment inlined
> > > > Hi Pingfan,
> > > > 
> > > > On 01/27/22 at 05:02pm, Pingfan Liu wrote:
> > > > > The following identical code piece appears in both
> > > > > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> > > > > 
> > > > > 	if (!cpu_online(primary_cpu))
> > > > > 		primary_cpu = cpumask_first(cpu_online_mask);
> > > > > 
> > > > > This is due to a breakage like the following:
> > > > >    migrate_to_reboot_cpu();
> > > > >    cpu_hotplug_enable();
> > > > >                           --> comes a cpu_down(this_cpu) on other cpu
> > > > >    machine_shutdown();
> > > > > 
> > > > > Although the kexec-reboot task can get through a cpu_down() on its cpu,
> > > > > this code looks a little confusing.
> > > > > 
> > > > > Make things straight forward by keeping cpu hotplug disabled until
> > > > > smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> > > > > breakage is squashed out and the rebooting cpu can keep unchanged.
> > > > 
> > > > If I didn't go through code wrongly, you may miss the x86 case.
> > > > Several ARCHes do call smp_shutdown_nonboot_cpus() in machine_shutdown()
> > > > in kexec reboot code path, while x86 doesn't. If I am right, you may
> > > > need reconsider if this patch is needed or need be adjustd.
> > > > 
> > > Citing the code piece in kernel_kexec()
> > > 
> > >                 migrate_to_reboot_cpu();
> > > 
> > >                 /*
> > >                  * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> > >                  * no further code needs to use CPU hotplug (which is true in
> > >                  * the reboot case). However, the kexec path depends on using
> > >                  * CPU hotplug again; so re-enable it here.
> > >                  */
> > >                 cpu_hotplug_enable();
> > >                 pr_notice("Starting new kernel\n");
> > >                 machine_shutdown();
> > > 
> > > So maybe it can be considered in such way: "cpu_hotplug_enable()" is not
> > > needed by x86 and ppc, so this patch removes it, while re-displace it in
> > > a more appropriate place for arm64/riscv ...
> > 
> > OK, so the thing is:
> > 
> > ==
> > In the current code of kexec, we disable cpu hotplug and check reboot cpu
> > validity in migrate_to_reboot_cpu(), then enable cpu hotplug. Then in
> > machine_shutdown()->smp_shutdown_nonboot_cpus(), check the reboot cpu and
> > disable cpu hotplug again.
>   ^^^
> No, there is no any new call to cpu_hotplug_disable() after
> migrate_to_reboot_cpu(). smp_shutdown_nonboot_cpus() just leaves
> cpu_hotplug_disabled==0 as it is.

Hmm, there's 'cpu_hotplug_disabled++;' at the end of
smp_shutdown_nonboot_cpus(). It's disabling cpu hotplug again, I think.

> > 
> > In this patch, it disables cpu hotplug in migrate_to_reboot_cpu() and
> > keep it till entering into smp_shutdown_nonboot_cpus() to shutdown all
> > other cpu with hotplug mechanism, then disable it again. With this
>                                          ^^^
> Here is enable, i.e. smp_shutdown_nonboot_cpus() makes
> cpu_hotplug_disabled switch from 1 to 0, so the following fn can work

Right, you keep the cpu hotplug disabled till in
smp_shutdown_nonboot_cpus(), then enable it to shut down all other cpus.

> ||	static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
> ||	{
> ||		if (cpu_hotplug_disabled)
> ||			return -EBUSY;
> ||		return _cpu_down(cpu, 0, target);
> ||	}
> 
> > change, it won't need to double check the reboot cpu validity. 
> > 
> > This change only affect ARCHes relying on hotplug to shutdown cpu before
> > kexec reboot, e.g arm64, risc-v. Other ARCH like x86 is not affected.
> 
> Yes.
> > ==
> > 
> > Do I got it right?
> > 
> Here, neither the original code nor this patch has another
> cpu_hotplug_disable(), the only change is the shift of cpu_hotplug_enable() to an onwards place.
> 
> And I think you should get my idea except this.
> 
> Thanks,
> 
> 	Pingfan
> 

