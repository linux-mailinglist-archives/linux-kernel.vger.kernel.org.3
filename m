Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5D50DC32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbiDYJOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbiDYJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:13:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087B1CABA1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PtVe1iWNOkZD3Ag5Tlk3rDK+4QAZNviMZC3dxAtlGFo=; b=aznWSDaNcHkD33pKTbQmzvEZ/M
        cXqQoVoIidAAIe749nz4SYc0dC+6D1VZQ7RGyE8lRwQu1QwVQQPoh3M1YEn1w15EZwnqh+AmSFiCd
        dZTBSdu7wpMx4lLTjgY+jEkpKFFJyuEh/dHPMcKzFw/uqKz5XuKjZrN0VfMs5yZebbLWdE2xtMvu8
        9B5mFp8aCwfg0X5Zfj8uEE/hHv6qzvEM/1vJsEVpHHjE1wjfIAupVSV/tkpima8ClqAhjQurH+R7C
        uNndpERWY2S3MtJv1T4L06vEM9LQw+YmYHMu9Pm1y8eQpKmTF6SJ/TFw1n33rM2zZkvzQTJMebGlI
        hzGT7n5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niujO-008VVz-Aj; Mon, 25 Apr 2022 09:10:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF208980BF1; Mon, 25 Apr 2022 11:10:05 +0200 (CEST)
Date:   Mon, 25 Apr 2022 11:10:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] smp: eliminate SCF_WAIT and SCF_RUN_LOCAL
Message-ID: <20220425091005.GE2731@worktop.programming.kicks-ass.net>
References: <20220422200040.93813-1-dqiao@redhat.com>
 <20220422200040.93813-4-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-4-dqiao@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:00:32PM -0400, Donghai Qiao wrote:
> The commit a32a4d8a815c ("smp: Run functions concurrently in
> smp_call_function_many_cond()") was to improve the concurrent
> of the cross call execution between local and remote. The change
> in smp_call_function_many_cond() did what was intended, but the
> new macro SCF_WAIT and SCF_RUN_LOCAL and the code around them
> to handle local call were not unnecessary because the modified
> function smp_call_function_many() was able to handle the local
> cross call. So these two macros can be eliminated and the code
> implemented around that can be removed as well.

Maybe I've not had enough wake-up-juice, but I can't parse the above,
what?!


> @@ -787,23 +787,13 @@ int smp_call_function_any(const struct cpumask *mask,
>  }
>  EXPORT_SYMBOL_GPL(smp_call_function_any);
>  
> -/*
> - * Flags to be used as scf_flags argument of smp_call_function_many_cond().
> - *
> - * %SCF_WAIT:		Wait until function execution is completed
> - * %SCF_RUN_LOCAL:	Run also locally if local cpu is set in cpumask
> - */
> -#define SCF_WAIT	(1U << 0)
> -#define SCF_RUN_LOCAL	(1U << 1)
> -
>  static void smp_call_function_many_cond(const struct cpumask *mask,
>  					smp_call_func_t func, void *info,
> -					unsigned int scf_flags,
> +					bool wait,
>  					smp_cond_func_t cond_func)
>  {
>  	int cpu, last_cpu, this_cpu = smp_processor_id();
>  	struct call_function_data *cfd;
> -	bool wait = scf_flags & SCF_WAIT;
>  	bool run_remote = false;
>  	bool run_local = false;
>  	int nr_cpus = 0;
> @@ -829,14 +819,14 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  	WARN_ON_ONCE(!in_task());
>  
>  	/* Check if we need local execution. */
> -	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask))
> +	if (cpumask_test_cpu(this_cpu, mask))
>  		run_local = true;
>  
>  	/* Check if we need remote execution, i.e., any CPU excluding this one. */
>  	cpu = cpumask_first_and(mask, cpu_online_mask);
>  	if (cpu == this_cpu)
>  		cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
> -	if (cpu < nr_cpu_ids)
> +	if ((unsigned int)cpu < nr_cpu_ids)
>  		run_remote = true;
>  
>  	if (run_remote) {
> @@ -911,12 +901,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>   * @mask: The set of cpus to run on (only runs on online subset).
>   * @func: The function to run. This must be fast and non-blocking.
>   * @info: An arbitrary pointer to pass to the function.
> - * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
> - *        (atomically) until function has completed on other CPUs. If
> - *        %SCF_RUN_LOCAL is set, the function will also be run locally
> - *        if the local CPU is set in the @cpumask.
> - *
> - * If @wait is true, then returns once @func has returned.
> + * @wait: If wait is true, the call will not return until func()
> + *        has completed on other CPUs.
>   *
>   * You must not call this function with disabled interrupts or from a
>   * hardware interrupt handler or from a bottom half handler. Preemption
> @@ -925,7 +911,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  void smp_call_function_many(const struct cpumask *mask,
>  			    smp_call_func_t func, void *info, bool wait)
>  {
> -	smp_call_function_many_cond(mask, func, info, wait * SCF_WAIT, NULL);
> +	smp_call_function_many_cond(mask, func, info, wait, NULL);
>  }
>  EXPORT_SYMBOL(smp_call_function_many);

This changes the semantics of smp_call_function_many(), before this, if
self was in the mask it wouldn't call @func, now it will.

I appreciate you want to clean that up, but you can't do that without
auditing all callers.
