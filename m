Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D454C5A1194
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbiHYNLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHYNLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:11:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E904C4A82F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:11:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8770D344C1;
        Thu, 25 Aug 2022 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661433092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCAuc8FWvjqnR5fEuXkcUAappoIRH5GZFA+NXq08iEA=;
        b=c3C6DntEiZuf/RhVUCjGM0P4qHgRiY+H6borHlSr1r3fL4AEGrWWK650Oa5cd7bt+AE5qD
        G8mzNhMTck18cTvm60VNktqL5VV7VUd0lRxJr8pCooPHkhmDMEf4HJmRFMlM9Mly5Brqdz
        PZ61nkD0g95ejPx9117DwGYME1Soa44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661433092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCAuc8FWvjqnR5fEuXkcUAappoIRH5GZFA+NXq08iEA=;
        b=KgsbqGNx93obxPdb3R+cJBZb+xAPMTkNVze7LKBsfFoK4dzCkUBsqFHozc61CQ03wma+YS
        iszqV7uzE75akCDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B4AB13A8E;
        Thu, 25 Aug 2022 13:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fx65EQR1B2PxKQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 Aug 2022 13:11:32 +0000
Message-ID: <eff58088-e291-6960-cbfd-b6cc428f5f06@suse.cz>
Date:   Thu, 25 Aug 2022 15:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] mm/slub: fix comments about fastpath limitation on
 PREEMPT_RT
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220825015722.1697209-1-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220825015722.1697209-1-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 03:57, Hyeonggon Yoo wrote:
> With PREEMPT_RT disabling interrupt is unnecessary as there is
> no user of slab in hardirq context on PREEMPT_RT.
> 
> The limitation of lockless fastpath on PREEMPT_RT comes from the fact
> that local_lock does not disable preemption on PREEMPT_RT.
> 
> Fix comments accordingly.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Just FTR, as "slub: Make PREEMPT_RT support less convoluted" patch dealt
with these comments already, there's now nothing left to apply from below.

> ---
>  mm/slub.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 30c2ee9e8a29..aa42ac6013b8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -100,7 +100,7 @@
>   *   except the stat counters. This is a percpu structure manipulated only by
>   *   the local cpu, so the lock protects against being preempted or interrupted
>   *   by an irq. Fast path operations rely on lockless operations instead.
> - *   On PREEMPT_RT, the local lock does not actually disable irqs (and thus
> + *   On PREEMPT_RT, the local lock does not actually disable preemption (and thus
>   *   prevent the lockless operations), so fastpath operations also need to take
>   *   the lock and are no longer lockless.
>   *
> @@ -3185,10 +3185,12 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>  	slab = c->slab;
>  	/*
>  	 * We cannot use the lockless fastpath on PREEMPT_RT because if a
> -	 * slowpath has taken the local_lock_irqsave(), it is not protected
> -	 * against a fast path operation in an irq handler. So we need to take
> -	 * the slow path which uses local_lock. It is still relatively fast if
> -	 * there is a suitable cpu freelist.
> +	 * slowpath has taken the local_lock which does not disable preemption
> +	 * on PREEMPT_RT, it is not protected against a fast path operation in
> +	 * another thread that does not take the local_lock.
> +	 *
> +	 * So we need to take the slow path which uses local_lock. It is still
> +	 * relatively fast if there is a suitable cpu freelist.
>  	 */
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
>  	    unlikely(!object || !slab || !node_match(slab, node))) {
> @@ -3457,10 +3459,13 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  #else /* CONFIG_PREEMPT_RT */
>  		/*
>  		 * We cannot use the lockless fastpath on PREEMPT_RT because if
> -		 * a slowpath has taken the local_lock_irqsave(), it is not
> -		 * protected against a fast path operation in an irq handler. So
> -		 * we need to take the local_lock. We shouldn't simply defer to
> -		 * __slab_free() as that wouldn't use the cpu freelist at all.
> +		 * a slowpath has taken the local_lock which does not disable
> +		 * preemption on PREEMPT_RT, it is not protected against a
> +		 * fast path operation in another thread that does not take
> +		 * the local_lock.
> +		 *
> +		 * So we need to take the local_lock. We shouldn't simply defer
> +		 * to __slab_free() as that wouldn't use the cpu freelist at all.
>  		 */
>  		void **freelist;
>  

