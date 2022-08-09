Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0D58D5AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbiHIIs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbiHIIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBAB3220FF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660034883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5EGFbFs/lIL/rbVEQQvHXXCPRsVB0qqjyg3GENEnkVI=;
        b=OBh6akwaf8hwEVxjP1KGEmAa5cMA0BRzoExYZmY3dM052doLhOT0953oCQw0gPW5r30NHY
        qNjfe3JeuGs3s4x3mbNq0WqKcN6/JTT0yqfMwxhJt+eodS2+2g5XBlsqe8KtYcrlXjliTF
        +z6hMZQp7yXXlv0H56tQaUNSOc1alo4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-aBH_vENmO3S4XXRsaUvaYQ-1; Tue, 09 Aug 2022 04:47:57 -0400
X-MC-Unique: aBH_vENmO3S4XXRsaUvaYQ-1
Received: by mail-wm1-f71.google.com with SMTP id a17-20020a05600c349100b003a545125f6eso2312894wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 01:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=5EGFbFs/lIL/rbVEQQvHXXCPRsVB0qqjyg3GENEnkVI=;
        b=AOzXmzIp/y1xPHkvQmLPQFwYiUOjlk7rH/We+VCiKLiC1eKqjDKSqu/Eyb6eZZN4XE
         Qs962VWVbZXg1b5JDGjjnjLGF5SGVUyUXuUZbwaX9cTgxcQHWcSQAIoHjR9ddiP7nP1C
         NYAPvP8Fka6ZmDCb2xOXfsBQ4OjtuPGdaQh/xeG8+jre3OCYcoAs+u4L5yIIZ9rUsMS4
         xF9zS1HQK4RGnaw3ob31f0ScFcIvKlAG28UylAjA/ytZlYkIhhBBXncqqCDrJkiBWo/X
         p2J9WTIGhVcgEZqxRiTKxxGgntA4Pkd2wjTnJBU/nJeMKYMx4/n1tLFpHoyy828I6bFb
         MZhg==
X-Gm-Message-State: ACgBeo3ENrTOUPdEqT1/9DQTeu5WLwuk2iZLxWXgE1tiQfNebC85OGCO
        2xg7kMBl2lpVt+JH05aiHZXiwcgJGypKbLEbrU+h1kmZOZyzDBZYSMmk6uy13yslMUgeYrJRylx
        tjHS+BIk5qRFQxkrlH6DpE8K8
X-Received: by 2002:a7b:c7d4:0:b0:3a5:737:3e1e with SMTP id z20-20020a7bc7d4000000b003a507373e1emr14879044wmk.123.1660034876210;
        Tue, 09 Aug 2022 01:47:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7GkOe3DiUhn6hWYT/VPDPl0RZniR9c9EXzdSmPH2Lktl0vfRlWVelZH/yZ0Dun96bpZJE5Hw==
X-Received: by 2002:a7b:c7d4:0:b0:3a5:737:3e1e with SMTP id z20-20020a7bc7d4000000b003a507373e1emr14879030wmk.123.1660034875968;
        Tue, 09 Aug 2022 01:47:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:c300:d2ce:1fb5:2460:179a? (p200300d82f15c300d2ce1fb52460179a.dip0.t-ipconnect.de. [2003:d8:2f15:c300:d2ce:1fb5:2460:179a])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b003a3199c243bsm28577241wmq.0.2022.08.09.01.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 01:47:55 -0700 (PDT)
Message-ID: <ccd1ecd3-f754-0048-6073-39fb83ed1f93@redhat.com>
Date:   Tue, 9 Aug 2022 10:47:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>, Peter Xu <peterx@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20220804203952.53665-1-peterx@redhat.com>
 <20220804203952.53665-3-peterx@redhat.com>
 <A84CB6A0-86C8-4CAB-A977-47495D877C31@gmail.com>
 <Yu1FkCkjJ00+H0sF@xz-m1.local>
 <8735e5hkk3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <8735e5hkk3.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.22 10:45, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Thu, Aug 04, 2022 at 03:40:57PM -0700, Nadav Amit wrote:
>>> On Aug 4, 2022, at 1:39 PM, Peter Xu <peterx@redhat.com> wrote:
>>>> +
>>>> static inline bool is_pfn_swap_entry(swp_entry_t entry);
>>>>
>>>> /* Clear all flags but only keep swp_entry_t related information */
>>>> @@ -265,6 +285,57 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
>>>> 	return swp_entry(SWP_MIGRATION_WRITE, offset);
>>>> }
>>>>
>>>> +/*
>>>> + * Returns whether the host has large enough swap offset field to support
>>>> + * carrying over pgtable A/D bits for page migrations.  The result is
>>>> + * pretty much arch specific.
>>>> + */
>>>> +static inline bool migration_entry_supports_ad(void)
>>>> +{
>>>> +	/*
>>>> +	 * max_swapfile_size() returns the max supported swp-offset plus 1.
>>>> +	 * We can support the migration A/D bits iff the pfn swap entry has
>>>> +	 * the offset large enough to cover all of them (PFN, A & D bits).
>>>> +	 */
>>>> +#ifdef CONFIG_SWAP
>>>> +	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
>>>
>>> This is an actual a function call (unless LTO has some trick). A bit of a
>>> shame it cannot be at least memoized.
>>>
>>> Or at least mark max_swapfile_size() as __attribute_const__ so it would not
>>> be called twice for make_migration_entry_young() and
>>> make_migration_entry_dirty().
>>
>> I didn't take too much effort on this one since we're on swap path and I
>> assumed that's not a super hot path.  But __attribute_const__ sounds good
>> and easy to get, thanks.
>>
>> Perhaps I should mark it on migration_entry_supports_ad() as a whole?  Note
>> that unfortunately SWP_MIG_TOTAL_BITS may not be a const either (see how
>> that define roots back to MAX_PHYSMEM_BITS, where on x86_64 it needs to
>> check 5-lvl).
> 
> I think it's possible to memorize max_swapfile_size() or
> migration_entry_supports_ad().  Although they are not constant, they are
> not changed after initialized.  The challenge is to find a clean way to
> initialize it.

We could max_swapfile_size()->__max_swapfile_size()

and then simply have a new max_swapfile_size() that caches the value in
a static variable. If that turns out to be worth the trouble.

-- 
Thanks,

David / dhildenb

