Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00996547B11
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiFLQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFLQaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 12:30:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987F03DA55
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3329160FB0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 16:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924F2C34115;
        Sun, 12 Jun 2022 16:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655051444;
        bh=av4x1OtTbLOl2qaVByxmxj3YZ1Y0YhQeHKj8yiGOlRo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=euctpRUWaLEf17/tF2HcTJ6lMEKPe/F725SFt9VuJY21dUWD3CRUAceUgUixMa52V
         7yecVLWwHVbzU23+CjcGD624tHpvMm336Q5zk/r9tasRpqH64N326Wf2o27JjhndqK
         npyLpjJbX/6PXqDhwbr1IcqfAvJm7FFbK282hlLV7iVYPz2ouVP8S3abi+CqJrds9R
         ZuinSpxZZgjzOVsxWYixQUHq5hgwicHyOYGKEwXf3Sk91pSYGVLWtCk6qv+tQz157a
         mMQCbcoI7UYhCUkVuAXeW2NHFLQuol6NCDn0esuMTfO7LEv179hsbLt2LLJlbV5xoY
         ktNcXqhZ3CgvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 23B415C02F9; Sun, 12 Jun 2022 09:30:44 -0700 (PDT)
Date:   Sun, 12 Jun 2022 09:30:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org, pmladek@suse.com
Subject: Re: [BUG] 8e274732115f ("printk: extend console_lock for per-console
 locking")
Message-ID: <20220612163044.GS1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
 <20220612132302.GA873785@paulmck-ThinkPad-P17-Gen-1>
 <87k09llvi9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k09llvi9.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 06:09:10PM +0206, John Ogness wrote:
> Hi Paul,
> 
> Thanks for looking into this! I am currently on vacation with family, so
> my responses are limited. Some initial comments from me below...

First, this is not an emergency.  I have a good workaround that just got
done passing significant rcutorture testing.  This means that I can port
my RCU changes to v5.19-rc1/2 and get on with other testing.

So please ignore this for the rest of your time away, and have a great
time with your family!!!

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

Which is the case when called from torture_shutdown().

But it does seem to be common to invoke kernel_power_off() from things
like interrupt handlers.  Which means that putting the pr_flush() in
kernel_power_off() would be a bad idea given that we cannot detect
non-preemptible regions of code with CONFIG_PREEMPT_NONE=y kernels.
(That again!)

So any fix within kernel_power_off() would be a bit "interesting".

> What is _supposed_ to happen is that @system_state increases above
> SYSTEM_RUNNING, which then causes direct printing to be used. So the
> pr_emerg("Power down\n") in kernel_power_off() would directly flush all
> remaining messages.
> 
> But if the threaded printers are already in the process of printing,
> they block direct printing. That may be what we are seeing here.

Given that rcutorture can be a bit chatty at shutdown time, my guess
is that the threaded printers are already in the process of printing.

> What I find particularly interesting is that it is not the kthread-patch
> that is causing the issue.

I do know that feeling!

> I will have some time tonight to take a closer look.

Please wait until you are back from your vacation.  Given that I now
have a workaround, which might be as good a fix as there is, there is
no need to interrupt your vacation.

							Thanx, Paul
