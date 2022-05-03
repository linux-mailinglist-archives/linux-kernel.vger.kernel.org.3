Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD80D517D92
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiECGwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiECGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:52:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482F137031
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:49:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 05690210E5;
        Tue,  3 May 2022 06:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NP8vAZfmgF+dnOWl0SRaBrH1NF8WDUxMZVLc1BzYQqw=;
        b=o8xoGS5KraH9ARSziPEkg5dZeG0W/0bLG0oFhwtvWVWKbxdCYbny/B1baHRpZISePxbVYi
        Y9u/wF6CMwadwSM6rnov2CrNGsgI2suJTGAjur1FwUvHnIH5jJurmtNcMzForBQ2sVJWvb
        LgHcwRgCoWzzw6Dx2MrXsHGqdnSU6ok=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9286E2C141;
        Tue,  3 May 2022 06:49:07 +0000 (UTC)
Date:   Tue, 3 May 2022 08:49:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Message-ID: <YnDQYIWLZMjOPKK5@alley>
References: <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <Ym/Z7PYPqvWPEjuL@alley>
 <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-05-03 01:13:19, Marek Szyprowski wrote:
> Hi Petr,
> 
> On 02.05.2022 15:17, Petr Mladek wrote:
> > On Mon 2022-05-02 11:19:07, Marek Szyprowski wrote:
> >> On 30.04.2022 18:00, John Ogness wrote:
> >>> On 2022-04-29, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >>>> The same issue happens if I boot with init=/bin/bash
> >>> Very interesting. Since you are seeing all the output up until you try
> >>> doing something, I guess receiving UART data is triggering the issue.
> >> Right, this is how it looks like.
> >>
> >>>> I found something really interesting. When lockup happens, I'm still
> >>>> able to log via ssh and trigger any magic sysrq action via
> >>>> /proc/sysrq-trigger.
> >>> If you boot the system and directly login via ssh (without sending any
> >>> data via serial), can you trigger printk output on the UART? For
> >>> example, with:
> >>>
> >>>       echo hello > /dev/kmsg
> >>>
> >>> (You might need to increase your loglevel to see it.)
> >> Data written to /dev/kmsg and all kernel logs were always displayed
> >> correctly. Also data written directly to /dev/ttyAML0 is displayed
> >> properly on the console. The latter doesn't however trigger the input
> >> related activity.
> >>
> >> It looks that the data read from the uart is delivered only if other
> >> activity happens on the kernel console. If I type 'reboot' and press
> >> enter, nothing happens immediately. If I type 'date >/dev/ttyAML0' via
> >> ssh then, I only see the date printed on the console. However if I type
> >> 'date >/dev/kmsg', the the date is printed and reboot happens.
> > This is really interesting.
> >
> > 'date >/dev/kmsg' should be handled like a normal printk().
> > It should get pushed to the console using printk kthread,
> > that calls call_console_driver() that calls con->write()
> > callback. In our case, it should be meson_serial_console_write().
> >
> > I am not sure if meson_serial_console_write() is used also
> > when writing via /dev/ttyAML0.
> >
> >>>> It turned out that the UART console is somehow blocked, but it
> >>>> receives and buffers all the input. For example after issuing "echo
> >>>>    >/proc/sysrq-trigger" from the ssh console, the UART console has been
> >>>> updated and I see the magic sysrq banner and then all the commands I
> >>>> blindly typed in the UART console! However this doesn't unblock the
> >>>> console.
> >>> sysrq falls back to direct printing. This would imply that the kthread
> >>> printer is somehow unable to print.
> >>>
> >>>> Here is the output of 't' magic sys request:
> >>>>
> >>>> https://protect2.fireeye.com/v1/url?k=8649f24d-e73258c4-86487902-74fe48600034-a2ca6bb18361467d&q=1&e=1bc4226f-a422-42b9-95e8-128845b8609f&u=https%3A%2F%2Fpastebin.com%2FfjbRuy4f
> >>> It looks like the call trace for the printing kthread (pr/ttyAML0) is
> >>> corrupt.
> >> Right, good catch. For comparison, here is a 't' sysrq result from the
> >> 'working' serial console (next-20220429), which happens usually 1 of 4
> >> boots:
> >>
> >> https://protect2.fireeye.com/v1/url?k=610106f1-008a13b6-61008dbe-000babff99aa-11083c39c44861df&q=1&e=2eafad9e-c5d2-4696-9d78-f3b5885256dc&u=https%3A%2F%2Fpastebin.com%2Fmp8zGFbW
> > Strange. The backtrace is weird here too:
> >
> > [   50.514509] task:pr/ttyAML0      state:R  running task     stack:    0 pid:   65 ppid:     2 flags:0x00000008
> > [   50.514540] Call trace:
> > [   50.514548]  __switch_to+0xe8/0x160
> > [   50.514561]  meson_serial_console+0x78/0x118
> >
> > There should be kthread() and printk_kthread_func() on the stack.
> >
> > Hmm,  meson_serial_console+0x78/0x118 is weird on its own.
> > meson_serial_console is the name of the structure. I would
> > expect a name of the .write callback, like
> > meson_serial_console_write()
> 
> Well, this sounds a bit like a stack corruption. For the reference, I've 
> checked what magic sysrq 't' reports for my other test boards:
> 
> RaspberryPi4:
> 
> [  166.702431] task:pr/ttyS0        state:R stack:    0 pid:   64 
> ppid:     2 flags:0x00000008
> [  166.711069] Call trace:
> [  166.713647]  __switch_to+0xe8/0x160
> [  166.717216]  __schedule+0x2f4/0x9f0
> [  166.720862]  log_wait+0x0/0x50
> [  166.724081] task:vfio-irqfd-clea state:I stack:    0 pid:   65 
> ppid:     2 flags:0x00000008
> [  166.732698] Call trace:
> 
> 
> ARM Juno R1:
> 
> [   74.356562] task:pr/ttyAMA0      state:R  running task stack:    0 
> pid:   47 ppid:     2 flags:0x00000008
> [   74.356605] Call trace:
> [   74.356617]  __switch_to+0xe8/0x160
> [   74.356637]  amba_console+0x78/0x118
> [   74.356657] task:kworker/2:1     state:I stack:    0 pid:   48 
> ppid:     2 flags:0x00000008
> [   74.356695] Workqueue:  0x0 (mm_percpu_wq)
> [   74.356738] Call trace:
> 
> 
> QEMU virt/arm64:
> 
> [  174.155760] task:pr/ttyAMA0      state:S stack:    0 pid:   26 
> ppid:     2 flags:0x00000008
> [  174.156305] Call trace:
> [  174.156529]  __switch_to+0xe8/0x160
> [  174.157131]  0xffff5ebbbfdd62d8

You mentioned in the other mail that the other boards work as
expected. I mean that console gets stuck only on the meson board.
Is it true, please?

The stack looks really weird. But another weird thing is that
even the meson board is able to show the messages, for example,
using echo hello >/dev/kmsg. It suggests that the kthreads
somehow work.

There is also a possibility that this code path is optimized
some special way and the unwinder has troubles to show
the stack correctly.


> In the last case it doesn't happen always. In the other runs I got the 
> following log from QEMU virt/arm64:
> 
> [  200.537579] task:pr/ttyAMA0      state:S stack:    0 pid:   26 
> ppid:     2 flags:0x00000008
> [  200.538121] Call trace:
> [  200.538341]  __switch_to+0xe8/0x160
> [  200.538583]  __schedule+0x2f4/0x9f0
> [  200.538822]  schedule+0x54/0xd0
> [  200.539047]  printk_kthread_func+0x2d8/0x3bc
> [  200.539301]  kthread+0x118/0x11c
> [  200.539523]  ret_from_fork+0x10/0x20

This is what I would expect when the kthread is in an interruptible
sleep waiting for new strings to handle.

BTW: This is what I see on my x86_64 test system:

[61892.932242] task:pr/tty0         state:S stack:    0 pid:   14 ppid:     2 flags:0x00004000
[61892.932250] Call Trace:
[61892.932253]  <TASK>
[61892.932263]  __schedule+0x376/0xbb0
[61892.932284]  schedule+0x44/0xb0
[61892.932290]  printk_kthread_func+0x18f/0x370
[61892.932303]  ? schedstat_stop+0x10/0x10
[61892.932316]  ? console_start+0x30/0x30
[61892.932322]  kthread+0xf2/0x120
[61892.932327]  ? kthread_complete_and_exit+0x20/0x20
[61892.932338]  ret_from_fork+0x1f/0x30
[61892.932370]  </TASK>
[61892.932373] task:pr/ttyS0        state:R  running task     stack:    0 pid:   15 ppid:     2 flags:0x00004000
[61892.932391] Call Trace:
[61892.932398]  <TASK>
[61892.932427]  ? printk_kthread_func+0x15b/0x370
[61892.932436]  ? schedstat_stop+0x10/0x10
[61892.932449]  ? console_start+0x30/0x30
[61892.932455]  ? kthread+0xf2/0x120
[61892.932460]  ? kthread_complete_and_exit+0x20/0x20
[61892.932471]  ? ret_from_fork+0x1f/0x30
[61892.932502]  </TASK>


pr/tty0 is in the interruptible sleep and the stack looks reasonable.

pr/ttyS0 is in runnable state and the stack is weird. The '?' means
that this address was found on the stack, it belongs to some
function but the unwinder is not able to assign it to the current
call path by going back via the return addresses stored on the stack.


> I hope that at least the qemu case will let you to analyze it by 
> yourself. I run my test system with the following command:
> 
> qemu-system-aarch64 -kernel virt/Image -append "console=ttyAMA0 
> root=/dev/vda rootwait" -M virt -cpu cortex-a57 -smp 2 -m 1024 -device 
> virtio-blk-device,drive=virtio-blk0 -drive 
> file=qemu-virt-rootfs.raw,id=virtio-blk0,if=none,format=raw -netdev 
> user,id=user -device virtio-net-device,netdev=user -display none

Thanks a lot for all the information. It is really helpful.

Best Regards,
Petr
