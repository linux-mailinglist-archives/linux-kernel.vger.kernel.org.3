Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A51759F515
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiHXIW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiHXIWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE049569B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661329318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaKoJSFhkLs3j9BMMpW4Sul91GROScQNC38GatdEuPY=;
        b=ftOp+I0P4rEOIt2ICz80cqZsX8j9OFF0uiUtQQFsEZ5AG7dAI/bJZWI156rvxdyq/mgGkV
        sPuvLq2en/7teneaD7ZL2/fESrKvnj+IgIwT8fBS4M7lmGkAUxU657II6bTFZG2FAaqM78
        wn1hp2vTav0wWNfVnQPQSQtKsJmtSKA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-382-vlv5O1HbO2-Os5a0PEkpFA-1; Wed, 24 Aug 2022 04:21:57 -0400
X-MC-Unique: vlv5O1HbO2-Os5a0PEkpFA-1
Received: by mail-wr1-f71.google.com with SMTP id d11-20020adfc08b000000b002207555c1f6so2572693wrf.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=kaKoJSFhkLs3j9BMMpW4Sul91GROScQNC38GatdEuPY=;
        b=Q+1YbcQH3ogWiZgWOEK1r0cMOOTUt6OYh9kI2pSVB3gcUaZ0nwn1pjkBN+5Md/gkw+
         iS4xZ/scd1NJ1HzmHL1RXP/fp1XafkSZeWdsWNFwdVQxppU2MQKsThpEuieccWvnrE6E
         hti8gAw1v8mI31ANJv+bqVZyhv/A17CJfB6DHudclOL4hitGKp8g1oDjyL3E5gPGb/R9
         kH7U8wmClYQCeBnIHOa/wGMsH73NxwgVmxTBUyZCmSRhmAUWCIQTLVof3Jdj6QiGhI30
         /yOcSZ/1TJqOE03ApdafSxGswYpmeGX546eO/AEW5mOUM6MYK5Oa47DlgjLb8NR/bVvz
         9nog==
X-Gm-Message-State: ACgBeo2uUVKKIDaL1P9FlPR+lOT2WO6JZjN3KNrrJEy8MmLs1CARG8NN
        ofJH7KqR9xu9PL5fdM7XCUElHHy+THEABF4CBGrQj2G5c4tNI4jpCOzrq73/T+Ll7R9UilnWEmU
        y57h2ZuXvAbvPWzoeOCjF7sBn
X-Received: by 2002:adf:f644:0:b0:225:4cb4:c2f6 with SMTP id x4-20020adff644000000b002254cb4c2f6mr9491247wrp.552.1661329316185;
        Wed, 24 Aug 2022 01:21:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4X7X3tYyJSmiUUp6I0Ru0wIROQJojmCwOUf92jP2yjlZsNTJSwC4WCw77h1/+kLqgmchleqA==
X-Received: by 2002:adf:f644:0:b0:225:4cb4:c2f6 with SMTP id x4-20020adff644000000b002254cb4c2f6mr9491224wrp.552.1661329315912;
        Wed, 24 Aug 2022 01:21:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:c500:5445:cf40:2e32:6e73? (p200300cbc707c5005445cf402e326e73.dip0.t-ipconnect.de. [2003:cb:c707:c500:5445:cf40:2e32:6e73])
        by smtp.gmail.com with ESMTPSA id v5-20020a1cac05000000b003a626055569sm1122379wme.16.2022.08.24.01.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 01:21:55 -0700 (PDT)
Message-ID: <86b0622d-06eb-cfab-2ff1-8a0eaf823f8a@redhat.com>
Date:   Wed, 24 Aug 2022 10:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/3] mm/migrate_device.c: Flush TLB while holding PTL
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
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
References: <3b01af093515ce2960ac39bb16ff77473150d179.1661309831.git-series.apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3b01af093515ce2960ac39bb16ff77473150d179.1661309831.git-series.apopple@nvidia.com>
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

On 24.08.22 05:03, Alistair Popple wrote:
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
> Fixes: 8c3328f1f36a ("mm/migrate: migrate_vma() unmap page from vma while collecting pages")
> Cc: stable@vger.kernel.org
> 
> ---
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

I'm not a TLB-flushing expert, but this matches my understanding (and a
TLB flushing Linux documentation I stumbled over some while ago but
cannot quickly find).

In the ordinary try_to_migrate_one() path, flushing would happen via
ptep_clear_flush() (just like we do for the anon_exclusive case here as
well), correct?

-- 
Thanks,

David / dhildenb

