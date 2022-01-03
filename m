Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D36482F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiACJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:34:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbiACJeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641202453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Xw+nqyUaftEyVf2AbhE9FlSFY2sQizP+Ns052bR1SQ=;
        b=QMiin8g9TDrz4NW89KtF3zVbtFdYu4hiDIOVfZbkRvi998bhHUu2JcyDKw/kythVlHhU2I
        +tEBEhEjupqZLBTfDFR+WXwpMlVr/m2udqy/dwf2Fa1xFZ6VTdVnGPkgAY5axTpF3Crk/R
        niL6kbumePJhy2Qop+Q5EqSpq3v9gGk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-qHEXAI1yMUO4ppP8HShFrA-1; Mon, 03 Jan 2022 04:34:12 -0500
X-MC-Unique: qHEXAI1yMUO4ppP8HShFrA-1
Received: by mail-wr1-f71.google.com with SMTP id v15-20020adf8b4f000000b001a24c46d6ceso10088497wra.15
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 01:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+Xw+nqyUaftEyVf2AbhE9FlSFY2sQizP+Ns052bR1SQ=;
        b=guFZCnCh6ziUcO/Z8V/WvpFv4ZwqZXAAGKqAS5BiUbWF6EHx11m+vVfLdaOyWd6D1m
         YT4u3n8zDnt3l3V/+J+pLXWtnj3JYakorXuKQPffHulVI13HGvb6F7spunr3ROb5tJ0t
         iyuk5t+IIMAmxfR5eUTNx8R1VjWAhjaOqMQZWW4FjCSEmf07eqvLobnRgV8hOeH2gE89
         8Ip7BEPc/fujiKAzUdUbzhwenJYdeWB0vsO2UTIRVuowoMOqxo0oFCCosKHZPLpV9dzZ
         bTC4gF/aXDqHJ1yYM+6vfpdMb0VL3VdsssL42O1IgUO+m57aKo+HfeDhzrVlEDB4Pvrr
         2j7A==
X-Gm-Message-State: AOAM532AqLCmvR9pSGPbqiH7ymTP3Y/zx5/87Bgr8LwSadQB8L0eSKuG
        7sQglml0wKRbqp7Av/HQNUmDdGaO3RRLzTyuujrwq30qIupquHCCiox9fWymE3ZTfnnfB0bWsgh
        ky4tZ+dReEQiGdTQpt7KtS8Ja
X-Received: by 2002:a5d:456b:: with SMTP id a11mr37541833wrc.352.1641202450990;
        Mon, 03 Jan 2022 01:34:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoL2H9/ZzHZ3pWyMFDzj9AbN4ZminFthZZYz+EXbIcG/PExAGuQxxp7VjZLdpPJdEOpcLniQ==
X-Received: by 2002:a5d:456b:: with SMTP id a11mr37541820wrc.352.1641202450757;
        Mon, 03 Jan 2022 01:34:10 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6974.dip0.t-ipconnect.de. [91.12.105.116])
        by smtp.gmail.com with ESMTPSA id n15sm33729927wru.66.2022.01.03.01.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 01:34:10 -0800 (PST)
Message-ID: <88f1e4b1-b823-1af6-06b3-8d31564e6077@redhat.com>
Date:   Mon, 3 Jan 2022 10:34:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 2/3] dma/pool: create dma atomic pool only if dma zone
 has managed pages
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, 42.hyeyoo@gmail.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        David.Laight@ACULAB.COM, x86@kernel.org, bp@alien8.de
References: <20211223094435.248523-1-bhe@redhat.com>
 <20211223094435.248523-3-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211223094435.248523-3-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.12.21 10:44, Baoquan He wrote:
> Currently three dma atomic pools are initialized as long as the relevant
> kernel codes are built in. While in kdump kernel of x86_64, this is not
> right when trying to create atomic_pool_dma, because there's no managed
> pages in DMA zone. In the case, DMA zone only has low 1M memory presented
> and locked down by memblock allocator. So no pages are added into buddy
> of DMA zone. Please check commit f1d4d47c5851 ("x86/setup: Always reserve
> the first 1M of RAM").
> 
> Then in kdump kernel of x86_64, it always prints below failure message:
> 
>  DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
>  swapper/0: page allocation failure: order:5, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-0.rc5.20210611git929d931f2b40.42.fc35.x86_64 #1
>  Hardware name: Dell Inc. PowerEdge R910/0P658H, BIOS 2.12.0 06/04/2018
>  Call Trace:
>   dump_stack+0x7f/0xa1
>   warn_alloc.cold+0x72/0xd6
>   ? _raw_spin_unlock_irq+0x24/0x40
>   ? __alloc_pages_direct_compact+0x90/0x1b0
>   __alloc_pages_slowpath.constprop.0+0xf29/0xf50
>   ? __cond_resched+0x16/0x50
>   ? prepare_alloc_pages.constprop.0+0x19d/0x1b0
>   __alloc_pages+0x24d/0x2c0
>   ? __dma_atomic_pool_init+0x93/0x93
>   alloc_page_interleave+0x13/0xb0
>   atomic_pool_expand+0x118/0x210
>   ? __dma_atomic_pool_init+0x93/0x93
>   __dma_atomic_pool_init+0x45/0x93
>   dma_atomic_pool_init+0xdb/0x176
>   do_one_initcall+0x67/0x320
>   ? rcu_read_lock_sched_held+0x3f/0x80
>   kernel_init_freeable+0x290/0x2dc
>   ? rest_init+0x24f/0x24f
>   kernel_init+0xa/0x111
>   ret_from_fork+0x22/0x30
>  Mem-Info:
>  ......
>  DMA: failed to allocate 128 KiB GFP_KERNEL|GFP_DMA pool for atomic allocation
>  DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> 
> Here, let's check if DMA zone has managed pages, then create atomic_pool_dma
> if yes. Otherwise just skip it.
> 
> Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux-foundation.org
> ---
>  kernel/dma/pool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 5a85804b5beb..00df3edd6c5d 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -206,7 +206,7 @@ static int __init dma_atomic_pool_init(void)
>  						    GFP_KERNEL);
>  	if (!atomic_pool_kernel)
>  		ret = -ENOMEM;
> -	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> +	if (has_managed_dma()) {
>  		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
>  						GFP_KERNEL | GFP_DMA);
>  		if (!atomic_pool_dma)
> @@ -229,7 +229,7 @@ static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
>  	if (prev == NULL) {
>  		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
>  			return atomic_pool_dma32;
> -		if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> +		if (atomic_pool_dma && (gfp & GFP_DMA))
>  			return atomic_pool_dma;
>  		return atomic_pool_kernel;
>  	}

I thought for a second that we might have to tweak
atomic_pool_work_fn(), but atomic_pool_resize() handles it properly already.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

