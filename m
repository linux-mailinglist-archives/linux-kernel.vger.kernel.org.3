Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C088E5ACD61
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiIEIC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiIEICZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA46146DAD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662364944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80o6ny7YakZDOnj5vfvOfcJ/mpd+JzIMV0KWiRtG7lU=;
        b=fJFy4GlBd8BLA2gOWTEELgZ0uyLV8AY738ZP6jInPqMGhEPWDBvDF2ItO5gWNLhadSnFr5
        Hc19HEX7A+jNyc0wK+JRHIcxQUETUlhfU7b02//Q+WyO2Zmx7rsUA6MrN9Y/L98ZPYfndW
        jv0bp4ICaGFkghuRXGElTRsETdJuObQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-ZX8jM9PqNr2fhbh8wFjjjA-1; Mon, 05 Sep 2022 04:02:23 -0400
X-MC-Unique: ZX8jM9PqNr2fhbh8wFjjjA-1
Received: by mail-wr1-f70.google.com with SMTP id d16-20020adfa350000000b00228628ff913so471911wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=80o6ny7YakZDOnj5vfvOfcJ/mpd+JzIMV0KWiRtG7lU=;
        b=uUwbP6ULZ2kx0XCCAlgXw3zn2wz/Vumu5G7KMTO4kL62zeb08WwMTkZqfKnIRaN1Iu
         bvJ12Mwa8BY8bwcpUs/lNDZhzxJfj/wo4vfC3c23LOrZBMBGgA7oDjTL4Gy9aiiPXdXI
         epKKgaGCwVb15pFjm/mRtxg0pDylTbatcWyOl0PlOBXaFpUk1q5RJS/29TtG6e/u6isT
         q7YxkZD2wFHj4qf/YoAzF0oe7UZIkiD2/AiJ8Rn4WR7rxKFosWR3M04s2U4vhSekYIg7
         PRY1G+U5li7R8ZoBx/mpFXT5KS/f+qsUw/dJLcD2c1xC0KMr3HoRjftRCpuJLeyFkGxZ
         dkzw==
X-Gm-Message-State: ACgBeo1nF43wUeQFVKzP4Pdgd40SBNsrhqkla2voNdXx6KOGrbHo6Ux1
        SC4qmvVaTxzYwQs3pSpZbNO1XwCW4f+WxiZjYEsyDWS3+4UQ5pG5eKpwEZdeTTy8cNJ+SqPQQC/
        QEBNytOaOThVcvEPxWEhFMMBK
X-Received: by 2002:adf:a70b:0:b0:226:e1f5:7889 with SMTP id c11-20020adfa70b000000b00226e1f57889mr16352336wrd.108.1662364941757;
        Mon, 05 Sep 2022 01:02:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5VeKqJD8BKp8XpvDhFCd96ryOyjUPbABjHSgBOg/ayTO4RsUpd+w9B1tIi6UZfKUFXOQv4wQ==
X-Received: by 2002:adf:a70b:0:b0:226:e1f5:7889 with SMTP id c11-20020adfa70b000000b00226e1f57889mr16352310wrd.108.1662364941490;
        Mon, 05 Sep 2022 01:02:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id a19-20020a1cf013000000b003a5537bb2besm10092257wmb.25.2022.09.05.01.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 01:02:20 -0700 (PDT)
Message-ID: <a55a15fb-210a-39d3-cc68-78ba8f9f254f@redhat.com>
Date:   Mon, 5 Sep 2022 10:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Content-Language: en-US
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
 <bb46d28c-57e3-4cfd-b5b3-e4c6db1f003f@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <bb46d28c-57e3-4cfd-b5b3-e4c6db1f003f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.22 18:49, Aneesh Kumar K V wrote:
> On 9/1/22 10:04 PM, David Hildenbrand wrote:
>> On 01.09.22 18:28, Peter Xu wrote:
>>> On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
>>>> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
>>>> PMDs") didn't remove all details about the THP split requirements for
>>>> RCU GUP-fast.
>>>>
>>>> IPI broeadcasts on THP split are no longer required.
>>>>
>>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Cc: Sasha Levin <sasha.levin@oracle.com>
>>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>>> Cc: Jerome Marchand <jmarchan@redhat.com>
>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>>> Cc: Peter Xu <peterx@redhat.com>
>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>   mm/gup.c | 5 ++---
>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>> index 5abdaf487460..cfe71f422787 100644
>>>> --- a/mm/gup.c
>>>> +++ b/mm/gup.c
>>>> @@ -2309,9 +2309,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>>>>    *
>>>>    * Another way to achieve this is to batch up page table containing pages
>>>>    * belonging to more than one mm_user, then rcu_sched a callback to free those
>>>> - * pages. Disabling interrupts will allow the fast_gup walker to both block
>>>> - * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
>>>> - * (which is a relatively rare event). The code below adopts this strategy.
>>>> + * pages. Disabling interrupts will allow the fast_gup walker to block the
>>>> + * rcu_sched callback.
>>>
>>> This is the comment for fast-gup in general but not only for thp split.
>>
>> "an IPI that we broadcast for splitting THP" is about splitting THP.
>>
>>>
>>> I can understand that we don't need IPI for thp split, but isn't the IPIs
>>> still needed for thp collapse (aka pmdp_collapse_flush)?
>>
>> That was, unfortunately, never documented -- and as discussed in the
>> other thread, arm64 doesn't do that IPI before collapse and might need
>> fixing. We'll most probably end up getting rid of that
>> (undocumented/forgotten) IPI requirement and fix it in GUP-fast by
>> re-rechecking if the PMD changed.
>>
> 
> Can you point to the other thread ?

Sure

see

https://lkml.kernel.org/r/CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com

and a resulting patch from that discussion

https://lkml.kernel.org/r/20220901222707.477402-1-shy828301@gmail.com

-- 
Thanks,

David / dhildenb

