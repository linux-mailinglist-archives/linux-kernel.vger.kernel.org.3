Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DFB4E2548
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbiCULfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiCULfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:35:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C8693980
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:34:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d7so20249088wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=42+pcjD9nmVdVhSwWnyaINhA05iNt1mKva6XHXFOVbY=;
        b=qe6EWJsblOtDgZAnHq0dmr30IAgU307PubyeD6gbwstJOL3yIQu6FogrFJDQqe9hGV
         2Ejc4ONV49X+482LdIv2jYbrWTlz6Uc95WfrOilsre4k7aww01MdknuM8ucxDYcHv0i9
         hovvGmfg4pFSKEZfaBV6QXVpn4IYiRSAkNWqA3i8vXA7BnLpioauvjt3piMFCRSn+IE/
         E5nbRG33eDa7NzjGHWLSfEAdTBacGamOTUCB1rZazwpxav1qSoMKtdKpHfrZCekcILkX
         Zs2oPwhvHr31cE5k5lwFGavUzdqSwtJAkKi7yds+IgmaUXb6UE7U3mcgCE/qFzhOTxoj
         QULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=42+pcjD9nmVdVhSwWnyaINhA05iNt1mKva6XHXFOVbY=;
        b=TXbqnt9L16oAbISF1vS6AfO2BG1GYydoH7LlHBRLqR2GWrYJBisrCplKd1f7gxalfZ
         1sGt0U2H3VkheBUWsLMdW3f+iHM1/eOm3Ga9h+L9t1nnpPcs2Hy276goDZHfcBrxKfAw
         KZtHzSJry2tlkR6y8nF6/10xGrbLF6jr/WJETdLei26TtAoSN/picsjS5DXJC09HU2oY
         C0GUxfSIt++lqGQg/Wxzdl4NkwTMfo7gElKwCXQ6XHUDT12k44fX/MyXWVDP2pQ9UTzZ
         4c2mJTZLc9VXcMcevv1iD+7f5hgok5B0hd3kEebzTpRm7pcMQ5HIOWC19iQxoB4ZL4Tz
         uRpw==
X-Gm-Message-State: AOAM532PxxrIRzD2MHRECEh0Xi3C6dSoqi2sAduW90Spew0QS99v64OW
        R+qv3HzoV8rXKN+wXIDjO4TFvA==
X-Google-Smtp-Source: ABdhPJy1/Z5mdy2AbOVHN0m4FGyURD/Rk49c17OO5Dn464AdAgBr8yGbYlfNUZ8vkzX5261k0FlnrA==
X-Received: by 2002:a5d:6707:0:b0:203:e60e:49fa with SMTP id o7-20020a5d6707000000b00203e60e49famr18260078wru.603.1647862459370;
        Mon, 21 Mar 2022 04:34:19 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b00389f440512esm18318765wmq.32.2022.03.21.04.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 04:34:19 -0700 (PDT)
Date:   Mon, 21 Mar 2022 11:33:54 +0000
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
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Message-ID: <YjhiohZAbN1ornmB@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-7-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 02:40:25PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..47cf98e661ff 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -3,6 +3,8 @@
>   * Helpers for IOMMU drivers implementing SVA
>   */
>  #include <linux/mutex.h>
> +#include <linux/iommu.h>
> +#include <linux/slab.h>
>  #include <linux/sched/mm.h>
>  
>  #include "iommu-sva-lib.h"
> @@ -69,3 +71,101 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>  	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
> +static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev)
> +{
> +	struct bus_type *bus = dev->bus;
> +	struct iommu_domain *domain;
> +
> +	if (!bus || !bus->iommu_ops)
> +		return NULL;
> +
> +	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_SVA);
> +	if (domain)
> +		domain->type = IOMMU_DOMAIN_SVA;
> +
> +	return domain;
> +}
> +
> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to it
> + * @drvdata: opaque data pointer to pass to bind callback
> + *
> + * Create a bond between device and address space, allowing the device to access
> + * the mm using the returned PASID. If a bond already exists between @device and
> + * @mm, it is returned and an additional reference is taken.

This is not true anymore, we return a different structure for each call.

> Caller must call
> + * iommu_sva_unbind_device() to release each reference.
> + *
> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> + * initialize the required SVA features.
> + *
> + * On error, returns an ERR_PTR value.
> + */
> +struct iommu_sva *
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> +{
> +	int ret = -EINVAL;
> +	struct iommu_sva *handle;
> +	struct iommu_domain *domain;
> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
> +	if (ret)
> +		goto out;
> +
> +	domain = iommu_sva_domain_alloc(dev);
> +	if (!domain) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	domain->sva_cookie = mm;
> +
> +	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
> +	if (ret)
> +		goto out_free_domain;
> +
> +	handle->dev = dev;
> +	handle->domain = domain;
> +	handle->pasid = mm->pasid;
> +
> +	return handle;
> +
> +out_free_domain:
> +	iommu_domain_free(domain);
> +out:
> +	kfree(handle);
> +
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
> +
> +/**
> + * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
> + * @handle: the handle returned by iommu_sva_bind_device()
> + *
> + * Put reference to a bond between device and address space.

Same here. But I'd prefer keeping the old behavior so device drivers don't
have to keep track of {dev, mm} pairs themselves.

Thanks,
Jean

> The device should
> + * not be issuing any more transaction for this PASID. All outstanding page
> + * requests for this PASID must have been flushed to the IOMMU.
> + */
> +void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +	struct device *dev = handle->dev;
> +	struct iommu_domain *domain = handle->domain;
> +	struct mm_struct *mm = domain->sva_cookie;
> +
> +	iommu_detach_device_pasid(domain, dev, mm->pasid);
> +	iommu_domain_free(domain);
> +	kfree(handle);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> +
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	return handle->pasid;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
