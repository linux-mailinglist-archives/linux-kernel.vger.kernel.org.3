Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9DB46E737
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbhLILHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhLILHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:07:21 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87B8C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:03:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so8966836wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 03:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gco8rXFcPUiWI8MIlsOriypkPxo61cnS1MnZYRGL2nI=;
        b=pjNZyALMOJOTfoZjeajYIb2h1unn9loejD1zJAhfuzMuvWRtpb/8HY0X/ABJX/YEy4
         AqUVyD15chaLb5K0qQEIgZWJmN6Ylv+oX912Qw3bauO68XbZ6twZc7naSzwlA7ySOq10
         GpdrqdLderxJTc5X+3AXGaaJojlDTMVqIBTaQelVgwe5lEKYntCmSHvykP54jqZBMBYa
         dnsOdbVXirou544quG/p9AYJDYQ5bXKOpPoWJct7L2qapoA626ifz4GmlN0oHEc/OD6A
         9nWz4piGB2SQfw1UzvzIDaSWqpw6WI2X4b3+CjL9iRC7Y0cGqQLpNEdsuvtbqpCMimea
         bvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gco8rXFcPUiWI8MIlsOriypkPxo61cnS1MnZYRGL2nI=;
        b=U2q3WyyARPtbzB2pwtIM+ubW6KO6ik/xV8qDA5SdMjAp/BAwgpGTYdIEx5MVRIl4x7
         waNjtkqzLM3Z9WUbxNY0d/5qjQMSyNNhqtZvbnVsZ8n9Gy1At9WIx6m09ZN+9/eESfhQ
         rVOIubiICvWjyCqpYEH3Df3hQ5ohDqG/jcI+Gms99h7BEJbTMR6rPndBW/r3TKtOlz6B
         KpWJv1fPGK7f6qz2za/GE5Eor95kRbIeK2MFz5tk2ihiy9v6sOLa5U+qPF3MWRhYKJ7e
         NVUJudzjQRenJEdkkG8yLlWN89i5YOoZjpfDD/AiNUC/blMIVv4+DTQIiYK1XKzlgGxk
         Hsbw==
X-Gm-Message-State: AOAM533PBDJexmOZpdbmYoF5R58o7i1A7fczVnodjBuHUyCqSNF75Yfq
        +2CnrIzAm+8yOseH+WAIjeN3sA==
X-Google-Smtp-Source: ABdhPJzpu+okH7QBd+cokXbACh6KbY/U9SclkLgPBvY63AozEULnhT7BRdcw5jvVY9ysEsQAQdZtPg==
X-Received: by 2002:adf:f990:: with SMTP id f16mr5485994wrr.128.1639047825984;
        Thu, 09 Dec 2021 03:03:45 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id f15sm6639511wmg.30.2021.12.09.03.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 03:03:45 -0800 (PST)
Date:   Thu, 9 Dec 2021 11:03:23 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <YbHie/Z4bIXwTInx@myrica>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On Tue, Dec 07, 2021 at 05:47:11AM -0800, Jacob Pan wrote:
> In-kernel DMA is managed by DMA mapping APIs, which supports per device
> addressing mode for legacy DMA requests. With the introduction of
> Process Address Space ID (PASID), device DMA can now target at a finer
> granularity per PASID + Requester ID (RID).
> 
> However, for in-kernel DMA there is no need to differentiate between
> legacy DMA and DMA with PASID in terms of mapping. DMA address mapping
> for RID+PASID can be made identical to the RID. The benefit for the
> drivers is the continuation of DMA mapping APIs without change.
> 
> This patch reserves a special IOASID for devices that perform in-kernel
> DMA requests with PASID. This global IOASID is excluded from the
> IOASID allocator. The analogous case is PASID #0, a special PASID
> reserved for DMA requests without PASID (legacy). We could have different
> kernel PASIDs for individual devices, but for simplicity reasons, a
> globally reserved one will fit the bill.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
>  drivers/iommu/intel/iommu.c                     | 4 ++--
>  drivers/iommu/intel/pasid.h                     | 3 +--
>  drivers/iommu/intel/svm.c                       | 2 +-
>  drivers/iommu/ioasid.c                          | 2 ++
>  include/linux/ioasid.h                          | 4 ++++
>  6 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index ee66d1f4cb81..ac79a37ffe06 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -329,7 +329,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>  		return ERR_PTR(-ENOMEM);
>  
>  	/* Allocate a PASID for this mm if necessary */
> -	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
> +	ret = iommu_sva_alloc_pasid(mm, IOASID_ALLOC_BASE, (1U << master->ssid_bits) - 1);

I'd rather keep hardware limits as parameters here. PASID#0 is reserved by
the SMMUv3 hardware so we have to pass at least 1 here, but VT-d could
change RID_PASID and pass 0. On the other hand IOASID_DMA_PASID depends on
device drivers needs and is not needed on all systems, so I think could
stay within the ioasid allocator. Could VT-d do an ioasid_alloc()/ioasid_get()
to reserve this global PASID, storing it under the device_domain_lock?

This looks like we're just one step away from device drivers needing
multiple PASIDs for kernel DMA so I'm trying to figure out how to evolve
the API towards that. It's probably as simple as keeping a kernel IOASID
set at first, but then we'll probably want to optimize by having multiple
overlapping sets for each device driver (all separate from the SVA set).

Thanks,
Jean

