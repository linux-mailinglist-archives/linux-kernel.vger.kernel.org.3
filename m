Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732595A868D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiHaTPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiHaTPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD1D5F9A3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661973320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OoTRUGFCRCGqc4N4Lf1mF7m1xbctNWtbqZZ4JOPVOxM=;
        b=LGnR6OeBtyKl7onzX80h0txogMKqpUkGM85nd6uQ5oY6DCm+ATrCwzKFxiXDyV9ipxJQKp
        SFeREf5IkF0Zi5xCwhGeworP/bB4yUIKzSe6dwHV7eQxEXFrbK6HbFZQVfDqn8OEB5xvZu
        cgSGCs31mUn/BQXY1oGGuAXF5CRl0xY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-503-aUrPnzJ7Osi5o5v2Jzp6XA-1; Wed, 31 Aug 2022 15:15:13 -0400
X-MC-Unique: aUrPnzJ7Osi5o5v2Jzp6XA-1
Received: by mail-wm1-f70.google.com with SMTP id q10-20020a1ce90a000000b003a60123678aso34254wmc.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=OoTRUGFCRCGqc4N4Lf1mF7m1xbctNWtbqZZ4JOPVOxM=;
        b=4Z3irxeiWAmBX++ntaN7gLieunyZf1zajLVvx6J6Lx6cYKK4j2qkQ66rx3XNsrXD1o
         FonFHxXpuSChKP+RS8uUwrmGk/nC7YBIg0kMlKhIM+nxJ6Vpri1vjJ7eAclME3YOmtBt
         Mk4IfX6IQrdc+FqAr6CXusb8Z65Pnxo2BVfomfV3Ed8Pgat6qPPBYpFlJGezE7P2iGWx
         DRrONKqlpMP47AH1lDGnvk6OYupwOkeC72/GwzbtYW9wi2yCHqv+uSOT4l5C7VdVTNiF
         uT80D87S9sq4fqsTdkqwkT0UhJjBZ0aBKt0a6LytBGWlnmhhUf+FfX5KI6XHGZ6dY388
         MLfw==
X-Gm-Message-State: ACgBeo1tdAAsgZU+rdUUOD+Kitph8M2nYzva2/CqJFBQQyVCe+hIUmtP
        RO9aDOyguqVgQnYKhGKir2oJ+Kgglj2mbecEHIvzwwCSm9AhhbsBjhT+egpbIQZszaEQhoMv3lQ
        rWvoFz96TCr1UE3fct59N0oB/
X-Received: by 2002:adf:a490:0:b0:225:2da4:10ff with SMTP id g16-20020adfa490000000b002252da410ffmr12717625wrb.1.1661973312084;
        Wed, 31 Aug 2022 12:15:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7F7coh0iOwNSgEwYMu/hdq6HxvtLsOaJG5qGdBp234CJFc36CibInsWfni2LUDq0VSb8dTcA==
X-Received: by 2002:adf:a490:0:b0:225:2da4:10ff with SMTP id g16-20020adfa490000000b002252da410ffmr12717610wrb.1.1661973311809;
        Wed, 31 Aug 2022 12:15:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2900:1613:4308:aca3:2786? (p200300cbc706290016134308aca32786.dip0.t-ipconnect.de. [2003:cb:c706:2900:1613:4308:aca3:2786])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600c4e0b00b003a50924f1c0sm3613727wmq.18.2022.08.31.12.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 12:15:11 -0700 (PDT)
Message-ID: <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com>
Date:   Wed, 31 Aug 2022 21:15:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
Content-Language: en-US
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
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

On 31.08.22 21:08, Yang Shi wrote:
> On Wed, Aug 31, 2022 at 11:29 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 31.08.22 19:55, Yang Shi wrote:
>>> On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> The comment is stale, because a TLB flush is no longer sufficient and
>>>> required to synchronize against concurrent GUP-fast. This used to be true
>>>> in the past, whereby a TLB flush would have implied an IPI on architectures
>>>> that support GUP-fast, resulting in GUP-fast that disables local interrupts
>>>> from completing before completing the flush.
>>>
>>> Hmm... it seems there might be problem for THP collapse IIUC. THP
>>> collapse clears and flushes pmd before doing anything on pte and
>>> relies on interrupt disable of fast GUP to serialize against fast GUP.
>>> But if TLB flush is no longer sufficient, then we may run into the
>>> below race IIUC:
>>>
>>>          CPU A                                                CPU B
>>> THP collapse                                             fast GUP
>>>
>>> gup_pmd_range() <-- see valid pmd
>>>
>>> gup_pte_range() <-- work on pte
>>> clear pmd and flush TLB
>>> __collapse_huge_page_isolate()
>>>     isolate page <-- before GUP bump refcount
>>>
>>>    pin the page
>>> __collapse_huge_page_copy()
>>>     copy data to huge page
>>>     clear pte (don't flush TLB)
>>> Install huge pmd for huge page
>>>
>>> return the obsolete page
>>
>> Hm, the is_refcount_suitable() check runs while the PTE hasn't been
>> cleared yet. And we don't check if the PMD changed once we're in
>> gup_pte_range().
> 
> Yes
> 
>>
>> The comment most certainly should be stale as well -- unless there is
>> some kind of an implicit IPI broadcast being done.
>>
>> 2667f50e8b81 mentions: "The RCU page table free logic coupled with an
>> IPI broadcast on THP split (which is a rare event), allows one to
>> protect a page table walker by merely disabling the interrupts during
>> the walk."
>>
>> I'm not able to quickly locate that IPI broadcast -- maybe there is one
>> being done here (in collapse) as well?
> 
> The TLB flush may call IPI. I'm supposed it is arch dependent, right?
> Some do use IPI, some may not.

Right, and the whole idea of the RCU GUP-fast was to support
architectures that don't do it. x86-64 does it. IIRC, powerpc doesn't do
it -- but maybe it does so for PMDs?

-- 
Thanks,

David / dhildenb

