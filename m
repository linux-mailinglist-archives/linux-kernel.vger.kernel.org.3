Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC111562ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiGAItF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiGAIs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:48:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91CD13D56;
        Fri,  1 Jul 2022 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mY2YJsRE/yBS43tn1f7s0RHEEaTIk2g/RfTS1WyV6ug=; b=XjrOE8lfVYBHTAJTCA/bOgOgZ/
        wcYdChR/17ayscOYNFB9kP7t6BMY8Hs+uy3SJmVk9ki1DJwU/psjT3zoqOhOsPZfaaUKNw6xuMOHM
        cYQLXky8QVnO4onSSxH14ebDP5e8U+OVkx1VdsSS73Il7FxFmg7xOfcDBHIglcYPAuE94KAtwQadt
        8HwwDUdrc9uLWyi4zR1k3BEoRsK2EOVk3X8Rl5unreH0IupKaPG2iKQlluf1umazRub3W4APvZtWe
        vFaHpqakVoTAfvDEqr2rotdjoiNtX368Edt4YRs8CAqILu1SUHIxFWDxIcYjmrzzlav6tGHM0R4mb
        1m4uIzQg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7CJb-00FdrR-AC; Fri, 01 Jul 2022 08:47:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63D90980017; Fri,  1 Jul 2022 10:47:49 +0200 (CEST)
Date:   Fri, 1 Jul 2022 10:47:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Aring <aahringo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        thunder.leizhen@huawei.com, jacob.e.keller@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/2] refcount: attempt to avoid imbalance warnings
Message-ID: <Yr60tWxN4P568x3W@worktop.programming.kicks-ass.net>
References: <20220630135934.1799248-1-aahringo@redhat.com>
 <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:34:10AM -0700, Linus Torvalds wrote:

Not commenting on sparse, since I'm not much qualified there, however,

>  include/linux/compiler_types.h | 2 ++
>  include/linux/refcount.h       | 6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index d08dfcb0ac68..4f2a819fd60a 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -24,6 +24,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>  /* context/locking */
>  # define __must_hold(x)	__attribute__((context(x,1,1)))
>  # define __acquires(x)	__attribute__((context(x,0,1)))
> +# define __cond_acquires(x) __attribute__((context(x,0,-1)))
>  # define __releases(x)	__attribute__((context(x,1,0)))
>  # define __acquire(x)	__context__(x,1)
>  # define __release(x)	__context__(x,-1)
> @@ -50,6 +51,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>  /* context/locking */
>  # define __must_hold(x)
>  # define __acquires(x)
> +# define __cond_acquires(x)
>  # define __releases(x)
>  # define __acquire(x)	(void)0
>  # define __release(x)	(void)0
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index b8a6e387f8f9..a62fcca97486 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -361,9 +361,9 @@ static inline void refcount_dec(refcount_t *r)
>  
>  extern __must_check bool refcount_dec_if_one(refcount_t *r);
>  extern __must_check bool refcount_dec_not_one(refcount_t *r);
> -extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
> -extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock);
> +extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock) __cond_acquires(lock);
> +extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __cond_acquires(lock);
>  extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
>  						       spinlock_t *lock,
> -						       unsigned long *flags);
> +						       unsigned long *flags) __cond_acquires(lock);
>  #endif /* _LINUX_REFCOUNT_H */


YES!, thank you!
