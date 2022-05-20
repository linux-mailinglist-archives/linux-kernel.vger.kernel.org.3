Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2752EAC9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348517AbiETL3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245486AbiETL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:29:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E6A69CFC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:29:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso6620873wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=klBbWS7sRcqocWfFmSjhAhD7LMdlQzVYNuKtndTufmQ=;
        b=KKmuhkyrGGxRgDW7vHnZYTwIp2VhohRT0q11wWXZHehcaBkzga7Nl6OyoZwFE81jNa
         E9Ikujmsjw702GL2sYWRWvNdS0gW+WYirXnO6mmz3STYVfv2zHOBednXNpqUSuKW6cKA
         51NdWv4hKPYvE1IM/9zcFmKQuMGsu5y1zFFTfEwzPO7KyfSlMX4mkajOd3Wwdtl+yc8F
         yDktKpxUiPugXBP0G0BPS53KgEdg13IjPijWpp7Jg0COAgNsIIwfSyb09VWlu0xvIdFr
         rFEgPXIYAFkK4DPtc+Vn5rnmTNOp52plyyrF4gBvdd6Mfj/pNfrZ9V/JVSfWShAMx8Tg
         0mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=klBbWS7sRcqocWfFmSjhAhD7LMdlQzVYNuKtndTufmQ=;
        b=s/cxKPkHfRaXm66mUjjR5FWcpRpSm5V0xxz0GsR13boYRBShb7+g14pjxenPwEjFAD
         /owqGb6URRLj7MzM5T0gwxSmnXA0TOaeYeGn8GnwCoW6SIAmLyVLLa2olqJGkAhXwhVR
         7s2E6UtYJPOUYTUOGquLyoGQMlCHM7gLBp5LCiEKEcBsHgWq9jiiQM5VUAd0j1XoYwh0
         iTJCuXnU4Z/VqVOIYtXil8TWCDmpZHEytGlOUV4Rj+qtm4sgoeHlDChXjhmfE+HyV8Sd
         2YDiQtSsuQ8xz+S29OSR55yFhGXdFeKE9eUQS7E16RDvfxo89ab7dFAAZXPzKrx611g2
         yQ2g==
X-Gm-Message-State: AOAM530F4/ILgOMwTgRGcjV+pmevE+6mHYM3WyBAcRKfC9DqoBZaQURp
        V3pQ5sn2svRsyNvj+rCIeF1CKQ==
X-Google-Smtp-Source: ABdhPJy+XnCF6eA4cXPfHENATkzczZ6M9sLEqwQ1G4NPiVcFc5KVYiwAtyE/Mwnl1pZea/pFW1cCwg==
X-Received: by 2002:a05:600c:382:b0:394:6172:59dc with SMTP id w2-20020a05600c038200b00394617259dcmr8356943wmd.120.1653046149008;
        Fri, 20 May 2022 04:29:09 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r17-20020adfa151000000b0020d00174eabsm2181977wrr.94.2022.05.20.04.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:29:08 -0700 (PDT)
Date:   Fri, 20 May 2022 12:28:44 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
Subject: Re: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yod6/ceSMIeela/x@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com>
 <YoZyvVxJLiYOjBHw@myrica>
 <3636ac5e-4f52-26a9-db73-5858a27f61b8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3636ac5e-4f52-26a9-db73-5858a27f61b8@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:38:12PM +0800, Baolu Lu wrote:
> On 2022/5/20 00:39, Jean-Philippe Brucker wrote:
> > > +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> > > +{
> > > +	struct iommu_sva_domain *sva_domain;
> > > +	struct iommu_domain *domain;
> > > +	ioasid_t max_pasid = 0;
> > > +	int ret = -EINVAL;
> > > +
> > > +	/* Allocate mm->pasid if necessary. */
> > > +	if (!dev->iommu->iommu_dev->pasids)
> > > +		return ERR_PTR(-EOPNOTSUPP);
> > > +
> > > +	if (dev_is_pci(dev)) {
> > > +		max_pasid = pci_max_pasids(to_pci_dev(dev));
> > > +		if (max_pasid < 0)
> > > +			return ERR_PTR(max_pasid);
> > > +	} else {
> > > +		ret = device_property_read_u32(dev, "pasid-num-bits",
> > > +					       &max_pasid);
> > > +		if (ret)
> > > +			return ERR_PTR(ret);
> > > +		max_pasid = (1UL << max_pasid);
> > > +	}
> > The IOMMU driver needs this PASID width information earlier, when creating
> > the PASID table (in .probe_device(), .attach_dev()). Since we're moving it
> > to the IOMMU core to avoid code duplication, it should be done earlier and
> > stored in dev->iommu
> 
> Yes, really. How about below changes?
> 
> From f1382579e8a15ca49acdf758d38fd36451ea174d Mon Sep 17 00:00:00 2001
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Date: Mon, 28 Feb 2022 15:01:35 +0800
> Subject: [PATCH 1/1] iommu: Add pasids field in struct dev_iommu
> 
> Use this field to save the number of PASIDs that a device is able to
> consume. It is a generic attribute of a device and lifting it into the
> per-device dev_iommu struct could help to avoid the boilerplate code
> in various IOMMU drivers.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 15 +++++++++++++++
>  include/linux/iommu.h |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e49c5a5b8cc1..6b731171d42f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -20,6 +20,7 @@
>  #include <linux/idr.h>
>  #include <linux/err.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ats.h>
>  #include <linux/bitops.h>
>  #include <linux/property.h>
>  #include <linux/fsl/mc.h>
> @@ -194,6 +195,8 @@ EXPORT_SYMBOL_GPL(iommu_device_unregister);
>  static struct dev_iommu *dev_iommu_get(struct device *dev)
>  {
>  	struct dev_iommu *param = dev->iommu;
> +	u32 max_pasids = 0;
> +	int ret;
> 
>  	if (param)
>  		return param;
> @@ -202,6 +205,18 @@ static struct dev_iommu *dev_iommu_get(struct device
> *dev)
>  	if (!param)
>  		return NULL;
> 
> +	if (dev_is_pci(dev)) {
> +		ret = pci_max_pasids(to_pci_dev(dev));
> +		if (ret > 0)
> +			max_pasids = ret;
> +	} else {
> +		ret = device_property_read_u32(dev, "pasid-num-bits",
> +					       &max_pasids);
> +		if (!ret)
> +			max_pasids = (1UL << max_pasids);
> +	}
> +	param->pasids = max_pasids;
> +

we could also do a min() with the IOMMU PASID size here

>  	mutex_init(&param->lock);
>  	dev->iommu = param;
>  	return param;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 45f274b2640d..d4296136ba75 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -371,6 +371,7 @@ struct iommu_fault_param {
>   * @fwspec:	 IOMMU fwspec data
>   * @iommu_dev:	 IOMMU device this device is linked to
>   * @priv:	 IOMMU Driver private data
> + * @pasids:	 number of supported PASIDs

'max_pasids' to stay consistent?

Thanks,
Jean

>   *
>   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>   *	struct iommu_group	*iommu_group;
> @@ -382,6 +383,7 @@ struct dev_iommu {
>  	struct iommu_fwspec		*fwspec;
>  	struct iommu_device		*iommu_dev;
>  	void				*priv;
> +	u32				pasids;
>  };
> 
>  int iommu_device_register(struct iommu_device *iommu,
> -- 
> 2.25.1
> 
> Best regards,
> baolu
