Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2DE51A4A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352934AbiEDP7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352928AbiEDP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E113D28;
        Wed,  4 May 2022 08:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 371E161777;
        Wed,  4 May 2022 15:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9ECC385A5;
        Wed,  4 May 2022 15:55:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JYkvInkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651679739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6yyJ0k9BpvAv3H7drBawcClMMXzihm3exQEpiGY4xDM=;
        b=JYkvInkDkMu4DwG+axf7VkN0haw5B9+vh2KIgA9FtRpMP/P+uj58tA0EY5CX5HZi9hXxsC
        yWmjh1j06JEiIt+t8K2rzYnNZs8GWZr5Bq0IUPfY+awCBsG28xNUJ5LA1l1sYLDV5pRLRS
        4ijeE3RUiOvxmrqyP/rF9609ptPild0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bf1403c7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 15:55:38 +0000 (UTC)
Date:   Wed, 4 May 2022 17:55:35 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <YnKh96isoB7jiFrv@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de>
 <Ym/sHqKqmLOJubgE@zn.tnic>
 <87k0b4lydr.ffs@tglx>
 <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fslpjomx.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, May 04, 2022 at 05:36:38PM +0200, Thomas Gleixner wrote:
> But the only use case which utilizes FPU from hard interrupt context is
> the random generator via add_randomness_...().
> 
> I did a benchmark of these functions, which invoke blake2s_update()
> three times in a row, on a SKL-X and a ZEN3. The generic code and the
> FPU accelerated code are pretty much on par vs. execution time of the
> algorithm itself plus/minus noise.
>
> IOW, using the FPU blindly for this kind of computations is not
> necessarily a good plan. I have no idea how these things are analyzed
> and evaluated if at all. Maybe the crypto people can shed some light on
> this.

drivers/net/wireguard/{noise,cookie}.c makes pretty heavy use of BLAKE2s
in hot paths where the FPU is already being used for other algorithms,
and so there the save/restore is worth it (assuming restore finally
works lazily). In benchmarks, the SIMD code made a real difference.

But this presumably regards mix_pool_bytes() in the RNG. If it turns out
that supporting the FPU in hard IRQ context is a major PITA, and the RNG
is the only thing making use of it, then sure, drop hard IRQ context
support for it. However... This may be unearthing a larger bug.
Sebastian and I put in a decent amount of work during 5.18 to remove all
calls to mix_pool_bytes() (and hence to blake2s_compress()) from
add_interrupt_randomness(). Have a look:

https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/tree/drivers/char/random.c#n1289

It now accumulates in some per-CPU buffer, and then every 64 interrupts
a worker runs that does the actual mix_pool_bytes() from kthread
context.

So the question is: what is still hitting mix_pool_bytes() from hard IRQ
context? I'll investigate a bit and see.

Jason
