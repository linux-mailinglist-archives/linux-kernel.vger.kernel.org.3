Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C149126D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 00:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbiAQXpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 18:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiAQXpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 18:45:00 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF498C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 15:44:59 -0800 (PST)
Date:   Tue, 18 Jan 2022 07:44:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1642463097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jgK5Clodoz0vuYNJCwWgm6WXu1kx5wRywemzPx+NBvw=;
        b=Eto2CZBYlPtO0ItAbAhPRM5S05rZYlKeNE102wD+UkjIpM6qDqyYRioOezqeD+WwRoqGx7
        RUM91WZnGnC+kQhu51uhISO4rPdGJf9oZ7M75tXID42DJRjPz6etLijbeCD4f8HoB9Dazg
        Ahgj+B0IP5MJyC+/o4tHrLTCjL/0aQ4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, lukasz.luba@arm.com,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH v2 1/7] sched/fair: Provide u64 read for 32-bits arch
 helper
Message-ID: <YeX/dkwAAalVFmGg@geo.homenetwork>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
 <20220112161230.836326-2-vincent.donnefort@arm.com>
 <YeWVK8EY/s1TMOD4@geo.homenetwork>
 <YeXDLDBX2GbfSQ+S@FVFF7649Q05P>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeXDLDBX2GbfSQ+S@FVFF7649Q05P>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 07:42:04PM +0000, Vincent Donnefort wrote:
> [...]
> 
> > > +/*
> > > + * u64_u32_load/u64_u32_store
> > > + *
> > > + * Use a copy of a u64 value to protect against data race. This is only
> > > + * applicable for 32-bits architectures.
> > > + */
> > > +#ifdef CONFIG_64BIT
> > > +# define u64_u32_load_copy(var, copy)       var
> > > +# define u64_u32_store_copy(var, copy, val) (var = val)
> > > +#else
> > > +# define u64_u32_load_copy(var, copy)					\
> > > +({									\
> > > +	u64 __val, __val_copy;						\
> > > +	do {								\
> > > +		__val_copy = copy;					\
> > > +		/*							\
> > > +		 * paired with u64_u32_store, ordering access		\
> > > +		 * to var and copy.					\
> > > +		 */							\
> > > +		smp_rmb();						\
> > > +		__val = var;						\
> > > +	} while (__val != __val_copy);					\
> > > +	__val;								\
> > > +})
> > > +# define u64_u32_store_copy(var, copy, val)				\
> > > +do {									\
> > > +	typeof(val) __val = (val);					\
> > > +	var = __val;							\
> > > +	/*								\
> > > +	 * paired with u64_u32_load, ordering access to var and		\
> > > +	 * copy.							\
> > > +	 */								\
> > > +	smp_wmb();							\
> > > +	copy = __val;							\
> > > +} while (0)
> > 
> > Code stay there some time from me. Just from my crude review;
> > The above macro need a variable to load @var temporarily for
> > later store; that means the @copy value is from @var not @val.
> > 
> >   # define u64_u32_store_copy(var, copy, val)				\
> >   do {									\
> >     typeof(val) __val = (val), __var = (var);					\
> >     var = __val;							\
> >     /*								\
> >      * paired with u64_u32_load, ordering access to var and		\
> >      * copy.							\
> >      */								\
> >     smp_wmb();							\
> >     copy = __var;							\
> >   } while (0)
> 
> 
> Hi Tao,
> 
> __var would then contain the previous value of @var, wouldn't it? We need
> both @var and @copy to be equal to @val.

Sorry for the noise, I'm wrong here.

> 
> > 
> > 
> > 
> > Thanks,
> > Tao
