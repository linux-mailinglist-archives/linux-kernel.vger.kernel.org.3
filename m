Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F590583724
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiG1CpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiG1CpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:45:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B9842AEA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658976299; x=1690512299;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ah3X23tMVoVqGE9nPkCAsbxZjxK8SCUwElbqAG3Zw8g=;
  b=O7qhqpbrGm4OJZ1Ak836avf/jkmzWsqLfgX7ZzX8Aurke+zqnZNKeKoa
   ZzQ9RxwKvV+3iikGNKALURhZ9XW3XMoqQYIhH2/cnct+LcH1HhOKwJGpW
   pRpZ0EmyMEGFZdrixNWgjzuOvTeTQAbJKpw/jvO8XDC6TTMvBVjPpznpy
   YTX/9TdYOVGu+2BKAAE9AmvFtwS+eeWvAfS3a7QB8FpnRu5JuQhfnY8gh
   XIN/VxQefLcUX6gLt7qjQpf9OL3F7oU+Bzw1hcUZz8ZpG6Gax9cXzQfzR
   h1Zcxi6rhRjSz5L3d0ZvSnJkzNvSrhqFMyKGQ7R0nII2/EBrUMSIZL3Ew
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="271443873"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="271443873"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 19:44:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="633447834"
Received: from lingc1-mobl.ccr.corp.intel.com (HELO [10.249.173.21]) ([10.249.173.21])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 19:44:54 -0700
Message-ID: <cf370e4a-9391-4dd3-1e0a-3c7ea70d9ed2@linux.intel.com>
Date:   Thu, 28 Jul 2022 10:44:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220726135722.GC4438@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/26 21:57, Jason Gunthorpe wrote:
> On Tue, Jul 26, 2022 at 02:23:26PM +0800, Baolu Lu wrote:
>> On 2022/7/25 22:40, Jason Gunthorpe wrote:
>>> On Sun, Jul 24, 2022 at 03:03:16PM +0800, Baolu Lu wrote:
>>>
>>>> How about rephrasing this part of commit message like below:
>>>>
>>>> Some buses, like PCI, route packets without considering the PASID value.
>>>> Thus a DMA target address with PASID might be treated as P2P if the
>>>> address falls into the MMIO BAR of other devices in the group. To make
>>>> things simple, these interfaces only apply to devices belonging to the
>>>> singleton groups.
>>>
>>>> Considering that the PCI bus supports hot-plug, even a device boots with
>>>> a singleton group, a later hot-added device is still possible to share
>>>> the group, which breaks the singleton group assumption. In order to
>>>> avoid this situation, this interface requires that the ACS is enabled on
>>>> all devices on the path from the device to the host-PCI bridge.
>>>
>>> But ACS directly fixes the routing issue above
>>>
>>> This entire explanation can be recast as saying we block PASID
>>> attachment in all cases where the PCI fabric is routing based on
>>> address. ACS disables that.
>>>
>>> Not sure it even has anything to do with hotplug or singleton??
>>
>> Yes, agreed. I polished this patch like below. Does it look good to you?
>>
>> iommu: Add attach/detach_dev_pasid iommu interface
>>
>> Attaching an IOMMU domain to a PASID of a device is a generic operation
>> for modern IOMMU drivers which support PASID-granular DMA address
>> translation. Currently visible usage scenarios include (but not limited):
>>
>>   - SVA (Shared Virtual Address)
>>   - kernel DMA with PASID
>>   - hardware-assist mediated device
>>
>> This adds a pair of domain ops for this purpose and adds the interfaces
>> for device drivers to attach/detach a domain to/from a {device,
>> PASID}.
> 
>> The PCI bus routes packets without considering the PASID value.
> 
> More like:
> 
> Some configurations of the PCI fabric will route device originated TLP
> packets based on memory address, and these configurations are
> incompatible with PASID as the PASID packets form a distinct address
> space. For instance any configuration where switches are present
> without ACS is incompatible with PASID.

This description reads more accurate and professional. Thank you! I will
update the patch with this.

> 
>> +	/*
>> +	 * Block PASID attachment in all cases where the PCI fabric is
>> +	 * routing based on address. ACS disables it.
>> +	 */
>> +	if (dev_is_pci(dev) &&
>> +	    !pci_acs_path_enabled(to_pci_dev(dev), NULL, REQ_ACS_FLAGS))
>> +		return -ENODEV;
> 
> I would probably still put this in a function just to be clear, and
> probably even a PCI layer funcion 'pci_is_pasid_supported' that
> clearly indicates that the fabric path can route a PASID packet
> without mis-routing it.

Fair enough. Let's keep this in iommu for now and leave the possible
merging in PCI subsystem a future task.

> 
> If the fabric routes PASID properly then groups are not an issue - all
> agree on this?

I still think the singleton group is required, but it's not related to
the PCI fabric routing discussed here.

We have a single array for PASIDs in the iommu group. All devices
sitting in the group should share a single PASID namespace. However both
the translation structures for IOMMU hardware or the device drivers can
only adapt to per-device PASID namespace. Hence, it's reasonable to
require the singleton group.

Best regards,
baolu
