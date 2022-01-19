Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE47149400D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356853AbiASSi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:38:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40730 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356825AbiASSi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:38:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7094D1F3C5;
        Wed, 19 Jan 2022 18:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642617505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Y5h830ZigcRpnlka0yHJyOSF1gSh6wxN3fyow/u9Wg=;
        b=m+OQieTBArH3lLKFDbZNTvh3lZVP2/uUlbomT9Mx07bPwz3tpgvx0EfTvBRDyBxpLNJ/NX
        Lkqv60+W1cJb4IMSLAB6BrTch6VyLwJm6wEAgDHcvPYGu/Z8pcVR5lNppBEknTp7CaswdH
        qklGkRYS/pMIlhM1/4ZsdJljMl/o5Lk=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4A3FA3B83;
        Wed, 19 Jan 2022 18:38:24 +0000 (UTC)
Date:   Wed, 19 Jan 2022 19:38:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Message-ID: <YehanMqSvL81DLqg@alley>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114183046.428796-1-gpiccoli@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-01-14 15:30:46, Guilherme G. Piccoli wrote:
> The panic_print setting allows users to collect more information in a
> panic event, like memory stats, tasks, CPUs backtraces, etc.
> This is a pretty interesting debug mechanism, but currently the print
> event happens *after* kmsg_dump(), meaning that pstore, for example,
> cannot collect a dmesg with the panic_print information.

The above text is OK.

The below commit message is quite hard to follow. The sentences are very
long and complex. I tend to do the same mistakes. I will try to
suggest some improvements.


> This patch changes that in 2 ways:

> (a) First, after a good discussion with Petr in the mailing-list[0],
> he noticed

The above is not needed ;-) It is better to just describe the problem
and the solution a directive way.

> that one specific setting of panic_print (the console replay,
> bit 5) should not be executed before console proper flushing; hence we
> hereby split the panic_print_sys_info() function in upper and lower
> portions: if the parameter "after_kmsg_dumpers" is passed, only bit 5
> (the console replay thing) is evaluated and the function returns - this
> is the lower portion. Otherwise all other bits are checked and the
> function prints the user required information; this is the upper/earlier
> mode.

The meaning of the boolean parameter might be explained by:

    "panic_print_sys_info() allows to print additional information into the
    kernel log. In addition, it allows to reply the existing log on the
    console first.

    The extra information is useful also when generating crash dump or
    kmsg_dump. But the replay functionality makes sense only at the end
    of panic().

    Allow to distinguish the two situations by a boolean parameter."



> (b) With the above change, we can safely insert a panic_print_sys_info()
> call up some lines, in order kmsg_dump() accounts this new information
> and exposes it through pstore or other kmsg dumpers. Notice that this
> new earlier call doesn't set "after_kmsg_dumpers" so we print the
> information set by user in panic_print, except the console replay that,
> if set, will be executed after the console flushing.

This paragraph is too complicated. The important information here is:

     "panic_print_sys_info() is moved above kmsg_dump(). It allows to dump
     the extra information."

The trick with the boolean is already explained elsewhere. It is not
needed to repeat it in this paragraph.


> Also, worth to notice we needed to guard the panic_print_sys_info(false)
> calls against double print - we use kexec_crash_loaded() helper for that
> (see discussion [1] for more details).

This should be explained together with the reason to call it on two
locations, see below.


> In the first version of this patch we discussed the risks in the
> mailing-list [0], and seems this approach is the least terrible,

the above is not needed.

> despite still having risks of polluting the log with the bulk of
> information that panic_print may bring, losing older messages.
> In order to attenuate that, we've added a warning in the
> kernel-parameters.txt so that users enabling this mechanism consider
> to increase the log buffer size via "log_buf_len" as well.

Again, I would describe the problem and solution a directive way.

    "The additional messages might overwrite the oldest messages when
     the buffer is full. The only reasonable solution is to use large
     enough log buffer. The advice is added into kernel-parameters.txt."



> Finally, another decision was to keep 2 panic_print_sys_info(false)
> calls (instead of just bringing it up some code lines and keep a single
> call) due to the panic notifiers:

The above is too complicated and not important.

> if kdump is not set, currently the
> panic_print information is collected after the notifiers and since
> it's a bit safer this way,

The important information is why it is safer. Honestly, I am still not sure
about this claim. I have checked several notifiers today and they did
not added much stability.


> we decided to keep it as is, only modifying
> the kdump case as per the previous commit [2] (see more details about
> this discussion also in thread [1]).

This does not provide much information. Link to linux-next is bad
idea, see below.


> [0] https://lore.kernel.org/lkml/20211230161828.121858-1-gpiccoli@igalia.com
> [1] https://lore.kernel.org/lkml/f25672a4-e4dd-29e8-b2db-f92dd9ff9f8a@igalia.com
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5613b7538f69

linux-next is regularly rebased and Andrew's patches are always newly
imported from quilt. The commit probably already has another hash.

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

But then it does not make sense to call panic_print_sys_info(false)
from both locations.

You say that it is called after kexec_post_notifiers because
it is more safe. If this is true then it would make sense to
always call it after the notifiers when _crash_kexec_post_notifiers
is set.

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

You could do:

	if (!_crash_kexec_post_notifiers) {
		if (kexec_crash_loaded())
			panic_print_sys_info(false);

		__crash_kexec(NULL);
		smp_send_stop();
	} else {
		crash_smp_send_stop();
	}

	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);

	/* Just negate the condition here */
	if (_crash_kexec_post_notifiers || !kexec_crash_loaded())
		panic_print_sys_info(false);

> diff --git a/kernel/panic.c b/kernel/panic.c
> index 41ecf9ab824a..4ae712665f75 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
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

Too many words. Most of it is obvious from the code. The most important
information is why it is called after the notifiers when the crash
kernel is not loaded. And why it does not depend on _crash_kexec_post_notifiers
setting.


> +	if (!kexec_crash_loaded())
> +		panic_print_sys_info(false);
> +
>  	kmsg_dump(KMSG_DUMP_PANIC);
>  
>  	/*

Best Regards,
Petr
