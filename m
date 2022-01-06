Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE1486B10
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbiAFUZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:25:34 -0500
Received: from netrider.rowland.org ([192.131.102.5]:48469 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S243747AbiAFUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:25:31 -0500
Received: (qmail 86633 invoked by uid 1000); 6 Jan 2022 15:25:28 -0500
Date:   Thu, 6 Jan 2022 15:25:28 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, bhe@redhat.com,
        vgoyal@redhat.com, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net
Subject: Re: [PATCH V2] notifier/panic: Introduce panic_notifier_filter
Message-ID: <YddQOFye7Rhr9NDl@rowland.harvard.edu>
References: <20220106200007.112357-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106200007.112357-1-gpiccoli@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 05:00:07PM -0300, Guilherme G. Piccoli wrote:
> The kernel notifier infrastructure allows function callbacks to be
> added in multiple lists, which are then called in the proper time,
> like in a reboot or panic event. The panic_notifier_list specifically
> contains the callbacks that are executed during a panic event. As any
> other notifier list, the panic one has no filtering and all functions
> previously registered are executed.
> 
> The kdump infrastructure, on the other hand, enables users to set
> a crash kernel that is kexec'ed in a panic event, and vmcore/logs
> are collected in such crash kernel. When kdump is set, by default
> the panic notifiers are ignored - the kexec jumps to the crash kernel
> before the list is checked and callbacks executed.
> 
> There are some cases though in which kdump users might want to
> allow panic notifier callbacks to execute _before_ the kexec to
> the crash kernel, for a variety of reasons - for example, users
> may think kexec is very prone to fail and want to give a chance
> to kmsg dumpers to run (and save logs using pstore), or maybe
> some panic notifier is required to properly quiesce some hardware
> that must be used to the crash kernel. For these cases, we have
> the kernel parameter "crash_kexec_post_notifiers".
> 
> But there's a problem: currently it's an "all-or-nothing" situation,
> the kdump user choice is either to execute all panic notifiers or
> none of them. Given that panic notifiers may increase the risk of a
> kdump failure, this is a tough decision and may affect the debug of
> hard to reproduce bugs, if for some reason the user choice is to
> enable panic notifiers, but kdump then fails.
> 
> So, this patch aims to ease this decision: we hereby introduce a filter
> for the panic notifier list, in which users may select specifically
> which callbacks they wish to run, allowing a safer kdump. The allowlist
> should be provided using the parameter "panic_notifier_filter=a,b,..."
> where a, b are valid callback names. Invalid symbols are discarded.
> 
> Currently up to 16 symbols may be passed in this list, we consider
> that this numbers allows enough flexibility (and no matter what
> architecture is used, at most 30 panic callbacks are registered).
> In an experiment using a qemu x86 virtual machine, by default only
> six callbacks are registered in the panic notifier list.
> Once a valid callback name is provided in the list, such function
> is allowed to be registered/unregistered in the panic_notifier_list;
> all other panic callbacks are ignored. Notice that this filter is
> only for the panic notifiers and has no effect in the other notifiers.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index b8251dc0bc0f..04cb9e956058 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -140,10 +163,16 @@ int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
>  		struct notifier_block *n)
>  {
>  	unsigned long flags;
> -	int ret;
> +	int ret = 0;
>  
>  	spin_lock_irqsave(&nh->lock, flags);
> +	if (unlikely(panic_nf_count) && nh == &panic_notifier_list)
> +		if (!is_panic_notifier_filtered(n))
> +			goto panic_filtered_out;

Forget the unlikely(); this is not a hot path.

> +
>  	ret = notifier_chain_register(&nh->head, n);
> +
> +panic_filtered_out:
>  	spin_unlock_irqrestore(&nh->lock, flags);
>  	return ret;
>  }

It would be simpler to do:

	if (!(nh == &panic_notifier_list && panic_nf_count > 0 &&
			is_panic_notifier_filtered(n)))
		ret = notifier_chain_register(&nh->head, n);

If there were special-purpose functions just for registering and 
unregistering callbacks on the panic_notifier_list, the design would be 
cleaner (no need to modify core notifier code).  But making that change 
would mean altering a lot of call sites.  :-(

> @@ -162,10 +194,16 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
>  		struct notifier_block *n)
>  {
>  	unsigned long flags;
> -	int ret;
> +	int ret = 0;
>  
>  	spin_lock_irqsave(&nh->lock, flags);
> +	if (unlikely(panic_nf_count) && nh == &panic_notifier_list)
> +		if (!is_panic_notifier_filtered(n))
> +			goto panic_filtered_out;
> +
>  	ret = notifier_chain_unregister(&nh->head, n);
> +
> +panic_filtered_out:

Same idea here.

Alan Stern
