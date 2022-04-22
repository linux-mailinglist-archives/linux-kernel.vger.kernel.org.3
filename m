Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E240B50C120
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiDVVi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiDVViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:38:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53FC2A60A1;
        Fri, 22 Apr 2022 13:39:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F260215FF;
        Fri, 22 Apr 2022 20:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650659358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQC9EwCc1d1zwv7C55oUEIwJvP8u2qczlBIORadICHM=;
        b=uYZv5hZrfXo2ih3eM61buBuIvSz6QOFFhD/teRRlFeYlIRGxdGRHYkRzeigC3ZoAYLJZy4
        /xmA7IHpb9B0Z1fe2WOV2rI+8UjeTH2Ln4ZmlEcqiGNj5T7KgozDqEWusyu+VZwunc6EEX
        6bVDIOlkieaPn/YgYHdJh5iL0s+JxrE=
Received: from suse.cz (unknown [10.163.16.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D85F42C145;
        Fri, 22 Apr 2022 20:29:16 +0000 (UTC)
Date:   Fri, 22 Apr 2022 22:29:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v4 00/15] implement threaded console printing
Message-ID: <YmMQHMaS0KwyN5hX@alley>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <YmJ1fnc4trEOooZD@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmJ1fnc4trEOooZD@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-04-22 11:39:59, Petr Mladek wrote:
> On Thu 2022-04-21 23:28:35, John Ogness wrote:
> > This is v4 of a series to implement a kthread for each registered
> > console. v3 is here [0]. The kthreads locklessly retrieve the
> > records from the printk ringbuffer and also do not cause any lock
> > contention between each other. This allows consoles to run at full
> > speed. For example, a netconsole is able to dump records much
> > faster than a serial or vt console. Also, during normal operation,
> > printk() callers are completely decoupled from console printing.
> > 
> > There are situations where kthread printing is not sufficient. For
> > example, during panic situations, where the kthreads may not get a
> > chance to schedule. In such cases, the current method of attempting
> > to print directly within the printk() caller context is used. New
> > functions printk_prefer_direct_enter() and
> > printk_prefer_direct_exit() are made available to mark areas of the
> > kernel where direct printing is preferred. (These should only be
> > areas that do not occur during normal operation.)
> > 
> > This series also introduces pr_flush(): a might_sleep() function
> > that will block until all active printing threads have caught up
> > to the latest record at the time of the pr_flush() call. This
> > function is useful, for example, to wait until pending records
> > are flushed to consoles before suspending.
> > 
> > Note that this series does *not* increase the reliability of console
> > printing. Rather it focuses on the non-interference aspect of
> > printk() by decoupling printk() callers from printing (during normal
> > operation). Nonetheless, the reliability aspect should not worsen
> > due to this series.
> 
> This version looks good enough for linux-next. I do not see any
> functional problem and it should work as designed. It is time to
> see how it works in various "real life" work loads.
> 
> I am going to push it later today unless anyone (John) complains ;-)

I have pushed the patchset into printk/linux.git, branch
rework/kthreads. Also I merged it into for-next branch.

We are still discussing better solution of the complicated locking
scheme[0]. The main purpose is to make it easier and more safe to use.
Anyway, the current code looks safe. Any potential improvements
should not affect the behavior.

So, it is time to test it in linux-next. Let's see how survives
hammering of various robots and people testing on linux-next.
I keep my fingers crossed.

Best Regards,
Petr
