Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0BC58FA18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiHKJb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHKJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:31:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE190194
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:31:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 35F335C70F;
        Thu, 11 Aug 2022 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660210313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rF+k9eDGRl2XR235Pzqvbau2Y08myECs6AhHVzgotHk=;
        b=pq4UUdvCLhg6OSuHcnu72zbjUvF/b4QH0OAx+OVxfk/M5Rwn2gmm9V1IxPqtFEOW71aU7W
        MTs9ZmmcZQAqBDsC1qLOovfsLWngc3opHyq69o6a+R5kcz1B2O9i5VlKWkFJl8N1utFaHJ
        EW7u5H/stPeGYRVN0vrKMRW5EUJlm6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660210313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rF+k9eDGRl2XR235Pzqvbau2Y08myECs6AhHVzgotHk=;
        b=egvmLY85DU+veppAAo4BvoyC0Xiw+Vi3FIj+oi/gB1eCRAMyEse508mcsX4OCGpKP3Ohp1
        fa21THKDPRn1kZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F01821342A;
        Thu, 11 Aug 2022 09:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /f3ZOYjM9GJacAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 11 Aug 2022 09:31:52 +0000
Message-ID: <d3cd0f34-b30b-9a1d-8715-439ffb818539@suse.cz>
Date:   Thu, 11 Aug 2022 11:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
From:   vbabka@suse.cz
Subject: Re: [PATCH v2] Introduce sysfs interface to disable kfence for
 selected slabs.
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, glider@google.com,
        elver@google.com, dvyukov@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
References: <20220811085938.2506536-1-imran.f.khan@oracle.com>
In-Reply-To: <20220811085938.2506536-1-imran.f.khan@oracle.com>
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

On 8/11/22 10:59, Imran Khan wrote:
> By default kfence allocation can happen for any slab object, whose size
> is up to PAGE_SIZE, as long as that allocation is the first allocation
> after expiration of kfence sample interval. But in certain debugging
> scenarios we may be interested in debugging corruptions involving
> some specific slub objects like dentry or ext4_* etc. In such cases
> limiting kfence for allocations involving only specific slub objects
> will increase the probablity of catching the issue since kfence pool
> will not be consumed by other slab objects.

So you want to enable specific caches for kfence.

> This patch introduces a sysfs interface '/sys/kernel/slab/<name>/skip_kfence'
> to disable kfence for specific slabs. Having the interface work in this
> way does not impact current/default behavior of kfence and allows us to
> use kfence for specific slabs (when needed) as well. The decision to
> skip/use kfence is taken depending on whether kmem_cache.flags has
> (newly introduced) SLAB_SKIP_KFENCE flag set or not.

But this seems everything is still enabled and you can selectively disable.
Isn't that rather impractical?

How about making this cache flag rather denote that KFENCE is enabled (not
skipped), set it by default only for for caches with size <= 1024, then you
can drop the size check in __kfence_alloc and rely only on the flag? And if
you need, you can also enable a cache with size > 1024 with the sysfs
interface, to override the limit, which isn't possible now.
(I don't think changing the limit to always act on s->object_size instead of
e.g. size passed to kmalloc() that it can pick up now, will change anything
in practice)
Then you can also have a kernel boot param that tells kfence to set the flag
on no cache at all, and you can easily enable just the specific caches you
want. Or make a parameter that lets you override the 1024 size limit
globally, and if you set it to 0, it means no cache is enabled for kfence?

> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> ---
> 
> Changes since v1:
>  - Remove RFC tag
> 
>  include/linux/slab.h |  6 ++++++
>  mm/kfence/core.c     |  7 +++++++
>  mm/slub.c            | 27 +++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0fefdf528e0d..947d912fd08c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -119,6 +119,12 @@
>   */
>  #define SLAB_NO_USER_FLAGS	((slab_flags_t __force)0x10000000U)
>  
> +#ifdef CONFIG_KFENCE
> +#define SLAB_SKIP_KFENCE            ((slab_flags_t __force)0x20000000U)
> +#else
> +#define SLAB_SKIP_KFENCE            0
> +#endif
> +
>  /* The following flags affect the page allocator grouping pages by mobility */
>  /* Objects are reclaimable */
>  #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index c252081b11df..8c08ae2101d7 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -1003,6 +1003,13 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>  		return NULL;
>  	}
>  
> +	/*
> +	 * Skip allocations for this slab, if KFENCE has been disabled for
> +	 * this slab.
> +	 */
> +	if (s->flags & SLAB_SKIP_KFENCE)
> +		return NULL;
> +
>  	if (atomic_inc_return(&kfence_allocation_gate) > 1)
>  		return NULL;
>  #ifdef CONFIG_KFENCE_STATIC_KEYS
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..ee8b48327536 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5745,6 +5745,30 @@ STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
>  STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
>  #endif	/* CONFIG_SLUB_STATS */
>  
> +#ifdef CONFIG_KFENCE
> +static ssize_t skip_kfence_show(struct kmem_cache *s, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_SKIP_KFENCE));
> +}
> +
> +static ssize_t skip_kfence_store(struct kmem_cache *s,
> +			const char *buf, size_t length)
> +{
> +	int ret = length;
> +
> +	if (buf[0] == '0')
> +		s->flags &= ~SLAB_SKIP_KFENCE;
> +	else if (buf[0] == '1')
> +		s->flags |= SLAB_SKIP_KFENCE;
> +	else
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +SLAB_ATTR(skip_kfence);
> +
> +#endif
> +
>  static struct attribute *slab_attrs[] = {
>  	&slab_size_attr.attr,
>  	&object_size_attr.attr,
> @@ -5812,6 +5836,9 @@ static struct attribute *slab_attrs[] = {
>  	&failslab_attr.attr,
>  #endif
>  	&usersize_attr.attr,
> +#ifdef CONFIG_KFENCE
> +	&skip_kfence_attr.attr,
> +#endif
>  
>  	NULL
>  };
> 
> base-commit: 40d43a7507e1547dd45cb02af2e40d897c591870

