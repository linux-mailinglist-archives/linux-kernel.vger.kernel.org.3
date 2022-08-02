Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB45587A07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiHBJnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiHBJnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:43:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF0213E81
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:43:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1EE833EBB;
        Tue,  2 Aug 2022 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659433418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7YVoJLzpojTt0jcWLG9PMje7g7Fq1t+gY4EsDTwwLc=;
        b=OigbtW0PRUhvStwfiImCP8h/5RGJ+/waYDw64YhcPjvUb/mg47daucIBBbQIXF0/wOSO7s
        Y0MMdDKFNfMZzxd6qZ9+u1PAtZ8aiWi1Q7xv4tCV0QRAMkjnIFDTw9aFdgJARTAX4kHzOI
        rLwH4bUkrmmR4V4VkrXYZ2/jNFPJCAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659433418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7YVoJLzpojTt0jcWLG9PMje7g7Fq1t+gY4EsDTwwLc=;
        b=xrje5JswwGOFyUWXZMnq6BucanVw9QEruC0dThbsD+DxXVkgnyc5Toy4bBTCy0sJM45dyz
        Xi0RosHFXk8+c/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AD6B13A8E;
        Tue,  2 Aug 2022 09:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O9cDJcnx6GKScAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 02 Aug 2022 09:43:37 +0000
Message-ID: <85ec4ea8-ae4c-3592-5491-3db6d0ad8c59@suse.cz>
Date:   Tue, 2 Aug 2022 11:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [mm/slub] 3616799128:
 BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>, Feng Tang <feng.tang@intel.com>
Cc:     "Sang, Oliver" <oliver.sang@intel.com>, lkp <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
References: <20220727071042.8796-4-feng.tang@intel.com>
 <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020> <YuY6Wc39DbL3YmGi@feng-skl>
 <Yudw5ge/lJ26Hksk@feng-skl> <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl>
 <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 09:06, Dmitry Vyukov wrote:
> On Tue, 2 Aug 2022 at 08:55, Feng Tang <feng.tang@intel.com> wrote:
>>
>> On Mon, Aug 01, 2022 at 10:23:23PM +0800, Vlastimil Babka wrote:
>> > On 8/1/22 08:21, Feng Tang wrote:
>> [snip]
>> > > Cc kansan  mail list.
>> > >
>> > > This is really related with KASAN debug, that in free path, some
>> > > kmalloc redzone ([orig_size+1, object_size]) area is written by
>> > > kasan to save free meta info.
>> > >
>> > > The callstack is:
>> > >
>> > >   kfree
>> > >     slab_free
>> > >       slab_free_freelist_hook
>> > >           slab_free_hook
>> > >             __kasan_slab_free
>> > >               ____kasan_slab_free
>> > >                 kasan_set_free_info
>> > >                   kasan_set_track
>> > >
>> > > And this issue only happens with "kmalloc-16" slab. Kasan has 2
>> > > tracks: alloc_track and free_track, for x86_64 test platform, most
>> > > of the slabs will reserve space for alloc_track, and reuse the
>> > > 'object' area for free_track.  The kasan free_track is 16 bytes
>> > > large, that it will occupy the whole 'kmalloc-16's object area,
>> > > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
>> > > error is triggered.
>> > >
>> > > But it won't hurt other kmalloc slabs, as kasan's free meta won't
>> > > conflict with kmalloc-redzone which stay in the latter part of
>> > > kmalloc area.
>> > >
>> > > So the solution I can think of is:
>> > > * skip the kmalloc-redzone for kmalloc-16 only, or
>> > > * skip kmalloc-redzone if kasan is enabled, or
>> > > * let kasan reserve the free meta (16 bytes) outside of object
>> > >   just like for alloc meta
>> >
>> > Maybe we could add some hack that if both kasan and SLAB_STORE_USER is
>> > enabled, we bump the stored orig_size from <16 to 16? Similar to what
>> > __ksize() does.
>>
>> How about the following patch:
>>
>> ---
>> diff --git a/mm/slub.c b/mm/slub.c
>> index added2653bb0..33bbac2afaef 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
>>         if (!slub_debug_orig_size(s))
>>                 return;
>>
>> +#ifdef CONFIG_KASAN
>> +       /*
>> +        * When kasan is enabled, it could save its free meta data in the
>> +        * start part of object area, so skip the kmalloc redzone check
>> +        * for small kmalloc slabs to avoid the data conflict.
>> +        */
>> +       if (s->object_size <= 32)
>> +               orig_size = s->object_size;
>> +#endif
>> +
>>         p += get_info_end(s);
>>         p += sizeof(struct track) * 2;
>>
>> I extend the size to 32 for potential's kasan meta data size increase.
>> This is tested locally, if people are OK with it, I can ask for 0Day's
>> help to verify this.

Is there maybe some KASAN macro we can use instead of hardcoding 32?

> 
> Where is set_orig_size() function defined? Don't see it upstream nor
> in linux-next.
> This looks fine but my only concern is that this should not increase
> memory consumption when slub debug tracking is not enabled, which
> should be the main operation mode when KASAN is enabled. But I can't
> figure this out w/o context.

It won't increase memory consumption even if slub_debug tracking is enabled.
It just fakes a bit the size that was passed to kmalloc() and which we newly
store (thanks to Feng's patches) for statistics and debugging purposes.

>> Thanks,
>> Feng
>>
>> >
>> > > I don't have way to test kasan's SW/HW tag configuration, which
>> > > is only enabled on arm64 now. And I don't know if there will
>> > > also be some conflict.
>> > >
>> > > Thanks,
>> > > Feng
>> > >
>> >
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/YujKCxu2lJJFm73P%40feng-skl.

