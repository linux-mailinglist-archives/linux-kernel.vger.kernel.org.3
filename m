Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A289951E210
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444694AbiEFWTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444707AbiEFWTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4AABD2;
        Fri,  6 May 2022 15:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB886611D1;
        Fri,  6 May 2022 22:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1F4C385A8;
        Fri,  6 May 2022 22:15:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pOI5hGxD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651875318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WrY3HsKWQNSyKWcHZ9De8AVQuhdOwlvdLddYWMvFUkY=;
        b=pOI5hGxD8Nn68Qt3XNIHod2+bb2QHkAtR4AuuSM+f8Bkst7iStgI+5TfNODC78/iQ5PNQT
        LrDXwFoEMP6GhmvI3N4aU1p2eq54+cbjSBm2NFpXrOl/zyDtmYQLbfHtd4FFIlVcKbJ7K5
        eu47V1/3izpL8l27LU88thCK+Q4nQMg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e3d5def3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 6 May 2022 22:15:18 +0000 (UTC)
Date:   Sat, 7 May 2022 00:15:16 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <YnWd9O3bH1zI+5cE@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de>
 <Ym/sHqKqmLOJubgE@zn.tnic>
 <87k0b4lydr.ffs@tglx>
 <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx>
 <YnKh96isoB7jiFrv@zx2c4.com>
 <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnLOXZp6WgH7ULVU@zx2c4.com>
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

On Wed, May 04, 2022 at 09:05:01PM +0200, Jason A. Donenfeld wrote:
> Hey Thomas,
> 
> On Wed, May 04, 2022 at 06:45:45PM +0200, Thomas Gleixner wrote:
> > add_disk_randomness() on !RT kernels. That's what made me look into this
> > in the first place as it unearthed the long standing FPU protection
> > bug. See the first patch in this thread.
> > 
> > Possibly add_device_randomness() too, but I haven't seen evidence so far.
> 
> It looks like it's being hit from add_input_randomness() via
> input_handle_event() too. There are two positions we could take toward
> this:
> 
> One stance to take would be that if an event happens in an interrupt,
> add_interrupt_randomness() should in theory already be siphashing in a
> cycle counter so additional calls to add_{input,disk}_randomness() don't
> contribute substantially (unless you assume the num field has some
> entropic value). If that's compelling, then the next thing to do would
> be adding a `if (in_interrupt()) return;` early on in some function, and
> then we forever after impose a rule, "never mix into the input pool
> directly from an irq".
> 
> The other stance is that these input/disk events are relatively rare --
> compared to, say, a storm of interrupts from a NIC -- so mixing into the
> input pool from there isn't actually a problem, and we benefit from the
> quasi domain-specific accounting and the superior mixing function,
> there, so keep it around. And the non-raw spinlock on the input pool
> won't negatively affect RT from this context, because all its callers on
> RT should be threaded.

It turned out to be more complicated than this. Sometimes a given
interrupt handler would have multiple calls to add_disk_randomness(),
followed by a single call to add_interrupt_randomness(). Since those
multiple calls all represent different things being measured, the second
option of discarding them didn't seem like a good idea, but the first
option seemed pretty bad too, since the status quo is way too much
hashing from an irq handler. Further complicating things is the fact
that add_{input,disk}_randomness() is never just called from irq or from
elsewhere, as different drivers do different things. Luckily the way the
entropy estimator currently works allows for a pretty straight forward
compromise, which I posted here:

https://lore.kernel.org/lkml/20220506215454.1671-2-Jason@zx2c4.com/

The upshot for this discussion is that it means we can probably get rid
of hard irq FPU support. (This is in addition to the performance
argument, in which tentatively it seemed like the difference wasn't
/that/ much to justify the complexity.)

I intend to mull this over a bit more, though, so if my patch is to make
it in, it'll be for 5.19 and certainly not 5.18. So for 5.18, I think
it's probably a good idea to apply the patches in this thread. And then
for 5.19 we can take the next step.

Jason
