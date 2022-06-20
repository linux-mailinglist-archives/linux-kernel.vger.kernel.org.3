Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2BC5526F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbiFTWZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242768AbiFTWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:25:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340A113E3F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:25:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3E74E1F9D0;
        Mon, 20 Jun 2022 22:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655763905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJ0iztHxsK8a+Ha9h5rHbJfy+QtzjyiswzEJIkBJEYg=;
        b=Lou7oJk0l21cmXaZoH5uz/345ApgwxkXV3JrYfjJ3Fxse7kAMVwnYzhoECxQEy7NK1+TbP
        lvceRmr6MG7ZQUkmE76xbGdfFvw6NMBdnu8FetBVz9b1z5vhSDp0F/ndcTT5qKnxx5WPb5
        50+tyeKnw/McWVROCIfEKqCSuUOrSzg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A38E02C141;
        Mon, 20 Jun 2022 22:25:04 +0000 (UTC)
Date:   Tue, 21 Jun 2022 00:25:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
Message-ID: <YrDzvX1fXWn5hMWL@alley>
References: <20220619204949.50d9154d@thinkpad>
 <87r13kwawb.fsf@jogness.linutronix.de>
 <20220620112936.48fcb2a4@thinkpad>
 <YrBdjVwBOVgLfHyb@alley>
 <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
 <YrCDNqsPrY+Hs9ju@alley>
 <YrCO04oNncE1xF5K@alley>
 <CAHk-=whBSrixcBVoWGnU0eoaksp82gnQ9_1jMNZsCzhLXEgEpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whBSrixcBVoWGnU0eoaksp82gnQ9_1jMNZsCzhLXEgEpw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-06-20 14:10:20, Linus Torvalds wrote:
> On Mon, Jun 20, 2022 at 10:14 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > The console kthreads uncovered several races in console drivers.
> 
> I really want to make it clear that this was NOT some kind of "races
> in drivers".
>
> Console drivers may very well  have intentionally avoided taking locks
> for console output, since the printk output was supposed to be
> serialized by printk.
> 
> Don't try to make this some kind of "buggy drivers" thing. This is on
> printk, not on anything else.

OK, I see that uart_console_write() is used by
early_serial8250_write() without port->lock. It means that it is
racy against serial8250_console_write(). It might
cause problems reported by this thread. And you are
right that it has never been used in parallel before the kthreads.

But I believe that it might cause real problems. serial8250_console_write()
takes port->lock to get serialized against other operations on the
port. And there might be some when the same port is added as
a proper serial console.

Today I found that probe_baud() is called from
serial8250_console_setup() without port->lock. It does reads and
writes. I believe that it might break with the earlycon.

Also the commit 589f892ac8ef244e47c5a ("serial: meson:
acquire port->lock in startup()") fixes a race between
meson_serial_port_write() and meson_uart_startup(), where
meson_serial_port_write() is used by both early and proper
console driver. The problem was there even without kthreads.
They just made it more visible.

My colleagues familiar with ARM told me that they heard about
boot freezes with early consoles before threads. The kthreads
allow to reproduce and fix them. In the end, they make the early
consoles more reliable.


> Assuming this solves all issues, I'm ok with this approach, but I
> really want this to be clearly about printk being buggy, no "blame the
> drivers" garbage.
>
> And if there are other issues coming up, we revert the whole thing entirely.
> 
> Because printk is too important to play games with, and too important
> to try to blame drivers.

I take printk() really seriously. And I definitely do not want
to wave out problems as others problem.

I do not want to release 5.19 with broken printk(). But the kthreads
solve real bugs where printk() put the system into knees. I want
to invest much more time on improving them and fixing related
problems. Unfortunately, linux-next was not able to catch
the recently reported problems and we were not able to fix them
in advance.

All the recent fixes were generic and should make printk() with
kthreads much more reliable. I can't be sure if it will be enough.
I could only say that I am going to fix any new ones.

Of course, if people continue reporting problems, we would need
to revert it for 5.19. But I would really like to give it another
chance later.

Best Regards,
Petr
