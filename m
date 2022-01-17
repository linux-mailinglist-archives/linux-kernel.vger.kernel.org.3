Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29804910BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 20:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbiAQTmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 14:42:10 -0500
Received: from foss.arm.com ([217.140.110.172]:35784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231558AbiAQTmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 14:42:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A85916D;
        Mon, 17 Jan 2022 11:42:08 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE0E53F774;
        Mon, 17 Jan 2022 11:42:06 -0800 (PST)
Date:   Mon, 17 Jan 2022 19:42:04 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, lukasz.luba@arm.com
Subject: Re: [PATCH v2 1/7] sched/fair: Provide u64 read for 32-bits arch
 helper
Message-ID: <YeXDLDBX2GbfSQ+S@FVFF7649Q05P>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
 <20220112161230.836326-2-vincent.donnefort@arm.com>
 <YeWVK8EY/s1TMOD4@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeWVK8EY/s1TMOD4@geo.homenetwork>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > +/*
> > + * u64_u32_load/u64_u32_store
> > + *
> > + * Use a copy of a u64 value to protect against data race. This is only
> > + * applicable for 32-bits architectures.
> > + */
> > +#ifdef CONFIG_64BIT
> > +# define u64_u32_load_copy(var, copy)       var
> > +# define u64_u32_store_copy(var, copy, val) (var = val)
> > +#else
> > +# define u64_u32_load_copy(var, copy)					\
> > +({									\
> > +	u64 __val, __val_copy;						\
> > +	do {								\
> > +		__val_copy = copy;					\
> > +		/*							\
> > +		 * paired with u64_u32_store, ordering access		\
> > +		 * to var and copy.					\
> > +		 */							\
> > +		smp_rmb();						\
> > +		__val = var;						\
> > +	} while (__val != __val_copy);					\
> > +	__val;								\
> > +})
> > +# define u64_u32_store_copy(var, copy, val)				\
> > +do {									\
> > +	typeof(val) __val = (val);					\
> > +	var = __val;							\
> > +	/*								\
> > +	 * paired with u64_u32_load, ordering access to var and		\
> > +	 * copy.							\
> > +	 */								\
> > +	smp_wmb();							\
> > +	copy = __val;							\
> > +} while (0)
> 
> Code stay there some time from me. Just from my crude review;
> The above macro need a variable to load @var temporarily for
> later store; that means the @copy value is from @var not @val.
> 
>   # define u64_u32_store_copy(var, copy, val)				\
>   do {									\
>     typeof(val) __val = (val), __var = (var);					\
>     var = __val;							\
>     /*								\
>      * paired with u64_u32_load, ordering access to var and		\
>      * copy.							\
>      */								\
>     smp_wmb();							\
>     copy = __var;							\
>   } while (0)


Hi Tao,

__var would then contain the previous value of @var, wouldn't it? We need
both @var and @copy to be equal to @val.

> 
> 
> 
> Thanks,
> Tao

