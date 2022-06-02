Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D31C53C11B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiFBWue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbiFBWuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:50:32 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8923237A87
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 15:50:31 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id e11-20020a9d6e0b000000b0060afcbafa80so4417265otr.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EvwnZSWxH+4SifzKqxHbq0ZX5vJRMwq56kMlLvV2OGo=;
        b=kryx6LW9tji/L4CwgvZextEC/IsovFlRWxQlQITpabh0P+jCDq6Xmi5zv1hhV3qc69
         1dGMqSYH7Ea+oBBqN/SbV3ToPfYmpZqUw6MdcKBYzoPatckhtYXlCZJAoa3uoTSf5cOv
         i9sIgwPm9H+xL+g1bABZXEVD9AbfFRUsI6zBnx/FPRaLH2Fd7TjZEUC5ZYflToRxObRb
         PPTl2O2zRJnxpUkOaVMwEZxcgagLkSlKQi9OTG3KqNaNvjj40Nv8ir3G1gtdbLil2+ju
         02lezCvR0iQUX3Y1MyQsDyBPdAv0c8uNS4w+Q6mHKG4EMqFaZU9pcO1YRPmBDiKoYk71
         EwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EvwnZSWxH+4SifzKqxHbq0ZX5vJRMwq56kMlLvV2OGo=;
        b=57FeuuJBeTNjUGPbVuzdWfPiIMxfv1jLkFvpXtYVgOw3dpwMG2uJ8GkaBA0guDyIpb
         idvSnCehVldWB08DxWwN9gket/s633ZBTYN7yLG9EFdterOGOMxH59U13G/wDnK2z0TU
         r8D0oixr8Mw7aZ+DVQX82wNwmhYNIMP+JXbY0cx7gVTOC87AO2+VncMp+oNcGg3EQKoq
         NWwTq8PSnPJQpz8SQbSXpFkGm+ng+cZj6h7kNh0MgZFNyEB05eipk92vf81KufSS5bQF
         yA6cSkClt5COMqqMAS8AujkhCoMiMe9ZDv3wueE57CvzvFcGUIgjYFK1AYaGzKK+Ibua
         jErg==
X-Gm-Message-State: AOAM533wtYO6/cON6OJXGSJ4G5wOw1HexYzb/m6MRBr1vkmEkLQb+kt9
        KaCm+bU1zk19MkA8pTkje/o=
X-Google-Smtp-Source: ABdhPJxxadeFiTJMRE7rvaCtmz+LSvWQU0W5TWQujivIEO+FxWbA8OobF1MRkD3DYWtLdc0caUj3fw==
X-Received: by 2002:a9d:71d5:0:b0:60b:74e:dbb5 with SMTP id z21-20020a9d71d5000000b0060b074edbb5mr3027610otj.119.1654210230699;
        Thu, 02 Jun 2022 15:50:30 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id ga9-20020a056870ee0900b000f5ccbb7d75sm2616398oab.1.2022.06.02.15.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 15:50:30 -0700 (PDT)
Date:   Thu, 2 Jun 2022 15:48:16 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] cpumask: Fix invalid uniprocessor mask assumption
Message-ID: <Ypk+MKSSaSCBnITY@yury-laptop>
References: <cover.1654201862.git.sander@svanheule.net>
 <017b97698ba58d33bf45d30317d5a73c5b93d2a0.1654201862.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017b97698ba58d33bf45d30317d5a73c5b93d2a0.1654201862.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:04:19PM +0200, Sander Vanheule wrote:
> On uniprocessor builds, any CPU mask is assumed to contain exactly one
> CPU (cpu0). This ignores the existence of empty masks, resulting in
> incorrect behaviour for most of the implemented optimisations.
> 
> Replace the uniprocessor optimisations with implementations that also
> take into account empty masks. Also drop the incorrectly optimised
> for_each_cpu implementations and use the generic implementations in all
> cases.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  include/linux/cpumask.h | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index fe29ac7cc469..ce8c7b27f6c9 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -117,51 +117,54 @@ static __always_inline unsigned int cpumask_check(unsigned int cpu)
>  }
>  
>  #if NR_CPUS == 1
> -/* Uniprocessor.  Assume all masks are "1". */
> +/* Uniprocessor. Assume all valid masks are "1" or empty. */
>  static inline unsigned int cpumask_first(const struct cpumask *srcp)
>  {
> -	return 0;
> +	return !(*cpumask_bits(srcp) & 1);
>  }
 
I think, you can just drop this '#if NR_CPUS == 1' part and rely on SMP
versions. find_first_bit() is optimized for short bitmaps, so I expect
no overhead comparing to this.
  
>  static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
>  {
> -	return 0;
> +	return *cpumask_bits(srcp) & 1;
>  }
>  
>  static inline unsigned int cpumask_first_and(const struct cpumask *srcp1,
>  					     const struct cpumask *srcp2)
>  {
> -	return 0;
> +	return !(*cpumask_bits(srcp1) & *cpumask_bits(srcp2) & 1);
>  }
>  
>  static inline unsigned int cpumask_last(const struct cpumask *srcp)
>  {
> -	return 0;
> +	return cpumask_first(srcp);
>  }
>  
>  /* Valid inputs for n are -1 and 0. */
>  static inline unsigned int cpumask_next(int n, const struct cpumask *srcp)
>  {
> -	return n+1;
> +	return !!(n + 1 + cpumask_first(srcp));
>  }
>  
>  static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>  {
> -	return n+1;
> +	return !!(n + 1 + cpumask_first_zero(srcp));
>  }
>  
>  static inline unsigned int cpumask_next_and(int n,
>  					    const struct cpumask *srcp,
>  					    const struct cpumask *andp)
>  {
> -	return n+1;
> +	return !!(n + 1 + cpumask_first_and(srcp, andp));
>  }
>  
>  static inline unsigned int cpumask_next_wrap(int n, const struct cpumask *mask,
>  					     int start, bool wrap)
>  {
> -	/* cpu0 unless stop condition, wrap and at cpu0, then nr_cpumask_bits */
> -	return (wrap && n == 0);
> +	/*
> +	 * nr_cpumask_bits at stop condition, wrap and at cpu0, or empty mask
> +	 * otherwise cpu0
> +	 */
> +	return (wrap && n == 0) || cpumask_first(mask);
>  }
>  
>  /* cpu must be a valid cpu, ie 0, so there's no other choice. */
> @@ -186,14 +189,6 @@ static inline int cpumask_any_distribute(const struct cpumask *srcp)
>  	return cpumask_first(srcp);
>  }
>  
> -#define for_each_cpu(cpu, mask)			\
> -	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> -#define for_each_cpu_not(cpu, mask)		\
> -	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> -#define for_each_cpu_wrap(cpu, mask, start)	\
> -	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
> -#define for_each_cpu_and(cpu, mask1, mask2)	\
> -	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2)
>  #else
>  /**
>   * cpumask_first - get the first cpu in a cpumask
> @@ -259,11 +254,13 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>  }
>  
>  int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
> +extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);

is this extern needed?

Thanks,
Yury

>  int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
>  unsigned int cpumask_local_spread(unsigned int i, int node);
>  int cpumask_any_and_distribute(const struct cpumask *src1p,
>  			       const struct cpumask *src2p);
>  int cpumask_any_distribute(const struct cpumask *srcp);
> +#endif /* SMP */
>  
>  /**
>   * for_each_cpu - iterate over every cpu in a mask
> @@ -289,7 +286,6 @@ int cpumask_any_distribute(const struct cpumask *srcp);
>  		(cpu) = cpumask_next_zero((cpu), (mask)),	\
>  		(cpu) < nr_cpu_ids;)
>  
> -extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
>  
>  /**
>   * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
> @@ -324,7 +320,6 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
>  	for ((cpu) = -1;						\
>  		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
>  		(cpu) < nr_cpu_ids;)
> -#endif /* SMP */
>  
>  #define CPU_BITS_NONE						\
>  {								\
> -- 
> 2.36.1
