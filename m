Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283DC4EB2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiC2RiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbiC2RiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:38:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3547F1EA2AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648575390; x=1680111390;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fBn9JtbtkTc3R/g8GyiflShARTXJTrabmJczllhTBug=;
  b=VoX5m1/x1QEdDK/l3cRQe7fHFO2wa073BkR5K6NmF9B/cHz/ek3MAa2j
   rdKa2Rr1A/9bpm4ZRSbL5UnuzVcwyhcR5tcRmACedMJYDKsEavMVhyUpx
   d1QU5hv1yKq0Zw/icTgi87a+eYA9xW44ScEG+1I+wd2lUh7U8snrwq2GF
   4y98JYQfv4Y8oYikmDvn6oaoyfwHCGgbjaDTTgNqQjVpJ352z8xGvLBnb
   u4F8JXh+xwIMa/QRqn0or7tPMi/6oUUZj/53g/4cENTZUtDUumrGlZG9H
   YAUCx5AnuoTt1hyM2cdcFzB8naSDqHaH7/CQNLWUNLtL8sHxwnKt9DWnA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241475111"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="241475111"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 10:36:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="502977142"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 10:36:29 -0700
Date:   Tue, 29 Mar 2022 10:39:52 -0700
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
Subject: Re: [PATCH v2 6/8] dmaengine: idxd: Use DMA API for in-kernel DMA
 with PASID
Message-ID: <20220329103952.7a330c09@jacob-builder>
In-Reply-To: <BN9PR11MB527625B7AD0FBC1BCEB5D2768C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-7-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB527625B7AD0FBC1BCEB5D2768C139@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Fri, 18 Mar 2022 06:10:40 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > 
> > The current in-kernel supervisor PASID support is based on the SVM/SVA
> > machinery in SVA lib. The binding between a kernel PASID and kernel
> > mapping has many flaws. See discussions in the link below.
> > 
> > This patch enables in-kernel DMA by switching from SVA lib to the
> > standard DMA mapping APIs. Since both DMA requests with and without
> > PASIDs are mapped identically, there is no change to how DMA APIs are
> > used after the kernel PASID is enabled.
> > 
> > Link: https://lore.kernel.org/linux-
> > iommu/20210511194726.GP1002214@nvidia.com/
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/dma/idxd/idxd.h  |  1 -
> >  drivers/dma/idxd/init.c  | 34 +++++++++-------------------------
> >  drivers/dma/idxd/sysfs.c |  7 -------
> >  3 files changed, 9 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> > index da72eb15f610..a09ab4a6e1c1 100644
> > --- a/drivers/dma/idxd/idxd.h
> > +++ b/drivers/dma/idxd/idxd.h
> > @@ -276,7 +276,6 @@ struct idxd_device {
> >  	struct idxd_wq **wqs;
> >  	struct idxd_engine **engines;
> > 
> > -	struct iommu_sva *sva;
> >  	unsigned int pasid;
> > 
> >  	int num_groups;
> > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > index 08a5f4310188..5d1f8dd4abf6 100644
> > --- a/drivers/dma/idxd/init.c
> > +++ b/drivers/dma/idxd/init.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/intel-svm.h>
> >  #include <linux/iommu.h>
> > +#include <linux/dma-iommu.h>
> >  #include <uapi/linux/idxd.h>
> >  #include <linux/dmaengine.h>
> >  #include "../dmaengine.h"
> > @@ -466,36 +467,22 @@ static struct idxd_device *idxd_alloc(struct
> > pci_dev *pdev, struct idxd_driver_d
> > 
> >  static int idxd_enable_system_pasid(struct idxd_device *idxd)  
> 
> idxd_enable_pasid_dma() since system pasid is a confusing term now?
> Or just remove the idxd specific wrappers and have the caller to call
> iommu_enable_pasid_dma() directly given the simple logic here.
> 
agreed, will do.

> >  {
> > -	int flags;
> > -	unsigned int pasid;
> > -	struct iommu_sva *sva;
> > +	u32 pasid;
> > +	int ret;
> > 
> > -	flags = SVM_FLAG_SUPERVISOR_MODE;
> > -
> > -	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
> > -	if (IS_ERR(sva)) {
> > -		dev_warn(&idxd->pdev->dev,
> > -			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
> > -		return PTR_ERR(sva);
> > -	}
> > -
> > -	pasid = iommu_sva_get_pasid(sva);
> > -	if (pasid == IOMMU_PASID_INVALID) {
> > -		iommu_sva_unbind_device(sva);
> > -		return -ENODEV;
> > +	ret = iommu_enable_pasid_dma(&idxd->pdev->dev, &pasid);
> > +	if (ret) {
> > +		dev_err(&idxd->pdev->dev, "No DMA PASID %d\n", ret);
> > +		return ret;
> >  	}
> > -
> > -	idxd->sva = sva;
> >  	idxd->pasid = pasid;
> > -	dev_dbg(&idxd->pdev->dev, "system pasid: %u\n", pasid);
> > +
> >  	return 0;
> >  }
> > 
> >  static void idxd_disable_system_pasid(struct idxd_device *idxd)
> >  {
> > -
> > -	iommu_sva_unbind_device(idxd->sva);
> > -	idxd->sva = NULL;
> > +	iommu_disable_pasid_dma(&idxd->pdev->dev, idxd->pasid);
> >  }
> > 
> >  static int idxd_probe(struct idxd_device *idxd)
> > @@ -524,10 +511,7 @@ static int idxd_probe(struct idxd_device *idxd)
> >  		} else {
> >  			dev_warn(dev, "Unable to turn on SVA
> > feature.\n"); }
> > -	} else if (!sva) {
> > -		dev_warn(dev, "User forced SVA off via module
> > param.\n");  
> 
> why removing above 2 lines? they are related to a module param thus
> not affected by the logic in this series.
> 
This should be in a separate patch. I consulted with Dave, sva module param
is not needed anymore.
Thanks for pointing it out.

> >  	}
> > -
> >  	idxd_read_caps(idxd);
> >  	idxd_read_table_offsets(idxd);
> > 
> > diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> > index 7e19ab92b61a..fde6656695ba 100644
> > --- a/drivers/dma/idxd/sysfs.c
> > +++ b/drivers/dma/idxd/sysfs.c
> > @@ -839,13 +839,6 @@ static ssize_t wq_name_store(struct device *dev,
> >  	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
> >  		return -EINVAL;
> > 
> > -	/*
> > -	 * This is temporarily placed here until we have SVM support
> > for
> > -	 * dmaengine.
> > -	 */
> > -	if (wq->type == IDXD_WQT_KERNEL && device_pasid_enabled(wq-  
> > >idxd))  
> > -		return -EOPNOTSUPP;
> > -
> >  	memset(wq->name, 0, WQ_NAME_SIZE + 1);
> >  	strncpy(wq->name, buf, WQ_NAME_SIZE);
> >  	strreplace(wq->name, '\n', '\0');
> > --
> > 2.25.1  
> 


Thanks,

Jacob
