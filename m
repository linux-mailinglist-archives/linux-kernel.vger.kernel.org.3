Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A7757FA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiGYHjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGYHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:39:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4247212091
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:39:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n185so6238879wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e1aZ+o8kUOGYYPE2I8Uql3rIMOoNeVnZ6eovO9V2SYI=;
        b=e0kcc9cMVIDcngDRSTaZnB9OpBUCxX3qmlG7Rf8UF8KxVdSSsYTKRRoayVBXIw3Sng
         wu03r67IdDvHjuKRBxBG/MxS7zaI0Fo1WODf40DlybOy4RWF2zFeZBXFfeKyNY0k3tY0
         9acd2YlEjpByWP6lqxFmT8VFC6fWMD8ow89/760tUyLKH0o9qeiprvAj+2sNGlgZhJZI
         P/HxJLpuRxogFWVWPIjIQAFfo0PO7Gp9AJcrqgFGB0IZOyTnjDFWfH0tafCnnyRMGVx7
         qdcnwKIosMyB5F+UvM7GWAw6I/korbMgwAcezOoI6zLqC6A5RcxfoKxbs4WKBmEsKJwO
         BYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e1aZ+o8kUOGYYPE2I8Uql3rIMOoNeVnZ6eovO9V2SYI=;
        b=Bccz2s2pLLYS6ZovlsWDK6q6rB4Wx9BQEcRMY8jmXGnHEc10/crHz94KKUJkixAEmP
         YNyVuP7JXlQJ8sF07LDswiXbUyUcFhmq3/lp4HAfdyNPIuiKdYCkr1FyEc3GNkGyJ3F9
         US0ABZ2WC162vuJ0xtMo1OvDztyfdVuZGs6vgvWhVimgb5ZEEyZFt+Joo7CfblXzPivW
         PpAHIeAwwYLcoXSHzhStjWpZiiW6xzvqrqoqauLcgBw/83aSsXr5ICKujfR4wG3WVP1O
         JFrRl/Ty+RzMjySBJLhHikBClkS7E08XscCM7xvfo/R6LXYc0913x7/X9SqR5QZszgSS
         mkvg==
X-Gm-Message-State: AJIora/G13Va8EukTjAVpHFRLjKi/lypk3+ewi/mSMySbVbpXxDnfAwn
        kAxWMZpUGrIdCMXqSb+TSLhz6A==
X-Google-Smtp-Source: AGRyM1v6drvIQaPtLI2eyqwiXdbwRxbi3X7EtVh03o9xVmLSg1+t1aTiJIzZGSIA3tAvrAovwl/Odw==
X-Received: by 2002:a05:600c:17c7:b0:3a3:f1:148c with SMTP id y7-20020a05600c17c700b003a300f1148cmr20833043wmo.32.1658734790751;
        Mon, 25 Jul 2022 00:39:50 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id f9-20020adfb609000000b0021e519eba9bsm11085090wre.42.2022.07.25.00.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 00:39:50 -0700 (PDT)
Date:   Mon, 25 Jul 2022 08:39:23 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yt5IqyZw/Sa6Ck5t@myrica>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 09:48:15PM +0800, Baolu Lu wrote:
> /*
>  * iommu_detach_device_pasid() - Detach the domain from pasid of device
>  * @domain: the iommu domain.
>  * @dev: the attached device.
>  * @pasid: the pasid of the device.
>  *
>  * The @domain must have been attached to @pasid of the @dev with
>  * iommu_detach_device_pasid().
>  */
> void iommu_detach_device_pasid(struct iommu_domain *domain, struct device
> *dev,
> 			       ioasid_t pasid)
> {
> 	struct iommu_group *group = iommu_group_get(dev);
> 	struct group_pasid *param;
> 
> 	mutex_lock(&group->mutex);
> 	domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);

Please also pass the old domain to this detach() function, so that the
IOMMU driver doesn't have to keep track of them internally.

In addition to clearing contexts, detach() also needs to invalidate TLBs,
and for that the SMMU driver needs to know the old ASID (!= PASID) that
was used by the context descriptor.

Thanks,
Jean


