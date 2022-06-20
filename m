Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160305524E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiFTT5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiFTT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:57:09 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042B41CFE0;
        Mon, 20 Jun 2022 12:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655755028; x=1687291028;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=nVkMDtelBSqwtUPvbeoUxnRHGUYm0P0IpqSZEn/Amv8=;
  b=rcx6VCKq3Rle7fK8pXctneZkX05SbpJIwBaqR7BSJGmlC5d+9QWKsDjG
   xy4ihlozYsL1sHFZTgbeQ2wKGhWbXGYHSGkctbKPWTuC9EEoLV2MIByGc
   aZforBPhfLDHQNVKWnS2ITIVEmdr9OJ6pjJP/eHNO5gW8pI0x4BH5r6eQ
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jun 2022 12:57:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 12:57:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 12:57:07 -0700
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 12:57:06 -0700
Message-ID: <c93aa921-b327-fdf4-adae-f0dd77e8789e@quicinc.com>
Date:   Mon, 20 Jun 2022 13:57:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: Disable IRQs instead of freeing them during
 power down
Content-Language: en-US
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>,
        <quic_hemantk@quicinc.com>, <loic.poulain@linaro.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1654782215-70383-1-git-send-email-quic_qianyu@quicinc.com>
 <62d09e6f-9898-6233-dfd6-b5ba5d837571@quicinc.com>
In-Reply-To: <62d09e6f-9898-6233-dfd6-b5ba5d837571@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On 6/9/2022 7:54 AM, Jeffrey Hugo wrote:
> On 6/9/2022 7:43 AM, Qiang Yu wrote:
>> EP tends to read MSI address/data once and cache them after BME is set.
>> So host should avoid changing MSI address/data after BME is set.
>>
>> In pci reset function, host invokes free_irq(), which also clears MSI
>> address/data in EP's PCIe config space. If the invalid address/data
>> are cached and used by EP, MSI triggered by EP wouldn't be received by
>> host, because an invalid MSI data is sent to an invalid MSI address.
>>
>> To fix this issue, after host runs request_irq() successfully during
>> mhi driver probe, let's invoke enable_irq()/disable_irq() instead of
>> request_irq()/free_irq() when we want to power on and power down MHI.
>> Meanwhile, Host should invoke free_irq() when mhi host driver is
>> removed.
> 
> I don't think this works for hotplug, nor cases where there are multiple 
> MHI devices on the system.
> 
> The EP shouldn't be caching this information for multiple reasons. 
> Masking the MSIs, disabling the MSIs, changing the address when the 
> affinity changes, etc.
> 
> It really feels like we are solving the problem in the wrong place.
> 
> Right now, this gets a NACK from me.
> 
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> ---
>>   drivers/bus/mhi/host/init.c        | 31 +++++++++++++++++++++++++++++++
>>   drivers/bus/mhi/host/pci_generic.c |  2 ++
>>   drivers/bus/mhi/host/pm.c          |  4 ++--
>>   3 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index cbb86b2..48cb093 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/wait.h>
>> +#include <linux/irq.h>
> 
> Should be in alphabetical order
> 
>>   #include "internal.h"
>>   static DEFINE_IDA(mhi_controller_ida);
>> @@ -168,6 +169,22 @@ int mhi_init_irq_setup(struct mhi_controller 
>> *mhi_cntrl)
>>       unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
>>       int i, ret;
>> +    /*
>> +     * if irq[0] has action, it represents all MSI IRQs have been
>> +     * requested, so we just need to enable them.
>> +     */
> 
> This seems like an assumption about how the interrupts are allocated and 
> assigned that may not hold true for all devices.

Ah, I see.  This goes to the assumption that the BHI interrupt is always 
line 0, even though as far as I am aware, the spec doesn't require that. 
  The comment could be clearer I think.

> 
>> +    if (irq_has_action(mhi_cntrl->irq[0])) {
>> +        enable_irq(mhi_cntrl->irq[0]);
>> +
>> +        for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>> +            if (mhi_event->offload_ev)
>> +                continue;
>> +
>> +            enable_irq(mhi_cntrl->irq[mhi_event->irq]);
>> +        }
>> +        return 0;
>> +    }

Please no.  This overloads the function to have two different behaviors, 
and it doesn't match the inline disables.

Since you have inline disables, I would prefer inline enables so that 
the code is "balanced".

>> +
>>       /* if controller driver has set irq_flags, use it */
>>       if (mhi_cntrl->irq_flags)
>>           irq_flags = mhi_cntrl->irq_flags;
>> @@ -179,6 +196,11 @@ int mhi_init_irq_setup(struct mhi_controller 
>> *mhi_cntrl)
>>                      "bhi", mhi_cntrl);
>>       if (ret)
>>           return ret;
>> +    /*
>> +     * IRQ marked IRQF_SHARED isn't recommended to use IRQ_NOAUTOEN,
>> +     * so disable it explicitly.
>> +     */
>> +    disable_irq(mhi_cntrl->irq[0]);
>>       for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>>           if (mhi_event->offload_ev)
>> @@ -200,6 +222,8 @@ int mhi_init_irq_setup(struct mhi_controller 
>> *mhi_cntrl)
>>                   mhi_cntrl->irq[mhi_event->irq], i);
>>               goto error_request;
>>           }
>> +
>> +        disable_irq(mhi_cntrl->irq[mhi_event->irq]);
>>       }
>>       return 0;
>> @@ -1003,8 +1027,14 @@ int mhi_register_controller(struct 
>> mhi_controller *mhi_cntrl,
>>       mhi_create_debugfs(mhi_cntrl);
>> +    ret = mhi_init_irq_setup(mhi_cntrl);
>> +    if (ret)
>> +        goto error_setup_irq;
>> +
>>       return 0;
>> +error_setup_irq:
>> +    mhi_destroy_debugfs(mhi_cntrl);
>>   err_release_dev:
>>       put_device(&mhi_dev->dev);
>>   err_ida_free:
>> @@ -1027,6 +1057,7 @@ void mhi_unregister_controller(struct 
>> mhi_controller *mhi_cntrl)
>>       struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
>>       unsigned int i;
>> +    mhi_deinit_free_irq(mhi_cntrl);
>>       mhi_destroy_debugfs(mhi_cntrl);
>>       destroy_workqueue(mhi_cntrl->hiprio_wq);
>> diff --git a/drivers/bus/mhi/host/pci_generic.c 
>> b/drivers/bus/mhi/host/pci_generic.c
>> index 6fbc591..60020d0 100644
>> --- a/drivers/bus/mhi/host/pci_generic.c
>> +++ b/drivers/bus/mhi/host/pci_generic.c
>> @@ -945,6 +945,8 @@ static void mhi_pci_remove(struct pci_dev *pdev)
>>       mhi_unregister_controller(mhi_cntrl);
>>       pci_disable_pcie_error_reporting(pdev);
>> +
>> +    pci_free_irq_vectors(pdev);

This seems like a random change that should be in a different patch. 
Why is it included here?

>>   }
>>   static void mhi_pci_shutdown(struct pci_dev *pdev)
>> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
>> index dc2e8ff..190231c 100644
>> --- a/drivers/bus/mhi/host/pm.c
>> +++ b/drivers/bus/mhi/host/pm.c
>> @@ -500,7 +500,7 @@ static void mhi_pm_disable_transition(struct 
>> mhi_controller *mhi_cntrl)
>>       for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>>           if (mhi_event->offload_ev)
>>               continue;
>> -        free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
>> +        disable_irq(mhi_cntrl->irq[mhi_event->irq]);
>>           tasklet_kill(&mhi_event->task);
>>       }
>> @@ -1182,7 +1182,7 @@ void mhi_power_down(struct mhi_controller 
>> *mhi_cntrl, bool graceful)
>>       /* Wait for shutdown to complete */
>>       flush_work(&mhi_cntrl->st_worker);
>> -    free_irq(mhi_cntrl->irq[0], mhi_cntrl);
>> +    disable_irq(mhi_cntrl->irq[0]);
>>   }
>>   EXPORT_SYMBOL_GPL(mhi_power_down);
> 
> 

