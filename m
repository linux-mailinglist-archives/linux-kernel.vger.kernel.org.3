Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8EB50C82A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiDWIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiDWIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:05:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE28A1035
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650700924; x=1682236924;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oYSa9eG/ZLGjKfhpFORv9gMTTxmsCZoyxnq7RTpNwu0=;
  b=IRLMsWjBX6XtasNzPJMjx70D8b63WzmkSIRcZvWhbWuOl8azMD3sceU2
   rsUJF9qYXgJVk8f1E+psAdmu7crzjG0YO2gFqkMoY7R3Ix1rLXJMcTvxm
   DBQ4fcfC0oDCW9bLquw+8AajFwJcOTx1XvJkJlBCw2hAzeljkBsF+36oa
   c2LVy2BinSAZ3R2CKqAkx4l9N6HV5R1G//Hh2s+OedgHH3BKQtUtYYBUP
   aYGFhfalfVHhmyRMw24BrinVDql/m3npO0lMcfHRpc0BtVejFh6FffSto
   +hPT3ImaqzhBVpRvqb5mqlF0E7EMLVBplhR3SABMFYQuskJaqButSLTO6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="265034545"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="265034545"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 01:02:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="578312714"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217]) ([10.255.31.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 01:02:00 -0700
Message-ID: <36764562-ad54-b192-4084-842fee8fca78@linux.intel.com>
Date:   Sat, 23 Apr 2022 16:01:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        yong.wu@mediatek.com, mjrosato@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
 <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
 <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
 <7f693a3a-bbab-237a-af9a-4395e501a5b2@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <7f693a3a-bbab-237a-af9a-4395e501a5b2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2022/4/19 15:20, Robin Murphy wrote:
> On 2022-04-19 00:37, Lu Baolu wrote:
>> On 2022/4/19 6:09, Robin Murphy wrote:
>>> On 2022-04-16 01:04, Lu Baolu wrote:
>>>> On 2022/4/14 20:42, Robin Murphy wrote:
>>>>> @@ -1883,27 +1900,12 @@ static int iommu_bus_init(struct bus_type 
>>>>> *bus)
>>>>>    */
>>>>>   int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
>>>>>   {
>>>>> -    int err;
>>>>> -
>>>>> -    if (ops == NULL) {
>>>>> -        bus->iommu_ops = NULL;
>>>>> -        return 0;
>>>>> -    }
>>>>> -
>>>>> -    if (bus->iommu_ops != NULL)
>>>>> +    if (bus->iommu_ops && ops && bus->iommu_ops != ops)
>>>>>           return -EBUSY;
>>>>>       bus->iommu_ops = ops;
>>>>
>>>> Do we still need to keep above lines in bus_set_iommu()?
>>>
>>> It preserves the existing behaviour until each callsite and its 
>>> associated error handling are removed later on, which seems like as 
>>> good a thing to do as any. Since I'm already relaxing 
>>> iommu_device_register() to a warn-but-continue behaviour while it 
>>> keeps the bus ops on life-support internally, I figured not changing 
>>> too much at once would make it easier to bisect any potential issues 
>>> arising from this first step.
>>
>> Fair enough. Thank you for the explanation.
>>
>> Do you have a public tree that I could pull these patches and try them
>> on an Intel hardware? Or perhaps you have done this? I like the whole
>> idea of this series, but it's better to try it with a real hardware.
> 
> I haven't bothered with separate branches since there's so many 
> different pieces in-flight, but my complete (unstable) development 
> branch can be found here:
> 
> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus
> 
> For now I'd recommend winding the head back to "iommu: Clean up 
> bus_set_iommu()" for testing - some of the patches above that have 
> already been posted and picked up by their respective subsystems, but 
> others are incomplete and barely compile-tested. I'll probably rearrange 
> it later this week to better reflect what's happened so far.

I wound the head back to "iommu: Clean up bus_set_iommu" and tested it
on an Intel machine. It got stuck during boot. This test was on a remote
machine and I have no means to access it physically. So I can't get any
kernel debugging messages. (I have to work from home these days. :-()

I guess it's due to the fact that intel_iommu_probe_device() callback
only works for the pci devices. The issue occurs when probing a device
other than a PCI one.

Best regards,
baolu
