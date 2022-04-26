Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918DD51062F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbiDZSEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351377AbiDZSEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:04:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C7326552
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:01:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 713D1210EB;
        Tue, 26 Apr 2022 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650996088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTSORWGz8J6dnEZvGImyN3IE4KOw6ycpeMrWZ/JcCCg=;
        b=SzWNWpSlz0P/AZL437kbv/wvBsjXV8zfBmUCUwU/aeZfdyKbfygez9tkUtfhoVmKUpKrET
        qQcLkoVSPf6lVU2Oj5pj8zycXPmh2ZVOS5DFcZNZKibWG4ZX1EEO4E5po3PytPqQc4O869
        KmJ6QgsDhm6j+G4QNhEmhHBNx7cWKuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650996088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTSORWGz8J6dnEZvGImyN3IE4KOw6ycpeMrWZ/JcCCg=;
        b=3ywhU3yqUIV9CESUJD11SCSgzaU0QootSDHl2EeCEYASLxda5aS3/YVl9bMmSc/GdbW6Mn
        Uwao4S972zuhuCDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4711913AD5;
        Tue, 26 Apr 2022 18:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3V+/EHgzaGJkJgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 26 Apr 2022 18:01:28 +0000
Message-ID: <228411f0-96b9-60b4-b734-444ea39a354b@suse.cz>
Date:   Tue, 26 Apr 2022 20:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-11-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 10/23] mm/slab_common: cleanup
 kmem_cache_alloc{,node,lru}
In-Reply-To: <20220414085727.643099-11-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 10:57, Hyeonggon Yoo wrote:
> Implement only __kmem_cache_alloc_node() in slab allocators and make
> kmem_cache_alloc{,node,lru} wrapper of it.
> 
> Now that kmem_cache_alloc{,node,lru} is inline function, we should
> use _THIS_IP_ instead of _RET_IP_ for consistency.

Hm yeah looks like this actually fixes some damage of obscured actual
__RET_IP_ by the recent addition and wrapping of __kmem_cache_alloc_lru().

> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits:

> ---
>  include/linux/slab.h | 52 ++++++++++++++++++++++++++++++++-----
>  mm/slab.c            | 61 +++++---------------------------------------
>  mm/slob.c            | 27 ++++++--------------
>  mm/slub.c            | 35 +++++--------------------
>  4 files changed, 67 insertions(+), 108 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 143830f57a7f..1b5bdcb0fd31 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -429,9 +429,52 @@ void *__kmalloc(size_t size, gfp_t flags)
>  	return __kmalloc_node(size, flags, NUMA_NO_NODE);
>  }
>  
> -void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
> -void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> -			   gfp_t gfpflags) __assume_slab_alignment __malloc;
> +
> +void *__kmem_cache_alloc_node(struct kmem_cache *s, struct list_lru *lru,
> +			   gfp_t gfpflags, int node, unsigned long caller __maybe_unused)
> +			    __assume_slab_alignment __malloc;

I don't think caller needs to be __maybe_unused in the declaration nor any
of the implementations of __kmem_cache_alloc_node(), all actually pass it on?
