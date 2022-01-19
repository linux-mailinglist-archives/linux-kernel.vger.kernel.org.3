Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E6493549
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351933AbiASHNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:13:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239456AbiASHNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642576419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M4kjothqTJ5s+8Y5/kdA+MotCrLAw/RluaQw2swROTU=;
        b=fd7kIeU+Uk8Vrgz3IcVxBvL13SqneENR8y82VHx5Qm1AneXZq1ik1fM4b+HV0aVo7Pfvjc
        qDzgEqpPBKQGbCqB0z4fNZAukZWuAglxeTKXYHmU0qD5GsVOAdOqQ/BZcite8CGzmJBaq+
        mt5iFDRUz66iUBCsK6Hs6PmcZ/k4eJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-3plFfdJ8P6qXGD7MO35f6g-1; Wed, 19 Jan 2022 02:13:34 -0500
X-MC-Unique: 3plFfdJ8P6qXGD7MO35f6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C4CC83DD21;
        Wed, 19 Jan 2022 07:13:31 +0000 (UTC)
Received: from localhost (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E60294EC95;
        Wed, 19 Jan 2022 07:13:21 +0000 (UTC)
Date:   Wed, 19 Jan 2022 15:13:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pmladek@suse.com, kernel@gpiccoli.net, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        feng.tang@intel.com, kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Message-ID: <20220119071318.GA4977@MiWiFi-R3L-srv>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114183046.428796-1-gpiccoli@igalia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/14/22 at 03:30pm, Guilherme G. Piccoli wrote:
> The panic_print setting allows users to collect more information in a
> panic event, like memory stats, tasks, CPUs backtraces, etc.
> This is a pretty interesting debug mechanism, but currently the print
> event happens *after* kmsg_dump(), meaning that pstore, for example,
> cannot collect a dmesg with the panic_print information.
...... 

Thanks for the effort.                                                                                                                  

I have some concerns about this patch, and it's still not clear to me
why the thing done in this patch is needed. Hope you don't mind if I ask
stupid question or things have been discussed in the earlier post.

Firstly, let me add some background information and details about the
problem with my understanding, please correct me if anthing is wrong.

Background:
===========
Currently, in panic(), there are 5 different ways to try best to
collect information:
1) Vmcore dumping
   done via kdump, high weight, almost get all information we want;
   need switch to kdump kernel immediately.
2) Panic notifier
   iterating those registered handlers, light weight, information got
   depends on those panic handlers. Try its best after panic, do not reboot.
3) kmsg_dump
   iterating registered dumpers to collect as much kernel log as possible
   to store. E.g on pstore, light weight, only kernel log, do not reboot,
   log can be checked after system reboot.
4)console_flush_on_panic(CONSOLE_FLUSH_PENDING);
   Flush to get the pending logbuf printed out to console.
5)panic_print
   Print out more system info, including all dmesg, task states, mem
   info, etc.
===========


The problem encoutered:
=======
Currently panic_print is done after kmsg_dump. This caused an issue that
system info poked by panic_print to expose to logbuf have no chance to
be collected by kmsg_dump. E.g pstore_dumper registered and handled in
kmsg_dump(), is a light weight and helpful panic info collecting
mechanism, will miss those lots of and helful message poked by
panic_print.
======


> Finally, another decision was to keep 2 panic_print_sys_info(false)
> calls (instead of just bringing it up some code lines and keep a single
> call) due to the panic notifiers: if kdump is not set, currently the
> panic_print information is collected after the notifiers and since
> it's a bit safer this way, we decided to keep it as is, only modifying
> the kdump case as per the previous commit [2] (see more details about
> this discussion also in thread [1]).

About the change, my question is why not packing
console_flush_on_panic(CONSOLE_FLUSH_PENDING) into panic_print(), and
move panic_print() up to be above kmsg_dump(). The pending console
flusing and replaying all flush are all only called inside panic(), and
aim to print out more information.

And adding panic_print_sys_info(false) before kdump might not be a good
idea. Firstly, panicked system is very unstable, kdump need switch to
2nd kernel asap w/o any extra action so that it can survive and collect
tons of information. Added panic_print_sys_info(false) is obviously
unnecessary to kdump, and increase risk to kernel switching.

If I missing anything, please help point out so that I can have a
complete view on this isuse and its fix.

Thanks
Baoquan

> 
> [0] https://lore.kernel.org/lkml/20211230161828.121858-1-gpiccoli@igalia.com
> [1] https://lore.kernel.org/lkml/f25672a4-e4dd-29e8-b2db-f92dd9ff9f8a@igalia.com
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5613b7538f69
> 
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> V3: Added a guard in the 2nd panic_print_sys_info(false) to prevent
> double print - thanks for catching this Petr!
> 
> I didn't implement your final suggestion Petr, i.e., putting the first
> panic_print_sys_info(false) inside the if (!_crash_kexec_post_notifiers)
> block, and the reason is that when we do this, there's 4 cases to consider:
> 
> !kexec_crash_load() && !_crash_kexec_post_notifiers
> kexec_crash_load() && !_crash_kexec_post_notifiers
> kexec_crash_load() && _crash_kexec_post_notifiers
> !kexec_crash_load() && _crash_kexec_post_notifiers
> 
> The 3rd case, which means user enabled kdump and set the post_notifiers
> in the cmdline fails - we end-up not reaching panic_print_sys_info(false)
> in this case, unless we add another variable to track the function call
> and prevent double print. My preference was to keep the first call
> as introduced by commit [2] (mentioned above) and not rely in another
> variable.
> Thanks again for the great reviews,
> 
> Guilherme
> 
> 
> V2: https://lore.kernel.org/lkml/20220106212835.119409-1-gpiccoli@igalia.com
> 
> 
> 
>  .../admin-guide/kernel-parameters.txt         |  4 ++++
>  kernel/panic.c                                | 22 ++++++++++++++-----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a069d8fe2fee..0f5cbe141bfd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3727,6 +3727,10 @@
>  			bit 4: print ftrace buffer
>  			bit 5: print all printk messages in buffer
>  			bit 6: print all CPUs backtrace (if available in the arch)
> +			*Be aware* that this option may print a _lot_ of lines,
> +			so there are risks of losing older messages in the log.
> +			Use this option carefully, maybe worth to setup a
> +			bigger log buffer with "log_buf_len" along with this.
>  
>  	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
>  			Format: <hex>[,nousertaint]
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 41ecf9ab824a..4ae712665f75 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -148,10 +148,13 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
>  }
>  EXPORT_SYMBOL(nmi_panic);
>  
> -static void panic_print_sys_info(void)
> +static void panic_print_sys_info(bool after_kmsg_dumpers)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> -		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +	if (after_kmsg_dumpers) {
> +		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> +			console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +		return;
> +	}
>  
>  	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>  		trigger_all_cpu_backtrace();
> @@ -249,7 +252,7 @@ void panic(const char *fmt, ...)
>  	 * show some extra information on kernel log if it was set...
>  	 */
>  	if (kexec_crash_loaded())
> -		panic_print_sys_info();
> +		panic_print_sys_info(false);
>  
>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
> @@ -283,6 +286,15 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> +	/*
> +	 * If kexec_crash_loaded() is true and we still reach this point,
> +	 * kernel would double print the information from panic_print; so
> +	 * let's guard against that possibility (it happens if kdump users
> +	 * also set crash_kexec_post_notifiers in the command-line).
> +	 */
> +	if (!kexec_crash_loaded())
> +		panic_print_sys_info(false);
> +
>  	kmsg_dump(KMSG_DUMP_PANIC);
>  
>  	/*
> @@ -313,7 +325,7 @@ void panic(const char *fmt, ...)
>  	debug_locks_off();
>  	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>  
> -	panic_print_sys_info();
> +	panic_print_sys_info(true);
>  
>  	if (!panic_blink)
>  		panic_blink = no_blink;
> -- 
> 2.34.1
> 

