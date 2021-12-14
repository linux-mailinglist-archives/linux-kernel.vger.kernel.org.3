Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6BF4746EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhLNP4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhLNP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:56:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA34C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=EGMW+jMaJWxqVYPoPoipt7V2zmjhBmVrUGJa9k6HAHU=; b=E9zYT8iMlGhC2RI2WMvOf5uV5B
        DprpLVwzjl0CVGv28pSqLHdFcr8BgFHjEPJ+26EMq/fAXhUadZI0NcEBslpcA0PMcNjk48sR4Lf9n
        x04qZcLHoR1MkyrI5yuKqqmjd/SKI5FK3Ceo3ef+FHjVD1xXRWKzLQRrI+yyZvl+hrJrNEc14vMXj
        halCex387orY+verSGjm0lxLcik/26NnBe/mfC6VvMX3Dagpnnt0+NEyHhPs4VKYxMJwq2sEUEmAj
        WZW2rCVhRk8keOxZ5MrbL+c8bIacguhztUHvuswSsu3knAHHwMsqQodDnaqo/rXRbUFivnMO64Pgn
        LCqnfK1w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxAAD-00DqlS-Ii; Tue, 14 Dec 2021 15:56:27 +0000
Message-ID: <dda484cf-d974-dba3-db54-4df470a1ff2e@infradead.org>
Date:   Tue, 14 Dec 2021 07:56:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] smp: Fix the comments of smp_call_function_many()
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20211214081100.126-1-thunder.leizhen@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211214081100.126-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/14/21 00:10, Zhen Lei wrote:
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
> and restore the original comments of smp_call_function_many().
> 
> Finally, the comments have been simplified slightly to avoid duplication.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/smp.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> v1 --> v2:
> Delete some duplicate comments.
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 01a7c1706a58b1d..9cbe2509d1010ea 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -853,14 +853,17 @@ int smp_call_function_any(const struct cpumask *mask,
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
> + * @scf_flags: Bitmask that controls the operation. Such as SCF_WAIT,
> + *             SCF_RUN_LOCAL.
> + */
>  static void smp_call_function_many_cond(const struct cpumask *mask,
>  					smp_call_func_t func, void *info,
>  					unsigned int scf_flags,
> @@ -972,14 +975,12 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  }
>  
>  /**
> - * smp_call_function_many(): Run a function on a set of CPUs.
> + * smp_call_function_many(): Run a function on a set of other CPUs.
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

After applying this patch, kernel-doc emits 4 warnings:

smp.c:871: warning: Function parameter or member 'mask' not described in 'smp_call_function_many_cond'
smp.c:871: warning: Function parameter or member 'func' not described in 'smp_call_function_many_cond'
smp.c:871: warning: Function parameter or member 'info' not described in 'smp_call_function_many_cond'
smp.c:871: warning: Function parameter or member 'cond_func' not described in 'smp_call_function_many_cond'


thanks.
-- 
~Randy
