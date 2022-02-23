Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406394C05C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiBWAHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiBWAHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:07:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223FECC5;
        Tue, 22 Feb 2022 16:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE8C4B81D44;
        Wed, 23 Feb 2022 00:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F64C340E8;
        Wed, 23 Feb 2022 00:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645574800;
        bh=vttMxgjAZpqLoGBZMw5U3C2KnMQw5fBtXlwVwgbVK4o=;
        h=From:To:Cc:Subject:Date:From;
        b=XO7xukoTpyqRb3XyRlq3kwhRoY5nLCP+HfKTdG9gufarYTFtKisOBuq7EdJbEGdRy
         0jmGXvAp8bT8s7vdnxaGcmuCvJno6ysT9f9XvR54LNTzFcWgzL3kEqsXJi5ltu7mI+
         ELMEXEq9b8W5FD5LkHqXLu8nGh+/rcgX6xpR9FpZHyim63wBZxRC4aGuryXwQ055kT
         2T0gVzSClD7gOgRJClwh8cyxTSc1VNU5yFzcR82B2fywBNaZif8aj3J672u7lFtNZw
         8Yq5qxzagkx33aCHy3oH3GgJo38aDwNoqIXX+kMOX55FloYZbVze1VQZONkPzozV+f
         uEqBg5CqMF9PA==
From:   broonie@kernel.org
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: linux-next: manual merge of the maple tree with the memblock tree
Date:   Wed, 23 Feb 2022 00:06:34 +0000
Message-Id: <20220223000634.907121-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the maple tree got conflicts in:

  tools/testing/radix-tree/linux.c
  tools/testing/radix-tree/Makefile
  tools/include/linux/slab.h

between commit:

  aa0eab8639ff0 ("tools: Move gfp.h and slab.h from radix-tree to lib")

from the memblock tree and commits:

  3a77b4e41d4f3 ("radix tree test suite: Add support for slab bulk APIs")
  ad4144ea04112 ("lib/test_maple_tree: Add testing for maple tree")

from the maple tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/include/linux/slab.h
index f41d8a0eb1a42,d7aed1cc69781..0000000000000
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@@ -35,4 -24,8 +35,8 @@@ struct kmem_cache *kmem_cache_create(co
  			unsigned int align, unsigned int flags,
  			void (*ctor)(void *));
  
+ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list);
+ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
+ 			  void **list);
+ 
 -#endif		/* SLAB_H */
 +#endif		/* _TOOLS_SLAB_H */
diff --cc tools/testing/radix-tree/Makefile
index c4ea4fbb0bfcd,3e0fa6ae0e0a3..0000000000000
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@@ -4,9 -4,8 +4,9 @@@ CFLAGS += -I. -I../../include -g -Og -W
  	  -fsanitize=undefined
  LDFLAGS += -fsanitize=address -fsanitize=undefined
  LDLIBS+= -lpthread -lurcu
- TARGETS = main idr-test multiorder xarray
+ TARGETS = main idr-test multiorder xarray maple
 -CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o maple.o
 +CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
- 			 slab.o
++			 slab.o maple.o
  OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
  	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
  	 iteration_check_2.o benchmark.o
diff --cc tools/testing/radix-tree/linux.c
index 81539f5439546,3383d748c6509..0000000000000
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@@ -77,6 -118,97 +117,71 @@@ void kmem_cache_free(struct kmem_cache 
  	pthread_mutex_unlock(&cachep->lock);
  }
  
+ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list)
+ {
+ 	if (kmalloc_verbose)
+ 		pr_debug("Bulk free %p[0-%lu]\n", list, size - 1);
+ 
+ 	pthread_mutex_lock(&cachep->lock);
+ 	for (int i = 0; i < size; i++)
+ 		kmem_cache_free_locked(cachep, list[i]);
+ 	pthread_mutex_unlock(&cachep->lock);
+ }
+ 
+ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
+ 			  void **p)
+ {
+ 	size_t i;
+ 
+ 	if (kmalloc_verbose)
+ 		pr_debug("Bulk alloc %lu\n", size);
+ 
+ 	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+ 		if (cachep->non_kernel < size)
+ 			return 0;
+ 
+ 		cachep->non_kernel -= size;
+ 	}
+ 
+ 	pthread_mutex_lock(&cachep->lock);
+ 	if (cachep->nr_objs >= size) {
+ 		struct radix_tree_node *node;
+ 
+ 		for (i = 0; i < size; i++) {
+ 			node = cachep->objs;
+ 			cachep->nr_objs--;
+ 			cachep->objs = node->parent;
+ 			p[i] = node;
+ 			node->parent = NULL;
+ 		}
+ 		pthread_mutex_unlock(&cachep->lock);
+ 	} else {
+ 		pthread_mutex_unlock(&cachep->lock);
+ 		for (i = 0; i < size; i++) {
+ 			if (cachep->align) {
+ 				posix_memalign(&p[i], cachep->align,
+ 					       cachep->size * size);
+ 			} else {
+ 				p[i] = malloc(cachep->size * size);
+ 			}
+ 			if (cachep->ctor)
+ 				cachep->ctor(p[i]);
+ 			else if (gfp & __GFP_ZERO)
+ 				memset(p[i], 0, cachep->size);
+ 		}
+ 	}
+ 
+ 	for (i = 0; i < size; i++) {
+ 		uatomic_inc(&nr_allocated);
+ 		uatomic_inc(&cachep->nr_allocated);
+ 		uatomic_inc(&cachep->nr_tallocated);
+ 		if (kmalloc_verbose)
+ 			printf("Allocating %p from slab\n", p[i]);
+ 	}
+ 
+ 	return size;
+ }
+ 
 -void *kmalloc(size_t size, gfp_t gfp)
 -{
 -	void *ret;
 -
 -	if (!(gfp & __GFP_DIRECT_RECLAIM))
 -		return NULL;
 -
 -	ret = malloc(size);
 -	uatomic_inc(&nr_allocated);
 -	if (kmalloc_verbose)
 -		printf("Allocating %p from malloc\n", ret);
 -	if (gfp & __GFP_ZERO)
 -		memset(ret, 0, size);
 -	return ret;
 -}
 -
 -void kfree(void *p)
 -{
 -	if (!p)
 -		return;
 -	uatomic_dec(&nr_allocated);
 -	if (kmalloc_verbose)
 -		printf("Freeing %p to malloc\n", p);
 -	free(p);
 -}
 -
  struct kmem_cache *
  kmem_cache_create(const char *name, unsigned int size, unsigned int align,
  		unsigned int flags, void (*ctor)(void *))
