Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0044C1B10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbiBWSkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbiBWSkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:40:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505384A3F4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:39:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E43581F44C;
        Wed, 23 Feb 2022 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645641582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlJpzM5pIlT2qJDNths/PTMX9nYQ4QyiwW04BJRqenY=;
        b=03tUfnH6xOTOv9/1UkiE4wsOoRj8vW9TGuVgCyHfU10ZHvX/zUCtN6MEuZmR9MhMg2OpYp
        d+tgnopZRNe4TVuKs/fMAjNvJfM/vt8kBcIT8TJdKldh0OZQU5Gj1v74yESKUJ+g5K9Fjs
        ZsNx9LIf7QMt3aZ+b9fK0SPxUv0/NRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645641582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlJpzM5pIlT2qJDNths/PTMX9nYQ4QyiwW04BJRqenY=;
        b=B+2ot9fajn9mhqEj7n4Hw7M9m5+f4z1I8C2J2zlBP+wV9bSO8450qUcpOxp/lbIY66TOal
        IbL0/ZdRA4d03uCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5D9213C98;
        Wed, 23 Feb 2022 18:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wyOWK25/FmJZPgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Feb 2022 18:39:42 +0000
Message-ID: <4d42fcec-ff59-2e37-4d8f-a58e641d03c8@suse.cz>
Date:   Wed, 23 Feb 2022 19:39:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-2-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/5] mm/sl[au]b: Unify __ksize()
In-Reply-To: <20220221105336.522086-2-42.hyeyoo@gmail.com>
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

On 2/21/22 11:53, Hyeonggon Yoo wrote:
> Only SLOB need to implement __ksize() separately because SLOB records
> size in object header for kmalloc objects. Unify SLAB/SLUB's __ksize().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slab.c        | 23 -----------------------
>  mm/slab_common.c | 29 +++++++++++++++++++++++++++++
>  mm/slub.c        | 16 ----------------
>  3 files changed, 29 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index ddf5737c63d9..eb73d2499480 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -4199,27 +4199,4 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  }
>  #endif /* CONFIG_HARDENED_USERCOPY */
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
> -size_t __ksize(const void *objp)
> -{
> -	struct kmem_cache *c;
> -	size_t size;
>  
> -	BUG_ON(!objp);
> -	if (unlikely(objp == ZERO_SIZE_PTR))
> -		return 0;
> -
> -	c = virt_to_cache(objp);
> -	size = c ? c->object_size : 0;

This comes from commit a64b53780ec3 ("mm/slab: sanity-check page type when
looking up cache") by Kees and virt_to_cache() is an implicit check for
folio slab flag ...

> -
> -	return size;
> -}
> -EXPORT_SYMBOL(__ksize);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 23f2ab0713b7..488997db0d97 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1245,6 +1245,35 @@ void kfree_sensitive(const void *p)
>  }
>  EXPORT_SYMBOL(kfree_sensitive);
>  
> +#ifndef CONFIG_SLOB
> +/**
> + * __ksize -- Uninstrumented ksize.
> + * @objp: pointer to the object
> + *
> + * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
> + * safety checks as ksize() with KASAN instrumentation enabled.
> + *
> + * Return: size of the actual memory used by @objp in bytes
> + */
> +size_t __ksize(const void *object)
> +{
> +	struct folio *folio;
> +
> +	if (unlikely(object == ZERO_SIZE_PTR))
> +		return 0;
> +
> +	folio = virt_to_folio(object);
> +
> +#ifdef CONFIG_SLUB
> +	if (unlikely(!folio_test_slab(folio)))
> +		return folio_size(folio);
> +#endif
> +
> +	return slab_ksize(folio_slab(folio)->slab_cache);

... and here in the common version you now for SLAB trust that the folio
will be a slab folio, thus undoing the intention of that commit. Maybe
that's not good and we should keep the folio_test_slab() for both cases?
Although maybe it's also strange that prior this patch, SLAB would return 0
if the test fails, and SLUB would return folio_size(). Probably because with
SLUB this can be a large kmalloc here and with SLAB not. So we could keep
doing that in the unified version, or KASAN devs (CC'd) could advise
something better?

> +}
> +EXPORT_SYMBOL(__ksize);
> +#endif
> +
>  /**
>   * ksize - get the actual amount of memory allocated for a given object
>   * @objp: Pointer to the object
> diff --git a/mm/slub.c b/mm/slub.c
> index 261474092e43..3a4458976ab7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4526,22 +4526,6 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  }
>  #endif /* CONFIG_HARDENED_USERCOPY */
>  
> -size_t __ksize(const void *object)
> -{
> -	struct folio *folio;
> -
> -	if (unlikely(object == ZERO_SIZE_PTR))
> -		return 0;
> -
> -	folio = virt_to_folio(object);
> -
> -	if (unlikely(!folio_test_slab(folio)))
> -		return folio_size(folio);
> -
> -	return slab_ksize(folio_slab(folio)->slab_cache);
> -}
> -EXPORT_SYMBOL(__ksize);
> -
>  void kfree(const void *x)
>  {
>  	struct folio *folio;

