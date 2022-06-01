Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A498653A337
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352580AbiFAKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352578AbiFAKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:48:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB8275DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654080509; x=1685616509;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FljOfQd0ovis2myCMXGwjQ7sjwvP24kidUblqHsfnRA=;
  b=iI5F11nidUOKCcnuKJ41h/+z2jp0jbZKE4egwyAgHuFf4dwqeTWv3Bjz
   6kI2zKANJYYFTanquxbPblXL/hwFk5G3wIXr0vwhFo6Gq7DCLnE0qweKt
   DSIglapHdvN5odEhC5sREBRZtiRj5/pHSi9B9D52ERv+iX0L1p7IfKB9J
   EK3TL5lPj+/hJogs1+078WybXtc0mvydnHGN6u0lPz2m7ND+O0z2jR4Jb
   TH3t/mv6XhwyZzrzvGwwVrKm1NbYpBfhbXJl5kFtp+/n2rV5XKsldz4Ms
   WC4T8i1VI0Wmzz+dgY/LtbLZGM6bBoL7FjLEtBrX8mazgN1e2/fN2TZhb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="300898703"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="300898703"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 03:48:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="707004298"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123]) ([10.255.28.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 03:48:25 -0700
Message-ID: <c70501f3-9cee-fc7d-4ebc-6f88e1ad147f@linux.intel.com>
Date:   Wed, 1 Jun 2022 18:48:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/12] iommu/vt-d: Acquiring lock in pasid manipulation
 helpers
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-8-baolu.lu@linux.intel.com>
 <BN9PR11MB527639286A5F8BB4C8B4D3028CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527639286A5F8BB4C8B4D3028CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/1 17:18, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, May 27, 2022 2:30 PM
>>
>> The iommu->lock is used to protect the per-IOMMU pasid directory table
>> and pasid table. Move the spinlock acquisition/release into the helpers
>> to make the code self-contained.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>, with one nit
> 
>>
>> -	/* Caller must ensure PASID entry is not in use. */
>> -	if (pasid_pte_is_present(pte))
>> -		return -EBUSY;
>> +	spin_lock(&iommu->lock);
>> +	pte = get_non_present_pasid_entry(dev, pasid);
>> +	if (!pte) {
>> +		spin_unlock(&iommu->lock);
>> +		return -ENODEV;
>> +	}
> 
> I don't think above is a good abstraction and it changes the error
> code for an present entry from -EBUSY to -ENODEV.

Sure. I will roll it back to -EBUSY. I added this helper because the
same code appears at least three times in this file.

Best regards,
baolu


