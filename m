Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F8547E93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 06:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiFME3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 00:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiFME3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 00:29:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822161CB1A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 21:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6152612C9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071EDC34114;
        Mon, 13 Jun 2022 04:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655094578;
        bh=i49pQc/pJodj7UnEjzLfwNx3xKTBjjxSB1t7FjyvBiE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C6/UVSAS7YCK2CqrwT1O41jmLu6hh5uQpGL0hPN6CArYclWfJxJOPUP+WS1x7aujF
         cf+L5uN2odp9mNo33bcLU68q5ofwYHqsmHs7OsDrQY1ks6xqOQTOw+XmsUfMauSXcN
         4yukCEw3isdWzACQ5EWAsGYFI9jpzNSIjbAiwpRpydP4PC6+CgI7zrvNt802+EjphI
         EHaZ2xUdxmkT87FYS0AYZSULAm3Jk/vHA7W5rCefcINWFJY558DDcEAUMGJJ7EtiYB
         wrIdrGv1s6MOq0Sqt54765n2eWOYeOM7amSnfURqHVVp2E4HdCmgOzyZM4zA3nvJdB
         GIjD4eUkGxh0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9370F5C059E; Sun, 12 Jun 2022 21:29:37 -0700 (PDT)
Date:   Sun, 12 Jun 2022 21:29:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        pmladek@suse.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] 8e274732115f ("printk: extend console_lock for per-console
 locking")
Message-ID: <20220613042937.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
 <87v8t5l39z.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8t5l39z.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:18:56AM +0206, John Ogness wrote:
> On 2022-06-10, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > I have started getting rcutorture shutdown-time hangs when running
> > against recent mainline, and bisected back to the 8e274732115f ("printk:
> > extend console_lock for per-console locking") commit.  These hangs go
> > away (or at least their probability drops dramatically) if I build with
> > CONFIG_PREEMPTION=n -and- CONFIG_NO_HZ=y (not n!), at least assuming
> > that I also boot with "nohz_full=0-N".
> >
> > Attempts to debug using rcutorture's "--gdb" argument result in
> > "[Inferior 1 (process 1) exited normally]", but with the same truncated
> > console-log output as when running without "--gdb".  This suggests
> > that the kernel really did run to completion and halt as expected,
> > but that the shutdown-time printk() output was lost.  Furthermore, if I
> > use the gdb "hbreak" command to set a breakpoint at kernel_power_off(),
> > it really does hit that breakpoint.  This would not happen in the case
> > of a kernel hang.
> >
> > So, given that I can hit that breakpoint, what should I ask gdb to
> > show me?
> 
> If you also compile with CONFIG_GDB_SCRIPTS=y then you can use the
> defined "lx-dmesg" gdb command to see if the messages are in the
> ringbuffer.
> 
> (You may need to add:
> 
> add-auto-load-safe-path /path/to/linux/scripts/gdb/vmlinux-gdb.py
> 
> to your $HOME/.gdbinit)
> 
> But since you are hitting the breakpoint, the messages will be there.
> 
> > Alternatively, this reproduces on a variety of x86 platforms, so you
> > should be able reproduce it as follows [1]:
> >
> > 	git checkout v5.19-rc1
> > 	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE01" --gdb --kconfig "CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y" --trust-make
> >
> > This builds a kernel, boots it, and then tells you how to launch gdb
> > (presumably in some other window).  Once you give launch gdb and give
> > it the suggested commands, the kernel runs for two minutes under qemu,
> > then shuts down.  I used the following gdb commands to set the breakpoint
> > and run the kernel:
> >
> > 	target remote :1234  # suggested by the rcutorture script
> > 	hbreak kernel_power_off  # added by me
> > 	continue  # suggested by the rcutorture script
> 
> Thanks. Nice helper scripts. With this I could easily reproduce the
> issue.

Glad that they worked nicely for you!

> As I suspected, the final printk's cannot direct print because the
> kthread was printing. Using the below patch did seem to address your
> problem. But this is probably not the way forward.

When I apply it, I still lose output, perhaps due to different timing?
Doing the pr_flush(1000, true) just before the call to kernel_power_off()
has been working quite well thus far, though.

							Thanx, Paul

> What I have not figured out is why this problem does not exist when only
> the kthread patch (but not the "extend console_lock" patch) is
> applied. Somehow the console_lock is magically providing some sort of
> synchronization in the end. Or maybe it is just the increased lock
> contention that helps out.
> 
> It seems we need some sort of console_flush_on_panic() for non-panic
> situations that is not as violent as console_flush_on_panic().
> 
> @Petr, does it make sense to add the below patch to mainline? It is only
> marginally helpful because it performs the direct printing in the wrong
> context. Really we need that final pr_emerg("Power down\n") to be a
> successful direct print so that the buffer is fully flushed before
> hitting machine_power_off(). In fact, the below patch could make things
> worse because the printing kthread could take over printing from that
> final pr_emerg().
> 
> John Ogness
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ea3dd55709e7..5950586008fa 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3841,6 +3841,18 @@ static int printk_kthread_func(void *data)
>  		console_kthread_printing_exit();
>  
>  		mutex_unlock(&con->lock);
> +
> +		/*
> +		 * The kernel may have transitioned to a direct printing
> +		 * state, but any printk calls may not have direct printed
> +		 * because this thread was printing its message. Grab and
> +		 * release the console lock to flush out any pending
> +		 * messages on all consoles.
> +		 */
> +		if (allow_direct_printing()) {
> +			console_lock();
> +			console_unlock();
> +		}
>  	}
>  
>  	con_printk(KERN_INFO, con, "printing thread stopped\n");
