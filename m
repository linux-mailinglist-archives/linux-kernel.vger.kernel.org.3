Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9584D4E2545
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbiCULdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiCULdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:33:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184BE8EB78
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:31:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dr20so28827402ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PQzatZvQ0rnATnfydXXlZrcHERA9v9fqeol3oNRKe0s=;
        b=o6jTaq+guIeRJ1bVk1VLAfnnqbZ52yA+6P9AnEGOtOEqKkkiqb/sch6b14kyOhlCF9
         9CCR1EeOrSziOpa4PX8fDCbsloh+uaPQ2wfOmIfP59VnqWPaM7O8MfZDIhXN8IOn07c9
         8/bwgRBom5WtQhd/qXWBBdib7N0qe7VW9Qb68Xd0Fev9UxWOu7CmqU9f5vbcePQjKOCD
         nRkCw0AWy2n7DDLgMwgv/kSA6Yf97rrtN7oScgWQhCOSVZ8DFJ+k2AxSj57osJk04nu1
         d+uKFhRjycjKHvOKgIVkC/dMpWFvQVHeqyyzBsuySWhPvil1dVzcd8+VY8NS+vrRAw+e
         l9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQzatZvQ0rnATnfydXXlZrcHERA9v9fqeol3oNRKe0s=;
        b=ruWqM7qROpvoTTWaLAx0V3C8RO/n663Dn49eshmkhd5T39Xh15WAy3EjNaNsHzeOHr
         TfzGtlQDC7N/gES122IwNzTzm6lRBGZLgORk98C+IHYC3J4ADSu4miLbPyGr7zdAUddl
         8FPNRURBFbEjqnRH40QJSG6sBNHE6IDYnAYfIT+3aeLMKO6J2oABlCOSqwOjtgcn2rn7
         dCAhKfYNLKppjvkIlB72GH+wBFPS9YZVYtrWaO2OObC3w9IdSbKTiRaJvuxQKCNnjUK3
         CO2XwkZ/UHep6qjlZY4AHFykyZy7fGSYtsPsFEUrtyS2lYeey33aDvj2Ay0Pckh+r1ez
         gK9w==
X-Gm-Message-State: AOAM530gLylcSFahHBOz5s33InJNrCx+7js7dTvT+9N2ATrBV6tZbvlE
        rwGUooIpbrq1yg8ANqhCjMGdyg==
X-Google-Smtp-Source: ABdhPJyL9LR1se3eQeUHysrOzRuRAJK4jfY+6A8O1BnJb+gkVSsQ0NGrsR6W/95ufMiuyrJxX0jmKw==
X-Received: by 2002:a17:907:b590:b0:6c1:c061:d945 with SMTP id qx16-20020a170907b59000b006c1c061d945mr20083570ejc.768.1647862304429;
        Mon, 21 Mar 2022 04:31:44 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id z6-20020a056402274600b004194fc1b7casm101822edd.48.2022.03.21.04.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 04:31:44 -0700 (PDT)
Date:   Mon, 21 Mar 2022 11:31:19 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 05/11] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <YjhiByacn+WACHCU@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-6-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-6-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 02:40:24PM +0800, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 ++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 45 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 13 +++++-
>  3 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index cd48590ada30..7631c00fdcbd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -759,6 +759,10 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
>  void arm_smmu_sva_unbind(struct iommu_sva *handle);
>  u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>  void arm_smmu_sva_notifier_synchronize(void);
> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> +				  struct device *dev, ioasid_t id);
> +void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
> +				   struct device *dev, ioasid_t id);
>  #else /* CONFIG_ARM_SMMU_V3_SVA */
>  static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  {
> @@ -804,5 +808,15 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
>  }
>  
>  static inline void arm_smmu_sva_notifier_synchronize(void) {}
> +
> +static inline int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> +						struct device *dev, ioasid_t id)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
> +						 struct device *dev,
> +						 ioasid_t id) {}
>  #endif /* CONFIG_ARM_SMMU_V3_SVA */
>  #endif /* _ARM_SMMU_V3_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 22ddd05bbdcd..1e114b9dc17f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -534,3 +534,48 @@ void arm_smmu_sva_notifier_synchronize(void)
>  	 */
>  	mmu_notifier_synchronize();
>  }
> +
> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> +				  struct device *dev, ioasid_t id)
> +{
> +	int ret = 0;
> +	struct iommu_sva *handle;
> +	struct mm_struct *mm = domain->sva_cookie;
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +
> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1 ||

This check is for the parent domain, iommu_get_domain_for_dev(dev)

> +	    domain->type != IOMMU_DOMAIN_SVA || !mm)
> +		return -EINVAL;
> +
> +	mutex_lock(&sva_lock);
> +	handle = __arm_smmu_sva_bind(dev, mm);
> +	if (IS_ERR_OR_NULL(handle))
> +		ret = PTR_ERR(handle);
> +	mutex_unlock(&sva_lock);
> +
> +	return ret;
> +}
> +
> +void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
> +				   struct device *dev, ioasid_t id)
> +{
> +	struct arm_smmu_bond *bond = NULL, *t;
> +	struct mm_struct *mm = domain->sva_cookie;
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +
> +	mutex_lock(&sva_lock);
> +	list_for_each_entry(t, &master->bonds, list) {
> +		if (t->mm == mm) {
> +			bond = t;
> +			break;
> +		}
> +	}
> +
> +	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
> +		list_del(&bond->list);
> +		arm_smmu_mmu_notifier_put(bond->smmu_mn);
> +		iommu_sva_free_pasid(bond->mm);

Can be dropped since iommu.c does PASID allocation (also the one in
__arm_smmu_sva_bind() as a cleanup patch)

> +		kfree(bond);
> +	}
> +	mutex_unlock(&sva_lock);
> +}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8e262210b5ad..2e9d3cd30510 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -88,6 +88,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ 0, NULL},
>  };
>  
> +static void arm_smmu_domain_free(struct iommu_domain *domain);
> +
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
>  	int i = 0;
> @@ -1995,6 +1997,12 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  	}
>  }
>  
> +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
> +	.attach_dev_pasid	= arm_smmu_sva_attach_dev_pasid,
> +	.detach_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
> +	.free			= arm_smmu_domain_free,
> +};
> +
>  static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  {
>  	struct arm_smmu_domain *smmu_domain;
> @@ -2002,7 +2010,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  	if (type != IOMMU_DOMAIN_UNMANAGED &&
>  	    type != IOMMU_DOMAIN_DMA &&
>  	    type != IOMMU_DOMAIN_DMA_FQ &&
> -	    type != IOMMU_DOMAIN_IDENTITY)
> +	    type != IOMMU_DOMAIN_IDENTITY &&
> +	    type != IOMMU_DOMAIN_SVA)
>  		return NULL;

We don't need to allocate an arm_smmu_domain, it likely won't have
anything in common with the SVA domain and it would be much clearer within
the SMMU driver if we use different structs for parent and child domains.
For now we could just return a naked struct iommu_domain. Sanity checks in
arm_smmu_attach_dev() would be good too, a SVA domain can't be attached as
a parent domain.

I this this works otherwise, but will need to test the series to see what
more is needed, when I find some time.

Thanks,
Jean

>  
>  	/*
> @@ -2018,6 +2027,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  	INIT_LIST_HEAD(&smmu_domain->devices);
>  	spin_lock_init(&smmu_domain->devices_lock);
>  	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
> +	if (type == IOMMU_DOMAIN_SVA)
> +		smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
>  
>  	return &smmu_domain->domain;
>  }
> -- 
> 2.25.1
> 
