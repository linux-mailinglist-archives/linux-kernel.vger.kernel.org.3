Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6297859F24C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiHXD7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiHXD7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:59:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865779080A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:59:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so296354pjj.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=X9PVqQRV1oey29lEhQt0M3Wu0nCECGn9M+/HAl4AZg8=;
        b=TEzRBl+gwmfPSjPUjwjqI+tTB17Ls0HzHO/sK07YnOBGaCs7TDRxP/m2i/LWYMErFF
         SMDrBqW2lHXwnQ10ecrLM7/bsTRPNtQ++4QoevQUI3p3idMbfVyl49XUFmG9NtcGM4EI
         51AIcBwIjIN6rpISfw16ekqBAeWpbej4fHy0aVGLk3zvnwQyWpuD9YE3F9azEMU2Xx5o
         mUuQ0w5OYi/RW3yELNjZE5oFUW+4Vn455Wsn/+IPdb+QoGrNufRxXmqbYlIuX2lITOl0
         vUs1MNw6bGFDZ+5gsyZv9ArmR8XIEALTDG9fHWZzeCADMU6OVxtYyz4nNaad6sbf76SI
         b/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=X9PVqQRV1oey29lEhQt0M3Wu0nCECGn9M+/HAl4AZg8=;
        b=CHqKdVff2h560kHKKMehzd0hFS51ALVsnh6dmcaChOgoPcJFUMI86REk0DZV5mWW9E
         GW3OMmVH0yoZiCNk3x9+o34GCK2SuDD5un1qh4YvN1BdSCgASEYa/OL0v504NLqfmeRI
         t6RNzpzGcAFKQypX4baeqYHXSVKNETJ9kpso2+zajOocIjRWZOZi2OU3gpslDisBRZLm
         8paw6TbRS3IYhX0cY0dNgIMhHB6yVxJOHLLoaMP+N18FmUf9f+xoGklvoSgwsnnlyxMb
         2QhjaOWk/810ny7WoRUUc07Fhg83F5YuSlh+vVFksAGN9hHPqHNoto498TcIlF7sR39P
         4DzQ==
X-Gm-Message-State: ACgBeo2xW640FmayeTSNbDkR1ENv5LDxiw7Bllf52KjwCsS06r8UCYCH
        b6mTxmEbWMSbge6Whd+uEVw=
X-Google-Smtp-Source: AA6agR6po5+Tc9vgGXdCNoiQTpjDscRWui1PdqlHQpd2KAk9yyHwhyyjO0H9QfFHBw4zh9eJMCHtvA==
X-Received: by 2002:a17:902:f551:b0:16e:d000:543b with SMTP id h17-20020a170902f55100b0016ed000543bmr26412299plf.22.1661313547913;
        Tue, 23 Aug 2022 20:59:07 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id j9-20020a63ec09000000b00427564b6b57sm10060417pgh.7.2022.08.23.20.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 20:59:05 -0700 (PDT)
Date:   Wed, 24 Aug 2022 12:58:59 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/17] common kmalloc v4
Message-ID: <YwWiAwNdG6btZ+z+@hyeyoo>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
 <9e8a7927-a47d-a70d-ab35-9c5247af5d13@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e8a7927-a47d-a70d-ab35-9c5247af5d13@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 05:16:17PM +0200, Vlastimil Babka wrote:
> On 8/17/22 12:18, Hyeonggon Yoo wrote:
> > v3: https://lore.kernel.org/lkml/20220712133946.307181-1-42.hyeyoo@gmail.com/
> > 
> > Hello, this is common kmalloc v4.
> > Please review and consider applying.
> 
> Thanks, added to slab.git for-6.1/common_kmalloc and merged to for-next!

Thanks!

But please see these:
	https://lore.kernel.org/linux-mm/YwWfr8ATVx2Ag94z@hyeyoo/
	https://lore.kernel.org/lkml/20220824134530.1b10e768@canb.auug.org.au/T/#u

Fixed those, So please pull this:
	https://github.com/hygoni/linux.git slab-common-v4r1

git range-diff	for-6.1/common_kmalloc~17...for-6.1/common_kmalloc \
		slab-common-v4r1~17...slab-common-v4r1:

 1:  0276f0da97e3 =  1:  0276f0da97e3 mm/slab: move NUMA-related code to __do_cache_alloc()
 2:  d5ea00e8d8c9 =  2:  d5ea00e8d8c9 mm/slab: cleanup slab_alloc() and slab_alloc_node()
 3:  48c55c42e6b8 =  3:  48c55c42e6b8 mm/slab_common: remove CONFIG_NUMA ifdefs for common kmalloc functions
 4:  cd8523b488ec =  4:  cd8523b488ec mm/slab_common: cleanup kmalloc_track_caller()
 5:  0b92d497e03a =  5:  0b92d497e03a mm/sl[au]b: factor out __do_kmalloc_node()
 6:  d43649c0f472 =  6:  d43649c0f472 mm/slab_common: fold kmalloc_order_trace() into kmalloc_large()
 7:  cd6d756d6118 =  7:  cd6d756d6118 mm/slub: move kmalloc_large_node() to slab_common.c
 8:  fe8f3819416e !  8:  ec277200c5dd mm/slab_common: kmalloc_node: pass large requests to page allocator
    @@ mm/slab_common.c: void *kmalloc_large(size_t size, gfp_t flags)
      EXPORT_SYMBOL(kmalloc_large);

     -void *kmalloc_large_node(size_t size, gfp_t flags, int node)
    -+void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    ++static void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
      {
      	struct page *page;
      	void *ptr = NULL;
 9:  cc40615623ed !  9:  3d1d49576f4a mm/slab_common: cleanup kmalloc_large()
    @@ mm/slab_common.c: gfp_t kmalloc_fix_flags(gfp_t flags)
     -}
     -EXPORT_SYMBOL(kmalloc_large);

    - void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    + static void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
      {
    -@@ mm/slab_common.c: void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    +@@ mm/slab_common.c: static void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
      	void *ptr = NULL;
      	unsigned int order = get_order(size);

    @@ mm/slab_common.c: void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int
      	flags |= __GFP_COMP;
      	page = alloc_pages_node(node, flags, order);
      	if (page) {
    -@@ mm/slab_common.c: void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    +@@ mm/slab_common.c: static void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
      	return ptr;
      }

10:  e14d748cf9ad = 10:  d6d55b2e745a mm/slab: kmalloc: pass requests larger than order-1 page to page allocator
11:  84000279b448 = 11:  28c1aabc9f73 mm/sl[au]b: introduce common alloc/free functions without tracepoint
12:  79c7527b9805 ! 12:  7fefa4235ba9 mm/sl[au]b: generalize kmalloc subsystem
    @@ mm/slab_common.c: void free_large_kmalloc(struct folio *folio, void *object)
     +
     +/**
     + * kfree - free previously allocated memory
    -+ * @objp: pointer returned by kmalloc.
    ++ * @object: pointer returned by kmalloc.
     + *
    -+ * If @objp is NULL, no operation is performed.
    ++ * If @object is NULL, no operation is performed.
     + *
     + * Don't free memory not originally allocated by kmalloc()
     + * or you will run into trouble.
    @@ mm/slab_common.c: void free_large_kmalloc(struct folio *folio, void *object)
     +
     +/**
     + * __ksize -- Uninstrumented ksize.
    -+ * @objp: pointer to the object
    ++ * @object: pointer to the object
     + *
     + * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
     + * safety checks as ksize() with KASAN instrumentation enabled.
     + *
    -+ * Return: size of the actual memory used by @objp in bytes
    ++ * Return: size of the actual memory used by @object in bytes
     + */
     +size_t __ksize(const void *object)
     +{
    @@ mm/slab_common.c: gfp_t kmalloc_fix_flags(gfp_t flags)
       * know the allocation order to free the pages properly in kfree.
       */

    --void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    -+void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
    +-static void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    ++static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
      {
      	struct page *page;
      	void *ptr = NULL;
    -@@ mm/slab_common.c: void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    +@@ mm/slab_common.c: static void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)

      void *kmalloc_large(size_t size, gfp_t flags)
      {
13:  31be83f97c43 = 13:  446064fdf403 mm/sl[au]b: cleanup kmem_cache_alloc[_node]_trace()
14:  583b9ef311da = 14:  c923544d6d61 mm/slab_common: unify NUMA and UMA version of tracepoints
15:  d0b3552d07e0 = 15:  72633319472e mm/slab_common: drop kmem_alloc & avoid dereferencing fields when not using
16:  0db36c104255 ! 16:  c9b5ded32cc6 mm/slab_common: move declaration of __ksize() to mm/slab.h
    @@ mm/slab_common.c: void kfree(const void *object)

     -/**
     - * __ksize -- Uninstrumented ksize.
    -- * @objp: pointer to the object
    +- * @object: pointer to the object
     - *
     - * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
     - * safety checks as ksize() with KASAN instrumentation enabled.
     - *
    -- * Return: size of the actual memory used by @objp in bytes
    +- * Return: size of the actual memory used by @object in bytes
     - */
     +/* Uninstrumented ksize. Only called by KASAN. */
      size_t __ksize(const void *object)
17:  b261334803b4 = 17:  0248c8a1af52 mm/sl[au]b: check if large object is valid in __ksize()

-- 
Thanks,
Hyeonggon
