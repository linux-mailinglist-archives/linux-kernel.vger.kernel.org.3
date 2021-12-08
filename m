Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315E746D689
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbhLHPPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbhLHPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:15:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C14C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:11:40 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638976298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byRNx3IYYVfiqDvajulkCfOp0Xbkv4Qy7scN11FFXwE=;
        b=a7sx04DzB03RdVhq6WJhF9D9+xYxIGPK/cE49/FTuf291Rro/ZUNVS7tRWgxQAUq1mpfwg
        zvgKxUxGCrlsG3gj91Iq9Eiko48Dpip3ZU4Ye+k8dEZOf9V+xOTQLiQu1kf1ioXc7iobDi
        ZOy65wohCvG/oWSVdOmffP4ChxLGdtmHdx1QWDvshWaGMgq09ovPr7pcdIVv7quVxK6ppC
        P6PSYXRlrhgwUyB1+L6bdLfyLa8hKhXFovAbvWqnAE7Ws6KN95RC/9ZgEWXuLJE9vsQE1n
        ld1A489Po1sh368GsakhS84JDXHCs5BqIX6nlUCT+f6hAC7DewpT5dJJW2Aw+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638976298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byRNx3IYYVfiqDvajulkCfOp0Xbkv4Qy7scN11FFXwE=;
        b=w/MUaeRlCtKqId0ZQ1Oi5Zkwj3QA1wQjxABk3SUWp4RHsMkbhrOtAJJnHDEkCur/TAMOny
        3AX4dEuL9nWIdYAQ==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH V7 03/18] x86/pks: Add additional PKEY helper macros
In-Reply-To: <20211208005106.GJ3538886@iweiny-DESK2.sc.intel.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-4-ira.weiny@intel.com> <87lf1cl3cq.ffs@tglx>
 <20211208005106.GJ3538886@iweiny-DESK2.sc.intel.com>
Date:   Wed, 08 Dec 2021 16:11:38 +0100
Message-ID: <87k0gf168l.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira,

On Tue, Dec 07 2021 at 16:51, Ira Weiny wrote:
> On Thu, Nov 25, 2021 at 03:25:09PM +0100, Thomas Gleixner wrote:
>
>  u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
>  {
> -      int shift = pkey * PKR_BITS_PER_PKEY;
> +      int shift = PKR_PKEY_SHIFT(pkey);
>
> 	 if (WARN_ON_ONCE(accessbits & ~PKEY_ACCESS_MASK))
>		 accessbits &= PKEY_ACCESS_MASK;
>
> Better?

Let me postpone this question.

> As to the reason of why to put this patch after the other one.  Why would I
> improve the old pre-refactoring code only to throw it away when moving it to
> pkey_update_pkval()?  This reasoning is even stronger when pkey_update_pkval()
> is implemented.

Which refactoring? We seem to have fundamentally definitions of that
term. Let me illustrate why.

The original version of this was:

  u32 get_new_pkr(u32 old_pkr, int pkey, unsigned long init_val)
  {
  	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
  	u32 new_pkr_bits = 0;
  
  	/* Set the bits we need in the register:  */
  	if (init_val & PKEY_DISABLE_ACCESS)
  		new_pkr_bits |= PKR_AD_BIT;
  	if (init_val & PKEY_DISABLE_WRITE)
  		new_pkr_bits |= PKR_WD_BIT;
  
  	/* Shift the bits in to the correct place: */
  	new_pkr_bits <<= pkey_shift;
  
  	/* Mask off any old bits in place: */
  	old_pkr &= ~((PKR_AD_BIT | PKR_WD_BIT) << pkey_shift);
  
  	/* Return the old part along with the new part: */
  	return old_pkr | new_pkr_bits;
  }

IOW, mechanical Cut & Paste.

Then PeterZ came along and suggested to improve it this way:

  u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
  {
	  int pkey_shift = pkey * PKR_BITS_PER_PKEY;

	  /*  Mask out old bit values */
	  pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);

	  /*  Or in new values */
	  if (flags & PKEY_DISABLE_ACCESS)
		  pk_reg |= PKR_AD_BIT << pkey_shift;
	  if (flags & PKEY_DISABLE_WRITE)
		  pk_reg |= PKR_WD_BIT << pkey_shift;

	  return pk_reg;
  }

which is already better. So you changed your approach from Cut & Paste
to Copy & Paste.

But neither Cut & Paste nor Copy & Paste match what refactoring is
really about. Just throwing the term refactoring at it does not make it
so.

Refactoring is about improving the code in design and implementation.
The keyword is: improving.

There are obviously cases where you can take the code as is and split it
out into a new helper function.

You really have to look at it and answer the question whether it's good
code or not, whether it could be written in better ways and with
improved functionality.

I could have given you this minimalistic one:

  u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
  {
	  int shift = pkey * PKR_BITS_PER_PKEY;

	  pkval &= ~(PKEY_ACCESS_MASK << shift);
	  return pkval | (accessbit & PKEY_ACCESS_MASK) << shift;
  }

But I gave you this:

  u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
  {
	  int shift = pkey * PKR_BITS_PER_PKEY;

	  if (WARN_ON_ONCE(accessbits & ~PKEY_ACCESS_MASK))
		  accessbits &= PKEY_ACCESS_MASK;

	  pkval &= ~(PKEY_ACCESS_MASK << shift);
	  return pkval | accessbit << shift;
  }

This is what refactoring is about. See?

> I agree with Dan regarding the macros though.  I think they make it easier to
> see what is going on without dealing with masks and shifts directly.  But I can
> remove this patch if you feel that strongly about it.

I'm not against macros per se, but not everything is automatically
better when it is hidden behind a macro.

What I'm arguing against is the claim that macros are an improvement by
definition. Especially when they are just blindly thrown into code which
should not exist in the first place.

Also versus ordering. What's wrong with doing it this way:

  1) Define the macros first without changing the code

  2) Implement pkey_update_pkval() in a sensible way and use the macros
     where appropriate. Thereby replacing the existing version in the
     other function.

Which would end up in the obviously even simpler code:

  u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
  {
	  if (WARN_ON_ONCE(accessbits & ~PKEY_ACCESS_MASK))
		  accessbits &= PKEY_ACCESS_MASK;

	  pkval &= ~PKR_PKEY_VALUE(pkey, PKEY_ACCESS_MASK);
	  return pkval | PKR_PKEY_VALUE(pkey, accessbits);
  }

That fits the goal of that macro exercise to make it easy to read and
obvious what's going on, no?

Instead of:

>  u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
>  {
> -      int shift = pkey * PKR_BITS_PER_PKEY;
> +      int shift = PKR_PKEY_SHIFT(pkey);
>
> 	 if (WARN_ON_ONCE(accessbits & ~PKEY_ACCESS_MASK))
>		 accessbits &= PKEY_ACCESS_MASK;
>
>	  pkval &= ~(PKEY_ACCESS_MASK << shift);
>	  return pkval | accessbit << shift;
>  }
>
> Better?

You surely can answer this question yourself, no?

  "By continuously improving the design of code, we make it easier and
   easier to work with. This is in sharp contrast to what typically
   happens: little refactoring and a great deal of attention paid to
   expediently adding new features. If you get into the hygienic habit
   of refactoring continuously, you'll find that it is easier to extend
   and maintain code." -- Joshua Kerievsky

If you study that quote carefully, you surely can find our diverging
approach to refactoring in it, no?

Thanks,

        tglx
