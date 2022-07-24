Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A53F57F391
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiGXHD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiGXHDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:03:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376E2165AD
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658646204; x=1690182204;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YmhanHSqr6bwg4fH+2c4OjhFmUplZmcQFHAOBLtz87U=;
  b=Ol6XcFqlN/FHfU9CT7o5E1LIVJUmmaCQPvkyrPja2dDoVB/IBfcrIa01
   YJm7y5JJY0jr19Bd0hOVipIFxCBavVQIIgWJWLoOyctF6MYDwQkQM+Yxy
   IeTta3HWJ2mssOW10rDYDmAoNCEK8v2vgeUgX9jLBlCxPJBTTli+m4Z0d
   dh3aZiZrfIHJL9GGjDJ+GaCKuuFlSkLWIcLHq+inbmUexbH/n/DPLJczE
   9LhkPrDD1xaOmFwHQKoyz8xhP2jPBNtocZEpDe/j4F4/R+FKNp/FToUo4
   14jLrgw0r0Xfir0OMS05oGfhVTJ8mIN4WHZiR6A2TJPMH7JOf69WIoX2P
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288702512"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="288702512"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 00:03:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657734737"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 00:03:18 -0700
Message-ID: <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
Date:   Sun, 24 Jul 2022 15:03:16 +0800
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
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220723141118.GD79279@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thank you for reviewing this series.

On 2022/7/23 22:11, Jason Gunthorpe wrote:
> On Tue, Jul 05, 2022 at 01:07:02PM +0800, Lu Baolu wrote:
>> Attaching an IOMMU domain to a PASID of a device is a generic operation
>> for modern IOMMU drivers which support PASID-granular DMA address
>> translation. Currently visible usage scenarios include (but not limited):
>>
>>   - SVA (Shared Virtual Address)
>>   - kernel DMA with PASID
>>   - hardware-assist mediated device
>>
>> This adds a pair of domain ops for this purpose and adds the interfaces
>> for device drivers to attach/detach a domain to/from a {device, PASID}.
>> Some buses, like PCI, route packets without considering the PASID
>> value.
> Below the comments touch on ACS, so this is a bit out of date
> 
>> +static bool iommu_group_immutable_singleton(struct iommu_group *group,
>> +					    struct device *dev)
>> +{
>> +	int count;
>> +
>> +	mutex_lock(&group->mutex);
>> +	count = iommu_group_device_count(group);
>> +	mutex_unlock(&group->mutex);
>> +
>> +	if (count != 1)
>> +		return false;
>> +
>> +	/*
>> +	 * The PCI device could be considered to be fully isolated if all
>> +	 * devices on the path from the device to the host-PCI bridge are
>> +	 * protected from peer-to-peer DMA by ACS.
>> +	 */
>> +	if (dev_is_pci(dev))
>> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
>> +					    REQ_ACS_FLAGS);
> You might want to explain what condition causes ACS isolated devices
> to share a group in the first place..
> 

How about rephrasing this part of commit message like below:

Some buses, like PCI, route packets without considering the PASID value.
Thus a DMA target address with PASID might be treated as P2P if the
address falls into the MMIO BAR of other devices in the group. To make
things simple, these interfaces only apply to devices belonging to the
singleton groups.

Considering that the PCI bus supports hot-plug, even a device boots with
a singleton group, a later hot-added device is still possible to share
the group, which breaks the singleton group assumption. In order to
avoid this situation, this interface requires that the ACS is enabled on
all devices on the path from the device to the host-PCI bridge.

Best regards,
baolu
