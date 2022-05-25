Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91253352E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbiEYCNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiEYCNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:13:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB06164BDD
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653444808; x=1684980808;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y00jKpGRgIg6OivHiwn8VODmVJdokGS+y/8+3XdeIVU=;
  b=PRXdIV6n5m56DbwocsaDv1oG9+cqTMChYNl3c8TzgUaRRGpYtFLbbVsO
   tyDKH4R+zuz8Y79vjPP3VF+AZfSLMxXMP5TyxNmJYRjgQPhDEkYZznSrD
   kMA539jO8t0+12t95A+4BQU6kE08zk9qRCrA8749xCpsUw6Se4pyIAGCE
   j7EMGSe6yFZbCociDwWB6WqZMNZrujMnJeGIWOPT9x6BL4RPHJocIuSk5
   t4I7Ru0Y8NPkOu8gp7MyX3LlMN3HJi+2RyzxTlTLrJx7geTgsxTreD76L
   BHL1qKZKCZ4z1Q6cm3Y58fLN9E8OwuKMWjRxXXPDm/VRV8hPrmDaIyuf7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="360086128"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="360086128"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 19:13:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601604562"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139]) ([10.255.29.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 19:13:23 -0700
Message-ID: <3751d422-924f-81e6-de8e-3e33de38a50f@linux.intel.com>
Date:   Wed, 25 May 2022 10:13:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 01/10] iommu: Add pasids field in struct iommu_device
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52766D61BBE784A70B4BF06F8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3c112762-f6e6-0b41-b38f-3bb2995d97cf@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3c112762-f6e6-0b41-b38f-3bb2995d97cf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/25 10:03, Baolu Lu wrote:
>>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>>> index 4de960834a1b..1c3cf267934d 100644
>>> --- a/drivers/iommu/intel/dmar.c
>>> +++ b/drivers/iommu/intel/dmar.c
>>> @@ -1126,6 +1126,10 @@ static int alloc_iommu(struct dmar_drhd_unit
>>> *drhd)
>>>
>>>       raw_spin_lock_init(&iommu->register_lock);
>>>
>>> +    /* Supports full 20-bit PASID in scalable mode. */
>>> +    if (ecap_pasid(iommu->ecap))
>>> +        iommu->iommu.pasids = 1UL << 20;
>>> +
>>
>> supported pasid bits is reported by ecap_pss(). I don't think we should
>> assume 20bits here.
> 
> Yes. I overlooked this. Thanks for reminding.
> 
> Another thing I need to improve is that scalable mode could be disabled.
> This field should be 0 in that case.

I will change above to:

+        /*
+         * A value of N in PSS field of eCap register indicates hardware
+         * supports PASID field of N+1 bits.
+         */
+        if (pasid_supported(iommu))
+                iommu->iommu.max_pasids = 2UL << ecap_pss(iommu->ecap);

Best regards,
baolu
