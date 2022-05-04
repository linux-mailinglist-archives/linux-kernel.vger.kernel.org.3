Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC951B3D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiEEAFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382706AbiEDX4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:56:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58F04E3BD;
        Wed,  4 May 2022 16:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A2E0B827B2;
        Wed,  4 May 2022 23:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B5AC385A4;
        Wed,  4 May 2022 23:52:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Xc8ZsKYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651708354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RhWrhB/pJDJtUIEjANxHfC2hV+/L/PFBqp4ZrDUMmMs=;
        b=Xc8ZsKYyfQYJsg94Vj7Frp+VSERu3KKWi7wDL1PzWR3et9yruS8xtiHdbfGZTobV5aghAA
        SVmw0WOSvhkAw97LNk2Nq3Pg1pZ+I/QZVuf1zX6Tc3g8pakLowDOHMyBaGxQjv/8hIck4J
        a9sPVHQj/eUEKnQJR7j7whiHw0/BQbU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e9307e2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 23:52:34 +0000 (UTC)
Date:   Thu, 5 May 2022 01:52:32 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <YnMRwPFfvB0RlBow@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de>
 <Ym/sHqKqmLOJubgE@zn.tnic>
 <87k0b4lydr.ffs@tglx>
 <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx>
 <YnKh96isoB7jiFrv@zx2c4.com>
 <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com>
 <87wnf1huwj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnf1huwj.ffs@tglx>
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

On Wed, May 04, 2022 at 11:04:12PM +0200, Thomas Gleixner wrote:

> > The second stance seems easier and more conservative from a certain
> > perspective -- we don't need to change anything -- so I'm more inclined
> > toward it.
> 
> That's not conservative, that's lazy and lame. Staying with the status
> quo and piling more stuff on top because we can is just increasing
> technical debt. Works for a while by some definition of works.

I actually find this minorly upsetting :(. Considering the amount of
technical debt I've been tirelessly cleaning up over the last 5 months,
"lazy" certainly can't be correct here. None of this has anything to do
with laziness, but rather how the entropy collection logic works out.
It'd be lazy to just wave my hands around and say, "oh well it's handled
in add_interrupt_randomness() anyway, so let's torch the other thing,"
without having taken the time to do the analysis to see if that's
actually true or not. One way or another, it _will_ require real
analysis. Which obviously I'm volunteering to do here (it's an
interesting question to me) and have already started poking around with
it.

> > And given that you've fixed the bug now, it sounds like that's fine
> > with you too. But if you're thinking about it differently in fact, let
> > me know.
> 
> That still does not address my observation that using the FPU for this
> mixing, which is handling a couple of bytes per invocation, is not
> really benefitial.
> 
> Which in turn bears the question, why we have to maintain an asymmetric
> FPU protection mechanism in order to support hard interrupt FPU usage
> for no or questionable benefit.
> 
> The current implementation, courtesy to hard interrupt support, has the
> following downside:
> 
>   Any FPU usage in task context where soft interrupts are enabled will
>   prevent FPU usage in soft interrupt processing when the interrupt hits
>   into the FPU usage region. That means the softirq processing has to
>   fall back to the generic implementations.
> 
> Sure, the protection could be context dependent, but that's generally
> frowned upon. If we go there, then there has to be a really convincing
> technical argument.

That's curious about the softirq; I hadn't realized that. Indeed it
sounds like the technical burden of supporting it may not be worth it.
From the perspective of high-speed crypto, I know two areas pretty well:
pacrypt/padata and wireguard's queueing. Both of these run in workqueues
pinned to a CPU with queue_work_on(). In some cases, I believe locks may
be held during various crypto operations though. Also, I suspect some
paths of xfrm and mac80211 may process during softirq. Anyway, none of
those cases is hardirq. I haven't looked at dmcrypt, but I'd be
surprised if that was doing anything in hardirqs either.

So if truly the only user of this is random.c as of 5.18 (is it? I'm
assuming from a not very thorough survey...), and if the performance
boost doesn't even exist, then yeah, I think it'd make sense to just get
rid of it, and have kernel_fpu_usable() return false in those cases.

I'll run some benchmarks on a little bit more hardware in representative
cases and see.

Jason
