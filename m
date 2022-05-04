Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94B519AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346927AbiEDI4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346834AbiEDIxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:53:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D1125E87
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651654173; x=1683190173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V5tYr+zZNvwfwnQpbzyvburfLeDVmqCwlAN1Bm8YOJs=;
  b=U3S/3qNCAymUPeYd/fk5Bbows3rXGh2cCg86fRspwg0+ptN45hfWIfR6
   H72RA/pPXdasBKDZHLbWL9+wtaYO/pQX6tnqTT3GTchoDJ/q6jI5BVyZg
   t+IegwQu5pJF/N3Fi/32xis3cq2ybdG11t3oEuxl7gw1g1DpOrVo0wx0C
   y5NQabZQl2KM42VVivjIAXSwmBj4KRhTClcl/qfCXXhVyswiEdTQiwh7V
   zJX9WV9zIuG/xpO+9KlWeZNFETQ1azbtdIq0UVRrebkTiYSzkawEfMJjw
   HHyQZtLdVLBDguXo+TMYzXmsdPG3Rp3YAvMT2RMPINZpkE02OMOd03n2I
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="354141964"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="354141964"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:49:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="734304485"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223]) ([10.255.30.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:49:20 -0700
Message-ID: <aef3b3ed-a7a4-5e6a-c16d-0ee57d01e124@linux.intel.com>
Date:   Wed, 4 May 2022 16:49:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/5] iommu/vt-d: Remove hard coding PGSNP bit in PASID
 entries
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-6-baolu.lu@linux.intel.com>
 <20220502131959.GL8364@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220502131959.GL8364@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/2 21:19, Jason Gunthorpe wrote:
> On Sun, May 01, 2022 at 07:24:34PM +0800, Lu Baolu wrote:
>> As enforce_cache_coherency has been introduced into the iommu_domain_ops,
>> the kernel component which owns the iommu domain is able to opt-in its
>> requirement for force snooping support. The iommu driver has no need to
>> hard code the page snoop control bit in the PASID table entries anymore.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.h | 1 -
>>   drivers/iommu/intel/iommu.c | 3 ---
>>   drivers/iommu/intel/pasid.c | 6 ------
>>   3 files changed, 10 deletions(-)
> 
> It seems fine, but as in the other email where do we do
> pasid_set_pgsnp() for a new device attach on an already no-snopp domain?

Yes. I will take care of this in the next version.

> Jason

Best regards,
baolu
