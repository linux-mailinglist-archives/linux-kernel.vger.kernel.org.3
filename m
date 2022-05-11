Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74AC522DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbiEKHzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiEKHzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:55:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9D6590A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:55:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i27so2329098ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T+vt0ZVMpAStN8vtcO/W3H1y3FeI0bv62I6/uRsSEhc=;
        b=eMxDIQet9ahQhMdVrUMgQwkO/EsYnZNzv1UJDALKOX2rvcys5c3H8xAiH3t2OPUist
         k4fwOMS1K82o9wu0H71ne7MF1fN1pM8DeSYZAxfh+twlzgYbpgy1xUJMayjXiqfC2/AQ
         3qFqRtxN0o4QogT5xFHTW/YwqwbQM3OfJJPILkI8wW348+Km7BHGDfak3ERAZWL6PiGx
         n7hd/6dDe++fqJ5eJjKPQ1LZgvzSD7vNfySoL3i0CLpaEoj7NHQlQ7A16n6LisC2o6d+
         X+oBfXKYs7I63iQPWJGL0m3E6JsVafv2SPPCIxC8hi1NLit0KYzv6DItaL30wSX9bkYY
         Q9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+vt0ZVMpAStN8vtcO/W3H1y3FeI0bv62I6/uRsSEhc=;
        b=4Of4dYd0t9aDCRGSjIpT5xXVFABhR6mL9Mqpary5Q9DPzW57Hf/KCmaWFTlQwDtU1Z
         eO5hfqEjJ+AEoVkzcKZCqR5B10pVijyB149YHIgRw8FwAzER8nCIHWBaEldxs+FKMHUj
         QFvyP1AQ5d8ibZI8mCwElDbV7/OSyl4cdVath7YoUq3IQ2nFnUJRNPTFU/U46TGiUKiR
         UpWs0i9aYKVbR/x3WHe3t066C01Q3gWyOdnQoClnYxbDFag9+th2/RPYnN0RTi21dRe4
         dJjdzBsCQ0Vehk/9/QEF0zU87jDixFQNzq6FUucp3/E06Z2l7wBeWvMJwQWh/iAgv1dV
         tbUw==
X-Gm-Message-State: AOAM532K9Dcbvxv52NjNWqIJrvazeirk8KlXHBTrqMPfE/V8ULB+QpDS
        eJT5MNNxpjDkzN6xB05Q60tJyA==
X-Google-Smtp-Source: ABdhPJxl7ACcQ41IVyVSbAYdpPFjcDLn4U4wPVNWNsH0JdN+uXZ/yJbWCQZIxSwd0i10FQWlfGheLA==
X-Received: by 2002:a17:907:971b:b0:6f4:3b8c:ae04 with SMTP id jg27-20020a170907971b00b006f43b8cae04mr23406515ejc.548.1652255704732;
        Wed, 11 May 2022 00:55:04 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id t17-20020a17090605d100b006f3ef214e50sm638962ejt.182.2022.05.11.00.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 00:55:04 -0700 (PDT)
Date:   Wed, 11 May 2022 08:54:39 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <Yntrv+nq2t/IeVo2@myrica>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
 <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
 <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 04:09:14AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, May 11, 2022 10:32 AM
> > 
> > On 2022/5/10 22:02, Jason Gunthorpe wrote:
> > > On Tue, May 10, 2022 at 02:17:29PM +0800, Lu Baolu wrote:
> > >
> > >> This adds a pair of common domain ops for this purpose and adds
> > helpers
> > >> to attach/detach a domain to/from a {device, PASID}.
> > >
> > > I wonder if this should not have a detach op - after discussing with
> > > Robin we can see that detach_dev is not used in updated
> > > drivers. Instead attach_dev acts as 'set_domain'
> > >
> > > So, it would be more symmetrical if attaching a blocking_domain to the
> > > PASID was the way to 'detach'.
> > >
> > > This could be made straightforward by following the sketch I showed to
> > > have a static, global blocing_domain and providing a pointer to it in
> > > struct iommu_ops
> > >
> > > Then 'detach pasid' is:
> > >
> > > iommu_ops->blocking_domain->ops->attach_dev_pasid(domain, dev,
> > pasid);
> > >
> > > And we move away from the notion of 'detach' and in the direction that
> > > everything continuously has a domain set. PASID would logically
> > > default to blocking_domain, though we wouldn't track this anywhere.
> > 
> > I am not sure whether we still need to keep the blocking domain concept
> > when we are entering the new PASID world. Please allow me to wait and
> > listen to more opinions.
> > 
> 
> I'm with Jason on this direction. In concept after a PASID is detached it's
> essentially blocked. Implementation-wise it doesn't prevent the iommu
> driver from marking the PASID entry as non-present as doing in this
> series instead of actually pointing to the empty page table of the block
> domain. But api-wise it does make the entire semantics more consistent.

This is all internal to IOMMU so I don't think we should be concerned
about API consistency. I prefer a straighforward detach() operation
because that way IOMMU drivers don't have to keep track of which domain is
attached to which PASID. That code can be factored into the IOMMU core.

In addition to clearing contexts, detach() also needs to invalidate TLBs,
and for that the SMMU driver needs to know the old ASID (!= PASID) that
was used by the context descriptor. We can certainly work around a missing
detach() to implement this, but it will be convoluted.

Thanks,
Jean
