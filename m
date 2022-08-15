Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE70D592F45
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbiHONAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbiHONAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:00:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB68B120A2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:00:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 513EF20AA9;
        Mon, 15 Aug 2022 12:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660568399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmjHXEGWukk1QpHwgkzRniVDwmGGZ1kBPl/lBbGNIuI=;
        b=a2g25pzBylbpfiz81kB+cXLICQk0MYQCVM7PeTNnxmV8izWTGfVJg8jZxXgoTOcnQSNV8t
        zL7W8eR3GU12HwCStp2qEiD5NphqNaDKB9rV3lu1WkvG1I503wh84j3UKdmyJPMngItYLv
        zGdMvLOUuP5b6WZ2RqJzv8fwEw+E+Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660568399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmjHXEGWukk1QpHwgkzRniVDwmGGZ1kBPl/lBbGNIuI=;
        b=w30LhAOoGagCMWNQR5Up0sx/268MMtS4UCU5tm3Chpr3CMwjk+Nun7iYt4yK7VfVr2hHI+
        4SsnNExv8HP1a7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BEB413A99;
        Mon, 15 Aug 2022 12:59:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cRALH05D+mJ/OQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 15 Aug 2022 12:59:58 +0000
Message-ID: <06315f39-e246-7427-b342-5c0a16d871af@suse.cz>
Date:   Mon, 15 Aug 2022 14:59:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 00/15] common kmalloc v3
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
 <e77f9820-c818-d7af-185b-b8814313048b@suse.cz> <YvjJKeiwMAg+7/Q5@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YvjJKeiwMAg+7/Q5@hyeyoo>
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

On 8/14/22 12:06, Hyeonggon Yoo wrote:
> On Fri, Jul 29, 2022 at 05:08:31PM +0200, Vlastimil Babka wrote:
>> On 7/12/22 15:39, Hyeonggon Yoo wrote:
>>> This is v3 of common kmalloc series.
>>>
>>> This series generalize most of kmalloc functions and move its
>>> implementation into mm/slab_common.c.
>>>
>>> I believe this series give better maintainability of code for SLAB and SLUB.
>>> Please consider applying.
>>>
>>> This series is based on slab/for-next and also available at
>>> https://github.com/hygoni/linux/tree/slab-common-v3r0
>>>
>>> Any feedbacks/reviews will be appreciated.
>>
>> Hi, thanks for all your efforts. It's shaping up nicely so I think the next
>> version will be ready to be added to -next after the 5.20 merge window.
>> As I've finished the individual reviews, I'm looking at the result and see a
>> bit more potential for cleanups, which could be perhaps incorporated to
>> existing patches, or additionally:
> 
> Thank you for reviews and I too would like to add it to -next soon!
> 
>>
>> - kmalloc_large_node_notrace() has only one caller, can be removed and the
>> caller can call __kmalloc_large_node_notrace() directly, especially if it's
>> not __always_inline as I've IIRC suggested.
> 
> Will adjust in next version.
> 
>> - kmem_cache_alloc_trace() and kmem_cache_alloc_node_trace() are weird ones,
>> they are in fact for kmalloc despite the name.
> 
> Yeah, I'm the one that would like to rename it to kmalloc_trace() and
> kmalloc_node_trace().
> 
>> They depend on
>> CONFIG_TRACING, yet if you look carefully, the !CONFIG_TRACING variant also
>> goes through a trace_* function. The actual difference seems that
>> slab_alloc() thus kasan_alloc() and kfence_alloc() don't get the orig_size
>> that way, which is dubious. It might be worth trying to unify this as well?
>> E.g.
>>   - use only the CONFIG_TRACING variant, discard the other
> 
> Sounds okay.
> 
>>   - declare it in mm/slab.h, this is not for general usage
> 
> We can't completely remove it because its needed in include/linux/slab.h
> for inlined kmalloc.

Ah, ok.

>>   - single implementation in mm/slab_common.c that calls
>>     __kmem_cache_alloc_node() from SLAB/SLUB and does the trace
> 
> While I love the idea of single implementation in mm/slab_common.c,
> making use of __kmem_cache_alloc_node() and __kmem_cache_free() adds
> a bit of overhead:
> 	it adds overhead of function call and can't benefit from inlining
> 	(including removing unnnecessary part of function code) 

Hm, right.

> So... what about including slab_common.c in sl?b.c,
> so that compiler can treat sl?b.c and slab_common.c as a single translation unit?
> (or split kmalloc implementation into kmalloc.c and do similar thing?)

I don't know if that has a good precedent in the kernel. Maybe we can
postpone these more radical attempts to a later series.
