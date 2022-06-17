Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4383454F245
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380678AbiFQHzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379797AbiFQHzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:55:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4000942EFE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:55:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA3CA1FD8E;
        Fri, 17 Jun 2022 07:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655452537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8399TE5UWPTJshsgNjQyi05ualfu0JSvUA5o+5dodo=;
        b=YhAaqPEmN8n85x5VzOQsIZO2VOldEli/7FcoIwOZqIqmhGIq7IPCQxhQu2yd97txGaqUH6
        P0nHPwylWBSMKLDat0uHIE+/4oJr3KLP3VSmiYeLWgd28q/u9TNVrIB4wQjFxSHltkPOLs
        /antEabR+8LN/u1/l/rj1xQWWExV8jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655452537;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8399TE5UWPTJshsgNjQyi05ualfu0JSvUA5o+5dodo=;
        b=9vX/bCMnYg+czHiISNbVsUow0+sQpofd2GmtiCLWyel7gw82WOJlgDyOJnFkPkAH9jXGs1
        umTJMRTR8OjtRBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE8FA1348E;
        Fri, 17 Jun 2022 07:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zAC3LXkzrGKhBwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 17 Jun 2022 07:55:37 +0000
Message-ID: <81d2df40-c955-b88d-e29f-7f09796f5deb@suse.cz>
Date:   Fri, 17 Jun 2022 09:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
 <20220613125622.18628-8-mgorman@techsingularity.net>
 <CGME20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a@eucas1p1.samsung.com>
 <e1c73640-3f29-bf57-b98d-84b1800cf4e3@samsung.com>
 <20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org>
 <Yqqd5nHeAT77C4D0@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yqqd5nHeAT77C4D0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 05:05, Yu Zhao wrote:
> On Wed, Jun 15, 2022 at 04:04:46PM -0700, Andrew Morton wrote:
> 
> While we are at it, please consider this cleanup:

I suspect Mel had further plans for the API beynd this series.

...

>  #define pcp_spin_trylock_irqsave(ptr, flags)				\
> -	pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, ptr, flags)
> -
> -#define pcp_spin_unlock(ptr)						\
> -	pcpu_spin_unlock(lock, ptr)
> +({									\
> +	struct per_cpu_pages *_ret;					\
> +	pcpu_task_pin();						\
> +	_ret = this_cpu_ptr(ptr);					\
> +	if (!spin_trylock_irqsave(&_ret->lock, flags))			\

Also missing the unpin?

> +		_ret = NULL;						\
> +	_ret;								\
> +})
>  
>  #define pcp_spin_unlock_irqrestore(ptr, flags)				\
> -	pcpu_spin_unlock_irqrestore(lock, ptr, flags)
> +({									\
> +	spin_unlock_irqrestore(&ptr->lock, flags);			\
> +	pcpu_task_unpin();						\
> +})
> +
>  #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
>  DEFINE_PER_CPU(int, numa_node);
>  EXPORT_PER_CPU_SYMBOL(numa_node);
> @@ -3488,7 +3458,7 @@ void free_unref_page(struct page *page, unsigned int order)
>  
>  	zone = page_zone(page);
>  	pcp_trylock_prepare(UP_flags);
> -	pcp = pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone->per_cpu_pageset, flags);
> +	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
>  	if (pcp) {
>  		free_unref_page_commit(pcp, zone, page, migratetype, order);
>  		pcp_spin_unlock_irqrestore(pcp, flags);

