Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A889510280
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352789AbiDZQFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbiDZQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:05:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2EF42EE7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:02:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8897A1F388;
        Tue, 26 Apr 2022 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650988938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhUCnfLaLVR3gKOvJDs3VsH1Owqoy0EyHHUnNelrzz8=;
        b=FUeN2KN3Y4LRX09Snuy+dqHQLQ7yIRxsLMnO5Xbopwj20SsLx+EyN00Oq6CsX/hOrTPlWQ
        RKhhw5M4zO/Y2IqILzvDiqRTeuCQ0jj154pY4kuSNmzXXzWrk5Tej1UZlDMCECF/Bo48kI
        D9Bz39BV7K3LNRhIEpkcrNg1rOGUWRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650988938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhUCnfLaLVR3gKOvJDs3VsH1Owqoy0EyHHUnNelrzz8=;
        b=Ztj4sEhh40VCp+3uJZbgUl8r3xxZ1oZvtgm3dkbgOWZ2UL5dSgmcWVHtmMEp7dCcxaOspJ
        o3HFSBNnOVPlYfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E57013223;
        Tue, 26 Apr 2022 16:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X2dWFooXaGIBdgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 26 Apr 2022 16:02:18 +0000
Message-ID: <768d4216-232e-6c67-b395-83c2f34c7970@suse.cz>
Date:   Tue, 26 Apr 2022 18:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 05/23] mm/slab_common: cleanup __kmalloc()
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
 <20220414085727.643099-6-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220414085727.643099-6-42.hyeyoo@gmail.com>
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
> Make __kmalloc() wrapper of __kmalloc_node().

Again/similarly, looks like this will make SLUB not miss trace for
kmalloc_large() anymore.

> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> ---
>  include/linux/slab.h | 13 ++++++++++---
>  mm/slab.c            | 34 ----------------------------------
>  mm/slob.c            |  6 ------
>  mm/slub.c            | 23 -----------------------
>  4 files changed, 10 insertions(+), 66 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index acdb4b7428f9..4c06d15f731c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -419,7 +419,16 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>  #define kmalloc_index(s) __kmalloc_index(s, true)
>  #endif /* !CONFIG_SLOB */
>  
> -void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
> +extern void *__kmalloc_node(size_t size, gfp_t flags, int node)
> +			    __assume_kmalloc_alignment
> +			    __alloc_size(1);
> +

Again, no 'extern' please.

> +static __always_inline __alloc_size(1) __assume_kmalloc_alignment
> +void *__kmalloc(size_t size, gfp_t flags)
> +{
> +	return __kmalloc_node(size, flags, NUMA_NO_NODE);
> +}
> +
>  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
>  void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  			   gfp_t gfpflags) __assume_slab_alignment __malloc;
