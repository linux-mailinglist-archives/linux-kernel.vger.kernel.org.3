Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C514FE243
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355722AbiDLNWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355838AbiDLNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:22:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC752B30
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649769015; x=1681305015;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FtOtwsR/6/Gleg8tQpLT6Wl9kjWox0FUNsf+RY7PPeY=;
  b=WUJLf1ltwwJzaQQkzAikTNtqpJ/irEJaoNnzBEQl1l/ZMIAUBHg6peuM
   qPeMPQn56mshbiXrW2HfGswdSuk49qy3B/hCqPhhexC371tNGLY3Elhai
   Clml1HDW3TbAo6+BptoG53N8dsMNTkPYP1bKDUtptTRxOXK07yZjGnknI
   r454F1g+ZhvrJkV8Pk6aiZgLzHUB8Ny46z9yGPkPBiamV2Z8ciW9wGg6j
   o6VK4vBG9kkCHmro4BbjfsgiF746wuT1PLjmXsNMU7oHkt99I5yWvZtjf
   7l0LgekAm6Tg6asIebV9qYVpEON3Ia5fctMlOEjnbnS1JMBRMzwVF2iC7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="249654246"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="249654246"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:10:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="572758885"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174]) ([10.254.210.174])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:10:05 -0700
Message-ID: <06240213-dbc6-ea1c-ca49-28663387ac70@linux.intel.com>
Date:   Tue, 12 Apr 2022 21:10:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
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
 <BN9PR11MB527689614CBD807A113493B48CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527689614CBD807A113493B48CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 15:39, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 10, 2022 6:25 PM
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
> 
> btw probably we also want to check when a 2nd device is added
> to a group marked as singleton, just in case some weird thing happens?

It depends on how we judge whether the group to which a DT device
belongs is a singleton. As I explained in another thread, current trick
doesn't support doing this.

Best regards,
baolu
