Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E85528313
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbiEPLW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243018AbiEPLWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:22:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 432B1377DA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:22:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA1A71063;
        Mon, 16 May 2022 04:22:16 -0700 (PDT)
Received: from [10.57.82.175] (unknown [10.57.82.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF5803F66F;
        Mon, 16 May 2022 04:22:13 -0700 (PDT)
Message-ID: <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
Date:   Mon, 16 May 2022 12:22:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-GB
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220516015759.2952771-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-16 02:57, Lu Baolu wrote:
> Each IOMMU driver must provide a blocking domain ops. If the hardware
> supports detaching domain from device, setting blocking domain equals
> detaching the existing domain from the deivce. Otherwise, an UNMANAGED
> domain without any mapping will be used instead.

Unfortunately that's backwards - most of the implementations of 
.detach_dev are disabling translation entirely, meaning the device ends 
up effectively in passthrough rather than blocked. Conversely, at least 
arm-smmu and arm-smmu-v3 could implement IOMMU_DOMAIN_BLOCKED properly 
with fault-type S2CRs and STEs respectively, it just needs a bit of 
wiring up.

Thanks,
Robin.

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   include/linux/iommu.h                       |  7 +++++++
>   drivers/iommu/amd/iommu.c                   | 12 ++++++++++++
>   drivers/iommu/apple-dart.c                  | 12 ++++++++++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 +++
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 +++
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 12 ++++++++++++
>   drivers/iommu/exynos-iommu.c                | 12 ++++++++++++
>   drivers/iommu/fsl_pamu_domain.c             | 12 ++++++++++++
>   drivers/iommu/intel/iommu.c                 | 12 ++++++++++++
>   drivers/iommu/ipmmu-vmsa.c                  | 12 ++++++++++++
>   drivers/iommu/msm_iommu.c                   | 12 ++++++++++++
>   drivers/iommu/mtk_iommu.c                   | 12 ++++++++++++
>   drivers/iommu/mtk_iommu_v1.c                | 12 ++++++++++++
>   drivers/iommu/omap-iommu.c                  | 12 ++++++++++++
>   drivers/iommu/rockchip-iommu.c              | 12 ++++++++++++
>   drivers/iommu/s390-iommu.c                  | 12 ++++++++++++
>   drivers/iommu/sprd-iommu.c                  | 11 +++++++++++
>   drivers/iommu/sun50i-iommu.c                | 12 ++++++++++++
>   drivers/iommu/tegra-gart.c                  | 12 ++++++++++++
>   drivers/iommu/tegra-smmu.c                  | 12 ++++++++++++
>   drivers/iommu/virtio-iommu.c                |  3 +++
>   21 files changed, 219 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 572399ac1d83..5e228aad0ef6 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -216,6 +216,7 @@ struct iommu_iotlb_gather {
>    *		- IOMMU_DOMAIN_DMA: must use a dma domain
>    *		- 0: use the default setting
>    * @default_domain_ops: the default ops for domains
> + * @blocking_domain_ops: the blocking ops for domains
>    * @pgsize_bitmap: bitmap of all possible supported page sizes
>    * @owner: Driver module providing these ops
>    */
> @@ -255,6 +256,7 @@ struct iommu_ops {
>   	int (*def_domain_type)(struct device *dev);
>   
>   	const struct iommu_domain_ops *default_domain_ops;
> +	const struct iommu_domain_ops *blocking_domain_ops;
>   	unsigned long pgsize_bitmap;
>   	struct module *owner;
>   };
> @@ -279,6 +281,9 @@ struct iommu_ops {
>    * @enable_nesting: Enable nesting
>    * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>    * @free: Release the domain after use.
> + * @blocking_domain_detach: iommu hardware support detaching a domain from
> + *		a device, hence setting blocking domain to a device equals to
> + *		detach the existing domain from it.
>    */
>   struct iommu_domain_ops {
>   	int (*set_dev)(struct iommu_domain *domain, struct device *dev);
> @@ -310,6 +315,8 @@ struct iommu_domain_ops {
>   				  unsigned long quirks);
>   
>   	void (*free)(struct iommu_domain *domain);
> +
> +	unsigned int blocking_domain_detach:1;
>   };
>   
>   /**
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 01b8668ef46d..c66713439824 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2272,6 +2272,14 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>   	return true;
>   }
>   
> +static int amd_blocking_domain_set_dev(struct iommu_domain *domain,
> +				       struct device *dev)
> +{
> +	amd_iommu_detach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   const struct iommu_ops amd_iommu_ops = {
>   	.capable = amd_iommu_capable,
>   	.domain_alloc = amd_iommu_domain_alloc,
> @@ -2295,6 +2303,10 @@ const struct iommu_ops amd_iommu_ops = {
>   		.iotlb_sync	= amd_iommu_iotlb_sync,
>   		.free		= amd_iommu_domain_free,
>   		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= amd_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index a0b7281f1989..3c37762e01ec 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -763,6 +763,14 @@ static void apple_dart_get_resv_regions(struct device *dev,
>   	iommu_dma_get_resv_regions(dev, head);
>   }
>   
> +static int apple_dart_blocking_domain_set_dev(struct iommu_domain *domain,
> +					      struct device *dev)
> +{
> +	apple_dart_detach_dev(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops apple_dart_iommu_ops = {
>   	.domain_alloc = apple_dart_domain_alloc,
>   	.probe_device = apple_dart_probe_device,
> @@ -784,6 +792,10 @@ static const struct iommu_ops apple_dart_iommu_ops = {
>   		.iotlb_sync_map	= apple_dart_iotlb_sync_map,
>   		.iova_to_phys	= apple_dart_iova_to_phys,
>   		.free		= apple_dart_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= apple_dart_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7e7d9e0b7aee..4b0ec5bef63b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2867,6 +2867,9 @@ static struct iommu_ops arm_smmu_ops = {
>   		.iova_to_phys		= arm_smmu_iova_to_phys,
>   		.enable_nesting		= arm_smmu_enable_nesting,
>   		.free			= arm_smmu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev		= arm_smmu_attach_dev,
>   	}
>   };
>   
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index c91d12b7e283..0723f7c97763 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1606,6 +1606,9 @@ static struct iommu_ops arm_smmu_ops = {
>   		.enable_nesting		= arm_smmu_enable_nesting,
>   		.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
>   		.free			= arm_smmu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev		= arm_smmu_attach_dev,
>   	}
>   };
>   
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index cf624bd305e0..dee9b5a3a324 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -587,6 +587,14 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   	return iommu_fwspec_add_ids(dev, &asid, 1);
>   }
>   
> +static int qcom_blocking_domain_set_dev(struct iommu_domain *domain,
> +					struct device *dev)
> +{
> +	qcom_iommu_detach_dev(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops qcom_iommu_ops = {
>   	.capable	= qcom_iommu_capable,
>   	.domain_alloc	= qcom_iommu_domain_alloc,
> @@ -604,6 +612,10 @@ static const struct iommu_ops qcom_iommu_ops = {
>   		.iotlb_sync	= qcom_iommu_iotlb_sync,
>   		.iova_to_phys	= qcom_iommu_iova_to_phys,
>   		.free		= qcom_iommu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= qcom_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 797348f3440e..bbecb9a2a554 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1307,6 +1307,14 @@ static int exynos_iommu_of_xlate(struct device *dev,
>   	return 0;
>   }
>   
> +static int exynos_blocking_domain_set_dev(struct iommu_domain *domain,
> +					  struct device *dev)
> +{
> +	exynos_iommu_detach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops exynos_iommu_ops = {
>   	.domain_alloc = exynos_iommu_domain_alloc,
>   	.device_group = generic_device_group,
> @@ -1321,6 +1329,10 @@ static const struct iommu_ops exynos_iommu_ops = {
>   		.unmap		= exynos_iommu_unmap,
>   		.iova_to_phys	= exynos_iommu_iova_to_phys,
>   		.free		= exynos_iommu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= exynos_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index 7512c8e007e9..92fc320f8c83 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -451,6 +451,14 @@ static void fsl_pamu_release_device(struct device *dev)
>   {
>   }
>   
> +static int fsl_pamu_blocking_domain_set_dev(struct iommu_domain *domain,
> +					    struct device *dev)
> +{
> +	fsl_pamu_detach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops fsl_pamu_ops = {
>   	.capable	= fsl_pamu_capable,
>   	.domain_alloc	= fsl_pamu_domain_alloc,
> @@ -462,6 +470,10 @@ static const struct iommu_ops fsl_pamu_ops = {
>   		.detach_dev	= fsl_pamu_detach_device,
>   		.iova_to_phys	= fsl_pamu_iova_to_phys,
>   		.free		= fsl_pamu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= fsl_pamu_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6abc1fbbd461..2060e8a540b3 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4904,6 +4904,14 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
>   	}
>   }
>   
> +static int intel_blocking_domain_set_dev(struct iommu_domain *domain,
> +					 struct device *dev)
> +{
> +	intel_iommu_detach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   const struct iommu_ops intel_iommu_ops = {
>   	.capable		= intel_iommu_capable,
>   	.domain_alloc		= intel_iommu_domain_alloc,
> @@ -4935,6 +4943,10 @@ const struct iommu_ops intel_iommu_ops = {
>   		.iova_to_phys		= intel_iommu_iova_to_phys,
>   		.free			= intel_iommu_domain_free,
>   		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev		= intel_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index b361a4cff688..72982d1277c2 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -867,6 +867,14 @@ static struct iommu_group *ipmmu_find_group(struct device *dev)
>   	return group;
>   }
>   
> +static int ipmmu_blocking_domain_set_dev(struct iommu_domain *domain,
> +					 struct device *dev)
> +{
> +	ipmmu_detach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops ipmmu_ops = {
>   	.domain_alloc = ipmmu_domain_alloc,
>   	.probe_device = ipmmu_probe_device,
> @@ -885,6 +893,10 @@ static const struct iommu_ops ipmmu_ops = {
>   		.iotlb_sync	= ipmmu_iotlb_sync,
>   		.iova_to_phys	= ipmmu_iova_to_phys,
>   		.free		= ipmmu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= ipmmu_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 569d36840b67..b0471d03db60 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -674,6 +674,14 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>   	return 0;
>   }
>   
> +static int msm_blocking_domain_set_dev(struct iommu_domain *domain,
> +				       struct device *dev)
> +{
> +	msm_iommu_detach_dev(domain, dev);
> +
> +	return 0;
> +}
> +
>   static struct iommu_ops msm_iommu_ops = {
>   	.domain_alloc = msm_iommu_domain_alloc,
>   	.probe_device = msm_iommu_probe_device,
> @@ -696,6 +704,10 @@ static struct iommu_ops msm_iommu_ops = {
>   		.iotlb_sync_map	= msm_iommu_sync_map,
>   		.iova_to_phys	= msm_iommu_iova_to_phys,
>   		.free		= msm_iommu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= msm_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 33ec401d40eb..cc8d80290498 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -926,6 +926,14 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
>   	}
>   }
>   
> +static int mtk_blocking_domain_set_dev(struct iommu_domain *domain,
> +				       struct device *dev)
> +{
> +	mtk_iommu_detach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops mtk_iommu_ops = {
>   	.domain_alloc	= mtk_iommu_domain_alloc,
>   	.probe_device	= mtk_iommu_probe_device,
> @@ -946,6 +954,10 @@ static const struct iommu_ops mtk_iommu_ops = {
>   		.iotlb_sync_map	= mtk_iommu_sync_map,
>   		.iova_to_phys	= mtk_iommu_iova_to_phys,
>   		.free		= mtk_iommu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= mtk_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index fb55802fb841..894d2526ba4c 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -584,6 +584,14 @@ static int mtk_iommu_v1_hw_init(const struct mtk_iommu_v1_data *data)
>   	return 0;
>   }
>   
> +static int mtk_blocking_domain_set_dev(struct iommu_domain *domain,
> +				       struct device *dev)
> +{
> +	mtk_iommu_v1_detach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops mtk_iommu_v1_ops = {
>   	.domain_alloc	= mtk_iommu_v1_domain_alloc,
>   	.probe_device	= mtk_iommu_v1_probe_device,
> @@ -600,6 +608,10 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
>   		.unmap		= mtk_iommu_v1_unmap,
>   		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
>   		.free		= mtk_iommu_v1_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= mtk_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 6720dcb437a0..7e6ba6f1218d 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1732,6 +1732,14 @@ static struct iommu_group *omap_iommu_device_group(struct device *dev)
>   	return group;
>   }
>   
> +static int omap_blocking_domain_set_dev(struct iommu_domain *domain,
> +					struct device *dev)
> +{
> +	omap_iommu_detach_dev(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops omap_iommu_ops = {
>   	.domain_alloc	= omap_iommu_domain_alloc,
>   	.probe_device	= omap_iommu_probe_device,
> @@ -1745,6 +1753,10 @@ static const struct iommu_ops omap_iommu_ops = {
>   		.unmap		= omap_iommu_unmap,
>   		.iova_to_phys	= omap_iommu_iova_to_phys,
>   		.free		= omap_iommu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= omap_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 0a4196c34179..29c803759a0b 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1185,6 +1185,14 @@ static int rk_iommu_of_xlate(struct device *dev,
>   	return 0;
>   }
>   
> +static int rk_blocking_domain_set_dev(struct iommu_domain *domain,
> +				      struct device *dev)
> +{
> +	rk_iommu_detach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops rk_iommu_ops = {
>   	.domain_alloc = rk_iommu_domain_alloc,
>   	.probe_device = rk_iommu_probe_device,
> @@ -1199,6 +1207,10 @@ static const struct iommu_ops rk_iommu_ops = {
>   		.unmap		= rk_iommu_unmap,
>   		.iova_to_phys	= rk_iommu_iova_to_phys,
>   		.free		= rk_iommu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev	= rk_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index cde01c72f573..a03bff562a44 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -360,6 +360,14 @@ void zpci_destroy_iommu(struct zpci_dev *zdev)
>   	iommu_device_sysfs_remove(&zdev->iommu_dev);
>   }
>   
> +static int s390_blocking_domain_set_dev(struct iommu_domain *domain,
> +					struct device *dev)
> +{
> +	s390_iommu_detach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops s390_iommu_ops = {
>   	.capable = s390_iommu_capable,
>   	.domain_alloc = s390_domain_alloc,
> @@ -374,6 +382,10 @@ static const struct iommu_ops s390_iommu_ops = {
>   		.unmap		= s390_iommu_unmap,
>   		.iova_to_phys	= s390_iommu_iova_to_phys,
>   		.free		= s390_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev		= s390_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index 45b58845f5f8..ab62063cee5b 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -413,6 +413,13 @@ static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   	return 0;
>   }
>   
> +static int sprd_blocking_domain_set_dev(struct iommu_domain *domain,
> +					struct device *dev)
> +{
> +	sprd_iommu_detach_device(domain, dev);
> +
> +	return 0;
> +}
>   
>   static const struct iommu_ops sprd_iommu_ops = {
>   	.domain_alloc	= sprd_iommu_domain_alloc,
> @@ -431,6 +438,10 @@ static const struct iommu_ops sprd_iommu_ops = {
>   		.iotlb_sync	= sprd_iommu_sync,
>   		.iova_to_phys	= sprd_iommu_iova_to_phys,
>   		.free		= sprd_iommu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev		= sprd_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index 041b30463552..a51a55ae0634 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -758,6 +758,14 @@ static int sun50i_iommu_of_xlate(struct device *dev,
>   	return iommu_fwspec_add_ids(dev, &id, 1);
>   }
>   
> +static int sun50i_blocking_domain_set_dev(struct iommu_domain *domain,
> +					  struct device *dev)
> +{
> +	sun50i_iommu_detach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops sun50i_iommu_ops = {
>   	.pgsize_bitmap	= SZ_4K,
>   	.device_group	= sun50i_iommu_device_group,
> @@ -774,6 +782,10 @@ static const struct iommu_ops sun50i_iommu_ops = {
>   		.map		= sun50i_iommu_map,
>   		.unmap		= sun50i_iommu_unmap,
>   		.free		= sun50i_iommu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev		= sun50i_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index f083a9fba4d0..7e2aef7ae72e 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -270,6 +270,14 @@ static void gart_iommu_sync(struct iommu_domain *domain,
>   	gart_iommu_sync_map(domain, gather->start, length);
>   }
>   
> +static int gart_blocking_domain_set_dev(struct iommu_domain *domain,
> +					struct device *dev)
> +{
> +	gart_iommu_detach_dev(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops gart_iommu_ops = {
>   	.domain_alloc	= gart_iommu_domain_alloc,
>   	.probe_device	= gart_iommu_probe_device,
> @@ -286,6 +294,10 @@ static const struct iommu_ops gart_iommu_ops = {
>   		.iotlb_sync_map	= gart_iommu_sync_map,
>   		.iotlb_sync	= gart_iommu_sync,
>   		.free		= gart_iommu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev		= gart_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 36e9c2864e3f..fe2c463db230 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -963,6 +963,14 @@ static int tegra_smmu_of_xlate(struct device *dev,
>   	return iommu_fwspec_add_ids(dev, &id, 1);
>   }
>   
> +static int tegra_smmu_blocking_domain_set_dev(struct iommu_domain *domain,
> +					      struct device *dev)
> +{
> +	tegra_smmu_detach_dev(domain, dev);
> +
> +	return 0;
> +}
> +
>   static const struct iommu_ops tegra_smmu_ops = {
>   	.domain_alloc = tegra_smmu_domain_alloc,
>   	.probe_device = tegra_smmu_probe_device,
> @@ -977,6 +985,10 @@ static const struct iommu_ops tegra_smmu_ops = {
>   		.unmap		= tegra_smmu_unmap,
>   		.iova_to_phys	= tegra_smmu_iova_to_phys,
>   		.free		= tegra_smmu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev		= tegra_smmu_blocking_domain_set_dev,
> +		.blocking_domain_detach = true,
>   	}
>   };
>   
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index ce2bd01806d8..5054ebaf9654 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1023,6 +1023,9 @@ static struct iommu_ops viommu_ops = {
>   		.iova_to_phys		= viommu_iova_to_phys,
>   		.iotlb_sync		= viommu_iotlb_sync,
>   		.free			= viommu_domain_free,
> +	},
> +	.blocking_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev		= viommu_attach_dev,
>   	}
>   };
>   
