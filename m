Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608B7518C50
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbiECSbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiECSbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:31:42 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07E43BBE6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:28:08 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id kj8so6825121qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=omdkLVWDymQZwApjqvxbw+i1IH3FdHIBVFJO4bGVqyI=;
        b=DZjpOmlvJkEmvY6d/bKYqPzIi24+OeGX9jjIL1fRQBlGnQyRcaJSY6GECW1aUJfma0
         16mBAopmEHhJukXrELjrHDtNYd+J183Y7CFrMNr4bL00tnXO3bjJD+lEHdtmA1b4f5ca
         t9Tik0wWV6w1j5ntsyzyPB/J/Zm55em5wVK6eQSEkm6WOsdY8UIox9Z7hOkxOl7HT9j2
         CrImIvQb3hRMRn5TT/zqURzPa6UxhqmiJd7LWonHoc8inpsGFMY0bzYzdNXwJ4WYSzme
         8trdRJTIGtP7/CLa+DQkDFsCvYMtrRyh346O2SEIkZRFtpekhfZT5iB0gnFabNEnb/4S
         Fw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omdkLVWDymQZwApjqvxbw+i1IH3FdHIBVFJO4bGVqyI=;
        b=7mgdSIvKOPqhsFNG6lOafJcLDRH1WQNFdCmMPqapDgYUs4Q8Xl2gowXRq0pMg9/ODr
         5OsRZ3CfSJWh6MYqkiRCChHDLE6QmWAdLMNY+cJPz9cD4O3aLbyR5Pc9GSrBaAlUNO9e
         V+DpfzhiIEc1SALyMSDFZyPqU+0H04fbzMYLhe8co/0lZP3qn2kNJCpD89/jgX4jPh2B
         sHJO8/r9EN4ki7lZEr7sRGfVpPWdM66hLNQI3vN7u1D961/4gs3ptKlagQFt6esH4Aef
         yWC8r43mc66t7vC2cOIZYpZWGUqkTtbs8Pgsr+TsSz1O7Vy/HofKH3GLR7F9UjEVhbz9
         J47g==
X-Gm-Message-State: AOAM5307zc+6QLrX2LIBBKK0R6fKRHPFMjILOKYrY1p1uZQIj8GnkkEU
        NFuDYK7yA52AuEbUXSIYP7HumNDwDEjxOYRPgHE=
X-Google-Smtp-Source: ABdhPJwOlpxWUgmZpdOzEfMjW+Eiq6I++GhxgdqnzUuXMGEE76f61tep+acbkbO28XntM7RF2CDvlg==
X-Received: by 2002:a05:6214:519a:b0:456:3d2b:92e with SMTP id kl26-20020a056214519a00b004563d2b092emr14768392qvb.100.1651602487803;
        Tue, 03 May 2022 11:28:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id g77-20020a379d50000000b0069fc13ce21bsm6362583qke.76.2022.05.03.11.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:28:07 -0700 (PDT)
Date:   Tue, 3 May 2022 19:27:40 +0100
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
Subject: Re: [PATCH v5 11/12] iommu: Per-domain I/O page fault handling
Message-ID: <YnF0HIreC1hV4sss@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-12-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-12-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:48:41AM +0800, Lu Baolu wrote:
> Tweak the I/O page fault handling framework to route the page faults to
> the domain and call the page fault handler retrieved from the domain.
> This makes the I/O page fault handling framework possible to serve more
> usage scenarios as long as they have an IOMMU domain and install a page
> fault handler in it. Some unused functions are also removed to avoid
> dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/iommu-sva-lib.h |  1 -
>  drivers/iommu/io-pgfault.c    | 64 ++++-------------------------------
>  drivers/iommu/iommu-sva-lib.c | 20 -----------
>  3 files changed, 7 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 5776b4c80cc1..e7813c6706fb 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -8,7 +8,6 @@
>  #include <linux/ioasid.h>
>  #include <linux/mm_types.h>
>  
> -struct mm_struct *iommu_sva_find(ioasid_t pasid);
>  struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain);
>  
>  /* I/O Page fault */
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 1df8c1dcae77..8a2bb56e1474 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -69,69 +69,18 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
>  	return iommu_page_response(dev, &resp);
>  }
>  
> -static enum iommu_page_response_code
> -iopf_handle_single(struct iopf_fault *iopf)
> -{
> -	vm_fault_t ret;
> -	struct mm_struct *mm;
> -	struct vm_area_struct *vma;
> -	unsigned int access_flags = 0;
> -	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> -	struct iommu_fault_page_request *prm = &iopf->fault.prm;
> -	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> -
> -	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> -		return status;
> -
> -	mm = iommu_sva_find(prm->pasid);
> -	if (IS_ERR_OR_NULL(mm))
> -		return status;
> -
> -	mmap_read_lock(mm);
> -
> -	vma = find_extend_vma(mm, prm->addr);
> -	if (!vma)
> -		/* Unmapped area */
> -		goto out_put_mm;
> -
> -	if (prm->perm & IOMMU_FAULT_PERM_READ)
> -		access_flags |= VM_READ;
> -
> -	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> -		access_flags |= VM_WRITE;
> -		fault_flags |= FAULT_FLAG_WRITE;
> -	}
> -
> -	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> -		access_flags |= VM_EXEC;
> -		fault_flags |= FAULT_FLAG_INSTRUCTION;
> -	}
> -
> -	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> -		fault_flags |= FAULT_FLAG_USER;
> -
> -	if (access_flags & ~vma->vm_flags)
> -		/* Access fault */
> -		goto out_put_mm;
> -
> -	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
> -	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
> -		IOMMU_PAGE_RESP_SUCCESS;
> -
> -out_put_mm:
> -	mmap_read_unlock(mm);
> -	mmput(mm);
> -
> -	return status;
> -}
> -
>  static void iopf_handle_group(struct work_struct *work)
>  {
>  	struct iopf_group *group;
> +	struct iommu_domain *domain;
>  	struct iopf_fault *iopf, *next;
>  	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
>  
>  	group = container_of(work, struct iopf_group, work);
> +	domain = iommu_get_domain_for_dev_pasid(group->dev,
> +			group->last_fault.fault.prm.pasid);
> +	if (!domain || !domain->iopf_handler)
> +		status = IOMMU_PAGE_RESP_INVALID;
>  
>  	list_for_each_entry_safe(iopf, next, &group->faults, list) {
>  		/*
> @@ -139,7 +88,8 @@ static void iopf_handle_group(struct work_struct *work)
>  		 * faults in the group if there is an error.
>  		 */
>  		if (status == IOMMU_PAGE_RESP_SUCCESS)
> -			status = iopf_handle_single(iopf);
> +			status = domain->iopf_handler(&iopf->fault,
> +						      domain->fault_data);
>  
>  		if (!(iopf->fault.prm.flags &
>  		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 05a7d2f0e46f..ae3595d60f38 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -69,26 +69,6 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm,
>  	return ret;
>  }
>  
> -/* ioasid_find getter() requires a void * argument */
> -static bool __mmget_not_zero(void *mm)
> -{
> -	return mmget_not_zero(mm);
> -}
> -
> -/**
> - * iommu_sva_find() - Find mm associated to the given PASID
> - * @pasid: Process Address Space ID assigned to the mm
> - *
> - * On success a reference to the mm is taken, and must be released with mmput().
> - *
> - * Returns the mm corresponding to this PASID, or an error if not found.
> - */
> -struct mm_struct *iommu_sva_find(ioasid_t pasid)
> -{
> -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_find);
> -
>  /*
>   * Get or put an ioas for a shared memory.
>   */
> -- 
> 2.25.1
> 
