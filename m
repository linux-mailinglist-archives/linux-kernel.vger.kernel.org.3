Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12064D39E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiCITRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiCITRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:17:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A19A114FDE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646853359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8u+7tNvLmG2m1vlbYy9gZs+lrLcAJdUTzhBQfTfm8/8=;
        b=O7t0FW80LUUT6EURtnWxl/IXgOMQHMp68fx0y/ZjEJdUXhOXIvp9QINI92BTehKQaONA5Q
        +vkO9KW+FxwPctsdJ9+gpirjmL87jhnVs1WW0UJAU/mOadEN6XP+iKcGNF+OaLTQ53CXcg
        +rdgpxe80NbQUp9gKkngqKsJbClcPvY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-ZEXxmVxUNCG9LOwA8h2yQg-1; Wed, 09 Mar 2022 14:15:57 -0500
X-MC-Unique: ZEXxmVxUNCG9LOwA8h2yQg-1
Received: by mail-wm1-f72.google.com with SMTP id m34-20020a05600c3b2200b0038115c73361so1136792wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 11:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8u+7tNvLmG2m1vlbYy9gZs+lrLcAJdUTzhBQfTfm8/8=;
        b=Bftuc6sJC8xL5ITAg5cj1GaedR1tvGW1lAAVKNQJeBkh7Xuy/D7Ds6B/hUHdyOcN0K
         ZZdeDWVSnOBKLCRF2VOtyZJP3fwLnQ02s3MWJdT/PsvZwQERxBHVGM1inrGA0oMtxDiL
         WZWuom8Q9NjLe1D/wlanOfHz2N8wUg74vWjbLKCiltUF3LYYQaubEYSKQk71Vej/0XMj
         P7+s54AKesyCkr+PCWaf2zC2+5w1h83i9h121JplOUqDU+NJowq+t8gzYYsRbJuYQ9vd
         vbORB+r2uMurnDFjqd90M/a5k+9cQZ7/e3lrTMIYcKhdPy7X+LO+wZJl8jqodsZWXpAS
         bBrA==
X-Gm-Message-State: AOAM532Xw8Px3LYZcMmBsLosjsSUK9bXG+UbJ+COev+AkbhWBcvUxJwT
        nQ8+wRopbvIm23bubepmU8krO3phGVeYd6omCNq/uIy/gF95xuZjzNbJBByCTlq9ci8eaJy34Y2
        bLWHso1jU4zUUdqd6jzfb0zDo
X-Received: by 2002:a5d:59a2:0:b0:1f1:f3af:a069 with SMTP id p2-20020a5d59a2000000b001f1f3afa069mr845949wrr.581.1646853356489;
        Wed, 09 Mar 2022 11:15:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcP9keRv3UQ3cTcwHG1pYQLWUkqChIRH1t4JepaQN83RkcZ7XWUgDLb5f6ntlqfCFWdEszAA==
X-Received: by 2002:a5d:59a2:0:b0:1f1:f3af:a069 with SMTP id p2-20020a5d59a2000000b001f1f3afa069mr845925wrr.581.1646853356230;
        Wed, 09 Mar 2022 11:15:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6300:8418:c653:d01f:3bd2? (p200300cbc70763008418c653d01f3bd2.dip0.t-ipconnect.de. [2003:cb:c707:6300:8418:c653:d01f:3bd2])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b00389d6331f93sm1085737wms.3.2022.03.09.11.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:15:55 -0800 (PST)
Message-ID: <a01de28c-2195-eab3-fd3c-0e8ad3f58040@redhat.com>
Date:   Wed, 9 Mar 2022 20:15:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/9] mm: slightly clarify KSM logic in do_swap_page()
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Linux MM <linux-mm@kvack.org>
References: <20220131162940.210846-1-david@redhat.com>
 <20220131162940.210846-4-david@redhat.com>
 <CAHbLzkpoNeSPyzGV9arXK7BrVWpERy0yGRggn1ZaRam8RrHyRQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHbLzkpoNeSPyzGV9arXK7BrVWpERy0yGRggn1ZaRam8RrHyRQ@mail.gmail.com>
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

On 09.03.22 19:48, Yang Shi wrote:
> On Mon, Jan 31, 2022 at 8:33 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Let's make it clearer that KSM might only have to copy a page
>> in case we have a page in the swapcache, not if we allocated a fresh
>> page and bypassed the swapcache. While at it, add a comment why this is
>> usually necessary and merge the two swapcache conditions.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/memory.c | 38 +++++++++++++++++++++++---------------
>>  1 file changed, 23 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 923165b4c27e..3c91294cca98 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3615,21 +3615,29 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>                 goto out_release;
>>         }
>>
>> -       /*
>> -        * Make sure try_to_free_swap or reuse_swap_page or swapoff did not
> 
> We could remove the reference to "reuse_swap_page", right?
>
Yes, I noticed this a couple of days ago as well and already have a
patch prepared for that ("mm: adjust stale comment in do_swap_page()
mentioning reuse_swap_page()" at
https://github.com/davidhildenbrand/linux/commits/cow_fixes_part_3)

If Andrew wants, we can fix that up directly before sending upstream or
I'll simply include that patch when sending out part2 v2.

(I want to avoid sending another series just for this)

Thanks!

-- 
Thanks,

David / dhildenb

