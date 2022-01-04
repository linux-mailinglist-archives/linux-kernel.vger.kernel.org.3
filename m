Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB09484120
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiADLp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:45:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52864 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiADLpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:45:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9967F212B9;
        Tue,  4 Jan 2022 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641296724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NUsuy9+Sh0J4mLWeAh2wzGCcbkg3LiQSrl9AFsTcsU4=;
        b=ltyhfChzJWzuKu8opJ/Q8sX3X+Yffkgmmszrk0GySL9L7L1MQMA8p6FFQYf8S7BJuGICeO
        MXuqIR9wj7mxQ3DjFQ8jLbn45ZLtHPZ1iJLSMXfAn6nov910TA4tgvLJKS6N7m8Pl0OPAu
        6EEXqoE1hla7W1UYDtPEH6lUv19Blbg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 29A24A3B85;
        Tue,  4 Jan 2022 11:45:24 +0000 (UTC)
Date:   Tue, 4 Jan 2022 12:45:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH] panic: Move panic_print before kmsg dumpers
Message-ID: <YdQzU0KkAVq2BWpk@alley>
References: <20211230161828.121858-1-gpiccoli@igalia.com>
 <YdMPJwkfcjRA48sM@alley>
 <315d9a0b-2494-5d3d-e228-7c957f7c5e4a@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315d9a0b-2494-5d3d-e228-7c957f7c5e4a@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-01-03 13:30:35, Guilherme G. Piccoli wrote:
> Hi Petr, first of all, I'd like to thank you for the _very_ complete and
> informative response, pretty useful!
> Some comments inline below:
> 
> 
> On 03/01/2022 11:58, Petr Mladek wrote:
> > [...]
> > I see the point. Unfortunately, there is some risk in this change
> > so I have to ask:
> > 
> > Did you miss this behavior in practice?
> > Or does it just look like something that might be useful?
> 
> Heh it's a valid question! And the answer is that indeed, we miss this
> behavior in practice - the plan is to use pstore as panic "fast" log
> collection (instead of kdump), and to print some extra info through
> panic_print. Hence the surprise when that information wasn't properly
> stored in the pstore saved logs...

Good to know.

> > [...] 
> > Note that panic_print_sys_info() might produce a lot of lines. There is
> > non-trivial chance that a lot of information might get lost because
> > of the limited log buffer size.
> > 
> > It might cause regression even when no dumpers are registered and
> > crash kernel is not loaded. panic_print_sys_info() might overwrite
> > the existing messages before we try hard to flush them via
> > console_flush_on_panic().
> 
> Sure, we already account for this risk, and make use of "log_buf_len" to
> increase dmesg size, something like 4M/8M.
> 
> Now, the second portion of your statement is a bit frightening! Maybe a
> silly question, but the risk is to lose some messages in the *dmesg* or
> only in the output console, like a serial/graphic console?
> 
> If the risk is to lose messages even in the dmesg (that is going to be
> collected through pstore/any other kmsg dumper),

To make it clear. panic_printk_sys_info() might overwrite the oldest
messages stored on the log buffer. This patch moves
panic_print_sys_info() before kmsg_dump(). It means that even
kmsg_dump() would not see the overwritten oldest messages.


> do you think would make sense to have a second (in fact, first!)
> "console_flush_on_panic(...)" _before_ "panic_print_sys_info()"?
> What would be the cons in this approach? I understand that we may need
> to (at least) disable debug_locks earlier than it's currently done, for
> example. If kexec is more risky having this earlier flush, we could
> flush conditionally on not having a crash kernel loaded.

Good question. I am familiar only with the console problems and there
are many problems. Serial consoles might be slow. All consoles use
internal locks that might cause deadlocks. More complicated consoles
are even more risky.

My experience is that kexec mostly works when there is enough reserved
space for booting the crash kernel. And it can be tested before
the crash.

So, I personally think that console_flush_on_panic() is more risky
and should not get called before kexec().

Also kexec might be simply disabled when it does not work. But
console_flush_on_panic() could not be disabled if we call it
too early. We might make it configurable. But it would be
to complicated for users to get it right.


> > After all, the proposed patch might be good enough.
> > panic_print_sys_info() does nothing by default.
> > It might be enough to document that a large enough log buffer
> > should be used when some output is enabled, especially when
> > a dumper is used.
> > 
> > Also we should mention these pitfalls and risks in the commit
> > message.
> 
> OK, makes total sense. I'll wait on your feedback to my points above,
> and maybe others could also provide ideas/concerns, and then, I'll
> rework the commit message/code accordingly.

I think that this is the best solution after all.

Well, I see one more problem. CONSOLE_REPLAY_ALL replays all messages
on the console. This flag should be handled when it is now. I mean
after kmsg_dump(), kexec(), console_flush_on_panic().

It is pity that PANIC_PRINT_ALL_PRINTK_MSG is in "panic_print" flags.
It makes sense only for consoles. All the other flags make sense
also for kmsg_dump().

A solution would be to add a new kernel parameter that would
obsolete PANIC_PRINT_ALL_PRINTK_MSG. The parameter can be
called panic_console_replay or so.


> Thanks again, and a happy new year to you and family =)

Same to you.

Best Regards,
Petr
