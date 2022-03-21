Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD014E254B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346784AbiCULhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiCULha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:37:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ECF93998
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:36:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so8193531wmp.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZVAnw0RzZRCIiVPUEetPfW2YkVPetMxKA7nBTzr+HIw=;
        b=uZLSsmc74Q5/B8CA/4kxhdheuai2ZCTIeNLvbrI84RUpUGdkpG9Cz3bh6BwiqiFrGc
         abtmrsOH9fwm5vPy639n2ou6PTw8ZFqIW64RTcPm98lu0L/zed0WmpJviwfCca8+Unk3
         C9EXmtDr+t01W6DRvP5hL0eZu2UW2nk0/yCPPCd9jKrYkNzq0TLEPZAmrEqNCkIiCi7p
         3lESvWrDt63NMoEKakueosHmptoJJP4QrnSRayS0dFTlfvXq07Q4CeNS9zfCoxNwB3pM
         jl3pheGxMCrUUNTbhcscnRc8DiwTdFAHPu87eokMvgsxJEcKz2Qvo/3U21Wle6Ylwsig
         WYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZVAnw0RzZRCIiVPUEetPfW2YkVPetMxKA7nBTzr+HIw=;
        b=lbZA5cM0YNEjwrez9pff1kiue9C2W+7cO6ejDJoZv/2IXKqL4w6GdZyEW4RKh84RAT
         Y1aWlviMq98V28DtygR8zZmBwVprJaEm0jIpuHbt6rSN62h7p5/dUEo6JCABRmFhGfwh
         PpERSmyp85Wh5zpHQUhoEQFIcg2FNFOOPmqoysPAiRSvO5CY8JevbMrz3aTVJbjgtP4u
         Y7PVWN+wlGqIsSE48ci9LJmMyumyjS3hW2hgk83lvH/YwOiRf/RHvGEP5i0taby3rKL4
         JpO3rGe4GUtUj8cFRCpRkv7ALxIdlPSvo1Cnu6jFEt5nNCc4GaM+UY7serGHCdVvXXEp
         9KGw==
X-Gm-Message-State: AOAM532balkQUPYptd/aj2MEtEDxkFfAeUbYcMXhILImtRD7H5IoQRWP
        8nfeqwXGN8vz0+OQulCt1LWMRA==
X-Google-Smtp-Source: ABdhPJxo/11Zv/yAVHfSXaiR7imZ5KA75vdgTIy9kESpEDv3hbJqukWEJGk7IKO8XOMkMo70WDkXJQ==
X-Received: by 2002:a05:600c:2e4c:b0:38c:7088:afd0 with SMTP id q12-20020a05600c2e4c00b0038c7088afd0mr21171537wmf.70.1647862563546;
        Mon, 21 Mar 2022 04:36:03 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm13530707wmc.25.2022.03.21.04.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 04:36:03 -0700 (PDT)
Date:   Mon, 21 Mar 2022 11:35:38 +0000
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
Subject: Re: [PATCH RFC 08/11] iommu: Handle IO page faults directly
Message-ID: <YjhjCsrcTNDsFRwm@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-9-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-9-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 02:40:27PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c0966fc9b686..4f90b71c6f6e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -27,6 +27,8 @@
>  #include <linux/cc_platform.h>
>  #include <trace/events/iommu.h>
>  
> +#include "iommu-sva-lib.h"
> +
>  static struct kset *iommu_group_kset;
>  static DEFINE_IDA(iommu_group_ida);
>  
> @@ -1177,10 +1179,9 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  	if (!param || !evt)
>  		return -EINVAL;
>  
> -	/* we only report device fault if there is a handler registered */
>  	mutex_lock(&param->lock);
>  	fparam = param->fault_param;
> -	if (!fparam || !fparam->handler) {
> +	if (!fparam) {
>  		ret = -EINVAL;
>  		goto done_unlock;
>  	}
> @@ -1198,7 +1199,11 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  		mutex_unlock(&fparam->lock);
>  	}
>  
> -	ret = fparam->handler(&evt->fault, fparam->data);
> +	if (fparam->handler)
> +		ret = fparam->handler(&evt->fault, fparam->data);
> +	else
> +		ret = iommu_queue_iopf(&evt->fault, fparam->data);
> +

I like the change, but we'll need to consolidate this, because now if the
driver registers a fault handler it disables IOPF. We could instead
prevent registration if an IOPF param is present. We could also just merge
fparam->handler but eventually I'd like to make IOPF fall back to the
fault handler registered by device driver, in case of invalid page faults.
I have a couple patches for this but am still missing some bits.

Thanks,
Jean

>  	if (ret && evt_pending) {
>  		mutex_lock(&fparam->lock);
>  		list_del(&evt_pending->list);
> -- 
> 2.25.1
> 
