Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19F85858D3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 08:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiG3GRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 02:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiG3GRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 02:17:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443641D2F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 23:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659161866; x=1690697866;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=oFW1VFvsvwUQ1O2ptLBiOxnNK5bxa7Wr2RcCeO0TdgM=;
  b=ikles8eM3whUGVMDpjNmXqRSyEa7pDlOJxta68IgjWRXgAOz/x0jM51Y
   hz04L57zc1yqADzZpPyiPt3DOYFDCl3X7Nr3kdPARcVzT3nm3GTn+5dwo
   chUczu/UPuQSuheHsKVRq51Q9+pr5PnjWtOhf2EsMFNWljqJC2b8QBreP
   U3YEuvkn5rZFclRtQREM/Xc75+3rs5uFtEtfgXH+vhDSXrXxLjMwVFtCG
   91qlu7Ru3HfPe3zz7YWbNF0kqpVaPejeuWjC4uQVFJrn+gITz4+F2PPi/
   FFyQu7SInaf9IfFh6w/Zh8+FNYC1Np6uqCekpV5KG+DJ1WasnTMCk+S51
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="286450692"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="286450692"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 23:17:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="660516517"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174]) ([10.254.210.174])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 23:17:42 -0700
Message-ID: <01a591dc-4918-3c8d-e3f4-b4b738919ee5@linux.intel.com>
Date:   Sat, 30 Jul 2022 14:17:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220727115339.GM4438@nvidia.com>
 <BN9PR11MB52766C3D37FA985DEBDC30C78C969@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YuJ6MXoNTj0RKCb8@nvidia.com>
 <78376ca4-9b55-7609-abf1-27a1a376a8e0@linux.intel.com>
 <BN9PR11MB52761058CFCB9397F6A73A958C999@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64667345-7f7f-74ec-215a-f2d36be0f9ce@linux.intel.com>
 <BN9PR11MB5276ED7CE0C8CE192B4EACB68C999@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
In-Reply-To: <BN9PR11MB5276ED7CE0C8CE192B4EACB68C999@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/29 12:22, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, July 29, 2022 11:21 AM
>>
>> On 2022/7/29 10:56, Tian, Kevin wrote:
>>>> +static bool iommu_group_device_pasid_viable(struct iommu_group
>> *group,
>>>> +					    struct device *dev)
>>>> +{
>>>> +	int count;
>>>> +
>>>> +	count = iommu_group_device_count(group);
>>>> +	if (count != 1)
>>>> +		return false;
>>>> +
>>>> +	/*
>>>> +	 * Block PASID attachment in cases where the PCI fabric is
>>>> +	 * routing based on address. PCI/ACS disables that.
>>>> +	 */
>>>> +	if (dev_is_pci(dev))
>>>> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
>>>> +					    REQ_ACS_FLAGS);
>>> I think we are leaning toward doing above check in pci_enable_pasid().
>>> Then no singleton check inside iommu core.
>>
>> The iommu grouping also considers other things, like PCI alias. There
>> are many calls of pci_add_dma_alias() in drivers/pci/quirks.c.
>> Therefore, I believe that pci_acs_path_enabled() returning true doesn't
>> guarantees a singleton group.
> 
> Is there an actual problem of sharing PASID table between aliasing RIDs?
> As long as ACS is enabled the device is isolated from other devices
> in the fabric. DMA aliases don't change that fact and there is no p2p
> between aliasing RIDs.

Yes. Agreed.

At present, the visible PASID use cases only occur on the singleton
groups, so we can start to support it from this simple situation. In the
future, if the multi-device groups need to support pasid, we can simply
apply the domain to the PASIDs of all device of the group.

> 
>>
>>>
>>> Presumably similar check can be done in DT/ACPI path of enabling pasid?
>>>
>>
>> I can't find the pasid (or anything similar) enabling interfaces for
>> DT or ACPI. They are device specific?
>>
> 
> Looks only PCI PASID is supported so far. both in Intel/ARM/AMD
> drivers. If other buses will support PASID one day, then ACS-equivalent
> can be also checked in their PASID enabling APIs.

Yes. Fair enough.

Best regards,
baolu
