Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24A3596CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiHQKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHQKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:18:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4B652E70
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:18:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y141so11670078pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=I0eCQ2mpVVm6GHUma0l6Mck2FZ9dY4Gl7iYmE+bcY5s=;
        b=ko+aCxgRK7OSkO25aieooPtPVWw3mYn53/Ef2YGBmkWpqbAELM1G4F8g1w3cpr8TmW
         ARCnUjHNGfeRia74ljPlm75sJDRiKRp6aVB7DsYbwXtIkyAUBOKI9NG9qOmiRJhO5uZE
         LeUgI2O+mH2W6ohpKkU+d7FfNxtyEIU/hmDkjUAur83uakeaq3fleZXEDQfmmSvC3JYr
         mB1eafn1JL6fSPUUongpmFCRRejY3AmSiFLjhP/hDUSifqqe9jdgrXimSnRIYsmzOiuc
         KFti8YppF4T8BonTLUbqme4ANZKUtaOJfEEFsgv4EleNBcv3WwyLwhC1xzzvAclq3sKN
         AiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=I0eCQ2mpVVm6GHUma0l6Mck2FZ9dY4Gl7iYmE+bcY5s=;
        b=adg6q/dOvEHWuak8ET8qELmG2YHAHdLtqYsAzAtrVQLnJsVaLp4DL1Yggz+AuFg2VP
         bDNWUdp+Zztvrz8PHtMfUiBpjQNGTOMuJMU28vLSm19WTDY3GS8G34CoBgNo+8KCGd6o
         O4IkJDTnCW15hapeNxeiOXRJ2ME14waCMLuKPGwZ4PpjG+0a0I4z+OtbusrehflnW1Hq
         yZH0V5ihkxsVfZRcqvJBkOyR6oU512DwP1YEStyzrSzfUxiu+9qic0d41D3GPRC6t+zr
         ywkclc5q6dGomrA0Hn99RNONPWvFlBJoDj/JLYt3FeezTJoTvzuANGeVLwEkap4s8rTj
         Uuxw==
X-Gm-Message-State: ACgBeo1PqdfgKvHDZq5SeAb7SJoR6fFWT4AAwLINgdEve3WHexompYbi
        ImftvKX58sRXDcFDBqhUm+8=
X-Google-Smtp-Source: AA6agR5fAqv34YwfTXEzlz9iDU+A4lpEhip4ZtceAdd9xnCzfaJpFcDeaFmca1VQLd4V/rWDhKOhag==
X-Received: by 2002:a63:81c3:0:b0:41e:17df:aed0 with SMTP id t186-20020a6381c3000000b0041e17dfaed0mr21445570pgd.395.1660731525492;
        Wed, 17 Aug 2022 03:18:45 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:18:44 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/17] common kmalloc v4
Date:   Wed, 17 Aug 2022 19:18:09 +0900
Message-Id: <20220817101826.236819-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: https://lore.kernel.org/lkml/20220712133946.307181-1-42.hyeyoo@gmail.com/

Hello, this is common kmalloc v4.
Please review and consider applying.

Changes from v3 are shown as range-diff below.
(range-diff does not include new patch 13)

v3 -> v4:
	
	- Rebased to commit 3cc40a443a04d5 (after 6.0-rc1)

	- Added Reviewed-by: from Vlastimil Babka. Thanks!

	- Adjusted comments from Vlastimil Babka:

		- uninline __kmalloc_large_node_notrace()
		
		- Adjust s->size to SLOB_UNITS(s->size) * SLOB_UNIT in
		  SLOB.

		- do not pass __GFP_COMP to tracepoint in
		  kmalloc_large() and friends

		- defer testing of 'accounted' into TP_printk until
		  trace_kmalloc()

		- rename kmem_cache_alloc[_node]_trace() to
		  kmalloc[_node]_trace() and move it to slab_alloc.c,
		  
		  Use __assume_kmalloc_alignement instead of
		  __assume_slab_alignment (patch 13)
	
		- replace word definition to declaration in changelog

	- Adjusted comment from Chrisptoh Lameter:
		- replace WARN_ON() to BUG_ON()


Any feedbacks/suggestions will be appreciated!

Thanks!

Hyeonggon Yoo (17):
  mm/slab: move NUMA-related code to __do_cache_alloc()
  mm/slab: cleanup slab_alloc() and slab_alloc_node()
  mm/slab_common: remove CONFIG_NUMA ifdefs for common kmalloc functions
  mm/slab_common: cleanup kmalloc_track_caller()
  mm/sl[au]b: factor out __do_kmalloc_node()
  mm/slab_common: fold kmalloc_order_trace() into kmalloc_large()
  mm/slub: move kmalloc_large_node() to slab_common.c
  mm/slab_common: kmalloc_node: pass large requests to page allocator
  mm/slab_common: cleanup kmalloc_large()
  mm/slab: kmalloc: pass requests larger than order-1 page to page
    allocator
  mm/sl[au]b: introduce common alloc/free functions without tracepoint
  mm/sl[au]b: generalize kmalloc subsystem
  mm/sl[au]b: cleanup kmem_cache_alloc[_node]_trace()
  mm/slab_common: unify NUMA and UMA version of tracepoints
  mm/slab_common: drop kmem_alloc & avoid dereferencing fields when not
    using
  mm/slab_common: move declaration of __ksize() to mm/slab.h
  mm/sl[au]b: check if large object is valid in __ksize()

 include/linux/slab.h        | 144 ++++++-----------
 include/trace/events/kmem.h |  74 +++------
 mm/slab.c                   | 305 +++++++++---------------------------
 mm/slab.h                   |  10 ++
 mm/slab_common.c            | 191 +++++++++++++++++++---
 mm/slob.c                   |  31 ++--
 mm/slub.c                   | 234 ++-------------------------
 7 files changed, 338 insertions(+), 651 deletions(-)


===== range-diff =====

git range-diff	slab-common-v3r0~16...slab-common-v3r0
		slab-common-v4r0~17...slab-common-v4r0:

 1:  c1ba6a2f28b4 !  1:  0f84e3cefd1a mm/slab: move NUMA-related code to __do_cache_alloc()
    @@ mm/slab.c: static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t fl
      	bool init = false;
      
     @@ mm/slab.c: slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
    + 		goto out_hooks;
      
    - 	cache_alloc_debugcheck_before(cachep, flags);
      	local_irq_save(save_flags);
     -
     -	if (nodeid == NUMA_NO_NODE)
    @@ mm/slab.c: slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, s
      	return ____cache_alloc(cachep, flags);
      }
     @@ mm/slab.c: slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
    + 		goto out;
      
    - 	cache_alloc_debugcheck_before(cachep, flags);
      	local_irq_save(save_flags);
     -	objp = __do_cache_alloc(cachep, flags);
     +	objp = __do_cache_alloc(cachep, flags, NUMA_NO_NODE);
 2:  75e053d9e62f !  2:  ed66aae2655d mm/slab: cleanup slab_alloc() and slab_alloc_node()
    @@ mm/slab.c: static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t fl
     -	if (unlikely(ptr))
     -		goto out_hooks;
     -
    --	cache_alloc_debugcheck_before(cachep, flags);
     -	local_irq_save(save_flags);
     -	ptr = __do_cache_alloc(cachep, flags, nodeid);
     -	local_irq_restore(save_flags);
    @@ mm/slab.c: __do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid _
      	unsigned long save_flags;
      	void *objp;
     @@ mm/slab.c: slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
    + 		goto out;
      
    - 	cache_alloc_debugcheck_before(cachep, flags);
      	local_irq_save(save_flags);
     -	objp = __do_cache_alloc(cachep, flags, NUMA_NO_NODE);
     +	objp = __do_cache_alloc(cachep, flags, nodeid);
 3:  7db354b38ca6 =  3:  c84d648e0440 mm/slab_common: remove CONFIG_NUMA ifdefs for common kmalloc functions
 4:  cdb433c0c7eb =  4:  967dd62b2f55 mm/slab_common: cleanup kmalloc_track_caller()
 5:  46100ebddd00 !  5:  11b3a686bf31 mm/sl[au]b: factor out __do_kmalloc_node()
    @@ Commit message
         __kmalloc_node_track_caller().
     
         Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
    +    Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
     
      ## mm/slab.c ##
     @@ mm/slab.c: void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 6:  efc756f837fa !  6:  f30428f4af3d mm/slab_common: fold kmalloc_order_trace() into kmalloc_large()
    @@ mm/slab_common.c: gfp_t kmalloc_fix_flags(gfp_t flags)
      
      	if (unlikely(flags & GFP_SLAB_BUG_MASK))
      		flags = kmalloc_fix_flags(flags);
    + 
    +-	flags |= __GFP_COMP;
    +-	page = alloc_pages(flags, order);
    ++	page = alloc_pages(flags | __GFP_COMP, order);
    + 	if (likely(page)) {
    + 		ret = page_address(page);
    + 		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
     @@ mm/slab_common.c: void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
      	ret = kasan_kmalloc_large(ret, size, flags);
      	/* As ret might get tagged, call kmemleak hook after KASAN. */
 7:  9e137d787056 =  7:  bd1a17ffce8c mm/slub: move kmalloc_large_node() to slab_common.c
 8:  e48d0b2adad4 !  8:  4a83cf5171f2 mm/slab_common: kmalloc_node: pass large requests to page allocator
    @@ Commit message
         __kmalloc_node_track_caller() when large objects are allocated.
     
         Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
    +    Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
     
      ## include/linux/slab.h ##
     @@ include/linux/slab.h: static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
    @@ mm/slab_common.c: void *kmalloc_large(size_t size, gfp_t flags)
      EXPORT_SYMBOL(kmalloc_large);
      
     -void *kmalloc_large_node(size_t size, gfp_t flags, int node)
    -+static __always_inline
    -+void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    ++void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
      {
      	struct page *page;
      	void *ptr = NULL;
    @@ mm/slab_common.c: void *kmalloc_large_node(size_t size, gfp_t flags, int node)
      	return ptr;
      }
     +
    -+void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    -+{
    -+	return __kmalloc_large_node_notrace(size, flags, node);
    -+}
    -+
     +void *kmalloc_large_node(size_t size, gfp_t flags, int node)
     +{
    -+	void *ret = __kmalloc_large_node_notrace(size, flags, node);
    ++	void *ret = kmalloc_large_node_notrace(size, flags, node);
     +
     +	trace_kmalloc_node(_RET_IP_, ret, NULL, size,
     +			   PAGE_SIZE << get_order(size), flags, node);
 9:  7e813b9c9b0b !  9:  a94e5405bbc5 mm/slab_common: cleanup kmalloc_large()
    @@ Commit message
         mm/slab_common: cleanup kmalloc_large()
     
         Now that kmalloc_large() and kmalloc_large_node() do mostly same job,
    -    make kmalloc_large() wrapper of __kmalloc_large_node_notrace().
    +    make kmalloc_large() wrapper of kmalloc_large_node_notrace().
     
         In the meantime, add missing flag fix code in
    -    __kmalloc_large_node_notrace().
    +    kmalloc_large_node_notrace().
     
         Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
    +    Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
     
      ## mm/slab_common.c ##
     @@ mm/slab_common.c: gfp_t kmalloc_fix_flags(gfp_t flags)
    @@ mm/slab_common.c: gfp_t kmalloc_fix_flags(gfp_t flags)
     -	if (unlikely(flags & GFP_SLAB_BUG_MASK))
     -		flags = kmalloc_fix_flags(flags);
     -
    --	flags |= __GFP_COMP;
    --	page = alloc_pages(flags, order);
    +-	page = alloc_pages(flags | __GFP_COMP, order);
     -	if (likely(page)) {
     -		ret = page_address(page);
     -		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
    @@ mm/slab_common.c: gfp_t kmalloc_fix_flags(gfp_t flags)
     -}
     -EXPORT_SYMBOL(kmalloc_large);
      
    - static __always_inline
    - void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    -@@ mm/slab_common.c: void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    + void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    + {
    +@@ mm/slab_common.c: void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
      	void *ptr = NULL;
      	unsigned int order = get_order(size);
      
    @@ mm/slab_common.c: void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, i
      	flags |= __GFP_COMP;
      	page = alloc_pages_node(node, flags, order);
      	if (page) {
    -@@ mm/slab_common.c: void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    +@@ mm/slab_common.c: void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
      	return ptr;
      }
      
     +void *kmalloc_large(size_t size, gfp_t flags)
     +{
    -+	void *ret = __kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
    ++	void *ret = kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
     +
     +	trace_kmalloc(_RET_IP_, ret, NULL, size,
     +		      PAGE_SIZE << get_order(size), flags);
    @@ mm/slab_common.c: void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, i
     +}
     +EXPORT_SYMBOL(kmalloc_large);
     +
    - void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    + void *kmalloc_large_node(size_t size, gfp_t flags, int node)
      {
    - 	return __kmalloc_large_node_notrace(size, flags, node);
    + 	void *ret = kmalloc_large_node_notrace(size, flags, node);
10:  6ad83caba0a7 ! 10:  c46928674558 mm/slab: kmalloc: pass requests larger than order-1 page to page allocator
    @@ Commit message
         maintenance of common code.
     
         Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
    +    Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
     
      ## include/linux/slab.h ##
     @@ include/linux/slab.h: static inline unsigned int arch_slab_minalign(void)
11:  e5b712dc374c ! 11:  3215ee05c450 mm/sl[au]b: introduce common alloc/free functions without tracepoint
    @@ Commit message
         functions that does not have tracepoint.
     
         Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
    +    Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
     
      ## mm/slab.c ##
     @@ mm/slab.c: void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
12:  e44cd126a340 ! 12:  4d70e7590d3a mm/sl[au]b: generalize kmalloc subsystem
    @@ Commit message
         kfree(), __ksize(), __kmalloc(), __kmalloc_node() and move them
         to slab_common.c.
     
    +    In the meantime, rename kmalloc_large_node_notrace()
    +    to __kmalloc_large_node() and make it static as it's now only called in
    +    slab_common.c.
    +
         Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
    +    Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
     
      ## mm/slab.c ##
     @@ mm/slab.c: void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
    @@ mm/slab.c: void __check_heap_object(const void *ptr, unsigned long n,
     -}
     -EXPORT_SYMBOL(__ksize);
     
    + ## mm/slab.h ##
    +@@ mm/slab.h: void create_kmalloc_caches(slab_flags_t);
    + /* Find the kmalloc slab corresponding for a certain size */
    + struct kmem_cache *kmalloc_slab(size_t, gfp_t);
    + 
    +-void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
    + void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
    + 			      int node, size_t orig_size,
    + 			      unsigned long caller);
    +
      ## mm/slab_common.c ##
     @@ mm/slab_common.c: void free_large_kmalloc(struct folio *folio, void *object)
      			      -(PAGE_SIZE << order));
      	__free_pages(folio_page(folio, 0), order);
      }
     +
    ++static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
     +static __always_inline
     +void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
     +{
    @@ mm/slab_common.c: void free_large_kmalloc(struct folio *folio, void *object)
     +	void *ret;
     +
     +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
    -+		ret = kmalloc_large_node_notrace(size, flags, node);
    ++		ret = __kmalloc_large_node(size, flags, node);
     +		trace_kmalloc_node(caller, ret, NULL,
     +				   size, PAGE_SIZE << get_order(size),
     +				   flags, node);
    @@ mm/slab_common.c: void free_large_kmalloc(struct folio *folio, void *object)
      #endif /* !CONFIG_SLOB */
      
      gfp_t kmalloc_fix_flags(gfp_t flags)
    +@@ mm/slab_common.c: gfp_t kmalloc_fix_flags(gfp_t flags)
    +  * know the allocation order to free the pages properly in kfree.
    +  */
    + 
    +-void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    ++void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
    + {
    + 	struct page *page;
    + 	void *ptr = NULL;
    +@@ mm/slab_common.c: void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
    + 
    + void *kmalloc_large(size_t size, gfp_t flags)
    + {
    +-	void *ret = kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
    ++	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
    + 
    + 	trace_kmalloc(_RET_IP_, ret, NULL, size,
    + 		      PAGE_SIZE << get_order(size), flags);
    +@@ mm/slab_common.c: EXPORT_SYMBOL(kmalloc_large);
    + 
    + void *kmalloc_large_node(size_t size, gfp_t flags, int node)
    + {
    +-	void *ret = kmalloc_large_node_notrace(size, flags, node);
    ++	void *ret = __kmalloc_large_node(size, flags, node);
    + 
    + 	trace_kmalloc_node(_RET_IP_, ret, NULL, size,
    + 			   PAGE_SIZE << get_order(size), flags, node);
     
      ## mm/slub.c ##
     @@ mm/slub.c: static int __init setup_slub_min_objects(char *str)
 -:  ------------ > 13:  da6880a20924 mm/sl[au]b: cleanup kmem_cache_alloc[_node]_trace()
13:  a137bfbdb06b ! 14:  ef7a0f0d58db mm/slab_common: unify NUMA and UMA version of tracepoints
    @@ Commit message
         event classes does not makes sense at all.
     
         Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
    +    Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
     
      ## include/trace/events/kmem.h ##
     @@
    @@ mm/slab.c: void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_l
      
      	return ret;
      }
    -@@ mm/slab.c: kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
    - 
    - 	ret = kasan_kmalloc(cachep, ret, size, flags);
    - 	trace_kmalloc(_RET_IP_, ret, cachep,
    --		      size, cachep->size, flags);
    -+		      size, cachep->size, flags, NUMA_NO_NODE);
    - 	return ret;
    - }
    - EXPORT_SYMBOL(kmem_cache_alloc_trace);
     @@ mm/slab.c: void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
      {
      	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
    @@ mm/slab.c: void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, i
     -	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep,
     -				    cachep->object_size, cachep->size,
     -				    flags, nodeid);
    -+	trace_kmem_cache_alloc(_RET_IP_, ret, cachep,
    -+			       cachep->object_size, cachep->size,
    -+			       flags, nodeid);
    - 
    - 	return ret;
    - }
    -@@ mm/slab.c: void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
    - 	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
    ++	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, cachep->object_size,
    ++			       cachep->size, flags, nodeid);
      
    - 	ret = kasan_kmalloc(cachep, ret, size, flags);
    --	trace_kmalloc_node(_RET_IP_, ret, cachep,
    --			   size, cachep->size,
    --			   flags, nodeid);
    -+	trace_kmalloc(_RET_IP_, ret, cachep,
    -+		      size, cachep->size,
    -+		      flags, nodeid);
      	return ret;
      }
    - EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
     
      ## mm/slab_common.c ##
     @@ mm/slab_common.c: void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
      
      	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
    - 		ret = kmalloc_large_node_notrace(size, flags, node);
    + 		ret = __kmalloc_large_node(size, flags, node);
     -		trace_kmalloc_node(caller, ret, NULL,
     -				   size, PAGE_SIZE << get_order(size),
     -				   flags, node);
    -+		trace_kmalloc(_RET_IP_, ret, NULL,
    -+			      size, PAGE_SIZE << get_order(size),
    -+			      flags, node);
    ++		trace_kmalloc(_RET_IP_, ret, NULL, size,
    ++			      PAGE_SIZE << get_order(size), flags, node);
      		return ret;
      	}
      
    @@ mm/slab_common.c: void *__do_kmalloc_node(size_t size, gfp_t flags, int node, un
      	ret = kasan_kmalloc(s, ret, size, flags);
     -	trace_kmalloc_node(caller, ret, s, size,
     -			   s->size, flags, node);
    -+	trace_kmalloc(_RET_IP_, ret, s, size,
    -+		      s->size, flags, node);
    ++	trace_kmalloc(_RET_IP_, ret, s, size, s->size, flags, node);
      	return ret;
      }
      
    +@@ mm/slab_common.c: void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
    + 	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
    + 					    size, _RET_IP_);
    + 
    +-	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size,
    +-			   gfpflags, NUMA_NO_NODE);
    ++	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, NUMA_NO_NODE);
    + 
    + 	ret = kasan_kmalloc(s, ret, size, gfpflags);
    + 	return ret;
    +@@ mm/slab_common.c: void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
    + {
    + 	void *ret = __kmem_cache_alloc_node(s, gfpflags, node, size, _RET_IP_);
    + 
    +-	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size, gfpflags, node);
    ++	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, node);
    + 
    + 	ret = kasan_kmalloc(s, ret, size, gfpflags);
    + 	return ret;
     @@ mm/slab_common.c: void *kmalloc_large(size_t size, gfp_t flags)
    - 	void *ret = __kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
    + 	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
      
      	trace_kmalloc(_RET_IP_, ret, NULL, size,
     -		      PAGE_SIZE << get_order(size), flags);
    @@ mm/slab_common.c: void *kmalloc_large(size_t size, gfp_t flags)
      EXPORT_SYMBOL(kmalloc_large);
     @@ mm/slab_common.c: void *kmalloc_large_node(size_t size, gfp_t flags, int node)
      {
    - 	void *ret = __kmalloc_large_node_notrace(size, flags, node);
    + 	void *ret = __kmalloc_large_node(size, flags, node);
      
     -	trace_kmalloc_node(_RET_IP_, ret, NULL, size,
     -			   PAGE_SIZE << get_order(size), flags, node);
    @@ mm/slob.c: __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long cal
      
     -		trace_kmalloc_node(caller, ret, NULL,
     -				   size, size + minalign, gfp, node);
    -+		trace_kmalloc(caller, ret, NULL,
    -+			      size, size + minalign, gfp, node);
    ++		trace_kmalloc(caller, ret, NULL, size,
    ++			      size + minalign, gfp, node);
      	} else {
      		unsigned int order = get_order(size);
      
    @@ mm/slob.c: __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long cal
      
     -		trace_kmalloc_node(caller, ret, NULL,
     -				   size, PAGE_SIZE << order, gfp, node);
    -+		trace_kmalloc(caller, ret, NULL,
    -+			      size, PAGE_SIZE << order, gfp, node);
    ++		trace_kmalloc(caller, ret, NULL, size,
    ++			      PAGE_SIZE << order, gfp, node);
      	}
      
      	kmemleak_alloc(ret, size, 1, gfp);
    @@ mm/slub.c: void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *l
     -				s->size, gfpflags);
     +				s->size, gfpflags, NUMA_NO_NODE);
      
    - 	return ret;
    - }
    -@@ mm/slub.c: void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
    - void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
    - {
    - 	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
    --	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags);
    -+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, NUMA_NO_NODE);
    - 	ret = kasan_kmalloc(s, ret, size, gfpflags);
      	return ret;
      }
     @@ mm/slub.c: void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
    @@ mm/slub.c: void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int
      
     -	trace_kmem_cache_alloc_node(_RET_IP_, ret, s,
     -				    s->object_size, s->size, gfpflags, node);
    -+	trace_kmem_cache_alloc(_RET_IP_, ret, s,
    -+			       s->object_size, s->size, gfpflags, node);
    ++	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
    ++			       s->size, gfpflags, node);
      
      	return ret;
      }
    -@@ mm/slub.c: void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
    - {
    - 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
    - 
    --	trace_kmalloc_node(_RET_IP_, ret, s,
    --			   size, s->size, gfpflags, node);
    -+	trace_kmalloc(_RET_IP_, ret, s,
    -+		      size, s->size, gfpflags, node);
    - 
    - 	ret = kasan_kmalloc(s, ret, size, gfpflags);
    - 	return ret;
14:  6d2b911a8274 ! 15:  998f51e44ff8 mm/slab_common: drop kmem_alloc & avoid dereferencing fields when not using
    @@ Commit message
              gfp flag is enough to know if it's accounted or not.
            - Avoid dereferencing s->object_size and s->size when not using kmem_cache_alloc event.
            - Avoid dereferencing s->name in when not using kmem_cache_free event.
    +       - Adjust s->size to SLOB_UNITS(s->size) * SLOB_UNIT in SLOB
     
    +    Cc: Vasily Averin <vasily.averin@linux.dev>
         Suggested-by: Vlastimil Babka <vbabka@suse.cz>
         Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
    +    Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
     
      ## include/trace/events/kmem.h ##
     @@
    @@ include/trace/events/kmem.h: DECLARE_EVENT_CLASS(kmem_alloc,
      		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
      		__entry->node		= node;
      		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG_KMEM) ?
    + 					  ((gfp_flags & __GFP_ACCOUNT) ||
    +-					  (s && s->flags & SLAB_ACCOUNT)) : false;
    ++					  (s->flags & SLAB_ACCOUNT)) : false;
    + 	),
    + 
    + 	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
     @@ include/trace/events/kmem.h: DECLARE_EVENT_CLASS(kmem_alloc,
      		__entry->accounted ? "true" : "false")
      );
    @@ include/trace/events/kmem.h: DECLARE_EVENT_CLASS(kmem_alloc,
     +		__field(	size_t,		bytes_alloc	)
     +		__field(	unsigned long,	gfp_flags	)
     +		__field(	int,		node		)
    -+		__field(	bool,		accounted	)
     +	),
      
     -	TP_PROTO(unsigned long call_site, const void *ptr,
    @@ include/trace/events/kmem.h: DECLARE_EVENT_CLASS(kmem_alloc,
     +		__entry->bytes_alloc	= bytes_alloc;
     +		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
     +		__entry->node		= node;
    -+		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG_KMEM) ?
    -+					  (gfp_flags & __GFP_ACCOUNT) : false;
     +	),
      
     -	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
    @@ include/trace/events/kmem.h: DECLARE_EVENT_CLASS(kmem_alloc,
     +		__entry->bytes_alloc,
     +		show_gfp_flags(__entry->gfp_flags),
     +		__entry->node,
    -+		__entry->accounted ? "true" : "false")
    ++		(IS_ENABLED(CONFIG_MEMCG_KMEM) &&
    ++		 (__entry->gfp_flags & __GFP_ACCOUNT)) ? "true" : "false")
      );
      
      TRACE_EVENT(kfree,
    @@ mm/slab.c: void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_l
      
      	return ret;
      }
    -@@ mm/slab.c: kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
    - 	ret = slab_alloc(cachep, NULL, flags, size, _RET_IP_);
    - 
    - 	ret = kasan_kmalloc(cachep, ret, size, flags);
    --	trace_kmalloc(_RET_IP_, ret, cachep,
    --		      size, cachep->size, flags, NUMA_NO_NODE);
    -+	trace_kmalloc(_RET_IP_, ret,
    -+		      size, cachep->size,
    -+		      flags, NUMA_NO_NODE);
    - 	return ret;
    - }
    - EXPORT_SYMBOL(kmem_cache_alloc_trace);
     @@ mm/slab.c: void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
      {
      	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
      
    --	trace_kmem_cache_alloc(_RET_IP_, ret, cachep,
    --			       cachep->object_size, cachep->size,
    --			       flags, nodeid);
    +-	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, cachep->object_size,
    +-			       cachep->size, flags, nodeid);
     +	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, flags, nodeid);
      
      	return ret;
      }
    -@@ mm/slab.c: void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
    - 	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
    - 
    - 	ret = kasan_kmalloc(cachep, ret, size, flags);
    --	trace_kmalloc(_RET_IP_, ret, cachep,
    -+	trace_kmalloc(_RET_IP_, ret,
    - 		      size, cachep->size,
    - 		      flags, nodeid);
    - 	return ret;
     @@ mm/slab.c: void kmem_cache_free(struct kmem_cache *cachep, void *objp)
      	if (!cachep)
      		return;
    @@ mm/slab_common.c
     @@ mm/slab_common.c: void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
      
      	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
    - 		ret = kmalloc_large_node_notrace(size, flags, node);
    --		trace_kmalloc(_RET_IP_, ret, NULL,
    -+		trace_kmalloc(_RET_IP_, ret,
    - 			      size, PAGE_SIZE << get_order(size),
    - 			      flags, node);
    + 		ret = __kmalloc_large_node(size, flags, node);
    +-		trace_kmalloc(_RET_IP_, ret, NULL, size,
    ++		trace_kmalloc(_RET_IP_, ret, size,
    + 			      PAGE_SIZE << get_order(size), flags, node);
      		return ret;
    + 	}
     @@ mm/slab_common.c: void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
      
      	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
      	ret = kasan_kmalloc(s, ret, size, flags);
    --	trace_kmalloc(_RET_IP_, ret, s, size,
    --		      s->size, flags, node);
    -+	trace_kmalloc(_RET_IP_, ret,
    -+		      size, s->size,
    -+		      flags, node);
    +-	trace_kmalloc(_RET_IP_, ret, s, size, s->size, flags, node);
    ++	trace_kmalloc(_RET_IP_, ret, size, s->size, flags, node);
      	return ret;
      }
      
    +@@ mm/slab_common.c: void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
    + 	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
    + 					    size, _RET_IP_);
    + 
    +-	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, NUMA_NO_NODE);
    ++	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
    + 
    + 	ret = kasan_kmalloc(s, ret, size, gfpflags);
    + 	return ret;
    +@@ mm/slab_common.c: void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
    + {
    + 	void *ret = __kmem_cache_alloc_node(s, gfpflags, node, size, _RET_IP_);
    + 
    +-	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, node);
    ++	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
    + 
    + 	ret = kasan_kmalloc(s, ret, size, gfpflags);
    + 	return ret;
     @@ mm/slab_common.c: void *kmalloc_large(size_t size, gfp_t flags)
      {
    - 	void *ret = __kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
    + 	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
      
     -	trace_kmalloc(_RET_IP_, ret, NULL, size,
     -		      PAGE_SIZE << get_order(size), flags, NUMA_NO_NODE);
    -+	trace_kmalloc(_RET_IP_, ret,
    -+		      size, PAGE_SIZE << get_order(size),
    ++	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
     +		      flags, NUMA_NO_NODE);
      	return ret;
      }
      EXPORT_SYMBOL(kmalloc_large);
     @@ mm/slab_common.c: void *kmalloc_large_node(size_t size, gfp_t flags, int node)
      {
    - 	void *ret = __kmalloc_large_node_notrace(size, flags, node);
    + 	void *ret = __kmalloc_large_node(size, flags, node);
      
     -	trace_kmalloc(_RET_IP_, ret, NULL, size,
     -		      PAGE_SIZE << get_order(size), flags, node);
    -+	trace_kmalloc(_RET_IP_, ret,
    -+		      size, PAGE_SIZE << get_order(size),
    ++	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
     +		      flags, node);
      	return ret;
      }
    @@ mm/slob.c: __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long cal
      		*m = size;
      		ret = (void *)m + minalign;
      
    --		trace_kmalloc(caller, ret, NULL,
    --			      size, size + minalign, gfp, node);
    +-		trace_kmalloc(caller, ret, NULL, size,
    +-			      size + minalign, gfp, node);
     +		trace_kmalloc(caller, ret, size, size + minalign, gfp, node);
      	} else {
      		unsigned int order = get_order(size);
    @@ mm/slob.c: __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long cal
      			gfp |= __GFP_COMP;
      		ret = slob_new_pages(gfp, order, node);
      
    --		trace_kmalloc(caller, ret, NULL,
    --			      size, PAGE_SIZE << order, gfp, node);
    +-		trace_kmalloc(caller, ret, NULL, size,
    +-			      PAGE_SIZE << order, gfp, node);
     +		trace_kmalloc(caller, ret, size, PAGE_SIZE << order, gfp, node);
      	}
      
      	kmemleak_alloc(ret, size, 1, gfp);
    +@@ mm/slob.c: int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
    + 		/* leave room for rcu footer at the end of object */
    + 		c->size += sizeof(struct slob_rcu);
    + 	}
    ++
    ++	/* Actual size allocated */
    ++	c->size = SLOB_UNITS(c->size) * SLOB_UNIT;
    + 	c->flags = flags;
    + 	return 0;
    + }
     @@ mm/slob.c: static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
      
      	if (c->size < PAGE_SIZE) {
    @@ mm/slub.c: void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *l
     -				s->size, gfpflags, NUMA_NO_NODE);
     +	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
      
    - 	return ret;
    - }
    -@@ mm/slub.c: void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
    - void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
    - {
    - 	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
    --	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, NUMA_NO_NODE);
    -+	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
    - 	ret = kasan_kmalloc(s, ret, size, gfpflags);
      	return ret;
      }
     @@ mm/slub.c: void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
      {
      	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
      
    --	trace_kmem_cache_alloc(_RET_IP_, ret, s,
    --			       s->object_size, s->size, gfpflags, node);
    +-	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
    +-			       s->size, gfpflags, node);
     +	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, node);
      
      	return ret;
      }
    -@@ mm/slub.c: void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
    - {
    - 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
    - 
    --	trace_kmalloc(_RET_IP_, ret, s,
    --		      size, s->size, gfpflags, node);
    -+	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
    - 
    - 	ret = kasan_kmalloc(s, ret, size, gfpflags);
    - 	return ret;
     @@ mm/slub.c: void kmem_cache_free(struct kmem_cache *s, void *x)
      	s = cache_from_obj(s, x);
      	if (!s)
15:  566fdd67515d ! 16:  cd1a424103f5 mm/slab_common: move definition of __ksize() to mm/slab.h
    @@ Metadata
     Author: Hyeonggon Yoo <42.hyeyoo@gmail.com>
     
      ## Commit message ##
    -    mm/slab_common: move definition of __ksize() to mm/slab.h
    +    mm/slab_common: move declaration of __ksize() to mm/slab.h
     
         __ksize() is only called by KASAN. Remove export symbol and move
    -    definition to mm/slab.h as we don't want to grow its callers.
    +    declaration to mm/slab.h as we don't want to grow its callers.
     
         Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
         Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
    @@ mm/slab_common.c: size_t __ksize(const void *object)
      	return slab_ksize(folio_slab(folio)->slab_cache);
      }
     -EXPORT_SYMBOL(__ksize);
    - #endif /* !CONFIG_SLOB */
      
    - gfp_t kmalloc_fix_flags(gfp_t flags)
    + #ifdef CONFIG_TRACING
    + void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
     
      ## mm/slob.c ##
     @@ mm/slob.c: size_t __ksize(const void *block)
16:  2c99a66a9307 ! 17:  11bd80a065e4 mm/sl[au]b: check if large object is valid in __ksize()
    @@ Metadata
      ## Commit message ##
         mm/sl[au]b: check if large object is valid in __ksize()
     
    -    __ksize() returns size of objects allocated from slab allocator.
    -    When invalid object is passed to __ksize(), returning zero
    -    prevents further memory corruption and makes caller be able to
    -    check if there is an error.
    -
         If address of large object is not beginning of folio or size of
    -    the folio is too small, it must be invalid. Return zero in such cases.
    +    the folio is too small, it must be invalid. BUG() in such cases.
     
    +    Cc: Marco Elver <elver@google.com>
         Suggested-by: Vlastimil Babka <vbabka@suse.cz>
         Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
    +    Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
     
      ## mm/slab_common.c ##
     @@ mm/slab_common.c: size_t __ksize(const void *object)
    @@ mm/slab_common.c: size_t __ksize(const void *object)
      
     -	if (unlikely(!folio_test_slab(folio)))
     +	if (unlikely(!folio_test_slab(folio))) {
    -+		if (WARN_ON(object != folio_address(folio) ||
    -+				folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))
    -+			return 0;
    ++		BUG_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE);
    ++		BUG_ON(object != folio_address(folio));
      		return folio_size(folio);
     +	}
      
-- 
2.32.0
