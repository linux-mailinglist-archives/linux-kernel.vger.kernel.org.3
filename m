Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7DB4E67E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiCXRia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbiCXRi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:38:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF8FA996F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:36:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B468B1F38D;
        Thu, 24 Mar 2022 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648143415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZ+osao9kQ8YgBCBxHKZy0cRJWbFLf+edwLF/UPDRl4=;
        b=dE8bjG03OZ633klntJoYmdbH4LvEPQCMkxYLJG3vjW3J43m1LVqf9MJxUrQWSsM2U8WkPv
        XrHa3gZ1rfdp2oE+msiZP7G90t3spRLyKIwIgbPIbqgT54wuRISKbN5rZE1ejuLrecubV9
        Vgy47tAzo9GpFLY8+BiBRePxmdRquxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648143415;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZ+osao9kQ8YgBCBxHKZy0cRJWbFLf+edwLF/UPDRl4=;
        b=h1a9tOzxrVkQF2BZ/+zFHQ2qnslcBAkIhDhyaa8CQh2tJMON+2SFohj2FiA1NInRqy4tYK
        TQbb7FYLZ8WXBXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FF7513A7F;
        Thu, 24 Mar 2022 17:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id atyfIjesPGLiXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Mar 2022 17:36:55 +0000
Message-ID: <e8225962-6f09-508a-685a-6bae240c46c2@suse.cz>
Date:   Thu, 24 Mar 2022 18:36:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v1 07/15] mm/sl[au]b: kmalloc_node: pass large
 requests to page allocator
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
 <20220308114142.1744229-8-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220308114142.1744229-8-42.hyeyoo@gmail.com>
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

On 3/8/22 12:41, Hyeonggon Yoo wrote:
> Now that kmalloc_large_node() is in common code, pass large requests
> to page allocator in kmalloc_node() using kmalloc_large_node().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/slab.h | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 8840b2d55567..33d4260bce8b 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -551,23 +551,35 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  	return __kmalloc(size, flags);
>  }
>  
> +#ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
>  {
> -#ifndef CONFIG_SLOB
> -	if (__builtin_constant_p(size) &&
> -		size <= KMALLOC_MAX_CACHE_SIZE) {
> -		unsigned int i = kmalloc_index(size);
> +	if (__builtin_constant_p(size)) {
> +		unsigned int index;
>  
> -		if (!i)
> +		if (size > KMALLOC_MAX_CACHE_SIZE)
> +			return kmalloc_large_node(size, flags, node);
> +
> +		index = kmalloc_index(size);
> +
> +		if (!index)
>  			return ZERO_SIZE_PTR;
>  
>  		return kmem_cache_alloc_node_trace(
>  				kmalloc_caches[kmalloc_type(flags)][i],
>  						flags, node, size);
>  	}
> -#endif
>  	return __kmalloc_node(size, flags, node);
>  }
> +#else
> +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> +		return kmalloc_large_node(size, flags, node);
> +
> +	return __kmalloc_node(size, flags, node);
> +}
> +#endif
>  
>  /**
>   * kmalloc_array - allocate memory for an array.

