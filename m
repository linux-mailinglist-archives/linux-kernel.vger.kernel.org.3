Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C5058F347
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiHJTkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHJTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23D382DA8F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660160415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywXwFTTYN19k6bKSmUxoUNC6PPsNakVJx+Pwn8GLIOw=;
        b=hDq+rCjuEQjavPwZ9yLpBF83hEDX9XpuqMCt/l18kBEnrjBP9wCMXi9DFLQ4wGF4/btnU4
        7feCwFBNFbtjnF2dv6OZvLk40i16wspNOUBJrreIc4AXEE8Iq5gkUrfcyoidjlQrmB8eo2
        YcQPS55QnuCVyPG32Lv4jn6QAFS+5ps=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-cnevF9BmPQ6PLPyYGbOd2Q-1; Wed, 10 Aug 2022 15:40:13 -0400
X-MC-Unique: cnevF9BmPQ6PLPyYGbOd2Q-1
Received: by mail-wm1-f70.google.com with SMTP id f21-20020a1cc915000000b003a3551598a1so943415wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=ywXwFTTYN19k6bKSmUxoUNC6PPsNakVJx+Pwn8GLIOw=;
        b=wcuk7NBXkCyVaUqNyzTKCHjEaCRw/+++HWR32DX6+/iglPBgE/GfYCAIdbz0BVC2IK
         5BOXwixRAqkIjS7jHGrNPzc3awqBd226XYTgxQYf2KYyCA9FiN2iqAZ+TRvq0LkdZ8Pc
         RpSdrX1sn1pAUE+rf3jVhSnFv6rvH2mpr/BhW5WuRWhGiagsadmauuiJ5qfqwvWPdXdw
         w01wuZdS1UtShgFlqROlyXkPupYGJYSL7tz3v9N+EjKulAAQQpWqIhgbJcv5ghOfw1Rx
         bILM9Mrtvrpr60YaOLS9XTQ+OoYJXfMVhf+79D5kZcUfg15a+lZgGiTE5b6hRaidcpGE
         tKBQ==
X-Gm-Message-State: ACgBeo1RT6TujzHBtYAzClPszMgWxJAf3oiG+XWHQ0Wa1EVyToHioMKc
        nW4bLtjWjy92BIBthUtqzgrUyq8fRGpQ+7q0vhbnKXbtpZtM8TBvYtFNANL9JkbszrT78luHooN
        8zKCgq82Ipu/eR+eSMZ+2PEpN
X-Received: by 2002:a5d:5a94:0:b0:221:6cec:2589 with SMTP id bp20-20020a5d5a94000000b002216cec2589mr16712056wrb.336.1660160412788;
        Wed, 10 Aug 2022 12:40:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5m2be9A/VIlIf4mcJpLGYLozKrToHSPpbPQj+VTs1y3MiK44ruwPLfFlxMAccMpfgCzQhKZA==
X-Received: by 2002:a5d:5a94:0:b0:221:6cec:2589 with SMTP id bp20-20020a5d5a94000000b002216cec2589mr16712049wrb.336.1660160412519;
        Wed, 10 Aug 2022 12:40:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1600:a3ce:b459:ef57:7b93? (p200300cbc7071600a3ceb459ef577b93.dip0.t-ipconnect.de. [2003:cb:c707:1600:a3ce:b459:ef57:7b93])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b003a501ad8648sm3192271wmi.40.2022.08.10.12.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 12:40:12 -0700 (PDT)
Message-ID: <b3efd062-1548-cf80-dd1c-21f144887b9b@redhat.com>
Date:   Wed, 10 Aug 2022 21:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-3-david@redhat.com> <Yu1dkZeBwv0SUQMq@xz-m1.local>
 <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
 <YvE0OwsyQEL3K5Hm@xz-m1.local>
 <8b317ac7-f80e-4aab-4ad1-4e19a1a0740f@redhat.com>
 <YvFwU4e3WOSRseh6@xz-m1.local> <YvGJQaYeT9Y8PlDX@xz-m1.local>
 <12c65d91-5fc0-cb2e-c415-2b3447960b43@redhat.com>
 <YvQHKCylnFjgkFtw@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YvQHKCylnFjgkFtw@xz-m1.local>
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

On 10.08.22 21:29, Peter Xu wrote:
> On Wed, Aug 10, 2022 at 11:37:13AM +0200, David Hildenbrand wrote:
>> On 09.08.22 00:08, Peter Xu wrote:
>>> On Mon, Aug 08, 2022 at 04:21:39PM -0400, Peter Xu wrote:
>>>> On Mon, Aug 08, 2022 at 06:25:21PM +0200, David Hildenbrand wrote:
>>>>>>> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
>>>>>>> unfortunately wrong.
>>>>>>>
>>>>>>> If you're curious, take a look at f83a275dbc5c ("mm: account for
>>>>>>> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
>>>>>>> and mmap() code.
>>>>>>>
>>>>>>> Long story short: if the file is read-only, we only have VM_MAYSHARE but
>>>>>>> not VM_SHARED (and consequently also not VM_MAYWRITE).
>>>>>>
>>>>>> To ask in another way: if file is RO but mapped RW (mmap() will have
>>>>>> VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
>>>>>> won't we grant write bit errornously while we shouldn't? As the user
>>>>>> doesn't really have write permission to the file.
>>>>>
>>>>> Thus the VM_WRITE check. :)
>>>>>
>>>>> I wonder if we should just do it cleanly and introduce the maybe_mkwrite
>>>>> semantics here as well. Then there is no need for additional VM_WRITE
>>>>> checks and hugetlb will work just like !hugetlb.
>>>>
>>>> Hmm yeah I think the VM_MAYSHARE check is correct, since we'll need to fail
>>>> the cases where MAYSHARE && !SHARE - we used to silently let it pass.
>>>
>>> Sorry I think this is a wrong statement I made..  IIUC we'll fail correctly
>>> with/without the patch on any write to hugetlb RO regions.
>>>
>>> Then I just don't see a difference on checking VM_SHARED or VM_MAYSHARE
>>> here, it's just that VM_MAYSHARE check should work too like VM_SHARED so I
>>> don't see a problem.
>>>
>>> It also means I can't think of any valid case of having VM_WRITE when
>>> reaching here, then the WARN_ON_ONCE() is okay but maybe also redundant.
>>> Using maybe_mkwrite() seems misleading to me if FOLL_FORCE not ready for
>>> hugetlbfs after all.
>>>
>>
>> The main reason we'd have it would be to scream out lout and fail
>> gracefully if someone would -- for example -- use it for something like
>> FOLL_FORCE.
> 
> Having that WARN_ON_ONCE() is okay to me, but just to double check we're on
> the same page: why there's concern on using FOLL_FORCE? IIUC we're talking
> about shared mappings here, then no FOLL_FORCE possible at all?  IOW,
> "!is_cow_mapping()" should fail in check_vma_flags() already.

This code path also covers the anon case.
> 
> The other thing is I'm wondering whether patch 2 should be postponed anyway
> so that we can wait for a full resolution of the problem from Mike.

To make the code more robust and avoid any other such surprises I prefer
to have this in rather earlier than later.

As the commit says "Let's add a safety net ..."

-- 
Thanks,

David / dhildenb

