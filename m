Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE41D4732EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbhLMR3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbhLMR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:29:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F38C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 09:29:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d24so28470831wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 09:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hyGPpiwXiWTfWE++FjMW/J3pOXNgUwyYa+pKr29mqXc=;
        b=tHGsPumoFim4vKL2GTscaB3DFXAYKAHWSmHHPsj6rA4TJwQa4vqVHOMagA+9IFg2av
         tmBHq2lkJXyi81qHk4QJRaZwu6ItJGsZtylJSlgjsIBLEnQkmWz0EHzs4A1Wnoyi61gV
         IKACt02YcTbL9Y5NefofjJ4FOUR0Va3XNaaiCbny0sISdz/XUm7nMm8JNYnVBy+VJU7K
         8lUqHb9qXT/puI/nkbqixKhGRjR7O4n7rs6jLlk7P181ZF9N8OJXEBYSvyoc8tjRxU6w
         AceBmA8yBgzTsLGECwR2LSOw226v0rsEjr0v7ir6w0ce/hU8+VglDN9uWfdCwdso3NYy
         5NQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hyGPpiwXiWTfWE++FjMW/J3pOXNgUwyYa+pKr29mqXc=;
        b=n0U2iOdNzvYKp+FQg9Kf5AI2/bx2BLQ/uCbNUh07iq5i3ZC9gCvKGSJAmh5yQqbVum
         JCP5AoZSoFSBr1vFz/q8nO7c9ylrKk+mFFiQQzxUCOPTnMZX5WAWTbxx2nNvbV/bqXx+
         wabaHJ4BgGjp6de5s8EzjnAQNIhw/TomQXhO22n+iad0VwYty9QeHf9CQrwSZCSRCVHO
         fUqKj32JXJzbuN5w0MNQ6K/9MZdnVJuDQ8cgc3DxRgXo0iLs5j3rwiWD7aDOqipjstAf
         9/4nUduY4AbeJ/VKqzgu62EhLRycaPz9dVDVZaiRkMMMOHlFvqipsj7nfJrsso0eSBUu
         WRgA==
X-Gm-Message-State: AOAM5333JWmlp4emO62hD2Tx6341jQ5Pslg9uV/hzWbXrDbwppbFAZC0
        Slpulq2qKqI9181Q7ntuq8MpcQ==
X-Google-Smtp-Source: ABdhPJxEQd0FMs1a4s1YlJLTy0BPDcqgBSXVDJDmT7SC2n/cM4iZdJIvwj3TLv69fnW1/BjpKrGXjQ==
X-Received: by 2002:a05:6000:143:: with SMTP id r3mr33381306wrx.236.1639416574654;
        Mon, 13 Dec 2021 09:29:34 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:984e:fd4e:47c7:18be])
        by smtp.gmail.com with ESMTPSA id p12sm11488021wro.33.2021.12.13.09.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 09:29:34 -0800 (PST)
Date:   Mon, 13 Dec 2021 18:29:27 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 8/9] atomic,x86: Alternative atomic_*_overflow() scheme
Message-ID: <YbeC9ySoLlfKOZPq@elver.google.com>
References: <20211210161618.645249719@infradead.org>
 <20211210162313.857673010@infradead.org>
 <20211213164334.GY16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213164334.GY16608@worktop.programming.kicks-ass.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 05:43PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 10, 2021 at 05:16:26PM +0100, Peter Zijlstra wrote:
> > Shift the overflow range from [0,INT_MIN] to [-1,INT_MIN], this allows
> > optimizing atomic_inc_overflow() to use "jle" to detect increment
> > from free-or-negative (with -1 being the new free and it's increment
> > being 0 which sets ZF).
> > 
> > This then obviously changes atomic_dec*_overflow() since it must now
> > detect the 0->-1 transition rather than the 1->0. Luckily this is
> > reflected in the carry flag (since we need to borrow to decrement 0).
> > However this means decrement must now use the SUB instruction with a
> > literal, since DEC doesn't set CF.
> > 
> > This then gives the following primitives:
> > 
> > [-1, INT_MIN]					[0, INT_MIN]
> > 
> > inc()						inc()
> > 	lock inc %[var]					mov       $-1, %[reg]
> > 	jle	error-free-or-negative			lock xadd %[reg], %[var]
> > 							test      %[reg], %[reg]
> > 							jle	  error-zero-or-negative
> > 
> > dec()                                           dec()
> > 	lock sub $1, %[var]				lock dec %[var]
> > 	jc	error-to-free				jle	error-zero-or-negative
> > 	jl	error-from-negative
> > 
> > dec_and_test()                                  dec_and_test()
> > 	lock sub $1, %[var]				lock dec %[var]
> > 	jc	do-free					jl	error-from-negative
> > 	jl	error-from-negative			je	do-free
> > 
> > Make sure to set ATOMIC_OVERFLOW_OFFSET to 1 such that other code
> > interacting with these primitives can re-center 0.
> 
> So Marco was expressing doubt about this exact interface for the
> atomic_*_overflow() functions, since it's extremely easy to get the
> whole ATOMIC_OVERFLOW_OFFSET thing wrong.
> 
> Since the current ops are strictly those that require inline asm, the
> interface is fairly incomplete, which forces anybody who's going to use
> these to provide whatever is missing. eg. atomic_inc_not_zero_overflow()
> for example.
> 
> Another proposal had the user supply the offset as a compile time
> constant to the function itself, raising a build-bug for any unsupported
> offset. This would ensure the caller is at least aware of any non-zero
> offset... still not going to really be dummy proof either.

In the spirit of making the interface harder to misuse, this would at
least ensure that non-refcount_t code that wants to use
atomic_*overflow() is 100% aware of this. Which is half of the issue I
think.

The other half is code using the actual values, and ensuring it's offset
correctly. This might also be an issue in e.g. refcount_t, if someone
wants to modify or extend it, although it's easy enough to audit and
review in such central data structures as refcount_t.

> Alternatively we could provide a more complete set of ops and/or a whole
> new type, but... I'm not sure about that either.
> 
> I suppose I can try and do something like refcount_overflow_t and
> implement the whole current refcount API in terms of that. Basically
> everywhere we currently do refcount_warn_saturate() would become goto
> label.
> 
> And then refcount_t could be a thin wrapper on top of that. But urgh...
> lots of work, very little gain.
> 
> So what do we do? Keep things as is, and think about it again once we
> got the first bug in hand, preemptively add a few ops or go completely
> overboard?
> 
> Obviously I'm all for keeping things as is (less work for this lazy
> bastard etc..)

I think an entirely new type might be overkill, but at the very least
designing the interface such that it's

	A. either impossible to not notice the fact atomic_*overflow()
	   works in terms of offsets, or
	B. not even exposing this detail.

#A can be achieved with supplying offsets to atomic_*overflow(). #B can
be achieved with new wrapper types -- however, if we somehow ensure that
refcount_t remains the only user of atomic_*overflow(), I'd consider
refcount_t a wrapper type already, so no need to add more.

Regarding the interface, it'd be nice if it could be made harder to
misuse, but I don't know how much it'll buy over what it is right now,
since we don't even know if there'll be other users of this yet.

But here are some more issues I just thought of:

	1. A minor issue is inspecting raw values, like in register
	   dumps. refcount_t will now look different on x86 vs. other
	   architectures.

	2. Yet another potentially larger issue is if some code
	   kmalloc()s some structs containing refcount_t, and relies on
	   GFP_ZERO (kzalloc()) to initialize their data assuming that a
	   freshly initialized refcount_t contains 0.

I think #1 is a cosmetic issue, which we might be able to live with.

However, I have absolutely no idea how we can audit or even prevent #2
from happening. With #2 in mind, and with C's lack of enforcing any kind
of "constructors", the interface and implementation we end up with is
going to result in near-impossible to debug issues sooner or later.

Thanks,
-- Marco
