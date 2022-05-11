Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5829522DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbiEKIBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbiEKIBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:01:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE5F39159
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:01:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d6so1547839ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M4aeMJFFFKV21hSaluDeCVxCbgPrszET6TE6+DuKZy0=;
        b=pHErwaiX6ufGPbr+xXjlPt1Yc3gEtnWaSm8ytmYX710fnKTCNneuXmpcCLCEGqTExG
         m7Hs6QUMpa2kf0CWT3yM0LTy2PyrJCG8N6qYBW7tQGijpTswQh71X3v6WO+XdWu0TuDe
         09GmCLxd2aNLZu2aOIBXK4Nofo/Fe5dGXd/AkIQ8ZA4sJ3cl31BKatHndrY1YfzV4Cm+
         Oz1Uu7sXr1ERXN6NrCvL7Vi7oHCV30QoCD8jBzDjIsjjJvfrXNxSGICoehoho0L32G9m
         oLc7zw+8k22xvyS5HFxdVTtPJYJTjRW5Ps+XqcmHsp6UZroC3Oe4leN4M4Nu5ri+XNXa
         INXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M4aeMJFFFKV21hSaluDeCVxCbgPrszET6TE6+DuKZy0=;
        b=R7OOgJLBtZ+ZdI+XL0ftNcHbkw/LQcGThd037rgi22LEZS+EBAtSC8AGt5ObnTGWSF
         QNhfs/b3gbjCqBj5CAb39w9P+R3ZAohvpdoYIMrvfwH7NgZbO4uhM41pwWapWBaxA3eb
         CkKt4hbLALmhf9cXR1fesjS+2kzYFC0OBJXYLJWFUpCz8DlpujjGq8B51QBxDsyZ//6F
         0uELoMFStHHmOTGB+t7Oxk0t1kO9xdaDB54loUN1MIbTlLNM4Cqe/2z+H5EsDVjW5UR1
         lb0w57yqYrHUH32hJlj/q4iGEm+tzVrpvTwqVfs/ZrmPXyl5MyiXuCgmbv3jIHT447nl
         Nyhw==
X-Gm-Message-State: AOAM532e0BK4cFW5vL2CTeOI+HeMUQgp7BTljkmMyoZLsRQccC+7pfQb
        OrCwSM1iRzRzYct5OLPfUTuuyJ5DrYWpHv4L
X-Google-Smtp-Source: ABdhPJxcUxYehRflQhrWm3q6OieQJAMKNGsZSTynkrhHLPcj2CC9w6aa7qaw0vo2XGXSDh8yqvw2IA==
X-Received: by 2002:a05:6402:e9f:b0:41c:df21:b113 with SMTP id h31-20020a0564020e9f00b0041cdf21b113mr27914392eda.217.1652256076253;
        Wed, 11 May 2022 01:01:16 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id h12-20020a05640250cc00b0042617ba63d5sm783085edb.95.2022.05.11.01.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:01:15 -0700 (PDT)
Date:   Wed, 11 May 2022 09:00:50 +0100
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/12] iommu: Add pasid_bits field in struct dev_iommu
Message-ID: <YnttMpX2geTKRzVV@myrica>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-3-baolu.lu@linux.intel.com>
 <20220510143405.GE49344@nvidia.com>
 <3fe05f18-6726-276a-8c42-79e0b134dfdc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe05f18-6726-276a-8c42-79e0b134dfdc@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:25:48AM +0800, Baolu Lu wrote:
> On 2022/5/10 22:34, Jason Gunthorpe wrote:
> > On Tue, May 10, 2022 at 02:17:28PM +0800, Lu Baolu wrote:
> > 
> > >   int iommu_device_register(struct iommu_device *iommu,
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 627a3ed5ee8f..afc63fce6107 100644
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2681,6 +2681,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> > >   	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> > >   		master->stall_enabled = true;
> > > +	dev->iommu->pasid_bits = master->ssid_bits;
> > >   	return &smmu->iommu;
> > >   err_free_master:
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > index 2990f80c5e08..99643f897f26 100644
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -4624,8 +4624,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
> > >   			if (pasid_supported(iommu)) {
> > >   				int features = pci_pasid_features(pdev);
> > > -				if (features >= 0)
> > > +				if (features >= 0) {
> > >   					info->pasid_supported = features | 1;
> > > +					dev->iommu->pasid_bits =
> > > +						fls(pci_max_pasids(pdev)) - 1;
> > > +				}
> > 
> > It is not very nice that both the iommu drivers have to duplicate the
> > code to read the pasid capability out of the PCI device.
> > 
> > IMHO it would make more sense for the iommu layer to report the
> > capability of its own HW block only, and for the core code to figure
> > out the master's limitation using a bus-specific approach.
> 
> Fair enough. The iommu hardware capability could be reported in
> 
> /**
>  * struct iommu_device - IOMMU core representation of one IOMMU hardware
>  *                       instance
>  * @list: Used by the iommu-core to keep a list of registered iommus
>  * @ops: iommu-ops for talking to this iommu
>  * @dev: struct device for sysfs handling
>  */
> struct iommu_device {
>         struct list_head list;
>         const struct iommu_ops *ops;
>         struct fwnode_handle *fwnode;
>         struct device *dev;
> };
> 
> I haven't checked ARM code yet, but it works for x86 as far as I can
> see.

Arm also supports non-PCI PASID by reading a firmware property:

        device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);

should be the only difference

Thanks,
Jean

> 
> > 
> > It is also unfortunate that the enable/disable pasid is inside the
> > iommu driver as well - ideally the PCI driver itself would do this
> > when it knows it wants to use PASIDs.
> > 
> > The ordering interaction with ATS makes this look quite annoying
> > though. :(
> > 
> > I'm also not convinced individual IOMMU drivers should be forcing ATS
> > on, there are performance and functional implications here. Using ATS
> > or not is possibly best left as an administrator policy controlled by
> > the core code. Again we seem to have some mess.
> 
> Agreed with you. This has already been in my task list. I will start to
> solve it after the iommufd tasks.
> 
> Best regards,
> baolu
