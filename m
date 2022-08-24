Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DED59FA13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiHXMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiHXMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDC880352
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661344555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJuT0qCBRs+JGxRnNUBPV/84rd6u301RNuYVKr9ovFg=;
        b=O7kctG848rD5ubjn44ZIDIHP4quakZkd5wgbA6VVP7vYO8SNaaoBpUFtyzebMXpui71GlA
        8jrQJFTvOIqf7YUtshPMONCrgXd2x4VQBcO9VwsMdkBohuydgg7C2PRS6KjHUTWcwtDo72
        amJ3YhGxWNCexFtLOtqrLBvuqaKg3AU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-OQARc5szOK-mLv6X9Jf3Fw-1; Wed, 24 Aug 2022 08:35:54 -0400
X-MC-Unique: OQARc5szOK-mLv6X9Jf3Fw-1
Received: by mail-wm1-f71.google.com with SMTP id r10-20020a1c440a000000b003a538a648a9so9363301wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=rJuT0qCBRs+JGxRnNUBPV/84rd6u301RNuYVKr9ovFg=;
        b=FSLPqMsTIwGrSewgAFk3youRiLPnOxAe7oHs1D4pSXg4QpWZeNWsWQdGe8I6QOrT3N
         s7ZMyIgYTjdtFTtlGBCPKStHDHR14p8hBZd/wq3HPcVI2rIwUMZZZKq7bXodQo2u/hN7
         KzkvraEmO2CTloZTDTrHfbJhzMfSl3ajrQwqVHH9t+rKAovLH74SmrwIZTaPTTWJnqVq
         v23GUhdVR4p+Sr/JVw32q9tI362rckSViQDm3mGrD9HMwvgMDbQAYzzhYkoWO7wEPnPW
         BLMZrMFG+dFudmAEwbL6/AuqLdmqlFPHks04x3Zx4U7uAilDyXX+De/8N9SDqcbfLsTe
         HcIg==
X-Gm-Message-State: ACgBeo3ZaevoO35gxgJ7ECXGaio/H2DfZJb6+4cgaLL/gGpIGuGopKB6
        Yh3TtxIoFWN2wAZpUWip7AaKI0G8jjKGmgtuF8rI5tziFO9XG+kHvTF+56ws1tWucAZcUI2lIaG
        uPdrVV7jgsBRSoeG9fVnSv9jL
X-Received: by 2002:a05:600c:4e8c:b0:3a6:11e:cc08 with SMTP id f12-20020a05600c4e8c00b003a6011ecc08mr5172793wmq.198.1661344553397;
        Wed, 24 Aug 2022 05:35:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR44DedJ2+TvsAxiP57X1MmAV94j+vDVcHJ2tTdByck/P3U4Aea5bqXN86cTRa0XCN3QFAkAOA==
X-Received: by 2002:a05:600c:4e8c:b0:3a6:11e:cc08 with SMTP id f12-20020a05600c4e8c00b003a6011ecc08mr5172777wmq.198.1661344553097;
        Wed, 24 Aug 2022 05:35:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:c500:5445:cf40:2e32:6e73? (p200300cbc707c5005445cf402e326e73.dip0.t-ipconnect.de. [2003:cb:c707:c500:5445:cf40:2e32:6e73])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000100300b002254880c049sm11802172wrx.31.2022.08.24.05.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:35:52 -0700 (PDT)
Message-ID: <6e31290a-5b72-ceb6-b11c-f8c1b066beaf@redhat.com>
Date:   Wed, 24 Aug 2022 14:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/3] mm/migrate_device.c: Flush TLB while holding PTL
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, paulus@ozlabs.org,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
References: <3b01af093515ce2960ac39bb16ff77473150d179.1661309831.git-series.apopple@nvidia.com>
 <86b0622d-06eb-cfab-2ff1-8a0eaf823f8a@redhat.com>
 <87wnaxg6u4.fsf@nvdebian.thelocal>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87wnaxg6u4.fsf@nvdebian.thelocal>
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

On 24.08.22 14:26, Alistair Popple wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 24.08.22 05:03, Alistair Popple wrote:
>>> When clearing a PTE the TLB should be flushed whilst still holding the
>>> PTL to avoid a potential race with madvise/munmap/etc. For example
>>> consider the following sequence:
>>>
>>>   CPU0                          CPU1
>>>   ----                          ----
>>>
>>>   migrate_vma_collect_pmd()
>>>   pte_unmap_unlock()
>>>                                 madvise(MADV_DONTNEED)
>>>                                 -> zap_pte_range()
>>>                                 pte_offset_map_lock()
>>>                                 [ PTE not present, TLB not flushed ]
>>>                                 pte_unmap_unlock()
>>>                                 [ page is still accessible via stale TLB ]
>>>   flush_tlb_range()
>>>
>>> In this case the page may still be accessed via the stale TLB entry
>>> after madvise returns. Fix this by flushing the TLB while holding the
>>> PTL.
>>>
>>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>>> Reported-by: Nadav Amit <nadav.amit@gmail.com>
>>> Fixes: 8c3328f1f36a ("mm/migrate: migrate_vma() unmap page from vma while collecting pages")
>>> Cc: stable@vger.kernel.org
>>>
>>> ---
>>>
>>> Changes for v3:
>>>
>>>  - New for v3
>>> ---
>>>  mm/migrate_device.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>> index 27fb37d..6a5ef9f 100644
>>> --- a/mm/migrate_device.c
>>> +++ b/mm/migrate_device.c
>>> @@ -254,13 +254,14 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>  		migrate->dst[migrate->npages] = 0;
>>>  		migrate->src[migrate->npages++] = mpfn;
>>>  	}
>>> -	arch_leave_lazy_mmu_mode();
>>> -	pte_unmap_unlock(ptep - 1, ptl);
>>>
>>>  	/* Only flush the TLB if we actually modified any entries */
>>>  	if (unmapped)
>>>  		flush_tlb_range(walk->vma, start, end);
>>>
>>> +	arch_leave_lazy_mmu_mode();
>>> +	pte_unmap_unlock(ptep - 1, ptl);
>>> +
>>>  	return 0;
>>>  }
>>>
>>>
>>> base-commit: ffcf9c5700e49c0aee42dcba9a12ba21338e8136
>>
>> I'm not a TLB-flushing expert, but this matches my understanding (and a
>> TLB flushing Linux documentation I stumbled over some while ago but
>> cannot quickly find).
>>
>> In the ordinary try_to_migrate_one() path, flushing would happen via
>> ptep_clear_flush() (just like we do for the anon_exclusive case here as
>> well), correct?
> 
> Correct.
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

