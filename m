Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEE5547A55
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbiFLNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbiFLNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:23:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A98C2F03B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 06:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC6B3CE0930
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 13:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F83C34115;
        Sun, 12 Jun 2022 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655040183;
        bh=0weVAGbcwRL32E/exKQbawtLkyMMFCwF+cP6B34Yq0k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mUfsnRXlQerGGg8u3tDaTaDr5PYIahxuLMG8yL/WfouV9tyJgTWYqTWiCYAOd+PJL
         HA3gtH+34spaHTjw07N/Ro8LEGbTCbIt0UUm/R9oKdZcuTlO1EjZS/hrrmVRXeFXxp
         eeA+NPIu3/GnQkyLvuSd6kNCjE/xHv2Z3UAd+2bd1IrsiTT9Ji1QfR8Y95zP/jDciL
         syGmb38Daw4vRmN/dSSI/kb+hXt98+G7QUhCkHmnOWk4iTZf2Zu6/agzRrzs89ckl7
         k1tJGw6fDQDfq59ImeMuXrkxRaeyXqMhz9kQKx0wowLoEWBbmKHUeQhnJJvF3ISpSl
         SvCsjLYcMHdLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7C36F5C02F9; Sun, 12 Jun 2022 06:23:02 -0700 (PDT)
Date:   Sun, 12 Jun 2022 06:23:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     john.ogness@linutronix.de
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org, pmladek@suse.com
Subject: Re: [BUG] 8e274732115f ("printk: extend console_lock for per-console
 locking")
Message-ID: <20220612132302.GA873785@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 01:50:38PM -0700, Paul E. McKenney wrote:
> Hello, John,
> 
> I have started getting rcutorture shutdown-time hangs when running
> against recent mainline, and bisected back to the 8e274732115f ("printk:
> extend console_lock for per-console locking") commit.  These hangs go
> away (or at least their probability drops dramatically) if I build with
> CONFIG_PREEMPTION=n -and- CONFIG_NO_HZ=y (not n!), at least assuming
> that I also boot with "nohz_full=0-N".
> 
> Attempts to debug using rcutorture's "--gdb" argument result in
> "[Inferior 1 (process 1) exited normally]", but with the same truncated
> console-log output as when running without "--gdb".  This suggests
> that the kernel really did run to completion and halt as expected,
> but that the shutdown-time printk() output was lost.  Furthermore, if I
> use the gdb "hbreak" command to set a breakpoint at kernel_power_off(),
> it really does hit that breakpoint.  This would not happen in the case
> of a kernel hang.
> 
> So, given that I can hit that breakpoint, what should I ask gdb to
> show me?
> 
> Alternatively, this reproduces on a variety of x86 platforms, so you
> should be able reproduce it as follows [1]:
> 
> 	git checkout v5.19-rc1
> 	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE01" --gdb "CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y" --trust-make
> 
> This builds a kernel, boots it, and then tells you how to launch gdb
> (presumably in some other window).  Once you give launch gdb and give
> it the suggested commands, the kernel runs for two minutes under qemu,
> then shuts down.  I used the following gdb commands to set the breakpoint
> and run the kernel:
> 
> 	target remote :1234  # suggested by the rcutorture script
> 	hbreak kernel_power_off  # added by me
> 	continue  # suggested by the rcutorture script
> 
> Or leave out the "gdb" if you prefer some other debugging approach.

And the patch below takes care of things in (admittedly quite light)
testing thus far.  What it does is add ten seconds of pure delay before
rcutorture shuts down the system.  Presumably, this delay gives printk()
the time that it needs to flush its buffers.  In the configurations
that I have tested thus far, anyway.

So what should I be doing instead?

o	console_flush_on_panic() seems like strong medicine, but might
	be the right thing to do.  The bit about proceeding even though
	it failed to acquire the lock doesn't look good for non-panic use.

o	printk_trigger_flush() has an attractive name, but it looks
	like it only just starts the flush rather than waiting for it
	to finish.

o	pr_flush(1000, true) looks quite interesting, and also seems to
	work in a few quick tests, so I will continue playing with that.

Right now, I am putting this immediately before the kernel/torture.c
call to kernel_power_off().  I could argue that kernel_power_off()
should flush the printk() buffers as part of a "clean system power_off",
to quote the kernel_power_off() header comment.  Or is there some reason
why kernel_power_off() should leave printk() buffers unflushed?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/torture.c b/kernel/torture.c
index 789aeb0e1159c..bbdec930ea21f 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -651,6 +651,7 @@ static int torture_shutdown(void *arg)
 		VERBOSE_TOROUT_STRING("No torture_shutdown_hook(), skipping.");
 	if (ftrace_dump_at_shutdown)
 		rcu_ftrace_dump(DUMP_ALL);
+	schedule_timeout_uninterruptible(HZ * 10);
 	kernel_power_off();	/* Shut down the system. */
 	return 0;
 }
