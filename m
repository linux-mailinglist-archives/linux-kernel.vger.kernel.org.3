Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0A5A86C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiHaTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiHaTdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A09EE86B3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661974416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UqeSI+PCWfCsmnj3LueCL7MyoyIRpFEzhaDk1BD2TtU=;
        b=Ug7jpHhCfgMXLEJ7XxJTnB6suNehvfseIQxgCLmbYF3/cW+rhU0XnOxNHUFhF3DAMXxeyA
        ij1EBsnxZJn/hXJceGf2C5/3YbdtJcwTU/NgJIPaQ0tHXrxWIJevO7KmcmC2zPX2hv3iWi
        p6oOD/mir0W5udWVL+3IgnX+xy3LmbI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-MnVr8URDNbiGpu_GPVoirQ-1; Wed, 31 Aug 2022 15:33:35 -0400
X-MC-Unique: MnVr8URDNbiGpu_GPVoirQ-1
Received: by mail-wm1-f70.google.com with SMTP id c5-20020a7bc005000000b003a63a3570f2so52628wmb.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=UqeSI+PCWfCsmnj3LueCL7MyoyIRpFEzhaDk1BD2TtU=;
        b=PuNXcPZtoo1zrB6ey3WRA/In/Z+zPga37or2iGmO/Yug+BS9ArMWunTQ8+cO4WibiV
         Y4hxjjThSzJu4pcN/+N+E+JUln0209B04y+JnWFUf/dcOLL8komfiHFwFI6HoUvd5Mfq
         SK+pWQWn8lRkIzTp24T3VOaSBwMXAQYMz51OxJXxyK+teQD/2UviMaUL7WjI+oOVXMnO
         vh+jz+gaM3KhckStj7uIEwvbizUzic8WPS06WeRjjQ60xp0LeMsB4DA8FrspCyQVN7mB
         EQEfEzyrmn9SBm/8+XtNVd/nU7bAzwDVhhJgUg2zedMlQIAvyLR137x7Uf8M2/9PiTWW
         0IAQ==
X-Gm-Message-State: ACgBeo2CbfUwoIqnnyOaqJwtkZUxqybfeRUwqlhKSdDsGByxphdkw+ke
        qhTgZLB0PvGcWV3n7OeJTdARNK3U6soU1TNrIauj4WuOKA/p9/7n+u8DBERFFub12ugT8lyqB3J
        Pk6F9MwlN99TicCFbTnJT6njO
X-Received: by 2002:a5d:4243:0:b0:226:d45a:3ca6 with SMTP id s3-20020a5d4243000000b00226d45a3ca6mr11319573wrr.588.1661974413855;
        Wed, 31 Aug 2022 12:33:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5cqVLd0vaAJsaAhfmYELGkiIyNKNB/GXQqVkzak4unNSaEWjD9RzuZpOJA3n1ed6OiYJEp4Q==
X-Received: by 2002:a5d:4243:0:b0:226:d45a:3ca6 with SMTP id s3-20020a5d4243000000b00226d45a3ca6mr11319564wrr.588.1661974413633;
        Wed, 31 Aug 2022 12:33:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2900:1613:4308:aca3:2786? (p200300cbc706290016134308aca32786.dip0.t-ipconnect.de. [2003:cb:c706:2900:1613:4308:aca3:2786])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b003a342933727sm3201581wmb.3.2022.08.31.12.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 12:33:31 -0700 (PDT)
Message-ID: <9378bae6-e84f-113f-b41c-60a09c095243@redhat.com>
Date:   Wed, 31 Aug 2022 21:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20220831083024.37138-1-david@redhat.com>
 <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com>
 <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
 <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com>
Organization: Red Hat
In-Reply-To: <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 21:15, David Hildenbrand wrote:
> On 31.08.22 21:08, Yang Shi wrote:
>> On Wed, Aug 31, 2022 at 11:29 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 31.08.22 19:55, Yang Shi wrote:
>>>> On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> The comment is stale, because a TLB flush is no longer sufficient and
>>>>> required to synchronize against concurrent GUP-fast. This used to be true
>>>>> in the past, whereby a TLB flush would have implied an IPI on architectures
>>>>> that support GUP-fast, resulting in GUP-fast that disables local interrupts
>>>>> from completing before completing the flush.
>>>>
>>>> Hmm... it seems there might be problem for THP collapse IIUC. THP
>>>> collapse clears and flushes pmd before doing anything on pte and
>>>> relies on interrupt disable of fast GUP to serialize against fast GUP.
>>>> But if TLB flush is no longer sufficient, then we may run into the
>>>> below race IIUC:
>>>>
>>>>          CPU A                                                CPU B
>>>> THP collapse                                             fast GUP
>>>>
>>>> gup_pmd_range() <-- see valid pmd
>>>>
>>>> gup_pte_range() <-- work on pte
>>>> clear pmd and flush TLB
>>>> __collapse_huge_page_isolate()
>>>>     isolate page <-- before GUP bump refcount
>>>>
>>>>    pin the page
>>>> __collapse_huge_page_copy()
>>>>     copy data to huge page
>>>>     clear pte (don't flush TLB)
>>>> Install huge pmd for huge page
>>>>
>>>> return the obsolete page
>>>
>>> Hm, the is_refcount_suitable() check runs while the PTE hasn't been
>>> cleared yet. And we don't check if the PMD changed once we're in
>>> gup_pte_range().
>>
>> Yes
>>
>>>
>>> The comment most certainly should be stale as well -- unless there is
>>> some kind of an implicit IPI broadcast being done.
>>>
>>> 2667f50e8b81 mentions: "The RCU page table free logic coupled with an
>>> IPI broadcast on THP split (which is a rare event), allows one to
>>> protect a page table walker by merely disabling the interrupts during
>>> the walk."
>>>
>>> I'm not able to quickly locate that IPI broadcast -- maybe there is one
>>> being done here (in collapse) as well?
>>
>> The TLB flush may call IPI. I'm supposed it is arch dependent, right?
>> Some do use IPI, some may not.
> 
> Right, and the whole idea of the RCU GUP-fast was to support
> architectures that don't do it. x86-64 does it. IIRC, powerpc doesn't do
> it -- but maybe it does so for PMDs?

Looking into the details (and the outdated comment for gup_pte_range()
we should fixup), THP splitting used in the past pmdp_splitting_flush()
for triggering an IPI broadcast.

However, that has been removed in 4b471e8898c3 ("mm, thp: remove
infrastructure for handling splitting PMDs") due to refcount handling
changes that no longer require it.

Consequently, I don't think we can expect an IPI broadcast to sync with
GUP-fast at that point ...

-- 
Thanks,

David / dhildenb

