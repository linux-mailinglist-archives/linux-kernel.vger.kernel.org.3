Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E6948CD04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357491AbiALUTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357486AbiALUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:19:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA168C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:18:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso14648841pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cWg9oGmX5VjzwBIpzlyYG0aMpDjKGVxhDdmjr+TTfSE=;
        b=Wvl5veJvVOxAEEqXRfAlq3EFmvwi1k+5HEmL903UUIkAXm0sRZlwm/KBWwfxggotD9
         nSE2A51iCWC2SwhO0m7e4BYIOh/W7C/TOBh1bCV/0MEuwdfnL0c2cAijoGKgBa+t9wYA
         3zA/m12UZ+/zfgcxV00ab7JXCYBA8/HQXZKN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cWg9oGmX5VjzwBIpzlyYG0aMpDjKGVxhDdmjr+TTfSE=;
        b=Tmah/fsq+z1UxgyDVqn4csTiR1En5nX6KOG2537tIMZgvRUcLCMSDv9+BxXapIPkdM
         Kv8PmoWgMxys5RP8ZznJGizWc2PFx8zg/R3aO5vQml32y8hfBChcpzXQOSbhIilIelbr
         HpNarE5eA9EDA/T6ZC1CAtOG1vQCtKfw5BfZLhphcV4h75GEagYjvIY65wnmqGGNvtob
         F7MtasJXNVdHCjl2HrwcA8RGfgrOApPZbn9p3RIa8ccBS5nmvM6KUSJMeOVRXu2M4nZC
         7zhH1mGqhJLu39DOxZWhDSBjBPb334ZlR89g7VUUkK2GEdkuNbebIl7fphydEdh9Y1SU
         C4Qw==
X-Gm-Message-State: AOAM533rW5Xr9CI8DrvHmTV6gi/j7YprcCCwmM6N1cgpbLDO4H8MN1O7
        eOwiajsgT9fmxB2yybuKKgIgkQ==
X-Google-Smtp-Source: ABdhPJxO2Q9IGXVDG75qeMUDFvdczT7RHBGhaxNrz76IxGxWNBohSOWl8G2Wtv7gTZPEKYr34aTyVA==
X-Received: by 2002:aa7:8592:0:b0:4be:2691:bb88 with SMTP id w18-20020aa78592000000b004be2691bb88mr1214917pfn.20.1642018739352;
        Wed, 12 Jan 2022 12:18:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x25sm422555pfu.113.2022.01.12.12.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:18:59 -0800 (PST)
Date:   Wed, 12 Jan 2022 12:18:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64: atomics: Dereference matching size
Message-ID: <202201121217.FB408C2362@keescook>
References: <20220107232746.1540130-1-keescook@chromium.org>
 <YdwKLwvDRfc59c8U@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdwKLwvDRfc59c8U@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 10:27:59AM +0000, Mark Rutland wrote:
> Hi Kees,
> 
> On Fri, Jan 07, 2022 at 03:27:46PM -0800, Kees Cook wrote:
> > When building with -Warray-bounds (which is desired to be enabled
> > globally), the following warning is generated:
> > 
> > In file included from ./arch/arm64/include/asm/lse.h:16,
> >                  from ./arch/arm64/include/asm/cmpxchg.h:14,
> >                  from ./arch/arm64/include/asm/atomic.h:16,
> >                  from ./include/linux/atomic.h:7,
> >                  from ./include/asm-generic/bitops/atomic.h:5,
> >                  from ./arch/arm64/include/asm/bitops.h:25,
> >                  from ./include/linux/bitops.h:33,
> >                  from ./include/linux/kernel.h:22,
> >                  from kernel/printk/printk.c:22:
> > ./arch/arm64/include/asm/atomic_lse.h:247:9: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
> >   247 |         asm volatile(                                                   \
> >       |         ^~~
> > ./arch/arm64/include/asm/atomic_lse.h:266:1: note: in expansion of macro '__CMPXCHG_CASE'
> >   266 | __CMPXCHG_CASE(w,  , acq_, 32,  a, "memory")
> >       | ^~~~~~~~~~~~~~
> > kernel/printk/printk.c:3606:17: note: while referencing 'printk_cpulock_owner'
> >  3606 | static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
> >       |                 ^~~~~~~~~~~~~~~~~~~~
> > 
> > This is due to the compiler seeing an unsigned long * cast against
> > something (atomic_t) that is int sized. Replace the cast with the
> > matching size cast. This results in no change in binary output.
> 
> Just to check, I assume both GCC and Clang are happy with this applied?
> 
> I recall that (historically at least) clang would warn about size mismatches
> for inline assembly and would sometimes require more care. I don't see anythign
> for which that would matter, but I just want to check.

Yup, Clang is happy with this AFAICT.

> 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm64/include/asm/atomic_lse.h | 2 +-
> >  arch/arm64/include/asm/cmpxchg.h    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> > index d955ade5df7c..5d460f6b7675 100644
> > --- a/arch/arm64/include/asm/atomic_lse.h
> > +++ b/arch/arm64/include/asm/atomic_lse.h
> > @@ -249,7 +249,7 @@ __lse__cmpxchg_case_##name##sz(volatile void *ptr,			\
> >  	"	mov	%" #w "[tmp], %" #w "[old]\n"			\
> >  	"	cas" #mb #sfx "\t%" #w "[tmp], %" #w "[new], %[v]\n"	\
> >  	"	mov	%" #w "[ret], %" #w "[tmp]"			\
> > -	: [ret] "+r" (x0), [v] "+Q" (*(unsigned long *)ptr),		\
> > +	: [ret] "+r" (x0), [v] "+Q" (*(u##sz *)ptr),			\
> >  	  [tmp] "=&r" (tmp)						\
> >  	: [old] "r" (x1), [new] "r" (x2)				\
> >  	: cl);								\
> 
> It might be worth nothing that __ll_sc__cmpxchg_case_##name##sz already uses
> the same constraint:
> 
> 	[v] "+Q" (*(u##sz *)ptr
> 
> ... since that explains why we only need to update the LSE form and not the
> LL/SC form, and indicates that this is unlikely to be problematic.

Good idea, I'll note that in a v2.

> 
> Either way:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

-Kees

> 
> Thanks,
> Mark.
> 
> > diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> > index f9bef42c1411..497acf134d99 100644
> > --- a/arch/arm64/include/asm/cmpxchg.h
> > +++ b/arch/arm64/include/asm/cmpxchg.h
> > @@ -243,7 +243,7 @@ static inline void __cmpwait_case_##sz(volatile void *ptr,		\
> >  	"	cbnz	%" #w "[tmp], 1f\n"				\
> >  	"	wfe\n"							\
> >  	"1:"								\
> > -	: [tmp] "=&r" (tmp), [v] "+Q" (*(unsigned long *)ptr)		\
> > +	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
> >  	: [val] "r" (val));						\
> >  }
> >  
> > -- 
> > 2.30.2
> > 

-- 
Kees Cook
