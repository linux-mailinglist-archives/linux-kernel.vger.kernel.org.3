Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E845642ED
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiGBVmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGBVmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:42:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09B5BE2B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 14:42:04 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h19so4679458qtp.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hz/EyTqzbrOyLdAeFFSAHFBCbFY10k/rWCRKYJdYkIU=;
        b=EPY6/khg/hU6BpbiJPa4B7EaP4Y/EozuVF4NevIpckBVG0Qq0SGdC9FqPgxWUPawUe
         Bw6Tbe/ug0M2W/fPvCQaW0Buih7EoLID8UJwcyp3hUPzVCiRAaAcr6CCn3r2ctKvIA3L
         BKxFRyIKPR/VqHGxGdM7k6aibhC5gNuUoFnTNHiXHSB73rpBNjFk67P++CRfpBdIMhAL
         SzRxzxD7QpBsSoM5uivAFNHyg5OnpU86N7AwH19mOkTDwG50+I4tlwHO5OXuewnEF3TB
         czqfWnNL412dxQc0GvMXDj7mWq0WGvDwfxy4BVJ95RY5Ye2h/vj4W8zhAERrQQmXXVxn
         VFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hz/EyTqzbrOyLdAeFFSAHFBCbFY10k/rWCRKYJdYkIU=;
        b=xtcd+gTI7UtkyeaWO+ZCCuGkhdp2CVDL0miXkDFiU+hAQW71VoMzG/f4HqntSKffqp
         q/bA/oRkV0wK1tpKWOjzKl0+SzOAlLH8293+/Wj1ZM9w0l7EDJ3GT2jhk9Mfksg6H/18
         P8rKJpWv5VSYqS6E563j+oNnBefh8jnpesIAg0mU1qrEd8Sl+OG67o/CY5DQTx0iYHsp
         pkuaCOYgnsQlJCgKFLqH8O1fKpBCnW+iEeB/vESHtTbjV263NgVvKzQW9qWeuncQBxy3
         WiAmTj5FDZvKhgqfvX4ek05FkHZ+nlJzF4NF0Lg4rn+3PJq20iKhEjtPxJ+QQpJABG/z
         1WpA==
X-Gm-Message-State: AJIora9+a28lBxjQ3jPxom4qPhRpjwU/ZEmL3g5Lk3AnpxkHGgEolSap
        mvhX/tJB9wXCx+gdow+qZ2A=
X-Google-Smtp-Source: AGRyM1stPSKG06gv4iaYRtQgO27UwRdjdn07FO+zNFXtX0jy7Arcpm1KnwrCZT8TjaGGDapUtIddWQ==
X-Received: by 2002:a05:622a:1d2:b0:31d:3dbf:77f9 with SMTP id t18-20020a05622a01d200b0031d3dbf77f9mr4491314qtw.384.1656798123659;
        Sat, 02 Jul 2022 14:42:03 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:e838:b1c2:b125:986a])
        by smtp.gmail.com with ESMTPSA id bj35-20020a05620a192300b006af50b6f10csm12712643qkb.61.2022.07.02.14.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:42:03 -0700 (PDT)
Date:   Sat, 2 Jul 2022 14:42:02 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 2/5] cpumask: Fix invalid uniprocessor mask assumption
Message-ID: <YsC7qlQba4+VJ3W1@yury-laptop>
References: <cover.1656777646.git.sander@svanheule.net>
 <86bf3f005abba2d92120ddd0809235cab4f759a6.1656777646.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bf3f005abba2d92120ddd0809235cab4f759a6.1656777646.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 06:08:25PM +0200, Sander Vanheule wrote:
> On uniprocessor builds, any CPU mask is assumed to contain exactly one
> CPU (cpu0). This assumption ignores the existence of empty masks,
> resulting in incorrect behaviour.
> cpumask_first_zero(), cpumask_next_zero(), and for_each_cpu_not() don't
> provide behaviour matching the assumption that a UP mask is always "1",
> and instead provide behaviour matching the empty mask.
> 
> Drop the incorrectly optimised code and use the generic implementations
> in all cases.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Suggested-by: Yury Norov <yury.norov@gmail.com>

> ---
> 
> Notes:
>     Changes since v3:
>     - Add back UP-optimised cpumask_local_spread, cpumask_any_distribute,
>       cpumask_any_and_distribute
>     
>     Changes since v1:
>     - Drop UP implementations instead of trying to fix them
> 
>  include/linux/cpumask.h | 99 ++++++++---------------------------------
>  lib/Makefile            |  3 +-
>  lib/cpumask.c           |  2 +
>  3 files changed, 22 insertions(+), 82 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index fe29ac7cc469..7fbef41b3093 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -116,85 +116,6 @@ static __always_inline unsigned int cpumask_check(unsigned int cpu)
>  	return cpu;
>  }
>  
> -#if NR_CPUS == 1
> -/* Uniprocessor.  Assume all masks are "1". */
> -static inline unsigned int cpumask_first(const struct cpumask *srcp)
> -{
> -	return 0;
> -}
> -
> -static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
> -{
> -	return 0;
> -}
> -
> -static inline unsigned int cpumask_first_and(const struct cpumask *srcp1,
> -					     const struct cpumask *srcp2)
> -{
> -	return 0;
> -}
> -
> -static inline unsigned int cpumask_last(const struct cpumask *srcp)
> -{
> -	return 0;
> -}
> -
> -/* Valid inputs for n are -1 and 0. */
> -static inline unsigned int cpumask_next(int n, const struct cpumask *srcp)
> -{
> -	return n+1;
> -}
> -
> -static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
> -{
> -	return n+1;
> -}
> -
> -static inline unsigned int cpumask_next_and(int n,
> -					    const struct cpumask *srcp,
> -					    const struct cpumask *andp)
> -{
> -	return n+1;
> -}
> -
> -static inline unsigned int cpumask_next_wrap(int n, const struct cpumask *mask,
> -					     int start, bool wrap)
> -{
> -	/* cpu0 unless stop condition, wrap and at cpu0, then nr_cpumask_bits */
> -	return (wrap && n == 0);
> -}
> -
> -/* cpu must be a valid cpu, ie 0, so there's no other choice. */
> -static inline unsigned int cpumask_any_but(const struct cpumask *mask,
> -					   unsigned int cpu)
> -{
> -	return 1;
> -}
> -
> -static inline unsigned int cpumask_local_spread(unsigned int i, int node)
> -{
> -	return 0;
> -}
> -
> -static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
> -					     const struct cpumask *src2p) {
> -	return cpumask_first_and(src1p, src2p);
> -}
> -
> -static inline int cpumask_any_distribute(const struct cpumask *srcp)
> -{
> -	return cpumask_first(srcp);
> -}
> -
> -#define for_each_cpu(cpu, mask)			\
> -	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> -#define for_each_cpu_not(cpu, mask)		\
> -	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> -#define for_each_cpu_wrap(cpu, mask, start)	\
> -	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
> -#define for_each_cpu_and(cpu, mask1, mask2)	\
> -	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2)
> -#else
>  /**
>   * cpumask_first - get the first cpu in a cpumask
>   * @srcp: the cpumask pointer
> @@ -260,10 +181,29 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>  
>  int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
>  int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
> +
> +#if NR_CPUS == 1
> +/* Uniprocessor: there is only one valid CPU */
> +static inline unsigned int cpumask_local_spread(unsigned int i, int node)
> +{
> +	return 0;
> +}
> +
> +static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
> +					     const struct cpumask *src2p) {
> +	return cpumask_first_and(src1p, src2p);
> +}
> +
> +static inline int cpumask_any_distribute(const struct cpumask *srcp)
> +{
> +	return cpumask_first(srcp);
> +}
> +#else
>  unsigned int cpumask_local_spread(unsigned int i, int node);
>  int cpumask_any_and_distribute(const struct cpumask *src1p,
>  			       const struct cpumask *src2p);
>  int cpumask_any_distribute(const struct cpumask *srcp);
> +#endif /* NR_CPUS */
>  
>  /**
>   * for_each_cpu - iterate over every cpu in a mask
> @@ -324,7 +264,6 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
>  	for ((cpu) = -1;						\
>  		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
>  		(cpu) < nr_cpu_ids;)
> -#endif /* SMP */
>  
>  #define CPU_BITS_NONE						\
>  {								\
> diff --git a/lib/Makefile b/lib/Makefile
> index f99bf61f8bbc..bcc7e8ea0cde 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -34,10 +34,9 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>  	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>  	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
> -	 buildid.o
> +	 buildid.o cpumask.o
>  
>  lib-$(CONFIG_PRINTK) += dump_stack.o
> -lib-$(CONFIG_SMP) += cpumask.o
>  
>  lib-y	+= kobject.o klist.o
>  obj-y	+= lockref.o
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index a971a82d2f43..b9728513a4d4 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -192,6 +192,7 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>  }
>  #endif
>  
> +#if NR_CPUS > 1
>  /**
>   * cpumask_local_spread - select the i'th cpu with local numa cpu's first
>   * @i: index number
> @@ -279,3 +280,4 @@ int cpumask_any_distribute(const struct cpumask *srcp)
>  	return next;
>  }
>  EXPORT_SYMBOL(cpumask_any_distribute);
> +#endif /* NR_CPUS */
> -- 
> 2.36.1
