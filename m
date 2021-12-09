Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877AC46E933
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbhLINhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhLINhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:37:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1573AC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 05:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B6f8tntiTzzAseKWTv2hDwefK0R/Vt35xAxhbJywlpk=; b=qxDw+ksXKt+7cndN0em5gMQ9l+
        MSzVsNg5yI7OuufW8KAWomirK6He53N8DT8qvpNaa0lRiam3/wP3Do/mFLwpgM1yseMAElZ+GjmPu
        09VN7XYg3LIXaxMRu3S+8uck8MhwE92ndghTpW5Pg0vsW95itSwKWEsibWq8VEKnnK5+jgwTup10H
        85Cgmrg+NXCfHKhr0SR7gc8X5wMfk6ALUZK1p8scK0reahaKT7pOAa6TS15ZkS2sjAfnJa7h7HxrI
        FIMMWdhcXebGL2bQ1b6XAL53YYnxTXjqpJBxAlx3kXSdqIzpLRtvnVm5H6nh3s0P8Ai/jhuLT9vgy
        M0chSoHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvJYr-000N2r-8g; Thu, 09 Dec 2021 13:34:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE7C63000E6;
        Thu,  9 Dec 2021 14:34:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1B692BBA4086; Thu,  9 Dec 2021 14:34:11 +0100 (CET)
Date:   Thu, 9 Dec 2021 14:34:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [RFC][PATCH 1/5] atomic: Introduce
 atomic_{inc,dec,dec_and_test}_ofl()
Message-ID: <YbIF02MADsQvPyHz@hirez.programming.kicks-ass.net>
References: <20211208183655.251963904@infradead.org>
 <20211208183906.389506784@infradead.org>
 <YbH5x4FuIwj5krMO@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbH5x4FuIwj5krMO@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 12:42:47PM +0000, Mark Rutland wrote:
> On Wed, Dec 08, 2021 at 07:36:56PM +0100, Peter Zijlstra wrote:
> > In order to facilitate architecture support for refcount_t, introduce
> > a number of new atomic primitives that have a uaccess style exception
> > for overflow.
> > 
> > Notably:
> > 
> >   atomic_inc_ofl(v, Label) -- increment and goto Label when
> > 			      v is zero or negative.
> > 
> >   atomic_dec_ofl(v, Label) -- decrement and goto Label when
> > 			      the result is zero or negative
> > 
> >   atomic_dec_and_test_ofl(v, Label) -- decrement and return true when
> > 				       the result is zero and goto Label
> > 				       when the result is negative
> 
> Just to check, atomic_inc_ofl() tests the *old* value of `v`, and the other
> cases check the *new* value of `v`?
> 
> For clarity, in the descriptions it might be worth:
> 
>   s/v/the old value of v/
>   s/the result/the new value of v/
> 
> ... which I think makes that clearer.

Right, I'll clarify.

> > Since the GCC 'Labels as Values' extention doesn't allow having the
> > goto in an inline function, these new 'functions' must in fact be
> > implemented as macro magic.
> 
> Oh; fun... :(

Yeah, I tried all sorta things, it's all >.< close to working but then
GCC refuses to do the sensible thing.

> > This meant extending the atomic generation scripts to deal with
> > wrapping macros instead of inline functions. Since
> > xchg/cmpxchg/try_cmpxchg were already macro magic, there was existant
> > code for that. While extending/improving that a few latent
> > 'instrumentation' bugs were uncovered and 'accidentally' fixed.
> 
> I assume for non-RFC we can split that out into a preparatory patch. :)

Sure, I can split it in two; one add the infra and fix bugs and two
introduce the new ops.
