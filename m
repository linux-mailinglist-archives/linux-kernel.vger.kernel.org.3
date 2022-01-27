Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC549DE91
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiA0J4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiA0J4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:56:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4954EC061714;
        Thu, 27 Jan 2022 01:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O7zyVgxDozFmiHZoQV61cl7uW6jv9z1Nnl4RX0PNNzM=; b=CAZDyEIW1beCFmtp9vTAGjG23w
        I1BMY3znM1JmhUDKsZRiJt7P4EDeb/Pzk/wctVebbdbyemtqNVn9kmyBoo1SUTxfn0DM45Ni+OonS
        4wfH9dx8n+vVYSJ6eMwizu9iMttVPZ75afuYoONShWJCgomCYRMGwIni4XsIKItrUIv9KwrNizQnx
        4T3616drr9+fo36yGJeSFugQFjRHJA/pUPw1W4f5rHxRaiwkbw6xVH8xdVqFEQYNaUsg7nV2NLtG+
        AXQPjw8/2vjonsvwh81dxVaCli1gedkyu3iItLEO9MHqgj1efdAPkgcESZR3rSypPjzbwkMejIRg+
        kWZKb+cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1VL-0052ap-Rp; Thu, 27 Jan 2022 09:55:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 007EA3002C5;
        Thu, 27 Jan 2022 10:55:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA9392B383F57; Thu, 27 Jan 2022 10:55:44 +0100 (CET)
Date:   Thu, 27 Jan 2022 10:55:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: Re: [RFC][PATCH v2 4/5] x86/uaccess: Implement
 unsafe_try_cmpxchg_user()
Message-ID: <YfJsIDw+GwjZDiX3@hirez.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.852009966@infradead.org>
 <YfIAsHQv5Q84fOqO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfIAsHQv5Q84fOqO@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:17:20AM +0000, Sean Christopherson wrote:
> On Thu, Jan 20, 2022, Peter Zijlstra wrote:
> > Do try_cmpxchg() loops on userspace addresses.
> > 
> > Cc: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/include/asm/uaccess.h |   67 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> > 
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -342,6 +342,24 @@ do {									\
> >  		     : [umem] "m" (__m(addr))				\
> >  		     : : label)
> >  
> > +#define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
> > +	bool success;							\
> > +	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
> > +	__typeof__(*(_ptr)) __old = *_old;				\
> > +	__typeof__(*(_ptr)) __new = (_new);				\
> > +	asm_volatile_goto("\n"						\
> > +		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
> > +		     _ASM_EXTABLE_UA(1b, %l[label])			\
> > +		     : CC_OUT(z) (success),				\
> > +		       [ptr] "+m" (*_ptr),				\
> > +		       [old] "+a" (__old)				\
> > +		     : [new] ltype (__new)				\
> > +		     : "memory", "cc"					\
> 
> IIUC, the "cc" clobber is unnecessary as CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y implies
> __GCC_ASM_FLAG_OUTPUTS__=y, i.e. CC_OUT() will resolve to "=@cc".

Yeah, even without that GCC always assumes 'cc' is clobbered due to
hysterical raisins.

> > +		     : label);						\
> > +	if (unlikely(!success))						\
> > +		*_old = __old;						\
> > +	likely(success);					})
> > +
> >  #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> 
> ...
> 
> > +extern void __try_cmpxchg_user_wrong_size(void);
> > +
> > +#define unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({		\
> > +	__typeof__(*(_ptr)) __ret;					\
> 
> This should probably be a bool, the return from the lower level helpers is a bool
> that's true if the exchange succeed.  Declaring the type of the target implies
> that they return the raw result, which is confusing.

Fair enough.

> > +	switch (sizeof(__ret)) {					\
> > +	case 1:	__ret = __try_cmpxchg_user_asm("b", "q",		\
> > +					       (_ptr), (_oldp),		\
> > +					       (_nval), _label);	\
> > +		break;							\
> > +	case 2:	__ret = __try_cmpxchg_user_asm("w", "r",		\
> > +					       (_ptr), (_oldp),		\
> > +					       (_nval), _label);	\
> > +		break;							\
> > +	case 4:	__ret = __try_cmpxchg_user_asm("l", "r",		\
> > +					       (_ptr), (_oldp),		\
> > +					       (_nval), _label);	\
> > +		break;							\
> > +	case 8:	__ret = __try_cmpxchg_user_asm("q", "r",		\
> > +					       (_ptr), (_oldp),		\
> > +					       (_nval), _label);	\
> 
> Doh, I should have specified that KVM needs 8-byte CMPXCHG on 32-bit kernels due
> to using it to atomically update guest PAE PTEs and LTR descriptors (yay).

:-) I'm so trying to de-feature 32bit.

> Also, KVM's use case isn't a tight loop, how gross would it be to add a slightly
> less unsafe version that does __uaccess_begin_nospec()?  KVM pre-checks the address
> way ahead of time, so the access_ok() check can be omitted.  Alternatively, KVM
> could add its own macro, but that seems a little silly.  E.g. somethign like this,
> though I don't think this is correct (something is getting inverted somewhere and
> the assembly output is a nightmare):
> 
> /* "Returns" 0 on success, 1 on failure, -EFAULT if the access faults. */
> #define ___try_cmpxchg_user(_ptr, _oldp, _nval, _label)	({		\
> 	int ____ret = -EFAULT;						\
> 	__uaccess_begin_nospec();					\
> 	____ret = !unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label);	\
> _label:									\
> 	__uaccess_end();						\
> 	____ret;							\
> 						})

Works for me I suppose, but we really ought to keep usage of that in
arch code.

> Lastly, assuming I get my crap working, mind if I post a variant (Cc'd to stable@) in
> the context of KVM series?  

Not at all.
