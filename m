Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAED95879E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiHBJdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiHBJco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:32:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7821439BAC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:32:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2AB6520339;
        Tue,  2 Aug 2022 09:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659432762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZlMiDMauGITlK4Cag6n1I3xWbH99VdUcpWvKpgoPLcs=;
        b=tUhiJwocCojWSInY6pDE6YYe9SXQpwAY1MB7wqsjEpyDPxQQ2MA5iOGhqIK1Tk8bH3pUrz
        KubdGY9zVTHL6OazqfGfhvyjve91eHl0JmCqiVY1ro7wK7A3yryGSoItA1VuciYs1DEiMR
        gtTPPevJ4+hgEAzzR7cePB/5d0kvJU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659432762;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZlMiDMauGITlK4Cag6n1I3xWbH99VdUcpWvKpgoPLcs=;
        b=k5aX033Tw7r9QmukvIlIP9h6hZfjtmYgaWRH2vbqk6MM7ck3CZv2idwLUCXNXX8qdg+yJn
        127lMHDOSBbAoBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBC9D13A8E;
        Tue,  2 Aug 2022 09:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wvOvODnv6GJYawAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 02 Aug 2022 09:32:41 +0000
Message-ID: <321b8b3e-9d06-b01c-d871-1f7ca35ce91e@suse.cz>
Date:   Tue, 2 Aug 2022 11:32:41 +0200
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
 <caca2088-957d-70d3-0548-7fae810ae5b5@suse.cz> <Yujnihj5YVPP2LjA@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yujnihj5YVPP2LjA@hyeyoo>
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

On 8/2/22 10:59, Hyeonggon Yoo wrote:
> On Mon, Aug 01, 2022 at 04:44:22PM +0200, Vlastimil Babka wrote:
>> 
> 
> Yeah, uninlining __kmalloc_large_node saves hundreds of bytes.
> And the diff below looks good to me.
> 
> By The Way, do you have opinions on inlining slab_alloc_node()?
> (Looks like similar topic?)
> 
> AFAIK slab_alloc_node() is inlined in:
>         kmem_cache_alloc()
>         kmem_cache_alloc_node()
>         kmem_cache_alloc_lru()
>         kmem_cache_alloc_trace()
>         kmem_cache_alloc_node_trace()
>         __kmem_cache_alloc_node()
> 
> This is what I get after simply dropping __always_inline in slab_alloc_node:
> 
> add/remove: 1/1 grow/shrink: 3/6 up/down: 1911/-5275 (-3364)
> Function                                     old     new   delta
> slab_alloc_node                                -    1356   +1356
> sysfs_slab_alias                             134     327    +193
> slab_memory_callback                         528     717    +189
> __kmem_cache_create                         1325    1498    +173
> __slab_alloc.constprop                       135       -    -135
> kmem_cache_alloc_trace                       909     196    -713
> kmem_cache_alloc                             937     191    -746
> kmem_cache_alloc_node_trace                 1020     200    -820
> __kmem_cache_alloc_node                      862      19    -843
> kmem_cache_alloc_node                       1046     189    -857
> kmem_cache_alloc_lru                        1348     187   -1161
> Total: Before=32011183, After=32007819, chg -0.01%
> 
> So 3.28kB is cost of eliminating function call overhead in the 
> fastpath.
> 
> This is tradeoff between function call overhead and
> instruction cache usage...

We can investigate this aftewards, with proper measurements etc. I think
it's more sensitive than kmalloc_large_node.
