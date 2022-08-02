Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E61587BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiHBMGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiHBMGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A603232EC3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659442001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYEw35vKmDpSrFr4YkYnoue54oWP7di2VQu03Eq7wE0=;
        b=hon40IggO8pK5yMvF13pNru80B/JReu2+2DanGBxsv94vikxAhe5BgzK3GmC43oqOuuVx+
        mP8HBe3BzQylnFB+vYCnOU5Bcxf1IZM2XeZ9iJeMKZYfXEb377LvKOiFC43smbeCrIEHJF
        G/I0SIm13KrxqYgZZdtTHbaNC/H304I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-BjDXZbypM4GfJkj7V2QGRQ-1; Tue, 02 Aug 2022 08:06:40 -0400
X-MC-Unique: BjDXZbypM4GfJkj7V2QGRQ-1
Received: by mail-wr1-f71.google.com with SMTP id t12-20020adfba4c000000b0021e7440666bso3485869wrg.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 05:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=CYEw35vKmDpSrFr4YkYnoue54oWP7di2VQu03Eq7wE0=;
        b=D0mTXmmGzPhIbaqD0PYG1WviLScsvKQ6T4pDS2oFK8IWvthDegLqWxyENF1zJn50Cz
         VIo6t4jhpYQ1v+mKCwbvmOzR2OIm+GGabpL8tG38jWIvYQCd8lCJ9tmn8v49MVuyJUvm
         F75chXLfSshcGSt5H0fXb2cLl9hURLO/acHIJP2qzeLC92+cjQkzRD+EHXxYHU8fAfKi
         ii5xioa5eM/yhUg70myHwZH3bK1TAsl3Ml1oQoiZ6h3eOVVcXot2Q43HE8QQF+WNmnkz
         Zsn6Hac3eVGgu13uY9CpQTX+WmR+LlGI/hOSSDzm5WLMgktxraukkZO4c0JGVv3+WQzg
         Fc1A==
X-Gm-Message-State: AJIora9MNjA9THeL7Z93bR9e3sntP8ASuZ364polPLl8mnVWjw4mjqwn
        EkktOoeBf12DHRhE+cFZ7dou7JlVtmhlwYFjEXqyYcDIktnEmK741srjtmrjN9YNp5CpHVyRN4x
        PZ7dklcmD4X0Ex+kIpSmuMSQ4
X-Received: by 2002:a05:600c:1c26:b0:3a3:2251:c3cb with SMTP id j38-20020a05600c1c2600b003a32251c3cbmr13925733wms.126.1659441999203;
        Tue, 02 Aug 2022 05:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sG8ZI6iLhu+8yup8qcR2zbPYbaWcNlL4fEYHya3FIYj+hl/zDMrPBO7Oe86fv8d82ObX2faw==
X-Received: by 2002:a05:600c:1c26:b0:3a3:2251:c3cb with SMTP id j38-20020a05600c1c2600b003a32251c3cbmr13925707wms.126.1659441998919;
        Tue, 02 Aug 2022 05:06:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3800:8435:659e:f80:9b3d? (p200300cbc70738008435659e0f809b3d.dip0.t-ipconnect.de. [2003:cb:c707:3800:8435:659e:f80:9b3d])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe10f000000b0022062459ce5sm7199853wrz.30.2022.08.02.05.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 05:06:38 -0700 (PDT)
Message-ID: <49434bea-3862-1052-2993-8ccad985708b@redhat.com>
Date:   Tue, 2 Aug 2022 14:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220729014041.21292-1-peterx@redhat.com>
 <f23b71e5-a5f5-bb39-dbec-3e85af344185@redhat.com>
 <YuhVJmSsgs4Q1bYJ@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 0/4] mm: Remember young bit for migration entries
In-Reply-To: <YuhVJmSsgs4Q1bYJ@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.22 00:35, Peter Xu wrote:
> On Mon, Aug 01, 2022 at 10:21:32AM +0200, David Hildenbrand wrote:
>> On 29.07.22 03:40, Peter Xu wrote:
>>> [Marking as RFC; only x86 is supported for now, plan to add a few more
>>>  archs when there's a formal version]
>>>
>>> Problem
>>> =======
>>>
>>> When migrate a page, right now we always mark the migrated page as old.
>>> The reason could be that we don't really know whether the page is hot or
>>> cold, so we could have taken it a default negative assuming that's safer.
>>>
>>> However that could lead to at least two problems:
>>>
>>>   (1) We lost the real hot/cold information while we could have persisted.
>>>       That information shouldn't change even if the backing page is changed
>>>       after the migration,
>>>
>>>   (2) There can be always extra overhead on the immediate next access to
>>>       any migrated page, because hardware MMU needs cycles to set the young
>>>       bit again (as long as the MMU supports).
>>>
>>> Many of the recent upstream works showed that (2) is not something trivial
>>> and actually very measurable.  In my test case, reading 1G chunk of memory
>>> - jumping in page size intervals - could take 99ms just because of the
>>> extra setting on the young bit on a generic x86_64 system, comparing to 4ms
>>> if young set.
>>>
>>> This issue is originally reported by Andrea Arcangeli.
>>>
>>> Solution
>>> ========
>>>
>>> To solve this problem, this patchset tries to remember the young bit in the
>>> migration entries and carry it over when recovering the ptes.
>>>
>>> We have the chance to do so because in many systems the swap offset is not
>>> really fully used.  Migration entries use swp offset to store PFN only,
>>> while the PFN is normally not as large as swp offset and normally smaller.
>>> It means we do have some free bits in swp offset that we can use to store
>>> things like young, and that's how this series tried to approach this
>>> problem.
>>>
>>> One tricky thing here is even though we're embedding the information into
>>> swap entry which seems to be a very generic data structure, the number of
>>> bits that are free is still arch dependent.  Not only because the size of
>>> swp_entry_t differs, but also due to the different layouts of swap ptes on
>>> different archs.
>>>
>>> Here, this series requires specific arch to define an extra macro called
>>> __ARCH_SWP_OFFSET_BITS represents the size of swp offset.  With this
>>> information, the swap logic can know whether there's extra bits to use,
>>> then it'll remember the young bits when possible.  By default, it'll keep
>>> the old behavior of keeping all migrated pages cold.
>>>
>>
>>
>> I played with a similar idea when working on pte_swp_exclusive() but
>> gave up, because it ended up looking too hacky. Looking at patch #2, I
>> get the same feeling again. Kind of hacky.
> 
> Could you explain what's the "hacky" part you mentioned?

SWP_PFN_OFFSET_FREE_BITS :)

It's a PFN offset and we're mangling in random other bits. That's hacky
IMHO.

I played with the idea of converting all code to store bits in addition
to the type + offset. But that requires digging through a lot of arch
code to teach that code about additional flags, so I discarded that idea
when working on the COW fixes.

> 
> I used swap entry to avoid per-arch operations. I failed to figure out a
> common way to know swp offset length myself so unluckily in this RFC I
> still needed one macro per-arch.  Ying's suggestion seems to be a good fit
> here to me to remove the last arch-specific dependency.

Instead of mangling this into the PFN offset and let the arch tell you
which bits of the PFN offset are unused ... rather remove the bits from
the offset and define them manually to have a certain meaning. That's
exactly how pte_swp_mkexclusive/pte_swp_exclusive/ is supposed to be
handled on architectures that want to support it.

I hope I could make it clearer what the hacky part is IMHO :)

> 
>>
>>
>> If we mostly only care about x86_64, and it's a performance improvement
>> after all, why not simply do it like
>> pte_swp_mkexclusive/pte_swp_exclusive/ ... and reuse a spare PTE bit?
> 
> Page migration works for most archs, I want to have it work for all archs
> that can easily benefit from it.

Yet we only care about x86-64 IIUC regarding performance, just the way
the dirty bit is handled?

> 
> Besides I actually have a question on the anon exclusive bit in the swap
> pte: since we have that anyway, why we need a specific migration type for
> anon exclusive pages?  Can it be simply read migration entries with anon
> exclusive bit set?

Not before all arch support pte_swp_mkexclusive/pte_swp_exclusive/.

As pte_swp_mkexclusive/pte_swp_exclusive/ only applies to actual swap
PTEs, you could even reuse that bit for migration entries and get at
alteast the most relevant 64bit architectures supported easily.

-- 
Thanks,

David / dhildenb

