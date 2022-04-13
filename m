Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B964FF660
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiDMMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiDMMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:05:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE915549B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649851372; x=1681387372;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NUwMxQFGv5lhkdI71A37VU5mbkidXa87h31pzAqnuuI=;
  b=cDGMTSvo33DMDx9l7n0o4qfqvlxCFW3j7GLqbUweEXKJWnItxw9E31/N
   UubvusOjIo60Ae0wCJ+p/v0q+vKbtPAoMqDMVRkdhVM+S1mzqDX1EcgXt
   Lv8HLj6Ft8V9i8MI3dtah9NLyrh+jWN4JjMijxoWjYEvDJ1+9y8YQ/7co
   pV30PB+CYJ7CJOQ3JnQtDlpv1Si9SUCK0jdkCDIsMdIw/D232ZYk9yCtn
   WjfCFyJQDSAqyay1EdtwfB7ofHY84k0KH2kD02Ph3B0qDUK5HOx90jmdV
   TJkyf5kPNihxHqAI2Jh5y9MyJNCTkRcyvdVl3RqOLZR2qJvIr3QmUX2UF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262397682"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="262397682"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 05:02:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="573238690"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.67]) ([10.254.215.67])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 05:02:20 -0700
Message-ID: <4e29ee5c-9045-e6ba-880b-fda4020c47c9@linux.intel.com>
Date:   Wed, 13 Apr 2022 20:02:18 +0800
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
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
 <BN9PR11MB5276246A53447854DDA8920D8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6e9bac88-e544-aebe-81ec-d1171239fec3@linux.intel.com>
 <BN9PR11MB52762F5C339737F6E75755CB8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762F5C339737F6E75755CB8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/13 7:32, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 12, 2022 9:03 PM
>>
>> On 2022/4/12 15:37, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, April 12, 2022 1:09 PM
>>>> On 2022/4/12 11:15, Tian, Kevin wrote:
>>>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>>>> Sent: Sunday, April 10, 2022 6:25 PM
>>>>>
>>>>>>
>>>>>> This adds a flag in the iommu_group struct to indicate an immutable
>>>>>> singleton group, and uses standard PCI bus topology, isolation features,
>>>>>> and DMA alias quirks to set the flag. If the device came from DT,
>> assume
>>>>>> it is static and then the singleton attribute can know from the device
>>>>>> count in the group.
>>>>>
>>>>> where does the assumption come from?
>>>>
>>>> Hotplug is the only factor that can dynamically affect the
>>>> characteristics of IOMMU group singleton as far as I can see. If a
>>>> device node was created from the DT, it could be treated as static,
>>>> hence we can judge the singleton in iommu probe phase during boot.
>>>
>>> I didn't get this. Let's look at your code in iommu_group_add_device():
>>>
>>>    +	else if (is_of_node(dev_fwnode(dev)))
>>>    +		group->immutable_singleton =
>>>    +				(iommu_group_device_count(group) == 1);
>>>
>>> Even if there is a multi-devices group above logic will set the flag when
>>> the first device in the group is added since at that time there is only
>>> one device in the group. We need other concrete information  to tell
>>> it similar to how you walk PCI hierarchy to find out the fact...
>>
>> This is a small trick to make things simpler. Once more devices are
>> added to the group, the flag will be flipped. All iommu_group's should
>> be settled down before any drivers start to consume this flag.
>>
> 
> As an immutable flag it cannot be flipped. What about SVA has been
> enabled on the 1st device before the 2nd one is added to the group?

The flipping happens during iommu probe phase before any device driver
binding. Anyway, I have to agree that it doesn't look clever. :-) Let me
try to figure out another way.

Best regards,
baolu
