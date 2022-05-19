Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E277352DA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbiESQiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiESQh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:37:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFBBD8090
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:37:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f2so8029198wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FEdVgqo8LuBqkPaQiJ7UaThEjH5OciLn+zJb0Z2rPec=;
        b=wVQQ3DB3c+BD0bcw7D2QBZ66EAV+RtMMhfgoSV1qYu6ejuYsQieJ+t3XSlnQCOGSBQ
         SFDG/MzLIRsjLzCM7RTz3UK8zaOuKBErWKF8jj6WitlEEWOZ0ZpGs+7Cv/57InvZnVzZ
         6Wy7jAdJ6tRPjCSmt9Km41gF5rpn1qXGNcZTfIStx3vgn69FawRavUSmIHZT3YAjT//p
         1KjN5IhkNkj/gP/Kkc7FmvDQSFF5ic/mW7CaKwt8VszpmC8FWBccVNRMH+ZKv9Sbs3WD
         va1C0kITnyDKBLo6uGNFcc1JVQnuzpbwYp2Ee8/SvCrxRHuMdghTG3p80AUqNzH55zFl
         AtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FEdVgqo8LuBqkPaQiJ7UaThEjH5OciLn+zJb0Z2rPec=;
        b=HUqFOmL/GrKwDLKrC2cD+cONtBW6vdfbLewaeAZWVFQi8QJcuuJaATZqwch9ncyJnX
         mkHo3N/tYRb8kh1MDWybJLDwdOSH6W7N7U3XgA9nOLB9d7fgSP+bQqYhc9StZc3VhFDX
         L1mRyq0E7m4tqP7NqvWvepZhJ3pheBZ3J1MspXkApn2pXK/j8//mzaej4Xq/+k6+cwtu
         1rOBBdqhQtRanbQCFwAr9K5l6JB/PKvqaKlmmZs3CaHh1O57r019TaJuK9JdkUpkkyQ9
         /ucoM6pNZB+KVphRTeIj+GJrID9sUGgTBGPBjAgvrmhVTxvA88ZdOfSMeg5q9EN8KGj6
         KdkQ==
X-Gm-Message-State: AOAM533gLt35+dN2CrG1pTMT0dJzP4sjpIkFpO+8H5OixE2KZy6N9i1J
        1Eqt5ucwOHSFtWBniTxJ2rECmg==
X-Google-Smtp-Source: ABdhPJzFnceQn5e5Wzw4TmInSFRcAyP5hGwf5JsgXFD4NtjmPGuIub/SlWG/T9DFeKcXM7WqMukowg==
X-Received: by 2002:a5d:4f0c:0:b0:20e:5906:713d with SMTP id c12-20020a5d4f0c000000b0020e5906713dmr4717226wru.634.1652978273198;
        Thu, 19 May 2022 09:37:53 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b003942a244f39sm38873wmb.18.2022.05.19.09.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:37:52 -0700 (PDT)
Date:   Thu, 19 May 2022 17:37:28 +0100
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
Subject: Re: [PATCH v7 05/10] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <YoZySINkH/MTudFA@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-6-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519072047.2996983-6-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 03:20:42PM +0800, Lu Baolu wrote:
> Add support for domain ops callbacks for an SVA domain.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

(I'll try to take some time next cycle to clean up the driver following
this change)

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 46 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 +++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index d2ba86470c42..ec77f6a51ff9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -758,6 +758,10 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
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
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index f155d406c5d5..6969974ca89e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -549,3 +549,49 @@ void arm_smmu_sva_notifier_synchronize(void)
>  	 */
>  	mmu_notifier_synchronize();
>  }
> +
> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> +				  struct device *dev, ioasid_t id)
> +{
> +	int ret = 0;
> +	struct mm_struct *mm;
> +	struct iommu_sva *handle;
> +
> +	if (domain->type != IOMMU_DOMAIN_SVA)
> +		return -EINVAL;
> +
> +	mm = domain_to_mm(domain);
> +	if (WARN_ON(!mm))
> +		return -ENODEV;
> +
> +	mutex_lock(&sva_lock);
> +	handle = __arm_smmu_sva_bind(dev, mm);
> +	if (IS_ERR(handle))
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
> +	struct mm_struct *mm = domain_to_mm(domain);
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
> +		kfree(bond);
> +	}
> +	mutex_unlock(&sva_lock);
> +}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6e2cd082c670..4ad3ca70cf89 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2858,6 +2858,12 @@ static struct iommu_ops arm_smmu_ops = {
>  	.page_response		= arm_smmu_page_response,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  	.owner			= THIS_MODULE,
> +#ifdef CONFIG_ARM_SMMU_V3_SVA
> +	.sva_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev_pasid		= arm_smmu_sva_attach_dev_pasid,
> +		.block_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
> +	},
> +#endif
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev		= arm_smmu_attach_dev,
>  		.map_pages		= arm_smmu_map_pages,
> -- 
> 2.25.1
> 
