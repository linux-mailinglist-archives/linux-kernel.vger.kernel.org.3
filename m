Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE0652464E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350636AbiELHBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350640AbiELHBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:01:31 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20AB36B44
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:01:28 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so2066216otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=efsh0uFhOmfXuxYUIJCJiPXg0Qyy8hA9I7vTZKgvJew=;
        b=EnqUiSp3NRowBkDyrnH+e0w+NAXs45+xS/LbhwDZ3jHVK0hFAtydeud0D9yIZn5vHW
         h8HWixSpXklXLa+vK0fx3AbDZVfRsCuQ3uWTqZM5UIxf9StJFijoGeJ7Y9NtGuxszsXu
         kpIsxH5bfEK7ZaVLJvMeAWAa17bcyo8M/DirkCc2ghz86spx04iga5Sx0rcogQiDYQQK
         EOfOw72OCdN2Dw7gxALr9tRfBFCVfE8WB3Y9udtLVW8WmkPb7+c5AtLreavAU14sR3SC
         TZ3bR7XjoP4DP+D+JPhHYQsGcJN53ZIv1t4dk2aqF7ASmkfTgz5ABsz8Jo02qvjVqbb+
         lCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=efsh0uFhOmfXuxYUIJCJiPXg0Qyy8hA9I7vTZKgvJew=;
        b=KswGn7EL6Rf9vfc/BR610gcNytNAPB9qGy5i4rFawwnaUty7+NTEn2FZ93YDVMtRag
         g4fMhAlYy6chGYSz2vCOG9Kmc2RoBJycm8Jx5sv9/Icku4PU2+d+Rxn5yiWJBR0Y3WlJ
         a5Pv29rYZR9/rZjqA+teaqzhdOp3UaLELXxNFqo8kLS8kqKxlAgLcJRZTxp3TVpp3NbU
         g/hGiVhpiAPy1AxRcvhUPKW6MrIVuJLRMzFKgpCNk14eeZD770NZdGN5vZQEIrJJadEa
         lVaqwYFGQNh1CPyvHoSDV+r6tuSYMMtzXFKltjPAyT6shqazzX61i1u8BThPZAlZbDz+
         Lw0w==
X-Gm-Message-State: AOAM531K/y8AHVXoMOpMmtGtrDs1xQoUX1zIrJkDxpzWYeD/bnXlH2oR
        qkHRVAXvWXntBM1ZrIaD0TsEnDPRtDGdB5nH
X-Google-Smtp-Source: ABdhPJwALcVzEMLfNXiKQ1qqw3+WNq3w140FzQj5Vmo+drcuLq4wMlXBD8pHJTOXCPPEJ5+K2h3aKA==
X-Received: by 2002:a9d:7618:0:b0:605:a132:7d57 with SMTP id k24-20020a9d7618000000b00605a1327d57mr11353454otl.262.1652338887629;
        Thu, 12 May 2022 00:01:27 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id 102-20020a9d016f000000b0060603221272sm1633368otu.66.2022.05.12.00.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:01:26 -0700 (PDT)
Date:   Thu, 12 May 2022 08:00:59 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
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
Message-ID: <Ynywqxo4P+aEeS6c@myrica>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
 <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
 <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yntrv+nq2t/IeVo2@myrica>
 <20220511120240.GY49344@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511120240.GY49344@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 09:02:40AM -0300, Jason Gunthorpe wrote:
> On Wed, May 11, 2022 at 08:54:39AM +0100, Jean-Philippe Brucker wrote:
> > > > > Then 'detach pasid' is:
> > > > >
> > > > > iommu_ops->blocking_domain->ops->attach_dev_pasid(domain, dev,
> > > > pasid);
> > > > >
> > > > > And we move away from the notion of 'detach' and in the direction that
> > > > > everything continuously has a domain set. PASID would logically
> > > > > default to blocking_domain, though we wouldn't track this anywhere.
> > > > 
> > > > I am not sure whether we still need to keep the blocking domain concept
> > > > when we are entering the new PASID world. Please allow me to wait and
> > > > listen to more opinions.
> > > > 
> > > 
> > > I'm with Jason on this direction. In concept after a PASID is detached it's
> > > essentially blocked. Implementation-wise it doesn't prevent the iommu
> > > driver from marking the PASID entry as non-present as doing in this
> > > series instead of actually pointing to the empty page table of the block
> > > domain. But api-wise it does make the entire semantics more consistent.
> > 
> > This is all internal to IOMMU so I don't think we should be concerned
> > about API consistency. I prefer a straighforward detach() operation
> > because that way IOMMU drivers don't have to keep track of which domain is
> > attached to which PASID. That code can be factored into the IOMMU core.
> 
> Why would a driver need to keep additional tracking?
> 
> > In addition to clearing contexts, detach() also needs to invalidate TLBs,
> > and for that the SMMU driver needs to know the old ASID (!= PASID) that
> > was used by the context descriptor. We can certainly work around a missing
> > detach() to implement this, but it will be convoluted.
> 
> It is not "missing" it is just renamed to blocking_domain->ops->set_dev_pasid()
> 
> The implementation of that function would be identical to
> detach_dev_pasid.

  attach(dev, pasid, sva_domain)
  detach(dev, pasid, sva_domain)

versus

  set_dev_pasid(dev, pasid, sva_domain)
  set_dev_pasid(dev, pasid, blocking)

we loose the information of the domain previously attached, and the SMMU
driver has to retrieve it to find the ASID corresponding to the mm. 

Thanks,
Jean
