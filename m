Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0150C87B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiDWJDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiDWJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:03:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4ED192A5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650704449; x=1682240449;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8FB4N5+BQcUfsB0XAhS4jENfvDwsU+GAIvqUf13Y6Qc=;
  b=BbNSmZP8lGkjeVswRr8yc2rKQxWODaF1F77dW+2QOqWeOxhqXIbLbIqT
   hYqujSNO0L5ULG62LADXkwlpUs3qI1vSEIaFn6hLJluHK506nIzThJA35
   Fd2BA6AmrUd+nq6NvCUxm7pEtUwLeq8evRiRaNSHOug0/HhkWF5Etar2p
   OFoiCFCPG6EDfaztdCL6z+5+9INWUJavjRLewZ1b/wHfeKqaX/v9bn8JX
   jg/dno8xbjKCghBGATrpc5TBP/k2fa/aBArHeO5cpThNXUIPhTMXrY/6l
   hKqN3hCdZRLiW0HYuIn9MzFcS1Y5qTf9TCDk+O61ojW+XYFPaHJcalto8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325325062"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="325325062"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 02:00:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="578325099"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217]) ([10.255.31.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 02:00:46 -0700
Message-ID: <60d6a35e-5d12-b8c2-b0d2-7155965a10e5@linux.intel.com>
Date:   Sat, 23 Apr 2022 17:00:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-US
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     jean-philippe@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
        gerald.schaefer@linux.ibm.com
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
 <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
 <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
 <7f693a3a-bbab-237a-af9a-4395e501a5b2@arm.com>
 <36764562-ad54-b192-4084-842fee8fca78@linux.intel.com>
 <8cd04084-54d0-9e10-f16f-99541e42d7eb@arm.com>
 <f72349ab-19d9-ed9f-28a7-6654fd5556cd@linux.intel.com>
In-Reply-To: <f72349ab-19d9-ed9f-28a7-6654fd5556cd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/23 16:51, Lu Baolu wrote:
> On 2022/4/23 16:37, Robin Murphy wrote:
>> On 2022-04-23 09:01, Lu Baolu wrote:
>>> Hi Robin,
>>>
>>> On 2022/4/19 15:20, Robin Murphy wrote:
>>>> On 2022-04-19 00:37, Lu Baolu wrote:
>>>>> On 2022/4/19 6:09, Robin Murphy wrote:
>>>>>> On 2022-04-16 01:04, Lu Baolu wrote:
>>>>>>> On 2022/4/14 20:42, Robin Murphy wrote:
>>>>>>>> @@ -1883,27 +1900,12 @@ static int iommu_bus_init(struct 
>>>>>>>> bus_type *bus)
>>>>>>>>    */
>>>>>>>>   int bus_set_iommu(struct bus_type *bus, const struct iommu_ops 
>>>>>>>> *ops)
>>>>>>>>   {
>>>>>>>> -    int err;
>>>>>>>> -
>>>>>>>> -    if (ops == NULL) {
>>>>>>>> -        bus->iommu_ops = NULL;
>>>>>>>> -        return 0;
>>>>>>>> -    }
>>>>>>>> -
>>>>>>>> -    if (bus->iommu_ops != NULL)
>>>>>>>> +    if (bus->iommu_ops && ops && bus->iommu_ops != ops)
>>>>>>>>           return -EBUSY;
>>>>>>>>       bus->iommu_ops = ops;
>>>>>>>
>>>>>>> Do we still need to keep above lines in bus_set_iommu()?
>>>>>>
>>>>>> It preserves the existing behaviour until each callsite and its 
>>>>>> associated error handling are removed later on, which seems like 
>>>>>> as good a thing to do as any. Since I'm already relaxing 
>>>>>> iommu_device_register() to a warn-but-continue behaviour while it 
>>>>>> keeps the bus ops on life-support internally, I figured not 
>>>>>> changing too much at once would make it easier to bisect any 
>>>>>> potential issues arising from this first step.
>>>>>
>>>>> Fair enough. Thank you for the explanation.
>>>>>
>>>>> Do you have a public tree that I could pull these patches and try them
>>>>> on an Intel hardware? Or perhaps you have done this? I like the whole
>>>>> idea of this series, but it's better to try it with a real hardware.
>>>>
>>>> I haven't bothered with separate branches since there's so many 
>>>> different pieces in-flight, but my complete (unstable) development 
>>>> branch can be found here:
>>>>
>>>> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus
>>>>
>>>> For now I'd recommend winding the head back to "iommu: Clean up 
>>>> bus_set_iommu()" for testing - some of the patches above that have 
>>>> already been posted and picked up by their respective subsystems, 
>>>> but others are incomplete and barely compile-tested. I'll probably 
>>>> rearrange it later this week to better reflect what's happened so far.
>>>
>>> I wound the head back to "iommu: Clean up bus_set_iommu" and tested it
>>> on an Intel machine. It got stuck during boot. This test was on a remote
>>> machine and I have no means to access it physically. So I can't get any
>>> kernel debugging messages. (I have to work from home these days. :-()
>>>
>>> I guess it's due to the fact that intel_iommu_probe_device() callback
>>> only works for the pci devices. The issue occurs when probing a device
>>> other than a PCI one.
>>
>> Yeah, I was wondering if that would be significant, since it's the 
>> only driver that never registered itself for platform_bus_type so 
>> won't have actually seen those calls before. I'm inclined to bodge 
>> that as below for now, as long as it then works OK in terms of the 
>> rest of the changes.
>>
>> Thanks,
>> Robin.
>>
>> ----->8-----
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 9fa1b98186a3..6e359f92ec00 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4565,6 +4565,10 @@ static struct iommu_device 
>> *intel_iommu_probe_device(struct device *dev)
>>       unsigned long flags;
>>       u8 bus, devfn;
>>
>> +    /* ANDD platform device support needs fixing */
>> +    if (!pdev)
>> +        return ERR_PTR(-ENODEV);
>> +
>>       iommu = device_to_iommu(dev, &bus, &devfn);
>>       if (!iommu)
>>           return ERR_PTR(-ENODEV);
> 
> I haven't seen any real ANDD platform devices, hence this works for me.

Or more precisely, return NULL when @dev goes through device_to_iommu()?

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df5c62ecf942..0d447739e076 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -797,8 +797,11 @@ struct intel_iommu *device_to_iommu(struct device 
*dev, u8 *bus, u8 *devfn)
                 pf_pdev = pci_physfn(pdev);
                 dev = &pf_pdev->dev;
                 segment = pci_domain_nr(pdev->bus);
-       } else if (has_acpi_companion(dev))
+       } else if (has_acpi_companion(dev)) {
                 dev = &ACPI_COMPANION(dev)->dev;
+       } else {
+               return NULL;
+       }

         rcu_read_lock();
         for_each_iommu(iommu, drhd) {

Best regards,
baolu
