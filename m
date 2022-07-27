Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47501582414
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiG0KVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiG0KUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:20:52 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA66B7DE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:20:49 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 66F50B00264; Wed, 27 Jul 2022 12:20:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1658917247; bh=iiWn5QMcngKlLYivm+GA6lb+fbbu7FPY3WiuGWJO0is=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=g1EsMqUgJ6SkuH7Eop/o2cEKrnNldDGecwPmkcRY0hT7aRg5qpLjl10a8TBQDHOHn
         WKvVxXeJV8Zlyeuxtnta8PfE79flIEwy989p9XS7k2EMr4mShx07z8+Wmg7nhUDbzv
         B/pvzrlumA9m+u2PO+Vg6wJxn2UcQxDWkPRc9p9otVT/mQZT/oMeTAF1g/etzQErGx
         4IdKuqREezU/TuQdcC39B3KANaPyogBEvfbjgmMt48o9wx7+s9oRPbSbd+nZK1uvXa
         CPTLNB9m6yNobbqyWG2ekLUO3ZEKRzo+VvpYELm3zskRz9gxBel8MoCmLPIWCB5PP+
         738RKcnKuUZCA==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 62911B00224;
        Wed, 27 Jul 2022 12:20:47 +0200 (CEST)
Date:   Wed, 27 Jul 2022 12:20:47 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v3 1/3] mm/slub: enable debugging memory wasting of
 kmalloc
In-Reply-To: <20220727071042.8796-2-feng.tang@intel.com>
Message-ID: <alpine.DEB.2.22.394.2207271214570.1205438@gentwo.de>
References: <20220727071042.8796-1-feng.tang@intel.com> <20220727071042.8796-2-feng.tang@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022, Feng Tang wrote:

> @@ -2905,7 +2950,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
>   * already disabled (which is the case for bulk allocation).
>   */
>  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			  unsigned long addr, struct kmem_cache_cpu *c)
> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>  {
>  	void *freelist;
>  	struct slab *slab;
> @@ -3102,7 +3147,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>   * pointer.
>   */
>  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			  unsigned long addr, struct kmem_cache_cpu *c)
> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>  {
>  	void *p;
>
> @@ -3115,7 +3160,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	c = slub_get_cpu_ptr(s->cpu_slab);
>  #endif
>
> -	p = ___slab_alloc(s, gfpflags, node, addr, c);
> +	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
>  #ifdef CONFIG_PREEMPT_COUNT
>  	slub_put_cpu_ptr(s->cpu_slab);

This is modifying and making execution of standard slab functions more
expensive. Could you restrict modifications to the kmalloc subsystem?

kmem_cache_alloc() and friends are not doing any rounding up to power of
two  sizes.

What is happening here is that you pass kmalloc object size info through
the kmem_cache_alloc functions so that the regular allocation functions
debug functionality can then save the kmalloc specific object request
size. This is active even when no debugging options are enabled.

Can you avoid that? Have kmalloc do the object allocation without passing
through the kmalloc request size and then add the original size info
to the debug field later after execution continues in the kmalloc functions?


