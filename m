Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D04EFCD2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351032AbiDAWey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiDAWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:34:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC8201692
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:33:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D4D0210EC;
        Fri,  1 Apr 2022 22:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648852382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRwEXKyk8taU0Me5AEEyQ3cB4A5H97TBy7ejlW/HIGQ=;
        b=m4cUhr/sxBPUmUnvJET1mT2MQj56Munt/HKlCHinbCcWNZlilhx+3a2Ski2xUKFFQvj0Oa
        7R2pk6LIwwILCU0gX13Hm8VYHK16djjHFJv0Cdn5WC4KODXPzhRvxI6gPwWwKW2RuFPbNZ
        cC54FbbhGr7Bf43d6R6GkAG1ZwjwlwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648852382;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRwEXKyk8taU0Me5AEEyQ3cB4A5H97TBy7ejlW/HIGQ=;
        b=0B9HiZFJGZWUp+3U0avuQECt3wLMS2xSc8txXQS+xGNsJitRu8QZ1+FgEultE+t+jKae9z
        XuKlMatjV05i3GBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D08E6132C1;
        Fri,  1 Apr 2022 22:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7PjrMZ19R2KNNAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 01 Apr 2022 22:33:01 +0000
Message-ID: <bbafba4a-ec6b-936f-6ba2-d4b1c0700201@suse.cz>
Date:   Sat, 2 Apr 2022 00:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy
 page validation.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220401181109.1477354-1-zi.yan@sent.com>
 <20220401181109.1477354-2-zi.yan@sent.com>
 <CAHk-=wifQimj2d6npq-wCi5onYPjzQg4vyO4tFcPJJZr268cRw@mail.gmail.com>
 <ADC113C0-F731-4835-AE3E-87C2302877B5@nvidia.com>
 <CAHk-=wgNxEq9BaxBSjC+RvKPsc5zuRwc1PGEvXqqX9vb1UALyA@mail.gmail.com>
 <C8ADDC89-FE41-4DA1-A820-E3F7CE818955@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <C8ADDC89-FE41-4DA1-A820-E3F7CE818955@nvidia.com>
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

On 4/1/22 21:25, Zi Yan wrote:
> On 1 Apr 2022, at 15:01, Linus Torvalds wrote:
> 
>> On Fri, Apr 1, 2022 at 11:56 AM Zi Yan <ziy@nvidia.com> wrote:
>>>
>>> How about the patch below? If it looks good, I will send v3.
>>
>> I can't see anything worrisome, but by now I've looked at several
>> versions and who knows what I'm missing.
>>
>> Making it inline and allowing a NULL 'buddy_pfn' pointer for the cases
>> that don't care might be an option, but I don't think it matters
>> hugely.
> 
> What do you mean by inlining it? Moving the function and __find_buddy_pfn()
> to mm/internal.h and mark both inline?

I would prefer that for the sake of __free_one_page().

> Something like below to allow a NULL 'buddy_pfn'? buddy_pfn is needed
> to store the result of __find_buddy_pfn(). The code does not look
> as nice as before.
> 
> struct page *find_buddy_page_pfn(struct page *page, unsigned long pfn,
>                         unsigned int order, unsigned long *buddy_pfn)
> {
>         struct page *buddy;
> 
>         if (buddy_pfn) {
>                 *buddy_pfn = __find_buddy_pfn(pfn, order);
>                 buddy = page + (*buddy_pfn - pfn);
>         } else
>                 buddy = page + (__find_buddy_pfn(pfn, order) - pfn);
> 
>         if (page_is_buddy(page, buddy, order))
>                 return buddy;
>         return NULL;
> }
> 
> or
> 
> struct page *find_buddy_page_pfn(struct page *page, unsigned long pfn,
>                         unsigned int order, unsigned long *buddy_pfn)
> {
>         struct page *buddy;
>         unsigned long local_buddy_pfn = __find_buddy_pfn(pfn, order);
> 
>         buddy = page + (local_buddy_pfn - pfn);
>         if (buddy_pfn)
>                 *buddy_pfn = local_buddy_pfn;
> 
>         if (page_is_buddy(page, buddy, order))
>                 return buddy;
>         return NULL;
> }

The latter looks better. I would also use a name e.g. '__buddy_pfn'
instead of 'local_'.

Thanks.

> 
> --
> Best Regards,
> Yan, Zi

