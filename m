Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13340473218
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbhLMQnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhLMQno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:43:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CF2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QFfj3JfXtSH606UePT3DdUfSX6jUDmhU9qIot+M7cwQ=; b=mTHxkDr01z8kNNn+J7DjZOM/hb
        Isk6nNDtKKIvFZEB7tas2XpC1EZBtAyhf0nsCtWTnOT5gqf2jKbPOu3oqMuVPwsxrGr3JyN54kNHB
        RdpiMPq7bViXV1y+R/xVe/uIkZNCwRSeG8gpXzAWRv3tMHx3TNnF1uL4n9Eu+IUZrZEohwMRh/yDz
        z3hneoXor2TN/LguMUHzs9HXgYyGRSPDqzeHWnCHLUKVfiOpvRXFhwoW0Rqfq52HdSNyz/PqTDI7U
        8M623Ex94MaZ2Ev9Mkqg4x5r+/wwGjHywECKT9vH1lRmmlCNUb1oYopC4i0D4lo+CMb7Wfn6oR6Dg
        b5p7ZRaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwoQJ-00Cxby-3n; Mon, 13 Dec 2021 16:43:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E49A9981767; Mon, 13 Dec 2021 17:43:34 +0100 (CET)
Date:   Mon, 13 Dec 2021 17:43:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        elver@google.com, keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 8/9] atomic,x86: Alternative atomic_*_overflow() scheme
Message-ID: <20211213164334.GY16608@worktop.programming.kicks-ass.net>
References: <20211210161618.645249719@infradead.org>
 <20211210162313.857673010@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210162313.857673010@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:16:26PM +0100, Peter Zijlstra wrote:
> Shift the overflow range from [0,INT_MIN] to [-1,INT_MIN], this allows
> optimizing atomic_inc_overflow() to use "jle" to detect increment
> from free-or-negative (with -1 being the new free and it's increment
> being 0 which sets ZF).
> 
> This then obviously changes atomic_dec*_overflow() since it must now
> detect the 0->-1 transition rather than the 1->0. Luckily this is
> reflected in the carry flag (since we need to borrow to decrement 0).
> However this means decrement must now use the SUB instruction with a
> literal, since DEC doesn't set CF.
> 
> This then gives the following primitives:
> 
> [-1, INT_MIN]					[0, INT_MIN]
> 
> inc()						inc()
> 	lock inc %[var]					mov       $-1, %[reg]
> 	jle	error-free-or-negative			lock xadd %[reg], %[var]
> 							test      %[reg], %[reg]
> 							jle	  error-zero-or-negative
> 
> dec()                                           dec()
> 	lock sub $1, %[var]				lock dec %[var]
> 	jc	error-to-free				jle	error-zero-or-negative
> 	jl	error-from-negative
> 
> dec_and_test()                                  dec_and_test()
> 	lock sub $1, %[var]				lock dec %[var]
> 	jc	do-free					jl	error-from-negative
> 	jl	error-from-negative			je	do-free
> 
> Make sure to set ATOMIC_OVERFLOW_OFFSET to 1 such that other code
> interacting with these primitives can re-center 0.

So Marco was expressing doubt about this exact interface for the
atomic_*_overflow() functions, since it's extremely easy to get the
whole ATOMIC_OVERFLOW_OFFSET thing wrong.

Since the current ops are strictly those that require inline asm, the
interface is fairly incomplete, which forces anybody who's going to use
these to provide whatever is missing. eg. atomic_inc_not_zero_overflow()
for example.

Another proposal had the user supply the offset as a compile time
constant to the function itself, raising a build-bug for any unsupported
offset. This would ensure the caller is at least aware of any non-zero
offset... still not going to really be dummy proof either.

Alternatively we could provide a more complete set of ops and/or a whole
new type, but... I'm not sure about that either.

I suppose I can try and do something like refcount_overflow_t and
implement the whole current refcount API in terms of that. Basically
everywhere we currently do refcount_warn_saturate() would become goto
label.

And then refcount_t could be a thin wrapper on top of that. But urgh...
lots of work, very little gain.

So what do we do? Keep things as is, and think about it again once we
got the first bug in hand, preemptively add a few ops or go completely
overboard?

Obviously I'm all for keeping things as is (less work for this lazy
bastard etc..)
