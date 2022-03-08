Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43F84D12E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiCHIy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiCHIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:54:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B4E73B03C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646729609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=McCP1GFFVgE7UURnAsPiV2iHmS5OBmDZ+4yFuy2Ffa4=;
        b=Qeo5lWVQXRBzlPSwdOBegep/NHhHswxVDlzrTD1Pp63fd3YeUXbPtNQ0xtdgYX/e3lNREa
        T6Cd+k9q4LHbHp/kMdWbGFbpxW9x/KFG3HomzQhgnunA7pCHqkEk0vkeyynLQb0W0K59DP
        GA5+ssvOm4YKMXl7cQHeGvRB50hgvEk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-KrRGLddHO8SWls6frIkM9A-1; Tue, 08 Mar 2022 03:53:28 -0500
X-MC-Unique: KrRGLddHO8SWls6frIkM9A-1
Received: by mail-wm1-f72.google.com with SMTP id f24-20020a1c6a18000000b00388874b17a8so820394wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=McCP1GFFVgE7UURnAsPiV2iHmS5OBmDZ+4yFuy2Ffa4=;
        b=E0xT+n2Uw5sgxS0+KYFXKqlnuJmj9wxwAo8RXHbqOkiqAMwesjtjifZMubOn44/IN1
         kpBJrykRtNGF4jPO5PyVtMLf2OB5UoO8ztkywZHH6GGiCtPTgFbCU0X+z/jwGkbOONck
         pKc91GM+2aNki2UaAbrtOvl0DOo501l+8El7otkIEoLx4wZzgQtYMcevV4cY1fQbkmpy
         iMAhhTDT9+NyJBYAXg1tjGNsBfygv1N2iUrObA3Cs+l1qOepYjRWIUHSFzP/61JMVMbg
         ROZyXPUVv4sjlFGEowTjc8J9Lca//M0qb9bNmqN5/SKRyQp4CdXyrp1DMZXikpVq5J9a
         62/A==
X-Gm-Message-State: AOAM5315e/FFrJ9JTcOJLbSv9BtI5PgmpxGCSZxF6QGMSoFvyNmvmRCo
        gIcoSWcGm1p4JkoB/1jT0uLOCFjXMSFdnD3vhoUXY9FXMne8yTsapu8mKSTodatQmLFrQh1QUk/
        qDn5LArut1TgMlRqAv0LrNE5N
X-Received: by 2002:a05:600c:4f4f:b0:37b:d847:ef15 with SMTP id m15-20020a05600c4f4f00b0037bd847ef15mr2570090wmq.130.1646729607074;
        Tue, 08 Mar 2022 00:53:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfE9toN3qehdJsk1B+YMs1118DTmEo7CTeTOm9RdOjB8ja6Hj8ALlXAHzetoDJ35FFQ2+evg==
X-Received: by 2002:a05:600c:4f4f:b0:37b:d847:ef15 with SMTP id m15-20020a05600c4f4f00b0037bd847ef15mr2570068wmq.130.1646729606832;
        Tue, 08 Mar 2022 00:53:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id o11-20020adf9d4b000000b001f0077ea337sm13785536wre.22.2022.03.08.00.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:53:26 -0800 (PST)
Message-ID: <9f7431c6-4021-4821-e71e-296dd328c1a9@redhat.com>
Date:   Tue, 8 Mar 2022 09:53:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting
 PMD
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220303222014.517033-1-shy828301@gmail.com>
 <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
 <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
 <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com>
 <20220306180718.6d4e6233130b94fdad98df88@linux-foundation.org>
 <84a6c9c1-d18f-6955-2666-0a2d7bce6094@redhat.com>
 <20220307154326.6494f7fca7def491a23e5df1@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220307154326.6494f7fca7def491a23e5df1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.22 00:43, Andrew Morton wrote:
> On Mon, 7 Mar 2022 09:24:58 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 07.03.22 03:07, Andrew Morton wrote:
>>> On Fri, 4 Mar 2022 19:50:08 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> @Andrew, the last mail I received was
>>>>
>>>> + mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
>>>> added to -mm tree
>>>>
>>>> The patch shows up in mmotm as
>>>>
>>>> #[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
>>>>
>>>> ... which shouldn't be true.
>>>
>>> I guess I mislabelled the reason for dropping it.  Should have been to-be-updated, 
>>> due to https://lkml.kernel.org/r/CAHbLzkpbnQyHRckoRtbZoaLvANu92MY4kEsbKudaQ8MDUA3nVg@mail.gmail.com
>>>
>>
>> Let me clarify.
>>
>> 1. I sent [1] (9 patches)
>>
>> 2. You queued the 9 patches
>>
>> E.g., in "mmotm 2022-02-15-20-22 uploaded"
>>
>> * mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
>> * mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
>> * mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
>> * mm-streamline-cow-logic-in-do_swap_page.patch
>> * mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
>> * mm-khugepaged-remove-reuse_swap_page-usage.patch
>> * mm-swapfile-remove-stale-reuse_swap_page.patch
>> * mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
>> * mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
>>
>> 3. The last patch in the series was dropped. What remains are 8 patches.
>>
>> E.g., in "mmotm 2022-02-24-22-38 uploaded"
>>
>> * mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
>> * mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
>> * mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
>> * mm-streamline-cow-logic-in-do_swap_page.patch
>> * mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
>> * mm-khugepaged-remove-reuse_swap_page-usage.patch
>> * mm-swapfile-remove-stale-reuse_swap_page.patch
>> * mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
>>
>> 4. Yang Shi sent his patch (the one we're replying to)
>>
>> 5. You picked his patch and dropped it again due to [2]
>>
>>
>> I'm wondering why 3 happened and why
>> https://www.ozlabs.org/~akpm/mmotm/series contains:
>>
>>
>> mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
>> mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
>> mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
>> mm-streamline-cow-logic-in-do_swap_page.patch
>> mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
>> mm-khugepaged-remove-reuse_swap_page-usage.patch
>> mm-swapfile-remove-stale-reuse_swap_page.patch
>> mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
>> ...
>> #[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> 
> OK, thanks.  I guess it was me seeing 100% rejects when merging onto
> the folio changes then incorrectly deciding the patch was now in
> linux-next via some other tree.
> 

Thanks Andrew, my 2 cents would have been that my series, which fixes
actual CVEs should go in before folio cleanups. But that's a different
discussion (and the patch is question is just a cleanup part of the same
series, so i don't particularly care).

> I restored it and fixed things up.  Please check.
> 

That change looks good to me. I'd even say that we do the second cleanup
separately, with Yang Shi being the author. But whatever you+others prefer.


-- 
Thanks,

David / dhildenb

