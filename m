Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6628F4EEC79
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiDALnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiDALnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:43:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397E8211EFF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ga4MfIUZgdsktGYsgbWbZ2xcuagajJnCIZQSpqYHT18=; b=YFxkZ26vv3Nv6kN4orRf+lDvi6
        k0rMp+VqktNM3orFFBNQG8fS8IrO7AwHdpktunaWKQ7+tQVUS3hCmYyAPkDiYrAIuZ07YJiLzjvbI
        tkS4VD6XTUzi5+PtHugUPsXIZaE8X2vrE04BDaZ5RtjYEUDDMfwoCvSen5J5UBmrXa2igU1bUTNJc
        3rWNQOOPEPZF6sOZ6xKEI81BuY+ZZ8nYlvUu1CfG7U7QvtcREv+jmGQLKvk3c9TbgC05Iiu+wIUXm
        2eiN3yuj3/E3dlHRQf1XLd7gOojb5tJUYXroj5ZfBKOYikomJExM+cUyOQZf1lNUXRCchBxp6gHx2
        RhRii4gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naFef-000NjN-54; Fri, 01 Apr 2022 11:41:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61D0F30027B;
        Fri,  1 Apr 2022 13:41:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FDFA2007DF3D; Fri,  1 Apr 2022 13:41:20 +0200 (CEST)
Date:   Fri, 1 Apr 2022 13:41:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        vincent.guittot@linaro.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Subject: Re: [PATCH] sched/core: Fix forceidle balancing
Message-ID: <Ykbk4MSSNSxsQoMs@hirez.programming.kicks-ass.net>
References: <20220330160535.GN8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330160535.GN8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 06:05:35PM +0200, Peter Zijlstra wrote:
> 
> Steve reported that ChromeOS encounters the forceidle balancer being
> ran from rt_mutex_setprio()'s balance_callback() invocation and
> explodes.
> 
> Now, the forceidle balancer gets queued every time the idle task gets
> selected, set_next_task(), which is strictly too often.
> rt_mutex_setprio() also uses set_next_task() in the 'change' pattern:
> 
> 	queued = task_on_rq_queued(p); /* p->on_rq == TASK_ON_RQ_QUEUED */
> 	running = task_current(rq, p); /* rq->curr == p */
> 
> 	if (queued)
> 		dequeue_task(...);
> 	if (running)
> 		put_prev_task(...);
> 
> 	/* change task properties */
> 
> 	if (queued)
> 		enqueue_task(...);
> 	if (running)
> 		set_next_task(...);
> 
> However, rt_mutex_setprio() will explicitly not run this pattern on
> the idle task (since priority boosting the idle task is quite insane).
> Most other 'change' pattern users are pidhash based and would also not
> apply to idle.
> 
> Also, the change pattern doesn't contain a __balance_callback()
> invocation and hence we could have an out-of-band balance-callback,
> which *should* trigger the WARN in rq_pin_lock() (which guards against
> this exact anti-pattern).
> 
> So while none of that explains how this happens, it does indicate that
> having it in set_next_task() might not be the most robust option.
> 
> Instead, explicitly queue the forceidle balancer from pick_next_task()
> when it does indeed result in forceidle selection. Having it here,
> ensures it can only be triggered under the __schedule() rq->lock
> instance, and hence must be ran from that context.
> 
> This also happens to clean up the code a little, so win-win.

So I couldn't figure out how this could happen without triggering other
warnings, because as I mentioned elsewhere, commit 565790d28b1e ("sched:
Fix balance_callback()") should've caused a different splat.

But then Dietmar reminded me that ChromeOS is probably running some
ancient crud with backports on :/ and will most likely not have that
commit.

