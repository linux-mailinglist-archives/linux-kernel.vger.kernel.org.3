Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14B24DB963
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357503AbiCPU3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348561AbiCPU3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:29:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637211409C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1i0WnN0sRNJ5r3i3sNS6CEcqbgD4q29gLj9qxaplvjA=; b=VI72k+OclnVWeyhFO/cglE+dhk
        V/HD5fgh+c5PRUX87PX3mENgqUa4sMHFNiHMnDY9gQZRtsx9EkizxeO0xEqBlJXy1UDVwnYvq9w+S
        hzYfyn56TujYLaeSY6z0YyUOQ6k1y0PNC582v6YrCKPPMvz5d0a+XA13slV3aEWvZHQR/IWwMX3Hy
        QeJEKJX8bn6K7cvZ2ah6DyRSEvbNWEAGov91rxBqaEAmnK27R3qTSMwkG6cAzlAYd/WI4phegdZXC
        VJbfaXt+FrnRyBjImmZXkDe/6tkbGTMjTYGfuCfQDa0AfulG8yVmpMqJE5hcyhqAQbZIiYKNCxW5R
        h3Z/q3YQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUaF7-001eK2-AT; Wed, 16 Mar 2022 20:27:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDA5E9882AA; Wed, 16 Mar 2022 21:27:34 +0100 (CET)
Date:   Wed, 16 Mar 2022 21:27:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <20220316202734.GJ8939@worktop.programming.kicks-ass.net>
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315174606.02959816@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 05:46:06PM -0400, Steven Rostedt wrote:
> On Tue, 8 Mar 2022 16:14:55 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hi Peter,
> 
> Have you had time to look into this?

Not since I talk to you on IRC about it last week.

Like I wrote, the balance_callback should be ran under whichever
rq->lock instance it gets queued under. As per:

  565790d28b1e ("sched: Fix balance_callback()")

Now, we only do queue_core_balance() from set_next_task_idle(), which
*should* only happen from pick_next_task(), and as such the callback
should only ever get called from finish_lock_switch() or the 'prev ==
next' case in __schedule().

Neither of these two sites holds pi_lock.


This is about as far as I got explaining things, and it being late, it's
about as far as I got looking at things.

Now that also makes conceptual sense, we only want to pull a core-cookie
task when we're scheduling an idle task.

Now, clearly this gets triggered from the PI path, but that's not making
immediate sense to me, it would mean we're boosting the idle task, which
is wrong too.

So it would be useful for someone that can reproduce this to provide a
trace of where queue_core_balance() gets called, because that *should*
only be in __schedule().
