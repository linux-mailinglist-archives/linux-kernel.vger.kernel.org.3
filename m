Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E882C518BFB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbiECSQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiECSQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:16:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF52A711
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:12:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d5so24447521wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sYczTiism3AvB5i2HPPMCukvA88W4uV6GroVBqCVwd8=;
        b=l1P52yFfIlCoJeVp9x7e3toeQStCoXmBw8qmitK1qkEHjDq/GideoOhtsl7XjHWqox
         p/LXp78fFQ5ap6IfIz0F8+1StxUF1fGrGZpwFKLVhK2W+KtD3JO7vOw+t19qtxpN2JYr
         CY17h1JvKUie53gJ4URsGi3S5SNVchx0ncmR5aROBk/F1FZuaIXmGlhoMV6jyaRFJajy
         LPUMDsknIqrd1Fh7ZZY16nTQGF+Zk40EwyZoZU0iwYNTqkDePBL2OgmFA+A6RCwe+M7w
         gnzSjS285qeixa7sJPezOz8QEwSRdasVdV4DY50bpkdVfs7cxuJN0HR1iMoFIMa+a/LC
         B9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sYczTiism3AvB5i2HPPMCukvA88W4uV6GroVBqCVwd8=;
        b=PnqB38iPTh8XE7wFb8TJ7QKDPKyAirBNrPk6T93785nDKgEIezaAcIHkjTHMRfKkTI
         rwrTDfONtXmiXA4tpeOKP+vs8/k+CWPT7U+sZqkPie6aN8WkGoggB09BUCBeP0OmuTNZ
         FcjLL10nxG2+kBA6FuH5AJX8V5nyECUshKxFQsGP1y3TeCMTha/c5Suw+N3m8ciy7A8G
         CDNU5vIt/w4IBMH8QNXo2w9PsRXmzhx+UbrS9DvHShKkNrbQ90a99LDqOlBvxfrc+v2z
         AP4mbBOBxRf9Pe4nszaopaEWp8XYDz0HiG0ctq9/4IXgmf615baIAtu0oXTBWFw2kIm1
         rL6Q==
X-Gm-Message-State: AOAM532yO2aAhL7HJVCOTHKNLT6N5/jIncIEOncbSIAGdYmblBG2PURn
        CAj/oQdZRYW/edU1SrP9ehZiCg==
X-Google-Smtp-Source: ABdhPJzZrRo9lI/2sW0emG53DTRhp5HvrUFRkNLyUitvmuN4N7njcGivXM25nQUesOJYzJbyXRxOnQ==
X-Received: by 2002:a05:6000:1a87:b0:20c:687f:6d10 with SMTP id f7-20020a0560001a8700b0020c687f6d10mr6421133wry.574.1651601569296;
        Tue, 03 May 2022 11:12:49 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id i128-20020a1c3b86000000b003942a244ebfsm2217051wma.4.2022.05.03.11.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:12:48 -0700 (PDT)
Date:   Tue, 3 May 2022 19:12:24 +0100
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
Subject: Re: [PATCH v5 07/12] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <YnFwiLkvYtLn43Qv@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-8-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:48:37AM +0800, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 +++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 42 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 21 ++++++++++
>  3 files changed, 77 insertions(+)
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
> index c623dae1e115..3b843cd3ed67 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -541,3 +541,45 @@ void arm_smmu_sva_notifier_synchronize(void)
>  	 */
>  	mmu_notifier_synchronize();
>  }
> +
> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> +				  struct device *dev, ioasid_t id)
> +{
> +	int ret = 0;
> +	struct iommu_sva *handle;
> +	struct mm_struct *mm = iommu_sva_domain_mm(domain);
> +
> +	if (domain->type != IOMMU_DOMAIN_SVA || !mm)

We wouldn't get that far with a non-SVA domain since iommu_sva_domain_mm()
would dereference a NULL pointer. Could you move it after the domain->type
check, and maybe add a WARN_ON()?  It could help catch issues in future
API changes.

> +		return -EINVAL;
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
> +	struct mm_struct *mm = iommu_sva_domain_mm(domain);
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
> index afc63fce6107..bd80de0bad98 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1995,10 +1995,31 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  	}
>  }
>  
> +static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
> +{
> +	kfree(domain);
> +}
> +
> +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
> +	.attach_dev_pasid	= arm_smmu_sva_attach_dev_pasid,
> +	.detach_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
> +	.free			= arm_smmu_sva_domain_free,
> +};
> +
>  static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  {
>  	struct arm_smmu_domain *smmu_domain;
>  
> +	if (type == IOMMU_DOMAIN_SVA) {
> +		struct iommu_domain *domain;
> +
> +		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +		if (domain)
> +			domain->ops = &arm_smmu_sva_domain_ops;
> +
> +		return domain;
> +	}
> +

I'd prefer moving all of this to arm-smmu-v3-sva.c and just call
arm_smmu_sva_domain_alloc() here

Otherwise the patch looks fine. I'll rework the driver when I find some
time, because we can now remove arm_smmu_bond and move smmu_mn to the SVA
domain, maybe also remove sva_lock but I haven't thought it through.

Thanks,
Jean

>  	if (type != IOMMU_DOMAIN_UNMANAGED &&
>  	    type != IOMMU_DOMAIN_DMA &&
>  	    type != IOMMU_DOMAIN_DMA_FQ &&
> -- 
> 2.25.1
> 
