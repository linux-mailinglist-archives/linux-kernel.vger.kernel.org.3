Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F2B4E67B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352233AbiCXRYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240571AbiCXRY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:24:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0228F986F6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:22:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98A27215FD;
        Thu, 24 Mar 2022 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648142574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGT7Uj6/EhveXkVwghH4LYAenDJ1TyPCjNeutemup5s=;
        b=HQzImj5RZ4tBMpz4HqGSXrKSVTkS8nHvI8XO2MB65609assGuxUYVPCz40M5Ovk6NmFook
        U7dCxBVS6jWjhhVnfy4ZOSgnDkAqYx5eUl8ZDiJmHxBpVVoqbjqMY8hGmt5dFVh0di7vLQ
        t9nJfu2lAjAJONY+ukZ77nhKETGTJgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648142574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGT7Uj6/EhveXkVwghH4LYAenDJ1TyPCjNeutemup5s=;
        b=bKV0Fwya9p1PnCxvArPKuyctqOZ/8wV6lwKLs9LYMyshmhW6dcNJ7B5XzmFqQAohBIGslL
        vV3f2Jo3Xa4KdjBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 674EC13A7F;
        Thu, 24 Mar 2022 17:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EqBvGO6oPGLaWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Mar 2022 17:22:54 +0000
Message-ID: <f93b5d12-d30c-84dd-3ef4-9e21f9f8cf0c@suse.cz>
Date:   Thu, 24 Mar 2022 18:22:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v1 05/15] mm/slub: move kmalloc_large_node() to
 slab_common.c
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
 <20220308114142.1744229-6-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220308114142.1744229-6-42.hyeyoo@gmail.com>
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
> In later patch SLAB will also pass requests larger than order-1 page
> to page allocator. Move kmalloc_large_node() to slab_common.c.
> 
> Fold kmalloc_large_node_hook() into kmalloc_large_node() as there is
> no other caller.
> 
> Move tracepoint in kmalloc_large_node().
> 
> Add flag fix code. This exist in kmalloc_large() but omitted in
> kmalloc_large_node().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  include/linux/slab.h |  3 +++
>  mm/slab_common.c     | 26 ++++++++++++++++++++++++
>  mm/slub.c            | 47 ++++----------------------------------------
>  3 files changed, 33 insertions(+), 43 deletions(-)
> 

<snip>

>  
> @@ -4874,15 +4842,8 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
>  	struct kmem_cache *s;
>  	void *ret;
>  
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> -		ret = kmalloc_large_node(size, gfpflags, node);
> -
> -		trace_kmalloc_node(caller, ret,
> -				   size, PAGE_SIZE << get_order(size),
> -				   gfpflags, node);

Hmm this throws away the caller for tracing, so looks like an unintended
functional change.

> -
> -		return ret;
> -	}
> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> +		return kmalloc_large_node(size, gfpflags, node);
>  
>  	s = kmalloc_slab(size, gfpflags);
>  

