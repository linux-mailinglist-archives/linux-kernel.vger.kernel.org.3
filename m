Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B184EB2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbiC2Rkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240261AbiC2Rkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:40:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8992F2E0A1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648575537; x=1680111537;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BdPlvWarzhHsLaFQ8fFSDfcrHEVxYxEW9ZW8dC/aUMo=;
  b=iZur4f7kxSiyU+evCHG7FAcEVzMUII/yqfsjMNU8T1C8dFvxz2BNRzr+
   kIK6ZqnisgIgoXgSXKldSORFeum92jFLJ3+WDvfbAu/SbXJ/cuMJ5CV8a
   +Rfm9WQSk9alOagD7/bau6/t+/pA2ku8uzu0cEFfIxgdLHZrXGVLRQM3U
   +AFy05wLzbS7BCRBDTIT2RzvO1h1wYFSffWImVXyYrdBdWsGcywYP7EA3
   IlzBnoZATuDjh+RUPtvHL7KoamcJkbxqWj5TkrSz+gMYXlRQdH7JrbxXS
   gS76dEsOVU9ylgJJhtHQAUk5wu+CB8bNfpTeedp7jL0ey4PQZyh1ScKeS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241475529"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="241475529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 10:38:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="694798153"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 10:38:56 -0700
Date:   Tue, 29 Mar 2022 10:42:19 -0700
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
Subject: Re: [PATCH v2 7/8] iommu/vt-d: Delete supervisor/kernel SVA
Message-ID: <20220329104219.4445af35@jacob-builder>
In-Reply-To: <BN9PR11MB5276B2AB27F5AD50BC18AE718C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-8-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276B2AB27F5AD50BC18AE718C139@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Fri, 18 Mar 2022 06:16:58 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > 
> > In-kernel DMA with PASID should use DMA API now, remove supervisor
> > PASID
> > SVA support. Remove special cases in bind mm and page request service.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> so you removed all the references to SVM_FLAG_SUPERVISOR_MODE
> but the definition is still kept in include/linux/intel-svm.h...
> 
Good catch, will remove.

> > ---
> >  drivers/iommu/intel/svm.c | 42 ++++++++-------------------------------
> >  1 file changed, 8 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index 2c53689da461..37d6218f173b 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -516,11 +516,10 @@ static void intel_svm_free_pasid(struct mm_struct
> > *mm)
> > 
> >  static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
> >  					   struct device *dev,
> > -					   struct mm_struct *mm,
> > -					   unsigned int flags)
> > +					   struct mm_struct *mm)
> >  {
> >  	struct device_domain_info *info = get_domain_info(dev);
> > -	unsigned long iflags, sflags;
> > +	unsigned long iflags, sflags = 0;
> >  	struct intel_svm_dev *sdev;
> >  	struct intel_svm *svm;
> >  	int ret = 0;
> > @@ -533,16 +532,13 @@ static struct iommu_sva
> > *intel_svm_bind_mm(struct intel_iommu *iommu,
> > 
> >  		svm->pasid = mm->pasid;
> >  		svm->mm = mm;
> > -		svm->flags = flags;
> >  		INIT_LIST_HEAD_RCU(&svm->devs);
> > 
> > -		if (!(flags & SVM_FLAG_SUPERVISOR_MODE)) {
> > -			svm->notifier.ops = &intel_mmuops;
> > -			ret = mmu_notifier_register(&svm->notifier,
> > mm);
> > -			if (ret) {
> > -				kfree(svm);
> > -				return ERR_PTR(ret);
> > -			}
> > +		svm->notifier.ops = &intel_mmuops;
> > +		ret = mmu_notifier_register(&svm->notifier, mm);
> > +		if (ret) {
> > +			kfree(svm);
> > +			return ERR_PTR(ret);
> >  		}
> > 
> >  		ret = pasid_private_add(svm->pasid, svm);
> > @@ -583,8 +579,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct
> > intel_iommu *iommu,
> >  	}
> > 
> >  	/* Setup the pasid table: */
> > -	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
> > -			PASID_FLAG_SUPERVISOR_MODE : 0;
> >  	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ?
> > PASID_FLAG_FL5LP : 0;
> >  	spin_lock_irqsave(&iommu->lock, iflags);
> >  	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm-  
> > >pasid,  
> > @@ -957,7 +951,7 @@ static irqreturn_t prq_event_thread(int irq, void
> > *d)
> >  			 * to unbind the mm while any page faults are
> > outstanding.
> >  			 */
> >  			svm = pasid_private_find(req->pasid);
> > -			if (IS_ERR_OR_NULL(svm) || (svm->flags &
> > SVM_FLAG_SUPERVISOR_MODE))
> > +			if (IS_ERR_OR_NULL(svm))
> >  				goto bad_req;
> >  		}
> > 
> > @@ -1011,29 +1005,9 @@ static irqreturn_t prq_event_thread(int irq, void
> > *d)
> >  struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct
> > *mm, void *drvdata)
> >  {
> >  	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> > -	unsigned int flags = 0;
> >  	struct iommu_sva *sva;
> >  	int ret;
> > 
> > -	if (drvdata)
> > -		flags = *(unsigned int *)drvdata;
> > -
> > -	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
> > -		if (!ecap_srs(iommu->ecap)) {
> > -			dev_err(dev, "%s: Supervisor PASID not
> > supported\n",
> > -				iommu->name);
> > -			return ERR_PTR(-EOPNOTSUPP);
> > -		}
> > -
> > -		if (mm) {
> > -			dev_err(dev, "%s: Supervisor PASID with user
> > provided mm\n",
> > -				iommu->name);
> > -			return ERR_PTR(-EINVAL);
> > -		}
> > -
> > -		mm = &init_mm;
> > -	}
> > -
> >  	mutex_lock(&pasid_mutex);
> >  	ret = intel_svm_alloc_pasid(dev, mm, flags);
> >  	if (ret) {
> > --
> > 2.25.1  
> 


Thanks,

Jacob
