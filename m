Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87689569759
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiGGBUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiGGBUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:20:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E6E2E69C;
        Wed,  6 Jul 2022 18:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657156805; x=1688692805;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RlBsSE86mhkZ1VM1qqe1zDyK2s+b9dUNIdXAWa4b/3U=;
  b=MqFen/CH1oWMnHwrQxZifLcU/0coMdEwlj7UwSF/4Ld+8gaIAz3NGKj5
   Sv1VOQV3QLtWhYfPMnNe0jpKeXAsM4gmAqyuWN9jaDkbCTBYyDD0NvqAk
   Judq6xeZqP81xniFm+m5FpJpFgFoqIzY5nxf+E/ddHizPxiwRYNk04UMq
   DGYrWnf5camVm0p4KIK0KYj81gRmmjI51j5g1MQPoa4PJ7dxBC6oR0P7s
   GozERMKzpmpNUdQYJk5araKAxap27nbE15V916eoMXR1/x6ADlDiuJbqq
   smFSfZ8Ly47fz+JBT6VLGk1ObYPWEPTffL2eoNHlKpiY3LEs92AABsxeO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="266934029"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="266934029"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 18:20:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650909261"
Received: from hualiu-mobl1.ccr.corp.intel.com (HELO [10.249.171.209]) ([10.249.171.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 18:20:01 -0700
Message-ID: <2aa8aa41-4d9f-5a0f-1ad4-e2e19cbcbe6f@linux.intel.com>
Date:   Thu, 7 Jul 2022 09:19:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/15] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <5b9b608af21b3c4353af042355973bac55397962.1657034828.git.robin.murphy@arm.com>
 <d6a8e85b-ab7d-f5c9-a8cb-79dd8e68c967@linux.intel.com>
 <71835610-7798-5fbe-556a-fc44dc9e168b@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <71835610-7798-5fbe-556a-fc44dc9e168b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/6 22:37, Robin Murphy wrote:
> On 2022-07-06 03:35, Baolu Lu wrote:
>> On 2022/7/6 01:08, Robin Murphy wrote:
>>> @@ -202,12 +210,32 @@ int iommu_device_register(struct iommu_device 
>>> *iommu,
>>>       spin_lock(&iommu_device_lock);
>>>       list_add_tail(&iommu->list, &iommu_device_list);
>>>       spin_unlock(&iommu_device_lock);
>>> +
>>> +    for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>>> +        struct bus_type *bus = iommu_buses[i];
>>> +        int err;
>>> +
>>> +        if (bus->iommu_ops && bus->iommu_ops != ops) {
>>> +            err = -EBUSY;
>>> +        } else {
>>> +            bus->iommu_ops = ops;
>>> +            err = bus_iommu_probe(bus);
>>> +        }
>>> +        if (err) {
>>> +            iommu_device_unregister(iommu);
>>> +            return err;
>>> +        }
>>> +    }
>>> +
>>>       return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(iommu_device_register);
>>
>> With bus_set_iommu() retired, my understanding is that now we embrace
>> the first-come-first-serve policy for bus->iommu_ops setting. This will
>> lead to problem in different iommu_ops for different bus case. Did I
>> overlook anything?
> 
> This is just formalising the de-facto situation that we don't actually 
> have any combination of drivers that could load on the same system 
> without already attempting to claim at least one bus in common. It's 
> also only temporary until the bus ops are removed completely and we 
> fully support multiple drivers coexisting, which only actually takes a 
> handful more patches - I've realised I could even bring that change 
> *ahead* of the big job of converting iommu_domain_alloc() (I'm not 
> convinced that the tree-wide flag-day patch for that I currently have in 
> the dev branch is really viable, nor that I've actually got the correct 
> device at some of the callsites), although whether it's worth the 
> potentially-surprising behaviour that might result I'm less sure.
> 
> If we already had systems where in-tree drivers successfully coexisted 
> on different buses then I'd have split this up and done something a bit 
> more involved to keep a vestigial bus_set_iommu() around until the final 
> bus ops removal, but since we don't, it seemed neatest to do all the 
> related work in one go.

Fair enough. I've never seen a mixed system as far. It's fine for us to
retire bus_set_iommu() for now and then formally support mixed IOMMU
drivers later.

Best regards,
baolu
