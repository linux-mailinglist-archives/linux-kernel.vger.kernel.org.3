Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A5E548DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354140AbiFMMQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354277AbiFMMN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:13:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED69953736
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:01:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 563AA1F909;
        Mon, 13 Jun 2022 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655118073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m9FfGFa17KWR8a5iEek1UcK6iubFYvWLUYMLzZ/yc3c=;
        b=CTHEJs8hhZky3FUBfGs+bYLEvfXAps2Miyryh2baj5OG2NQ/uAXs05p3LX4IHBoGK3TuUU
        SivNESCwoGzT4a6O5Y91UJiEFT0gnpeSapVJMosVDB9J9RuhALQZQOrx1RUVnzmwod4dBV
        FeXsgVNrqdHCDkyWqsvAlvvNBQrC9i4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3552D2C141;
        Mon, 13 Jun 2022 11:01:13 +0000 (UTC)
Date:   Mon, 13 Jun 2022 13:01:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [BUG] 8e274732115f ("printk: extend console_lock for per-console
 locking")
Message-ID: <YqcY+NonkxDkZyVV@alley>
References: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
 <20220612132302.GA873785@paulmck-ThinkPad-P17-Gen-1>
 <87k09llvi9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k09llvi9.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-06-12 18:09:10, John Ogness wrote:
> Hi Paul,
> 
> Thanks for looking into this! I am currently on vacation with family, so
> my responses are limited. Some initial comments from me below...
> 
> On 2022-06-12, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > And the patch below takes care of things in (admittedly quite light)
> > testing thus far.  What it does is add ten seconds of pure delay
> > before rcutorture shuts down the system.  Presumably, this delay gives
> > printk() the time that it needs to flush its buffers.  In the
> > configurations that I have tested thus far, anyway.
> >
> > So what should I be doing instead?
> >
> > o	console_flush_on_panic() seems like strong medicine, but might
> > 	be the right thing to do.  The bit about proceeding even though
> > 	it failed to acquire the lock doesn't look good for non-panic
> >       use.
> 
> For sure not this one.
> 
> > o	printk_trigger_flush() has an attractive name, but it looks
> > 	like it only just starts the flush rather than waiting for it
> > 	to finish.
> 
> Correct. It just triggers.
> 
> > o	pr_flush(1000, true) looks quite interesting, and also seems to
> > 	work in a few quick tests, so I will continue playing with that.
> 
> This is only useful if the context is guaranteed may_sleep().
> 
> What is _supposed_ to happen is that @system_state increases above
> SYSTEM_RUNNING, which then causes direct printing to be used. So the
> pr_emerg("Power down\n") in kernel_power_off() would directly flush all
> remaining messages.
> 
> But if the threaded printers are already in the process of printing,
> they block direct printing. That may be what we are seeing here.
> 
> What I find particularly interesting is that it is not the kthread-patch
> that is causing the issue.

Yes, it is interesting :-)

I think that it is because the initial kthreads allowed to handover
console_lock() to another caller. It was removed when kthreads
started using the new con->lock mutex.

This might also be the reason why the extra
console_lock()/console_unlock() helped.

Best Regards,
Petr
