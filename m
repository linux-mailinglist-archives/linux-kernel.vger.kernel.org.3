Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BF8482C0E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiABQXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:23:12 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36453 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiABQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:23:11 -0500
Received: by mail-wr1-f45.google.com with SMTP id r17so65546528wrc.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 08:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=syRxK/WihK0W8cM9Lo7IEl7ax9RwmDt1BjblnKABupk=;
        b=7FToYKZVDehDUew86jZ3u/Otr6bmEfZq98s/aI2gqv3EjL14U/8AbRlXCIW4HRAtNN
         rfbRlU74+1r88PplLaqi3GqoA/g4CjNspj/3Pfa9r6a8UY9eHEwcim7p5CUOkJ7luIFy
         KvkTsi7NSHPfRj+Oddp+QM3k9xkJQJHpemmQkSh16epYYsNpTmeE8ZvLMRavxvPaX20U
         Awb5p1Ol7JQxcLde/rcs2X5GiQVzGpWF2MsJOYKprCUTXEU21Ik6ddunwhKyqDeHzPwj
         pPRW6/s9KxPLffWml5Ol6wf+GMDheOfd6z0ryRzdCj6k6lMjRgNt+yv9eCs2gWU0mIYL
         6IJQ==
X-Gm-Message-State: AOAM531Kred+A1mbMrcRqLpvYc+Qmbe77wL4gDceDvxb3zwN+0c4Ph+B
        Cb7jOqSi5yCvSKM/9RQ15x4=
X-Google-Smtp-Source: ABdhPJzXbMjog73caxBAxZ+vqfoRaLf7wB2/iqS1Zv8pzijdM+2Cav527ULesBUorK4v9MROCfkR4A==
X-Received: by 2002:a05:6000:144f:: with SMTP id v15mr35274705wrx.400.1641140590197;
        Sun, 02 Jan 2022 08:23:10 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b5sm2234326wrr.19.2022.01.02.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:23:09 -0800 (PST)
Date:   Sun, 2 Jan 2022 16:23:08 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap() in
 the swiotlb_mem_remap()
Message-ID: <20220102162308.msbzlzm4oz5jvabp@liuwe-devbox-debian-v2>
References: <20211231165640.1245751-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231165640.1245751-1-ltykernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 11:56:40AM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> HAS_IOMEM option may not be selected on some platforms(e.g, s390) and this
> will cause compile error due to miss memremap() implementation. Fix it via

miss -> missingk

> adding HAS_IOMEM check around memremap() in the swiotlb.c.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hi Christoph

Are you happy with this fix?

Thanks,
Wei.

> ---
>  kernel/dma/swiotlb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b36c1cdd0c4f..3de651ba38cc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -167,6 +167,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
>  {
>  	void *vaddr = NULL;
>  
> +#ifdef CONFIG_HAS_IOMEM
>  	if (swiotlb_unencrypted_base) {
>  		phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
>  
> @@ -175,6 +176,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
>  			pr_err("Failed to map the unencrypted memory %pa size %lx.\n",
>  			       &paddr, bytes);
>  	}
> +#endif
>  
>  	return vaddr;
>  }
> -- 
> 2.25.1
> 
