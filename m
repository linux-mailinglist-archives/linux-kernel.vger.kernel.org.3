Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9AD4DCF96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiCQUnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiCQUnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:43:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ECE11BE43
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647549734; x=1679085734;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZPJPlyM9zhjOGH64p0/EhU5dIkf9pGM8NWxT3n0sIXg=;
  b=iMJ7nwsHbScFB0oadF1EILOmr4ye6YyzpNQaXI83u4NhIejmi149FVkb
   GVwmWHDKafcJv22MlcQNI7EG6+gyZNSnXogwkwQOmS9WTUtDl5gzDhorD
   OVM5gyFZI5+6qTM6COleQj3qa0vDLV2FHb58r06fI6+eBH2qVgSde+nOX
   MajvTmr2j9tWm253HaLyhtpoui+eutNlnvbNWWiYu7MMzHQwohruCDafY
   N05xUVQetyf7/aN4u73P8tZmYRRrCsnc6DYA788LAGG/NdcuJJWifdTJ9
   7Yl+d9owJhg6nQeN9KJMvt3J3Dpb3+UhdjwjcVmYRZXpjdzSr4MWUj6cD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254534171"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="254534171"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:42:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="599237997"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:42:14 -0700
Date:   Thu, 17 Mar 2022 13:45:30 -0700
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
Subject: Re: [PATCH v2 4/8] iommu/vt-d: Use device_pasid attach op for
 RID2PASID
Message-ID: <20220317134530.36321009@jacob-builder>
In-Reply-To: <BN9PR11MB52766909013F9CC71A61369C8C119@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-5-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB52766909013F9CC71A61369C8C119@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Wed, 16 Mar 2022 07:54:19 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > 
> > With the availability of a generic device-PASID-domain attachment API,
> > there's no need to special case RID2PASID.  Use the API to replace
> > duplicated code.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 18 ++----------------
> >  1 file changed, 2 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 9267194eaed3..f832b7599d21 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1683,9 +1683,6 @@ static void domain_flush_piotlb(struct
> > intel_iommu *iommu,
> >  		qi_flush_piotlb(iommu, did, domain->default_pasid,
> >  				addr, npages, ih);
> > 
> > -	if (!list_empty(&domain->devices))
> > -		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr,
> > npages, ih);
> > -  
> 
> this should be rebased on top of Baolu's "iommu cleanup and refactoring"
> series which has removed the entire domain_flush_piotlb().
> 
Yes, I have been working with Baolu. Some of the refactoring patches were
withdrawn, so there are lots of moving targets. 

Thanks,

Jacob
