Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7785654F89F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382417AbiFQNwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382007AbiFQNwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:52:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF2245AF3;
        Fri, 17 Jun 2022 06:52:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EF39121DA1;
        Fri, 17 Jun 2022 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655473950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T1THTVu8jsvNWfYRgAb3JbU5dAAvtESDUxIyAXq6VH0=;
        b=ZruHASuJWkYRWTXGUZK85EK1c2rCRi6u/ea2V1Xaju6kf537/p+6XgRLlQJzSioBoJNQwF
        U1LqDOQcvtBm+JsMVeVtH5gNXUx4oiOhAxKTpx+ERTsaIO3ifeD369svwTH1+PorMfCSCC
        cQfWK1DxwF3MVA+ZSLSitKv/W56CBbw=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 91CD52C141;
        Fri, 17 Jun 2022 13:52:30 +0000 (UTC)
Date:   Fri, 17 Jun 2022 15:52:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Tao Zhou <tao.zhou@linux.dev>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
Message-ID: <YqyHGxPCgiXuep3/@alley>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <Yqxaf6V+hvCSXQSM@geo.homenetwork>
 <xhsmhh74j7biy.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhh74j7biy.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-06-17 12:52:05, Valentin Schneider wrote:
> Hi Tao,
> 
> On 17/06/22 18:42, Tao Zhou wrote:
> > Hi Valentin,
> >
> > On Thu, Jun 16, 2022 at 01:37:09PM +0100, Valentin Schneider wrote:
> >> @@ -964,24 +966,31 @@ late_initcall(kexec_core_sysctl_init);
> >>   */
> >>  void __noclone __crash_kexec(struct pt_regs *regs)
> >>  {
> >> -	/* Take the kexec_mutex here to prevent sys_kexec_load
> >> -	 * running on one cpu from replacing the crash kernel
> >> -	 * we are using after a panic on a different cpu.
> >> +	/*
> >> +	 * This should be taking kexec_mutex before doing anything with the
> >> +	 * kexec_crash_image, but this code can be run in NMI context which
> >> +	 * means we can't even trylock.
> >>  	 *
> >> -	 * If the crash kernel was not located in a fixed area
> >> -	 * of memory the xchg(&kexec_crash_image) would be
> >> -	 * sufficient.  But since I reuse the memory...
> >> +	 * Pairs with smp_mb() in do_kexec_load() and sys_kexec_file_load()
> >>  	 */
> >> -	if (mutex_trylock(&kexec_mutex)) {
> >> -		if (kexec_crash_image) {
> >> -			struct pt_regs fixed_regs;
> >> -
> >> -			crash_setup_regs(&fixed_regs, regs);
> >> -			crash_save_vmcoreinfo();
> >> -			machine_crash_shutdown(&fixed_regs);
> >> -			machine_kexec(kexec_crash_image);
> >> -		}
> >> -		mutex_unlock(&kexec_mutex);
> >> +	WRITE_ONCE(panic_wants_kexec, true);
> >> +	smp_mb();
> >> +	/*
> >> +	 * If we're panic'ing while someone else is messing with the crash
> >> +	 * kernel, this isn't going to end well.
> >> +	 */
> >> +	if (READ_ONCE(kexec_loading)) {
> >> +		WRITE_ONCE(panic_wants_kexec, false);
> >> +		return;
> >> +	}
> >
> > So this is from NMI. The mutex guarantee that kexec_file_load() or 
> > do_kexec_load() just one of them beat on cpu. NMI can happen on more
> > than one cpu. That means that here be cumulativity here IMHO.
> >
> 
> If you look at __crash_kexec() in isolation yes, but if you look at panic()
> and nmi_panic() only a single NMI can get in there. I think that is also
> true for invocations via crash_kexec().

It is true that panic() could be called only once, see this code
in panic():

	 * Only one CPU is allowed to execute the panic code from here. For
	this_cpu = raw_smp_processor_id();
	old_cpu  = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);

	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
		panic_smp_self_stop();


One the other hand, the aproach with two variables is strage
and brings exactly these questions.

If a trylock is enough that the mutex can be replaced by two
simple atomic operations. The mutex would be needed only
when a user really would need to wait for another one.


	atomic_t crash_kexec_lock;

	/* trylock part */
	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1) != 0)
		return -EBUSY;

	/* do anything guarded by crash_kexec_lock */

	/* release lock */
	atomic_set_release(&crash_kexec_lock, 0);

The _acquire, _release variants will do the barriers correctly.

Best Regards,
Petr
