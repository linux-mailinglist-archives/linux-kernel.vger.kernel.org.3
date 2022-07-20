Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718FA57BD4E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiGTSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiGTSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6508724BC5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658340023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=daD9q7+pH5XOO19X8ngAWhNCL1CJM0I+kmMSrlE+EFk=;
        b=HCaeGCphLIqnV3XaGVcjoApa97ZgD6aHS+u9clap5GLZm38Ev7wCMDloRT3LLlMl69tpw3
        j8883eSbtiyQURUz5YGbsCl6GFURHve8Y+Z3kmxJDtgsDkE6PVM2Q9uT8RK/YCoqqDgnGO
        LDmIqsSBSJPTWfYRD7L5r4ndkKNFMLU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-vue7iEdeP--YQB9VF25yhw-1; Wed, 20 Jul 2022 14:00:22 -0400
X-MC-Unique: vue7iEdeP--YQB9VF25yhw-1
Received: by mail-wm1-f70.google.com with SMTP id c126-20020a1c3584000000b003a02fa133ceso8717051wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=daD9q7+pH5XOO19X8ngAWhNCL1CJM0I+kmMSrlE+EFk=;
        b=0Wxsfaj3EqSYGVGi77CrkN+LHphaoBMOIy47JkESX/NS8Q8TBGZ+XjSmeVAOhF/rjz
         75ZtWKMo3lQdSs1B+UtU8Sl450CGDP1zURHtIiEv2xqB1fHiZorpkXYakoU4XDIucKeE
         Bbq9lFFW9J13gpuK6XgtQHJnwp4sDh5K8CN6hJYALJ/FxnMOG6dLHgj5tHleK1NAZ2Kx
         DIiONXxs1law0msrLXKQPf25COrDMWfKxDGdUwBvo9Lx3ZbA3uJHzbuZExgxZryp5mPX
         pKXRxeVDyPv0/9owiCV4s8lMtfq8K/99eDndfc8kNuVZzhOpJMl7CqciT+I9TtTcNFSx
         oRjw==
X-Gm-Message-State: AJIora9UhIjqTWtY2xK5c5yJuIip30rOD9nEe/6NcMFzsCFcp8VN2gZO
        GM/+Bt4fgNt52D4NqrqMd2XmJGDXeeUO6GWPU2Wosc4jq0qjiGIkGq4hJUCEv3POoT74p2q63SV
        9FQMEwe5V2kO2xZ592TbPaCHN
X-Received: by 2002:a5d:64e5:0:b0:21d:945a:e7c4 with SMTP id g5-20020a5d64e5000000b0021d945ae7c4mr32939615wri.0.1658340020980;
        Wed, 20 Jul 2022 11:00:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqqffIMrvaUX/gko9Rlbr1Yeb+tx70Q8rsS2rh53u9A+JLBZWJybIMk55pCp3ERrgytNxv1A==
X-Received: by 2002:a5d:64e5:0:b0:21d:945a:e7c4 with SMTP id g5-20020a5d64e5000000b0021d945ae7c4mr32939591wri.0.1658340020645;
        Wed, 20 Jul 2022 11:00:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e00:8d96:5dba:6bc4:6e89? (p200300cbc7060e008d965dba6bc46e89.dip0.t-ipconnect.de. [2003:cb:c706:e00:8d96:5dba:6bc4:6e89])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b003a31b79dc0esm12139062wmb.1.2022.07.20.11.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 11:00:20 -0700 (PDT)
Message-ID: <97e82e31-2411-501e-d401-d175eb24642f@redhat.com>
Date:   Wed, 20 Jul 2022 20:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com>
 <09d84297-65d5-a3df-fdc0-a7168cdb0798@redhat.com>
 <99AFB0A0-B2F8-420A-8164-1705EC14B255@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <99AFB0A0-B2F8-420A-8164-1705EC14B255@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.22 19:36, Nadav Amit wrote:
> On Jul 20, 2022, at 2:42 AM, David Hildenbrand <david@redhat.com> wrote:
> 
>> ⚠ External Email
>>
>> On 18.07.22 14:01, Nadav Amit wrote:
>>> From: Nadav Amit <namit@vmware.com>
>>>
>>> When userfaultfd makes a PTE writable, it can now change the PTE
>>> directly, in some cases, without going triggering a page-fault first.
>>> Yet, doing so might leave the PTE that was write-unprotected as old and
>>> clean. At least on x86, this would cause a >500 cycles overhead when the
>>> PTE is first accessed.
>>>
>>> Use MM_CP_WILL_NEED to set the PTE as young and dirty when userfaultfd
>>> gets a hint that the page is likely to be used. Avoid changing the PTE
>>> to young and dirty in other cases to avoid excessive writeback and
>>> messing with the page reclamation logic.
>>>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Yu Zhao <yuzhao@google.com>
>>> Cc: Nick Piggin <npiggin@gmail.com>
>>> ---
>>> include/linux/mm.h | 2 ++
>>> mm/mprotect.c | 9 ++++++++-
>>> mm/userfaultfd.c | 8 ++++++--
>>> 3 files changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 9cc02a7e503b..4afd75ce5875 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -1988,6 +1988,8 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
>>> /* Whether this change is for write protecting */
>>> #define MM_CP_UFFD_WP (1UL << 2) /* do wp */
>>> #define MM_CP_UFFD_WP_RESOLVE (1UL << 3) /* Resolve wp */
>>> +/* Whether to try to mark entries as dirty as they are to be written */
>>> +#define MM_CP_WILL_NEED (1UL << 4)
>>> #define MM_CP_UFFD_WP_ALL (MM_CP_UFFD_WP | \
>>> MM_CP_UFFD_WP_RESOLVE)
>>>
>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>> index 996a97e213ad..34c2dfb68c42 100644
>>> --- a/mm/mprotect.c
>>> +++ b/mm/mprotect.c
>>> @@ -82,6 +82,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>> bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
>>> bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>>> bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
>>> + bool will_need = cp_flags & MM_CP_WILL_NEED;
>>>
>>> tlb_change_page_size(tlb, PAGE_SIZE);
>>>
>>> @@ -172,6 +173,9 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>> ptent = pte_clear_uffd_wp(ptent);
>>> }
>>>
>>> + if (will_need)
>>> + ptent = pte_mkyoung(ptent);
>>> +
>>> /*
>>> * In some writable, shared mappings, we might want
>>> * to catch actual write access -- see
>>> @@ -187,8 +191,11 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>> */
>>> if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>>> !pte_write(ptent) &&
>>
>>
>> Why would we want to check if we can set something writable if it
>> already *is* writable? That doesn't make sense to me.
> 
> We check !pte_write(). What am I missing in your question?

My patch review skills have seen better days. I thought you'd be
removing the pte_write() check ... :( Tired eyes ...

> 
> Having said that, I do notice now that pte_mkdirty() should not be done
> only this condition is fulfilled. Instead we should just have
> something like:
> 
>                        if (will_need) {
>                                ptent = pte_mkyoung(ptent);
>                                if (pte_write(ptent))
>                                        ptent = pte_mkdirty(ptent);
>                        }

As can_change_pte_writable() will fail if it stumbles over a !pte_dirty
page in current code ... so I assume you would have that code before the
actual pte_mkwrite() logic, correct?

-- 
Thanks,

David / dhildenb

