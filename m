Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7B520FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbiEJIcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiEJIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:32:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1736E20
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:28:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652171291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TiMg1DrTYo/YZ2MXrCD0mV4n3aaVIaQGDnTw1AQsXRA=;
        b=nsioDX0IJUJIIL8PcIZ5LZzjCAKZI9Yr4r6v2sHmM1ka35Rq14vG/PKGc/MJ7nrybEppWR
        Ipk+vo4VaSBBSu+jb2BdzfelvxOh5spJvUCU+bj/Hq6FV93crY8ZW6ZKZ2/ez7VRAnGmPV
        WNHR9YJ4fql4wg3MaMI4IKparg7lD3q9R8zA08HpAv1h59XzQzGLlcpptDFZ1y4srezObO
        seOtnuUVQJeiYGJ3a++MYEZ4oOpjYnAWIgRK1uU4ssWG8qLdy7T97N+l4lXayj3dJz9fJh
        6LU4Vm3VetdEqRdZtxrCGUHIkOkK0/vJi5bRTkNpzwfTHPrmPDQyUQMAGMW5Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652171291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TiMg1DrTYo/YZ2MXrCD0mV4n3aaVIaQGDnTw1AQsXRA=;
        b=O7fDOSZXbtRnEViXweUqLo/rP6gRRUbIYVkmwi1ef+vfFRAMnnDMEQW1lhH87G88tPcFdg
        x9/0dAaYDXZnbjAw==
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCHv3 1/2] cpu/hotplug: Keep cpu hotplug disabled until the
 rebooting cpu is stable
In-Reply-To: <YnneUeRJ42SRM/M+@piliu.users.ipa.redhat.com>
References: <20220509041305.15056-1-kernelfans@gmail.com>
 <20220509041305.15056-2-kernelfans@gmail.com> <87ee13rn52.ffs@tglx>
 <YnneUeRJ42SRM/M+@piliu.users.ipa.redhat.com>
Date:   Tue, 10 May 2022 10:28:11 +0200
Message-ID: <87y1z9pzac.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10 2022 at 11:38, Pingfan Liu wrote:
> On Mon, May 09, 2022 at 12:55:21PM +0200, Thomas Gleixner wrote:
>> On Mon, May 09 2022 at 12:13, Pingfan Liu wrote:
>> > The following code chunk repeats in both
>> > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
>> > This is due to a breakage like the following:
>> 
>> I don't see what's broken here.
>> 
>
> No, no broken. Could it be better to replace 'breakage' with
> 'breakin'?

There is no break-in. There is a phase where CPU hotplug is reenabled,
which might be avoided.

>> > +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
>> 
>> This comment makes no sense.
>> 
>
> Since migrate_to_reboot_cpu() disables cpu hotplug, so the selected
> valid online cpu -- primary_cpu keeps unchange.

So what is that parameter for then? If migrate_to_reboot_cpu() ensured
that the current task is on the reboot CPU then this parameter is
useless, no?

>> >  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
>> >  {
>> >  	unsigned int cpu;
>> >  	int error;
>> >  
>> > +	/*
>> > +	 * Block other cpu hotplug event, so primary_cpu is always online if
>> > +	 * it is not touched by us
>> > +	 */
>> >  	cpu_maps_update_begin();
>> > -
>> >  	/*
>> > -	 * Make certain the cpu I'm about to reboot on is online.
>> > -	 *
>> > -	 * This is inline to what migrate_to_reboot_cpu() already do.
>> > +	 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
>> > +	 * no further code needs to use CPU hotplug (which is true in
>> > +	 * the reboot case). However, the kexec path depends on using
>> > +	 * CPU hotplug again; so re-enable it here.
>> 
>> You want to reduce confusion, but in reality this is even more confusing
>> than before.
>> 
>
> This __cpu_hotplug_enable() can be considered to defer from kernel_kexec() to
> arch-dependent code chunk (here), which is a more proper point.
>
> Could it make things better by rephrasing the words as the following?
>    migrate_to_reboot_cpu() disables CPU hotplug to prevent the selected
>    reboot cpu from disappearing. But arches need cpu_down to hot remove
>    cpus except rebooting-cpu, so re-enabling cpu hotplug again.

Can you please use proper words. arches is not a word and it's closer to
the plural of arch, than to the word architecture. This is not twitter.

And no, the architectures do not need cpu_down() at all. This very
function smp_shutdown_nonboot_cpus() invokes cpu_down_maps_locked() to
shut down the non boot CPUs. That fails when cpu_hotplug_disabled != 0.

>> >  	 */
>> > -	if (!cpu_online(primary_cpu))
>> > -		primary_cpu = cpumask_first(cpu_online_mask);
>> > +	__cpu_hotplug_enable();
>> 
>> How is this decrement solving anything? At the end of this function, the
>> counter is incremented again. So what's the point of this exercise?
>> 
> This decrement enables the cpu hot-removing.  Since
> smp_shutdown_nonboot_cpus()->cpu_down_maps_locked(), if
> cpu_hotplug_disabled, it returns -EBUSY.

Correct, so why can't you spell that out in concise words in the first
place right at that comment which reenables hotplug?

>> What does that for arch/powerpc/kernel/kexec_machine64.c now?
>> 
>> Nothing, as far as I can tell. Which means you basically reverted
>> 011e4b02f1da ("powerpc, kexec: Fix "Processor X is stuck" issue during
>> kexec from ST mode") unless I'm completely confused.
>> 
>
> Oops. Forget about powerpc. Considering the cpu hotplug is an
> arch-dependent feature in machine_shutdown(), as x86 does not need it.

It's not a feature, it's a architecture specific requirement. x86 is
irrelevant here because this is a powerpc requirement.

>> This is tinkering at best. Can we please sit down and rethink this whole
>> machinery instead of applying random duct tape to it?
>> 
> I try to make code look consistent.

Emphasis on try. So far the attempt failed and resulted in a regression.

Thanks,

        tglx
