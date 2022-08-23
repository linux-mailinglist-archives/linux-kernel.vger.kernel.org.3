Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659E959EB77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiHWSwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiHWSvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:51:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B763D11C3C5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:15:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2832336D9;
        Tue, 23 Aug 2022 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661274943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEBpfl3pgtZLUcRnNN7xouCt+plGofu/FkYkOP6oe74=;
        b=p9IJlS3zT1E+49k0he/IUMtkrf5PaPs/2CtKcr7/jCHdwJmnJzbNXPR72OcSNZ9FkhBGiZ
        9cxsQKq8zr5M8z19dqNKTRxczJ2JIrHp2VMcnd0a/PU+hWksx/JKClq6zTPwdU7gjbhDkd
        PiGkU3rwbWs21JNBwhIEnt6OfVfSFYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661274943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEBpfl3pgtZLUcRnNN7xouCt+plGofu/FkYkOP6oe74=;
        b=ufVOXxEjYVZaxVi7jU3dSTd2kMdZQnX4kFBw9I5u+qbypfctDP1or1FUc0fpKduFwbIp2R
        msnbC4hiSEbIxSAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A22B13AB7;
        Tue, 23 Aug 2022 17:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8YB3ID8LBWPxRgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 Aug 2022 17:15:43 +0000
Message-ID: <ffb4012b-e038-a92e-c84c-bb1d061fe29f@suse.cz>
Date:   Tue, 23 Aug 2022 19:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-2-bigeasy@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220817162703.728679-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 18:26, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The slub code already has a few helpers depending on PREEMPT_RT. Add a few
> more and get rid of the CONFIG_PREEMPT_RT conditionals all over the place.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: linux-mm@kvack.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  mm/slub.c | 66 +++++++++++++++++++++++++------------------------------
>  1 file changed, 30 insertions(+), 36 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f52..5f7c5b5bd49f9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -100,9 +100,11 @@
>   *   except the stat counters. This is a percpu structure manipulated only by
>   *   the local cpu, so the lock protects against being preempted or interrupted
>   *   by an irq. Fast path operations rely on lockless operations instead.
> - *   On PREEMPT_RT, the local lock does not actually disable irqs (and thus
> - *   prevent the lockless operations), so fastpath operations also need to take
> - *   the lock and are no longer lockless.
> + *
> + *   On PREEMPT_RT, the local lock neither disables interrupts nor preemption
> + *   which means the lockless fastpath cannot be used as it might interfere with
> + *   an in-progress slow path operations. In this case the local lock is always
> + *   taken but it still utilizes the freelist for the common operations.
>   *
>   *   lockless fastpaths
>   *
> @@ -163,8 +165,11 @@
>   * function call even on !PREEMPT_RT, use inline preempt_disable() there.
>   */
>  #ifndef CONFIG_PREEMPT_RT
> -#define slub_get_cpu_ptr(var)	get_cpu_ptr(var)
> -#define slub_put_cpu_ptr(var)	put_cpu_ptr(var)
> +#define slub_get_cpu_ptr(var)		get_cpu_ptr(var)
> +#define slub_put_cpu_ptr(var)		put_cpu_ptr(var)
> +#define use_lockless_fast_path()	(true)

> +#define slub_local_irq_save(flags)	local_irq_save(flags)
> +#define slub_local_irq_restore(flags)	local_irq_restore(flags)

Note these won't be neccessary anymore after
https://lore.kernel.org/linux-mm/20220823170400.26546-6-vbabka@suse.cz/T/#u

>  #else
>  #define slub_get_cpu_ptr(var)		\
>  ({					\
> @@ -176,6 +181,9 @@ do {					\
>  	(void)(var);			\
>  	migrate_enable();		\
>  } while (0)
> +#define use_lockless_fast_path()	(false)
> +#define slub_local_irq_save(flags)	do { } while (0)
> +#define slub_local_irq_restore(flags)	do { } while (0)
>  #endif
>  
>  #ifdef CONFIG_SLUB_DEBUG
> @@ -460,16 +468,14 @@ static __always_inline void __slab_unlock(struct slab *slab)
>  
>  static __always_inline void slab_lock(struct slab *slab, unsigned long *flags)
>  {
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		local_irq_save(*flags);
> +	slub_local_irq_save(*flags);
>  	__slab_lock(slab);
>  }
>  
>  static __always_inline void slab_unlock(struct slab *slab, unsigned long *flags)
>  {
>  	__slab_unlock(slab);
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		local_irq_restore(*flags);
> +	slub_local_irq_restore(*flags);
>  }

Ditto.

>  /*
> @@ -482,7 +488,7 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab
>  		void *freelist_new, unsigned long counters_new,
>  		const char *n)
>  {
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +	if (use_lockless_fast_path())
>  		lockdep_assert_irqs_disabled();

This test would stay after the patch I referenced above. But while this
change will keep testing the technically correct thing, the name would be
IMHO misleading here, as this is semantically not about the lockless fast
path, but whether we need to have irqs disabled to avoid a deadlock due to
irq incoming when we hold the bit_spin_lock() and its handler trying to
acquire it as well.
