Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306795103C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353086AbiDZQqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiDZQqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 189CB45ACD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650991370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D4Wo1BOUbiwCKjHDQuE2fXDkFkLp6gsv3e+wn4BHxY4=;
        b=BfJotS1C+NcS9uPR6EGxN4cVHu9rzw/9BKjy2ClBe4y/ypURl//3qF1Z9c/hqxpVpwg4BC
        IwK/LTYrrDHcreSIW5xVzxogl+jrcvDpXwmdubQsFszDNIIed/IOwBI3qVJDgx0pQmTC7g
        tYi8RqvaXRMzsetW52lvrsQDBr6mV/o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-cqXGR2ixPsis1NyJH0u7KQ-1; Tue, 26 Apr 2022 12:42:48 -0400
X-MC-Unique: cqXGR2ixPsis1NyJH0u7KQ-1
Received: by mail-wm1-f69.google.com with SMTP id v191-20020a1cacc8000000b0038ce818d2efso8291677wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=D4Wo1BOUbiwCKjHDQuE2fXDkFkLp6gsv3e+wn4BHxY4=;
        b=tDVzNtPQZxPiVHELd7ztXP774XYfZkGQpOMkRqfFn0ZSMSaX7bLF5Z+AgDdUvKVffP
         Y4gKUzE+yp2cfz9L79gbAft5tmnfj1IfkRUdriJeEAB+Jk3YjeXDAjapi2zyN8PjkIPr
         eCJ4BlwJKIXgtNYhnDMQFR+vm340Kp4VV9KXCbxmFDp4u5FAgbMnNbC4djx2XvaOqC9Y
         j1n1odx60qgbppSnUx6AHx0pkPs7+7eAp/Uk/y7T9O49ra33025wxkRr5X/EXMlmg4jG
         swxL1WpVbzKiA14to2VtFBr7BdS9RhsWvYHJLKdpyuPaB1T6O9/dAOrf9PFl2d3iCZ2O
         Q4Lw==
X-Gm-Message-State: AOAM531UAeuc9FSER5c2feky/v5JwiZxJyHgoC6KoO+/tWAZlMw9AkJG
        KPrtYHx9cGwUT6pNUl2NK2xQ+21NDIklhgVItZwjkKrYPccLc4qq9G+EJuQktxAa+ldhe5p8vi5
        x6xCt9QlO+/G7hefChmM8hMU7
X-Received: by 2002:a05:600c:348f:b0:393:dcff:f95b with SMTP id a15-20020a05600c348f00b00393dcfff95bmr19418053wmq.76.1650991366012;
        Tue, 26 Apr 2022 09:42:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw8SSeU6/it9DsVKT+zwFdAr+l3N0XPyXxX5+e0HOP9IQFGUbD8XN9KzX3ugSn+4PrPHPk3Q==
X-Received: by 2002:a05:600c:348f:b0:393:dcff:f95b with SMTP id a15-20020a05600c348f00b00393dcfff95bmr19418039wmq.76.1650991365758;
        Tue, 26 Apr 2022 09:42:45 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1306:2f00:cfcf:62cf:6f38:dd92? ([2a0c:5a80:1306:2f00:cfcf:62cf:6f38:dd92])
        by smtp.gmail.com with ESMTPSA id r20-20020adfb1d4000000b0020adba3a4d6sm5555643wra.77.2022.04.26.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 09:42:45 -0700 (PDT)
Message-ID: <0d6bf5a97777bec1e0b425f2fb33dbb80d848621.camel@redhat.com>
Subject: Re: [PATCH 5/6] mm/page_alloc: Protect PCP lists with a spinlock
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Tue, 26 Apr 2022 18:42:43 +0200
In-Reply-To: <20220420095906.27349-6-mgorman@techsingularity.net>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
         <20220420095906.27349-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 10:59 +0100, Mel Gorman wrote:
> Currently the PCP lists are protected by using local_lock_irqsave to
> prevent migration and IRQ reentrancy but this is inconvenient. Remote
> draining of the lists is impossible and a workqueue is required and
> every task allocation/free must disable then enable interrupts which is
> expensive.
> 
> As preparation for dealing with both of those problems, protect the
> lists with a spinlock. The IRQ-unsafe version of the lock is used
> because IRQs are already disabled by local_lock_irqsave. spin_trylock
> is used in preparation for a time when local_lock could be used instead
> of lock_lock_irqsave.
> 
> The per_cpu_pages still fits within the same number of cache lines after
> this patch relative to before the series.
> 
> struct per_cpu_pages {
>         spinlock_t                 lock;                 /*     0     4 */
>         int                        count;                /*     4     4 */
>         int                        high;                 /*     8     4 */
>         int                        batch;                /*    12     4 */
>         short int                  free_factor;          /*    16     2 */
>         short int                  expire;               /*    18     2 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         struct list_head           lists[13];            /*    24   208 */
> 
>         /* size: 256, cachelines: 4, members: 7 */
>         /* sum members: 228, holes: 1, sum holes: 4 */
>         /* padding: 24 */
> } __attribute__((__aligned__(64)));
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/mmzone.h |   1 +
>  mm/page_alloc.c        | 155 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 136 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index abe530748de6..8b5757735428 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -385,6 +385,7 @@ enum zone_watermarks {
>  
>  /* Fields and list protected by pagesets local_lock in page_alloc.c */
>  struct per_cpu_pages {
> +	spinlock_t lock;	/* Protects lists field */
>  	int count;		/* number of pages in the list */
>  	int high;		/* high watermark, emptying needed */
>  	int batch;		/* chunk size for buddy add/remove */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dc0fdeb3795c..813c84b67c65 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -132,6 +132,17 @@ static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
>  	.lock = INIT_LOCAL_LOCK(lock),
>  };
>  
> +#ifdef CONFIG_SMP
> +/* On SMP, spin_trylock is sufficient protection */
> +#define pcp_trylock_prepare(flags)	do { } while (0)
> +#define pcp_trylock_finish(flag)	do { } while (0)
> +#else
> +
> +/* UP spin_trylock always succeeds so disable IRQs to prevent re-entrancy. */

This is only needed on non-RT kernels. RT UP builds go through
rt_spin_trylock(), which behaves like its SMP counterpart.

> +#define pcp_trylock_prepare(flags)	local_irq_save(flags)
> +#define pcp_trylock_finish(flags)	local_irq_restore(flags)
> +#endif
> +
>  #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
>  DEFINE_PER_CPU(int, numa_node);
>  EXPORT_PER_CPU_SYMBOL(numa_node);
> @@ -3082,15 +3093,22 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>   */
>  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>  {
> -	unsigned long flags;
>  	int to_drain, batch;
>  
> -	local_lock_irqsave(&pagesets.lock, flags);
>  	batch = READ_ONCE(pcp->batch);
>  	to_drain = min(pcp->count, batch);
> -	if (to_drain > 0)
> +	if (to_drain > 0) {
> +		unsigned long flags;
> +
> +		/* free_pcppages_bulk expects IRQs disabled for zone->lock */
> +		local_irq_save(flags);

Why dropping the local_lock? That approach is nicer to RT builds, and I don't
think it makes a difference from a non-RT perspective.

That said, IIUC, this will eventually disappear with subsequent patches, right?

> +
> +		spin_lock(&pcp->lock);
>  		free_pcppages_bulk(zone, to_drain, pcp, 0);
> -	local_unlock_irqrestore(&pagesets.lock, flags);
> +		spin_unlock(&pcp->lock);
> +
> +		local_irq_restore(flags);
> +	}
>  }
>  #endif
>  

[...]

> @@ -3668,9 +3748,30 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>  			int migratetype,
>  			unsigned int alloc_flags,
>  			struct per_cpu_pages *pcp,
> -			struct list_head *list)
> +			struct list_head *list,
> +			bool locked)
>  {
>  	struct page *page;
> +	unsigned long __maybe_unused UP_flags;
> +
> +	/*
> +	 * spin_trylock is not necessary right now due to due to
> +	 * local_lock_irqsave and is a preparation step for
> +	 * a conversion to local_lock using the trylock to prevent
> +	 * IRQ re-entrancy. If pcp->lock cannot be acquired, the caller
> +	 * uses rmqueue_buddy.
> +	 *
> +	 * TODO: Convert local_lock_irqsave to local_lock. Care
> +	 * 	 is needed as the type of local_lock would need a
> +	 * 	 PREEMPT_RT version due to threaded IRQs.
> +	 */

I missed this in our previous conversation, but as far as RT is concerned
local_lock_irqsave() is the same as local_lock(), see in local_lock_internal.h:

#define __local_lock_irqsave(lock, flags)			\
	do {							\
		typecheck(unsigned long, flags);		\
		flags = 0;					\
		__local_lock(lock);				\
	} while (0)

Something similar happens with spin_lock_irqsave(), see in spinlock_rt.h:

#define spin_lock_irqsave(lock, flags)			 \
	do {						 \
		typecheck(unsigned long, flags);	 \
		flags = 0;				 \
		spin_lock(lock);			 \
	} while (0)

IIUC, RT will run this code paths in threaded IRQ context, where we can think
of RT spinlocks as mutexes (plus some extra priority inheritance magic).

Regards,

-- 
Nicolás Sáenz

