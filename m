Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0534B518BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbiECSG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiECSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:06:23 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47233EA8E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:02:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j9so14374718qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uyl9FgqCpk0Nf843k4+zgAZBrShtUTws+zDSvi2LfUM=;
        b=HASzNM8N5KvGdhci2AiFzKOaJQwN9mxfIDe/lkZJ5ShoUtwlUdYMfOFqvjDXyIJbF4
         yaCwBO/1X43osNrP+A0r7dVcuxLftUPcVym8xAbVVku9NRSgvrtT3UelMCZeHJLzuNfL
         /5clZPtUWO33c4TklN3NmqsrqPCjOhgAcTCkIEOzaMYJ+wD9Tt0duo4/8BLzMAiOuNdH
         Th8ElVEgO5wkiBNqADw6YU6YJxaC9PMmi42uZc7tbY4rLb7pZRcZVhFjQU2SahZBEiCr
         HiDdRYiv2HnjeJQfP+uXqwRIbMnNmiSSP232+3Utj39UgC6S/OvJYFIF+2Ox/UbleRkj
         /E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uyl9FgqCpk0Nf843k4+zgAZBrShtUTws+zDSvi2LfUM=;
        b=RASqUQEDlP9lNqPJ9DRYXcL96hyOfLFQ3zdZAalNxL8+RwmVxM62jauJU2nSAFhm0A
         wgpSpuw4BMLnklKtzGHbC5bRjTUlFKpBExegr8L+uCZLzcvd+0i3uHxATKIud/jnySLt
         k9wZHdUBdXBHuei5spNskSYMmQL/evNdZpovzHnGhv1u0swSBDk8H3sowUVXDCEkmdqL
         wv6ybQzfVkB5oLqYWVoRqB55f98pHjxpZmBUMdcMckOwU0dP54bkk2xvyOCNFEmmU5DF
         rlQroyQOUmPzTL+k+VtLmE7XJMySr9fo1HryHjc6iobBoHkRUUNMIg5jGf2RKupPo67v
         Op0Q==
X-Gm-Message-State: AOAM5309Qx1SJ15esAW5k2IVXf5tp7IzkSOgBnBzww2VrcTbt8KwSkMz
        dJqX64aQ1Z5WwBRqxsfSc5l3gA==
X-Google-Smtp-Source: ABdhPJy6ETxhDfU1H18vwQw8SjcmvvfRmmnBdOiKVkVcmW4w4SWSAwiUMPGahiMaZ41Ml+rD4xkWVw==
X-Received: by 2002:a05:620a:414a:b0:69f:d123:6011 with SMTP id k10-20020a05620a414a00b0069fd1236011mr9378899qko.89.1651600969861;
        Tue, 03 May 2022 11:02:49 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86bd8000000b002f39b99f67esm6180531qtt.24.2022.05.03.11.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:02:49 -0700 (PDT)
Date:   Tue, 3 May 2022 19:02:22 +0100
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
Subject: Re: [PATCH v5 02/12] iommu: Add pasid_bits field in struct dev_iommu
Message-ID: <YnFuLsvWcjjKBWNy@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-3-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:48:32AM +0800, Lu Baolu wrote:
> Use this field to save the pasid/ssid bits that a device is able to
> support with its IOMMU hardware. It is a generic attribute of a device
> and lifting it into the per-device dev_iommu struct makes it possible
> to allocate a PASID for device without calls into the IOMMU drivers.
> Any iommu driver which suports PASID related features should set this
> field before features are enabled on the devices.
> 
> For initialization of this field in the VT-d driver, the
> info->pasid_supported is only set for PCI devices. So the status is
> that non-PCI SVA hasn't been supported yet. Setting this field only for
> PCI devices has no functional change.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  include/linux/iommu.h                       | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
>  drivers/iommu/intel/iommu.c                 | 5 ++++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e1afe169549..b8ffaf2cb1d0 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -373,6 +373,7 @@ struct dev_iommu {
>  	struct iommu_fwspec		*fwspec;
>  	struct iommu_device		*iommu_dev;
>  	void				*priv;
> +	unsigned int			pasid_bits;
>  };
>  
>  int iommu_device_register(struct iommu_device *iommu,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..afc63fce6107 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2681,6 +2681,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>  		master->stall_enabled = true;
>  
> +	dev->iommu->pasid_bits = master->ssid_bits;
> +
>  	return &smmu->iommu;
>  
>  err_free_master:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cf43e8f9091b..170eb777d57b 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4611,8 +4611,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>  			if (pasid_supported(iommu)) {
>  				int features = pci_pasid_features(pdev);
>  
> -				if (features >= 0)
> +				if (features >= 0) {
>  					info->pasid_supported = features | 1;
> +					dev->iommu->pasid_bits =
> +						fls(pci_max_pasids(pdev)) - 1;
> +				}
>  			}
>  
>  			if (info->ats_supported && ecap_prs(iommu->ecap) &&
> -- 
> 2.25.1
> 
