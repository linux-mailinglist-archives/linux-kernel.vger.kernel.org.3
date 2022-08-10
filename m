Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF658F492
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiHJW4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiHJW4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:56:22 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84134642F9;
        Wed, 10 Aug 2022 15:56:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au [49.181.193.158])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 68C6C62D24D;
        Thu, 11 Aug 2022 08:56:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oLucc-00Bbew-Oy; Thu, 11 Aug 2022 08:56:18 +1000
Date:   Thu, 11 Aug 2022 08:56:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fs/xfs: Use atomic64_try_cmpxchg in
 xlog_grant_{add,sub}_space
Message-ID: <20220810225618.GM3600936@dread.disaster.area>
References: <20220809165615.9694-1-ubizjak@gmail.com>
 <20220809220511.GI3600936@dread.disaster.area>
 <20220809230244.GJ3600936@dread.disaster.area>
 <CAFULd4YkSG4RES8=P5BjF8JH5En++XN6LpVNd391eYcy_baeyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4YkSG4RES8=P5BjF8JH5En++XN6LpVNd391eYcy_baeyw@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62f43794
        a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=99CUqXMKFniesV8lYRMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:02:16AM +0200, Uros Bizjak wrote:
> On Wed, Aug 10, 2022 at 1:02 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Aug 10, 2022 at 08:05:11AM +1000, Dave Chinner wrote:
> > > On Tue, Aug 09, 2022 at 06:56:15PM +0200, Uros Bizjak wrote:
> > > > Use `!atomic64_try_cmpxchg(ptr, &old, new)` instead of
> > > > `atomic64_cmpxchg(ptr, old, new) != old` in xlog_grant_{add,sub}_space.
> > > > This has two benefits:
> > > >
> > > > - The x86 cmpxchg instruction returns success in the ZF flag, so this
> > > >   change saves a compare after cmpxchg, as well as a related move
> > > >   instruction in the front of cmpxchg.
> > > >
> > > > - atomic64_try_cmpxchg implicitly assigns the *ptr value to &old when
> > > >   cmpxchg fails, enabling further code simplifications.
> > >
> > > Do the two cmpxchg operations have the same memory ordering
> > > semantics on failure?
> 
> Yes. The API also provides _acquire, _release and _relaxed variants of
> both, atomic64_cmpxchg and atomic64_try_cmpxchg.

Yes, I know this, which was why I was asking if the default
behaviour is the same - many people get caught out by assuming that
cmpxchg implies release semantics even if it fails....

> On x86, these two
> functions actually compile to the same CMPXCHG instruction, the
> difference is only in how the comparison is handled:
> 
>       15:    48 09 c2                 or     %rax,%rdx
>       18:    48 89 c8                 mov    %rcx,%rax
>       1b:    f0 48 0f b1 16           lock cmpxchg %rdx,(%rsi)
>       20:    48 39 c1                 cmp    %rax,%rcx
>       23:    74 2a                    je     4f <xlog_grant_add_space+0x4f>
> 
> becomes:
> 
>      29c:    48 09 ca                 or     %rcx,%rdx
>      29f:    f0 48 0f b1 16           lock cmpxchg %rdx,(%rsi)
>      2a4:    75 d2                    jne    278 <xlog_grant_add_space+0x8>
> 
> And as demonstrated in [1], even the fallback code compiles to a
> better assembly.o

FWIW, I mostly don't care about assembler level optimisations for
the code I write. I'll try to write code efficiently, but I don't
really care that much for micro-optimisation. Fundamentally, 
focussing on optimising code down to the instruction level means you
are not looking for algorithmic optimisations, which is where all
the big gains typically come from....

This thread demonstrates that - I get an improvement from roughly
1.4 million transactions/s to roughly 2 million transactions/s with
the change to the grant head accounting algorithm, whilst the
improvement from removing 2 instructions from the cmpxchg can't
actually be measured on my tests. i.e. the improvement is lost
within the noise floor of the benchmarks.

So, yeah, when it comes to making code faster, I focus on efficient
algorithms rather than efficient code because algorithms are where
the gains users will notice are....

> > FYI, the original RFC for this was posted a bit over a month ago:
> >
> > https://lore.kernel.org/linux-xfs/20220708015558.1134330-1-david@fromorbit.com/
> 
> -static void
> +void
>  xlog_grant_sub_space(
> 
> [...]
> 
> - old = head_val;
> - new = xlog_assign_grant_head_val(cycle, space);
> - head_val = atomic64_cmpxchg(&head->grant, old, new);
> - } while (head_val != old);
> + atomic64_sub(bytes, &head->grant);
>  }
> 
> I actually wondered why these two functions were not implemented as
> atomic64_{add,sub}.

Because the grant heads were not integer values that can be added
and subtracted. Log sequence numbers (LSNs) are 64 bit objects made
up of two discrete 32 bit values. Essentially the upper 32 bits
counts the number of overflows of the fixed size space the lower 32
bits accounts.

The lower 32 bits matches the size of the journal, so will overflow
at some boundary much lower than 2^32. Hence adding or subtracting
to a LSN has to handle the space overflow/underflow itself to
modify the overflow (cycle) counter top 32 bits appropriately.

These calculations cannot be done as a single atomic operation,
hence the crack/calc/combine/cmpxchg loops to enable them to be done
without requiring locks in the fast path.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
