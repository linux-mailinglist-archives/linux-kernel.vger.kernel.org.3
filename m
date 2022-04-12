Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F404FE225
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355690AbiDLNRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356838AbiDLNOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:14:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48C6128
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649768561; x=1681304561;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gvqJWcb4v9bvjUM4ccwyUHqiZCCuCXPOz9JdAQU7q4Q=;
  b=boOja9nF7cqgRVv2Shkh/5Z4L8sjwvbPrt15oZg8FJ+MyB9zLIedpjun
   AWsuSxBoGUkXjUcyn38iDdoYrEjhISXtJ3TJivydAGZn/H1A1cLXCqTI+
   DADkRohX+Gn6+VFvsCwWAAzTvkih3u5bqoRNGYQAoDO4Kfg4VuFYFoVCK
   e+qzbaGleSRzNBiPT9DadgmRYeGRC/7h0T4ygtjxf4HNMXedh1sibbeXJ
   8UAeGBRJDFzTKEFVtL18FNu7kqI5Amp5y6M4EQFlV7ZA3fuodToOm3L34
   3x7kmfoyINkCHY3g2BCNgY+p6uBnAnJ0ME7WeUo0ViGQnuyAzpvr3bEEl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261216641"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261216641"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:02:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="572756171"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174]) ([10.254.210.174])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:02:37 -0700
Message-ID: <6e9bac88-e544-aebe-81ec-d1171239fec3@linux.intel.com>
Date:   Tue, 12 Apr 2022 21:02:32 +0800
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
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276246A53447854DDA8920D8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 15:37, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 12, 2022 1:09 PM
>> On 2022/4/12 11:15, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Sunday, April 10, 2022 6:25 PM
>>>
>>>>
>>>> This adds a flag in the iommu_group struct to indicate an immutable
>>>> singleton group, and uses standard PCI bus topology, isolation features,
>>>> and DMA alias quirks to set the flag. If the device came from DT, assume
>>>> it is static and then the singleton attribute can know from the device
>>>> count in the group.
>>>
>>> where does the assumption come from?
>>
>> Hotplug is the only factor that can dynamically affect the
>> characteristics of IOMMU group singleton as far as I can see. If a
>> device node was created from the DT, it could be treated as static,
>> hence we can judge the singleton in iommu probe phase during boot.
> 
> I didn't get this. Let's look at your code in iommu_group_add_device():
> 
>   +	else if (is_of_node(dev_fwnode(dev)))
>   +		group->immutable_singleton =
>   +				(iommu_group_device_count(group) == 1);
> 
> Even if there is a multi-devices group above logic will set the flag when
> the first device in the group is added since at that time there is only
> one device in the group. We need other concrete information  to tell
> it similar to how you walk PCI hierarchy to find out the fact...

This is a small trick to make things simpler. Once more devices are
added to the group, the flag will be flipped. All iommu_group's should
be settled down before any drivers start to consume this flag.

> 
>>>> +	/*
>>>> +	 * The device could be considered to be fully isolated if
>>>> +	 * all devices on the path from the parent to the host-PCI
>>>> +	 * bridge are protected from peer-to-peer DMA by ACS.
>>>> +	 */
>>>> +	if (!pci_is_root_bus(pdev->bus) &&
>>>> +	    !pci_acs_path_enabled(pdev->bus->self, NULL, REQ_ACS_FLAGS))
>>>> +		return false;
>>>> +
>>>> +	/* Multi-function devices should have ACS enabled. */
>>>> +	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
>>>> +		return false;
>>>
>>> Looks my earlier comment was lost, i.e. you can just use
>>> pci_acs_path_enabled(pdev) to cover above two checks.
>>
>> If a device is directly connected to the root bridge and it is not an
>> MFD, do we still need ACS on it? The Intel idxd device seems to be such
>> a device. I had a quick check with lspci, it has no ACS support.
>>
>> I probably missed anything.
>>
> 
> single-function RCiEP doesn't need to implement ACS but this has
> been covered by pci_acs_enabled() and pci_acs_path_enabled().

Cool! I missed this part. :-) Thanks a lot.

Best regards,
baolu
