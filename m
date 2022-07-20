Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28C57B411
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiGTJnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiGTJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F7916391A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658310179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RKfphNn3mPOW1MXkGNfh4n+QtAmR71ynMhMeD/fO8E=;
        b=fOcmHKZyIY5ZrJMDar458RiargpP2dxnDbnrf7o7RZfeXyhkVyfC0uECKsT6Bap2UE2I+8
        2eCGNuD3PEFyW7rBVLghtBeIEYZjbhAzHGwMWAo4Grz680PbHjCrtzLJH16z7CPm5EDVOK
        7hIDK+7XRwDWGUvYlzm6fA3cbnvteeo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-2ilFvp8NP9-A6YwBC5l8HQ-1; Wed, 20 Jul 2022 05:42:58 -0400
X-MC-Unique: 2ilFvp8NP9-A6YwBC5l8HQ-1
Received: by mail-wr1-f70.google.com with SMTP id l11-20020adfbd8b000000b0021d754b84c5so3041210wrh.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6RKfphNn3mPOW1MXkGNfh4n+QtAmR71ynMhMeD/fO8E=;
        b=uMmIfMbSiD/St+Nx9graEXROZf1HkPte/FdXCt8cdc1Hqa/YrtNwrOTZkcbZUIAg6F
         XJoQHvsX31UUi7P1/thvtiAT5HmwuL/hrXdPRNst3QJqAZSnJzyWwQkm2aXlrZu7TeK1
         ajnR6wlP0WNT3sxtbw1dEGBDMPVPOxZh0r7ADjZ9mYr509/D9u+RQwvIFioHAIgmKzb4
         aJ0zfdfky7cQS8BarPfN+8tl24oPkp1a94x//Q96XoRzZWFA38aWD34/UJsKcIRBCQko
         IumlOQtzRMe1IMwIiESfnmxJqSUbUD1MyTwOE3SFWPNWVeMghMl0CIWPis+6f+4N5SAP
         OpQw==
X-Gm-Message-State: AJIora+9yRQfro/IyEn9epnwoYrgjmXBrXvIAyG3osFr1pXbn4xE2kA+
        EVTIU0N36P1Lpb2oMoPep7dmwAJTf4Wu7b8xOiXd9Lw8jBSo1nfcnzI8DkaZ/q3kOstgUH3mS/a
        mhQ07hLoxLicOVhHiTgBK9ufD
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id f8-20020a0560001a8800b0021daa97cb16mr30480722wry.97.1658310176899;
        Wed, 20 Jul 2022 02:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vLkuZu1Isp50EKcsrNnkjav5J73V5/aUvap3rND17xDst4/UY0s1U6Yu8aeSvpX5+PIIk6cA==
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id f8-20020a0560001a8800b0021daa97cb16mr30480707wry.97.1658310176663;
        Wed, 20 Jul 2022 02:42:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e00:8d96:5dba:6bc4:6e89? (p200300cbc7060e008d965dba6bc46e89.dip0.t-ipconnect.de. [2003:cb:c706:e00:8d96:5dba:6bc4:6e89])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c28cc00b003a325bd8517sm2190898wmd.5.2022.07.20.02.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 02:42:56 -0700 (PDT)
Message-ID: <09d84297-65d5-a3df-fdc0-a7168cdb0798@redhat.com>
Date:   Wed, 20 Jul 2022 11:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220718120212.3180-2-namit@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.22 14:01, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> When userfaultfd makes a PTE writable, it can now change the PTE
> directly, in some cases, without going triggering a page-fault first.
> Yet, doing so might leave the PTE that was write-unprotected as old and
> clean. At least on x86, this would cause a >500 cycles overhead when the
> PTE is first accessed.
> 
> Use MM_CP_WILL_NEED to set the PTE as young and dirty when userfaultfd
> gets a hint that the page is likely to be used. Avoid changing the PTE
> to young and dirty in other cases to avoid excessive writeback and
> messing with the page reclamation logic.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> ---
>  include/linux/mm.h | 2 ++
>  mm/mprotect.c      | 9 ++++++++-
>  mm/userfaultfd.c   | 8 ++++++--
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9cc02a7e503b..4afd75ce5875 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1988,6 +1988,8 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
>  /* Whether this change is for write protecting */
>  #define  MM_CP_UFFD_WP                     (1UL << 2) /* do wp */
>  #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
> +/* Whether to try to mark entries as dirty as they are to be written */
> +#define  MM_CP_WILL_NEED		   (1UL << 4)
>  #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
>  					    MM_CP_UFFD_WP_RESOLVE)
>  
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 996a97e213ad..34c2dfb68c42 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -82,6 +82,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>  	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
> +	bool will_need = cp_flags & MM_CP_WILL_NEED;
>  
>  	tlb_change_page_size(tlb, PAGE_SIZE);
>  
> @@ -172,6 +173,9 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  				ptent = pte_clear_uffd_wp(ptent);
>  			}
>  
> +			if (will_need)
> +				ptent = pte_mkyoung(ptent);
> +
>  			/*
>  			 * In some writable, shared mappings, we might want
>  			 * to catch actual write access -- see
> @@ -187,8 +191,11 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  			 */
>  			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>  			    !pte_write(ptent) &&


Why would we want to check if we can set something writable if it
already *is* writable? That doesn't make sense to me.

> -			    can_change_pte_writable(vma, addr, ptent))
> +			    can_change_pte_writable(vma, addr, ptent)) {
>  				ptent = pte_mkwrite(ptent);
> +				if (will_need)
> +					ptent = pte_mkdirty(ptent);
> +			}

-- 
Thanks,

David / dhildenb

