Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791B452DA72
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbiESQk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242136AbiESQkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:40:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121C1E77
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:40:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k30so8001896wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g9gYzxWe5NPTbaNAHgbnlMxkb6BQm0o5fPGCfOasomw=;
        b=odGYCXlYMgIzbmhlZajrwAIYrVzVwUGAygS7xDgeEP2rU4W9fYXMtAowdDXWjBuBmN
         N8vUt46PYTxRHIXJUvYhROlIHPsqU+g8ONQJuDAnApcUSeY7b/s6sHKiwpUirq7+VyBb
         T7moq/nxrXA/AYNVxABM+qr+9lTbgERS0jZv+fu7vIqCofJukIpMY8o8Oe8pKbdNmnKN
         PonSzsSzBbtH4erc+IOjytHkSynceUJCBS5xGilAl5fN01iDARm7T9xNJsLRhFmiEd/Y
         SzY4ujloji/i0hf3ldGrjkCz+MwG4nB7+jUg2kfQshpg+oVxpXyaY4KvU73lYn2yOa+7
         rCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g9gYzxWe5NPTbaNAHgbnlMxkb6BQm0o5fPGCfOasomw=;
        b=H6aeZUgX3oHkIyGPw1ab3gEGoLHqKIUPoeE7aeikGhKrzyHxfE6aVznQCdmX0uhSkI
         qLDulqb1uag+IJnl6GSsTwofJjOuzMWs5qQph4KpJ1sxQ/7VwfJLQ+6esYkOxOTbfsI8
         OWLofQ7FA4DOIBgZdImqc7GLNLQjDnCtMT4JWavea1Yw1eAIQGPQHY3aAuTWOFVthCLd
         xfpcM7SJ3St/T4txNUUYIYd54PUGPmaPCIMV69nC2P/hqbrdCxZYUeYm3S22Bu5pZoni
         PBxiIzYOYJsNKB4cSm2y4vq7qJMUG96hIWFrbvTMkdhm5dNDVoeiCxfeiCUaiIGE6ego
         VV0A==
X-Gm-Message-State: AOAM531cAK2ZuLshWQwmBv38pi3RG806002L2h/mvFzXnJC0YvfdmYSq
        h8ViwvtdAF8f0As/5/rSHHsKvtCnMmcJvQ==
X-Google-Smtp-Source: ABdhPJwmsiBN/XwBVe8E5Ys3+WsVkowKP+Je5QRAj4S9lPWo204wsjJqP+iG7dMMB7RDwhMffQZlkw==
X-Received: by 2002:a5d:4ad1:0:b0:20d:b23:fe1b with SMTP id y17-20020a5d4ad1000000b0020d0b23fe1bmr4752812wrs.579.1652978446569;
        Thu, 19 May 2022 09:40:46 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id z6-20020a7bc146000000b003942a244ebesm77922wmi.3.2022.05.19.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:40:46 -0700 (PDT)
Date:   Thu, 19 May 2022 17:40:21 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] iommu: Prepare IOMMU domain for IOPF
Message-ID: <YoZy9fnJlN/RIVY4@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-9-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519072047.2996983-9-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 03:20:45PM +0800, Lu Baolu wrote:
> This adds some mechanisms around the iommu_domain so that the I/O page
> fault handling framework could route a page fault to the domain and
> call the fault handler from it.
> 
> Add pointers to the page fault handler and its private data in struct
> iommu_domain. The fault handler will be called with the private data
> as a parameter once a page fault is routed to the domain. Any kernel
> component which owns an iommu domain could install handler and its
> private parameter so that the page fault could be further routed and
> handled.
> 
> This also prepares the SVA implementation to be the first consumer of
> the per-domain page fault handling model.
> 
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h         |  3 ++
>  drivers/iommu/io-pgfault.c    |  7 ++++
>  drivers/iommu/iommu-sva-lib.c | 65 +++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e4ce2fe0e144..45f274b2640d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -100,6 +100,9 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
> +						      void *data);
> +	void *fault_data;
>  };
>  
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 1df8c1dcae77..aee9e033012f 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -181,6 +181,13 @@ static void iopf_handle_group(struct work_struct *work)
>   * request completes, outstanding faults will have been dealt with by the time
>   * the PASID is freed.
>   *
> + * Any valid page fault will be eventually routed to an iommu domain and the
> + * page fault handler installed there will get called. The users of this
> + * handling framework should guarantee that the iommu domain could only be
> + * freed after the device has stopped generating page faults (or the iommu
> + * hardware has been set to block the page faults) and the pending page faults
> + * have been flushed.
> + *
>   * Return: 0 on success and <0 on error.
>   */
>  int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 568e0f64edac..317ab8e8c149 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -72,6 +72,69 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_find);
>  
> +/*
> + * I/O page fault handler for SVA
> + *
> + * Copied from io-pgfault.c with mmget_not_zero() added before
> + * mmap_read_lock().

Comment doesn't really belong here, maybe better in the commit message.
Apart from that

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> + */
> +static enum iommu_page_response_code
> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
> +{
> +	vm_fault_t ret;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	unsigned int access_flags = 0;
> +	struct iommu_domain *domain = data;
> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> +	struct iommu_fault_page_request *prm = &fault->prm;
> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> +
> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> +		return status;
> +
> +	mm = domain_to_mm(domain);
> +	if (IS_ERR_OR_NULL(mm) || !mmget_not_zero(mm))
> +		return status;
> +
> +	mmap_read_lock(mm);
> +
> +	vma = find_extend_vma(mm, prm->addr);
> +	if (!vma)
> +		/* Unmapped area */
> +		goto out_put_mm;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_READ)
> +		access_flags |= VM_READ;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> +		access_flags |= VM_WRITE;
> +		fault_flags |= FAULT_FLAG_WRITE;
> +	}
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> +		access_flags |= VM_EXEC;
> +		fault_flags |= FAULT_FLAG_INSTRUCTION;
> +	}
> +
> +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> +		fault_flags |= FAULT_FLAG_USER;
> +
> +	if (access_flags & ~vma->vm_flags)
> +		/* Access fault */
> +		goto out_put_mm;
> +
> +	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
> +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
> +		IOMMU_PAGE_RESP_SUCCESS;
> +
> +out_put_mm:
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +
> +	return status;
> +}
> +
>  /*
>   * IOMMU SVA driver-oriented interfaces
>   */
> @@ -94,6 +157,8 @@ iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
>  	domain = &sva_domain->domain;
>  	domain->type = IOMMU_DOMAIN_SVA;
>  	domain->ops = bus->iommu_ops->sva_domain_ops;
> +	domain->iopf_handler = iommu_sva_handle_iopf;
> +	domain->fault_data = domain;
>  
>  	return domain;
>  }
> -- 
> 2.25.1
> 
