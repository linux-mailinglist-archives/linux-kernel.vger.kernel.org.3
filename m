Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65385533564
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbiEYCie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiEYCic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:38:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2E96F4AF
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653446310; x=1684982310;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SdlZnAu2OMh5vWqWaY7d/SJjgLMefXlumhmFyk3EdaY=;
  b=K3mU2/eXOSz0f2es/+FHstWexn+npCoj0yYUAcGjy6CQ6GGgfUSsJbll
   dSZZ9ijH6vZIiGXf7TxveFpHjDZgME+tl8P2TOAgxC+QM/DeRTDqms/2J
   WuM+s6eNb9cIt79RH6ygGM7I1E8Jxt3SIknvmxijFfRC+YueSEzia8pP0
   acm4aUQ3eSAziVpIzIWurYYXLimDU46nIkNcnjrl4AUIknNElfjBL/Pm5
   j5IHYC2GT7Hb9qEj6Ar3kj9ryISh/lAG2Y+ieSFX/Ebpw0GqTwmkksFK8
   L8zWov+WOUX/HFLkb3N0CepHHU3vpYhxmdidBxSHE6ujaB13465RSiI1+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="336752156"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="336752156"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 19:38:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601611754"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139]) ([10.255.29.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 19:38:26 -0700
Message-ID: <5d1e2178-ac4c-a864-59b4-d297a3366f6a@linux.intel.com>
Date:   Wed, 25 May 2022 10:38:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276982C37DFF0FEFC45BDD68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220524133839.GS1343366@nvidia.com>
 <BN9PR11MB52767C320271EC422B1D55228CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52767C320271EC422B1D55228CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/25 08:44, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Tuesday, May 24, 2022 9:39 PM
>>
>> On Tue, May 24, 2022 at 09:39:52AM +0000, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, May 19, 2022 3:21 PM
>>>>
>>>> The iommu_sva_domain represents a hardware pagetable that the
>> IOMMU
>>>> hardware could use for SVA translation. This adds some infrastructure
>>>> to support SVA domain in the iommu common layer. It includes:
>>>>
>>>> - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA
>>>> domain
>>>>    type.
>>>> - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
>>>>    support SVA should provide the callbacks.
>>>> - Add helpers to allocate and free an SVA domain.
>>>> - Add helpers to set an SVA domain to a device and the reverse
>>>>    operation.
>>>>
>>>> Some buses, like PCI, route packets without considering the PASID value.
>>>> Thus a DMA target address with PASID might be treated as P2P if the
>>>> address falls into the MMIO BAR of other devices in the group. To make
>>>> things simple, the attach/detach interfaces only apply to devices
>>>> belonging to the singleton groups, and the singleton is immutable in
>>>> fabric i.e. not affected by hotplug.
>>>>
>>>> The iommu_set/block_device_pasid() can be used for other purposes,
>>>> such as kernel DMA with pasid, mediation device, etc. Hence, it is put
>>>> in the iommu.c.
>>>
>>> usually we have 'set/clear' pair or 'allow/block'. Having 'set' paired
>>> with 'block' doesn't read very clearly.
>>
>> I thought we agreed we'd use the blocking domain for this? Why did it
>> go back to an op?
>>
> 
> Probably it's based on following discussion:
> 
> https://lore.kernel.org/all/c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com/
> 
> --
>> FWIW from my point of view I'm happy with having a .detach_dev_pasid op
>> meaning implicitly-blocked access for now.
> 
> If this is the path then lets not call it attach/detach
> please. 'set_dev_pasid' and 'set_dev_blocking_pasid' are clearer
> names.

Yes. Learning from above discussion, we are about to implement the
set_dev_pasid and blocking domain in parallel. We will convert all
the callback names to set_dev and set_dev_pasid after blocking domain
support is merged.

> --
> 
> Looks Baolu chooses this path and plans to use the blocking domain
> later.

Yes. I have already started to implement the blocking domain in Intel
driver. With it as an example, we can extend it to other possible IOMMU
drivers.

Best regards,
baolu
