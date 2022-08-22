Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327C459C182
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiHVOSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiHVOR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:17:58 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68D73AB16
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:17:57 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11c5ee9bf43so13024258fac.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=T4vb96jQImn+i7N+D+K6WfydPyXmqWxDxWTvbMb6X6k=;
        b=TSe2SpGBDir+805CwFZZRWD/MemoC2HuwK/SSS3DBQpDRZxUkl1RQZxQsy+Z/r/AjB
         vwIcwtqAjxVKv2dqFVyebvk9YvkebeTDDnDnDDBt35YGLQTbDCu9WqElnjmcHiSJJ/xC
         26N0JmEZAQledrqS4J76lCYhzKCWh4UXp79r/dSCnv4sm9Wj93xsRJVwV4sbp8PAHIt5
         UNkYJmBD7dGfq8qCMEt9wPpoDJnOXPKtJACKvyFZP9pvk2Te0zgKgWdyXUf7U4w9wGrz
         OKH8413KujqZ19DCigNt3V37AbBbVWfFShePKATvDfVYfYcIzCXeUMTC1mqC5AR0ibRs
         rUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=T4vb96jQImn+i7N+D+K6WfydPyXmqWxDxWTvbMb6X6k=;
        b=Irr4UU5snNBlI8EGlZ/3msFLQ4iKmHzOibkXOJYQIBqmaSXemBFbv5AXrAU6hricrX
         khT+cDJeUCLNwULcaUGkrHRNBw8kd0zRbspmQuWc2AIZqzG+bVrE8APWgd8mGCXKkrmD
         2KIKqz7C59IWDQfDbftuykEiDmNHqN5L/w8GZatJqKRqCZuBjxQ2ljp0h5gGnwSYRpXg
         lF6RtZcYyA/X0sQgU4s5AcXpOPSAPcAO4LFx8mJFuFkCL6JYf8oNp6AsuDZ8RRSuahA0
         PGaNTxBjnMnnadmSB70u2qpHv+OhKrCmBufKtSB8MAoEhiw3L/aRsmWSyvFArBuxGi4n
         fHCw==
X-Gm-Message-State: ACgBeo3oI1FocM+N6tra+QmHiiO1p1cDoiT/7+ROztXU3EQzR3pQiYzo
        r+d+UBN/LzpNa7LbvbBbqaXYpdx46BM=
X-Google-Smtp-Source: AA6agR4DytZAiZQiILumzfX6Xko7IOgkVAwZLDqistJHJxOlGPWKiAZZDTL4vD1ZKAp+oddRa9YtTw==
X-Received: by 2002:a05:6870:f2a7:b0:11c:49bb:aa6a with SMTP id u39-20020a056870f2a700b0011c49bbaa6amr12012961oap.35.1661177876998;
        Mon, 22 Aug 2022 07:17:56 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id q6-20020a056871080600b0011cf5ff4a6bsm1027877oap.55.2022.08.22.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:17:56 -0700 (PDT)
Date:   Mon, 22 Aug 2022 07:15:45 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [RFC 07/10] lib/cpumask: Introduce cpumask_not_dying_but()
Message-ID: <YwOPkc1cpoD/hs2D@yury-laptop>
References: <20220822021520.6996-1-kernelfans@gmail.com>
 <20220822021520.6996-8-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822021520.6996-8-kernelfans@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:15:17AM +0800, Pingfan Liu wrote:
> During cpu hot-removing, the dying cpus are still in cpu_online_mask.
> On the other hand, A subsystem will migrate its broker from the dying
> cpu to a online cpu in its teardown cpuhp_step.
> 
> After enabling the teardown of cpus in parallel, cpu_online_mask can not
> tell those dying from the real online.
> 
> Introducing a function cpumask_not_dying_but() to pick a real online
> cpu.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> To: linux-kernel@vger.kernel.org
> ---
>  include/linux/cpumask.h |  3 +++
>  kernel/cpu.c            |  3 +++
>  lib/cpumask.c           | 18 ++++++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 0d435d0edbcb..d2033a239a07 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -317,6 +317,9 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
>  	return i;
>  }
>  
> +/* for parallel kexec reboot */
> +int cpumask_not_dying_but(const struct cpumask *mask, unsigned int cpu);
> +
>  #define CPU_BITS_NONE						\
>  {								\
>  	[0 ... BITS_TO_LONGS(NR_CPUS)-1] = 0UL			\
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 90debbe28e85..771e344f8ff9 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1282,6 +1282,9 @@ static void cpus_down_no_rollback(struct cpumask *cpus)
>  	struct cpuhp_cpu_state *st;
>  	unsigned int cpu;
>  
> +	for_each_cpu(cpu, cpus)
> +		set_cpu_dying(cpu, true);
> +
>  	/* launch ap work one by one, but not wait for completion */
>  	for_each_cpu(cpu, cpus) {
>  		st = per_cpu_ptr(&cpuhp_state, cpu);
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 8baeb37e23d3..6474f07ed87a 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -7,6 +7,24 @@
>  #include <linux/memblock.h>
>  #include <linux/numa.h>
>  
> +/* Used in parallel kexec-reboot cpuhp callbacks */
> +int cpumask_not_dying_but(const struct cpumask *mask,
> +					   unsigned int cpu)
> +{
> +	unsigned int i;
> +
> +	if (CONFIG_SHUTDOWN_NONBOOT_CPUS) {

Hmm... Would it even work? Anyways, the documentation says:
Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
symbol into a C boolean expression, and use it in a normal C conditional:

.. code-block:: c

        if (IS_ENABLED(CONFIG_SOMETHING)) {
                ...
        }


> +		cpumask_check(cpu);
> +		for_each_cpu(i, mask)
> +			if (i != cpu && !cpumask_test_cpu(i, cpu_dying_mask))
> +				break;
> +		return i;
> +	} else {
> +		return cpumask_any_but(mask, cpu);
> +	}
> +}
> +EXPORT_SYMBOL(cpumask_not_dying_but);

I don't like how you create a dedicated function for a random
mask. Dying mask is nothing special, right? What you really
need is probably this:
        cpumask_andnot_any_but(mask, cpu_dying_mask, cpu);

Now, if you still think it's worth that, you can add a trivial wrapper
for cpu_dying_mask. (But please pick some other name, because
'not dying but' sounds like a hangover description. :) )

Thanks,
Yury

> +
>  /**
>   * cpumask_next_wrap - helper to implement for_each_cpu_wrap
>   * @n: the cpu prior to the place to search
> -- 
> 2.31.1
