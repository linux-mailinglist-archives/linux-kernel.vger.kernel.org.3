Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2011653EE5B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiFFTOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiFFTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:14:49 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FC452B00
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:14:47 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id h18so10838695qvj.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1sFfmt+aAU3MlHrhFJtWHXyGldxbtLEza9Q/vq/tl9o=;
        b=D1Fxn/imDZ+yKEXDtzx64TcIterAly3HWaTCmzC7ENFjTU1ee+CoZEYDVWZSybb/cx
         XndPbR6u0bC+W1neTG3XcC84ZsTk47i3ywAnXzGrcpXZYv1lbdLei4j2E+DkJGzlLwhe
         AcRnpxHYWi856DmWQQh9Gwnd8MKJsN5gpl8ybn6xqfZW3HCUDeAdtlIshge+3yNOs8+p
         lD5uCxI+YYX+DaOcSNxlhpFL398gJxCZbudqI2nDQD+ZtupNgtAIQjGQwGtR9pcRVkgd
         yj3Mod1LUgwRRDB4BGr6ifFffHQ5IzSWxRB2N3NWtmOC3xlB5NDjGaBhoxY0TidCu2Ww
         hUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1sFfmt+aAU3MlHrhFJtWHXyGldxbtLEza9Q/vq/tl9o=;
        b=xbc5X/mJiV2vJF5qHhCFiLJbLp8nLMKN7kUxmCW0kQpWcAIwbqM9oolo2XIAYfziJD
         IsNqIuw3P+z1T65JNje/oJWPBYcmi1AVSS9PGZJ4mvaYhyd6puQSn+7PTwTboByrIoV0
         rd03TdwYjPFCetIwLuMm3ynnGYKfKexC6igtv4bG2igS7rSKKZIbc2Jzd1uvaKl233v3
         gv06KjApFauxjrlwy8YHJDRxSK3PGGF6T4meodUQWWOFcZFolwGckqJ4aoOxuPsKeVXB
         db0Z9lGwCG/faBuA2R83eQ6ja8jYxa+9NMJvEOPHZnhfrYA+31Nqo9CzEp4v7PH15zSN
         6BDQ==
X-Gm-Message-State: AOAM532MjEJvjYdcSPG+gqazXxgSwpO+FaURPm+mmzwoFY8HF/bFMsAl
        bJ9/A6JlF9xGm2R/79+nc/8=
X-Google-Smtp-Source: ABdhPJxnnR7ytJ5vSs/YYi81m/riE2K8mM9+kuJxGK7ob+t8a3yp06jp/xumDhwyZs+6/1wn/ppQlA==
X-Received: by 2002:a05:6214:dc1:b0:467:dcd2:3f9 with SMTP id 1-20020a0562140dc100b00467dcd203f9mr13987819qvt.30.1654542886923;
        Mon, 06 Jun 2022 12:14:46 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:be9c:b2d9:3353:7a73])
        by smtp.gmail.com with ESMTPSA id ca27-20020a05622a1f1b00b00304e43ac0a5sm6150631qtb.79.2022.06.06.12.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:14:45 -0700 (PDT)
Date:   Mon, 6 Jun 2022 12:14:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/4] cpumask: Fix invalid uniprocessor mask assumption
Message-ID: <Yp5SJAkq8whC8EBI@yury-laptop>
References: <cover.1654410109.git.sander@svanheule.net>
 <cc1f7d3334348cccbf9fde091015a802f379a9be.1654410109.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1f7d3334348cccbf9fde091015a802f379a9be.1654410109.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 08:22:38AM +0200, Sander Vanheule wrote:
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
> ---
> Changes since v1:
> - Drop UP implementations instead of trying to fix them
> ---
>  include/linux/cpumask.h | 80 -----------------------------------------
>  lib/Makefile            |  3 +-
>  2 files changed, 1 insertion(+), 82 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index fe29ac7cc469..d6add0e29ef4 100644
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

It looks like cpumask_local_spread, cpumask_any_and_distribute and
cpumask_any_distribute were correct and better optimized in UP case.
cpumask_local_spread - for sure. I think it's worth keeping them
optimized.

Thanks,
Yury

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
> @@ -324,7 +245,6 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
>  	for ((cpu) = -1;						\
>  		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
>  		(cpu) < nr_cpu_ids;)
> -#endif /* SMP */
>  
>  #define CPU_BITS_NONE						\
>  {								\
> diff --git a/lib/Makefile b/lib/Makefile
> index 89fcae891361..6f26a429115b 100644
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
> -- 
> 2.36.1
