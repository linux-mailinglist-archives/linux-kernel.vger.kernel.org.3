Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52CB4E52E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbiCWNVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbiCWNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:21:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492FD1FCE6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:19:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E2EBE1F37F;
        Wed, 23 Mar 2022 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648041570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skAPDzFpHTiodgB8Q02pBrdUfjbG2DP3aT/OV2kUCTg=;
        b=ExWKBH5gbebZ2qLYLYhoqyuTeCoOFEeTDXcHTyKzVTsy7cEJjCYK6VddO3UW7yGD+ja2Cu
        SrZnNBg0QIK1yZsSQPDEIxkQ45o4i57nTrErjU5qicqaZABRbr95w4AvNZ3e9QyzZnujTs
        nm7tAt0Q1y8Sf0+UfJEtEENErmnZCco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648041570;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skAPDzFpHTiodgB8Q02pBrdUfjbG2DP3aT/OV2kUCTg=;
        b=xJJQhmlpXwoElCRd9f8SJOA1NqCjyl8IfEx5JKFWYW8GBDuHAdGI+N76EUs5DvqbMFysNf
        vQk/tHT2uqjB5mDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F60C12FC5;
        Wed, 23 Mar 2022 13:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ud/kGWIeO2KkJgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Mar 2022 13:19:30 +0000
Message-ID: <93851312-6443-31ec-c194-8117e483f5d4@suse.cz>
Date:   Wed, 23 Mar 2022 14:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 27/39] kasan, mm: only define ___GFP_SKIP_KASAN_POISON
 with HW_TAGS
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <cover.1643047180.git.andreyknvl@google.com>
 <44e5738a584c11801b2b8f1231898918efc8634a.1643047180.git.andreyknvl@google.com>
 <63704e10-18cf-9a82-cffb-052c6046ba7d@suse.cz>
 <YjsaaQo5pqmGdBaY@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YjsaaQo5pqmGdBaY@linutronix.de>
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

On 3/23/22 14:02, Sebastian Andrzej Siewior wrote:
> On 2022-03-23 12:48:29 [+0100], Vlastimil Babka wrote:
>>> +#ifdef CONFIG_KASAN_HW_TAGS
>>>  #define ___GFP_SKIP_KASAN_POISON	0x1000000u
>>> +#else
>>> +#define ___GFP_SKIP_KASAN_POISON	0
>>> +#endif
>>>  #ifdef CONFIG_LOCKDEP
>>>  #define ___GFP_NOLOCKDEP	0x2000000u
>>>  #else
>>> @@ -251,7 +255,9 @@ struct vm_area_struct;
>>>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>>>  
>>>  /* Room for N __GFP_FOO bits */
>>> -#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
>>> +#define __GFP_BITS_SHIFT (24 +					\
>>> +			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
>>> +			  IS_ENABLED(CONFIG_LOCKDEP))
>>
>> This breaks __GFP_NOLOCKDEP, see:
>> https://lore.kernel.org/all/YjoJ4CzB3yfWSV1F@linutronix.de/
> 
> This could work because ___GFP_NOLOCKDEP is still 0x2000000u. In

Hm but already this patch makes gfp_allowed_mask to be 0x1ffffff (thus
not covering 0x2000000u) when CONFIG_LOCKDEP is enabled and the KASAN
stuff not? 0x8000000u is just even further away.

> 	("kasan, page_alloc: allow skipping memory init for HW_TAGS")
> 	https://lore.kernel.org/all/0d53efeff345de7d708e0baa0d8829167772521e.1643047180.git.andreyknvl@google.com/
> 
> This is replaced with 0x8000000u which breaks lockdep.
> 
> Sebastian
> 

