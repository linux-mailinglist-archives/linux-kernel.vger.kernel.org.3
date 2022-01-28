Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6995749FDE6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350041AbiA1QTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:19:54 -0500
Received: from foss.arm.com ([217.140.110.172]:52302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350009AbiA1QTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:19:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6DAD1396;
        Fri, 28 Jan 2022 08:19:51 -0800 (PST)
Received: from [10.57.86.86] (unknown [10.57.86.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F0EC3F793;
        Fri, 28 Jan 2022 08:19:49 -0800 (PST)
Message-ID: <61b51d19-aad4-dd98-a1a1-8227d43fa28b@arm.com>
Date:   Fri, 28 Jan 2022 16:19:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH] ACPI / amba: Skip creating amba device when
 associated cpu is not online
To:     Robin Murphy <robin.murphy@arm.com>,
        chenxiang <chenxiang66@hisilicon.com>, linux@armlinux.org.uk,
        vkoul@kernel.org, linux-arm-kernel@lists.infradead.org,
        mathieu.poirier@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <1641544906-7069-1-git-send-email-chenxiang66@hisilicon.com>
 <2f3c5e6b-7000-8fa2-21f7-3b0c3fb66ae3@arm.com>
 <136be111-c75e-48b2-caef-cbf4900b6ce1@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <136be111-c75e-48b2-caef-cbf4900b6ce1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2022 15:28, Robin Murphy wrote:
> On 2022-01-28 11:00, Suzuki K Poulose wrote:
>> Hi Xiang
>>
>> On 07/01/2022 08:41, chenxiang wrote:
>>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>>
>>> If not up all the cpus with command line "maxcpus=x", system will be
>>> blocked.
>>> We find that some amba devices such as ETM devices, are associated with
>>> special cpus, and if the cpu is not up, the register of associated 
>>> device
>>> is not allowed to access. BIOS reports all the ETM device nodes and a
>>> amba device is created for every ETM device, so even if one cpu is 
>>> not up,
>>> the amba device will still be created for the associated device, and 
>>> also
>>> the register of device (pid and cid) will be accessed when adding amba
>>> device which will cause the issue.
>>> To fix it, skip creating amba device if it is associated with a cpu 
>>> which
>>> is not online.
>>
>> I understand the issue. We do not have an issue at least on DT based 
>> platforms with a similar environment (Juno). The key is the power 
>> management for the components.
>>
>> There are two separate issues at play here :
>>
>> 1) Power management with ACPI. I believe there is a solution in progress
>> to address this.
>>
>> 2) The ETM is in the same power domain as that of the CPU and normal 
>> device power management may not work without the CPU being online.
>>
>> 3) Additionally we have other issue of supporting system instructions
>> with ACPI, which do not appear on the AMBA bus.
>>
>> Considering all of these, the ideal solution is to :
>>
>> 1) Implement power management for ACPI, which is anyway in progress
>>    (at least for SCMI based systems)
>> 2) Move the ETM driver away from the AMBA framework. That would make
>>     the CPU online problem and the (3) above easier to solve.
>>     Anshuman is going to look into this.
>>
>> In the meantime, we could have this temporary fix in and solve it
>> forever by moving away from the AMBA.
> 
> Out of curiosity, what happens when you boot with "maxcpus=" and then 
> manually bring up the extra cpus from userspace later? Is there a chance 
> that tracing will explode if some online CPUs have ETM initialised but 
> others don't?

No. At the moment, we don't bring the ETMs online for hotplugged CPUs.
i.e., ETM is not registered for the CPU. So any attempt to trace on that
CPU will fail.

Probe deferral doesn't go beyond the userspace init. But we plan to add 
hotplug support, by defering the ETM probe.

At present, the ETMs are bound to the AMBA frame work and I am not sure
if there is a way to explicitly trigger a probe from the AMBA layer on
CPU hotplug. The other option is to always create the AMBA device and
defer the "etm" probe to a cpu hotplug notifier in the ETM driver.
This is something we plan to add.

Suzuki

> 
> Robin.
> 
>>>
>>> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
>>> ---
>>>   drivers/acpi/acpi_amba.c | 36 ++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 36 insertions(+)
>>>
>>> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
>>> index ab8a4e0191b1..2369198f734b 100644
>>> --- a/drivers/acpi/acpi_amba.c
>>> +++ b/drivers/acpi/acpi_amba.c
>>> @@ -16,6 +16,7 @@
>>>   #include <linux/ioport.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/module.h>
>>> +#include <acpi/processor.h>
>>>   #include "internal.h"
>>> @@ -45,6 +46,35 @@ static void amba_register_dummy_clk(void)
>>>       clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
>>>   }
>>> +static int acpi_handle_to_cpuid(acpi_handle handle)
>>> +{
>>> +    int cpu = -1;
>>> +    struct acpi_processor *pr;
>>> +
>>> +    for_each_possible_cpu(cpu) {
>>> +        pr = per_cpu(processors, cpu);
>>> +        if (pr && pr->handle == handle)
>>> +            break;
>>> +    }
>>> +
>>> +    return cpu;
>>> +}
>>> +
>>
>> Please could we reuse the function in coresight-platform.c ?
>> i.e, move it to a generic location and share it, rather than
>> duplicating it ?
>>
>>
>>> +static int acpi_dev_get_cpu(struct acpi_device *adev)
>>> +{
>>> +    acpi_handle cpu_handle;
>>> +    acpi_status status;
>>> +    int cpu;
>>> +
>>> +    status = acpi_get_parent(adev->handle, &cpu_handle);
>>> +    if (ACPI_FAILURE(status))
>>> +        return -1;
>>> +    cpu = acpi_handle_to_cpuid(cpu_handle);
>>> +    if (cpu >= nr_cpu_ids)
>>> +        return -1;
>>> +    return cpu;
>>> +}
>>> +
>>>   static int amba_handler_attach(struct acpi_device *adev,
>>>                   const struct acpi_device_id *id)
>>>   {
>>> @@ -54,11 +84,17 @@ static int amba_handler_attach(struct acpi_device 
>>> *adev,
>>>       bool address_found = false;
>>>       int irq_no = 0;
>>>       int ret;
>>> +    int cpu;
>>>       /* If the ACPI node already has a physical device attached, 
>>> skip it. */
>>>       if (adev->physical_node_count)
>>>           return 0;
>>> +    /* If the cpu associated with the device is not online, skip it. */
>>> +    cpu = acpi_dev_get_cpu(adev);
>>> +    if (cpu >= 0 && !cpu_online(cpu))
>>> +        return 0;
>>> +
>>
>> Except for the comment above, the patch looks good to me.
>>
>> Suzuki
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

