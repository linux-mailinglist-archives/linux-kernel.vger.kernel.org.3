Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B916554A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348218AbiFVMzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiFVMzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3977FBF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6C6E619BA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2E0C34114;
        Wed, 22 Jun 2022 12:55:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Y/EvvntV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655902535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z1QhB/dAFSPHO7nfrU3phSHya1Kkz+Az4CmOoNx2RXg=;
        b=Y/EvvntVPzbJTWdi5dgoAfjtXicQnsAboWYKC6C5JJtGD+wCU0Kqmzz7DtWEV2BF3DB305
        doRNzCja95MIVnGmzpFqJp7QaN+Q4WmhrIIzhub5h3E3so2DT4SWiNWeWUoNaJ5ldz/ha4
        l+sGK+8Xgm815QvwbWyqzlpr4HpdfUE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e6935ca9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 22 Jun 2022 12:55:35 +0000 (UTC)
Date:   Wed, 22 Jun 2022 14:55:32 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Subject: Re: [PATCH v3] printk: allow direct console printing to be enabled
 always
Message-ID: <YrMRRB0RbyDIyLem@zx2c4.com>
References: <Yq+xGcBO06ILMUFy@zx2c4.com>
 <20220619233302.601092-1-Jason@zx2c4.com>
 <YrGWg2E8Z8RxeyEU@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrGWg2E8Z8RxeyEU@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:59:31AM +0200, Jason A. Donenfeld wrote:
> Hey John, Petr, Sergey,
> 
> On Mon, Jun 20, 2022 at 01:33:02AM +0200, Jason A. Donenfeld wrote:
> > In 5.19, there are some changes in printk message ordering /
> > interleaving which leads to confusion. The most obvious (and benign)
> > example appears on system boot, in which the "Run /init as init process"
> > message gets intermixed with the messages that init actually writes() to
> > stdout. For example, here's a snippet from build.wireguard.com:
> > 
> >     [    0.469732] Freeing unused kernel image (initmem) memory: 4576K
> >     [    0.469738] Write protecting the kernel read-only data: 10240k
> >     [    0.473823] Freeing unused kernel image (text/rodata gap) memory: 2044K
> >     [    0.475228] Freeing unused kernel image (rodata/data gap) memory: 1136K
> >     [    0.475236] Run /init as init process
> > 
> >         WireGuard Test Suite on Linux 5.19.0-rc2+ x86_64
> > 
> >     [+] Mounting filesystems...
> >     [+] Module self-tests:
> >      *  allowedips self-tests: pass
> >      *  nonce counter self-tests: pass
> >      *  ratelimiter self-tests: pass
> >     [+] Enabling logging...
> >     [+] Launching tests...
> >     [    0.475237]   with arguments:
> >     [    0.475238]     /init
> >     [    0.475238]   with environment:
> >     [    0.475239]     HOME=/
> >     [    0.475240]     TERM=linux
> >     [+] ip netns add wg-test-46-0
> >     [+] ip netns add wg-test-46-1
> > 
> > Before the "with arguments:" and such would print prior to the
> > "wireguard test suite on linux 5.19" banner. Now it shows after.
> > 
> > I see the same thing with "Freeing unused kernel image (text/rodata gap)
> > memory" printing interwoven into the console of my initramfs on my
> > laptop. And so forth.
> > 
> > But the bigger issue for me is that it makes it very confusing to
> > interpret CI results later on. Prior, I would nice a nice correlation
> > of:
> > 
> > [+] some userspace command
> > [    1.2345 ] some kernel log output
> > [+] some userspace command
> > [    1.2346 ] some kernel log output
> > [+] some userspace command
> > [    1.2347 ] some kernel log output
> > 
> > Now, the kernel log outputs are all over the place and out of order with
> > the sequence of commands. This makes debugging issues somewhat tricky,
> > because post hoc ergo propter hoc winds up being a good intuition to
> > follow when tracking down bugs, and now the post hoc part is muddled.
> > 
> > This is caused by threaded printk. In order to restore this in debugging
> > sessions and in CI, this commit adds the ability to always use direct
> > printk, either set by default at compile time, or overridden with a
> > runtime command line switch.
> > 
> > Cc: John Ogness <john.ogness@linutronix.de>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Marco Elver <elver@google.com>
> > Fixes: 09c5ba0aa2fc ("printk: add kthread console printers")
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
> >  kernel/printk/printk.c                          | 11 +++++++++++
> >  lib/Kconfig.debug                               | 12 ++++++++++++
> >  3 files changed, 30 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 2522b11e593f..04cec66802d1 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4424,6 +4424,13 @@
> >  	printk.time=	Show timing data prefixed to each printk message line
> >  			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
> >  
> > +	printk.direct=	Rather than using kthreads for printk output, always
> > +			attempt to write to the console immediately. This has
> > +			performance implications, but will result in a more
> > +			faithful ordering and interleaving with other
> > +			processes writing to the console.
> > +			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
> > +
> >  	processor.max_cstate=	[HW,ACPI]
> >  			Limit processor to maximum C-state
> >  			max_cstate=9 overrides any DMI blacklist limit.
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index b095fb5f5f61..b7f8f2904f2c 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -178,6 +178,14 @@ static int __init control_devkmsg(char *str)
> >  }
> >  __setup("printk.devkmsg=", control_devkmsg);
> >  
> > +static bool printk_direct_only __initdata = IS_ENABLED(CONFIG_PRINTK_DIRECT);
> > +
> > +static int __init control_printk_direct_only(char *str)
> > +{
> > +	return kstrtobool(str, &printk_direct_only);
> > +}
> > +__setup("printk.direct=", control_printk_direct_only);
> > +
> >  char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
> >  #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
> >  int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
> > @@ -3605,6 +3613,9 @@ static int __init printk_activate_kthreads(void)
> >  {
> >  	struct console *con;
> >  
> > +	if (printk_direct_only)
> > +		return 0;
> > +
> >  	console_lock();
> >  	printk_kthreads_available = true;
> >  	for_each_console(con)
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 2e24db4bff19..1acfb4971ec7 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -35,6 +35,18 @@ config PRINTK_CALLER
> >  	  no option to enable/disable at the kernel command line parameter or
> >  	  sysfs interface.
> >  
> > +config PRINTK_DIRECT
> > +	bool "Attempt to flush printk output immediately"
> > +	depends on PRINTK
> > +	help
> > +	  Rather than using kthreads for printk output, always attempt to write
> > +	  to the console immediately. This has performance implications, but
> > +	  will result in a more faithful ordering and interleaving with other
> > +	  processes writing to the console.
> > +
> > +	  Say N here unless you really need this. This may also be controlled
> > +	  at boot time with printk.direct=0/1.
> > +
> >  config STACKTRACE_BUILD_ID
> >  	bool "Show build ID information in stacktraces"
> >  	depends on PRINTK
> > -- 
> > 2.35.1
> > 
> 
> From reading the other thread with Linus about console driver locks, it
> sounds like there's a good chance threaded printk will be reverted
> wholesale, which would of course fix this regression here. But before
> that happens, could you make sure this v3 gets applied, so that whenever
> threaded printk is reintroduced, I don't run into the same problem and
> repeat all the same motions to draw this up again?
> 
> Thanks,
> Jason

Another thing I'm finding is that without this patch, printing various
messages from userspace, and then calling reboot() results in those
messages never actually making it to the console, making my test suite
panic() handler kind of useless.

This patch presumably fixes it, since it becomes direct. But maybe if
people don't want direct mode, but still don't want messages to get lost
on reboot, you might consider some kind of flushing?

Jason
