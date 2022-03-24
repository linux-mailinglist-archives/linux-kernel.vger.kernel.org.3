Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941C94E680D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352397AbiCXRsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbiCXRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:48:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F621B2471
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:46:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C36C6210FD;
        Thu, 24 Mar 2022 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648143994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nXfRRkwI9pT0Egb62KVCQmh30ZwxB4Oif8GwM6IzOI=;
        b=1xY/vL7oKZJ+V+m8eO34xNsjEY+2nmP4fLYXPTjyZO5igZctxEsQthD6YKhOoQ3h1rUeX0
        1zZDjtdUv3hBxsdzuenuKtLvcw+LPtlhLUhhI7vLMkkUeeo/dNs9r8hOHV0c5QE8SzG84F
        UpWWwitpMlnwJIJccgHs/Js7txlccFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648143994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nXfRRkwI9pT0Egb62KVCQmh30ZwxB4Oif8GwM6IzOI=;
        b=NIdmExCsToRsefI4UqAAIkxFSFt8oQw61dY77oFrCiMiWbtMf827G30ATuFseMm/EksI4t
        if+twqt1wnpWsCCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BF0F13A7F;
        Thu, 24 Mar 2022 17:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xoteJXquPGKhYgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Mar 2022 17:46:34 +0000
Message-ID: <d35ce303-c72d-2c7f-8785-4aee7237d05e@suse.cz>
Date:   Thu, 24 Mar 2022 18:46:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v1 08/15] mm/sl[auo]b: cleanup kmalloc()
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
 <20220308114142.1744229-9-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220308114142.1744229-9-42.hyeyoo@gmail.com>
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
> Now that kmalloc() and kmalloc_node() do same job, make kmalloc()
> wrapper of kmalloc_node().
> 
> Remove kmalloc_trace() that is now unused. This patch makes slab
> allocator use kmalloc_node tracepoints in kmalloc().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Actually there are more things to fix than the commit log.

> +#ifndef CONFIG_SLOB
> +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	if (__builtin_constant_p(size)) {
> +		unsigned int index;
> +
> +		if (size > KMALLOC_MAX_CACHE_SIZE)
> +			return kmalloc_large(size, flags);

Should use kmalloc_large_node().

> +
> +		index = kmalloc_index(size);
> +
> +		if (!index)
> +			return ZERO_SIZE_PTR;
> +
> +		return kmem_cache_alloc_node_trace(
> +				kmalloc_caches[kmalloc_type(flags)][index],
> +						flags, node, size);
> +	}
> +	return __kmalloc_node(size, flags, node);
> +}
> +#else
> +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> +		return kmalloc_large(size, flags);

And here.

> +
> +	return __kmalloc_node(size, flags, node);
> +}
> +#endif
