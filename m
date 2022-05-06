Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD851D277
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389651AbiEFHph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389643AbiEFHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:45:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E035DA4D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651822909; x=1683358909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4qkVneJsyWqf2kkvrL6fvf+P6n2txyfxdD4MiAVsMII=;
  b=TqUEiqCyztGky72VR5UNDChb9cDrSXr9X+ybqzUimW8PLx0V9t4ww0MI
   zWKTa0SElk5fFEFO/XJfx3k1H2/UgEEVN9Hj37ZBcWGeWx/sFtgdqgezV
   PyaCTAC0v3JzQUkDzv2o5TutoAgMwpot31FTIs7q9jYc6VV23HLRHPYxn
   +9wcYa1Q0hFkpYUJgWMsrzNau5dtQV9HckQnov6A45+TdVbqTkTFPvxKP
   qZ7r5FOWf5zV7FSJEDR+8weXdLbttYLDqWLAaX9C/Xesjg3tfUbEuAmNa
   6BJDvnfSvFm0gz/oWbCegrWHUAo7j3x2ytg+4xbkL+KtEIoSR4/JqwjaN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="255865851"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="255865851"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 00:41:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735463665"
Received: from sunyanwa-mobl1.ccr.corp.intel.com (HELO [10.255.31.183]) ([10.255.31.183])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 00:41:46 -0700
Message-ID: <b3b353eb-11f7-92c2-3958-fc782fc54389@linux.intel.com>
Date:   Fri, 6 May 2022 15:41:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220506052727.1689687-1-baolu.lu@linux.intel.com>
 <20220506052727.1689687-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52762145C90CDAF980E5E3EB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762145C90CDAF980E5E3EB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/6 14:10, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, May 6, 2022 1:27 PM
>> +
>> +/*
>> + * Set the page snoop control for a pasid entry which has been set up.
>> + */
>> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
>> +					  struct device *dev, u32 pasid)
>> +{
>> +	struct pasid_entry *pte;
>> +	u16 did;
>> +
>> +	spin_lock(&iommu->lock);
>> +	pte = intel_pasid_get_entry(dev, pasid);
>> +	if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
>> +		spin_unlock(&iommu->lock);
>> +		return;
>> +	}
>> +
>> +	pasid_set_pgsnp(pte);
>> +	did = pasid_get_domain_id(pte);
>> +	spin_unlock(&iommu->lock);
>> +
>> +	pasid_flush_caches(iommu, pte, pasid, did);
>> +}
> 
> The comment of pasid_flush_caches() says:
> 
> /*
>   * This function flushes cache for a newly setup pasid table entry.
>   * Caller of it should not modify the in-use pasid table entries.
>   */
> 
> Can you check whether that comment still hold?

I am sorry that I overlooked this. Very appreciated for pointing this
out!

How about below additional changes?

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index da47406011d3..68f7e8cfa848 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -782,5 +782,24 @@ void intel_pasid_setup_page_snoop_control(struct 
intel_iommu *iommu,
         did = pasid_get_domain_id(pte);
         spin_unlock(&iommu->lock);

-       pasid_flush_caches(iommu, pte, pasid, did);
+       if (!ecap_coherent(iommu->ecap))
+               clflush_cache_range(pte, sizeof(*pte));
+
+       /*
+        * VT-d spec 3.4 table23 states guides for cache invalidation:
+        *
+        * - PASID-selective-within-Domain PASID-cache invalidation
+        * - PASID-selective PASID-based IOTLB invalidation
+        * - If (pasid is RID_PASID)
+        *    - Global Device-TLB invalidation to affected functions
+        *   Else
+        *    - PASID-based Device-TLB invalidation (with S=1 and
+        *      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
+        */
+       pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+       qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+
+       /* Device IOTLB doesn't need to be flushed in caching mode. */
+       if (!cap_caching_mode(iommu->cap))
+               devtlb_invalidation_with_pasid(iommu, dev, pasid);
  }

Best regards,
baolu
