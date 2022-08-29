Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8FD5A5501
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiH2T43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiH2T4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:56:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095C883BF5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A91560F4D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A3EC433D6;
        Mon, 29 Aug 2022 19:56:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZaGNOfmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1661802967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ah8CVAiN+uoE/qZr3aB6GUys/H3CZdI2qxXh6vsSvrg=;
        b=ZaGNOfmQd3S9wgthc+iP/y82OiNTxmVcG7GXPjQzOKlZyFWVqbiZ2/zF8eTTVMIfilJikC
        6r6Cp/tZinhERjmbjNIxDp6rft1LOHa3rlMAXeaGvYpMJitnbZrMAlCIaArQP5KA+chBfC
        GGL9n6uTEcJBbIlGTKOTvw8gypfNHIc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0dc6a6af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 29 Aug 2022 19:56:07 +0000 (UTC)
Date:   Mon, 29 Aug 2022 15:56:06 -0400
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <Yw0Z1jvwHEQQq8Zw@zx2c4.com>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de>
 <YvRKm/IpbUID18FK@zx2c4.com>
 <YvSsf5uds7zGgWPX@linutronix.de>
 <YvUQJTDREXSAA9J6@zx2c4.com>
 <Yw0XRtgh2dmSM+T1@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yw0XRtgh2dmSM+T1@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Mon, Aug 29, 2022 at 09:45:10PM +0200, Sebastian Andrzej Siewior wrote:
> > So why don't we actually fix this, so we don't have to keep coming up
> > with hacks? The question is: does using raw spinlocks over this code
> > result in any real issue for RT latency? If so, I'd like to know where,
> > and maybe I can do something about that (or maybe I can't). If not, then
> > this is a non problem and I'll apply this patch with your blessing.
> 
> It depends on what you do define as hacks. I suggested an explicit init
> during boot for everyone. The only "hacky" thing might be the reschedule
> of the worker every two secs in case random-core isn't ready yet.

The worker solution you proposed before was problematic in that it
changes RNG semantics by making jitter entropy run early on at boot
before even attempting to get entropy from later. Maybe that's an okay
change, or maybe it's not, but either way it isn't one that should be
forced by wacky vnsprintf changes.

> RNG may be used from any context but I doubt if this also includes any
> context on RT. (Side note: it does not include NMI but in general any
> context, yes.)
> The work in hardirq context is limited on RT and therefore I doubt that
> there is any need to request random numbers (from hardirq, preempt or
> IRQ disabled context) on PREEMPT RT on a regular basis. We had (have)
> requests where this is needed but we managed to avoid it.
> Another example: While kmalloc() can be invoked from any context, it
> still must not be used on PREEMPT_RT from hardirq context and or
> preempt-disabled regions.

Okay but this on-demand aspect of vnsprintf() is clearly a place where
it makes sense to do it from the occasional irq context.

> So that local_lock_t is still breaking things since it can not be
> acquired from blocking context. So in order to continue this needs to be
> replaced somehow and checked again…
> Assuming this has been done, round #2:
> 
> get_random_bytes()
> -> _get_random_bytes()
>   -> crng_make_state()
>     -> crng_reseed()
>       -> extract_entropy()
>         -> blake2s_final()
> 	  -> blake2s_compress()
> 	    -> kernel_fpu_begin()…

kernel_fpu_begin() is no longer used from IRQ context, since there's no
longer SIMD in IRQ context. So this callgraph isn't representative.

> This blake2s_compress() can be called again within this callchain (via
> blake2s()). The problem here is that kernel_fpu_begin() disables
> preemption and the following SIMD operation can be expensive (not to
> mention the onetime register store) and so it is attempted to have a
> scheduling point on a regular basis.
> Invoking this call chain from an already preempt-disabled section would
> not allow any scheduling at this point (and so build up the max. latency
> worst case).

Irrelevant, since kernel_fpu_begin() shouldn't be called in this context
any more, right?

> After looking at this after a break, while writing this and paging
> everything in, I still think that initialising the random number at boot
> up for vsprintf's sake is the easiest thing. One init for RT and non-RT
> from an initcall. No hack, just one plain and simple init with no need
> to perform anything later on demand. 

The "once at boot time" thing does not work here, as I've said over and
over, if what we're talking about is the workqueued get_random_bytes_wait()
call. The much smarter thing to do is let entropy be collected for as
long as possible, and when the RNG is initialized, initialize the
siphash secret, which is exactly what the current code does. So I think
the current vnsprintf code can stay the same. What needs fixing, rather,
are the lack of raw spinlocks in random.c...

In light of my note on kernel_fpu_begin() not being used from IRQ
context, can you now consider this raw spinlock patch?

Jason
