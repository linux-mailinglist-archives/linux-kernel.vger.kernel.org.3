Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970FF58284D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiG0OMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiG0OMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:12:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46AD22B22
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:12:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5268038923;
        Wed, 27 Jul 2022 14:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658931166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H98ZbyL+yCoBqBhV71DiorzBZIV17eeA3gst4o8mrk=;
        b=bgQoHYCprpaw4pMJP0e2jDu5EvkOWB9a3HmUBXACljqsjBUt87bFlkE5Yse6iYZgKl9lQ6
        cXQWtvVALZgXOgqbJbTWhboHpJ/pnW60pln1Ll4o0fhJETEDrSrObo7htBWJyCFSZahO+R
        wirE0MwPArcMHgxaNm8Hl17qgAgc20k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658931166;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H98ZbyL+yCoBqBhV71DiorzBZIV17eeA3gst4o8mrk=;
        b=7+xTh6q4y3M/AUe0+yTtSDDSrDHYe+YQx05ty09JeTaV3FhChgTM05wqgkG3pFsiDqkd1y
        ZfaEKuYkkTD+UJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2377313A8E;
        Wed, 27 Jul 2022 14:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MbwLCN5H4WImTgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 27 Jul 2022 14:12:46 +0000
Message-ID: <071e9a19-4aa8-e6c5-2e50-d59e60dca3e2@suse.cz>
Date:   Wed, 27 Jul 2022 16:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] mm/slub: enable debugging memory wasting of
 kmalloc
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.de>, Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220727071042.8796-1-feng.tang@intel.com>
 <20220727071042.8796-2-feng.tang@intel.com>
 <alpine.DEB.2.22.394.2207271214570.1205438@gentwo.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <alpine.DEB.2.22.394.2207271214570.1205438@gentwo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 12:20, Christoph Lameter wrote:
> On Wed, 27 Jul 2022, Feng Tang wrote:
> 
>> @@ -2905,7 +2950,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
>>   * already disabled (which is the case for bulk allocation).
>>   */
>>  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>> -			  unsigned long addr, struct kmem_cache_cpu *c)
>> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>>  {
>>  	void *freelist;
>>  	struct slab *slab;
>> @@ -3102,7 +3147,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   * pointer.
>>   */
>>  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>> -			  unsigned long addr, struct kmem_cache_cpu *c)
>> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>>  {
>>  	void *p;
>>
>> @@ -3115,7 +3160,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>  	c = slub_get_cpu_ptr(s->cpu_slab);
>>  #endif
>>
>> -	p = ___slab_alloc(s, gfpflags, node, addr, c);
>> +	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
>>  #ifdef CONFIG_PREEMPT_COUNT
>>  	slub_put_cpu_ptr(s->cpu_slab);
> 
> This is modifying and making execution of standard slab functions more
> expensive. Could you restrict modifications to the kmalloc subsystem?
> 
> kmem_cache_alloc() and friends are not doing any rounding up to power of
> two  sizes.
> 
> What is happening here is that you pass kmalloc object size info through
> the kmem_cache_alloc functions so that the regular allocation functions
> debug functionality can then save the kmalloc specific object request
> size. This is active even when no debugging options are enabled.

I don't think the extra orig_size parameter (unused for non-debug caches)
adds any noticeable overhead. In slab_alloc_node() we already have the
orig_size parameter (for both kmalloc and non-kmalloc caches) before this
patch, and it remains unused in the cmpxchg based fast path. The patch adds
it to __slab_alloc() which is not the fast path, and it's still unused for
non-debug caches there. So the overhead is basically one less register
available (because of the extra param) in a slow path and that should be
immeasurable.

> Can you avoid that? Have kmalloc do the object allocation without passing
> through the kmalloc request size and then add the original size info
> to the debug field later after execution continues in the kmalloc functions?

That approach is problematic wrt patches 2+3 if we want to use orig_size to
affect the boundaries of zero-init and redzoning.
Also it goes against the attempt to fix races wrt validation, see [1] where
the idea is to have alloc_debug_processing() including redzoning done under
n->list_lock and for that should have orig_size passed there as well.

[1] https://lore.kernel.org/all/69462916-2d1c-dd50-2e64-b31c2b61690e@suse.cz/
