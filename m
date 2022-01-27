Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2024449E51C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiA0OvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:51:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38106 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiA0Ou7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:50:59 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 83850210FC;
        Thu, 27 Jan 2022 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643295058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HrbOLvVfTjJxpgNdexz3gqWGKtlu6cxmmtB0KacyOh4=;
        b=DSVBG2qWh2jBwVUSaT0D67GhlUL1i5dchE9+msvt6W1OCEZeZDAxTCsNc9zkn8PJDkA7m/
        hlqcZI/WbEP3SGz+JcbEf3sa+QY7S3Q3WNBChqGoZaLeza6/lFigAdiriRHBk/MrfHSq6j
        Fk+uUhyXmacAugpKXPY1XMpNKjvkNAM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2E55DA3B84;
        Thu, 27 Jan 2022 14:50:58 +0000 (UTC)
Date:   Thu, 27 Jan 2022 15:50:57 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] printk: Avoid livelock with heavy printk during
 panic
Message-ID: <YfKxUQdGn0SmRnB3@alley>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
 <20220126230236.750229-4-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126230236.750229-4-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-26 15:02:35, Stephen Brennan wrote:
> During panic(), if another CPU is writing heavily the kernel log (e.g.
> via /dev/kmsg), then the panic CPU may livelock writing out its messages
> to the console. Note when too many messages are dropped during panic and
> suppress further printk, except from the panic CPU. This could result in
> some important messages being dropped. However, messages are already
> being dropped, so this approach at least prevents a livelock.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
> 
> Notes:
>     v2: Add pr_warn when we suppress printk on non-panic CPU
> 
>  kernel/printk/printk.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 20b4b71a1a07..18107db118d4 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -93,6 +93,12 @@ EXPORT_SYMBOL_GPL(console_drivers);
>   */
>  int __read_mostly suppress_printk;
>  
> +/*
> + * During panic, heavy printk by other CPUs can delay the
> + * panic and risk deadlock on console resources.
> + */
> +int __read_mostly suppress_panic_printk;
> +
>  #ifdef CONFIG_LOCKDEP
>  static struct lockdep_map console_lock_dep_map = {
>  	.name = "console_lock"
> @@ -2228,6 +2234,10 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	if (unlikely(suppress_printk))
>  		return 0;
>  
> +	if (unlikely(suppress_panic_printk) &&
> +	    atomic_read(&panic_cpu) != raw_smp_processor_id())
> +		return 0;
> +
>  	if (level == LOGLEVEL_SCHED) {
>  		level = LOGLEVEL_DEFAULT;
>  		in_sched = true;
> @@ -2613,6 +2623,7 @@ void console_unlock(void)
>  {
>  	static char ext_text[CONSOLE_EXT_LOG_MAX];
>  	static char text[CONSOLE_LOG_MAX];
> +	static int panic_console_dropped;
>  	unsigned long flags;
>  	bool do_cond_resched, retry;
>  	struct printk_info info;
> @@ -2667,6 +2678,11 @@ void console_unlock(void)
>  		if (console_seq != r.info->seq) {
>  			console_dropped += r.info->seq - console_seq;
>  			console_seq = r.info->seq;
> +			if (panic_in_progress() && panic_console_dropped++ > 10) {
> +				suppress_panic_printk = 1;
> +				pr_warn("Too many dropped messages. "
> +				        "Supress messages on non-panic CPUs to prevent livelock.\n");

It looks like the message might be printed more times when
panic_console_dropped++ > 10.

In theory, no message can be lost after we disable printk on another
CPUs. But the code might evolve in the future. Let's make it
more error-proof.

We could use (panic_console_dropped++ == 10) or pr_warn_once() or
both.

I prefer using pr_warn_once() because it looks the most error-proof.


Nit: printk() has exceptions from the 80 chars/line rule.
     The message string should be on a single line. It helps
     to find it using "git grep". I think that even checkpatch.pl
     handles this correctly.


With pr_warn_once() and message in single line:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


PS: I could fix the two problems when pushing to git. But there
    is still time to send v3. I have vacation the following week
    with limited internet access. I am not going to rush it into
    linux before I leave, ...
    
