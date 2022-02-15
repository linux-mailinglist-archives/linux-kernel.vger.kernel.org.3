Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C1A4B697D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiBOKjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:39:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiBOKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:39:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB48A31D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:38:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 994481F38A;
        Tue, 15 Feb 2022 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644921529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RWgiqsavi4LQkLJLAT2M9QYXv0J8DbLY5zh6H/ikYSY=;
        b=mDGuJZWs9DfvrVikLQgxmr7nvCSg34lIlV32ZQXnDbA/nyjIpuBzT+3ccZ6udBW58mRpRH
        SVr92jaWRpqEiBdaeyOrU13xXLEZrjIk4qmdX6IMzvWAJwlKnd0GaA1yTE2YR3a8pUAs7h
        PSCy9gOGiJlFU2D490JNWH44hz1EM7w=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3B4C6A3B83;
        Tue, 15 Feb 2022 10:38:49 +0000 (UTC)
Date:   Tue, 15 Feb 2022 11:38:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 03/13] printk: use percpu flag instead of
 cpu_online()
Message-ID: <YguCuFYeZ52mkr4r@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <YgaJZtY+EH9JIGyo@alley>
 <YgoGNmYER8xni34K@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgoGNmYER8xni34K@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-14 16:35:18, Sergey Senozhatsky wrote:
> On (22/02/11 17:05), Petr Mladek wrote:
> > On Mon 2022-02-07 20:49:13, John Ogness wrote:
> [..]
> > The problem is the commit ac25575203c11145066ea ("[PATCH] CPU hotplug
> > printk fix"). It suggests that per-CPU data of slab are freed during
> > hotplug.
> > 
> > There are many other things that are manipulated during cpu hotplug.
> > And there are the two notifiers "printk:dead" and "printk:online",
> > see printk_late_init(). Maybe, we should use them to decide whether
> > the non-trivial consoles are callable during CPU hotplug.
> 
> Great findings. Looks like we only set __printk_percpu_data_ready to
> true and never set it back to false, relying on cpu_online() in such
> cases. But here's the thing: we have printk_percpu_data_ready() in
> __printk_recursion_counter() and in wake_up_klogd() and in
> defer_console_output(), but why we never check __printk_percpu_data_ready
> in __down_trylock_console_sem()/__up_console_sem() and more importantly
> in console_trylock_spinning() and those do access this_cpu() in printk safe
> enter/exit. Am I missing something?

Great point!

I am not 100% sure. But it seems that static per-CPU variables might
actually be used since the boot.

This is from mm/percpu.c

 * There is special consideration for the first chunk which must handle
 * the static percpu variables in the kernel image as allocation services
 * are not online yet.  In short, the first chunk is structured like so:
 *
 *                  <Static | [Reserved] | Dynamic>
 *
 * The static data is copied from the original section managed by the
 * linker.  The reserved section, if non-zero, primarily manages static
 * percpu variables from kernel modules.  Finally, the dynamic section
 * takes care of normal allocations.


I thought that it might work only for CPU0. But it seems that it
probably works for each possible cpu, see:

bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
{
#ifdef CONFIG_SMP
	const size_t static_size = __per_cpu_end - __per_cpu_start;
	void __percpu *base = __addr_to_pcpu_ptr(pcpu_base_addr);
	unsigned int cpu;

	for_each_possible_cpu(cpu) {
		void *start = per_cpu_ptr(base, cpu);
		void *va = (void *)addr;

		if (va >= start && va < start + static_size) {
[...]
}

and

/**
 * is_kernel_percpu_address - test whether address is from static percpu area
 * @addr: address to test
 *
 * Test whether @addr belongs to in-kernel static percpu area.  Module
 * static percpu areas are not considered.  For those, use
 * is_module_percpu_address().
 *
 * RETURNS:
 * %true if @addr is from in-kernel static percpu area, %false otherwise.
 */
bool is_kernel_percpu_address(unsigned long addr)
{
	return __is_kernel_percpu_address(addr, NULL);
}


Most likely, only dynamically allocated per-cpu variables have to wait
until the per-cpu areas are initialized.

This might explain why there is no generic
are_per_cpu_variables_ready() callback.

We should probably revisit the code and remove the fallback to
normal static variables.

Best Regards,
Petr
