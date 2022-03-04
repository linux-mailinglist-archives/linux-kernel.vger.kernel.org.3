Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C9F4CCFF9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiCDIdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiCDIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:33:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EFA2FFF1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:32:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02439212C3;
        Fri,  4 Mar 2022 08:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646382753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syaRdmr8RBhJBNb56uTD6oy6Jsi1NqPRHXEbfXm8kv4=;
        b=wJt+IL30uRT46LWxmz4b8OuQ1S6kZRmk7bAdvdmbrIDT2PLnERpmwcK1OAHyjnhZF4s2Pp
        C93G7O9vBX4p/xEkC4u1cYGe1iULy99WpUdD2zzehjzseMlqiSXT9A8JPLjqqTAC0ZXv9l
        TVEFkV9eWnr+QVSfK2BBJQYw7vLe/m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646382753;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syaRdmr8RBhJBNb56uTD6oy6Jsi1NqPRHXEbfXm8kv4=;
        b=ZP5UB2fC/AmlEotQ8ZHBvVSowvRyx+c1jwpQsvQyoK20PinRtxtWmq7clYwmTKHhualAQg
        r0OhdqLXuuAI0wCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9D7013AF7;
        Fri,  4 Mar 2022 08:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pZqkMKDOIWJRZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 04 Mar 2022 08:32:32 +0000
Message-ID: <deae2ce6-8a43-5720-319e-cab25ee3bdb6@suse.cz>
Date:   Fri, 4 Mar 2022 09:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm/page_alloc: call check_new_pages() while zone spinlock
 is not held
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
References: <20220304015941.1704249-1-eric.dumazet@gmail.com>
 <CANn89iJgaSDucfvTusWDKVU4vraqku3pw1BBPjNVj5cZt2U7vg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANn89iJgaSDucfvTusWDKVU4vraqku3pw1BBPjNVj5cZt2U7vg@mail.gmail.com>
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

On 3/4/22 03:09, Eric Dumazet wrote:
> On Thu, Mar 3, 2022 at 5:59 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>>
>> For high order pages not using pcp, rmqueue() is currently calling
>> the costly check_new_pages() while zone spinlock is held.
>>
>> This is not needed, we can release the spinlock sooner to reduce
>> zone spinlock contention.
>>
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Shakeel Butt <shakeelb@google.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: Greg Thelen <gthelen@google.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: David Rientjes <rientjes@google.com>
>> ---
>>  mm/page_alloc.c | 17 +++++++----------
>>  1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3589febc6d31928f850ebe5a4015ddc40e0469f3..0890a65f8cc2259e82bc1f5ba95a592fb30f9fb8 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3685,7 +3685,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>>                         gfp_t gfp_flags, unsigned int alloc_flags,
>>                         int migratetype)
>>  {
>> -       unsigned long flags;
>>         struct page *page;
>>
>>         if (likely(pcp_allowed_order(order))) {
>> @@ -3706,10 +3705,12 @@ struct page *rmqueue(struct zone *preferred_zone,
>>          * allocate greater than order-1 page units with __GFP_NOFAIL.
>>          */
>>         WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>> -       spin_lock_irqsave(&zone->lock, flags);
>>
>>         do {
>> +               unsigned long flags;
>> +
>>                 page = NULL;
>> +               spin_lock_irqsave(&zone->lock, flags);
>>                 /*
>>                  * order-0 request can reach here when the pcplist is skipped
>>                  * due to non-CMA allocation context. HIGHATOMIC area is
>> @@ -3723,13 +3724,13 @@ struct page *rmqueue(struct zone *preferred_zone,
>>                 }
>>                 if (!page)
>>                         page = __rmqueue(zone, order, migratetype, alloc_flags);
>> -       } while (page && check_new_pages(page, order));
>> -       if (!page)
>> -               goto failed;
>> +               spin_unlock_irqrestore(&zone->lock, flags);
>> +               if (!page)
>> +                       return NULL;
>> +       } while (check_new_pages(page, order));
>>
> 
> Oh well, it seems hard irqs have to be disabled when calling the
> following function.

Ah, you found out already. Well maybe it could simply be moved inside the
loop under the locked section and always done when page != NULL? I mean if
check_new_pages() fails we just leak the problematic pages anyway so they
are no longer free to allocate anymore and we should not count them as such.

> I will send a V2.
> 
>>         __mod_zone_freepage_state(zone, -(1 << order),
>>                                   get_pcppage_migratetype(page));
>> -       spin_unlock_irqrestore(&zone->lock, flags);
>>
>>         __count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
>>         zone_statistics(preferred_zone, zone, 1);
>> @@ -3743,10 +3744,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>>
>>         VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
>>         return page;
>> -
>> -failed:
>> -       spin_unlock_irqrestore(&zone->lock, flags);
>> -       return NULL;
>>  }
>>
>>  #ifdef CONFIG_FAIL_PAGE_ALLOC
>> --
>> 2.35.1.616.g0bdcbb4464-goog
>>

