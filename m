Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E484B61F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiBOEEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:04:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiBOEED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:04:03 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532F3F11B5;
        Mon, 14 Feb 2022 20:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644897816; x=1676433816;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2uvbwvVv1g2ej9jzPmcevXRYP4rXUd+by4/cKcEYS90=;
  b=srOUTcou2IYOryKzM9Ukl/Dmg/MfrSIj5rSbbhHEJWAabMDVBllo878f
   KbMbDUWOUlLSkgqLNkx2KBkqaFWgLexoT/O9NzGS7C73RJV9oj2rA5/hT
   gxvsSgm4vAhCvmGUaCjLm+WPa71YSvt2nZEdOfi2YZRHhhVq+IRtKI6Xt
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Feb 2022 20:03:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 20:03:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 20:03:35 -0800
Received: from [10.50.50.207] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 14 Feb
 2022 20:03:31 -0800
Message-ID: <f8ab050f-117b-2c8e-71b8-dbfa38d24c03@quicinc.com>
Date:   Tue, 15 Feb 2022 09:33:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv4] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>
References: <20220210135632.24638-1-quic_saipraka@quicinc.com>
 <YgpyMRTo5wVMhUPl@FVFF77S0Q05N>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YgpyMRTo5wVMhUPl@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Mark,

On 2/14/2022 8:46 PM, Mark Rutland wrote:
> Hi,
>
> On Thu, Feb 10, 2022 at 07:26:32PM +0530, Sai Prakash Ranjan wrote:
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
> This has been the Linux behaviour since the dawn of time, so why is this not
> considered to be a bug in the tools? Why can't Lauterbach add an option to
> treat the cores as one?

More like a feature request than a bug? And why would tools add such a 
feature when
it is the kernel which runs in SMP mode? Shouldn't kernel be the one 
having such a feature
because there would be number of such tools with the same issue and we 
can't send a feature
request to all those tool vendors to add this feature right. Instead 
adding this in the kernel would
avoid all these centrally at one place.

> Importantly, with hotplug we *cannot* guarantee that all messages will go to
> the same CPU anyway, since that could be offlined (even if it is CPU 0), so in
> general we cann't provide a guarantee here.

Right that is true, in case of CPU hotplug this would be pretty much 
broken if CPU0 is offlined.
We use these during initial bringup stage of SoCs when we don't have 
debug UART console up and running
and at the time we don't much care for testing out hotplugging the CPUs 
and let alone trying out
to offline CPU0 which we use and shoot our own foot :)

Given this is mostly a debug feature, we don't mind if this doesn't 
guarantee to work in hotplug scenario.
I did try to make this depend on !HOTPLUG_CPU but it looks like that 
config is so tangled into CPU_PM and
others that it can't be independently disabled without disabling a whole 
lot of other configs.

>> Selecting this option will enable code that serializes all console
>> input and output to core 0. The DCC driver will create input and
>> output FIFOs that all cores will use. Reads and writes from/to DCC
>> are handled by a workqueue that runs only core 0.
> What is 'core 0'?

I mean CPU 0 here.

> Do you actually need a *specific* PE to be used, or just some singular PE?

We just need some singular PE.

> What happens with hotplug, as above?
>
> Do you need to inihibit that?

Please look at my reply above. We don't prevent it currently and just 
make sure that
CPU0 is online so that we don't schedule work on that CPU if it is offline.

Thanks,
Sai

> Thanks,
> Mark.
>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> Acked-by: Adam Wallis <awallis@codeaurora.org>
>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> ---
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
>>   drivers/tty/hvc/hvc_dcc.c | 177 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 174 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
>> index 8e0edb7d93fd..535b09441e55 100644
>> --- a/drivers/tty/hvc/hvc_dcc.c
>> +++ b/drivers/tty/hvc/hvc_dcc.c
>> @@ -2,19 +2,35 @@
>>   /* Copyright (c) 2010, 2014 The Linux Foundation. All rights reserved.  */
>>   
>>   #include <linux/console.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpumask.h>
>>   #include <linux/init.h>
>> +#include <linux/kfifo.h>
>> +#include <linux/moduleparam.h>
>>   #include <linux/serial.h>
>>   #include <linux/serial_core.h>
>> +#include <linux/spinlock.h>
>>   
>>   #include <asm/dcc.h>
>>   #include <asm/processor.h>
>>   
>>   #include "hvc_console.h"
>>   
>> +static bool serialize_smp;
>> +module_param(serialize_smp, bool, 0444);
>> +MODULE_PARM_DESC(serialize_smp, "Serialize all DCC console input and output to CPU core 0");
>> +
>>   /* DCC Status Bits */
>>   #define DCC_STATUS_RX		(1 << 30)
>>   #define DCC_STATUS_TX		(1 << 29)
>>   
>> +#define DCC_INBUF_SIZE		128
>> +#define DCC_OUTBUF_SIZE		1024
>> +
>> +static DEFINE_SPINLOCK(dcc_lock);
>> +static DEFINE_KFIFO(inbuf, unsigned char, DCC_INBUF_SIZE);
>> +static DEFINE_KFIFO(outbuf, unsigned char, DCC_OUTBUF_SIZE);
>> +
>>   static void dcc_uart_console_putchar(struct uart_port *port, int ch)
>>   {
>>   	while (__dcc_getstatus() & DCC_STATUS_TX)
>> @@ -67,24 +83,179 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
>>   	return i;
>>   }
>>   
>> +/*
>> + * Check if the DCC is enabled. If serialize_smp module param is enabled,
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
>> +	if (serialize_smp && smp_processor_id() && dcc_core0_available)
>> +		return true;
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
>> +	if (!serialize_smp)
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
>> +		 * Also take a CPU hotplug lock to avoid CPU going down
>> +		 * between the check and scheduling work on CPU0.
>> +		 */
>> +		cpus_read_lock();
>> +
>> +		if (cpu_online(0))
>> +			schedule_work_on(0, &dcc_pwork);
>> +
>> +		cpus_read_unlock();
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
>> +	if (!serialize_smp)
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
>> +		 * called, we'll have data. Take a CPU hotplug lock as well
>> +		 * to avoid CPU going down between the cpu online check and
>> +		 * scheduling work on CPU0.
>> +		 */
>> +		cpus_read_lock();
>> +
>> +		if (!len && cpu_online(0))
>> +			schedule_work_on(0, &dcc_gwork);
>> +
>> +		cpus_read_unlock();
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
>>
>> base-commit: 395a61741f7ea29e1f4a0d6e160197fe8e377572
>> -- 
>> 2.33.1
>>

