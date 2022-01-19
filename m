Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEA0493A02
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354399AbiASMBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:01:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49348 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbiASMBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:01:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7DDF01F38B;
        Wed, 19 Jan 2022 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642593668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMd+jDzPfFQgxkzSCXgmQcSxD69OBufpxj9V/lK7IfI=;
        b=GAQiAo3iUwAGJxxVLc8jyo7I5AUA+1v4L1tBNqIZnew5cS7dPuHDKoExdHb4hx2VV2uub7
        /Zy1xjDWwYQlOa47ag+lTStq0AOdhPLo/+YeNu5/zWsG9jD+pKgqCBFxIDl7wgvBRxX8to
        TMIQ7rbCC/roZonqbIa7pWyUhKau7Zw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3340DA3B83;
        Wed, 19 Jan 2022 12:01:08 +0000 (UTC)
Date:   Wed, 19 Jan 2022 13:01:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: count warnings and make count accessible to
 userspace
Message-ID: <Yef9hPon8s8swQMn@alley>
References: <20220118060431.1368538-1-jsperbeck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118060431.1368538-1-jsperbeck@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Andrew into Cc. Most changes in panic.c go via his tree.

On Tue 2022-01-18 06:04:31, John Sperbeck wrote:
> When testing, it's common to consider a warning to be a test failure,
> but it's currently awkward to determine which of multiple sequential
> tests is responsible for triggering a warning.  Scraping dmesg or
> /var/log/messages is somewhat expensive and error-prone.  Setting
> panic_on_warn is reliable, but spoils test runs for minor issues.
> Looking at the taint bit is also reliable, but only works for a single
> warning.
>
> We can track the warning count and expose it as a sysfs file.  Test
> infrastructures can snapshot the value before and after a test.  If
> the value changes, they can do more expensive things like extracting
> logs.

The counter makes sense. It might be useful even for normal debugging.
It would be nice to show the value in the log.

> Signed-off-by: John Sperbeck <jsperbeck@google.com>
> ---
>  kernel/panic.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index cefd7d82366f..5262c2a0ebf4 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -571,6 +571,8 @@ struct warn_args {
>  	va_list args;
>  };
>  
> +static atomic_t  __maybe_unused warn_counter;
> +
>  void __warn(const char *file, int line, void *caller, unsigned taint,
>  	    struct pt_regs *regs, struct warn_args *args)
>  {
> @@ -612,6 +614,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  
>  	/* Just a warning, don't kill lockdep. */
>  	add_taint(taint, LOCKDEP_STILL_OK);
> +
> +	atomic_inc(&warn_counter);
>  }
>  
>  #ifndef __WARN_FLAGS
> @@ -667,6 +671,7 @@ static __init int register_warn_debugfs(void)
>  	/* Don't care about failure */
>  	debugfs_create_file_unsafe("clear_warn_once", 0200, NULL, NULL,
>  				   &clear_warn_once_fops);
> +	debugfs_create_atomic_t("warn_count", 0444, NULL, &warn_counter);

Is the sysfs interface really important for you use case, please?
Would the value in the log be enough?

Anyway, we already count the number WARN() reports. It is quite hidden
and hashed in init_oops_id()/print_oops_end_marker().

A solution would be to make this hidden counter more explicit.
Something like:

diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..8ac19124ceb4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -537,13 +537,12 @@ void oops_enter(void)
  * 64-bit random ID for oopses:
  */
 static u64 oops_id;
+static int oops_cnt;
 
 static int init_oops_id(void)
 {
 	if (!oops_id)
 		get_random_bytes(&oops_id, sizeof(oops_id));
-	else
-		oops_id++;
 
 	return 0;
 }
@@ -552,7 +551,9 @@ late_initcall(init_oops_id);
 static void print_oops_end_marker(void)
 {
 	init_oops_id();
-	pr_warn("---[ end trace %016llx ]---\n", (unsigned long long)oops_id);
+	oops_cnt++;
+	pr_warn("---[ end trace %016llx:%d ]---\n",
+		(unsigned long long)oops_id, oops_cnt);
 }
 
 /*


The report would like like:

[ 1871.476204] WARNING: CPU: 2 PID: 2003 at samples/livepatch/livepatch-sample.c:60 livepatch_init+0x11/0x20 [livepatch_sample]
[ 1871.476905] Modules linked in: livepatch_sample(EK+) [last unloaded: livepatch_sample]
[ 1871.477509] CPU: 2 PID: 2003 Comm: modprobe Tainted: G        W   E K   5.16.0-default+ #312
[ 1871.478175] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 1871.478858] RIP: 0010:livepatch_init+0x11/0x20 [livepatch_sample]
[...]
[ 1871.489801] hardirqs last disabled at (9188): [<ffffffffb217aa4e>] vprintk_emit+0x21e/0x2b0
[ 1871.489803] softirqs last  enabled at (9096): [<ffffffffb3000364>] __do_softirq+0x364/0x4ab
[ 1871.489805] softirqs last disabled at (9083): [<ffffffffb20efb5d>] irq_exit_rcu+0x10d/0x120
[ 1871.489807] ---[ end trace a19f0f55262cfcc8:2 ]---

Best Regards,
Petr
