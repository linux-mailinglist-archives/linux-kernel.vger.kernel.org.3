Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAF64ECF7E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351498AbiC3WRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbiC3WRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:17:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BFD43EEA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:15:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C54AF210E3;
        Wed, 30 Mar 2022 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648678532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RB58uq41HlO09LnWG3dYM0gMH6ZgNNKiB+odHxThMMo=;
        b=n3937DmkrCR9JJUi07aVywmEMy04bOSOLECtora3sLUgZ7wUG4qVdksq6NwJtHnkj7QrMY
        oXPFK+jMC1cOPsNBge2bfY7m2k3TbAV/a55R+wuXO1GPf6OUtWmNdEjsOfmyahq8HfaLm7
        GdoXQmDbbiEGfdNSig4iT0ANYjF37Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648678532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RB58uq41HlO09LnWG3dYM0gMH6ZgNNKiB+odHxThMMo=;
        b=5Gmwb3rOG88M/M8DCuexjR4gb0y3UHlj6JmXT5Xc9O14GHKalQ4kNvSHeCOmz5uya7hDu/
        0nixIOW8Fd5h8yDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9276813AF3;
        Wed, 30 Mar 2022 22:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LrXxIoTWRGISJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 30 Mar 2022 22:15:32 +0000
Message-ID: <1ac57f1d-46ba-e28f-c541-70d57ca7b704@suse.cz>
Date:   Thu, 31 Mar 2022 00:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [BUG] Crash on x86_32 for: mm: page_alloc: avoid merging
 non-fallbackable pageblocks with others
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220330154208.71aca532@gandalf.local.home>
 <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
 <27ff69f9-60c5-9e59-feb2-295250077551@suse.cz>
 <EDB4B100-3CC4-4797-A32D-3DCAE7C76D8B@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <EDB4B100-3CC4-4797-A32D-3DCAE7C76D8B@nvidia.com>
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

On 3/31/22 00:03, Zi Yan wrote:
> On 30 Mar 2022, at 17:43, Vlastimil Babka wrote:
> 
>> On 3/30/22 22:05, Linus Torvalds wrote:
>>> On Wed, Mar 30, 2022 at 12:42 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>>
>>>> I started testing new patches and it crashed when doing the x86-32 test on
>>>> boot up.
>>>>
>>>> Initializing HighMem for node 0 (000375fe:0021ee00)
>>>> BUG: kernel NULL pointer dereference, address: 00000878
>>>> #PF: supervisor read access in kernel mode
>>>> #PF: error_code(0x0000) - not-present page
>>>> *pdpt = 0000000000000000 *pde = f0000000f000eef3
>>>> Oops: 0000 [#1] PREEMPT SMP PTI
>>>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-test+ #469
>>>> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
>>>> EIP: get_pfnblock_flags_mask+0x2c/0x36
>>>> Code: 6d ea ff 55 89 e5 56 89 ce 53 8b 18 89 d8 c1 eb 1e e8 f7 fb ff ff 69 db c0 02 00 00 89 c1 89 c2 c1 ea 05 8b 83 7c d7 79 c1 5b <8b> 04 90 d3 e8 21 f0 5e 5d c3 55 89 e5 57 56 89 d6 53 89 c3 64 a1
>>>
>>> The whole function is in that Code: thing, and it decodes to:
>>>
>>>    0: 55                    push   %ebp
>>>    1: 89 e5                mov    %esp,%ebp
>>>    3: 56                    push   %esi
>>>    4: 89 ce                mov    %ecx,%esi
>>>    6: 53                    push   %ebx
>>>    7: 8b 18                mov    (%eax),%ebx
>>>    9: 89 d8                mov    %ebx,%eax
>>>    b: c1 eb 1e              shr    $0x1e,%ebx
>>>    e: e8 f7 fb ff ff        call   0xfffffc0a
>>>   13: 69 db c0 02 00 00    imul   $0x2c0,%ebx,%ebx
>>>   19: 89 c1                mov    %eax,%ecx
>>>   1b: 89 c2                mov    %eax,%edx
>>>   1d: c1 ea 05              shr    $0x5,%edx
>>>   20: 8b 83 7c d7 79 c1    mov    -0x3e862884(%ebx),%eax
>>>   26: 5b                    pop    %ebx
>>>   27:* 8b 04 90              mov    (%eax,%edx,4),%eax <-- trapping instruction
>>>   2a: d3 e8                shr    %cl,%eax
>>>   2c: 21 f0                and    %esi,%eax
>>>   2e: 5e                    pop    %esi
>>>   2f: 5d                    pop    %ebp
>>>   30: c3                    ret
>>>
>>> with '%eax' being NULL, and %edx being 0x21e.
>>>
>>> (The call seems to be to 'pfn_to_bitidx().isra.0' if my compiler does
>>> similar code generation, so it's out-of-lined part of pfn_to_bitidx()
>>> despite being marked inline)
>>>
>>> So that oops is that
>>>
>>>         word = bitmap[word_bitidx];
>>>
>>> line, with 'bitmap' being NULL (and %edx contains 'word_bitidx').
>>>
>>> Looking around, your 'config-bad' doesn't even have
>>> CONFIG_MEMORY_ISOLATION enabled, and so I suspect the culprit is this
>>> part of the change:
>>>
>>> -               if (unlikely(has_isolate_pageblock(zone))) {
>>>
>>> which used to always be false for that config, and now the code is
>>> suddenly enabled.
>>
>> If CONFIG_MEMORY_ISOLATION was enabled then the zone layout would be the
>> same, so I think it's not simply that. I think it's the timing -
>> has_isolate_pageblock(zone) would only be possible to become true later
>> in runtime when some isolation is ongoing, but here it seems we are
>> still in the early boot. Probably at a boundary of highmem with another
>> zone that doesn't have the pageblock bitmap yet initialized? While later
>> it would have, and all would be fine.
> 
> It seems so based on the boot log from Steven.
> 
>>
>> As Zi Yan said, the usual merging code will, through page_is_buddy()
>> find safely enough the buddy is not applicable, so I agree with his
>> patch direction. Seems this also shows the code tried to become too
>> smart and for the next merge window we should try just move the
>> migratetype checks into the main while loop (under something like "if
>> (order >= max_order)") and simplify the function a lot, hopefully with
>> negligible perf impact.
> 
> Something like this?

Exactly (with some nits).

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6c6af8658775..568ecaf5700d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1053,7 +1053,6 @@ static inline void __free_one_page(struct page *page,
>                 int migratetype, fpi_t fpi_flags)
>  {
>         struct capture_control *capc = task_capc(zone);
> -       unsigned int max_order = pageblock_order;
>         unsigned long buddy_pfn;
>         unsigned long combined_pfn;
>         struct page *buddy;
> @@ -1069,8 +1068,7 @@ static inline void __free_one_page(struct page *page,
>         VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>         VM_BUG_ON_PAGE(bad_range(zone, page), page);
> 
> -continue_merging:
> -       while (order < max_order) {
> +       while (order < MAX_ORDER - 1) {
>                 if (compaction_capture(capc, page, order, migratetype)) {
>                         __mod_zone_freepage_state(zone, -(1 << order),
>                                                                 migratetype);
> @@ -1081,6 +1079,27 @@ static inline void __free_one_page(struct page *page,
> 
>                 if (!page_is_buddy(page, buddy, order))
>                         goto done_merging;
> +
> +               if (order >= pageblock_order) {

Would use unlikely() here.

> +                       /* If we are here, it means order is >= pageblock_order.

Can drop this like as it became quite obvious now :)

> +                        * We want to prevent merge between freepages on pageblock
> +                        * without fallbacks and normal pageblock. Without this,
> +                        * pageblock isolation could cause incorrect freepage or CMA
> +                        * accounting or HIGHATOMIC accounting.
> +                        *
> +                        * We don't want to hit this code for the more frequent
> +                        * low-order merging.

The last two lines should be also dropped now.

> +                        */
> +                       int buddy_mt;
> +
> +                       buddy_mt = get_pageblock_migratetype(buddy);

Can be now single line.

> +
> +                       if (migratetype != buddy_mt
> +                                       && (!migratetype_is_mergeable(migratetype) ||
> +                                               !migratetype_is_mergeable(buddy_mt)))
> +                               goto done_merging;
> +               }
> +
>                 /*
>                  * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
>                  * merge with it and move up one order.
> @@ -1094,32 +1113,6 @@ static inline void __free_one_page(struct page *page,
>                 pfn = combined_pfn;
>                 order++;
>         }
> -       if (order < MAX_ORDER - 1) {
> -               /* If we are here, it means order is >= pageblock_order.
> -                * We want to prevent merge between freepages on pageblock
> -                * without fallbacks and normal pageblock. Without this,
> -                * pageblock isolation could cause incorrect freepage or CMA
> -                * accounting or HIGHATOMIC accounting.
> -                *
> -                * We don't want to hit this code for the more frequent
> -                * low-order merging.
> -                */
> -               int buddy_mt;
> -
> -               buddy_pfn = __find_buddy_pfn(pfn, order);
> -               buddy = page + (buddy_pfn - pfn);
> -
> -               if (!page_is_buddy(page, buddy, order))
> -                       goto done_merging;
> -               buddy_mt = get_pageblock_migratetype(buddy);
> -
> -               if (migratetype != buddy_mt
> -                               && (!migratetype_is_mergeable(migratetype) ||
> -                                       !migratetype_is_mergeable(buddy_mt)))
> -                       goto done_merging;
> -               max_order = order + 1;
> -               goto continue_merging;
> -       }
> 
>  done_merging:
>         set_buddy_order(page, order);
> 
> --
> Best Regards,
> Yan, Zi

