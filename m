Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF65AA85C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiIBGwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiIBGwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF216A570A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662101518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2hN84B8hnb1JPYdOSNGVn39QYSxDPmK/SyG1a0JjEM=;
        b=af5nbEbFd58JmDviKm7JCDNAVh5X0Dro1lEemBE6JYT+OUBzRBa6grxi2KiOnItIoq6vtJ
        Csec8YMGiIFwmUgDPAEWJniaZ8e27RhxlnYlo+QGupcU1VmFSk4XWHiX3wfj6RIEaSGVWl
        KjOasXWMg48V0yrO/mFkP8DPIIKwWfQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-T5KXihPyOdaMZFvZmLCiag-1; Fri, 02 Sep 2022 02:51:56 -0400
X-MC-Unique: T5KXihPyOdaMZFvZmLCiag-1
Received: by mail-wm1-f72.google.com with SMTP id q16-20020a1cf310000000b003a626026ed1so284337wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 23:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=K2hN84B8hnb1JPYdOSNGVn39QYSxDPmK/SyG1a0JjEM=;
        b=c3L2+GTyZQzrC6QJiLyk+nbOcF0CEhnjftLpQSc+gEyz2QBC75H6mJzKM99uaIkHZ+
         SWCZsMmrgQERrJPBi3ozSwo+XDKZJjH0Yh7BMNnFdInlZLQZ3vzrx0kvst/NI4Mefd1H
         ndgy6L9BMtiH3UALFPPIZHRSX/lV3swq/j4alvvTx/X6MnGiGuD7E+rst5/cze6Qrwb0
         f7ZYmvv+euaZ5Roeza1ys5M67hkBnn0LVYacBAq49/ieN9o7tJpqJHhRDaKlm3oAAnNO
         7WI05aqaeALWPBkJs+9BU15K0evfkx7cot8KNxkOjbuFC5VwW5I3i+xJMBjyOHUfaelb
         owzg==
X-Gm-Message-State: ACgBeo3DQi1u2pvSAlGxlXfDHvE/BEtNQmBvhG9oxyh+xnVQdEkMchkU
        N/f/tZsJayZ8Ew8BgjkuGQ8Dtr6V1qV47Yq4bVOBjpOVz/Tg0csWXHI3GOvTDFI15gJEBo8rosg
        tFULsAmsFP8kGtmsmlW73q9N9
X-Received: by 2002:a05:600c:348d:b0:3a6:b4e:ff6d with SMTP id a13-20020a05600c348d00b003a60b4eff6dmr1565278wmq.95.1662101515469;
        Thu, 01 Sep 2022 23:51:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46CGLtC2fDdfzM/QpJfx4qdEeswbHmK0RWHhlnHIk5iORrxdcergyRIzSqDQ7HjT8Z5PbhQw==
X-Received: by 2002:a05:600c:348d:b0:3a6:b4e:ff6d with SMTP id a13-20020a05600c348d00b003a60b4eff6dmr1565249wmq.95.1662101515193;
        Thu, 01 Sep 2022 23:51:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:4800:2077:1bf6:40e7:2833? (p200300cbc714480020771bf640e72833.dip0.t-ipconnect.de. [2003:cb:c714:4800:2077:1bf6:40e7:2833])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a31fd05e0fsm16660267wms.2.2022.09.01.23.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 23:51:54 -0700 (PDT)
Message-ID: <65b9abb4-45f7-f8e0-5148-6059b2c2ae6a@redhat.com>
Date:   Fri, 2 Sep 2022 08:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/4] mm/migrate_device.c: Flush TLB while holding PTL
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Peter Xu <peterx@redhat.com>, Nadav Amit <nadav.amit@gmail.com>,
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
        linuxppc-dev@lists.ozlabs.org,
        "Huang, Ying" <ying.huang@intel.com>, stable@vger.kernel.org
References: <9f801e9d8d830408f2ca27821f606e09aa856899.1662078528.git-series.apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <9f801e9d8d830408f2ca27821f606e09aa856899.1662078528.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.22 02:35, Alistair Popple wrote:
> When clearing a PTE the TLB should be flushed whilst still holding the
> PTL to avoid a potential race with madvise/munmap/etc. For example
> consider the following sequence:
> 
>   CPU0                          CPU1
>   ----                          ----
> 
>   migrate_vma_collect_pmd()
>   pte_unmap_unlock()
>                                 madvise(MADV_DONTNEED)
>                                 -> zap_pte_range()
>                                 pte_offset_map_lock()
>                                 [ PTE not present, TLB not flushed ]
>                                 pte_unmap_unlock()
>                                 [ page is still accessible via stale TLB ]
>   flush_tlb_range()
> 
> In this case the page may still be accessed via the stale TLB entry
> after madvise returns. Fix this by flushing the TLB while holding the
> PTL.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reported-by: Nadav Amit <nadav.amit@gmail.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Fixes: 8c3328f1f36a ("mm/migrate: migrate_vma() unmap page from vma while collecting pages")
> Cc: stable@vger.kernel.org
> 
> ---
> 
> Changes for v4:
> 
>  - Added Review-by
> 
> Changes for v3:
> 
>  - New for v3
> ---
>  mm/migrate_device.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 27fb37d..6a5ef9f 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -254,13 +254,14 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  		migrate->dst[migrate->npages] = 0;
>  		migrate->src[migrate->npages++] = mpfn;
>  	}
> -	arch_leave_lazy_mmu_mode();
> -	pte_unmap_unlock(ptep - 1, ptl);
>  
>  	/* Only flush the TLB if we actually modified any entries */
>  	if (unmapped)
>  		flush_tlb_range(walk->vma, start, end);
>  
> +	arch_leave_lazy_mmu_mode();
> +	pte_unmap_unlock(ptep - 1, ptl);
> +
>  	return 0;
>  }
>  
> 
> base-commit: ffcf9c5700e49c0aee42dcba9a12ba21338e8136


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

