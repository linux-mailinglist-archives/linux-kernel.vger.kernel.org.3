Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B76533645
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 06:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbiEYEuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 00:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiEYEuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 00:50:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F1771DA8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 21:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653454210; x=1684990210;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pjZMmEANMCnklIA4vkBd2ENvVE8LwaQZspI3mdFXeHY=;
  b=Bz07Cdun7geUfgE5rloSint2MN1vCaXC2vhxMSOPIRkM/DudzNfMxO5d
   G96PK8kHTkR3DNkpoAhOk5B7vMKYLPkzm7Ebndrnb2N3VhbgAcCAamKPh
   7mywDkNJq8wqUSAzfMzQZXl5XDqKPFy1BBk4/8BkhtPzYRLlR1Wdeetrg
   KYYmB7pRKHL+ev2oGBSiZ8WlJrpWy7UOeAWMz5w6NGfWTRBImOQyK2wQT
   mH9A1G8NZGrlU6pw2kOkDFSjyBabZQpnvOb1TZCXYrdj9Z9ctXahJwap7
   Z/AS6IAe8PmPu/cIyX5MRNJRCFe+Czh94r3vwAoCfSaQjWu5FYM1hTFL+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="336769629"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="336769629"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 21:50:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601652421"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139]) ([10.255.29.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 21:50:06 -0700
Message-ID: <caae0926-b8f8-a64d-5c33-441e33d0c1dc@linux.intel.com>
Date:   Wed, 25 May 2022 12:50:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
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
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276982C37DFF0FEFC45BDD68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276982C37DFF0FEFC45BDD68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/5/24 17:39, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 19, 2022 3:21 PM
>>
>> The iommu_sva_domain represents a hardware pagetable that the IOMMU
>> hardware could use for SVA translation. This adds some infrastructure
>> to support SVA domain in the iommu common layer. It includes:
>>
>> - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA
>> domain
>>    type.
>> - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
>>    support SVA should provide the callbacks.
>> - Add helpers to allocate and free an SVA domain.
>> - Add helpers to set an SVA domain to a device and the reverse
>>    operation.
>>
>> Some buses, like PCI, route packets without considering the PASID value.
>> Thus a DMA target address with PASID might be treated as P2P if the
>> address falls into the MMIO BAR of other devices in the group. To make
>> things simple, the attach/detach interfaces only apply to devices
>> belonging to the singleton groups, and the singleton is immutable in
>> fabric i.e. not affected by hotplug.
>>
>> The iommu_set/block_device_pasid() can be used for other purposes,
>> such as kernel DMA with pasid, mediation device, etc. Hence, it is put
>> in the iommu.c.
> 
> usually we have 'set/clear' pair or 'allow/block'. Having 'set' paired
> with 'block' doesn't read very clearly.

Yes. Let's still use the attach/detach semantics.

> 
>> +static bool device_group_immutable_singleton(struct device *dev)
>> +{
>> +	struct iommu_group *group = iommu_group_get(dev);
> 
> what about passing group as the parameter since the caller will
> get the group again right after calling this function? In that case
> the function could be renamed as:
> 
> 	iommu_group_immutable_singleton()
> 
> or be shorter:
> 
> 	iommu_group_fixed_singleton()

Fair enough. I will tune it as below:

+static bool iommu_group_immutable_singleton(struct iommu_group *group)
+{
+       int count;
+
+       mutex_lock(&group->mutex);
+       count = iommu_group_device_count(group);
+       mutex_unlock(&group->mutex);
+
+       if (count != 1)
+               return false;
+
+       /*
+        * The PCI device could be considered to be fully isolated if all
+        * devices on the path from the device to the host-PCI bridge are
+        * protected from peer-to-peer DMA by ACS.
+        */
+       if (dev_is_pci(dev))
+               return pci_acs_path_enabled(to_pci_dev(dev), NULL,
+                                           REQ_ACS_FLAGS);
+
+       /*
+        * Otherwise, the device came from DT/ACPI, assume it is static and
+        * then singleton can know from the device count in the group.
+        */
+       return true;
+}


> 
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
> 
> For non-pci devices above doesn't check anything against immutable.
> Please add some comment to explain why doing so is correct.

Yes, as above code shows.

> 
>> +
>> +	/*
>> +	 * The PCI device could be considered to be fully isolated if all
>> +	 * devices on the path from the device to the host-PCI bridge are
>> +	 * protected from peer-to-peer DMA by ACS.
>> +	 */
>> +	if (dev_is_pci(dev))
>> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
>> +					    REQ_ACS_FLAGS);
>> +
>> +	return true;
>> +}
>> +

Best regards,
baolu
