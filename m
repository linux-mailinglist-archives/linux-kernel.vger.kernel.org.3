Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95516472AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhLMLJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:09:11 -0500
Received: from foss.arm.com ([217.140.110.172]:51818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhLMLJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:09:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05ACD6D;
        Mon, 13 Dec 2021 03:09:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 639543F793;
        Mon, 13 Dec 2021 03:09:06 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:09:03 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 3/9] atomic: Introduce
 atomic_{inc,dec,dec_and_test}_overflow()
Message-ID: <Ybcpz1XIU8+EtSV3@FVFF77S0Q05N>
References: <20211210161618.645249719@infradead.org>
 <20211210162313.464256797@infradead.org>
 <YbcbCQ/ySN8ZpTWR@FVFF77S0Q05N>
 <YbcnpAjgJSRIAduN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbcnpAjgJSRIAduN@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:59:48AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 13, 2021 at 10:06:01AM +0000, Mark Rutland wrote:
> > On Fri, Dec 10, 2021 at 05:16:21PM +0100, Peter Zijlstra wrote:
> 
> > > +#ifndef arch_atomic_inc_overflow
> > > +#define arch_atomic_inc_overflow(_v, _label)				\
> > > +do {									\
> > > +	int __old = arch_atomic_fetch_inc(_v);			\
> > > +	if (unlikely(__old <= 0))					\
> > > +		goto _label;						\
> > > +} while (0)
> > > +#endif
> > > +
> > > +#ifndef arch_atomic_dec_overflow
> > > +#define arch_atomic_dec_overflow(_v, _label)				\
> > > +do {									\
> > > +	int __new = arch_atomic_dec_return(_v);			\
> > > +	if (unlikely(__new <= 0))					\
> > > +		goto _label;						\
> > > +} while (0)
> > > +#endif
> > > +
> > > +#ifndef arch_atomic_dec_and_test_overflow
> > > +#define arch_atomic_dec_and_test_overflow(_v, _label)		\
> > > +({									\
> > > +	bool __ret = false;						\
> > > +	int __new = arch_atomic_dec_return(_v);			\
> > > +	if (unlikely(__new < 0))					\
> > > +		goto _label;						\
> > > +	if (unlikely(__new == 0))					\
> > > +		__ret = true;						\
> > > +	__ret;								\
> > > +})
> > > +#endif
> > 
> > I had wanted to move at least part of this to a function to ensure
> > single-evaluation and avoid accidental symbol aliasing, but (as we discussed
> > over IRC) I couldn't find any good way to do so, and given this is sufficiently
> > specialise I think we should be ok with this as-is. It's certainly no worse
> > than the existing stuff for xchg/cmpxchg.
> 
> Right, as you know I tried the same :-) Anyway, the above macros should
> be free of multi-evaluation issues, both _v and _label are only used the
> once. Aliassing is always a possibility but minimized by __ prefixing
> the local variables.

Agreed! I just wanted something archived in the thread mentioning that this was
the only practical option.

I agree that as this stands we're not doing anything sufficiently complicated
enough to worry about multi-evaluation, and that the underscores should be
sufficient to avoid aliasing in practice.

Mark.


