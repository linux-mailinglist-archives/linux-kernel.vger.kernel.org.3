Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D746EF53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbhLIREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:04:08 -0500
Received: from foss.arm.com ([217.140.110.172]:59478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242041AbhLIRD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:03:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2929ED1;
        Thu,  9 Dec 2021 09:00:22 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.64.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 762DB3F5A1;
        Thu,  9 Dec 2021 09:00:21 -0800 (PST)
Date:   Thu, 9 Dec 2021 17:00:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC][PATCH 2/5] refcount: Use atomic_*_ofl()
Message-ID: <YbI2IjU7qoSTlCH6@FVFF77S0Q05N>
References: <20211208183655.251963904@infradead.org>
 <20211208183906.468934357@infradead.org>
 <YbIB7aJU5ngCcaNj@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbIB7aJU5ngCcaNj@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 01:17:33PM +0000, Mark Rutland wrote:
> On Wed, Dec 08, 2021 at 07:36:57PM +0100, Peter Zijlstra wrote:
> > Use the shiny new atomic_*_ofl() functions in order to have better
> > code-gen.
> > 
> > Notably refcount_inc() case no longer distinguishes between
> > inc-from-zero and inc-negative in the fast path, this improves
> > code-gen:
> > 
> >     4b88:       b8 01 00 00 00          mov    $0x1,%eax
> >     4b8d:       f0 0f c1 43 28          lock xadd %eax,0x28(%rbx)
> >     4b92:       85 c0                   test   %eax,%eax
> >     4b94:       74 1b                   je     4bb1 <alloc_perf_context+0xf1>
> >     4b96:       8d 50 01                lea    0x1(%rax),%edx
> >     4b99:       09 c2                   or     %eax,%edx
> >     4b9b:       78 20                   js     4bbd <alloc_perf_context+0xfd>
> > 
> > to:
> > 
> >     4768:       b8 01 00 00 00          mov    $0x1,%eax
> >     476d:       f0 0f c1 43 28          lock xadd %eax,0x28(%rbx)
> >     4772:       85 c0                   test   %eax,%eax
> >     4774:       7e 14                   jle    478a <alloc_perf_context+0xea>
> 
> For comparison, I generated the same for arm64 below with kernel.org crosstool
> GCC 11.1.0 and defconfig.
> 
> For arm64 there's an existing sub-optimiality for inc/dec where the register
> for `1` or `-1` gets generated with a `MOV;MOV` chain or `MOV;NEG` chain rather
> than a single `MOV` in either case. I think taht's due to the way we build
> LSE/LL-SC variants of add() and build a common inc() atop, and the compiler
> just loses the opportunity to constant-fold. I'll take a look at how to make
> that neater.

With some improvement's to arm64's LSE atomics, that becomes a comparable
sequence to x86's:

    2df8:       52800021        mov     w1, #0x1                        // #1
    ...
    2e20:       b8e10002        ldaddal w1, w2, [x0]
    2e24:       7100005f        cmp     w2, #0x0
    2e28:       5400012d        b.le    2e4c <alloc_perf_context+0xc8>

> > without sacrificing on functionality; the only thing that suffers is
> > the reported error condition, which might now 'spuriously' report
> > 'saturated' instead of 'inc-from-zero'.
> > 
> > refcount_dec_and_test() is also improved:
> > 
> >     aa40:       b8 ff ff ff ff          mov    $0xffffffff,%eax
> >     aa45:       f0 0f c1 07             lock xadd %eax,(%rdi)
> >     aa49:       83 f8 01                cmp    $0x1,%eax
> >     aa4c:       74 05                   je     aa53 <ring_buffer_put+0x13>
> >     aa4e:       85 c0                   test   %eax,%eax
> >     aa50:       7e 1e                   jle    aa70 <ring_buffer_put+0x30>
> >     aa52:       c3                      ret
> > 
> > to:
> > 
> >     a980:       b8 ff ff ff ff          mov    $0xffffffff,%eax
> >     a985:       f0 0f c1 07             lock xadd %eax,(%rdi)
> >     a989:       83 e8 01                sub    $0x1,%eax
> >     a98c:       78 20                   js     a9ae <ring_buffer_put+0x2e>
> >     a98e:       74 01                   je     a991 <ring_buffer_put+0x11>
> >     a990:       c3                      ret

Likewise I can get the arm64 equivalent down to:

    bebc:       12800001        mov     w1, #0xffffffff                 // #-1
    ...
    becc:       b8e10001        ldaddal w1, w1, [x0]
    bed0:       71000421        subs    w1, w1, #0x1
    bed4:       540000c4        b.mi    beec <ring_buffer_put+0x3c>  // b.first
    bed8:       54000120        b.eq    befc <ring_buffer_put+0x4c>  // b.none

I've pushed my WIP patches to:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/atomics/improvements
  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/atomics/improvements

... and I'll try to get those cleaned up and posted soon.

Thanks,
Mark.
