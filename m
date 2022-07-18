Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00B3577906
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 02:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiGRAYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 20:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGRAY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 20:24:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61505E0ED
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 17:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A722B80EBC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA36C3411E;
        Mon, 18 Jul 2022 00:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658103865;
        bh=3vdAZzQqrm/X74AkkzCX4tDp+nGAuIYBaPfAzyKr/TQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CnrTcurfwtTpgPEYViVVNMAZirrK1HG84AS9X3dOvk8lEjV6XnGDRR/n5gMcmAFKH
         JQRkAni9WXeuVl8xOnXyMw3RDvqqnBucx9TherYeht/WNIWi++JKGQJuETiqHXDBgW
         Ib5kIvmO4pAvJVZtj3j/tcsoOCvVfnvwImGPgF0s=
Date:   Sun, 17 Jul 2022 17:24:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     tglx@linutronix.de, hch@lst.de, keescook@chromium.org,
        longman@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/debugobjects: Fix stat count and optimize
 debug_objects_mem_init.
Message-Id: <20220717172424.4d9689133fd688fb57308e1c@linux-foundation.org>
In-Reply-To: <20220611130634.99741-1-wuchi.zero@gmail.com>
References: <20220611130634.99741-1-wuchi.zero@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2022 21:06:34 +0800 wuchi <wuchi.zero@gmail.com> wrote:

> 1. Var debug_objects_allocated tracks valid kmem_cache_alloc calls, so
> track it in debug_objects_replace_static_objects. Do similar things in
> object_cpu_offline.
> 
> 2. In debug_objects_mem_init, there is no need to call function
> cpuhp_setup_state_nocalls when debug_objects_enabled = 0 (out of memory).
> 

Could we please have some review input here?

> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -437,6 +437,7 @@ static int object_cpu_offline(unsigned int cpu)
>  	struct debug_percpu_free *percpu_pool;
>  	struct hlist_node *tmp;
>  	struct debug_obj *obj;
> +	unsigned long flags;
>  
>  	/* Remote access is safe as the CPU is dead already */
>  	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
> @@ -444,6 +445,12 @@ static int object_cpu_offline(unsigned int cpu)
>  		hlist_del(&obj->node);
>  		kmem_cache_free(obj_cache, obj);
>  	}
> +
> +	raw_spin_lock_irqsave(&pool_lock, flags);
> +	obj_pool_used -= percpu_pool->obj_free;
> +	debug_objects_freed += percpu_pool->obj_free;
> +	raw_spin_unlock_irqrestore(&pool_lock, flags);
> +
>  	percpu_pool->obj_free = 0;
>  
>  	return 0;
> @@ -1318,6 +1325,8 @@ static int __init debug_objects_replace_static_objects(void)
>  		hlist_add_head(&obj->node, &objects);
>  	}
>  
> +	debug_objects_allocated += i;
> +
>  	/*
>  	 * debug_objects_mem_init() is now called early that only one CPU is up
>  	 * and interrupts have been disabled, so it is safe to replace the
> @@ -1386,6 +1395,7 @@ void __init debug_objects_mem_init(void)
>  		debug_objects_enabled = 0;
>  		kmem_cache_destroy(obj_cache);
>  		pr_warn("out of memory.\n");
> +		return;
>  	} else
>  		debug_objects_selftest();
>  

