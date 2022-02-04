Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639B54A984A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358250AbiBDLQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:16:09 -0500
Received: from foss.arm.com ([217.140.110.172]:36690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241755AbiBDLQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:16:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20C891435;
        Fri,  4 Feb 2022 03:16:09 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AD843F774;
        Fri,  4 Feb 2022 03:16:07 -0800 (PST)
Date:   Fri, 4 Feb 2022 11:16:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, ardb@kernel.org, arnd@arndb.de,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v2] atomics: fix atomic64_{read_acquire,set_release}
 fallbacks
Message-ID: <Yf0K8oxan1NvjKmE@FVFF77S0Q05N>
References: <20220203161243.3955547-1-mark.rutland@arm.com>
 <YfxxSX3v6nSJ0tKo@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfxxSX3v6nSJ0tKo@tardis>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 08:20:25AM +0800, Boqun Feng wrote:
> On Thu, Feb 03, 2022 at 04:12:43PM +0000, Mark Rutland wrote:
> > diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
> > index a3dba31df01e..6db58d180866 100644
> > --- a/include/linux/atomic/atomic-arch-fallback.h
> > +++ b/include/linux/atomic/atomic-arch-fallback.h
> > @@ -151,7 +151,16 @@
> >  static __always_inline int
> >  arch_atomic_read_acquire(const atomic_t *v)
> >  {
> > -	return smp_load_acquire(&(v)->counter);
> > +	int ret;
> > +
> > +	if (__native_word(atomic_t)) {
> > +		ret = smp_load_acquire(&(v)->counter);
> > +	} else {
> > +		ret = arch_atomic_read(v);
> > +		__atomic_acquire_fence();
> > +	}
> > +
> > +	return ret;
> >  }
> >  #define arch_atomic_read_acquire arch_atomic_read_acquire
> >  #endif
> > @@ -160,7 +169,12 @@ arch_atomic_read_acquire(const atomic_t *v)
> >  static __always_inline void
> >  arch_atomic_set_release(atomic_t *v, int i)
> >  {
> > -	smp_store_release(&(v)->counter, i);
> > +	if (__native_word(atomic_t)) {
> > +		smp_store_release(&(v)->counter, i);
> > +	} else {
> > +		__atomic_release_fence();
> > +		arch_atomic_set(v, i);
> > +	}
> >  }
> 
> The changes for atomic_t are not necessary, right? They are correct but
> "side effects" because of the change in scripts.

Correct -- those aren't necessary, but aren't harmful, and it's simpler to have
than than it is to special-case the scripts.

> If so, it's better to mention this somewhere.

Sure; how about I add the following to the commit message:

| Since the fallback templates are used to generate the atomic64_*() and
| atomic_*() operations, the __native_word() check is added to both. For
| the atomic_*() operations, which are always 32-bit, the __native_word()
| check is redundant but not harmful, as it is always true.

... ?

Thanks,
Mark.
