Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40FB5AAB4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiIBJ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiIBJ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:26:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F698D33;
        Fri,  2 Sep 2022 02:26:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72D2E20F32;
        Fri,  2 Sep 2022 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662110804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LufUnh2BoglPx9r2swU6gnvTyAVWzguRsB5RoAkwcZE=;
        b=0JocWmjAr6RkBtXUiki0tX1cN0VErKiZW6QOYHVNz7Zyp7tL4NEoJCL6ZNmJnNW+XcOVLr
        6mY8LBVCVbVlkJRWRv4XHv78FLp6uUboNp7pbAfwhbyeahvkWqpFOyapwHsMp3eKfIvZr4
        KDwxRWzuHgrzheVaeENODh3aiUtEF2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662110804;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LufUnh2BoglPx9r2swU6gnvTyAVWzguRsB5RoAkwcZE=;
        b=EScdHJTfo2v9PQoZmF8fXzarENGiiWhElbkPg/sBeemUieAbhCvT25HZRV+Dgz8cPygXRx
        TcY1rZB7HYRq1BDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F34E13328;
        Fri,  2 Sep 2022 09:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XsqSElTMEWPmEgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 02 Sep 2022 09:26:44 +0000
Message-ID: <e84c90f2-d76f-83d4-d40b-403f894eda33@suse.cz>
Date:   Fri, 2 Sep 2022 11:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 02/18] mm/sl[au]b: rearrange struct slab fields to
 allow larger rcu_head
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-3-joel@joelfernandes.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220901221720.1105021-3-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 00:17, Joel Fernandes (Google) wrote:
> From: Vlastimil Babka <vbabka@suse.cz>
> 
> Joel reports [1] that increasing the rcu_head size for debugging
> purposes used to work before struct slab was split from struct page, but
> now runs into the various SLAB_MATCH() sanity checks of the layout.
> 
> This is because the rcu_head in struct page is in union with large
> sub-structures and has space to grow without exceeding their size, while
> in struct slab (for SLAB and SLUB) it's in union only with a list_head.
> 
> On closer inspection (and after the previous patch) we can put all
> fields except slab_cache to a union with rcu_head, as slab_cache is
> sufficient for the rcu freeing callbacks to work and the rest can be
> overwritten by rcu_head without causing issues.
> 
> This is only somewhat complicated by the need to keep SLUB's
> freelist+counters aligned for cmpxchg_double. As a result the fields
> need to be reordered so that slab_cache is first (after page flags) and
> the union with rcu_head follows. For consistency, do that for SLAB as
> well, although not necessary there.
> 
> As a result, the rcu_head field in struct page and struct slab is no
> longer at the same offset, but that doesn't matter as there is no
> casting that would rely on that in the slab freeing callbacks, so we can
> just drop the respective SLAB_MATCH() check.
> 
> Also we need to update the SLAB_MATCH() for compound_head to reflect the
> new ordering.
> 
> While at it, also add a static_assert to check the alignment needed for
> cmpxchg_double so mistakes are found sooner than a runtime GPF.
> 
> [1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/
> 
> Reported-by: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

I've added patches 01 and 02 to slab tree for -next exposure before Joel's
full series posting, but it should be also ok if rcu tree carries them with
the whole patchset. I can then drop them from slab tree (there are no
dependencies with other stuff there) so we don't introduce duplicite commits
needlessly, just give me a heads up.

> ---
>  mm/slab.h | 54 ++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 4ec82bec15ec..2c248864ea91 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -11,37 +11,43 @@ struct slab {
>  
>  #if defined(CONFIG_SLAB)
>  
> +	struct kmem_cache *slab_cache;
>  	union {
> -		struct list_head slab_list;
> +		struct {
> +			struct list_head slab_list;
> +			void *freelist;	/* array of free object indexes */
> +			void *s_mem;	/* first object */
> +		};
>  		struct rcu_head rcu_head;
>  	};
> -	struct kmem_cache *slab_cache;
> -	void *freelist;	/* array of free object indexes */
> -	void *s_mem;	/* first object */
>  	unsigned int active;
>  
>  #elif defined(CONFIG_SLUB)
>  
> -	union {
> -		struct list_head slab_list;
> -		struct rcu_head rcu_head;
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -		struct {
> -			struct slab *next;
> -			int slabs;	/* Nr of slabs left */
> -		};
> -#endif
> -	};
>  	struct kmem_cache *slab_cache;
> -	/* Double-word boundary */
> -	void *freelist;		/* first free object */
>  	union {
> -		unsigned long counters;
>  		struct {
> -			unsigned inuse:16;
> -			unsigned objects:15;
> -			unsigned frozen:1;
> +			union {
> +				struct list_head slab_list;
> +#ifdef CONFIG_SLUB_CPU_PARTIAL
> +				struct {
> +					struct slab *next;
> +					int slabs;	/* Nr of slabs left */
> +				};
> +#endif
> +			};
> +			/* Double-word boundary */
> +			void *freelist;		/* first free object */
> +			union {
> +				unsigned long counters;
> +				struct {
> +					unsigned inuse:16;
> +					unsigned objects:15;
> +					unsigned frozen:1;
> +				};
> +			};
>  		};
> +		struct rcu_head rcu_head;
>  	};
>  	unsigned int __unused;
>  
> @@ -66,9 +72,10 @@ struct slab {
>  #define SLAB_MATCH(pg, sl)						\
>  	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
>  SLAB_MATCH(flags, __page_flags);
> -SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
>  #ifndef CONFIG_SLOB
> -SLAB_MATCH(rcu_head, rcu_head);
> +SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
> +#else
> +SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
>  #endif
>  SLAB_MATCH(_refcount, __page_refcount);
>  #ifdef CONFIG_MEMCG
> @@ -76,6 +83,9 @@ SLAB_MATCH(memcg_data, memcg_data);
>  #endif
>  #undef SLAB_MATCH
>  static_assert(sizeof(struct slab) <= sizeof(struct page));
> +#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && defined(CONFIG_SLUB)
> +static_assert(IS_ALIGNED(offsetof(struct slab, freelist), 16));
> +#endif
>  
>  /**
>   * folio_slab - Converts from folio to slab.

