Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B51D58F97E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiHKIsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbiHKIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0843A915CC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660207692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRRIcx/kAfOd8EtYau1ApQoX7Wlp1XgJ+KDqlaJLHkM=;
        b=TcIOJpq8IPX7TkxqH/eIQORCvluPhSjwTOaX7BTyw9BU5GZ6c4UctgEzKKb7CkJCADqv24
        PbIiaHmTkataBAsE82S242XeFwHNOfRm2NwJaKln0Eo3vbrAWqHN++N8SM5Tpip+t23/kF
        1DdgivzKgX8yVW4Wsf/JaHaq/7Fax3s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-314-T03hsyQHNjCwUnBrDKXMuQ-1; Thu, 11 Aug 2022 04:48:11 -0400
X-MC-Unique: T03hsyQHNjCwUnBrDKXMuQ-1
Received: by mail-wm1-f72.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so1435170wmp.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=WRRIcx/kAfOd8EtYau1ApQoX7Wlp1XgJ+KDqlaJLHkM=;
        b=U/spOQPQA60GZKoBzkKTxO887AoQf6V72A6YzHZL3z4k3ud2WnC/fJuN0YaqXXBVWM
         fT3V/iiTZ/IQp6Xvmki/y8GntXwmCWTcNgHi1nrTtZn5sH2AZJ7Awc5v6iQnX2xWNWIn
         TV/QFNl6pnfEdwFAOMC3I4EHPIBtSWce35Hnqmw/d7z1bZ4BupnP0oMTPQ9UBh4LfZ5Z
         UYIzFjaAiOpOBbL5HwT2jv4tlsUZZCZqW3BoHtuE+Vdgaa8yGF9hkC9a4eioW+Otkntf
         gKHlADObpX7gia+VeVBKYgXRztc5CAVr7XyH/JAkbyaFHiE/KxjM+tyh16fSj/AYL8Zy
         xlyQ==
X-Gm-Message-State: ACgBeo3svlGvR+DBVnV0G9qTUqmJdhrfCr+hH3MSTgHFNqZgkxenTXc7
        Ne7lJUE4YWPgJXBnsVtMQEG4rXLSw66FBsxnMctyZv2XBsRKLUQ7kwzdaY6vnk2g2GlldGoyZ+C
        U5QYdDRKE5RWZ0U7Oqff5ayoW
X-Received: by 2002:a05:600c:a0b:b0:39e:22ef:1a0 with SMTP id z11-20020a05600c0a0b00b0039e22ef01a0mr5003913wmp.46.1660207689816;
        Thu, 11 Aug 2022 01:48:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7+D4QEaXbqdi3hbwqAcTyKEKN9dtwY8eSgn7I2KYFMOhUl7xukf7Zbaeqx5TWiJqsvhjI7pw==
X-Received: by 2002:a05:600c:a0b:b0:39e:22ef:1a0 with SMTP id z11-20020a05600c0a0b00b0039e22ef01a0mr5003897wmp.46.1660207689531;
        Thu, 11 Aug 2022 01:48:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:2e00:4009:47dc:d0e5:dcd2? (p200300cbc7082e00400947dcd0e5dcd2.dip0.t-ipconnect.de. [2003:cb:c708:2e00:4009:47dc:d0e5:dcd2])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d6441000000b0021eb309c97dsm18589064wrw.25.2022.08.11.01.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 01:48:09 -0700 (PDT)
Message-ID: <3d2c6064-1912-b3e3-61bc-5edf57b01310@redhat.com>
Date:   Thu, 11 Aug 2022 10:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <Yu1dkZeBwv0SUQMq@xz-m1.local>
 <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
 <YvE0OwsyQEL3K5Hm@xz-m1.local>
 <8b317ac7-f80e-4aab-4ad1-4e19a1a0740f@redhat.com>
 <YvFwU4e3WOSRseh6@xz-m1.local> <YvGJQaYeT9Y8PlDX@xz-m1.local>
 <12c65d91-5fc0-cb2e-c415-2b3447960b43@redhat.com>
 <YvQHKCylnFjgkFtw@xz-m1.local>
 <b3efd062-1548-cf80-dd1c-21f144887b9b@redhat.com>
 <YvQMhonK5cC4MXiQ@xz-m1.local> <YvRFa5YF3BQNb0ME@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
In-Reply-To: <YvRFa5YF3BQNb0ME@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.22 01:55, Mike Kravetz wrote:
> On 08/10/22 15:52, Peter Xu wrote:
>> On Wed, Aug 10, 2022 at 09:40:11PM +0200, David Hildenbrand wrote:
>>> On 10.08.22 21:29, Peter Xu wrote:
>>>> On Wed, Aug 10, 2022 at 11:37:13AM +0200, David Hildenbrand wrote:
>>>>> On 09.08.22 00:08, Peter Xu wrote:
>>>>>> On Mon, Aug 08, 2022 at 04:21:39PM -0400, Peter Xu wrote:
>>>>>>> On Mon, Aug 08, 2022 at 06:25:21PM +0200, David Hildenbrand wrote:
>>>>>>>>>> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
>>>>>>>>>> unfortunately wrong.
>>>>>>>>>>
>>>>>>>>>> If you're curious, take a look at f83a275dbc5c ("mm: account for
>>>>>>>>>> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
>>>>>>>>>> and mmap() code.
>>>>>>>>>>
>>>>>>>>>> Long story short: if the file is read-only, we only have VM_MAYSHARE but
>>>>>>>>>> not VM_SHARED (and consequently also not VM_MAYWRITE).
>>>>>>>>>
>>>>>>>>> To ask in another way: if file is RO but mapped RW (mmap() will have
>>>>>>>>> VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
>>>>>>>>> won't we grant write bit errornously while we shouldn't? As the user
>>>>>>>>> doesn't really have write permission to the file.
>>>>>>>>
>>>>>>>> Thus the VM_WRITE check. :)
>>>>>>>>
>>>>>>>> I wonder if we should just do it cleanly and introduce the maybe_mkwrite
>>>>>>>> semantics here as well. Then there is no need for additional VM_WRITE
>>>>>>>> checks and hugetlb will work just like !hugetlb.
>>>>>>>
>>>>>>> Hmm yeah I think the VM_MAYSHARE check is correct, since we'll need to fail
>>>>>>> the cases where MAYSHARE && !SHARE - we used to silently let it pass.
>>>>>>
>>>>>> Sorry I think this is a wrong statement I made..  IIUC we'll fail correctly
>>>>>> with/without the patch on any write to hugetlb RO regions.
>>>>>>
>>>>>> Then I just don't see a difference on checking VM_SHARED or VM_MAYSHARE
>>>>>> here, it's just that VM_MAYSHARE check should work too like VM_SHARED so I
>>>>>> don't see a problem.
>>>>>>
>>>>>> It also means I can't think of any valid case of having VM_WRITE when
>>>>>> reaching here, then the WARN_ON_ONCE() is okay but maybe also redundant.
>>>>>> Using maybe_mkwrite() seems misleading to me if FOLL_FORCE not ready for
>>>>>> hugetlbfs after all.
>>>>>>
>>>>>
>>>>> The main reason we'd have it would be to scream out lout and fail
>>>>> gracefully if someone would -- for example -- use it for something like
>>>>> FOLL_FORCE.
>>>>
>>>> Having that WARN_ON_ONCE() is okay to me, but just to double check we're on
>>>> the same page: why there's concern on using FOLL_FORCE? IIUC we're talking
>>>> about shared mappings here, then no FOLL_FORCE possible at all?  IOW,
>>>> "!is_cow_mapping()" should fail in check_vma_flags() already.
>>>
>>> This code path also covers the anon case.
>>
>> But this specific warning is under the VM_MAYSHARE if clause just added in
>> this patch?
>>
>> My understanding is any FOLL_FORCE will always constantly fail before this
>> patch, and it should keep failing as usual and I don't see any case it'll
>> be failing at the warn_on_once here.
>>
>> So again, I'm fine with having the warning, but I just want to make sure
>> what you want to capture is what you expected..
>>
>>>>
>>>> The other thing is I'm wondering whether patch 2 should be postponed anyway
>>>> so that we can wait for a full resolution of the problem from Mike.
>>>
>>> To make the code more robust and avoid any other such surprises I prefer
>>> to have this in rather earlier than later.
>>>
>>> As the commit says "Let's add a safety net ..."
>>
>> Sure, no strong opinion.  I'll leave that to Mike.  Thanks,
>>
> 
> Sorry that I am not contributing to this thread more.  Need to spend
> some time educating myself on the relatively new semantics here.
> 
> As mentioned, softdirty is on my todo list but has been there for over a
> year.  So, better to add a safety net until that code moves forward.
> 
> However, just for clarification.  The only way we KNOW of to encounter
> these situations today via softdirty.  Patch 1 takes care of that.  This
> patch catches any unknown ways we may get here.  Correct?  i.e. We don't
> really expect to exercise these code paths.

While I do love a good challenge on a Thursday morning, I wish I could
spend less time writing reproducers and arguing about obviously shaky
code ;) . Having that said, there is a flaw in uffd-wp that will end up
in the same code path and similarly mess up.

I'll resend including the reproducer. Note that I'll be on vacation for
~ 1.5 weeks.

-- 
Thanks,

David / dhildenb

