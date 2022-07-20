Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D192F57B405
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiGTJjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiGTJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF98F66ADA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658309973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGxXUHt0JfxzO2wlEKH/S8YYCRAzyPaR+NasW2jhftA=;
        b=CE5Lbfyn8rnie1rAzKcRGWbK21k1O3nVgKqqp8k5TeSLZwfuM9NHIjBoEWX8oCC+J/1ZmN
        DQeP4sk8AxfAnu4G52WASvPQOCfVPZhIAOxGRsyHHTUF84I+5V/oqImzSvAqyP2i8In7bp
        J5omE645LzwR2VroD0DNI3+wVhD4ze4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-_uqy22eTMYy0FJ-8-jhm7A-1; Wed, 20 Jul 2022 05:39:31 -0400
X-MC-Unique: _uqy22eTMYy0FJ-8-jhm7A-1
Received: by mail-wm1-f72.google.com with SMTP id n18-20020a05600c501200b003a050cc39a0so8137305wmr.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=vGxXUHt0JfxzO2wlEKH/S8YYCRAzyPaR+NasW2jhftA=;
        b=IKn0UJbZ61UJrK4YDtUMUYkEUUkw+JjbWCPz/wt/M/yFEGeMZLucZnT3gDUjePs+w3
         g0u0B2PIlfxQEzCpvh0epV+aejxWqxDD8eF6yvz/1BKFKKGBjmA5gA/7yDBwiwBVpUA4
         /rgascWsOsHuIWO55V94Cu1CfmV6SvfzSa80dBNXH+yquxD88XlDH6p1CeLugZd48f1f
         eSwY0IqpeXALTMG9XSHEXcK5ee6GqaMdlMb57hUTr5sbVPwfmofYJdIeCXx+OctYM8Xy
         bFyjIOL2TsO9ojgXeo/WCJ8ZpHw5R4iyxh0g43WR47hf+rVvY2xbA1D+dDYhIoXNt+lK
         CHxw==
X-Gm-Message-State: AJIora9WRvrLGWaF7nQGb4AcRhBbuoJaROmlWpjQmdNBN18i1IrOctFy
        +bPykNSyNLmdZkzsQDSWpxNRaqOEAEHwp6vFYD4Chx+TiF9IP3w8DyyGSdUYY5BDpBo6QfnGtbo
        +hT14nnHkcHZY/0vWv6oz1gvz
X-Received: by 2002:a05:6000:1545:b0:21d:8f3e:a0bd with SMTP id 5-20020a056000154500b0021d8f3ea0bdmr30658065wry.697.1658309970567;
        Wed, 20 Jul 2022 02:39:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSBJcT0KSj/yskIB0kKZ+SoBc2evqDzxLK35JoDwI6XTLe7tbE4VLHxgMH47vdcBVuIwRwaA==
X-Received: by 2002:a05:6000:1545:b0:21d:8f3e:a0bd with SMTP id 5-20020a056000154500b0021d8f3ea0bdmr30658035wry.697.1658309970332;
        Wed, 20 Jul 2022 02:39:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e00:8d96:5dba:6bc4:6e89? (p200300cbc7060e008d965dba6bc46e89.dip0.t-ipconnect.de. [2003:cb:c706:e00:8d96:5dba:6bc4:6e89])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c28c800b003a02f957245sm1863102wmd.26.2022.07.20.02.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 02:39:30 -0700 (PDT)
Message-ID: <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
Date:   Wed, 20 Jul 2022 11:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com> <YtcYVMoSRVxRH70Z@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YtcYVMoSRVxRH70Z@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.22 22:47, Peter Xu wrote:
> On Mon, Jul 18, 2022 at 05:01:59AM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>
>> When userfaultfd makes a PTE writable, it can now change the PTE
>> directly, in some cases, without going triggering a page-fault first.
>> Yet, doing so might leave the PTE that was write-unprotected as old and
>> clean. At least on x86, this would cause a >500 cycles overhead when the
>> PTE is first accessed.
>>
>> Use MM_CP_WILL_NEED to set the PTE as young and dirty when userfaultfd
>> gets a hint that the page is likely to be used. Avoid changing the PTE
>> to young and dirty in other cases to avoid excessive writeback and
>> messing with the page reclamation logic.
>>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Nick Piggin <npiggin@gmail.com>
>> ---
>>  include/linux/mm.h | 2 ++
>>  mm/mprotect.c      | 9 ++++++++-
>>  mm/userfaultfd.c   | 8 ++++++--
>>  3 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 9cc02a7e503b..4afd75ce5875 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1988,6 +1988,8 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
>>  /* Whether this change is for write protecting */
>>  #define  MM_CP_UFFD_WP                     (1UL << 2) /* do wp */
>>  #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
>> +/* Whether to try to mark entries as dirty as they are to be written */
>> +#define  MM_CP_WILL_NEED		   (1UL << 4)
>>  #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
>>  					    MM_CP_UFFD_WP_RESOLVE)
>>  
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index 996a97e213ad..34c2dfb68c42 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -82,6 +82,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>  	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
>>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>>  	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
>> +	bool will_need = cp_flags & MM_CP_WILL_NEED;
>>  
>>  	tlb_change_page_size(tlb, PAGE_SIZE);
>>  
>> @@ -172,6 +173,9 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>  				ptent = pte_clear_uffd_wp(ptent);
>>  			}
>>  
>> +			if (will_need)
>> +				ptent = pte_mkyoung(ptent);
> 
> For uffd path, UFFD_FLAGS_ACCESS_LIKELY|UFFD_FLAGS_WRITE_LIKELY are new
> internal flags used with or without the new feature bit set.  It means even
> with !ACCESS_HINT we'll start to set young bit while we used not to?  Is
> that some kind of a light abi change?
> 
> I'd suggest we only set will_need if ACCESS_HINT is set.
> 
>> +
>>  			/*
>>  			 * In some writable, shared mappings, we might want
>>  			 * to catch actual write access -- see
>> @@ -187,8 +191,11 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>  			 */
>>  			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>>  			    !pte_write(ptent) &&
>> -			    can_change_pte_writable(vma, addr, ptent))
>> +			    can_change_pte_writable(vma, addr, ptent)) {
>>  				ptent = pte_mkwrite(ptent);
>> +				if (will_need)
>> +					ptent = pte_mkdirty(ptent);
> 
> Can we make this unconditional?  IOW to cover both:
> 
>   (1) When will_need is not set, or
>   (2) mprotect() too
> 
> David's patch is good in that we merged the unprotect and CoW.  However
> that's not complete because the dirty bit ops are missing.
> 
> Here IMHO we should have a standalone patch to just add the dirty bit into
> this logic when we'll grant write bit.  IMHO it'll make the write+dirty
> bits coherent again in all paths.

I'm not sure I follow.

We *surely* don't want to dirty random pages (especially once in the
pagecache/swapcache) simply because we change protection.

Just like we don't set all pages write+dirty in a writable VMA on a read
fault.

-- 
Thanks,

David / dhildenb

