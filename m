Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C1951B537
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiEEBZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiEEBZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:25:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60EF506FD;
        Wed,  4 May 2022 18:21:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651713704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKuGwdSJtS+WiXghVoIOPpH32AVOKBI/15oCiMuq+jQ=;
        b=mlX+me3NOGEr2QS8iofK25Nzt/JMyKvAWUFvlEBfi3vgWJWAbGFlCJZZBCi9XfpgkVGdTp
        ezzlLg4sna1GNariY6xv6alMom9mPBIouX8Dz2xknquqKah6lac/eiY40VaI1BdYxv6+kz
        Rsi9x2ic0FV2GhKQ2a5iLUEkxa80w9VhYdzzIOiChlSow5SrbTchqbqhobT4Kcta8tBYu9
        u/rOBZfDm6UYayws4BisIIPNBInm0iKwNm+3i3iBGIan9fTxv1DLqdlwe8dxtP5qhYd0Xa
        BkJMpAmi9qf0duNXFF/25xIvCndY8vKkScVwYD/cAMHO+ZlKsLlokQ0ReZ/Xpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651713704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKuGwdSJtS+WiXghVoIOPpH32AVOKBI/15oCiMuq+jQ=;
        b=ah23Qu7hQPYvzXRQTkxFXgnobMZPJBL9gXOSfAFn0Ru7tgFXZpLOI06TDd8B5iP1IE87o4
        Uv3voCCxRFzNvIAg==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
In-Reply-To: <YnMkRLcxczMxdE5z@zx2c4.com>
References: <Ym/sHqKqmLOJubgE@zn.tnic> <87k0b4lydr.ffs@tglx>
 <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net> <87fslpjomx.ffs@tglx>
 <YnKh96isoB7jiFrv@zx2c4.com> <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com> <87wnf1huwj.ffs@tglx>
 <YnMRwPFfvB0RlBow@zx2c4.com> <87mtfwiyqp.ffs@tglx>
 <YnMkRLcxczMxdE5z@zx2c4.com>
Date:   Thu, 05 May 2022 03:21:43 +0200
Message-ID: <87h764ixjs.ffs@tglx>
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

Jason,

On Thu, May 05 2022 at 03:11, Jason A. Donenfeld wrote:
> On Thu, May 05, 2022 at 02:55:58AM +0200, Thomas Gleixner wrote:
>> > So if truly the only user of this is random.c as of 5.18 (is it? I'm
>> > assuming from a not very thorough survey...), and if the performance
>> > boost doesn't even exist, then yeah, I think it'd make sense to just get
>> > rid of it, and have kernel_fpu_usable() return false in those cases.
>> >
>> > I'll run some benchmarks on a little bit more hardware in representative
>> > cases and see.
>> 
>> Find below a combo patch which makes use of strict softirq serialization
>> for the price of not supporting the hardirq FPU usage. 
>
> Thanks, I'll give it a shot in the morning (3am) when trying to do a
> more realistic benchmark. But just as a synthetic thing, I ran the
> numbers in kBench900 and am getting:
>
>      generic:    430 cycles per call
>        ssse3:    315 cycles per call
>       avx512:    277 cycles per call
>
> for a single call to the compression function, which is the most any of
> those mix_pool_bytes() calls do from add_{input,disk}_randomness(), on
> Tiger Lake, using RDPMC from kernel space.

I'm well aware of the difference between synthetic benchmarks and real
world scenarios and with the more in depth instrumentation of these
things I'm even more concerned that the difference is underestimated.

> This _doesn't_ take into account the price of calling kernel_fpu_begin().
> That's a little hard to bench synthetically by running it in a loop and
> taking medians because of the lazy restoration. But that's an indication
> anyway that I should be looking at the cost of the actual function as
> its running in random.c, rather than the synthetic test. Will keep this
> thread updated.

Appreciated.

Thanks,

        tglx
