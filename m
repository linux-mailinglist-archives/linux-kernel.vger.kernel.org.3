Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21F651424F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354530AbiD2Ga7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiD2Ga6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:30:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83CA63503
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651213661; x=1682749661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SuKUMbuCFeOAQ3RN6lPTsfmXavMFIzZF1jAdEMe+Jcw=;
  b=D0rpZx68KQUnfxFbjFo1z2Gk+ZimrlW2tPnDB0cvJ4r+Sh1nA7q/SDMB
   pcUoZXLlHVQSahZrAHcG2fYXe1CGnXcWGLZzZUlrw52xmTrVKHPOkPoY4
   PuyaDYAjdVVqUCGfvZd3n3PvGSgvBx83qa5oO3UMdKWJQ0OpWgjC0/+fo
   TrMoyvB7LnBoNpK+SKecgDilyZj+lxbCPLzvFVcgT1dZlkuYGh5uWSHSx
   50Ww/HFZVrdTUzYaTkZml3jtNjLi300zzb9pDn7J+BeLQEjA1Ize7HCV6
   uom2HJ/hgqQIbdmH9JWD36Ll6HVzlzwf47RjSg65JzE7whkioxaNqlV+q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="247105412"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="247105412"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 23:27:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="581921103"
Received: from lye4-mobl.ccr.corp.intel.com (HELO [10.249.170.95]) ([10.249.170.95])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 23:27:36 -0700
Message-ID: <47d16a5f-23de-fb84-6958-5329ef08fb25@linux.intel.com>
Date:   Fri, 29 Apr 2022 14:27:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 03/12] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-4-baolu.lu@linux.intel.com> <YmqqaXtqev9FUJo7@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YmqqaXtqev9FUJo7@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/28 22:53, Jean-Philippe Brucker wrote:
> On Thu, Apr 21, 2022 at 01:21:12PM +0800, Lu Baolu wrote:
>> Attaching an IOMMU domain to a PASID of a device is a generic operation
>> for modern IOMMU drivers which support PASID-granular DMA address
>> translation. Currently visible usage scenarios include (but not limited):
>>
>>   - SVA (Shared Virtual Address)
>>   - kernel DMA with PASID
>>   - hardware-assist mediated device
>>
>> This adds a pair of common domain ops for this purpose and adds helpers
>> to attach/detach a domain to/from a {device, PASID}. Some buses, like
>> PCI, route packets without considering the PASID value. Thus a DMA target
>> address with PASID might be treated as P2P if the address falls into the
>> MMIO BAR of other devices in the group. To make things simple, these
>> interfaces only apply to devices belonging to the singleton groups, and
>> the singleton is immutable in fabric i.e. not affected by hotplug.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> [...]
>> +/*
>> + * Use standard PCI bus topology, isolation features, and DMA
>> + * alias quirks to check the immutable singleton attribute. If
>> + * the device came from DT, assume it is static and then
>> + * singleton can know from the device count in the group.
>> + */
>> +static bool device_group_immutable_singleton(struct device *dev)
>> +{
>> +	struct iommu_group *group = iommu_group_get(dev);
>> +	int count;
>> +
>> +	if (!group)
>> +		return false;
>> +
>> +	mutex_lock(&group->mutex);
>> +	count = iommu_group_device_count(group);
>> +	mutex_unlock(&group->mutex);
>> +	iommu_group_put(group);
>> +
>> +	if (count != 1)
>> +		return false;
>> +
>> +	if (dev_is_pci(dev)) {
>> +		struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +		/*
>> +		 * The device could be considered to be fully isolated if
>> +		 * all devices on the path from the device to the host-PCI
>> +		 * bridge are protected from peer-to-peer DMA by ACS.
>> +		 */
>> +		if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
>> +			return false;
>> +
>> +		/* Filter out devices which has any alias device. */
>> +		if (pci_for_each_dma_alias(pdev, has_pci_alias, pdev))
>> +			return false;
> 
> Aren't aliases already added to the group by pci_device_group()?  If so
> it's part of the count check above

You are right. pci_device_group() has already covered pci aliases.

> 
>> +
>> +		return true;
>> +	}
>> +
>> +	/*
>> +	 * If the device came from DT, assume it is static and then
>> +	 * singleton can know from the device count in the group.
>> +	 */
>> +	return is_of_node(dev_fwnode(dev));
> 
> I don't think DT is relevant here because a platform device enumerated
> through ACPI will also have its own group. It should be safe to stick to
> what the IOMMU drivers declare with their device_group() callback. Except
> for PCI those groups should be immutable so we can return true here.

Fair enough. My code is too restrict. The group singleton is immutable
as long as the fabric is static or ACS (or similar) technology is
implemented. Currently we only need to care about PCI as far as I can
see.

> Thanks,
> Jean
> 

Best regards,
baolu
