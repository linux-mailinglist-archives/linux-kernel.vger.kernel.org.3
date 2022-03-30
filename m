Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3D4ECF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348397AbiC3VuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351360AbiC3Vtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:49:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23652E4A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:48:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF36F218F8;
        Wed, 30 Mar 2022 21:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648676887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWhCH76wJNOPUkyUEGjWSMW9zgCG+hN7ltEMYwIFxNA=;
        b=0hGaA5oUgyBUmiCvjSMdMMYK2/vVDl0Paz7oDbnNAYjh4/os8TxHqDREx2rf9SuMr7F53f
        PPiEMTg+AkY+dCF5urd4okHT3fXJY5I8uMymT7Dg2hlIxe0LuC7sCpets5jwYGXTrvgCFm
        pTXzbFqNCftxSHTEqHt3TlfiEYtKrOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648676887;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWhCH76wJNOPUkyUEGjWSMW9zgCG+hN7ltEMYwIFxNA=;
        b=GSR7mChVNeh+pGPYpRizx3j4jedxwMLSR2xHiSKZs5M7BkTT08RBLW4XLRH7B98bcZli3o
        XAi0+gkLkZCBhDAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6B1613AF3;
        Wed, 30 Mar 2022 21:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T5nBJxfQRGJxHgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 30 Mar 2022 21:48:07 +0000
Message-ID: <2b84aba9-7435-0073-59f0-410fddb6df7d@suse.cz>
Date:   Wed, 30 Mar 2022 23:48:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [BUG] Crash on x86_32 for: mm: page_alloc: avoid merging
 non-fallbackable pageblocks with others
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220330154208.71aca532@gandalf.local.home>
 <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
 <B7789993-75EC-4F74-B4E6-AF1CC2CBD9D4@nvidia.com>
 <20220330165337.7138810e@gandalf.local.home>
 <AF9D3EF9-B070-4ADE-A2D3-C466A4A2D125@nvidia.com>
 <733F211D-9717-46A7-A0A2-40353E12F65A@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <733F211D-9717-46A7-A0A2-40353E12F65A@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 23:43, Zi Yan wrote:
> On 30 Mar 2022, at 17:25, Zi Yan wrote:
> 
>> On 30 Mar 2022, at 16:53, Steven Rostedt wrote:
>>
>>> On Wed, 30 Mar 2022 16:29:28 -0400
>>> Zi Yan <ziy@nvidia.com> wrote:
>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index bdc8f60ae462..83a90e2973b7 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -1108,6 +1108,8 @@ static inline void __free_one_page(struct page *page,
>>>>
>>>>                 buddy_pfn = __find_buddy_pfn(pfn, order);
>>>>                 buddy = page + (buddy_pfn - pfn);
>>>> +               if (!page_is_buddy(page, buddy, order))
>>>> +                       goto done_merging;
>>>>                 buddy_mt = get_pageblock_migratetype(buddy);
>>>>
>>>>                 if (migratetype != buddy_mt
>>>>
>>>
>>> The above did not apply to Linus's tree, nor even the problem commit
>>> (before or after), but I found where the code is, and added it manually.
>>>
>>> It does appear to allow the machine to boot.
>>>
>> I just pulled Linus’s tree and grabbed the diff. Anyway, thanks.
>>
>> I would like to get more understanding of the issue before blindly sending
>> this as a fix.
>>
>> Merge the other thread:
>>>
>>> Not sure if this matters or not, but my kernel command line has:
>>>
>>>   crashkernel=256M
>>>
>>> Could that have caused this to break?
>>
>> Unlikely, 256MB is MAX_ORDER_NR_PAGES aligned (MAX_ORDER is 11 here).
>> __find_buddy_pfn() will not get any buddy_pfn from crashkernel memory
>> region, since that would cross MAX_ORDER_NR_PAGES boundary.
>>
>> page_is_buddy() checks page_is_guard(buddy), PageBuddy(buddy),
>> buddy_order(buddy), and page_zone_id(buddy), where page_is_guard(buddy)
>> is always false since CONFIG_DEBUG_PAGEALLOC is not set in your config.
>> So either PageBuddy(buddy) is false, buddy_order(buddy) != order,
>> or page_zone_id(buddy) is not the same as page_zone_id(page).
>>
>> Do you mind adding the following code right before my fix code above
>> and provide a complete boot log? I would like to understand what
>> went wrong. Thanks.
>>
>> pr_info("buddy_pfn: %lx, PageBuddy: %d, buddy_order: %d (vs %d), page_zone_id: %d (vs %d)\n",
>>         buddy_pfn, PageBuddy(buddy), buddy_order(buddy), order, page_zone_id(buddy),
>>         page_zone_id(page));
>>
>>
> 
> This seems to be a bug in the original code too.
> But "if (unlikely(has_isolate_pageblock(zone)))" is too rare to trigger it.
> I do not see how having isolated pageblocks in a zone could get us away
> from checking page_is_buddy().

IIRC the assumption was that pageblock bitmaps would always exist
withing MAX_ORDER blocks. But here we are still under mem_init() where
has_isolate_pageblock() couldn't happen. And the assumption could have
been silently broken by subsequent memory init changes.

> --
> Best Regards,
> Yan, Zi

