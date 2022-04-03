Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE54F0CEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 01:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376652AbiDCXZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 19:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDCXY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:24:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7537AB9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 16:23:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649028182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFT29KGwTL9/a9j1ulmt1kYHc8JakC8y8u/vUFmDr+A=;
        b=oKcXZxVmrLomnV5AsXRBhGhqXA9vCgY/eiH1njhtDtvi31fogEVobD4FgD9XyK2RIkMWP8
        E5cd88uv2yVBUzPDIktA81HSnnmfo5RmUXiqYynkX0wYtmqqOK3kKbkb9riKdjzokCHmud
        V7fRLQu88KQTytC4eE5z+Qhggynauv0UjVevnMiuSp3S0H+KCtvd5T8TUOtBPkElc92n06
        UKhzEgwEQMkGfDcIU9xJp1fJdB+S3Iw4YOyQ7BbJaTntPzvagGupPbqJxqTNUBUf7+J/Yf
        +SEG33ixkXIg2KkGy9RmlsziEJHD/Th7FuBgi7hWuWsVWK+Bdm9tcQiC2YbBvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649028182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFT29KGwTL9/a9j1ulmt1kYHc8JakC8y8u/vUFmDr+A=;
        b=YGB7Rj0dmCvxLzhM3h/vBXfAJufjTpO37DI71rK1x3yIr7HpdcrqmAT1PAv/W707+emBYR
        OB6q16rUGDhK5VCA==
To:     Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: UML time-travel warning from __run_timers
In-Reply-To: <43785c9c6ee74a995963144946c67893ebbf8852.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
 <877d86m978.ffs@tglx>
 <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
 <43785c9c6ee74a995963144946c67893ebbf8852.camel@sipsolutions.net>
Date:   Mon, 04 Apr 2022 01:23:01 +0200
Message-ID: <87h779lpka.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes,

On Sun, Apr 03 2022 at 19:19, Johannes Berg wrote:
> Actually, in a sense, this *is* the case of (just) recalculating
> next_expiry, no? We just never set next_expiry_recalc since there was
> never any timer on this?

why are you insisting on fishing in the dark? 

> So actually this also makes the warning go away:
>
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1729,6 +1733,7 @@ static inline void __run_timers(struct timer_base *base)
>  		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
>  		base->clk++;
>  		base->next_expiry = __next_timer_interrupt(base);
> +		base->next_expiry_recalc = !levels;

You are papering over the problem. That makes the warnign go away, but
does not explain anyhting about the root cause. Can you please provide
the information which was asked for?

>  		while (levels--)
>  			expire_timers(base, heads + levels);
> @@ -2005,6 +2010,7 @@ static void __init init_timer_cpu(int cpu)
>  		raw_spin_lock_init(&base->lock);
>  		base->clk = jiffies;
>  		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
> +		base->next_expiry_recalc = true;

This is complete nonsense because at the point where the CPU base is
initialized next_expiry _IS_ correct at the outer max. Why would it be
required to be recalculated? The only reason why it needs to be
recalculated is when a timer is canceled before expiry, but there is
_NO_ timer which can be canceled at this point.

So what are you trying to solve here?

Thanks,

        tglx
