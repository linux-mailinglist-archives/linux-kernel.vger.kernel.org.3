Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D041E4E53B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbiCWN7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242324AbiCWN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:59:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EFB7E0A7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:57:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AFFF1210E4;
        Wed, 23 Mar 2022 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648043851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itu+LHsaFezNfv+6AfxtF3Pylr5NbpawvSpL4NXWxCc=;
        b=ZsrLi6jex0eApPlRNLc7tI9/QKRpc0JHSa98ysm8sWkr7DGrC+Q8QNEGa0KJKSw2kCt778
        tGjirxsi8jSsWMREeU6akSB3TWnB9Q7LtsohMtwJostGPbtBYCb4XwkSkI9FxRdcBNU/1E
        zu04qCmmAb1TOebmQZ6I/665j4BBvAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648043851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itu+LHsaFezNfv+6AfxtF3Pylr5NbpawvSpL4NXWxCc=;
        b=E/97Ue1iAv691jvF2gSfULnJn4QIBWV3B/TyrMcNJ7SAzbH5ecCJXsF/zlagV4bEZuGCo+
        WbIb3S+/6RInXNBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36D8712FC5;
        Wed, 23 Mar 2022 13:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RHj4C0snO2LpOQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Mar 2022 13:57:31 +0000
Message-ID: <b4d598ac-006e-1de3-21e5-8afa6aea0538@suse.cz>
Date:   Wed, 23 Mar 2022 14:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 27/39] kasan, mm: only define ___GFP_SKIP_KASAN_POISON
 with HW_TAGS
Content-Language: en-US
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthew Wilcox <willy@infradead.org>
References: <cover.1643047180.git.andreyknvl@google.com>
 <44e5738a584c11801b2b8f1231898918efc8634a.1643047180.git.andreyknvl@google.com>
 <63704e10-18cf-9a82-cffb-052c6046ba7d@suse.cz>
 <YjsaaQo5pqmGdBaY@linutronix.de>
 <CA+fCnZeG5DbxcnER1yWkJ50605_4E1xPtgeTEsSEc89qUg4w6g@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+fCnZeG5DbxcnER1yWkJ50605_4E1xPtgeTEsSEc89qUg4w6g@mail.gmail.com>
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

On 3/23/22 14:36, Andrey Konovalov wrote:
> On Wed, Mar 23, 2022 at 2:02 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>>
>> On 2022-03-23 12:48:29 [+0100], Vlastimil Babka wrote:
>>>> +#ifdef CONFIG_KASAN_HW_TAGS
>>>>  #define ___GFP_SKIP_KASAN_POISON   0x1000000u
>>>> +#else
>>>> +#define ___GFP_SKIP_KASAN_POISON   0
>>>> +#endif
>>>>  #ifdef CONFIG_LOCKDEP
>>>>  #define ___GFP_NOLOCKDEP   0x2000000u
>>>>  #else
>>>> @@ -251,7 +255,9 @@ struct vm_area_struct;
>>>>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>>>>
>>>>  /* Room for N __GFP_FOO bits */
>>>> -#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
>>>> +#define __GFP_BITS_SHIFT (24 +                                     \
>>>> +                     IS_ENABLED(CONFIG_KASAN_HW_TAGS) +    \
>>>> +                     IS_ENABLED(CONFIG_LOCKDEP))
>>>
>>> This breaks __GFP_NOLOCKDEP, see:
>>> https://lore.kernel.org/all/YjoJ4CzB3yfWSV1F@linutronix.de/
>>
>> This could work because ___GFP_NOLOCKDEP is still 0x2000000u. In
>>         ("kasan, page_alloc: allow skipping memory init for HW_TAGS")
>>         https://lore.kernel.org/all/0d53efeff345de7d708e0baa0d8829167772521e.1643047180.git.andreyknvl@google.com/
>>
>> This is replaced with 0x8000000u which breaks lockdep.
>>
>> Sebastian
> 
> Hi Sebastian,
> 
> Indeed, sorry for breaking lockdep. Thank you for the report!
> 
> I wonder what's the proper fix for this. Perhaps, don't hide KASAN GFP
> bits under CONFIG_KASAN_HW_TAGS? And then do:
> 
> #define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
> 
> Vlastimil, Andrew do you have any preference?

I guess it's the simplest thing to do for now. For the future we can
still improve and handle all combinations of kasan/lockdep to occupy as
few bits as possible and set the shift/mask appropriately. Or consider
first if it's necessary anyway. I don't know if we really expect at any
point to start triggering the BUILD_BUG_ON() in radix_tree_init() and
then only some combination of configs will reduce the flags to a number
that works. Or is there anything else that depends on __GFP_BITS_SHIFT?
I mean if we don't expect to go this way, we can just define
__GFP_BITS_SHIFT as a constant that assumes all the config-dependent
flags to be defined (not zero).

> If my suggestion sounds good, Andrew, could you directly apply the
> changes? They are needed for these 3 patches:
> 
> kasan, page_alloc: allow skipping memory init for HW_TAGS
> kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
> kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS
> 
> As these depend on each other, I can't send separate patches that can
> be folded for all 3.
> 
> Thanks!

