Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEACB57647B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiGOPeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiGOPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:34:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB1314035
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:34:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 80F60201E6;
        Fri, 15 Jul 2022 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657899249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dHkyYdvPMihubQc6LwKfvGIMJV7WAc+es/B12KkQGCM=;
        b=r445NMOxTKeahO1JlHAolIviqz+alz907NIiiFVDb3BwSmSX352yhlFRnH5ZwNptZYO9o1
        ceO8xAq+p4dk7X1M8Xh08gYa6bGSpKgOHeu7loXqKfQupQd6BVE0GTEFwumb2haPnEItmt
        D6/HcEx14p151K5yGbQJTliHxbO4FAc=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EF9442C141;
        Fri, 15 Jul 2022 15:34:08 +0000 (UTC)
Date:   Fri, 15 Jul 2022 17:34:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        kasan-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make console tracepoint safe in NMI() context
Message-ID: <20220715153408.GF24338@pathway.suse.cz>
References: <20220715120152.17760-1-pmladek@suse.com>
 <CANpmjNOHY1GC_Fab4T6J06vqW0vRf=4jQR0dG0MJoFOPpKzcUA@mail.gmail.com>
 <20220715095156.12a3a0e3@gandalf.local.home>
 <20220715151000.GY1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715151000.GY1790663@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-07-15 08:10:00, Paul E. McKenney wrote:
> On Fri, Jul 15, 2022 at 09:51:56AM -0400, Steven Rostedt wrote:
> > On Fri, 15 Jul 2022 14:39:52 +0200
> > Marco Elver <elver@google.com> wrote:
> > 
> > > Couldn't this just use rcu_is_watching()?
> > > 
> > >   | * rcu_is_watching - see if RCU thinks that the current CPU is not idle
> > 
> > Maybe, but I was thinking that Petr had a way to hit the issue that we
> > worry about. But since the non _rcuide() call requires rcu watching,
> > prehaps that is better to use.

I actually saw the warning even with simple sysrq+l. I wonder why
I have missed it during testing. It was probably well hidden within
the other backtraces.

I was not aware that rcu_is_watching() and rcu_is_idle_cpu() did
basically the same. I used rcu_is_idle_cpu() because of the "idle"
in the name and the function description ;-)

> In case this helps...  ;-)
> 
> The rcu_is_watching() function is designed to be used from the current
> CPU, so it dispenses with memory ordering.  However, it explicitly
> disables preemption in order to avoid weird preemption patterns.
> 
> The formulation that Marco used is designed to be used from a remote
> CPU, and so it includes explicit memory ordering that is not needed
> in this case.  But it does not disable preemption.
> 
> So if preemption is enabled at that point in tracing, you really want
> to be using rcu_is_watching().

rcu_is_watching() is the right variant then. I am going to send v2.

Thanks a lot for the detailed explanation.

Best Regards,
Petr
