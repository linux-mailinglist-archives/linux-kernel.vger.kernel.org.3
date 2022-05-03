Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD4B518C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiECSTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiECSTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:19:00 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E912DA96
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:15:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a22so11299343qkl.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OgSbB7xviil735GerxOuwIuRvfVfav3PuE+3DES2qXM=;
        b=Zk5H8M3i8c2o3PgxQ9qMTDk1dmurKwMWx7/9kOj5v3vUJ9rxhk8HlrsJ8j9TH6OC3l
         3V1nPlkO9a57YEkqK5zLcy2e+7mgoye6BJL7Hm/MJnBe2xiIhM+7cnYhNud9qeZ/ZKZS
         i3rmYgmEYUUBdtDm7mH9BLgDncbOt7gfOoqKFZXRAU0ruSA3jjnV7WvnE8S7nPCCAk1k
         5FieEXVjXWvUN5V26CMYj6wYz/Trp/2FQbLoN4THekM3s8L8dhLrkvyWOlTYS5FBNsWd
         J/+eYku9dmlLQPJREn2lXw7HNb//hJdr19sEalGEQNCGyIHjvhRImf3YhOJuys3B7m2k
         SNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OgSbB7xviil735GerxOuwIuRvfVfav3PuE+3DES2qXM=;
        b=PK8Tc5tRGclYe7lpr5Ny6QJ+12BVtFBGGR6vM0UVsP7Si+6NP7JLFIME6LC6y1j+zT
         qtJFSlH4s/1sH8W8BVXFtFKjjvlAZ6xwf7TQH7Ue+CR31d5urBdpgOyOC/ZJPGyOM+st
         vI0Q5yLYI/ecDzo0/K+eMxK8D/P/jpaFOwFgMEuOQCwHLJekEoJRArFEMd8LqVwZA3UD
         OUNEw9wWcYvcIa2vhtl+5C2FtvHO0t5/hhUDhoDcBOtphZM0vTIhNeUbUxaex6tFr+ll
         4kZPFn7PTKyN7bu6YOqFLebATxWj3sI/SAtMMc5xkALJeYPyJqqATv+xw0ePjRNuzuup
         wlcw==
X-Gm-Message-State: AOAM530wgcWyMpWMj1QFRF6sAHTFFq3LYaQ1kZXUAkbo/D/bUzdI3LmP
        wAtmHspeXQ3qAunNpbNVxHbB7w==
X-Google-Smtp-Source: ABdhPJwhtZpbfAP9HfWXuO/bOO57lDoAp0l6pbWq7Gei7svBynqa0Ret31M8DnRk8FcdZGshbWBfzA==
X-Received: by 2002:a37:a04b:0:b0:69f:baff:b185 with SMTP id j72-20020a37a04b000000b0069fbaffb185mr13320182qke.176.1651601725297;
        Tue, 03 May 2022 11:15:25 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id g24-20020ac870d8000000b002f39b99f690sm6148851qtp.42.2022.05.03.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:15:23 -0700 (PDT)
Date:   Tue, 3 May 2022 19:14:56 +0100
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
Subject: Re: [PATCH v5 09/12] iommu: Remove SVA related callbacks from iommu
 ops
Message-ID: <YnFxIMLi1Bjs72XB@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-10-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-10-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:48:39AM +0800, Lu Baolu wrote:
> These ops'es have been replaced with the dev_attach/detach_pasid domain
> ops'es. There's no need for them anymore. Remove them to avoid dead
> code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  include/linux/intel-iommu.h                   |  4 --
>  include/linux/iommu.h                         |  8 ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 17 -------
>  drivers/iommu/iommu-sva-lib.h                 |  1 -
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 41 ----------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 --
>  drivers/iommu/intel/iommu.c                   |  3 --
>  drivers/iommu/intel/svm.c                     | 49 -------------------
>  drivers/iommu/iommu-sva-lib.c                 |  4 +-
>  9 files changed, 2 insertions(+), 128 deletions(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 3b4ca16f53e2..5af24befc9f1 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -738,10 +738,6 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
>  extern void intel_svm_check(struct intel_iommu *iommu);
>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> -struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
> -				 void *drvdata);
> -void intel_svm_unbind(struct iommu_sva *handle);
> -u32 intel_svm_get_pasid(struct iommu_sva *handle);
>  int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
>  			    struct iommu_page_response *msg);
>  extern const struct iommu_domain_ops intel_svm_domain_ops;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index c5a16b47cae8..19718939d9df 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -214,9 +214,6 @@ struct iommu_iotlb_gather {
>   * @dev_has/enable/disable_feat: per device entries to check/enable/disable
>   *                               iommu specific features.
>   * @dev_feat_enabled: check enabled feature
> - * @sva_bind: Bind process address space to device
> - * @sva_unbind: Unbind process address space from device
> - * @sva_get_pasid: Get PASID associated to a SVA handle
>   * @page_response: handle page request response
>   * @def_domain_type: device default domain type, return value:
>   *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
> @@ -250,11 +247,6 @@ struct iommu_ops {
>  	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
>  	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
>  
> -	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
> -				      void *drvdata);
> -	void (*sva_unbind)(struct iommu_sva *handle);
> -	u32 (*sva_get_pasid)(struct iommu_sva *handle);
> -
>  	int (*page_response)(struct device *dev,
>  			     struct iommu_fault_event *evt,
>  			     struct iommu_page_response *msg);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 7631c00fdcbd..2513309ec0db 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -754,10 +754,6 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
>  int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
>  int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
>  bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
> -struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
> -				    void *drvdata);
> -void arm_smmu_sva_unbind(struct iommu_sva *handle);
> -u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>  void arm_smmu_sva_notifier_synchronize(void);
>  int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
>  				  struct device *dev, ioasid_t id);
> @@ -794,19 +790,6 @@ static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master
>  	return false;
>  }
>  
> -static inline struct iommu_sva *
> -arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> -{
> -	return ERR_PTR(-ENODEV);
> -}
> -
> -static inline void arm_smmu_sva_unbind(struct iommu_sva *handle) {}
> -
> -static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	return IOMMU_PASID_INVALID;
> -}
> -
>  static inline void arm_smmu_sva_notifier_synchronize(void) {}
>  
>  static inline int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 9c5e108e2c8a..5776b4c80cc1 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -8,7 +8,6 @@
>  #include <linux/ioasid.h>
>  #include <linux/mm_types.h>
>  
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
>  struct mm_struct *iommu_sva_find(ioasid_t pasid);
>  struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain);
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 3b843cd3ed67..0ace04b27d4b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -335,11 +335,6 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>  	if (!bond)
>  		return ERR_PTR(-ENOMEM);
>  
> -	/* Allocate a PASID for this mm if necessary */
> -	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
> -	if (ret)
> -		goto err_free_bond;
> -
>  	bond->mm = mm;
>  	bond->sva.dev = dev;
>  	refcount_set(&bond->refs, 1);
> @@ -358,42 +353,6 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>  	return ERR_PTR(ret);
>  }
>  
> -struct iommu_sva *
> -arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> -{
> -	struct iommu_sva *handle;
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> -
> -	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
> -		return ERR_PTR(-EINVAL);
> -
> -	mutex_lock(&sva_lock);
> -	handle = __arm_smmu_sva_bind(dev, mm);
> -	mutex_unlock(&sva_lock);
> -	return handle;
> -}
> -
> -void arm_smmu_sva_unbind(struct iommu_sva *handle)
> -{
> -	struct arm_smmu_bond *bond = sva_to_bond(handle);
> -
> -	mutex_lock(&sva_lock);
> -	if (refcount_dec_and_test(&bond->refs)) {
> -		list_del(&bond->list);
> -		arm_smmu_mmu_notifier_put(bond->smmu_mn);
> -		kfree(bond);
> -	}
> -	mutex_unlock(&sva_lock);
> -}
> -
> -u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	struct arm_smmu_bond *bond = sva_to_bond(handle);
> -
> -	return bond->mm->pasid;
> -}
> -
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  {
>  	unsigned long reg, fld;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index bd80de0bad98..543d3ef1c102 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2875,9 +2875,6 @@ static struct iommu_ops arm_smmu_ops = {
>  	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
>  	.dev_enable_feat	= arm_smmu_dev_enable_feature,
>  	.dev_disable_feat	= arm_smmu_dev_disable_feature,
> -	.sva_bind		= arm_smmu_sva_bind,
> -	.sva_unbind		= arm_smmu_sva_unbind,
> -	.sva_get_pasid		= arm_smmu_sva_get_pasid,
>  	.page_response		= arm_smmu_page_response,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  	.owner			= THIS_MODULE,
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5d1d3e325afa..46e2eb15197b 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4914,9 +4914,6 @@ const struct iommu_ops intel_iommu_ops = {
>  	.def_domain_type	= device_def_domain_type,
>  	.pgsize_bitmap		= SZ_4K,
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> -	.sva_bind		= intel_svm_bind,
> -	.sva_unbind		= intel_svm_unbind,
> -	.sva_get_pasid		= intel_svm_get_pasid,
>  	.page_response		= intel_svm_page_response,
>  #endif
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index ec684d883014..6084f960ba27 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -313,14 +313,6 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
>  	return 0;
>  }
>  
> -static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
> -{
> -	ioasid_t max_pasid = dev_is_pci(dev) ?
> -			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
> -
> -	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
> -}
> -
>  static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>  					   struct device *dev,
>  					   struct mm_struct *mm)
> @@ -809,47 +801,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  	return IRQ_RETVAL(handled);
>  }
>  
> -struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> -{
> -	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> -	struct iommu_sva *sva;
> -	int ret;
> -
> -	mutex_lock(&pasid_mutex);
> -	ret = intel_svm_alloc_pasid(dev, mm);
> -	if (ret) {
> -		mutex_unlock(&pasid_mutex);
> -		return ERR_PTR(ret);
> -	}
> -
> -	sva = intel_svm_bind_mm(iommu, dev, mm);
> -	mutex_unlock(&pasid_mutex);
> -
> -	return sva;
> -}
> -
> -void intel_svm_unbind(struct iommu_sva *sva)
> -{
> -	struct intel_svm_dev *sdev = to_intel_svm_dev(sva);
> -
> -	mutex_lock(&pasid_mutex);
> -	intel_svm_unbind_mm(sdev->dev, sdev->pasid);
> -	mutex_unlock(&pasid_mutex);
> -}
> -
> -u32 intel_svm_get_pasid(struct iommu_sva *sva)
> -{
> -	struct intel_svm_dev *sdev;
> -	u32 pasid;
> -
> -	mutex_lock(&pasid_mutex);
> -	sdev = to_intel_svm_dev(sva);
> -	pasid = sdev->pasid;
> -	mutex_unlock(&pasid_mutex);
> -
> -	return pasid;
> -}
> -
>  int intel_svm_page_response(struct device *dev,
>  			    struct iommu_fault_event *evt,
>  			    struct iommu_page_response *msg)
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 0524659a4c0c..992388106da0 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -41,7 +41,8 @@ struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain)
>   *
>   * Returns 0 on success and < 0 on error.
>   */
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> +static int iommu_sva_alloc_pasid(struct mm_struct *mm,
> +				 ioasid_t min, ioasid_t max)
>  {
>  	int ret = 0;
>  	ioasid_t pasid;
> @@ -67,7 +68,6 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  	mutex_unlock(&iommu_sva_lock);
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
>  
>  /* ioasid_find getter() requires a void * argument */
>  static bool __mmget_not_zero(void *mm)
> -- 
> 2.25.1
> 
