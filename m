Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA70A51A425
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352553AbiEDPkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352537AbiEDPkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:40:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D10F1659C;
        Wed,  4 May 2022 08:36:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651678599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXLtyiQ0yzGv0MwBOzbiZq4Wuv0+MbxgkH7y3R8DVS4=;
        b=TavzHSeFulEXeEchW8J2tstpjC4Ump7rBph2KtJdn/m2KNb3XlTkcX5shbBVGnotH6Zjr1
        zyzNNaGMCU+18h/Ymjz13Eu4cvzgLKkzfi048oOk2v5QznFrANKYAvgW/HdAXt3l0li20J
        +MrGXVfrevPJVZ/x+9QOiZQ/b7x6Ks1ot+nrxA9hcRwoXMgyLDS1s9MfE9nphOOEV8FV/V
        acKLJIVEHwzhWi7MbXSXgDqQUhf2PRCINMdESR/opEJJuz+cuycb7H4dYDDPZxbQt1rxY0
        hQ5roQ7rQtqsayhb2KlseGSaYnOBR4g2w5yuMOkyoz2f7Ex0YZmBwITOVxXWZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651678599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXLtyiQ0yzGv0MwBOzbiZq4Wuv0+MbxgkH7y3R8DVS4=;
        b=97RwyIZmaBA3/a0DfH0+3MS8W+jR6bZDalTSkrWixSHJK24ep0NRbiRQ9awpdskhiAfGum
        /5sy7rNqEAkYIEAg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
In-Reply-To: <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de> <Ym/sHqKqmLOJubgE@zn.tnic>
 <87k0b4lydr.ffs@tglx> <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
Date:   Wed, 04 May 2022 17:36:38 +0200
Message-ID: <87fslpjomx.ffs@tglx>
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

On Tue, May 03 2022 at 11:06, Peter Zijlstra wrote:
> On Mon, May 02, 2022 at 05:58:40PM +0200, Thomas Gleixner wrote:
>> Right, though currently it's guaranteed that softirq processing context
>> can use the FPU. Quite some of the network crypto work runs in softirq
>> context, so this might cause a regression. If so, then this needs to be
>> an explicit commit on top which is easy to revert. Let me stare at it
>> some more.
>
> Right, so with the:
>
> 	preempt_disable();
> 	this_cpu_write(fpu_in_use, true);
> 	barrier();
>
> sequence it is safe against both softirq and hardirq fpu usage. The only
> concern is performance not correctness when dropping that
> local_bh_disable() thing.
>
> So what Thomas proposes makes sense to me.

Now I was looking at it the other way round too; i.e. to use
local_bh_disable() for both fpregs_lock() and kernel_fpu_begin().

Using local_bh_disable() for both fpregs_lock() and kernel_fpu_begin()
is not possible with the current constraints, because kernel_fpu_begin()
can be called from hard interrupt context.

But the only use case which utilizes FPU from hard interrupt context is
the random generator via add_randomness_...().

I did a benchmark of these functions, which invoke blake2s_update()
three times in a row, on a SKL-X and a ZEN3. The generic code and the
FPU accelerated code are pretty much on par vs. execution time of the
algorithm itself plus/minus noise.

But in case that the interrupt hits a userspace task the FPU needs to be
saved and if the interrupt does not result in rescheduling then the
return to user space has to restore it. That's _expensive_ and the
actual cost depends on the FPU state, but 200-300 cycles for save and
200-700 cycles for restore are due.

Even if we ignore the save/restore part and assume that it averages out
vs. schedule() having to save FPU state anyway, then there is another
aspect to this: power consumption which affects also thermal budget and
capacity.

Though that made me more curious and I did the same comparison for crc32
which is heavily used by ext4. crc32c_pcl_intel_update() already
contains a switch to software when the buffer length is less than 512
bytes. But even on larger buffers, typically ~4k, FPU is not necessarily
a win. It's consistently slower by a factor of ~1.4x. And that's not due
to xsave/rstor overhead because these computations run on a worker
thread which does not do that dance at all.

IOW, using the FPU blindly for this kind of computations is not
necessarily a good plan. I have no idea how these things are analyzed
and evaluated if at all. Maybe the crypto people can shed some light on
this.

Thanks,

        tglx
