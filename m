Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7C5AB97B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIBUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIBUfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341F8F63E5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662150952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fn+Zoib7z+3jWmLDklpcVUHy37Y7jPpJPmAY6A3wSS4=;
        b=EUBE6q1XBNfPmHpqV9iK4CAr3YVmw2q8Hvb16kUSWbBhctMGRmUb5xfMsCA0n0kMdeJtVj
        mmpJ9FSK275fcJzdIiASnv1ZuDFrWlyaR5uM58tiL5TJT+h4ERLGk4RtmRQE7nsUsgpbqY
        nH+fj6xbj5wL+309RbRqfY/U9a0lII8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-m3gmaiD0M36f4ugvP4_h5g-1; Fri, 02 Sep 2022 16:35:51 -0400
X-MC-Unique: m3gmaiD0M36f4ugvP4_h5g-1
Received: by mail-qk1-f200.google.com with SMTP id br15-20020a05620a460f00b006bc58c26501so2864303qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 13:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fn+Zoib7z+3jWmLDklpcVUHy37Y7jPpJPmAY6A3wSS4=;
        b=4F8gnmw92VFtvj1xKo1m6lA7vx0XXtUxj39LbhbMJCNyZfHdOiQWhcndYe2jHIH/MP
         c28xqArA9T3Zkzzb3GoHAI3EZyBdJXrmRwwXiUukKQrmcvZCXtBQ8T0Ed5pPFIadNw8W
         I59jC0bqsXSbn87lNRKGvg5yc5HVpL4yqhuWbZNsmQLyd42TdhWksa0K0bUBZhojlii0
         wbJtFEtbegr4xGr/GAcx9/VsjUcih6lmbO6RrzDM/XxJH3BYPb5QVdHYgUpw9BoFm7fb
         Zws4RpbQDSiXIBv+rfSIMlt7otazJArbyQZveU2B8UyqoaADBS9CB5Mm7kFe6ihKU4G8
         6Cmw==
X-Gm-Message-State: ACgBeo0XiSJ+jhjeiVACskauXZHkriwLz10AykuJ9pXFFezjCF5JVy3N
        mC9ZeuTsgPw1uWREwfhaj/eQYJnksAJ6T70WMXhP5pIYZhFD8vpvocGART7XT9aAC1pOFHFzcLF
        y+ZpDE4dINu9OSov9lbejRb7Y
X-Received: by 2002:a05:6214:cca:b0:499:216a:bb53 with SMTP id 10-20020a0562140cca00b00499216abb53mr12361609qvx.98.1662150950663;
        Fri, 02 Sep 2022 13:35:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6kIdR84rwbeR6TPg15NwPgQnYmK4+injhS/K8qL1Ci4QeM6ILUyA6WUnfYAugNgzwk5mCQRQ==
X-Received: by 2002:a05:6214:cca:b0:499:216a:bb53 with SMTP id 10-20020a0562140cca00b00499216abb53mr12361578qvx.98.1662150950432;
        Fri, 02 Sep 2022 13:35:50 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a404700b006b5cc25535fsm2262614qko.99.2022.09.02.13.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:35:50 -0700 (PDT)
Date:   Fri, 2 Sep 2022 16:35:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Nadav Amit <nadav.amit@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, paulus@ozlabs.org,
        linuxppc-dev@lists.ozlabs.org,
        "Huang, Ying" <ying.huang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mm/migrate_device.c: Flush TLB while holding PTL
Message-ID: <YxJpIwPn0FGOka0C@xz-m1.local>
References: <9f801e9d8d830408f2ca27821f606e09aa856899.1662078528.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f801e9d8d830408f2ca27821f606e09aa856899.1662078528.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:35:51AM +1000, Alistair Popple wrote:
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

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

