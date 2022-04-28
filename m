Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FAC512A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242680AbiD1Eh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiD1Ehy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:37:54 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABB654BE4;
        Wed, 27 Apr 2022 21:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651120481; x=1682656481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FXEtPRiw2jY1PBgN9Gci+LbqP2JrnJrWQixl9IKN5fc=;
  b=taAhVz8HkELPU5SPYWxd/PsyHkZbannCk+BDLjCmJUEiMqveS57L4k6c
   7/tcIoKzPGV2KJ20Q4cJDICwnYDLoLmX2S+hLqMTXCdrf3ObTWGQ04ahd
   6QCmka/HcPSfmL7jOU6hkft7G+xeE3Pj1x+CMVVBSQwaBJGuGbQn11azN
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Apr 2022 21:34:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 21:34:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 21:34:40 -0700
Received: from [10.50.42.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 21:34:37 -0700
Message-ID: <cad739da-75af-8d2f-4107-72c657b9acab@quicinc.com>
Date:   Thu, 28 Apr 2022 10:04:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv6] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20220310032636.7286-1-quic_saipraka@quicinc.com>
 <YlkPvnBYzJo9aeZ2@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YlkPvnBYzJo9aeZ2@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 4/15/2022 11:55 AM, Greg Kroah-Hartman wrote:
> On Thu, Mar 10, 2022 at 08:56:36AM +0530, Sai Prakash Ranjan wrote:
>> From: Shanker Donthineni <shankerd@codeaurora.org>
>>
>> Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
>> reads/writes from/to DCC on secondary cores. Each core has its
>> own DCC device registers, so when a core reads or writes from/to DCC,
>> it only accesses its own DCC device. Since kernel code can run on
>> any core, every time the kernel wants to write to the console, it
>> might write to a different DCC.
>>
>> In SMP mode, Trace32 creates multiple windows, and each window shows
>> the DCC output only from that core's DCC. The result is that console
>> output is either lost or scattered across windows.
>>
>> Selecting this option will enable code that serializes all console
>> input and output to core 0. The DCC driver will create input and
>> output FIFOs that all cores will use. Reads and writes from/to DCC
>> are handled by a workqueue that runs only core 0.
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> Acked-by: Adam Wallis <awallis@codeaurora.org>
>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> ---
>>
>> Changes in v6:
>>   * Disable CPU hotplug when CONFIG_HVC_DCC_SERIALIZE_SMP=y.
>>
>> Changes in v5:
>>   * Use get_cpu() and put_cpu() for CPU id check in preemptible context.
>>   * Revert back to build time Kconfig.
>>   * Remove unnecessary hotplug locks, they result in sleeping in atomic context bugs.
>>   * Add a comment for the spinlock.
>>
>> Changes in v4:
>>   * Use module parameter for runtime choice of enabling this feature.
>>   * Use hotplug locks to avoid race between cpu online check and work schedule.
>>   * Remove ifdefs and move to common ops.
>>   * Remove unnecessary check for this configuration.
>>   * Use macros for buf size instead of magic numbers.
>>   * v3 - https://lore.kernel.org/lkml/20211213141013.21464-1-quic_saipraka@quicinc.com/
>>
>> Changes in v3:
>>   * Handle case where core0 is not online.
>>
>> Changes in v2:
>>   * Checkpatch warning fixes.
>>   * Use of IS_ENABLED macros instead of ifdefs.
>>
>> ---
>>   drivers/tty/hvc/Kconfig   |  20 +++++
>>   drivers/tty/hvc/hvc_dcc.c | 175 +++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 192 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
>> index 8d60e0ff67b4..62560cd0c04d 100644
>> --- a/drivers/tty/hvc/Kconfig
>> +++ b/drivers/tty/hvc/Kconfig
>> @@ -87,6 +87,26 @@ config HVC_DCC
>>   	  driver. This console is used through a JTAG only on ARM. If you don't have
>>   	  a JTAG then you probably don't want this option.
>>   
>> +config HVC_DCC_SERIALIZE_SMP
>> +	bool "Use DCC only on CPU core 0"
>> +	depends on SMP && HVC_DCC
>> +	help
>> +	  Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
>> +	  reads/writes from/to DCC on more than one CPU core. Each core has its
>> +	  own DCC device registers, so when a CPU core reads or writes from/to
>> +	  DCC, it only accesses its own DCC device. Since kernel code can run on
>> +	  any CPU core, every time the kernel wants to write to the console, it
>> +	  might write to a different DCC.
>> +
>> +	  In SMP mode, Trace32 creates multiple windows, and each window shows
>> +	  the DCC output only from that core's DCC. The result is that console
>> +	  output is either lost or scattered across windows.
> Why are we documenting, and supporting, a closed source userspace tool
> with kernel changes?  Does this advertisement deserve to be in the
> kernel source tree?

Ok, I will remove the comment.

> And why can't they just fix their tool if this is such a big issue?  Why
> does this only affect this one platform and not all other smp systems?

Hmm, this has been discussed in all the past versions of this series and still we
are at the same question :) I will write a small summary below which will cover
mostly relevant discussions we discussed till now and then I can point to it
whenever this question is asked again.

>> +
>> +	  Selecting this option will enable code that serializes all console
>> +	  input and output to CPU core 0. The DCC driver will create input and
>> +	  output FIFOs that all cores will use. Reads and writes from/to DCC
>> +	  are handled by a workqueue that runs only CPU core 0.
> No need to describe implementation details in a help text, right?  What
> happens when we change this to not be a workqueue?
>

Right, will remove implementation details.

>
>> +
>>   config HVC_RISCV_SBI
>>   	bool "RISC-V SBI console support"
>>   	depends on RISCV_SBI_V01
>> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
>> index 8e0edb7d93fd..e87b82e873d7 100644
>> --- a/drivers/tty/hvc/hvc_dcc.c
>> +++ b/drivers/tty/hvc/hvc_dcc.c
>> @@ -2,9 +2,14 @@
>>   /* Copyright (c) 2010, 2014 The Linux Foundation. All rights reserved.  */
> No copyright update?

Ugh, my bad. Will fix it.

>>   
>>   #include <linux/console.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpumask.h>
>>   #include <linux/init.h>
>> +#include <linux/kfifo.h>
>>   #include <linux/serial.h>
>>   #include <linux/serial_core.h>
>> +#include <linux/smp.h>
>> +#include <linux/spinlock.h>
>>   
>>   #include <asm/dcc.h>
>>   #include <asm/processor.h>
>> @@ -15,6 +20,15 @@
>>   #define DCC_STATUS_RX		(1 << 30)
>>   #define DCC_STATUS_TX		(1 << 29)
>>   
>> +#define DCC_INBUF_SIZE		128
>> +#define DCC_OUTBUF_SIZE		1024
>> +
>> +/* Lock to serialize access to DCC fifo */
>> +static DEFINE_SPINLOCK(dcc_lock);
>> +
>> +static DEFINE_KFIFO(inbuf, unsigned char, DCC_INBUF_SIZE);
>> +static DEFINE_KFIFO(outbuf, unsigned char, DCC_OUTBUF_SIZE);
>> +
>>   static void dcc_uart_console_putchar(struct uart_port *port, int ch)
>>   {
>>   	while (__dcc_getstatus() & DCC_STATUS_TX)
>> @@ -67,24 +81,176 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
>>   	return i;
>>   }
>>   
>> +/*
>> + * Check if the DCC is enabled. If CONFIG_HVC_DCC_SERIALIZE_SMP is enabled,
>> + * then we assume then this function will be called first on core0. That way,
>> + * dcc_core0_available will be true only if it's available on core0.
>> + */
>>   static bool hvc_dcc_check(void)
>>   {
>>   	unsigned long time = jiffies + (HZ / 10);
>> +	static bool dcc_core0_available;
>> +
>> +	/*
>> +	 * If we're not on core 0, but we previously confirmed that DCC is
>> +	 * active, then just return true.
>> +	 */
>> +	int cpu = get_cpu();
>> +
>> +	if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP) && cpu && dcc_core0_available) {
>> +		put_cpu();
>> +		return true;
>> +	}
>> +
>> +	put_cpu();
>>   
>>   	/* Write a test character to check if it is handled */
>>   	__dcc_putchar('\n');
>>   
>>   	while (time_is_after_jiffies(time)) {
>> -		if (!(__dcc_getstatus() & DCC_STATUS_TX))
>> +		if (!(__dcc_getstatus() & DCC_STATUS_TX)) {
>> +			dcc_core0_available = true;
>>   			return true;
>> +		}
>>   	}
>>   
>>   	return false;
>>   }
>>   
>> +/*
>> + * Workqueue function that writes the output FIFO to the DCC on core 0.
>> + */
>> +static void dcc_put_work(struct work_struct *work)
>> +{
>> +	unsigned char ch;
>> +	unsigned long irqflags;
>> +
>> +	spin_lock_irqsave(&dcc_lock, irqflags);
>> +
>> +	/* While there's data in the output FIFO, write it to the DCC */
>> +	while (kfifo_get(&outbuf, &ch))
>> +		hvc_dcc_put_chars(0, &ch, 1);
>> +
>> +	/* While we're at it, check for any input characters */
>> +	while (!kfifo_is_full(&inbuf)) {
>> +		if (!hvc_dcc_get_chars(0, &ch, 1))
>> +			break;
>> +		kfifo_put(&inbuf, ch);
>> +	}
>> +
>> +	spin_unlock_irqrestore(&dcc_lock, irqflags);
>> +}
>> +
>> +static DECLARE_WORK(dcc_pwork, dcc_put_work);
>> +
>> +/*
>> + * Workqueue function that reads characters from DCC and puts them into the
>> + * input FIFO.
>> + */
>> +static void dcc_get_work(struct work_struct *work)
>> +{
>> +	unsigned char ch;
>> +	unsigned long irqflags;
>> +
>> +	/*
>> +	 * Read characters from DCC and put them into the input FIFO, as
>> +	 * long as there is room and we have characters to read.
>> +	 */
>> +	spin_lock_irqsave(&dcc_lock, irqflags);
>> +
>> +	while (!kfifo_is_full(&inbuf)) {
>> +		if (!hvc_dcc_get_chars(0, &ch, 1))
>> +			break;
>> +		kfifo_put(&inbuf, ch);
>> +	}
>> +	spin_unlock_irqrestore(&dcc_lock, irqflags);
>> +}
>> +
>> +static DECLARE_WORK(dcc_gwork, dcc_get_work);
>> +
>> +/*
>> + * Write characters directly to the DCC if we're on core 0 and the FIFO
>> + * is empty, or write them to the FIFO if we're not.
>> + */
>> +static int hvc_dcc0_put_chars(u32 vt, const char *buf, int count)
>> +{
>> +	int len;
>> +	unsigned long irqflags;
>> +
>> +	if (!IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))
>> +		return hvc_dcc_put_chars(vt, buf, count);
>> +
>> +	spin_lock_irqsave(&dcc_lock, irqflags);
>> +	if (smp_processor_id() || (!kfifo_is_empty(&outbuf))) {
>> +		len = kfifo_in(&outbuf, buf, count);
>> +		spin_unlock_irqrestore(&dcc_lock, irqflags);
>> +
>> +		/*
>> +		 * We just push data to the output FIFO, so schedule the
>> +		 * workqueue that will actually write that data to DCC.
>> +		 * CPU hotplug is disabled so CPU0 cannot be offlined
>> +		 * after the cpu online check.
> How is cpu hotplug disabled here?

I guess you got this answer below where we disable CPU hotplug during initialization.

>> +		 */
>> +		if (cpu_online(0))
> What happens if the cpu state changes right after checking it?

CPU hotplug is disabled below during initialization.

>> +			schedule_work_on(0, &dcc_pwork);
> What happens if cpu 0 never comes back?

Same as above.

>> +
>> +		return len;
>> +	}
>> +
>> +	/*
>> +	 * If we're already on core 0, and the FIFO is empty, then just
>> +	 * write the data to DCC.
>> +	 */
>> +	len = hvc_dcc_put_chars(vt, buf, count);
>> +	spin_unlock_irqrestore(&dcc_lock, irqflags);
>> +
>> +	return len;
>> +}
>> +
>> +/*
>> + * Read characters directly from the DCC if we're on core 0 and the FIFO
>> + * is empty, or read them from the FIFO if we're not.
>> + */
>> +static int hvc_dcc0_get_chars(u32 vt, char *buf, int count)
>> +{
>> +	int len;
>> +	unsigned long irqflags;
>> +
>> +	if (!IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))
>> +		return hvc_dcc_get_chars(vt, buf, count);
>> +
>> +	spin_lock_irqsave(&dcc_lock, irqflags);
>> +
>> +	if (smp_processor_id() || (!kfifo_is_empty(&inbuf))) {
>> +		len = kfifo_out(&inbuf, buf, count);
>> +		spin_unlock_irqrestore(&dcc_lock, irqflags);
>> +
>> +		/*
>> +		 * If the FIFO was empty, there may be characters in the DCC
>> +		 * that we haven't read yet.  Schedule a workqueue to fill
>> +		 * the input FIFO, so that the next time this function is
>> +		 * called, we'll have data. CPU hotplug is disabled so CPU0
>> +		 * cannot be offlined after the cpu online check.
> Again, how is cpu hotplug disabled?

See above answer.

>> +		 */
>> +		if (!len && cpu_online(0))
>> +			schedule_work_on(0, &dcc_gwork);
>> +
>> +		return len;
>> +	}
>> +
>> +	/*
>> +	 * If we're already on core 0, and the FIFO is empty, then just
>> +	 * read the data from DCC.
>> +	 */
>> +	len = hvc_dcc_get_chars(vt, buf, count);
>> +	spin_unlock_irqrestore(&dcc_lock, irqflags);
>> +
>> +	return len;
>> +}
>> +
>>   static const struct hv_ops hvc_dcc_get_put_ops = {
>> -	.get_chars = hvc_dcc_get_chars,
>> -	.put_chars = hvc_dcc_put_chars,
>> +	.get_chars = hvc_dcc0_get_chars,
>> +	.put_chars = hvc_dcc0_put_chars,
>>   };
>>   
>>   static int __init hvc_dcc_console_init(void)
>> @@ -108,6 +274,9 @@ static int __init hvc_dcc_init(void)
>>   	if (!hvc_dcc_check())
>>   		return -ENODEV;
>>   
>> +	if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))
>> +		cpu_hotplug_disable();
> Ah.  And you never enable it again?  This feels very very wrong.  Did
> you just ensure that you can never use this option in a real system?
>
> For this reason alone I can't take this change, as you just increased
> the power consumption of any system with this enabled :(
>

DCC stands for "Debug Communication Channel", it is a *DEBUG* channel to communicate
with external debuggers such as JTAG whose access is not enabled in end devices for obvious
reasons. So the DCC console/JTAG console is used in early development of the chipset bringups
when actual UART is not available/come-up yet.

So how is power consumption and using in a real system come into picture at that stage of development?
I can add a big Kconfig message highlighting it is a debug feature and use it accordingly?

And now coming back to the summary, few exchange of messages till now explaining the hotplug situation,

(https://lore.kernel.org/lkml/e4299485-5e20-9254-0c2b-b30be274dd89@quicinc.com/,
https://lore.kernel.org/lkml/YcGQ72wQB1CLkvur@kroah.com/)

Greg:  What has changed in the kernel in the past decade that this is suddenly an issue?
             Why can't userspace debuggers handle this today, merging all of the data from different cores together?
             I still think it should all be handled in userspace?

Me: How would userspace take care of the problem with CPU hotplug? We can't open 100s of CPU JTAG windows
         attach each of them and open DCC terminals initially so that the userspace tool would be able to somehow
         automagically migrate the messages on to different CPU when the current CPU goes offline?

Greg: Offlining CPU 0 happens with power management situations right? Especially with big/little systems, if CPU0
            was a big one, you would remove it while only the little ones were running.

Me: AFAIK on arm64, offlining CPU0 is possible via CPU device sysfs node but we aren't discussing about
         manual offlining right? Because in that case a lot of code would need to be protected against a lot of
         undesired effects like what if someone manually triggers sysrq panic (echo c > /proc/sysrq-trigger),
         what protects us from it? Hopefully we are not talking about manual triggers. Now about PM situations
         in arm64, correct me if I am wrong but I don't see CPU0(boot cpu) being offlined in case of suspend to
         idle(which just puts CPUs into deep idle state and no offlining), suspend to ram or suspend to disk.
         In suspend to ram, I see only non-boot CPUs being offlined in suspend and brought back after resume.
         In case of suspend to disk, I believe it is the same, stack trace in the link above.

So in summary, disabling CPU hotplug for this debug feature doesn't actually make system unusable or lead
to more power consumption as this is a debug hw component and a debug feature with the Kconfig knob
to enable only for required users and used only for early stage developments where we have bare minimal
components up and running. Once we shift to actual debug UART, we anyways don't use this feature.

Thanks,
Sai
