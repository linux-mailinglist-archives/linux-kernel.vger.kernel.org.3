Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D84D9A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347342AbiCOL2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiCOL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:28:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E280F4F9F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:27:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r6so28040382wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xsy+hdBDmUEEW9oGx4D4eHqInkltCSE2p0AuseWmMgg=;
        b=NN5nqsh5i2xYRMZXD4nVNF44ylsoZUN1zOSa8Vzd4saL/27OcGoHbKQSfiEqQbnx7+
         Eft7dWXkDfTrx7LuODBh7+p3+qJQDwsy5n5Jp8eoWvlZWGulbQqK27lYw4cgD2fxDdGK
         jlgVl5VVl0GV/w8Mw7cV7mLIU8CG4phu5pwPOm0orA8CQFVFWTDgZC8MoGspUSQ46AKx
         lkGZ/fpYCyerOUjUbrFm5lyOmIoRNE2Aqa5mU92mx3ZjtED1k8eFhJaIldK6mkV34T30
         afZlNazQE9o5zyTKePlKUNCHT73/Fm3P+amBqUwUPPUjeSkCHyCfbDz2fHFIqQEgW+/p
         NYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xsy+hdBDmUEEW9oGx4D4eHqInkltCSE2p0AuseWmMgg=;
        b=IMhspA3iT8B/caNKgB0J6xeJ9OoHXJ3PzdNe16qP+nTMqCz3Y0L/bSn3QN28AH+BjJ
         sQ8pPMiKthTyux2jVMrfvd/OasFfZKJ0CDwhBXCoynZkvhJjT1PMuWt+qkh9FK5PEDVN
         LUrvFInK53O+xLOYhx9f+zRN/KjotswU5eiwu+aRv8th7O7M1WOj/VpohBoBZAy/z/qr
         mLXJCt7En8Y1ZpqMZ+8tDfkuOYMn2QMtTIQGOJbEzoOb4pAWeGTFUF3rNfnpHXr5olvh
         +BIDMz//KeVCa7AkcCWKCCuts2nL2943REE/s7ROTYm3ugixb3bqiWuKcJwkQr4WaIhu
         PSug==
X-Gm-Message-State: AOAM533BNGPkM5p8hR5Lnxau7vxJAWn2pEijnrSJR1FHLQobVV9+ZL6/
        MzIJQUPyDcHDdElc3ABrxFipBA==
X-Google-Smtp-Source: ABdhPJxjD95iUAyVMeq2yyB+8Hz8TYrdwXdaaEoOsEgDVOLullCXgK01LaViQhsTRhCAEfA2ljtKjw==
X-Received: by 2002:adf:cd8f:0:b0:1ed:af02:2295 with SMTP id q15-20020adfcd8f000000b001edaf022295mr19238184wrj.226.1647343645473;
        Tue, 15 Mar 2022 04:27:25 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm1348294wri.105.2022.03.15.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 04:27:25 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:26:59 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <YjB4AyrgsnbUrlLe@myrica>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 10:07:06PM -0700, Jacob Pan wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> An IOMMU domain represents an address space which can be attached by
> devices that perform DMA within a domain. However, for platforms with
> PASID capability the domain attachment needs be handled at device+PASID
> level. There can be multiple PASIDs within a device and multiple devices
> attached to a given domain.
> This patch introduces a new IOMMU op which support device, PASID, and
> IOMMU domain attachment. The immediate use case is for PASID capable
> devices to perform DMA under DMA APIs.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/linux/iommu.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 369f05c2a4e2..fde5b933dbe3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
>   * @aux_get_pasid: get the pasid given an aux-domain
>   * @sva_bind: Bind process address space to device
>   * @sva_unbind: Unbind process address space from device
> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> + * @detach_dev_pasid: detach an iommu domain from a pasid of device

Isn't that operation "assign a PASID to a domain" instead?  In patch 5,
the domain is already attached to the device, so set_domain_pasid() might
be clearer and to the point. If the IOMMU driver did the allocation we
could also avoid patch 1.

If I understand correctly this series is not about a generic PASID API
that allows drivers to manage multiple DMA address spaces, because there
still doesn't seem to be any interest in that. It's about the specific
IDXD use-case, so let's focus on that. We can introduce a specialized call
such as (iommu|dma)_set_device_pasid(), which will be easy to consolidate
later into a more generic "dma_enable_pasid()" API if that ever seems
useful.

Thanks,
Jean

>   * @sva_get_pasid: Get PASID associated to a SVA handle
>   * @page_response: handle page request response
>   * @cache_invalidate: invalidate translation caches
> @@ -296,6 +298,10 @@ struct iommu_ops {
>  	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
>  				      void *drvdata);
>  	void (*sva_unbind)(struct iommu_sva *handle);
> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t id);
> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t id);
>  	u32 (*sva_get_pasid)(struct iommu_sva *handle);
>  
>  	int (*page_response)(struct device *dev,
> -- 
> 2.25.1
> 
