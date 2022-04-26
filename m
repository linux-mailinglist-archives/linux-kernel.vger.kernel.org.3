Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADD65102F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352857AbiDZQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352708AbiDZQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:17:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A09D4F1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:13:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8AB41F380;
        Tue, 26 Apr 2022 16:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650989632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fepc2oLMPvkExB4fn/i4OKfIvMt6S6PP9V70SD2F7kU=;
        b=wS+JSk5j+c0FTM36Co61iaBnZ8JHEsNpqXK7cqHDhBcbQfxbF7hg3KoObU3e4Kw/pfi5ku
        3RK1CrBqiPGMKL7Ccv4q1ia0QrO1GKfT+T5ljYxvM6QqdaWhz4XyJTZgHAciI4XUvRUZVD
        xaVzQOXrIOG/rSs3ZAMiuLUflmNX/Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650989632;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fepc2oLMPvkExB4fn/i4OKfIvMt6S6PP9V70SD2F7kU=;
        b=M5mxhJCILPqO9yQAXPCFVhsXea/nT0ctWg8rt5zDpf1I0GP0hYMT00TbUR7T6u/YGPqZtS
        w33Oc+1i2mGQVrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B841B13223;
        Tue, 26 Apr 2022 16:13:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IKbVK0AaaGK0egAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 26 Apr 2022 16:13:52 +0000
Message-ID: <c6b5c7b9-0f71-fffe-c9b1-6486973a7df4@suse.cz>
Date:   Tue, 26 Apr 2022 18:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 07/23] mm/slub: move kmalloc_large_node() to
 slab_common.c
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
 <20220414085727.643099-8-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220414085727.643099-8-42.hyeyoo@gmail.com>
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
> In later patch SLAB will also pass requests larger than order-1 page
> to page allocator. Move kmalloc_large_node() to slab_common.c.
> 
> Fold kmalloc_large_node_hook() into kmalloc_large_node() as there is
> no other caller.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/slab.h |  3 +++
>  mm/slab_common.c     | 22 ++++++++++++++++++++++
>  mm/slub.c            | 25 -------------------------
>  3 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 6f6e22959b39..97336acbebbf 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -486,6 +486,9 @@ static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, g
>  
>  extern void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
>  						     __alloc_size(1);
> +
> +extern void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> +				__assume_page_alignment __alloc_size(1);

The usual :)

