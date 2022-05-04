Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84A51A5D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353604AbiEDQt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353110AbiEDQtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:49:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FEE6442;
        Wed,  4 May 2022 09:45:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651682746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMixN8cuqlcIWYEYdCj7kZizdE9V6yCD9qvxJl7kpU4=;
        b=aZp5uSAMO1Lhaqq9CN2P0GEVbg+kN095nF1t4DC2J9tMeNKXBbHmBjiQTw2XtIGig/AtRL
        cgG6kUIVKpSltAvs9fiIBRVLDnVaXoc+4KQmWJXZRBuJMmbqe6DsgMvqaRiMI1WHKhi/iN
        CXkr4XNBzD1UnRYZcSvQBdKBF3hXxxjaskwODvqAn1qnamSHDDlpbqJhuxN5ei9tpsvUbN
        HGSWpea+kUQWkX6aAn+tnYXGtcWbg4Aj+0VmN8gw8UtdkZ9KnfrO9OyvjA7liyR/N7cvPa
        T4U1uYB2f9lfG73hPHMH5ryHU7A9t4SWhfQ1C5A81CQ2qh17rIXsgoDNjgafbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651682746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMixN8cuqlcIWYEYdCj7kZizdE9V6yCD9qvxJl7kpU4=;
        b=M805BnjFPz7Ky1Fn4P7lC/lUY7igEkaLMi2ZCxiYCDs0eNWT3KuB2EPvxy/uea2N6KTgKp
        iBhBieR4eq/9+7AA==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
In-Reply-To: <YnKh96isoB7jiFrv@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de> <Ym/sHqKqmLOJubgE@zn.tnic>
 <87k0b4lydr.ffs@tglx> <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx> <YnKh96isoB7jiFrv@zx2c4.com>
Date:   Wed, 04 May 2022 18:45:45 +0200
Message-ID: <87czgtjlfq.ffs@tglx>
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

On Wed, May 04 2022 at 17:55, Jason A. Donenfeld wrote:
> On Wed, May 04, 2022 at 05:36:38PM +0200, Thomas Gleixner wrote:
>> But the only use case which utilizes FPU from hard interrupt context is
>> the random generator via add_randomness_...().
>> 
>> I did a benchmark of these functions, which invoke blake2s_update()
>> three times in a row, on a SKL-X and a ZEN3. The generic code and the
>> FPU accelerated code are pretty much on par vs. execution time of the
>> algorithm itself plus/minus noise.
>>
>> IOW, using the FPU blindly for this kind of computations is not
>> necessarily a good plan. I have no idea how these things are analyzed
>> and evaluated if at all. Maybe the crypto people can shed some light on
>> this.
>
> drivers/net/wireguard/{noise,cookie}.c makes pretty heavy use of BLAKE2s
> in hot paths where the FPU is already being used for other algorithms,
> and so there the save/restore is worth it (assuming restore finally
> works lazily). In benchmarks, the SIMD code made a real difference.

I'm sure there are very valid use cases, but just the two things I
looked at turned out to be questionable at least.

> But this presumably regards mix_pool_bytes() in the RNG. If it turns out
> that supporting the FPU in hard IRQ context is a major PITA, and the
> RNG

Supporting FPU in hard interrupt context is possible if required and the
preexisting bug which survived 10+ years has been fixed.
x
I just started to look into this because of that bug and due to the
inconsistency between the FPU protections we have. The inconsistency
comes from the hardirq requirement.

> is the only thing making use of it, then sure, drop hard IRQ context
> support for it. However... This may be unearthing a larger bug.
> Sebastian and I put in a decent amount of work during 5.18 to remove all
> calls to mix_pool_bytes() (and hence to blake2s_compress()) from
> add_interrupt_randomness(). Have a look:

I know.

> It now accumulates in some per-CPU buffer, and then every 64 interrupts
> a worker runs that does the actual mix_pool_bytes() from kthread
> context.

That's add_interrupt_randomness() and not affected by this.

> So the question is: what is still hitting mix_pool_bytes() from hard IRQ
> context? I'll investigate a bit and see.

add_disk_randomness() on !RT kernels. That's what made me look into this
in the first place as it unearthed the long standing FPU protection
bug. See the first patch in this thread.

Possibly add_device_randomness() too, but I haven't seen evidence so far.

Thanks,

        tglx
