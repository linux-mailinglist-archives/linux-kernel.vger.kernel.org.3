Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993BE56CE7D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiGJKC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 06:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 06:02:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F42E644C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 03:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C3DD4CE0A2B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 10:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B583C3411E;
        Sun, 10 Jul 2022 10:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657447366;
        bh=CtswWxU1FinXHgGCbZzjkEJjLoNfuK7FKwCH91rIYeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYo242d7WGCnY4hxZG3pQpH/3UgmS6bRmMpBW/hyMQbm6keXf4DGcRCctjnkB7Gsi
         svNAoz6AnxZCKziB9ILdD0BFrkmgZ1UOcUiZmtO6fv38nLu7bPQmXD/XPW/P1n+eFN
         6kU9Rzfpq5zBJI8Xn2Ohm1CbQbqvjakc3Xm5buk4=
Date:   Sun, 10 Jul 2022 12:02:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     duoming@zju.edu.cn
Cc:     linux-staging@lists.linux.dev, davem@davemloft.net,
        alexander.deucher@amd.com, kuba@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: Fix sleep in atomic context bug in
 dm_fsync_timer_callback
Message-ID: <YsqjwVJWifOpo2ws@kroah.com>
References: <20220623055912.84138-1-duoming@zju.edu.cn>
 <YrQ2gXtX2FOkyNgu@kroah.com>
 <1ddff589.e0f1.181944e6c1a.Coremail.duoming@zju.edu.cn>
 <482a0dc6.10f76.1819a2a3546.Coremail.duoming@zju.edu.cn>
 <YrbVpbKvqdYuY84C@kroah.com>
 <3cd6bfda.380db.181e77ece60.Coremail.duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cd6bfda.380db.181e77ece60.Coremail.duoming@zju.edu.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 05:44:16PM +0800, duoming@zju.edu.cn wrote:
> Hello,
> 
> On Sat, 25 Jun 2022 11:30:13 +0200 Greg KH wrote:
> 
> > On Sat, Jun 25, 2022 at 05:21:06PM +0800, duoming@zju.edu.cn wrote:
> > > Hello,
> > > 
> > > > > On Thu, Jun 23, 2022 at 01:59:12PM +0800, Duoming Zhou wrote:
> > > > > > There are sleep in atomic context bugs when dm_fsync_timer_callback is
> > > > > > executing. The root cause is that the memory allocation functions with
> > > > > > GFP_KERNEL or GFP_NOIO parameters are called in dm_fsync_timer_callback
> > > > > > which is a timer handler. The call paths that could trigger bugs are
> > > > > > shown below:
> > > > > > 
> > > > > >     (interrupt context)
> > > > > > dm_fsync_timer_callback
> > > > > >   write_nic_byte
> > > > > >     kzalloc(sizeof(data), GFP_KERNEL); //may sleep
> > > > > >     usb_control_msg
> > > > > >       kmalloc(.., GFP_NOIO); //may sleep
> > > > > >   write_nic_dword
> > > > > >     kzalloc(sizeof(data), GFP_KERNEL); //may sleep
> > > > > >     usb_control_msg
> > > > > >       kmalloc(.., GFP_NOIO); //may sleep
> > > > > > 
> > > > > > This patch uses delayed work to replace timer and moves the operations
> > > > > > that may sleep into the delayed work in order to mitigate bugs.
> > > > > > 
> > > > > > Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
> > > > > > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > >   - Use delayed work to replace timer.
> > > > > 
> > > > > Did you test this with real hardware to verify it still works?
> > > > 
> > > > I am testing this and I will give you feedback within one or two days.
> > > 
> > > Do you know what vendor id and device id use the r8192u_usb driver?
> > 
> > The vendor/device ids are in the driver itself.  Also in the output of
> > modinfo:
> > 	❯ modinfo drivers/staging/rtl8192u/r8192u_usb.ko | grep alias
> > 	alias:          usb:v043Ep7A01d*dc*dsc*dp*ic*isc*ip*in*
> > 	alias:          usb:v5A57p0290d*dc*dsc*dp*ic*isc*ip*in*
> > 	alias:          usb:v2001p3301d*dc*dsc*dp*ic*isc*ip*in*
> > 	alias:          usb:v1740p9201d*dc*dsc*dp*ic*isc*ip*in*
> > 	alias:          usb:v0DF6p0031d*dc*dsc*dp*ic*isc*ip*in*
> > 	alias:          usb:v050Dp805Ed*dc*dsc*dp*ic*isc*ip*in*
> > 	alias:          usb:v07AAp0043d*dc*dsc*dp*ic*isc*ip*in*
> > 	alias:          usb:v0BDAp8709d*dc*dsc*dp*ic*isc*ip*in*
> > 
> > see the "v" and "p" portions of the alias string. 
> 
> I am sorry for the delay. This is a really hard work, but I successfully test it.
> This patch could run well.
> 
> The following is the report of the bug:
> 
> [  104.055321][    C3] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> [  104.075499][    C3] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
> [  104.076346][    C3] preempt_count: 100, expected: 0
> [  104.076938][    C3] RCU nest depth: 0, expected: 0
> [  104.076938][    C3] Preemption disabled at:
> [  104.078194][    C3] [<ffffffff846000a0>] __do_softirq+0xa0/0x544
> [  104.083981][    C3] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc5-00213-g7c895ef88403-dirty #65
> [  104.083981][    C3] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [  104.083981][    C3] Call Trace:
> [  104.083981][    C3]  <IRQ>
> [  104.083981][    C3]  dump_stack_lvl+0xbf/0xee
> [  104.083981][    C3]  __might_resched+0x386/0x4b0
> [  104.083981][    C3]  ? irq_exit_rcu+0x4d/0xa0
> [  104.083981][    C3]  ? __do_softirq+0xa0/0x544
> [  104.083981][    C3]  ? write_nic_dword+0x70/0x160
> [  104.083981][    C3]  kmem_cache_alloc_trace+0x3a/0x240
> [  104.083981][    C3]  write_nic_dword+0x70/0x160
> [  104.083981][    C3]  dm_fsync_timer_callback+0x1c4/0xd80
> [  104.083981][    C3]  ? dm_rf_pathcheck_workitemcallback+0x1150/0x1150
> [  104.083981][    C3]  call_timer_fn+0x2d/0x1c0
> [  104.083981][    C3]  ? dm_rf_pathcheck_workitemcallback+0x1150/0x1150
> [  104.083981][    C3]  expire_timers+0x1f3/0x320
> [  104.083981][    C3]  __run_timers+0x3ff/0x4d0
> [  104.083981][    C3]  ? lapic_next_event+0x61/0x70
> [  104.083981][    C3]  run_timer_softirq+0x41/0x80
> [  104.083981][    C3]  __do_softirq+0x233/0x544
> [  104.083981][    C3]  irq_exit_rcu+0x41/0xa0
> [  104.083981][    C3]  sysvec_apic_timer_interrupt+0x8c/0xb0
> [  104.083981][    C3]  </IRQ>
> [  104.083981][    C3]  <TASK>
> [  104.083981][    C3]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [  104.083981][    C3] RIP: 0010:rtl8192_usb_initendpoints+0xa0/0x310
> [  104.083981][    C3] Code: 85 ed 0f 84 3c 02 00 00 48 89 1c 24 31 ff be c0 0c 00 00 e8 a2 19 b8 ff 48 89 c5 43 80 3c 37 00 74 08 4c 89 ef e8 80 8
> [  104.083981][    C3] RSP: 0018:ffff888006e279f8 EFLAGS: 00000246
> [  104.083981][    C3] RAX: ffff8880097b0300 RBX: ffff88800bf00000 RCX: ffffffff831e1751
> [  104.083981][    C3] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff8880097b0320
> [  104.083981][    C3] RBP: ffff8880097b0300 R08: dffffc0000000000 R09: ffffed10012f6061
> [  104.083981][    C3] R10: dfffe910012f6062 R11: 1ffff110012f6060 R12: ffff88800bf0fff4
> [  104.083981][    C3] R13: ffff88800bf09140 R14: dffffc0000000000 R15: 1ffff110017e1228
> 
> After using delayed work to replace timer, the following is the result triggered by gdb. 
> As we can see, the dm_fsync_work_callback() is successfully triggered.
> 
> [#0] 0xffffffff8368bd6b → dm_fsync_work_callback(work=0xffff88800bda98b8)
> [#1] 0xffffffff8118a583 → process_one_work(worker=0xffff888006f5b200, work=0xffff88800bda98b8)
> [#2] 0xffffffff8118b526 → worker_thread(__worker=0xffff88800bda98b8)
> [#3] 0xffffffff81199d72 → kthread(_create=<optimized out>)
> [#4] 0xffffffff81003902 → ret_from_fork()
> 
> The dm_fsync_work_callback() could run well and there is no bug report anymore.

Great, can you resend this, it's not in my queue anymore.

thanks,

greg k-h
