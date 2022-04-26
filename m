Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534C650FBE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349515AbiDZL2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiDZL2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E394ECCF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B09617F1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32868C385AA;
        Tue, 26 Apr 2022 11:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650972301;
        bh=d2RBMaudaF4i1bmeXBeYQjnyibgadA2VLLfhb9sPHdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejJ/8LO5aFB/QCDDfjoFwI8nVxdgS4O7wtMmRWGscS4kmNQbCUxTKtHwHJMTDHGl/
         vXDbfd5vwB92k1jDMY8SvKpgYFMu5ZwcR7z9BqRCX/O/O4Ijr6uQ1NKGqKlkz2f4Qu
         UGZEmRvBZlIGbEorGfUnZGrcDA3gsZUGObv8auW0=
Date:   Tue, 26 Apr 2022 13:24:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] sysrq: do not omit current cpu when showing backtrace of
 all active CPUs
Message-ID: <YmfWipwuVlAt5Meq@kroah.com>
References: <20220117154300.2808-1-changbin.du@gmail.com>
 <YeWQPVy30EFTQaoq@kroah.com>
 <20220118003358.6pcowtbds44dntls@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118003358.6pcowtbds44dntls@mail.google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 08:33:58AM +0800, Changbin Du wrote:
> Hi, Greg,
> On Mon, Jan 17, 2022 at 04:50:21PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Jan 17, 2022 at 11:43:00PM +0800, Changbin Du wrote:
> > > The backtrace of current CPU also should be printed as it is active. This
> > > change add stack trace for current CPU and print a hint for idle CPU for
> > > the generic workqueue based printing. (x86 already does this)
> > 
> > How does x86 already do this?  What processors do not currently do this?
> >
> 
> The default hevaiour on x86 is as below:
>   1) The current CPU (active) is printed.
>   2) There is a hint for idle cpu. This is helpful for me to distingusih whether
>      the not printed cpu is in idle or a problem of stacktrace itself (which
>      really happed on me).
> 
> root@ubuntu:~# echo l > /proc/sysrq-trigger
> [   34.622117] sysrq: Show backtrace of all active CPUs
> [   34.622573] NMI backtrace for cpu 0
> [   34.622576] CPU: 0 PID: 1145 Comm: bash Not tainted 5.16.0+ #120 8a8a684efa076f0b679fc9dbfc6ff35722bf429e
> [   34.622579] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [   34.622584] Call Trace:
> [   34.622588]  <TASK>
> [   34.622589]  dump_stack_lvl+0x45/0x59
> [   34.622598]  nmi_cpu_backtrace.cold+0x30/0x76
> [   34.622600]  ? lapic_can_unplug_cpu+0x80/0x80
> [   34.622605]  nmi_trigger_cpumask_backtrace+0x104/0x130
> [   34.622610]  __handle_sysrq.cold+0x43/0x129
> [   34.622614]  write_sysrq_trigger+0x3f/0x50
> [   34.622618]  proc_reg_write+0x55/0xa0
> [   34.622622]  vfs_write+0xe4/0x320
> [   34.622627]  ksys_write+0x68/0xe0
> [   34.622631]  do_syscall_64+0x3b/0xc0
> [   34.622634]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   34.622637] RIP: 0033:0x7f51db009c27
> [   34.622640] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 284
> [   34.622641] RSP: 002b:00007ffcef29e828 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   34.622644] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f51db009c27
> [   34.622646] RDX: 0000000000000002 RSI: 00005556146896f0 RDI: 0000000000000001
> [   34.622647] RBP: 00005556146896f0 R08: 000000000000000a R09: 0000000000000000
> [   34.622648] R10: 00007f51db0a7040 R11: 0000000000000246 R12: 0000000000000002
> [   34.622649] R13: 00007f51db0e36c0 R14: 00007f51db0e44a0 R15: 00007f51db0e38a0
> [   34.622657]  </TASK>
> [   34.622658] Sending NMI from CPU 0 to CPUs 1-7:
> [   34.622676] NMI backtrace for cpu 7
> [   34.622678] CPU: 7 PID: 1187 Comm: unattended-upgr Not tainted 5.16.0+ #120 8a8a684efa076f0b679fc9dbfc6ff35722bf429e
> [   34.622681] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [   34.622682] RIP: 0010:kmem_cache_free+0x27b/0x480
> [   34.622685] Code: 01 59 01 4c 8d 34 10 48 8b 35 a1 01 59 01 49 c1 ee 0c 49 c1 e6 06 49 01 f6 49 8b 46 08 48 8d 50 ff a8 01 4c 0f 45 f2 49 8b 06 <f6> c4 02 0f 84 20 01 00 00 4d 85 f6 0f8
> [   34.622687] RSP: 0018:ffffc90000e2bdc0 EFLAGS: 00000202
> [   34.622689] RAX: 000fffffc0010200 RBX: ffff888009754000 RCX: 0000000000000000
> [   34.622690] RDX: ffffea000025d400 RSI: ffffea0000000000 RDI: ffff888009754000
> [   34.622691] RBP: ffffc90000e2be08 R08: 000000080fac04bd R09: 0000000000000000
> [   34.622692] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81436575
> [   34.622694] R13: ffff888005479100 R14: ffffea000025d400 R15: 0000000000000000
> [   34.622695] FS:  00007fc9e5b1c740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   34.622696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   34.622697] CR2: 00007fc9dba14024 CR3: 0000000028f04002 CR4: 0000000000370ee0
> [   34.622699] Call Trace:
> [   34.622700]  <TASK>
> [   34.622702]  user_path_at_empty+0x45/0x50
> [   34.622705]  vfs_statx+0x74/0x130
> [   34.622708]  __do_sys_newfstatat+0x31/0x70
> [   34.622710]  ? lock_release+0x148/0x430
> [   34.622714]  ? syscall_enter_from_user_mode+0x17/0x60
> [   34.622716]  ? trace_hardirqs_on+0x2b/0xe0
> [   34.622719]  ? syscall_enter_from_user_mode+0x17/0x60
> [   34.622720]  do_syscall_64+0x3b/0xc0
> [   34.622722]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   34.622724] RIP: 0033:0x7fc9e5c260ae
> [   34.622726] Code: 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 07 00 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 41 89 ca b8 06 01 00 00 0f 05 <3d> 00 f0 ff ff 77 0b 31 c0 c3 0f 1f 841
> [   34.622727] RSP: 002b:00007ffed7182998 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
> [   34.622729] RAX: ffffffffffffffda RBX: 00000000021f8ab0 RCX: 00007fc9e5c260ae
> [   34.622730] RDX: 00007ffed71829a0 RSI: 0000000001d90230 RDI: 00000000ffffff9c
> [   34.622731] RBP: 00007ffed7182ad0 R08: 0000000001d90230 R09: 0000000000000064
> [   34.622732] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffed7182ae0
> [   34.622733] R13: 00007ffed7182ac0 R14: 00007ffed7182b50 R15: 00000000ffffff00
> [   34.622736]  </TASK>
> [   34.622736] NMI backtrace for cpu 5 skipped: idling at default_idle+0x10/0x20
> [   34.622743] NMI backtrace for cpu 4 skipped: idling at default_idle+0x10/0x20
> [   34.622746] NMI backtrace for cpu 6 skipped: idling at default_idle+0x10/0x20
> [   34.622751] NMI backtrace for cpu 3 skipped: idling at default_idle+0x10/0x20
> [   34.622756] NMI backtrace for cpu 2 skipped: idling at default_idle+0x10/0x20
> [   34.622762] NMI backtrace for cpu 1 skipped: idling at default_idle+0x10/0x20
> 
> 
> > > Now it looks like below:
> > > [  279.401567] sysrq: Show backtrace of all active CPUs
> > > [  279.407234] sysrq: CPU5:
> > > [  279.407505] Call Trace:
> > > [  279.408789] [<ffffffff8000606c>] dump_backtrace+0x2c/0x3a
> > > [  279.411698] [<ffffffff800060ac>] show_stack+0x32/0x3e
> > > [  279.411809] [<ffffffff80542258>] sysrq_handle_showallcpus+0x4c/0xc6
> > > [  279.411929] [<ffffffff80542f16>] __handle_sysrq+0x106/0x26c
> > > [  279.412034] [<ffffffff805436a8>] write_sysrq_trigger+0x64/0x74
> > > [  279.412139] [<ffffffff8029cd48>] proc_reg_write+0x8e/0xe2
> > > [  279.412252] [<ffffffff8021a8f8>] vfs_write+0x90/0x2be
> > > [  279.412362] [<ffffffff8021acd2>] ksys_write+0xa6/0xce
> > > [  279.412467] [<ffffffff8021ad24>] sys_write+0x2a/0x38
> > > [  279.412689] [<ffffffff80003ff8>] ret_from_syscall+0x0/0x2
> > > [  279.417173] sysrq: CPU6: backtrace skipped as idling
> > > [  279.417185] sysrq: CPU4: backtrace skipped as idling
> > > [  279.417187] sysrq: CPU0: backtrace skipped as idling
> > > [  279.417181] sysrq: CPU7: backtrace skipped as idling
> > > [  279.417190] sysrq: CPU1: backtrace skipped as idling
> > > [  279.417193] sysrq: CPU3: backtrace skipped as idling
> > > [  279.417219] sysrq: CPU2:
> > > [  279.419179] Call Trace:
> > > [  279.419440] [<ffffffff8000606c>] dump_backtrace+0x2c/0x3a
> > > [  279.419782] [<ffffffff800060ac>] show_stack+0x32/0x3e
> > > [  279.420015] [<ffffffff80542b30>] showacpu+0x5c/0x96
> > > [  279.420317] [<ffffffff800ba71c>] flush_smp_call_function_queue+0xd6/0x218
> > > [  279.420569] [<ffffffff800bb438>] generic_smp_call_function_single_interrupt+0x14/0x1c
> > > [  279.420798] [<ffffffff800079ae>] handle_IPI+0xaa/0x13a
> > > [  279.421024] [<ffffffff804dcb92>] riscv_intc_irq+0x56/0x70
> > > [  279.421274] [<ffffffff80a05b70>] generic_handle_arch_irq+0x6a/0xfa
> > > [  279.421518] [<ffffffff80004006>] ret_from_exception+0x0/0x10
> > > [  279.421750] [<ffffffff80096492>] rcu_idle_enter+0x16/0x1e
> > > 
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > ---
> > >  drivers/tty/sysrq.c | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > > index bbfd004449b5..34cfdda4aff5 100644
> > > --- a/drivers/tty/sysrq.c
> > > +++ b/drivers/tty/sysrq.c
> > > @@ -232,8 +232,10 @@ static void showacpu(void *dummy)
> > >  	unsigned long flags;
> > >  
> > >  	/* Idle CPUs have no interesting backtrace. */
> > > -	if (idle_cpu(smp_processor_id()))
> > > +	if (idle_cpu(smp_processor_id())) {
> > > +		pr_info("CPU%d: backtrace skipped as idling\n", smp_processor_id());
> > >  		return;
> > > +	}
> > 
> > Why do you need to see the skipped processor?  Can't you just infer this
> > from a lack of calltrace on the other cpus?  What needs to see this
> > information?
> > 
> > >  
> > >  	raw_spin_lock_irqsave(&show_lock, flags);
> > >  	pr_info("CPU%d:\n", smp_processor_id());
> > > @@ -260,10 +262,13 @@ static void sysrq_handle_showallcpus(int key)
> > >  
> > >  		if (in_hardirq())
> > >  			regs = get_irq_regs();
> > > -		if (regs) {
> > > -			pr_info("CPU%d:\n", smp_processor_id());
> > > +
> > > +		pr_info("CPU%d:\n", smp_processor_id());
> > > +		if (regs)
> > >  			show_regs(regs);
> > > -		}
> > > +		else
> > > +			show_stack(NULL, NULL, KERN_INFO);
> > > +
> > 
> > Why is this change needed as well?
> > 
> On the contrary, I wonder why the current cpu is skipped? Isn't it active?

Ok, let's try this and see if people complain :)

