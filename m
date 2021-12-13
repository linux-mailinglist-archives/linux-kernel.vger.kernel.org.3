Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553BB472ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhLMK74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhLMK7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:59:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AIRLZy3MLfKJthu5L2tdTbQRLGi9J/E7QBJG+/pGbRU=; b=gt26BJtO6ArZSQwipwUwthsyVm
        FXqzOv0HNvCzv+XrwzWWCRENsec8V18QEVtjTgOD1uKbKfK1qXrX0blYJuxJSTjjgkFiM9mI8Pgs3
        +ZEwHzbnCO64lIHN2n3yxnFTUOkUxbwQbkVcQuAUXlV3MbLuDO6Cwqocxs00mJU3cEYWKb+tN2kRt
        zTmtGvNlbdVk+Elz92HfvH/TYzW6Ai431PlLMPrlZa5O3YqG/Rp8RJEI+uxcGN4RqsySjuvj/WDAz
        iSxfYVYaV1zLfAQYDWjV8oUVp9Hayxp4C+/ceyNHYq52DFr9HFZ/qQup8eL51PfoEIWLkmqcKORup
        AIjuk9lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwj3d-00174X-Dz; Mon, 13 Dec 2021 10:59:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04C013000E6;
        Mon, 13 Dec 2021 11:59:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2B3E2D2B0A00; Mon, 13 Dec 2021 11:59:48 +0100 (CET)
Date:   Mon, 13 Dec 2021 11:59:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 3/9] atomic: Introduce
 atomic_{inc,dec,dec_and_test}_overflow()
Message-ID: <YbcnpAjgJSRIAduN@hirez.programming.kicks-ass.net>
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

> > +#ifndef arch_atomic_inc_overflow
> > +#define arch_atomic_inc_overflow(_v, _label)				\
> > +do {									\
> > +	int __old = arch_atomic_fetch_inc(_v);			\
> > +	if (unlikely(__old <= 0))					\
> > +		goto _label;						\
> > +} while (0)
> > +#endif
> > +
> > +#ifndef arch_atomic_dec_overflow
> > +#define arch_atomic_dec_overflow(_v, _label)				\
> > +do {									\
> > +	int __new = arch_atomic_dec_return(_v);			\
> > +	if (unlikely(__new <= 0))					\
> > +		goto _label;						\
> > +} while (0)
> > +#endif
> > +
> > +#ifndef arch_atomic_dec_and_test_overflow
> > +#define arch_atomic_dec_and_test_overflow(_v, _label)		\
> > +({									\
> > +	bool __ret = false;						\
> > +	int __new = arch_atomic_dec_return(_v);			\
> > +	if (unlikely(__new < 0))					\
> > +		goto _label;						\
> > +	if (unlikely(__new == 0))					\
> > +		__ret = true;						\
> > +	__ret;								\
> > +})
> > +#endif
> 
> I had wanted to move at least part of this to a function to ensure
> single-evaluation and avoid accidental symbol aliasing, but (as we discussed
> over IRC) I couldn't find any good way to do so, and given this is sufficiently
> specialise I think we should be ok with this as-is. It's certainly no worse
> than the existing stuff for xchg/cmpxchg.

Right, as you know I tried the same :-) Anyway, the above macros should
be free of multi-evaluation issues, both _v and _label are only used the
once. Aliassing is always a possibility but minimized by __ prefixing
the local variables.
