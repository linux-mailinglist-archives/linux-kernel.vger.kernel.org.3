Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C384FBC71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346206AbiDKMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346258AbiDKMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:52:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F010132992;
        Mon, 11 Apr 2022 05:50:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 95CB91F7AC;
        Mon, 11 Apr 2022 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649681421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mRb2hfkCPyR9bsV16wzMVvKahkyDBmTBDlcwwDQpb7o=;
        b=VHN8EV/Y286zoCF2jOJDqFhPHphTWVuRTckwFBpJE/8W2WMU1LotwgbJs0BUIMjr9X/3/g
        sGFKZdfJ4Prr0Y6io2MqAnJlYKrbogAsx4KEYQS+Jlffyh1vXXZezFjcwFjc8vvkDELc56
        BnZJy5Y4DkvcsyyO2mP1f0mslERm5i8=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C19EAA3B8A;
        Mon, 11 Apr 2022 12:50:19 +0000 (UTC)
Date:   Mon, 11 Apr 2022 14:50:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Helge Deller <deller@gmx.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v2 09/12] printk: add functions to prefer direct
 printing
Message-ID: <YlQkC0jddnjb8Mbr@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-10-john.ogness@linutronix.de>
 <Yk61Q+w7tWTjh8xl@alley>
 <b746d99e-729f-ca0d-5d30-6d803d1cd833@gmx.de>
 <87zgkxnepg.fsf@jogness.linutronix.de>
 <7fc5853e-dbe6-c2d2-2130-003e3b9777bc@gmx.de>
 <878rsgvews.fsf@jogness.linutronix.de>
 <4bcfd2b3-66fd-c5df-a8df-c51a89a0bce4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bcfd2b3-66fd-c5df-a8df-c51a89a0bce4@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-04-07 22:20:30, Helge Deller wrote:
> On 4/7/22 22:04, John Ogness wrote:
> > On 2022-04-07, Helge Deller <deller@gmx.de> wrote:
> >> In my case - while I debug low-level kernel code - I then just need to
> >> use pr_warn() or pr_emerg() and get it printed non-threadened. That's
> >> sufficient for me.
> >
> > Actually, no. The loglevel does not determine if a message is direct
> > printed or not. By "warn" I was referring to WARN_ON(condition).
> 
> Oh, then there was a misunderstanding on my side.
> 
> > If you are debugging low-level kernel code, you usually will _want_
> > threaded printing. The timestamps match the printk() call, so you will
> > get accurate logs. And the runtime performance of your low-level kernel
> > code will not be significantly affected by the printk() call.
> 
> That really much depends on what you debug.
> Currently I'm debugging some CPU hotplug stuff, and I really want my
> debug info printed immediately, otherwise it's too late to analyze what's
> going wrong. I can imaginge other use cases like trying to find memory
> leaks are similiar.

So, it is not about severity of the messages but about the context,
in this case the suspend. We try to address this. 10th patch from
this patchset adds:

static inline bool allow_direct_printing(void)
{
	return (!printk_kthreads_available ||
		system_state > SYSTEM_RUNNING ||
		oops_in_progress ||
		atomic_read(&printk_prefer_direct));
}

It means that printk() inside the SYSTEM_SUSPEND state will
automatically try to handle the console directly.

I intentionally mention "try" because printk() uses console_trylock().
It fails when anyone else already does the printing, including
a kthread. trylock() is needed because printk() must be usable also
in atomic context. It has worked this way for more than two decades.
It came with SMP support.


> > If for some reason you really want non-threaded printing, the patch we
> > are discussing creates new functions to manually activate it:
> >
> > printk_prefer_direct_enter();
> > pr_info("debugging\n");
> > printk_prefer_direct_exit();
> 
> That's quite unhandy. At least I would have thought that pr_emerg() would
> do that call sequence.
> Wouldn't it make sense to make pr_emerg() work unthreadened, as it's
> used quite seldom and only in special situations...

It is true that pr_emerg() is relatively special.

But I would really like to avoid a situation where developers
use non-appropriate printk level just to get the message
directly.

Instead, we should allow using the direct context in some
situation easily. We could also add a command line parameter
to disable the kthreads completely.

Best Regards,
Petr
