Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5944B50A2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381977AbiDUOnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389536AbiDUOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:43:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6F4092D;
        Thu, 21 Apr 2022 07:40:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7C58E1F388;
        Thu, 21 Apr 2022 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650552026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9effdkmUxVjgOh70/NqOrgpWR04Elt7nh5VJxi2xATE=;
        b=amHgvBjSPF66rzQhn9TWLQ/xoCtxeh8VjkBMStTUBE+dOlswgf5ovgANJUK0WFGZmsFxM6
        VmHgLPKnc1KdY3h/yePAegYHE5rBeN8bf/TpvdWF5ASCPCZ4UjU8NSI3omlY8rR8oJE1qj
        6YYlxj1qSw9zjz8hjzGxNJeCXcrLVDE=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 878CA2C14B;
        Thu, 21 Apr 2022 14:40:25 +0000 (UTC)
Date:   Thu, 21 Apr 2022 16:40:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
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
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Marco Elver <elver@google.com>, Wei Liu <wei.liu@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v3 00/15] printk/for-next
Message-ID: <20220421144025.GE11747@pathway.suse.cz>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234637.357112-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-20 01:52:22, John Ogness wrote:
> This is v3 of a series to implement a kthread for each registered
> console. v2 is here [0]. The kthreads locklessly retrieve the
> records from the printk ringbuffer and also do not cause any lock
> contention between each other. This allows consoles to run at full
> speed. For example, a netconsole is able to dump records much
> faster than a serial or vt console. Also, during normal operation,
> printk() callers are completely decoupled from console printing.
> 
> There are situations where kthread printing is not sufficient. For
> example, during panic situations, where the kthreads may not get a
> chance to schedule. In such cases, the current method of attempting
> to print directly within the printk() caller context is used. New
> functions printk_prefer_direct_enter() and
> printk_prefer_direct_exit() are made available to mark areas of the
> kernel where direct printing is preferred. (These should only be
> areas that do not occur during normal operation.)
> 
> This series also introduces pr_flush(): a might_sleep() function
> that will block until all active printing threads have caught up
> to the latest record at the time of the pr_flush() call. This
> function is useful, for example, to wait until pending records
> are flushed to consoles before suspending.
> 
> Note that this series does *not* increase the reliability of console
> printing. Rather it focuses on the non-interference aspect of
> printk() by decoupling printk() callers from printing (during normal
> operation). Nonetheless, the reliability aspect should not worsen
> due to this series.

This series looks almost ready for linux-next. The only real
problems are:

   + Use allow_direct_printing() instead of
     atomic_read(&printk_prefer_direct) in defer_console_output()

   + "temporary" remove
     console_lock_single_hold()/console_lock_single_release() and
     use the full console_lock()/console_unlock() instead.

The rest are few cosmetic issues.

I would like to push this into linux-next ASAP so that we get some
wider testing of this approach. I do not expect that we could find
much more issues just by staring into the code ;-)

Now, the question is whether I should wait for v4. Or whether
I should put v3 into linux-next with a follow up patch doing
the two above suggested changes. They are quite trivial.

Anyway, if I pushed v3+fixup then I would replace it with v4, v5, ...
once they are available. I just do not want to block testing because
of cosmetic problems.

John, what is your preference, please?
Anybody has another opinion, please?

Best Regards,
Petr
