Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C45524E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbiFTT7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiFTT7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:59:19 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C1362DB;
        Mon, 20 Jun 2022 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655755159; x=1687291159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zLK8JRmjPUYY12xma+OCv7DTnOA0Wyo6DRgV4BXT040=;
  b=kTbdJhW4w2pwGlUzxXYqIZnWk59lO5vxEuh8EgUSGHPowT5wNeOLahlm
   7t2DkSyTlCo+/WC/LsBU5mfqXgI0eAZT69Q2u31LUn8MvPT5A8l7N4j3y
   F7cO0rdw+2eZeojNZTsZB1oIGw232n939G4CKSUUL51w9NlcNikklUmuP
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 20 Jun 2022 12:59:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 12:59:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 12:59:17 -0700
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 12:59:16 -0700
Message-ID: <0ad762f2-5acb-cfd1-efca-ff83f97f978d@quicinc.com>
Date:   Mon, 20 Jun 2022 13:59:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: Disable IRQs instead of freeing them during
 power down
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Qiang Yu <quic_qianyu@quicinc.com>, <quic_hemantk@quicinc.com>,
        <loic.poulain@linaro.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>
References: <1654782215-70383-1-git-send-email-quic_qianyu@quicinc.com>
 <62d09e6f-9898-6233-dfd6-b5ba5d837571@quicinc.com>
 <9659ecb9-9727-a146-e286-d28d656483c3@quicinc.com>
 <9a11394d-f7df-e549-8afb-0834f7d30202@quicinc.com>
 <8eceb966-b5c1-8913-ac97-95348f92650d@quicinc.com>
 <b3f5e49d-8917-79ab-8f59-29ad6cec3973@quicinc.com>
 <20220615211621.GD3606@thinkpad>
 <1c48ef5b-65c0-501d-db55-714a8a4388b2@quicinc.com>
 <20220616205936.GG2889@thinkpad>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20220616205936.GG2889@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/2022 2:59 PM, Manivannan Sadhasivam wrote:
> On Thu, Jun 16, 2022 at 09:53:34AM -0600, Jeffrey Hugo wrote:
>> On 6/15/2022 3:16 PM, Manivannan Sadhasivam wrote:
>>> On Mon, Jun 13, 2022 at 07:07:02AM -0600, Jeffrey Hugo wrote:
>>>> On 6/12/2022 7:48 PM, Qiang Yu wrote:
>>>>>
>>>>> On 6/10/2022 10:00 PM, Jeffrey Hugo wrote:
>>>>>> On 6/9/2022 9:21 PM, Qiang Yu wrote:
>>>>>>> On 6/9/2022 9:54 PM, Jeffrey Hugo wrote:
>>>>>>>
>>>>>>>> On 6/9/2022 7:43 AM, Qiang Yu wrote:
>>>>>>>>> EP tends to read MSI address/data once and cache them
>>>>>>>>> after BME is set.
>>>>>>>>> So host should avoid changing MSI address/data after BME is set.
>>>>>>>>>
>>>>>>>>> In pci reset function, host invokes free_irq(), which also clears MSI
>>>>>>>>> address/data in EP's PCIe config space. If the invalid address/data
>>>>>>>>> are cached and used by EP, MSI triggered by EP wouldn't be received by
>>>>>>>>> host, because an invalid MSI data is sent to an invalid MSI address.
>>>>>>>>>
>>>>>>>>> To fix this issue, after host runs request_irq() successfully during
>>>>>>>>> mhi driver probe, let's invoke enable_irq()/disable_irq() instead of
>>>>>>>>> request_irq()/free_irq() when we want to power on and power down MHI.
>>>>>>>>> Meanwhile, Host should invoke free_irq() when mhi host driver is
>>>>>>>>> removed.
>>>>>>>>
>>>>>>>> I don't think this works for hotplug, nor cases where there
>>>>>>>> are multiple MHI devices on the system.
>>>>>>>>
>>>>>>>> The EP shouldn't be caching this information for multiple
>>>>>>>> reasons. Masking the MSIs, disabling the MSIs, changing the
>>>>>>>> address when the affinity changes, etc.
>>>>>>>>
>>>>>>>> It really feels like we are solving the problem in the wrong place.
>>>>>>>>
>>>>>>>> Right now, this gets a NACK from me.
>>>>>>>>
>>>>>>> After free_irq(), MSI is still enabled but MSI address and data
>>>>>>> are cleared. So there is a chance that device initiates MSI
>>>>>>> using zero address. How to fix this race conditions.
>>>>>>
>>>>>> On what system is MSI still enabled?  I just removed the AIC100
>>>>>> controller on an random x86 system, and lspci is indicating MSIs are
>>>>>> disabled -
>>>>>>
>>>>>> Capabilities: [50] MSI: Enable- Count=32/32 Maskable+ 64bit+
>>>>>
>>>>> system: Ubuntu18.04, 5.4.0-89-generic,  Intel(R) Core(TM) i7-6700 CPU @
>>>>> 3.40GHz
>>>>>
>>>>> After removing MHI driver, I also see MSI enable is cleared.  But I
>>>>> don't think free_irq clears it. I add log before free_irq and after
>>>>> free_irq as following show:
>>>>>
>>>>> [62777.625111] msi cap before free irq
>>>>> [62777.625125] msi control=0x1bb, address=0xfee00318, data=0x0
>>>>> [62777.625301] msi cap after free irq
>>>>> [62777.625313] msi control=0x1bb, address=0x0, data=0x0
>>>>> [62777.625496] mhi-pci-generic 0000:01:00.0: mhi_pci_remove end of line,
>>>>> block 90 secs.
>>>>> # lspci -vvs 01:00.0
>>>>>            Capabilities: [50] MSI: Enable+ Count=8/32 Maskable+ 64bit+
>>>>>                    Address: 0000000000000000  Data: 0000
>>>>>                    Masking: ffffffff  Pending: 00000000
>>>>
>>>> At this point, the MSI functionality is still enabled, but every MSI is
>>>> masked out (Masking), so per the PCIe spec, the endpoint may not trigger a
>>>> MSI to the host.  The device advertises that it supports maskable MSIs
>>>> (Maskable+), so this is appropiate.
>>>>
>>>> If your device can still send a MSI at this point, then it violates the PCIe
>>>> spec.
>>>>
>>>> disable_irq() will not help you with this as it will do the same thing.
>>>>
>>>> I still think you are trying to fix an issue in the wrong location (host vs
>>>> EP), and causing additional issues by doing so.
>>>>
>>>
>>> Irrespective of caching the MSI data in endpoint, I'd like to get rid of
>>> request_irq/free_irq during the mhi_{power_down/power_up} time. As like the MHI
>>> endpoint stack, we should just do disable/enable irq. Because, the MHI device
>>> may go down several times while running and we do not want to deallocate the
>>> IRQs all the time. And if the device gets removed, ultimately the MHI driver
>>> will get removed and we are fine while loading it back (even if MSI count
>>> changes).
>>>
>>> I didn't had time to look into the patch in detail but I'm in favour of
>>> accepting the proposal.
>>>
>>> @Jeff: Any specific issue you are seeing with hotplug etc...?
>>
>> Perhaps I'm getting confused by the commit text of this change.
>>
>> The issue described is that we free the irq, and then the EP sends a MSI,
>> and the host doesn't receive it.  To me, that is expected.  The host doesn't
>> care about the irq anymore because it freed it, therefore it would be
>> expected that the host doesn't receive the irq.  So, the described issue is
>> not an issue since it is expected behavior from what I can tell.
>>
>> The proposed fix, is to disable the interrupts, and not free them until the
>> driver is removed.  I interpret removing the driver as "rmmod mhi".  Based
>> on this, the problem I see is a scenario where we have N devices in a
>> system, and one device is hotplugged.  On hotplug, we would want to clean up
>> all resources (free irq), but according to the description, we need to rmmod
>> mhi, which is both not automatic and also affects the other N-1 devices
>> which are presumed to be operational.
> 
> No. When the PCI device gets removed during runtime, the remove() callback will
> get called with relevant "struct pci_dev" and that should take care of all
> resource cleanup for that particular device (including free_irq).

That is what I expected, so I was confused.  Seems like we are on the 
same page now.

> You do not need to manually rmmod the driver as that will be done by the
> hotplug driver when there are no devices making use of it. And yes, the commit
> message needs to be changed. >
>>
>> Now, if we throw all of that out the window, and say that the goal is to
>> register the irqs when the controller is registered, free them when the
>> controller is unregistered, and enable/disable based on power up/down as a
>> optimization, that could be sane.  If that is what this change is attempting
>> to do, it is not what the commit text describes.
>>
>> Under the assumption that you want the optimization I just described, I will
>> re-review the code next week when I get back from my travel. Assuming the
>> implementation is good (other than what I've already pointed out), I think
>> the commit text needs to be rewritten.
>>
>> Does that clarify things for you?
> 
> Yep!

Reviewed, with additional comments.  I guess I remove my NACK, but there 
is a lot to address with v2.
