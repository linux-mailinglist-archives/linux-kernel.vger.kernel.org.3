Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FCA4E252A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346747AbiCULYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244534AbiCULYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:24:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989008BE07
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:22:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u16so19205582wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EjTFhP6pLNh8SP7hia+QSRERJDUH8MZHoqCvzO3yUHk=;
        b=SiNU4Iz/MmLcp3Eg9/x5F8VpGL82FE7rcP2CgSbbjSbZVCkNb9npsiF2VHJWukpJ00
         rX9Gk4ui/c/pu5QZvgSi6a4DHQRqXMGRO0Seg4Lx7aB2q5kafVb9xYMIJXXI5TkAjcnu
         tWYE09gta3z5KQFnQodJorT66odExJ6+jCHTg2j2FxZxB0kL1jWZGRdb47YijoAs/5ww
         FY7YtXQJ+IPm1fYgCnEy78OpBcOik3zN+7I4lVo5ZPJM1hIxCShrHM+yFNcM6XXcuMG7
         +SK41gum0BHXXK2FCoL/8mSBYlCz5WL+WE7sNjjqAg6Bmt2DRIsl7OrO1IcmjPGmPY8c
         BS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EjTFhP6pLNh8SP7hia+QSRERJDUH8MZHoqCvzO3yUHk=;
        b=GXyPdf+tNp47OTzP0JdeGpzU9RMCgpkFLbmvayMTnDKY5RdkzWTNZjdn23HkeEemd5
         RFB0Fr9HRu+J0Un16BIPNhn0w6nTKL089o2qEHVS/HbNKse8T1wagaB2JHve9qjR24LE
         flQU760wT9OGUShoylVNWeNqpF9HH50COwg8Jb1vFj96a15uJ9e0q14YZDCk2alLgCi4
         SLxAWFbPZs8+5gXGqweSLbNScZPpizZ7v4QQCBgXQ/XUt94mam35Mu7POopplDoU7N1v
         VYcWwPPTC3rPmftS4EKmRFie45y7oYnr9rt5QCUWlZkutXSaYe3+l7MsDVHd4taL51zZ
         Jbrg==
X-Gm-Message-State: AOAM533Ztyw85NuCX7bxifcIl2xZacloqOgE6R/RjEVE1TYL3miM4M40
        rjm79RF0sqBKxMQTwx34OQpMrQ==
X-Google-Smtp-Source: ABdhPJxxiqoqWBhnbWtqpG8g8SqCncPhXvaJfxdi+9fEwzbBfwr4SieS2NKJ2O3yzbYubf5rUoZPOg==
X-Received: by 2002:a05:6000:2c8:b0:204:f83:ba35 with SMTP id o8-20020a05600002c800b002040f83ba35mr4508092wry.539.1647861754143;
        Mon, 21 Mar 2022 04:22:34 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600002ad00b00203d64c5289sm14817902wry.112.2022.03.21.04.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 04:22:33 -0700 (PDT)
Date:   Mon, 21 Mar 2022 11:22:09 +0000
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
Subject: Re: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Message-ID: <Yjhf4dlthDkHBICr@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-2-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Sun, Mar 20, 2022 at 02:40:20PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..8e262210b5ad 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2812,6 +2812,7 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
>  		master->iopf_enabled = true;
>  		return 0;
>  	case IOMMU_DEV_FEAT_SVA:
> +		dev->iommu->pasid_bits = master->ssid_bits;

This would be better in arm_smmu_probe_device()

Thanks,
Jean

>  		return arm_smmu_master_enable_sva(master);
>  	default:
>  		return -EINVAL;
