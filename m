Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2FC49D7EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiA0CR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiA0CRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:17:25 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A2C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 18:17:25 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id e28so1345542pfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 18:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pfo2AAnbZYL8NSXYsUqsl7N0rnK7jglSBk146tmS5MY=;
        b=WmYajQOphzJ6Iycj+xwWSnIKlTDzkcyUZpLlQTvegz7SSFg8m65ZuPmS6JvQKbc5u6
         aIqvAPVoGf6CHYthEf8sPeC15Z+Q9iTUTE84aU2g2Eknu4u+6u7AviXWSKK9NjAE/OsU
         vDpAoPaxpLNkQxTcHZ2ctcCBS5x4zPXZlzgLJpfkToqx6LuXP/NGhnGDc6b1KREw8MM1
         KvypfCreMbcC3pm9lgYEmlmv7o3h/Qkn6xgwNzUawaclESwGW0yzJKXP+3GOR7QWFLcs
         jnjh2nHDhu7milCtb5mIb1QuI3tWi35fOjqgdt469toirZ9yidr4zN+fbLZE/6bB9t20
         m51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pfo2AAnbZYL8NSXYsUqsl7N0rnK7jglSBk146tmS5MY=;
        b=Adikx+jOXQFMRPUZySBH5mz3fC2ugSlZtskK9dioSCu3XCVJUVpawA4RvPKyQfhmf+
         HqMwbpxBHFLnvaHyjTPebFemPFbX6sOOJI4chhz+zTQ+fgZvmCC9VZ+g2jYCsb4ZvqLw
         xriCey5XjzaFxGMkbugLnE707pmxr+cURVUkYmI00/3/CRQbaf8FqLoqvub3dsmhaD/J
         A2nFrlCyAw3kH2/zitwfqq7h7QFZFpPvnDpFW5E/TEVUt1/TzP6xeOnnPcImlOQ+kdjy
         xuszPPDRAkcMvyYjT8eJIosLrdW+w1bwvbLRwkY8fKs4ULyCNNwM/8qSpzanqtv3iQMY
         NdKA==
X-Gm-Message-State: AOAM5307+28WjOwuH/BmFXcgvlZOcNRRbPv+HeWkMrhMFSBPxKtdBLGn
        WN2sXEl9LU+DdzNL6JK7La+l0Q==
X-Google-Smtp-Source: ABdhPJwzDebr3y5VtRAz5bN4BTdqwTwYv8SZ14QttiFd0hws7Dw/VZWC29xPfw/oFRlX2ZzpePl12w==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr1242795pgd.230.1643249844295;
        Wed, 26 Jan 2022 18:17:24 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w19sm3643088pfu.47.2022.01.26.18.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 18:17:23 -0800 (PST)
Date:   Thu, 27 Jan 2022 02:17:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <YfIAsHQv5Q84fOqO@google.com>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.852009966@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120160822.852009966@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022, Peter Zijlstra wrote:
> Do try_cmpxchg() loops on userspace addresses.
> 
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/uaccess.h |   67 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -342,6 +342,24 @@ do {									\
>  		     : [umem] "m" (__m(addr))				\
>  		     : : label)
>  
> +#define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
> +	bool success;							\
> +	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
> +	__typeof__(*(_ptr)) __old = *_old;				\
> +	__typeof__(*(_ptr)) __new = (_new);				\
> +	asm_volatile_goto("\n"						\
> +		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
> +		     _ASM_EXTABLE_UA(1b, %l[label])			\
> +		     : CC_OUT(z) (success),				\
> +		       [ptr] "+m" (*_ptr),				\
> +		       [old] "+a" (__old)				\
> +		     : [new] ltype (__new)				\
> +		     : "memory", "cc"					\

IIUC, the "cc" clobber is unnecessary as CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y implies
__GCC_ASM_FLAG_OUTPUTS__=y, i.e. CC_OUT() will resolve to "=@cc".

> +		     : label);						\
> +	if (unlikely(!success))						\
> +		*_old = __old;						\
> +	likely(success);					})
> +
>  #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT

...

> +extern void __try_cmpxchg_user_wrong_size(void);
> +
> +#define unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({		\
> +	__typeof__(*(_ptr)) __ret;					\

This should probably be a bool, the return from the lower level helpers is a bool
that's true if the exchange succeed.  Declaring the type of the target implies
that they return the raw result, which is confusing.

> +	switch (sizeof(__ret)) {					\
> +	case 1:	__ret = __try_cmpxchg_user_asm("b", "q",		\
> +					       (_ptr), (_oldp),		\
> +					       (_nval), _label);	\
> +		break;							\
> +	case 2:	__ret = __try_cmpxchg_user_asm("w", "r",		\
> +					       (_ptr), (_oldp),		\
> +					       (_nval), _label);	\
> +		break;							\
> +	case 4:	__ret = __try_cmpxchg_user_asm("l", "r",		\
> +					       (_ptr), (_oldp),		\
> +					       (_nval), _label);	\
> +		break;							\
> +	case 8:	__ret = __try_cmpxchg_user_asm("q", "r",		\
> +					       (_ptr), (_oldp),		\
> +					       (_nval), _label);	\

Doh, I should have specified that KVM needs 8-byte CMPXCHG on 32-bit kernels due
to using it to atomically update guest PAE PTEs and LTR descriptors (yay).

Also, KVM's use case isn't a tight loop, how gross would it be to add a slightly
less unsafe version that does __uaccess_begin_nospec()?  KVM pre-checks the address
way ahead of time, so the access_ok() check can be omitted.  Alternatively, KVM
could add its own macro, but that seems a little silly.  E.g. somethign like this,
though I don't think this is correct (something is getting inverted somewhere and
the assembly output is a nightmare):

/* "Returns" 0 on success, 1 on failure, -EFAULT if the access faults. */
#define ___try_cmpxchg_user(_ptr, _oldp, _nval, _label)	({		\
	int ____ret = -EFAULT;						\
	__uaccess_begin_nospec();					\
	____ret = !unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label);	\
_label:									\
	__uaccess_end();						\
	____ret;							\
						})

Lastly, assuming I get my crap working, mind if I post a variant (Cc'd to stable@) in
the context of KVM series?  Turns out KVM has an ugly bug where it completely
botches the pfn calculation of memory it remaps and accesses[*], the easiest fix
is to switch to __try_cmpxchg_user() and purge the nastiness.

[*] https://lore.kernel.org/all/20220124172633.103323-1-tadeusz.struk@linaro.org
