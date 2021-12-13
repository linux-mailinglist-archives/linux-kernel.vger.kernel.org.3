Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC58472AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhLMK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhLMK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:57:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813DFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JXkpO3XHIfwAdjxXNEfPd3do/JwvYSS6U0o195N1K9g=; b=MPMuSutY5SbTXwQ09XTDPJ7G23
        jWu3rt2GtFQ7Tl0RM46i0Cca6VSvJAQcRl8zjLRtkKaJ1JRVQNT8LsT1tNWaqsjkyrsA7OcRCgrS+
        HkA0k6nqzMMh3G6XfsL4UJpDRxtp5JijWetKjb9wxpmcKxASVjF3occwofielpPE4V0CLod0l4+PI
        u3g52AdXsUm3z5AOhas0a16zm3oclvW8cAv/lPeQziqSxVihNShmCzVlN2T21BegL/cL0kRjoMIe2
        VsjWgqCckv2tGNEhrtI7daKmly8YX2OAc1PJiUGwBiYfCW5Ulf13zEKTMAiA37gkmxle61iMH/2T8
        koqFlyvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwj1T-00173p-9f; Mon, 13 Dec 2021 10:57:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D521A30026A;
        Mon, 13 Dec 2021 11:57:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2FF82D2B0A04; Mon, 13 Dec 2021 11:57:33 +0100 (CET)
Date:   Mon, 13 Dec 2021 11:57:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 3/9] atomic: Introduce
 atomic_{inc,dec,dec_and_test}_overflow()
Message-ID: <YbcnHZtbcpLMkoGp@hirez.programming.kicks-ass.net>
References: <20211210161618.645249719@infradead.org>
 <20211210162313.464256797@infradead.org>
 <YbcbCQ/ySN8ZpTWR@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbcbCQ/ySN8ZpTWR@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:06:01AM +0000, Mark Rutland wrote:
> On Fri, Dec 10, 2021 at 05:16:21PM +0100, Peter Zijlstra wrote:
> > In order to facilitate architecture support for refcount_t, introduce
> > a number of new atomic primitives that have a uaccess style exception
> > for overflow.
> > 
> > Notably:
> > 
> >   atomic_inc_overflow(v, Label):
> > 
> > 	increment and goto Label when the old value of v is zero or
> > 	negative.
> > 
> >   atomic_dec_overflow(v, Label):
> > 
> > 	decrement and goto Label when the new value of v is zero or
> > 	negative
> > 
> >   atomic_dec_and_test_overflow(v, Label):
> > 
> > 	decrement and return true when the result is zero and goto
> > 	Label when the new value of v is negative
> 
> Maybe it's worth adding these as comments in the fallback, which we have for a
> few existing functions, e.g.
> 
> | /**
> |  * arch_${atomic}_add_negative - add and test if negative
> |  * @i: integer value to add 
> |  * @v: pointer of type ${atomic}_t
> |  *
> |  * Atomically adds @i to @v and returns true
> |  * if the result is negative, or false when
> |  * result is greater than or equal to zero.
> |  */
> | static __always_inline bool
> | arch_${atomic}_add_negative(${int} i, ${atomic}_t *v) 
> | {
> |         return arch_${atomic}_add_return(i, v) < 0;
> | }
> 
> Not a big deal either way.

I can do that; but the whole ATOMIC*_OVERFLOW_OFFSET thing complicates
all this somewhat. Still, let me try, I've gotta document that anyway..
