Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACBE4FCE87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347659AbiDLFLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347631AbiDLFLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:11:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6185B340FF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649740140; x=1681276140;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=zE7wi6OheYHsLolA4WbgwXAqoZPUdneCI7YMnZcvNds=;
  b=nfndm+W/BUuJK4rO9nF3x3RtxJX2nG85funf8GcUqy1X3oM1hMuTbqce
   ITDa5M+csQ5cHjkEGgJgS99y3k9vtVzsH0lvpk/cJ7uRkYkqN1bWEC4NJ
   /Gr4f0bfMZbRldxLNQiO7oH4VlYeRnyzogBFa0EdQp86mFODhzOw5Pq6X
   zmpGng7/aiJI7ykV+CwYVaTBRbNO6Ib1GgEMk5NkrM/nkB6XYCifGQJyh
   4mI48HEFr4QRY6jbPXpl4rg0H2XNQifruhy1u3tnwBad1ESjjQGsmPGbb
   ZLll1/FR6WGqYupiwVR3suEAeTwOwOc2LsAAfEhZOUwYvMHPwLTbOmWec
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325189457"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="325189457"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 22:08:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572565571"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.210]) ([10.254.215.210])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 22:08:55 -0700
Message-ID: <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
Date:   Tue, 12 Apr 2022 13:08:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
In-Reply-To: <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

Thanks for your time.

On 2022/4/12 11:15, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 10, 2022 6:25 PM
>>
>> Some features require that a single device must be immutably isolated,
>> even when hot plug is supported.
> 
> This reads confusing, as hotplug cannot be allowed in a singleton group.
> What you actually meant suppose to be:
> 
> "Enabling certain device features require the device in a singleton iommu
> group which is immutable in fabric i.e. not affected by hotplug"

Yours is better. Thank you.

> 
>> For example, the SVA bind()/unbind()
>> interfaces require that the device exists in a singleton group. If we
>> have a singleton group that doesn't have ACS (or similar technologies)
>> and someone hotplugs in another device on a bridge, then our SVA is
>> completely broken and we get data corruption.
> 
> this needs the background that PASID doesn't join PCI packet routing
> thus the dma address (CPU VA) may hit a p2p range.

Sure.

> 
>>
>> This adds a flag in the iommu_group struct to indicate an immutable
>> singleton group, and uses standard PCI bus topology, isolation features,
>> and DMA alias quirks to set the flag. If the device came from DT, assume
>> it is static and then the singleton attribute can know from the device
>> count in the group.
> 
> where does the assumption come from?

Hotplug is the only factor that can dynamically affect the
characteristics of IOMMU group singleton as far as I can see. If a
device node was created from the DT, it could be treated as static,
hence we can judge the singleton in iommu probe phase during boot.

> 
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 67 ++++++++++++++++++++++++++++++++++++----
>> ---
>>   1 file changed, 57 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 0c42ece25854..56ffbf5fdc18 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -48,6 +48,7 @@ struct iommu_group {
>>   	struct list_head entry;
>>   	unsigned int owner_cnt;
>>   	void *owner;
>> +	bool immutable_singleton;
> 
> Just call it 'singleton' with a comment to explain it must be immutable?

I was just trying to distinguish "singleton" and "immutable singleton".
A group is singleton if it only contains a single device in the device
list, while a group is immutable singleton only if the fabric doesn't
allow to change the state.

> 
>>   };
>>
>>   struct group_device {
>> @@ -74,6 +75,16 @@ static const char * const
>> iommu_group_resv_type_string[] = {
>>   #define IOMMU_CMD_LINE_DMA_API		BIT(0)
>>   #define IOMMU_CMD_LINE_STRICT		BIT(1)
>>
>> +/*
>> + * To consider a PCI device isolated, we require ACS to support Source
>> + * Validation, Request Redirection, Completer Redirection, and Upstream
>> + * Forwarding.  This effectively means that devices cannot spoof their
>> + * requester ID, requests and completions cannot be redirected, and all
>> + * transactions are forwarded upstream, even as it passes through a
>> + * bridge where the target device is downstream.
>> + */
>> +#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR |
>> PCI_ACS_UF)
>> +
>>   static int iommu_alloc_default_domain(struct iommu_group *group,
>>   				      struct device *dev);
>>   static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>> @@ -89,6 +100,7 @@ static int
>> iommu_create_device_direct_mappings(struct iommu_group *group,
>>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>>   static ssize_t iommu_group_store_type(struct iommu_group *group,
>>   				      const char *buf, size_t count);
>> +static int iommu_group_device_count(struct iommu_group *group);
>>
>>   #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)
>> 	\
>>   struct iommu_group_attribute iommu_group_attr_##_name =		\
>> @@ -844,6 +856,37 @@ static bool iommu_is_attach_deferred(struct device
>> *dev)
>>   	return false;
>>   }
>>
>> +static int has_pci_alias(struct pci_dev *pdev, u16 alias, void *opaque)
>> +{
>> +	return -EEXIST;
>> +}
>> +
>> +static bool pci_immutably_isolated(struct pci_dev *pdev)
>> +{
>> +	/* Skip the bridges. */
>> +	if (pci_is_bridge(pdev))
>> +		return false;
>> +
>> +	/*
>> +	 * The device could be considered to be fully isolated if
>> +	 * all devices on the path from the parent to the host-PCI
>> +	 * bridge are protected from peer-to-peer DMA by ACS.
>> +	 */
>> +	if (!pci_is_root_bus(pdev->bus) &&
>> +	    !pci_acs_path_enabled(pdev->bus->self, NULL, REQ_ACS_FLAGS))
>> +		return false;
>> +
>> +	/* Multi-function devices should have ACS enabled. */
>> +	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
>> +		return false;
> 
> Looks my earlier comment was lost, i.e. you can just use
> pci_acs_path_enabled(pdev) to cover above two checks.

If a device is directly connected to the root bridge and it is not an
MFD, do we still need ACS on it? The Intel idxd device seems to be such
a device. I had a quick check with lspci, it has no ACS support.

I probably missed anything.

> 
>> +
>> +	/* Filter out devices which has any alias device. */
>> +	if (pci_for_each_dma_alias(pdev, has_pci_alias, NULL))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   /**
>>    * iommu_group_add_device - add a device to an iommu group
>>    * @group: the group into which to add the device (reference should be held)
>> @@ -898,6 +941,20 @@ int iommu_group_add_device(struct iommu_group
>> *group, struct device *dev)
>>   	list_add_tail(&device->list, &group->devices);
>>   	if (group->domain  && !iommu_is_attach_deferred(dev))
>>   		ret = __iommu_attach_device(group->domain, dev);
>> +
>> +	/*
>> +	 * Use standard PCI bus topology, isolation features, and DMA
>> +	 * alias quirks to set the immutable singleton attribute. If
>> +	 * the device came from DT, assume it is static and then
>> +	 * singleton can know from the device count in the group.
>> +	 */
>> +	if (dev_is_pci(dev))
>> +		group->immutable_singleton =
>> +				pci_immutably_isolated(to_pci_dev(dev));
>> +	else if (is_of_node(dev_fwnode(dev)))
>> +		group->immutable_singleton =
>> +				(iommu_group_device_count(group) == 1);
>> +
>>   	mutex_unlock(&group->mutex);
>>   	if (ret)
>>   		goto err_put_group;
>> @@ -1290,16 +1347,6 @@ EXPORT_SYMBOL_GPL(iommu_group_id);
>>   static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
>>   					       unsigned long *devfns);
>>
>> -/*
>> - * To consider a PCI device isolated, we require ACS to support Source
>> - * Validation, Request Redirection, Completer Redirection, and Upstream
>> - * Forwarding.  This effectively means that devices cannot spoof their
>> - * requester ID, requests and completions cannot be redirected, and all
>> - * transactions are forwarded upstream, even as it passes through a
>> - * bridge where the target device is downstream.
>> - */
>> -#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR |
>> PCI_ACS_UF)
>> -
>>   /*
>>    * For multifunction devices which are not isolated from each other, find
>>    * all the other non-isolated functions and look for existing groups.  For
>> --
>> 2.25.1
> 

Best regards,
baolu
