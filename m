Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6C513745
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348563AbiD1Ovg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiD1Ove (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:51:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925A6B0D34
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:48:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bi24-20020a05600c3d9800b00393ff664705so3158290wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gXcgGcE+u9ZZ2nNfuMlJwxFYwU47p+7KJbt/dJsKH2k=;
        b=WoXhKzVCsdlC5PUxXMPtuzO6MyUVEwuQIKmv3o0Fq3J+OB+PULeTKG9nBT0FsElq8U
         tzXFIdRn+O/epPEH8lcBtwL/GVklJeA53TSIHwe5JEFkgzt3FWfHSVPcu/d1ivseCBdC
         187xbW/KsmiQt3bJ42HIUc3A8B7TJhiyNI6coYwMWaWUJ8ScACpCjTavoLRReuX7Av/P
         upuWvJBiL/cRfcv/AopQLXAlHMuHbLE1xNpqMx7hel3CxHW+vEgAmL0GJT+zRJ4osRJY
         PoIwgAmvExzt9jf52TXT8RVwRA+GB5mapKcp8fPjbI5HrsmWMCOPbCSmK6+ErdA5r+gc
         Uncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gXcgGcE+u9ZZ2nNfuMlJwxFYwU47p+7KJbt/dJsKH2k=;
        b=qWeyJC9wsZO34mis1K9XuBFApSMWpEAoJ6+ZBX29xE0SYFJElBgsLktobTVBCr9+fL
         Uqmk9XA6SIKpEG5xtsPBshY/MHnXgK5sOpecby41f+F9qV/IImRbJ5UbxEAgx7zG27oh
         darkJYkB7ZJkzy0/f3r7E7Gi2O3yUPwXubS6ynGz0ylJ/2fL0uPCUKVoSnW87vZAv9Pl
         51srP29aCw/kG1zZahuW2RrKkmmYA1HTxJuzZUrErE7hmyhBWLCsmFlHVEL1abiqt9Tn
         ttkqZbf4tyR3ymp6haggOtQcTJv8FIcfp24Q+rwpcSFGfS88sSWWFZzd2TVc4OZCnzjj
         lP7A==
X-Gm-Message-State: AOAM531Inge5phwAiniELm2es/NX7b2U/KcajsWxhV5vuuG9rCR31oA/
        CprXeN6/I31dOy+DiIguS5FTVw==
X-Google-Smtp-Source: ABdhPJxNWPXTUPDxwHrxcCJa+urJQ5WdUNKsvAt695sYRfcOhAF31zd2EOk9mXufDDPQiUwFCynz5Q==
X-Received: by 2002:a7b:cb48:0:b0:394:b64:8b88 with SMTP id v8-20020a7bcb48000000b003940b648b88mr5166056wmj.183.1651157298179;
        Thu, 28 Apr 2022 07:48:18 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id p3-20020adfaa03000000b00207a1db96cfsm60631wrd.71.2022.04.28.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:48:17 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:47:52 +0100
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
Subject: Re: [PATCH v4 10/12] iommu: Prepare IOMMU domain for IOPF
Message-ID: <YmqpGFzMZn7ZMzsQ@myrica>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-11-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421052121.3464100-11-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Thu, Apr 21, 2022 at 01:21:19PM +0800, Lu Baolu wrote:
> +/*
> + * Get the attached domain for asynchronous usage, for example the I/O
> + * page fault handling framework. The caller get a reference counter
> + * of the domain automatically on a successful return and should put
> + * it with iommu_domain_put() after usage.
> + */
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid_async(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +
> +	if (!pasid_valid(pasid))
> +		return NULL;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;
> +
> +	mutex_lock(&group->mutex);

There is a possible deadlock between unbind() and the fault handler:

 unbind()                            iopf_handle_group()
  mutex_lock(&group->mutex)
  iommu_detach_device_pasid()
   iopf_queue_flush_dev()             iommu_get_domain_for_dev_pasid_async()
    ... waits for IOPF work            mutex_lock(&group->mutex)

I was wrong in my previous review: we do have a guarantee that the SVA
domain does not go away during IOPF handling, because unbind() waits for
pending faults with iopf_queue_flush_dev() before freeing the domain (or
for Arm stall, knows that there are no pending faults). So we can just get
rid of domain->async_users and the group->mutex in IOPF, I think?

Thanks,
Jean

> +	domain = xa_load(&group->pasid_array, pasid);
> +	if (domain)
> +		refcount_inc(&domain->async_users);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	return domain;
> +}
> -- 
> 2.25.1
> 
