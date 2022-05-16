Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1E052930F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349442AbiEPVms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbiEPVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:42:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E68F41FAC
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:42:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D8741F92F;
        Mon, 16 May 2022 21:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652737362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HovTC6FiGf3ja40F9c2fQ83eYmm4tQXXZRRsLYbnnew=;
        b=C4uCBBXfemb8MP3PaJvLlMu9yHsXfZqNCeK0/wzvpjZNdf6aNz5aWaRHx0KH4pl4kueyrB
        FJGLewWXchFIshCwRnNFYpncf2B63+m1+M3wbEGERstAdf37CLhR/B6chyUuSRAhyXfDZR
        uzcaEocfzBK/NNpFy9C8jpi5Q5KkWpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652737362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HovTC6FiGf3ja40F9c2fQ83eYmm4tQXXZRRsLYbnnew=;
        b=6x2VDOQWPLaOaelqHEiu5a2K30qWoyibm1xQOrvQu2BG7G0HPFg7eFDozfYY3bXC2VEcxw
        vwDcUi/pKd3NTMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 189A113AAB;
        Mon, 16 May 2022 21:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6GyHBFLFgmIBOwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 16 May 2022 21:42:42 +0000
Message-ID: <8eccb3bc-e6b1-354b-e1de-bd3d896dcb35@suse.cz>
Date:   Mon, 16 May 2022 23:41:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] tracing: add ACCOUNT flag for allocations from marked
 slab caches
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>, Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, kernel@openvz.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <1fd21e25-b095-e055-fc2e-abda640a0575@openvz.org>
 <CALvZod6wmxxigoLVg8Q+upqOkyoh+nPuVT0yx_XTbu8RXYYFgA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CALvZod6wmxxigoLVg8Q+upqOkyoh+nPuVT0yx_XTbu8RXYYFgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 21:10, Shakeel Butt wrote:
> On Mon, May 16, 2022 at 11:53 AM Vasily Averin <vvs@openvz.org> wrote:
>>
>> Slab caches marked with SLAB_ACCOUNT force accounting for every
>> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
>> Unfortunately, at the moment this flag is not visible in ftrace output,
>> and this makes it difficult to analyze the accounted allocations.
>>
>> This patch adds the __GFP_ACCOUNT flag for allocations from slab caches
>> marked with SLAB_ACCOUNT to the ftrace output.
>>
>> Signed-off-by: Vasily Averin <vvs@openvz.org>
>> ---
>>  mm/slab.c | 3 +++
>>  mm/slub.c | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/mm/slab.c b/mm/slab.c
>> index 0edb474edef1..4c3da8dfcbdb 100644
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -3492,6 +3492,9 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
> 
> What about kmem_cache_alloc_node()?
> 
>>  {
>>         void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
>>
>> +       if (cachep->flags & SLAB_ACCOUNT)
> 
> Should this 'if' be unlikely() or should we trace cachep->flags
> explicitly to avoid this branch altogether?

Hm I think ideally the tracepoint accepts cachep instead of current
cachep->*size parameters and does the necessary extraction and
modification in its fast_assign.

> 
>> +               flags |= __GFP_ACCOUNT;
>> +
>>         trace_kmem_cache_alloc(_RET_IP_, ret,
>>                                cachep->object_size, cachep->size, flags);
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index ed5c2c03a47a..670bbfef9e49 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3231,6 +3231,9 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>>  {
>>         void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>>
>> +       if (s->flags & SLAB_ACCOUNT)
>> +               gfpflags |= __GFP_ACCOUNT;
>> +
>>         trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
>>                                 s->size, gfpflags);
>>
>> --
>> 2.25.1
>>

