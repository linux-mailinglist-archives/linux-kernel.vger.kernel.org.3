Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408EF476732
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhLPBBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLPBBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:01:40 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A008C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 17:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mCqjKwUnrxgO0CPAG5UQvGJG1yly6q5JSPyo0QzZaWE=; b=RYl1CfB8RVdjXeuyn59tOdvAVx
        C/+AtHl6ro4RP9iZOvwKWmJkAK4AtCmde/OmdiWUgcUqlzhtF4inlu8+jfT2PrH1QF3BydWEUCAPP
        pq6gJVFx54p++3sENtbGaNrkS2SoNfHTifsI+r1oriQQIeroekLylz4gp/LBukTExh9rGXLEUO26n
        D+c7eRCr98/6R/fdtAl3m0WqHuafcF91YdfqwZIJyu98JaaxpDqJaDo5yUcm5XOBJMXbaf0DjKN+D
        l2hykXgRwSPcOzEUrNx0tJ8m7VBe46a2fJnF+cTmBYDZMP4qD4MuMeIfN4yf7yx9bYOTCCNxsKOQg
        BXc+04dQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxf9B-001bPj-RA; Thu, 16 Dec 2021 01:01:26 +0000
Message-ID: <d07a3735-243a-535b-001a-c657f4305bf0@infradead.org>
Date:   Wed, 15 Dec 2021 17:01:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] smp: Fix the comments of smp_call_function_many()
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20211215122931.179-1-thunder.leizhen@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211215122931.179-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/15/21 04:29, Zhen Lei wrote:
> As commit a32a4d8a815c ("smp: Run functions concurrently in
> smp_call_function_many_cond()") itself says:
>                   "Keep other smp_call_function_many() semantic as it is
> today for backward compatibility: the called function is not executed in
> this case locally."
> 
> It's clear that, the function header comments of smp_call_function_many()
> does not need to be changed.
> 
> So move the comment about 'scf_flags' to smp_call_function_many_cond(),
> and restore the original comments of smp_call_function_many(). The
> comments have been simplified slightly to avoid duplication. And the
> description of other parameters of smp_call_function_many_cond() is added.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/smp.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> v2 --> v3:
> Add the descrition of other parameters of smp_call_function_many_cond().

          description

OK, this patch works (that is, scripts/kernel-doc does not complain).
However:

> 
> v1 --> v2:
> Delete some duplicate comments.
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 01a7c1706a58b1d..46ef41d6b6f197e 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -853,14 +853,26 @@ int smp_call_function_any(const struct cpumask *mask,
>  EXPORT_SYMBOL_GPL(smp_call_function_any);
>  
>  /*
> - * Flags to be used as scf_flags argument of smp_call_function_many_cond().
> - *
>   * %SCF_WAIT:		Wait until function execution is completed
>   * %SCF_RUN_LOCAL:	Run also locally if local cpu is set in cpumask
>   */
>  #define SCF_WAIT	(1U << 0)
>  #define SCF_RUN_LOCAL	(1U << 1)
>  
> +/**
> + * smp_call_function_many_cond(): Run a function on a set of CPUs.

The documented character to use after a function name is '-', not ':'. So

 * smp_call_function_many_cond() - Run a function on a set of CPUs

and

> + * @mask:	The set of cpus to run on (only runs on online subset).
> + *		Whether to allow execution on the local CPU is also controlled
> + *		by @scf_flags.
> + * @func:	The function to run on all applicable CPUs.
> + * @info:	An arbitrary pointer to pass to @func.
> + * @scf_flags:	Bitmask that controls the operation. Such as SCF_WAIT,
> + *		SCF_RUN_LOCAL.
> + * @cond_func:	A callback function that is passed a cpu id and the info
> + *		parameter. The function should return a blooean value
> + *		indicating whether @func will be executed on the specified CPU.
> + *		If @cond_func is NULL, that means unconditional, always true.
> + */
>  static void smp_call_function_many_cond(const struct cpumask *mask,
>  					smp_call_func_t func, void *info,
>  					unsigned int scf_flags,
> @@ -972,14 +984,12 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  }
>  
>  /**
> - * smp_call_function_many(): Run a function on a set of CPUs.
> + * smp_call_function_many(): Run a function on a set of other CPUs.

 * smp_call_function_many() - Run a function on a set of other CPUs.

are preferable.

>   * @mask: The set of cpus to run on (only runs on online subset).
>   * @func: The function to run. This must be fast and non-blocking.
>   * @info: An arbitrary pointer to pass to the function.
> - * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
> - *        (atomically) until function has completed on other CPUs. If
> - *        %SCF_RUN_LOCAL is set, the function will also be run locally
> - *        if the local CPU is set in the @cpumask.
> + * @wait: If true, wait (atomically) until function has completed
> + *        on other CPUs.
>   *
>   * If @wait is true, then returns once @func has returned.
>   *
> 

thanks.
-- 
~Randy
