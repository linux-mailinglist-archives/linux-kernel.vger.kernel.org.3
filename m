Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093E2586D2D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiHAOpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiHAOoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:44:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F05C3A4BF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:44:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A1BB34F0A;
        Mon,  1 Aug 2022 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659365063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b3kgzoMTS9DgLAuglxQQWO3u8jm1ZLW5f8M21w+NP1o=;
        b=byMT7hD2NKnQGhOva9KFmTcEtXdDvPyTpLBWEAbqrLnj9uY2ElJ+cYyiFDvNHCBI1kX6Qe
        hlaJGtkpkp6h25VG0rdmyAQTp7kHjtiXN0D08nhte6EfCY8FwHwsByatr/7ryZ1wR1zOK3
        4z8ZSExpjqTVD4MX6GkyUyVn+EKiw0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659365063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b3kgzoMTS9DgLAuglxQQWO3u8jm1ZLW5f8M21w+NP1o=;
        b=JjEsGiPdnYAPLeswcHvUSC8itbaO5HvXBXKl3po0F4oeRmqiSouDeTBqAsVM1NT/8qmlyX
        2fSP8uCqxXE15pCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E914213AAE;
        Mon,  1 Aug 2022 14:44:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wicROMbm52I0YAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 01 Aug 2022 14:44:22 +0000
Message-ID: <caca2088-957d-70d3-0548-7fae810ae5b5@suse.cz>
Date:   Mon, 1 Aug 2022 16:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 08/15] mm/slab_common: kmalloc_node: pass large
 requests to page allocator
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-9-42.hyeyoo@gmail.com>
 <a26f9cb0-7781-3bdc-4536-0ac06f2483b1@suse.cz> <YuflNcUsyfQjculC@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YuflNcUsyfQjculC@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/1/22 16:37, Hyeonggon Yoo wrote:
> On Thu, Jul 28, 2022 at 06:09:27PM +0200, Vlastimil Babka wrote:
>> On 7/12/22 15:39, Hyeonggon Yoo wrote:
>> > Now that kmalloc_large_node() is in common code, pass large requests
>> > to page allocator in kmalloc_node() using kmalloc_large_node().
>> > 
>> > One problem is that currently there is no tracepoint in
>> > kmalloc_large_node(). Instead of simply putting tracepoint in it,
>> > use kmalloc_large_node{,_notrace} depending on its caller to show
>> > useful address for both inlined kmalloc_node() and
>> > __kmalloc_node_track_caller() when large objects are allocated.
>> > 
>> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> 
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>
> 
> Thanks!
> 
>> Nit below:
>> 
>> > ---
>> >  v3:
>> > 	This patch is new in v3 and this avoids
>> > 	missing caller in __kmalloc_large_node_track_caller()
>> > 	when kmalloc_large_node() is called.
>> > 
>> >  include/linux/slab.h | 26 +++++++++++++++++++-------
>> >  mm/slab.h            |  2 ++
>> >  mm/slab_common.c     | 17 ++++++++++++++++-
>> >  mm/slub.c            |  2 +-
>> >  4 files changed, 38 insertions(+), 9 deletions(-)
>> > 
>> > diff --git a/include/linux/slab.h b/include/linux/slab.h
>> > index 082499306098..fd2e129fc813 100644
>> > --- a/include/linux/slab.h
>> > +++ b/include/linux/slab.h
>> > @@ -571,23 +571,35 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>> >  	return __kmalloc(size, flags);
>> >  }
>> >  
>> > +#ifndef CONFIG_SLOB
>> >  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
>> >  {
>> > -#ifndef CONFIG_SLOB
>> > -	if (__builtin_constant_p(size) &&
>> > -		size <= KMALLOC_MAX_CACHE_SIZE) {
>> > -		unsigned int i = kmalloc_index(size);
>> > +	if (__builtin_constant_p(size)) {
>> > +		unsigned int index;
>> >  
>> > -		if (!i)
>> > +		if (size > KMALLOC_MAX_CACHE_SIZE)
>> > +			return kmalloc_large_node(size, flags, node);
>> > +
>> > +		index = kmalloc_index(size);
>> > +
>> > +		if (!index)
>> >  			return ZERO_SIZE_PTR;
>> >  
>> >  		return kmem_cache_alloc_node_trace(
>> > -				kmalloc_caches[kmalloc_type(flags)][i],
>> > +				kmalloc_caches[kmalloc_type(flags)][index],
>> >  						flags, node, size);
>> >  	}
>> > -#endif
>> >  	return __kmalloc_node(size, flags, node);
>> >  }
>> > +#else
>> > +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
>> > +{
>> > +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
>> > +		return kmalloc_large_node(size, flags, node);
>> > +
>> > +	return __kmalloc_node(size, flags, node);
>> > +}
>> > +#endif
>> >  
>> >  /**
>> >   * kmalloc_array - allocate memory for an array.
>> > diff --git a/mm/slab.h b/mm/slab.h
>> > index a8d5eb1c323f..7cb51ff44f0c 100644
>> > --- a/mm/slab.h
>> > +++ b/mm/slab.h
>> > @@ -273,6 +273,8 @@ void create_kmalloc_caches(slab_flags_t);
>> >  
>> >  /* Find the kmalloc slab corresponding for a certain size */
>> >  struct kmem_cache *kmalloc_slab(size_t, gfp_t);
>> > +
>> > +void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
>> >  #endif
>> >  
>> >  gfp_t kmalloc_fix_flags(gfp_t flags);
>> > diff --git a/mm/slab_common.c b/mm/slab_common.c
>> > index 6f855587b635..dc872e0ef0fc 100644
>> > --- a/mm/slab_common.c
>> > +++ b/mm/slab_common.c
>> > @@ -956,7 +956,8 @@ void *kmalloc_large(size_t size, gfp_t flags)
>> >  }
>> >  EXPORT_SYMBOL(kmalloc_large);
>> >  
>> > -void *kmalloc_large_node(size_t size, gfp_t flags, int node)
>> > +static __always_inline
>> 
>> I don't think we need to inline, compiler should be able to make
>> kmalloc_large_node(_notrace) quite efficient anyway.
> 
> You mean s/static __always_inline/static/g, or like this?
> 
> kmalloc_large_node_notrace():
> 	fold __kmalloc_large_node_notrace() into here
> 
> kmalloc_large_node():
> 	kmalloc_large_node_notrace()
> 	trace_kmalloc()
> 
> I have no strong opinion.
> 
> IMO It's unlikely that there would be workloads that are
> meaningfully affected by inlining or not inlining __kmalloc_large_node_notrace().
> Just wanted to avoid adding even tiny of overhead by this series.

I tried the following quick change on top of your series and got (with
CONFIG_SLUB):

add/remove: 2/4 grow/shrink: 0/2 up/down: 208/-588 (-380)
Function                                     old     new   delta
__kmalloc_large_node                           -     186    +186
__kmalloc_large_node.cold                      -      22     +22
kmalloc_large_node.cold                       15       -     -15
kmalloc_large.cold                            15       -     -15
kmalloc_large_node_notrace.cold               22       -     -22
kmalloc_large                                252      87    -165
kmalloc_large_node                           271      86    -185
kmalloc_large_node_notrace                   186       -    -186
Total: Before=49398081, After=49397701, chg -0.00%


diff --git a/mm/slab.h b/mm/slab.h
index ad634e02b3cb..7b8963394144 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -274,7 +274,6 @@ void create_kmalloc_caches(slab_flags_t);
 /* Find the kmalloc slab corresponding for a certain size */
 struct kmem_cache *kmalloc_slab(size_t, gfp_t);
 
-void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
 void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 			      int node, size_t orig_size,
 			      unsigned long caller);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 0d6cbe9d7ad0..07a6bf1cff36 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -925,6 +925,7 @@ void free_large_kmalloc(struct folio *folio, void *object)
 	__free_pages(folio_page(folio, 0), order);
 }
 
+static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
 static __always_inline
 void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 {
@@ -932,7 +933,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 	void *ret;
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
-		ret = kmalloc_large_node_notrace(size, flags, node);
+		ret = __kmalloc_large_node(size, flags, node);
 		trace_kmalloc(_RET_IP_, ret,
 			      size, PAGE_SIZE << get_order(size),
 			      flags, node);
@@ -1042,8 +1043,7 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
  * know the allocation order to free the pages properly in kfree.
  */
 
-static __always_inline
-void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
+static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
 	void *ptr = NULL;
@@ -1069,7 +1069,7 @@ void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
 
 void *kmalloc_large(size_t size, gfp_t flags)
 {
-	void *ret = __kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
+	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
 
 	trace_kmalloc(_RET_IP_, ret,
 		      size, PAGE_SIZE << get_order(size),
@@ -1078,14 +1078,9 @@ void *kmalloc_large(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(kmalloc_large);
 
-void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
-{
-	return __kmalloc_large_node_notrace(size, flags, node);
-}
-
 void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
-	void *ret = __kmalloc_large_node_notrace(size, flags, node);
+	void *ret = __kmalloc_large_node(size, flags, node);
 
 	trace_kmalloc(_RET_IP_, ret,
 		      size, PAGE_SIZE << get_order(size),
