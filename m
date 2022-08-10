Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6779158EA03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiHJJqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiHJJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16CB01F2F2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660124763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQhjJGzBRGTZiQN80ahY4rWeodzufG2/XfFDBAk+2w4=;
        b=Tx4O7P5poMIANdX4BpQW8eHtYEPvGvije7XSgKP9ejDXXHWHaCPwiQhpqhvYcq/rYpTwrN
        7pkRkVDXuwt3/dZBszfOjI5G4jp1lvSXEvvQ7s885dB481RtYdNT3QxVLHX8jPVFRnHs/o
        V/t4+liQkiK2TPNluwA4W0pOtvDSuMI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111--XQKcS0SNKaQapvWqFZXCA-1; Wed, 10 Aug 2022 05:45:54 -0400
X-MC-Unique: -XQKcS0SNKaQapvWqFZXCA-1
Received: by mail-wr1-f70.google.com with SMTP id w20-20020adf8bd4000000b002237e71d4e4so152862wra.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=RQhjJGzBRGTZiQN80ahY4rWeodzufG2/XfFDBAk+2w4=;
        b=ZKRa3a8MGQMW9fq0X1sMEiT1SLlSSb41TO2WAJBG6JPU7B2dfX8hKPn4VKcTMuSmxM
         pHJS75Pm9MWSvkgSxs93Uoatwcoyepop/sDAsHOStWrAQf6w9u1BhZBmGIa5Rv/qfS/L
         ib+NU640WjqbMYNN3o3ApuwkyxPeJkBleCTTzSqEbUgLYqP4h4ZHIlLmn3+W+VFA1z8s
         dr9KQjLrGatCfvjT/u5LICOx+6pgbmrOPTkP/ofm62kBtlWmpTTbQJwyi0Z6IQJBeos/
         MODML0nf51CEYizCcawOSWjGl/Y7LVBLOcuew//PB2EF9TRzjAcrTPQdJRlIAZ9SUWDo
         aI6w==
X-Gm-Message-State: ACgBeo0iehvr3d9yn2o/gDkGMPLwpkzY5xWsD8PXC7duPmzcYKAOWih4
        A/AC4Bp6DckrpjlGQC0s7bvdXHH7U4ogMnieRnfOsSFtRPrhMP+MIRKlmBXaIq8kjxhW9C+RyDD
        t3ahyAx6fCDKz6Dtuj7+pD3/3
X-Received: by 2002:a5d:5273:0:b0:220:5d3e:c50f with SMTP id l19-20020a5d5273000000b002205d3ec50fmr17383755wrc.291.1660124753434;
        Wed, 10 Aug 2022 02:45:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4EiDj3wCjMk+MyRjKRdbx4iiAltWGIB3iGfdatBmWEJl1cqk5OD1IxsBikKX7EYuzK1f+Q+g==
X-Received: by 2002:a5d:5273:0:b0:220:5d3e:c50f with SMTP id l19-20020a5d5273000000b002205d3ec50fmr17383745wrc.291.1660124753149;
        Wed, 10 Aug 2022 02:45:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1600:a3ce:b459:ef57:7b93? (p200300cbc7071600a3ceb459ef577b93.dip0.t-ipconnect.de. [2003:cb:c707:1600:a3ce:b459:ef57:7b93])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b003a32297598csm2139946wmq.43.2022.08.10.02.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 02:45:52 -0700 (PDT)
Message-ID: <c9c477de-395d-7a13-a200-c319aaa26be1@redhat.com>
Date:   Wed, 10 Aug 2022 11:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
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
Organization: Red Hat
In-Reply-To: <12c65d91-5fc0-cb2e-c415-2b3447960b43@redhat.com>
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

On 10.08.22 11:37, David Hildenbrand wrote:
> On 09.08.22 00:08, Peter Xu wrote:
>> On Mon, Aug 08, 2022 at 04:21:39PM -0400, Peter Xu wrote:
>>> On Mon, Aug 08, 2022 at 06:25:21PM +0200, David Hildenbrand wrote:
>>>>>> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
>>>>>> unfortunately wrong.
>>>>>>
>>>>>> If you're curious, take a look at f83a275dbc5c ("mm: account for
>>>>>> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
>>>>>> and mmap() code.
>>>>>>
>>>>>> Long story short: if the file is read-only, we only have VM_MAYSHARE but
>>>>>> not VM_SHARED (and consequently also not VM_MAYWRITE).
>>>>>
>>>>> To ask in another way: if file is RO but mapped RW (mmap() will have
>>>>> VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
>>>>> won't we grant write bit errornously while we shouldn't? As the user
>>>>> doesn't really have write permission to the file.
>>>>
>>>> Thus the VM_WRITE check. :)
>>>>
>>>> I wonder if we should just do it cleanly and introduce the maybe_mkwrite
>>>> semantics here as well. Then there is no need for additional VM_WRITE
>>>> checks and hugetlb will work just like !hugetlb.
>>>
>>> Hmm yeah I think the VM_MAYSHARE check is correct, since we'll need to fail
>>> the cases where MAYSHARE && !SHARE - we used to silently let it pass.
>>
>> Sorry I think this is a wrong statement I made..  IIUC we'll fail correctly
>> with/without the patch on any write to hugetlb RO regions.
>>
>> Then I just don't see a difference on checking VM_SHARED or VM_MAYSHARE
>> here, it's just that VM_MAYSHARE check should work too like VM_SHARED so I
>> don't see a problem.
>>
>> It also means I can't think of any valid case of having VM_WRITE when
>> reaching here, then the WARN_ON_ONCE() is okay but maybe also redundant.
>> Using maybe_mkwrite() seems misleading to me if FOLL_FORCE not ready for
>> hugetlbfs after all.
>>
> 
> The main reason we'd have it would be to scream out lout and fail
> gracefully if someone would -- for example -- use it for something like
> FOLL_FORCE. I mean triggering a write fault without VM_WRITE on !hugetlb
> works, so it would be easy to assume that it similarly simply works for
> hugetlb as well. And the code most probably wouldn't even blow up
> immediately :)
> 

I propose the following change to hugetlb_wp():

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a18c071c294e..b92d30d3b33b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5233,6 +5233,21 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
        VM_BUG_ON(unshare && (flags & FOLL_WRITE));
        VM_BUG_ON(!unshare && !(flags & FOLL_WRITE));
 
+       /*
+        * hugetlb does not support FOLL_FORCE-style write faults that keep the
+        * PTE mapped R/O such as maybe_mkwrite() would do.
+        */
+       if (WARN_ON_ONCE(!unshare && !(vma->vm_flags & VM_WRITE)))
+               return VM_FAULT_SIGSEGV;
+
+       /* Let's take out shared mappings first, this should be a rare event. */
+       if (unlikely(vma->vm_flags & VM_MAYSHARE)) {
+               if (unlikely(unshare))
+                       return 0;
+               set_huge_ptep_writable(vma, haddr, ptep);
+               return 0;
+       }
+



-- 
Thanks,

David / dhildenb

