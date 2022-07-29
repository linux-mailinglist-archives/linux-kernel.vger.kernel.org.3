Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B907C584FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiG2Lr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiG2Lr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:47:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B4674787
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:47:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10BB134727;
        Fri, 29 Jul 2022 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659095244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rboBrKYOhQuJ3PgN2+0Gi74K24zaet/UD86WBExDovY=;
        b=r2vd2/MEu+HFFhXUS46Mhvw6FwtGRgr7CENAZDYHtrf8oa7jL9PIkwvZwrTR78bBPbCay8
        7vXL8LdAYjvm6KDXz5W5UJTzSFXFtBWzJCZpGfEHIOTmGeejBecuGwac5Q8RGrD7IEq2VP
        O7ngEhEVUKGQyFkXne8igDIqE6m62g4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659095244;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rboBrKYOhQuJ3PgN2+0Gi74K24zaet/UD86WBExDovY=;
        b=koK/Nh7IJh+gJR38zFrKRNTeQqcLef0cL9tzvmJOoWybAJamHn7Cpqfm+ZbhnrJ+TSN7PZ
        ixDYQAed23A5ZTBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D619013A1B;
        Fri, 29 Jul 2022 11:47:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2P+OM8vI42K3IAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Jul 2022 11:47:23 +0000
Message-ID: <35ee9435-97b4-4161-b21c-15467b56d004@suse.cz>
Date:   Fri, 29 Jul 2022 13:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 15/16] mm/slab_common: move definition of __ksize() to
 mm/slab.h
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-16-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-16-42.hyeyoo@gmail.com>
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

On 7/12/22 15:39, Hyeonggon Yoo wrote:
> __ksize() is only called by KASAN. Remove export symbol and move
> definition to mm/slab.h as we don't want to grow its callers.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit: The subject and changelog should probably say declaration, not definition.

> ---
>  include/linux/slab.h |  1 -
>  mm/slab.h            |  2 ++
>  mm/slab_common.c     | 11 +----------
>  mm/slob.c            |  1 -
>  4 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 4ee5b2fed164..701fe538650f 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -187,7 +187,6 @@ int kmem_cache_shrink(struct kmem_cache *s);
>  void * __must_check krealloc(const void *objp, size_t new_size, gfp_t flags) __alloc_size(2);
>  void kfree(const void *objp);
>  void kfree_sensitive(const void *objp);
> -size_t __ksize(const void *objp);
>  size_t ksize(const void *objp);
>  #ifdef CONFIG_PRINTK
>  bool kmem_valid_obj(void *object);
> diff --git a/mm/slab.h b/mm/slab.h
> index 9193e9c1f040..ad634e02b3cb 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -678,6 +678,8 @@ void free_large_kmalloc(struct folio *folio, void *object);
>  
>  #endif /* CONFIG_SLOB */
>  
> +size_t __ksize(const void *objp);
> +
>  static inline size_t slab_ksize(const struct kmem_cache *s)
>  {
>  #ifndef CONFIG_SLUB
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index c01c6b8f0d34..1f8db7959366 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1003,15 +1003,7 @@ void kfree(const void *object)
>  }
>  EXPORT_SYMBOL(kfree);
>  
> -/**
> - * __ksize -- Uninstrumented ksize.
> - * @objp: pointer to the object
> - *
> - * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
> - * safety checks as ksize() with KASAN instrumentation enabled.
> - *
> - * Return: size of the actual memory used by @objp in bytes
> - */
> +/* Uninstrumented ksize. Only called by KASAN. */
>  size_t __ksize(const void *object)
>  {
>  	struct folio *folio;
> @@ -1026,7 +1018,6 @@ size_t __ksize(const void *object)
>  
>  	return slab_ksize(folio_slab(folio)->slab_cache);
>  }
> -EXPORT_SYMBOL(__ksize);
>  #endif /* !CONFIG_SLOB */
>  
>  gfp_t kmalloc_fix_flags(gfp_t flags)
> diff --git a/mm/slob.c b/mm/slob.c
> index 97a4d2407f96..91d6e2b19929 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -584,7 +584,6 @@ size_t __ksize(const void *block)
>  	m = (unsigned int *)(block - align);
>  	return SLOB_UNITS(*m) * SLOB_UNIT;
>  }
> -EXPORT_SYMBOL(__ksize);
>  
>  int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
>  {

