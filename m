Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97574D9F05
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbiCOPrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiCOPrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:47:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF3A13CD6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647359163; x=1678895163;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9l3zMa1N2Xp5sxnI3YEfCtneKtd5sTYwcoovBFmuHj4=;
  b=G3MJkA+PAusSvx/IgXHx+fsINNxwIkW04249ernYmvtxXmLH0nHLJIjm
   w15AHQ4bKv5SKtxKtLWfaN+igqwTxKJk+Egt/SPBf+gIDmz5ph90bd5bn
   8ReY2XiHZFivLWvQuhJlVaVOI7w5IJ+M4jPouyCjB/CE6I56gKyDlS48W
   o0e7zU6lwYUlMKPK7dRS3T9S+7st4dgVH0vAIMS0EzWpM4CBhVDLZXlY+
   PP9Y60tHc3/C8XOYdIimhg7zhUpzQsVDdD4FMC1bogpcNMd8FOkZ8lO6x
   Lande3L5GtWx4u2nowcU6DQ0DndVKkgM/tnECqjcU0nm0yqBPWLBPBQ62
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256291448"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256291448"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 08:45:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="515921223"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 08:45:56 -0700
Date:   Tue, 15 Mar 2022 08:49:12 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 0/8] Enable PASID for DMA API users
Message-ID: <20220315084912.52f98cf8@jacob-builder>
In-Reply-To: <BN9PR11MB5276F78A62AD159A73868C268C109@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276F78A62AD159A73868C268C109@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Tue, 15 Mar 2022 08:16:59 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > 
> > Some modern accelerators such as Intel's Data Streaming Accelerator
> > (DSA) require PASID in DMA requests to be operational. Specifically,
> > the work submissions with ENQCMD on shared work queues require PASIDs.
> > The use cases
> > include both user DMA with shared virtual addressing (SVA) and in-kernel
> > DMA similar to legacy DMA w/o PASID. Here we address the latter.
> > 
> > DMA mapping API is the de facto standard for in-kernel DMA. However, it
> > operates on a per device or Requester ID(RID) basis which is not
> > PASID-aware. To leverage DMA API for devices relies on PASIDs, this
> > patchset introduces the following APIs
> > 
> > 1. A driver facing API that enables DMA API PASID usage:
> > iommu_enable_pasid_dma(struct device *dev, ioasid_t &pasid);  
> 
> Should this be called dma_enable_pasid() since it's about DMA API? Doing
> so also avoids the driver to include iommu.h.
> 
PASID is still tied to IOMMU, drivers who wants to use this must explicitly
put dependency on IOMMU. So I prefer not to give that illusion.

> Thanks
> Kevin


Thanks,

Jacob
