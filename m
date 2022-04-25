Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0450DC15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiDYJKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbiDYJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:10:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7B3A5D1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bwDJAf4sjG1eHBhQ2M0vl8YcdMtjPOWzFZ8QA3dO7N4=; b=Igy0pF0AqiQujnUQmo4dQ3iIDY
        EuYpCAbJnyBTbD0qdZoqknhS2S/hlXXcbXZ0MRjz/pXTYgVNRUbDJ++MHpzocpTQZ3I2Kd014sgCD
        ERSbEdCQRd2+/hlOQULNCN2wsbTJPW2NtSc/gUe688Dnsr55krEQUmerKzpOvURxoZHyPknGXkhEp
        gztzGdz1pgagPOou2TyL1Y0VTyKNm35/FEmGn7OBz/tePTWo5efcCabkHBX/GFz7XmyLuu/ZWvPDS
        2WOmb/tuTCmYjQSy9/txXHsh1n6xflYqSlAa8PNl/VFOrhRlt4Ac/Zfxx9+EyBvo8zEDAot8nAlCL
        mgMHk60g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niufO-008VRw-3J; Mon, 25 Apr 2022 09:05:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E15C980BF1; Mon, 25 Apr 2022 11:05:56 +0200 (CEST)
Date:   Mon, 25 Apr 2022 11:05:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/11] smp: define the cross call interface
Message-ID: <20220425090556.GD2731@worktop.programming.kicks-ass.net>
References: <20220422200040.93813-1-dqiao@redhat.com>
 <20220422200040.93813-3-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-3-dqiao@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:00:31PM -0400, Donghai Qiao wrote:
> The functions of cross CPU call interface are defined below :
> 
> int smp_call(int cpu, smp_call_func_t func, void *info,
> 		unsigned int flags)
> 

> int smp_call_cond(int cpu, smp_call_func_t func, void *info,
> 		smp_cond_func_t condf, unsigned int flags)
> 
> void smp_call_mask(const struct cpumask *mask, smp_call_func_t func,
> 		void *info, unsigned int flags)
> 

I think these two are a mistake. See below.

> void smp_call_mask_cond(const struct cpumask *mask, smp_call_func_t func,
> 		void *info, smp_cond_func_t condf, unsigned int flags)
> 
> int smp_call_private(int cpu, call_single_data_t *csd, unsigned int flags)

I'm thinking this is a terrible name. At least the current names tells
me what it does, whereas _private tells me nothing.

> int smp_call_any(const struct cpumask *mask, smp_call_func_t func,
> 		void *info, unsigned int flags)
> 
> The motivation of submitting this patch set is intended to make the
> existing cross CPU call mechanism become a bit more formal interface
> and more friendly to the kernel developers.

Why do you think that's needed? Mostly, it at all possible, you
shouldn't IPI.

> Basically the minimum set of functions below can satisfy any demand
> for cross CPU call from kernel consumers. For the sack of simplicity

LOL - s/sack/sake/

> self-explanatory and less code redundancy no ambiguity, the functions
> in this interface are renamed, simplified, or eliminated. But they
> are still inheriting the same semantics and parameter lists from their
> previous version.
> 
> Signed-off-by: Donghai Qiao <dqiao@redhat.com>
> ---
> v1 -> v2: removed 'x' from the function names and change XCALL to SMP_CALL from the new macros
> 
>  include/linux/smp.h |  30 +++++++++
>  kernel/smp.c        | 156 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+)
> 
> diff --git a/include/linux/smp.h b/include/linux/smp.h
> index 31811da856a3..bee1e6b5b2fd 100644
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -161,6 +161,36 @@ do {						\
>  	*(_csd) = CSD_INIT((_func), (_info));	\
>  } while (0)
>  
> +
> +/*
> + * smp_call Interface.
> + *
> + * Also see kernel/smp.c for the details.
> + */
> +#define	SMP_CALL_TYPE_SYNC		CSD_TYPE_SYNC
> +#define	SMP_CALL_TYPE_ASYNC	CSD_TYPE_ASYNC
> +#define	SMP_CALL_TYPE_IRQ_WORK	CSD_TYPE_IRQ_WORK
> +#define	SMP_CALL_TYPE_TTWU		CSD_TYPE_TTWU
> +#define	SMP_CALL_TYPE_MASK		CSD_FLAG_TYPE_MASK
> +
> +#define	SMP_CALL_ALL		-1
> +
> +extern int smp_call(int cpu, smp_call_func_t func, void *info, unsigned int flags);
> +
> +extern int smp_call_cond(int cpu, smp_call_func_t func, void *info,
> +		smp_cond_func_t condf, unsigned int flags);
> +
> +extern void smp_call_mask(const struct cpumask *mask, smp_call_func_t func,
> +		void *info, unsigned int flags);
> +
> +extern void smp_call_mask_cond(const struct cpumask *mask, smp_call_func_t func,
> +		void *info, smp_cond_func_t condf, unsigned int flags);
> +
> +extern int smp_call_private(int cpu, call_single_data_t *csd, unsigned int flags);
> +
> +extern int smp_call_any(const struct cpumask *mask, smp_call_func_t func,
> +		void *info, unsigned int flags);
> +
>  /*
>   * Enqueue a llist_node on the call_single_queue; be very careful, read
>   * flush_smp_call_function_queue() in detail.
> diff --git a/kernel/smp.c b/kernel/smp.c
> index b2b3878f0330..b1e6a8f77a9e 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -1170,3 +1170,159 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
>  	return sscs.ret;
>  }
>  EXPORT_SYMBOL_GPL(smp_call_on_cpu);
> +
> +
> +void __smp_call_mask_cond(const struct cpumask *mask,
> +		smp_call_func_t func, void *info,
> +		smp_cond_func_t cond_func,
> +		unsigned int flags)
> +{
> +}
> +
> +/*
> + * smp_call Interface
> + *
> + * Consolidate the cross CPU call usage from the history below:
> + *
> + * Normally this interface cannot be used with interrupts disabled or
> + * from a hardware interrupt handler or from a bottom half handler.
> + * But there are two exceptions:
> + * 1) It can be used during early boot while early_boot_irqs_disabled
> + *    is. In this scenario, you should use local_irq_save/restore()
> + *    instead of local_irq_disable/enable()
> + * 2) Because smp_call_private(cpu, csd, SMP_CALL_TYPE_ASYNC) is an asynchonous
> + *    call with a preallocated csd structure, thus it can be called from
> + *    the context where interrupts are disabled.
> + */
> +
> +/*
> + * Parameters:
> + *
> + * cpu: If cpu >=0 && cpu < nr_cpu_ids, the cross call is for that cpu.

If @cpu were unsigned, that could be a single expression.

> + *      If cpu == -1, the cross call is for all the online CPUs

URGH... no, please don't make it easy to IPI all. We shoulnd't ever do
that it at all avoidable. This should be a *hard* thing to make happen.

> + *
> + * func: It is the cross function that the destination CPUs need to execute.
> + *       This function must be fast and non-blocking.
> + *
> + * info: It is the parameter to func().
> + *
> + * flags: The flags specify the manner the cross call is performaned in terms
> + *	  of synchronous or asynchronous.
> + *
> + *	  A synchronous cross call will not return immediately until all
> + *	  the destination CPUs have executed func() and responded the call.
> + *
> + *	  An asynchrouse cross call will return immediately as soon as it
> + *	  has fired all the cross calls and run func() locally if needed
> + *	  regardless the status of the target CPUs.
> + *
> + * Return: %0 on success or negative errno value on error.
> + */
> +int smp_call(int cpu, smp_call_func_t func, void *info, unsigned int flags)
> +{
> +	return smp_call_cond(cpu, func, info, NULL, flags);
> +}
> +EXPORT_SYMBOL(smp_call);

Given this uses smp_call_cond(), it's defintion should come after the
definition of smp_call_cond().

> +/*
> + * Parameters:
> + *
> + * cond_func: This is a condition function cond_func(cpu, info) invoked by
> + *	      the underlying cross call mechanism only. If the return value
> + *	      from cond_func(cpu, info) is true, the cross call will be sent
> + *	      to that cpu, otherwise the call will not be sent.
> + *
> + * Others: see smp_call().
> + *
> + * Return: %0 on success or negative errno value on error.
> + */
> +int smp_call_cond(int cpu, smp_call_func_t func, void *info,
> +		    smp_cond_func_t cond_func, unsigned int flags)
> +{
> +	preempt_disable();
> +	if (cpu == SMP_CALL_ALL) {
> +		__smp_call_mask_cond(cpu_online_mask, func, info, cond_func, flags);

Should we mandate @cond != NULL ?

> +	} else if ((unsigned int)cpu < nr_cpu_ids)
> +		__smp_call_mask_cond(cpumask_of(cpu), func, info, cond_func, flags);

That's a fairly useless combination. If you IPI a single CPU you had
better already know if @cond is true or not.

> +	else {

Very inconsistent use of {} there.

> +		preempt_enable();
> +		pr_warn("Invalid cpu ID = %d\n", cpu);
> +		return -ENXIO;
> +	}
> +	preempt_enable();
> +	return 0;
> +}
> +EXPORT_SYMBOL(smp_call_cond);
> +
> +/*
> + * Parameters:
> + *
> + * mask: This is the bitmap of CPUs to which the cross call will be sent.
> + *
> + * Others: see smp_call().
> + */
> +void smp_call_mask(const struct cpumask *mask, smp_call_func_t func,
> +		void *info, unsigned int flags)
> +{
> +	preempt_disable();
> +	__smp_call_mask_cond(mask, func, info, NULL, flags);
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(smp_call_mask);

Arguably, the whole preempt thing should be in __smp_call_mask_cond(),
also, I really don't see the point of having these two functions above.

> +
> +/*
> + * The combination of smp_call_cond() and smp_call_mask()
> + */
> +void smp_call_mask_cond(const struct cpumask *mask,
> +		smp_call_func_t func, void *info,
> +		smp_cond_func_t cond_func,
> +		unsigned int flags)
> +{
> +	preempt_disable();
> +	__smp_call_mask_cond(mask, func, info, cond_func, flags);
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(smp_call_mask_cond);

This should be something like:

{
	preempt_disable();
	if (!mask) {
		WARN_ON_ONCE(!cond);
		mask = cpu_online_mask;
	}
	__smp_call_mask_cond(mask, func, info, cond_func, flags);
	preempt_enable();
}

So then we have smp_call(@cpu) for if you want to IPI a single specific
CPU and smp_call_mask_cond() for anything else. Additionally if you want
.mask=NULL to IPI-all then .cond *must* be set.

Because IPI-all is *BAD*, it must not be done if it can be avoided.

> +/*
> + * Parameters:
> + *
> + * mask:  Run func() on one of the given CPUs in mask if it is oneline.
> + *        CPU selection preference (from the original comments for
> + *        smp_call_function_any()) :
> + *          1) current cpu if in @mask
> + *          2) any cpu of current node if in @mask
> + *          3) any other online cpu in @mask
> + *
> + * Others, see smp_call().
> + *
> + * Returns 0 on success, else a negative status code (if no cpus were online).
> + */
> +int smp_call_any(const struct cpumask *mask, smp_call_func_t func,
> +		void *info, unsigned int flags)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(smp_call_any);

Seriously? is there anybody who does something daft like this? If you
don't care who gets the IPI, maybe you shouldn't IPI.
