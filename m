Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E267554910D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243352AbiFMPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbiFMPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:34:46 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7B377EE;
        Mon, 13 Jun 2022 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655125625; x=1686661625;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RjncP8fHJaZm0GW9zoaAk/zj6fE5CQig6aRBxp/wKTw=;
  b=djcktMo1eMQYk4skgRSd/00BST+0fk2iSOAm4MjxRjvXarLGz5lqJVK2
   +dPiqBXO/T5URDSHz+LViRtV6SvhVDKWYiPg6NKhjG/292NIjErY7LFZf
   kpFItpZSEnZu1AMpwtj2GHyW4rBCb10DELma1wrw3l62pZ0EBR78mVArB
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jun 2022 06:07:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 06:07:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 06:07:04 -0700
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 13 Jun
 2022 06:07:03 -0700
Message-ID: <b3f5e49d-8917-79ab-8f59-29ad6cec3973@quicinc.com>
Date:   Mon, 13 Jun 2022 07:07:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: Disable IRQs instead of freeing them during
 power down
Content-Language: en-US
To:     Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>,
        <quic_hemantk@quicinc.com>, <loic.poulain@linaro.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>
References: <1654782215-70383-1-git-send-email-quic_qianyu@quicinc.com>
 <62d09e6f-9898-6233-dfd6-b5ba5d837571@quicinc.com>
 <9659ecb9-9727-a146-e286-d28d656483c3@quicinc.com>
 <9a11394d-f7df-e549-8afb-0834f7d30202@quicinc.com>
 <8eceb966-b5c1-8913-ac97-95348f92650d@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <8eceb966-b5c1-8913-ac97-95348f92650d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/2022 7:48 PM, Qiang Yu wrote:
> 
> On 6/10/2022 10:00 PM, Jeffrey Hugo wrote:
>> On 6/9/2022 9:21 PM, Qiang Yu wrote:
>>> On 6/9/2022 9:54 PM, Jeffrey Hugo wrote:
>>>
>>>> On 6/9/2022 7:43 AM, Qiang Yu wrote:
>>>>> EP tends to read MSI address/data once and cache them after BME is 
>>>>> set.
>>>>> So host should avoid changing MSI address/data after BME is set.
>>>>>
>>>>> In pci reset function, host invokes free_irq(), which also clears MSI
>>>>> address/data in EP's PCIe config space. If the invalid address/data
>>>>> are cached and used by EP, MSI triggered by EP wouldn't be received by
>>>>> host, because an invalid MSI data is sent to an invalid MSI address.
>>>>>
>>>>> To fix this issue, after host runs request_irq() successfully during
>>>>> mhi driver probe, let's invoke enable_irq()/disable_irq() instead of
>>>>> request_irq()/free_irq() when we want to power on and power down MHI.
>>>>> Meanwhile, Host should invoke free_irq() when mhi host driver is
>>>>> removed.
>>>>
>>>> I don't think this works for hotplug, nor cases where there are 
>>>> multiple MHI devices on the system.
>>>>
>>>> The EP shouldn't be caching this information for multiple reasons. 
>>>> Masking the MSIs, disabling the MSIs, changing the address when the 
>>>> affinity changes, etc.
>>>>
>>>> It really feels like we are solving the problem in the wrong place.
>>>>
>>>> Right now, this gets a NACK from me.
>>>>
>>> After free_irq(), MSI is still enabled but MSI address and data are 
>>> cleared. So there is a chance that device initiates MSI using zero 
>>> address. How to fix this race conditions.
>>
>> On what system is MSI still enabled?  I just removed the AIC100 
>> controller on an random x86 system, and lspci is indicating MSIs are 
>> disabled -
>>
>> Capabilities: [50] MSI: Enable- Count=32/32 Maskable+ 64bit+
> 
> system: Ubuntu18.04, 5.4.0-89-generic,  Intel(R) Core(TM) i7-6700 CPU @ 
> 3.40GHz
> 
> After removing MHI driver, I also see MSI enable is cleared.  But I 
> don't think free_irq clears it. I add log before free_irq and after 
> free_irq as following show:
> 
> [62777.625111] msi cap before free irq
> [62777.625125] msi control=0x1bb, address=0xfee00318, data=0x0
> [62777.625301] msi cap after free irq
> [62777.625313] msi control=0x1bb, address=0x0, data=0x0
> [62777.625496] mhi-pci-generic 0000:01:00.0: mhi_pci_remove end of line, 
> block 90 secs.
> # lspci -vvs 01:00.0
>          Capabilities: [50] MSI: Enable+ Count=8/32 Maskable+ 64bit+
>                  Address: 0000000000000000  Data: 0000
>                  Masking: ffffffff  Pending: 00000000

At this point, the MSI functionality is still enabled, but every MSI is 
masked out (Masking), so per the PCIe spec, the endpoint may not trigger 
a MSI to the host.  The device advertises that it supports maskable MSIs 
(Maskable+), so this is appropiate.

If your device can still send a MSI at this point, then it violates the 
PCIe spec.

disable_irq() will not help you with this as it will do the same thing.

I still think you are trying to fix an issue in the wrong location (host 
vs EP), and causing additional issues by doing so.

> [62868.692186] mhi-pci-generic 0000:01:00.0: mhi_pci_remove 90 sec expire.
> # lspci -vvs 01:00.0
>          Capabilities: [50] MSI: Enable- Count=8/32 Maskable+ 64bit+
>                  Address: 0000000000000000  Data: 0000
>                  Masking: 00000000  Pending: 00000000
> 
> I also add msleep() at last of remove callback to block the remove 
> operation, then lspci shows MSI is still enabled  and after MHI driver 
> is removed,
> 
> lspci shows MSI is disabled. It proves free_irq does not clear MSI 
> enable, although I am not sure who does it (probably pci framework 
> clears but I don 't find it).
> 
> I delete pci_free_irq_vectors() when I test.
> 
>>
>>> Maybe EP should not cache MSI data and address. But I think this 
>>> patch is necessary and we will talk with EP POC.
>>>
>>>>>
>>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>>> ---
>>>>>   drivers/bus/mhi/host/init.c        | 31 
>>>>> +++++++++++++++++++++++++++++++
>>>>>   drivers/bus/mhi/host/pci_generic.c |  2 ++
>>>>>   drivers/bus/mhi/host/pm.c          |  4 ++--
>>>>>   3 files changed, 35 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>>>> index cbb86b2..48cb093 100644
>>>>> --- a/drivers/bus/mhi/host/init.c
>>>>> +++ b/drivers/bus/mhi/host/init.c
>>>>> @@ -18,6 +18,7 @@
>>>>>   #include <linux/slab.h>
>>>>>   #include <linux/vmalloc.h>
>>>>>   #include <linux/wait.h>
>>>>> +#include <linux/irq.h>
>>>>
>>>> Should be in alphabetical order
>>>>
>>>>>   #include "internal.h"
>>>>>     static DEFINE_IDA(mhi_controller_ida);
>>>>> @@ -168,6 +169,22 @@ int mhi_init_irq_setup(struct mhi_controller 
>>>>> *mhi_cntrl)
>>>>>       unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
>>>>>       int i, ret;
>>>>>   +    /*
>>>>> +     * if irq[0] has action, it represents all MSI IRQs have been
>>>>> +     * requested, so we just need to enable them.
>>>>> +     */
>>>>
>>>> This seems like an assumption about how the interrupts are allocated 
>>>> and assigned that may not hold true for all devices.
>>>
>>> All interrupts are allocated and assigned together in 
>>> mhi_pci_get_irqs() and mhi_init_irq_setup().
>>>
>>> So I think if irq[0] has action, other irqs must be requested 
>>> successfully. If any other msi request fail, irq[0] should have been 
>>> freed.
>>>
>>>>> +    if (irq_has_action(mhi_cntrl->irq[0])) {
>>>>> +        enable_irq(mhi_cntrl->irq[0]);
>>>>> +
>>>>> +        for (i = 0; i < mhi_cntrl->total_ev_rings; i++, 
>>>>> mhi_event++) {
>>>>> +            if (mhi_event->offload_ev)
>>>>> +                continue;
>>>>> +
>>>>> + enable_irq(mhi_cntrl->irq[mhi_event->irq]);
>>>>> +        }
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>>       /* if controller driver has set irq_flags, use it */
>>>>>       if (mhi_cntrl->irq_flags)
>>>>>           irq_flags = mhi_cntrl->irq_flags;
>>>>> @@ -179,6 +196,11 @@ int mhi_init_irq_setup(struct mhi_controller 
>>>>> *mhi_cntrl)
>>>>>                      "bhi", mhi_cntrl);
>>>>>       if (ret)
>>>>>           return ret;
>>>>> +    /*
>>>>> +     * IRQ marked IRQF_SHARED isn't recommended to use IRQ_NOAUTOEN,
>>>>> +     * so disable it explicitly.
>>>>> +     */
>>>>> +    disable_irq(mhi_cntrl->irq[0]);
>>>>>         for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>>>>>           if (mhi_event->offload_ev)
>>>>> @@ -200,6 +222,8 @@ int mhi_init_irq_setup(struct mhi_controller 
>>>>> *mhi_cntrl)
>>>>>                   mhi_cntrl->irq[mhi_event->irq], i);
>>>>>               goto error_request;
>>>>>           }
>>>>> +
>>>>> +        disable_irq(mhi_cntrl->irq[mhi_event->irq]);
>>>>>       }
>>>>>         return 0;
>>>>> @@ -1003,8 +1027,14 @@ int mhi_register_controller(struct 
>>>>> mhi_controller *mhi_cntrl,
>>>>>         mhi_create_debugfs(mhi_cntrl);
>>>>>   +    ret = mhi_init_irq_setup(mhi_cntrl);
>>>>> +    if (ret)
>>>>> +        goto error_setup_irq;
>>>>> +
>>>>>       return 0;
>>>>>   +error_setup_irq:
>>>>> +    mhi_destroy_debugfs(mhi_cntrl);
>>>>>   err_release_dev:
>>>>>       put_device(&mhi_dev->dev);
>>>>>   err_ida_free:
>>>>> @@ -1027,6 +1057,7 @@ void mhi_unregister_controller(struct 
>>>>> mhi_controller *mhi_cntrl)
>>>>>       struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
>>>>>       unsigned int i;
>>>>>   +    mhi_deinit_free_irq(mhi_cntrl);
>>>>>       mhi_destroy_debugfs(mhi_cntrl);
>>>>>         destroy_workqueue(mhi_cntrl->hiprio_wq);
>>>>> diff --git a/drivers/bus/mhi/host/pci_generic.c 
>>>>> b/drivers/bus/mhi/host/pci_generic.c
>>>>> index 6fbc591..60020d0 100644
>>>>> --- a/drivers/bus/mhi/host/pci_generic.c
>>>>> +++ b/drivers/bus/mhi/host/pci_generic.c
>>>>> @@ -945,6 +945,8 @@ static void mhi_pci_remove(struct pci_dev *pdev)
>>>>>         mhi_unregister_controller(mhi_cntrl);
>>>>>       pci_disable_pcie_error_reporting(pdev);
>>>>> +
>>>>> +    pci_free_irq_vectors(pdev);
>>>>>   }
>>>>>     static void mhi_pci_shutdown(struct pci_dev *pdev)
>>>>> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
>>>>> index dc2e8ff..190231c 100644
>>>>> --- a/drivers/bus/mhi/host/pm.c
>>>>> +++ b/drivers/bus/mhi/host/pm.c
>>>>> @@ -500,7 +500,7 @@ static void mhi_pm_disable_transition(struct 
>>>>> mhi_controller *mhi_cntrl)
>>>>>       for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>>>>>           if (mhi_event->offload_ev)
>>>>>               continue;
>>>>> -        free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
>>>>> +        disable_irq(mhi_cntrl->irq[mhi_event->irq]);
>>>>>           tasklet_kill(&mhi_event->task);
>>>>>       }
>>>>>   @@ -1182,7 +1182,7 @@ void mhi_power_down(struct mhi_controller 
>>>>> *mhi_cntrl, bool graceful)
>>>>>       /* Wait for shutdown to complete */
>>>>>       flush_work(&mhi_cntrl->st_worker);
>>>>>   -    free_irq(mhi_cntrl->irq[0], mhi_cntrl);
>>>>> +    disable_irq(mhi_cntrl->irq[0]);
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(mhi_power_down);
>>>>
>>

