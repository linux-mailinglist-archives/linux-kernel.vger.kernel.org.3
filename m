Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B790B5800AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiGYOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiGYOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:24:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF6167C6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:24:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7F1DA344D6;
        Mon, 25 Jul 2022 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658759062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3DHSZ0eeKNjdw0rg2aKKUav44aKsZSE3aktJc7q1/kQ=;
        b=jifpNVdMlHE7ShY097OU8tPqWdO8EwxCG+HOuuuBn2UK/nBZQdJJclwCjXcvMY57K0pwHY
        euwI3MTOY8tQDWquErseaxkYFNt18YD8Hz2lMm/cTHqsdF7Wz28DcdEknu2b5cUZcfAT5O
        OQEWIY8ljpfdWN9/Q7fIBh/NKr1dEbo=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3866C2C153;
        Mon, 25 Jul 2022 14:24:22 +0000 (UTC)
Date:   Mon, 25 Jul 2022 16:24:21 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <Yt6nlaSrfZ+fn80x@alley>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de>
 <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de>
 <Ytj3PisFjOfS9L0Y@linutronix.de>
 <YtqakGJAQzw/IPul@alley>
 <YtrYdXWGb0NQLKNA@linutronix.de>
 <Yt6MzEEFfpyTBIIj@alley>
 <Yt6gxxRxDZ/wFHrA@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt6gxxRxDZ/wFHrA@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-07-25 15:55:19, Sebastian Andrzej Siewior wrote:
> On 2022-07-25 14:30:04 [+0200], Petr Mladek wrote:
> > This is what I have missed. It might be obvious for people living by RT
> > kernel. But spinlocks do not sleep in normal kernel. So I did not get
> > that the spinlocks are the culprit. Please, make it more obvious
> > in the commit message, for example:
> > 
> > --- cut ---
> > Console drivers use spinlocks that might sleep in PREEMPT_RT. As a
> > result they must not be called with interrupts enabled...
> > --- cut ---
> 
> It is not only the sleeping lock by itself but also the fact that
> polling on 115200 or 9600 to print a line is simply takes too much time.
> Even if the line consists of four letters.

I see.

> > Huh, I do not think that it is a good idea. There are neither atomic
> > consoles nor printk kthreads in upstream. The patch effectively
> > completely disables the consoles in PREEMPT_RT. All consoles
> > will be _empty all the time_.
> 
> I am aware of that, I tested that patch (as in I didn't just send it).
> This is what I see on bare metal's UART:
> 
> |  Booting `Debian GNU/Linux'
> |
> | Loading Linux RT ...
> | Loading initial ramdisk ...
> | No EFI environment detected.
> | early console in extract_kernel
> | input_data: 0x00000000031d12e0
> | input_len: 0x0000000000c283e1
> | output: 0x0000000001000000
> | output_len: 0x00000000025f49f8
> | kernel_total_size: 0x0000000002e26000
> | needed_size: 0x0000000003000000
> | trampoline_32bit: 0x0000000000099000
> | 
> | Decompressing Linux... Parsing ELF... done.
> | Booting the kernel.
> | Loading, please wait...
> | Starting version 251.3-1
> | Begin: Loading essential drivers ... done.

I see. These messages are pushed to the serial console directly.


> and this is okay for me at this point. This means that v5.20 could have
> RT enabled for x86 and people can start test it without additional
> patches. They can enable it and if it boots they can check dmesg's
> output for anything odd. If it doesn't boot they can either wait for the
> next release or grab the patchset with the missing bits for debugging.
> This is way better than letting printk depend on !RT which would provide
> no insight at all. The RT option is still hidden behind EXPERT.

Makes sense.

> > Also the consoles were never tested with interrupts enabled. I am
> > pretty sure that interrupts has to be disabled in some locations,
> > for example, when sending some data sequences on the ports. Are we
> > sure that they are always explicitly disabled inside the drivers?
> 
> The 8250 did disable interrupts via local_irq_disable() and this is not
> desired on RT since it *really* disables interrupts. This was long ago
> addressed in commit
>    ebade5e833eda ("serial: 8250: Clean up the locking for -rt")

Good to know.

> The lack of the console probably makes RT not production ready as of
> v5.20 but I was debugging systems without a UART so.
> It might not be production ready without a console. Also ARM and PowerPC
> can not be enabled so there will be a queue for a while unless people
> device that they don't care about what is left. However it will
> hopefully will attract x86 people to give it a spin. Then we may receive
> bug reports and or patches which we did not before and so get better.

OK, it all makes sense now. Could you please send v3 with an updated
commit message?

It should explain why it is not acceptable to call console drivers
with disabled interrupts in RT (spinlocks are sleeping locks,
pooling takes too long).

It should make clear the effect of the patch. printk() messages
will never reach console. They will be accessible only from userspace
(dmesg).

Finally, it should mention that this is only a temporary solution.
It allows to boot PREEMPT_RT mainline kernel without extra patches.
The consoles will later get enabled again by calling console
drivers with interrupts enabled from dedicated kthreads.
Also it will be possible to call consoles directly by
atomic consoles drivers.

If it gets acked by John then I could queue it for 5.20.

Thanks for explaining all the details.

Best Regards,
Petr
