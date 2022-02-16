Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617594B7EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbiBPD3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:29:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344279AbiBPD3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:29:45 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96452FEB0C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:29:34 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u5so986514ple.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2kpmC0tEMCrOHD6+CDOUDHb25YQtPxjkpDAyvolQ4Qs=;
        b=MnYAvBwN3fo3B4O6Bb/5HQItQxu9NCxR8QGoqmcoWeuvY7gxiNpQpdb3b0hZR+pedz
         zUNYgdNkxDODwxEkJ6MvINUGb76NIo2dwDoZiHPqYWExt9hu7tc3Nzqj/6fRQNJDJPLf
         JiCLv8m0cxoaOG7p7dRc1lrcSWiMXJAUbBgek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2kpmC0tEMCrOHD6+CDOUDHb25YQtPxjkpDAyvolQ4Qs=;
        b=2WYC3pnhFVm211zplDueqoEo7RrhUP+cTlSt0sfrCO2LzvhQeB/3bArgErmGSwd+SK
         8FlWsG5lGi+aLJ5WHVeH146CCws3h6rAe8wOX6z0v2LWm6suwkKUOnGnnU3l32NTNJL+
         703DB8OuVgWGQLwy/HpI1C3LaCVccliEr4JFOQhy6oW5NXP2bj+ThynSHAKRulJe2SZn
         LVdP4A0xnEQavVhX6Mso70XvDRGCcSyVK/tLBfXXwWyeC51tL6lxUKpC2psHWLe4i/x9
         bQFLKXbdJSgnSkzQM24OYOcjZv2MLVw10uXSW/dmY4ZVGQzpdz7eSheNMHR7z5oTqPuv
         A1LA==
X-Gm-Message-State: AOAM531mU4tQ80ZMjtdNCPzRoIOcBkZ4hy/ZvjeMNHzRJVcvU71apmvv
        NnIiJ9SCWZUcD6h9g/uqpAND3w==
X-Google-Smtp-Source: ABdhPJydEvjDPVULwGeUFucMmT8cEU3P1vOQL+LieGAXiwHl/lYE4zDjqvauBr4dNwfSEYopmT2xtQ==
X-Received: by 2002:a17:903:234e:b0:14d:ca32:c5a4 with SMTP id c14-20020a170903234e00b0014dca32c5a4mr700608plh.140.1644982174102;
        Tue, 15 Feb 2022 19:29:34 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c926:4ee:add9:bf67])
        by smtp.gmail.com with ESMTPSA id c20sm30478536pfl.46.2022.02.15.19.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:29:33 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:29:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 03/13] printk: use percpu flag instead of
 cpu_online()
Message-ID: <YgxvmepaTqRxwn/o@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <YgaJZtY+EH9JIGyo@alley>
 <YgoGNmYER8xni34K@google.com>
 <YguCuFYeZ52mkr4r@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YguCuFYeZ52mkr4r@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/15 11:38), Petr Mladek wrote:
> On Mon 2022-02-14 16:35:18, Sergey Senozhatsky wrote:
> > On (22/02/11 17:05), Petr Mladek wrote:
> > > On Mon 2022-02-07 20:49:13, John Ogness wrote:
> > [..]
> > > The problem is the commit ac25575203c11145066ea ("[PATCH] CPU hotplug
> > > printk fix"). It suggests that per-CPU data of slab are freed during
> > > hotplug.
> > > 
> > > There are many other things that are manipulated during cpu hotplug.
> > > And there are the two notifiers "printk:dead" and "printk:online",
> > > see printk_late_init(). Maybe, we should use them to decide whether
> > > the non-trivial consoles are callable during CPU hotplug.
> > 
> > Great findings. Looks like we only set __printk_percpu_data_ready to
> > true and never set it back to false, relying on cpu_online() in such
> > cases. But here's the thing: we have printk_percpu_data_ready() in
> > __printk_recursion_counter() and in wake_up_klogd() and in
> > defer_console_output(), but why we never check __printk_percpu_data_ready
> > in __down_trylock_console_sem()/__up_console_sem() and more importantly
> > in console_trylock_spinning() and those do access this_cpu() in printk safe
> > enter/exit. Am I missing something?
> 
> Great point!
> 
> I am not 100% sure. But it seems that static per-CPU variables might
> actually be used since the boot.

Wow, this is great to learn. Thanks!

> This is from mm/percpu.c
> 
>  * There is special consideration for the first chunk which must handle
>  * the static percpu variables in the kernel image as allocation services
>  * are not online yet.  In short, the first chunk is structured like so:
>  *
>  *                  <Static | [Reserved] | Dynamic>
>  *
>  * The static data is copied from the original section managed by the
>  * linker.  The reserved section, if non-zero, primarily manages static
>  * percpu variables from kernel modules.  Finally, the dynamic section
>  * takes care of normal allocations.
> 
> 
> I thought that it might work only for CPU0. But it seems that it
> probably works for each possible cpu, see:
> 
> bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
> {
> #ifdef CONFIG_SMP
> 	const size_t static_size = __per_cpu_end - __per_cpu_start;
> 	void __percpu *base = __addr_to_pcpu_ptr(pcpu_base_addr);
> 	unsigned int cpu;
> 
> 	for_each_possible_cpu(cpu) {
> 		void *start = per_cpu_ptr(base, cpu);
> 		void *va = (void *)addr;
> 
> 		if (va >= start && va < start + static_size) {
> [...]
> }
> 
> and
> 
> /**
>  * is_kernel_percpu_address - test whether address is from static percpu area
>  * @addr: address to test
>  *
>  * Test whether @addr belongs to in-kernel static percpu area.  Module
>  * static percpu areas are not considered.  For those, use
>  * is_module_percpu_address().
>  *
>  * RETURNS:
>  * %true if @addr is from in-kernel static percpu area, %false otherwise.
>  */
> bool is_kernel_percpu_address(unsigned long addr)
> {
> 	return __is_kernel_percpu_address(addr, NULL);
> }
> 
> 
> Most likely, only dynamically allocated per-cpu variables have to wait
> until the per-cpu areas are initialized.
> 
> This might explain why there is no generic
> are_per_cpu_variables_ready() callback.
> 
> We should probably revisit the code and remove the fallback to
> normal static variables.

Agreed.
