Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F654F486
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381358AbiFQJk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381381AbiFQJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:40:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED77694B0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:40:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DDDB1FDB3;
        Fri, 17 Jun 2022 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655458851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6oZdEy+pMmRbF2FnRey4yeqXKc7iEyAzOEBd1mwvi4=;
        b=3PFMlJM48WT3dfPf0TJazaVtkSGer9hM5vVyK7ujKtV0kUG86LAit5b+pbc3rHZ3BFVL+F
        8WTQn11/CBfdRG6pvSUHjP1IlRe/4evIoovkF/p2aI43/UZUf23wDjFaqmp7C0zxrPu/4k
        bQbY9qQZKVM//GPWj/Ohe/1Fyh7Bz6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655458851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6oZdEy+pMmRbF2FnRey4yeqXKc7iEyAzOEBd1mwvi4=;
        b=2OzJOJtwXFrdjf+AhktrgIA0wre7xOEAJUCRE69uHcCe4zUedgRiPafbYkydxzO4w62T5L
        TDDhGYRdM7bCTgAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7780213458;
        Fri, 17 Jun 2022 09:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YdGZHCNMrGLoNQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 17 Jun 2022 09:40:51 +0000
Message-ID: <faf416b9-f46c-8534-7fb7-557c046a564d@suse.cz>
Date:   Fri, 17 Jun 2022 11:40:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.de>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com>
 <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
 <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de>
 <29723aaa-5e28-51d3-7f87-9edf0f7b9c33@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206081417370.465021@gentwo.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <alpine.DEB.2.22.394.2206081417370.465021@gentwo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 14:23, Christoph Lameter wrote:
> On Wed, 8 Jun 2022, Rongwei Wang wrote:
> 
>> If available, I think document the issue and warn this incorrect behavior is
>> OK. But it still prints a large amount of confusing messages, and disturbs us?
> 
> Correct it would be great if you could fix this in a way that does not
> impact performance.
> 
>> > are current operations on the slab being validated.
>> And I am trying to fix it in following way. In a short, these changes only
>> works under the slub debug mode, and not affects the normal mode (I'm not
>> sure). It looks not elegant enough. And if all approve of this way, I can
>> submit the next version.
> 
> 
>>
>> Anyway, thanks for your time:).
>> -wrw
>>
>> @@ -3304,7 +3300,7 @@ static void __slab_free(struct kmem_cache *s,
> struct
>> slab *slab,
>>
>>  {
>>         void *prior;
>> -       int was_frozen;
>> +       int was_frozen, to_take_off = 0;
>>         struct slab new;
> 
> to_take_off has the role of !n ? Why is that needed?
> 
>> -       do {
>> -               if (unlikely(n)) {
>> +               spin_lock_irqsave(&n->list_lock, flags);
>> +               ret = free_debug_processing(s, slab, head, tail, cnt, addr);
> 
> Ok so the idea is to take the lock only if kmem_cache_debug. That looks
> ok. But it still adds a number of new branches etc to the free loop.

It also further complicates the already tricky code. I wonder if we should
make more benefit from the fact that for kmem_cache_debug() caches we don't
leave any slabs on percpu or percpu partial lists, and also in
free_debug_processing() we aready take both list_lock and slab_lock. If we
just did the freeing immediately there under those locks, we would be
protected against other freeing cpus by that list_lock and don't need the
double cmpxchg tricks.

What about against allocating cpus? More tricky as those will currently end
up privatizing the freelist via get_partial(), only to deactivate it again,
so our list_lock+slab_lock in freeing path would not protect in the
meanwhile. But the allocation is currently very inefficient for debug
caches, as in get_partial() it will take the list_lock to take the slab from
partial list and then in most cases again in deactivate_slab() to return it.

If instead the allocation path for kmem_cache_debug() cache would take a
single object from the partial list (not whole freelist) under list_lock, it
would be ultimately more efficient, and protect against freeing using
list_lock. Sounds like an idea worth trying to me?
And of course we would stop creating the 'validate' sysfs files for
non-debug caches.
