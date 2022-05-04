Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9490451B00D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350061AbiEDVHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiEDVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:07:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2095132C;
        Wed,  4 May 2022 14:04:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651698253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yscU3WybghtmL24CPVhfe3Npv35TWeHhUhbLPNB/baI=;
        b=2o4PulypsEzEaBWVKXUxymwhkYsJP/KTJPjb8FRZr+Ih3SjC7rNRe3gMTZ62Zhxqe08LUl
        Prn+Gl88cMnO4fy59CKk9MWSFjSSblnj75szVkZXRS/pw218lyTttRm8hs69hlbqvD5+4r
        j7Spi2zSB+/qZi6XUycE2WBtWCrd759FD1kpHPRuXmY/gpuftQmIGEQRFXTcEd9Llm67b4
        VvIdre3I7NblZMLPy0gpoT6K7GeJsxSeVK3liXZ5Ry0rAF7vzYZhWyNs3AmbfDo3ov9PGt
        jIaFLQEVGPftCkXx7bujbixeFC6j2mpTed3UhJijSNvnblLacC+JRVzZhTCuqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651698253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yscU3WybghtmL24CPVhfe3Npv35TWeHhUhbLPNB/baI=;
        b=XRJx8U7T2flBHP2xUg1gwUnEZLffldEyfEe3a60XlUALYx+birhCBL4LUAs3gFlFAAI227
        Vi33mqjq76SNcODQ==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
In-Reply-To: <YnLOXZp6WgH7ULVU@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de> <Ym/sHqKqmLOJubgE@zn.tnic>
 <87k0b4lydr.ffs@tglx> <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx> <YnKh96isoB7jiFrv@zx2c4.com> <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com>
Date:   Wed, 04 May 2022 23:04:12 +0200
Message-ID: <87wnf1huwj.ffs@tglx>
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

On Wed, May 04 2022 at 21:05, Jason A. Donenfeld wrote:
> The other stance is that these input/disk events are relatively rare --
> compared to, say, a storm of interrupts from a NIC -- so mixing into the
> input pool from there isn't actually a problem, and we benefit from the
> quasi domain-specific accounting and the superior mixing function,
> there, so keep it around. And the non-raw spinlock on the input pool
> won't negatively affect RT from this context, because all its callers on
> RT should be threaded.

I'm not worried about RT here.

> The second stance seems easier and more conservative from a certain
> perspective -- we don't need to change anything -- so I'm more inclined
> toward it.

That's not conservative, that's lazy and lame. Staying with the status
quo and piling more stuff on top because we can is just increasing
technical debt. Works for a while by some definition of works.

> And given that you've fixed the bug now, it sounds like that's fine
> with you too. But if you're thinking about it differently in fact, let
> me know.

That still does not address my observation that using the FPU for this
mixing, which is handling a couple of bytes per invocation, is not
really benefitial.

Which in turn bears the question, why we have to maintain an asymmetric
FPU protection mechanism in order to support hard interrupt FPU usage
for no or questionable benefit.

The current implementation, courtesy to hard interrupt support, has the
following downside:

  Any FPU usage in task context where soft interrupts are enabled will
  prevent FPU usage in soft interrupt processing when the interrupt hits
  into the FPU usage region. That means the softirq processing has to
  fall back to the generic implementations.

Sure, the protection could be context dependent, but that's generally
frowned upon. If we go there, then there has to be a really convincing
technical argument.

Thanks,

        tglx
