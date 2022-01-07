Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8A348734F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiAGHJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:09:52 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:55962 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234102AbiAGHJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641539390; x=1673075390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LJTwzX7qQ2r1smP33J4G60+Wwvcf6UaU56FSLYSfUz4=;
  b=a0SM69oRbNzXdJJNc81aIA6vLW4uSan5BRu3qsRIZp5p8GvsuBf3G24e
   73M9iK9s3F9w3OtIC/URi8j1As5USnHdBefQxgLmu9dlTOfuYRn16Ruh6
   NJbNGytLKXJwBZvgpqeeulISAcWFEuEI4LUluYMIgUfM/+j9IbcPEiav+
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jan 2022 23:09:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 23:09:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 6 Jan 2022 23:09:49 -0800
Received: from [10.50.8.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 6 Jan 2022
 23:09:46 -0800
Message-ID: <8d8991cc-d0f5-bb5d-098a-e5a1a98f6b09@quicinc.com>
Date:   Fri, 7 Jan 2022 12:39:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv3] tty: hvc: dcc: Bind driver to core0 for reads and
 writes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_eberman@quicinc.com>, <quic_tsoni@quicinc.com>,
        Elliot Berman <eberman@codeaurora.org>
References: <20211213141013.21464-1-quic_saipraka@quicinc.com>
 <YcGQ72wQB1CLkvur@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YcGQ72wQB1CLkvur@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/21/2021 2:01 PM, Greg Kroah-Hartman wrote:
> On Mon, Dec 13, 2021 at 07:40:13PM +0530, Sai Prakash Ranjan wrote:
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
>> Changes in v3:
>>   * Handle case where core0 is not online.
>>
>> Changes in v2:
>>   * Checkpatch warning fixes.
>>   * Use of IS_ENABLED macros instead of ifdefs.
>>
>> ---
>>   drivers/tty/hvc/Kconfig   |  20 +++++
>>   drivers/tty/hvc/hvc_dcc.c | 161 +++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 180 insertions(+), 1 deletion(-)
> What has changed in the kernel in the past decade that this is suddenly
> an issue?  Why can't userspace debuggers handle this today, merging all
> of the data from different cores together?

The issue is for the users of this feature, from the past 6 years (when 
the first version was posted)
or possibly more, we have been carrying it downstream because we are the 
frequent users of this
feature and the issue hits us. Just like any other feature, if it is not 
used by more people/org, then they
won't report it. So it is nothing like a sudden issue, its been there 
from a long time.

> And why does this have to be a build-time option and not a runtime
> choice?  How are you going to build a universal kernel that works for
> both types of systems?

There are no 2 types of systems here, just one system with different 
implementation to fix/increase the
usability of this feature. I can add a module parameter if that is what 
you are suggesting to make a runtime
choice?

>> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
>> index 8d60e0ff67b4..c0754a2e3fe4 100644
>> --- a/drivers/tty/hvc/Kconfig
>> +++ b/drivers/tty/hvc/Kconfig
>> @@ -87,6 +87,26 @@ config HVC_DCC
>>   	  driver. This console is used through a JTAG only on ARM. If you don't have
>>   	  a JTAG then you probably don't want this option.
>>   
>> +config HVC_DCC_SERIALIZE_SMP
>> +	bool "Use DCC only on core 0"
>> +	depends on SMP && HVC_DCC
>> +	help
>> +	  Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
>> +	  reads/writes from/to DCC on more than one core. Each core has its
>> +	  own DCC device registers, so when a core reads or writes from/to DCC,
>> +	  it only accesses its own DCC device. Since kernel code can run on
>> +	  any core, every time the kernel wants to write to the console, it
>> +	  might write to a different DCC.
>> +
>> +	  In SMP mode, Trace32 creates multiple windows, and each window shows
>> +	  the DCC output only from that core's DCC. The result is that console
>> +	  output is either lost or scattered across windows.
>> +
>> +	  Selecting this option will enable code that serializes all console
>> +	  input and output to core 0. The DCC driver will create input and
>> +	  output FIFOs that all cores will use. Reads and writes from/to DCC
>> +	  are handled by a workqueue that runs only core 0.
> So this drops down to only one device, not multiple ones?  Or is it the
> other way around?

Yes.

>> +
>>   config HVC_RISCV_SBI
>>   	bool "RISC-V SBI console support"
>>   	depends on RISCV_SBI_V01
>> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
>> index 8e0edb7d93fd..24e3770219bc 100644
>> --- a/drivers/tty/hvc/hvc_dcc.c
>> +++ b/drivers/tty/hvc/hvc_dcc.c
>> @@ -2,9 +2,12 @@
>>   /* Copyright (c) 2010, 2014 The Linux Foundation. All rights reserved.  */
>>   
>>   #include <linux/console.h>
>> +#include <linux/cpumask.h>
>>   #include <linux/init.h>
>> +#include <linux/kfifo.h>
>>   #include <linux/serial.h>
>>   #include <linux/serial_core.h>
>> +#include <linux/spinlock.h>
>>   
>>   #include <asm/dcc.h>
>>   #include <asm/processor.h>
>> @@ -67,26 +70,182 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
>>   	return i;
>>   }
>>   
>> +/*
>> + * Check if the DCC is enabled.  If CONFIG_HVC_DCC_SERIALIZE_SMP is enabled,
>> + * then we assume then this function will be called first on core 0.  That
>> + * way, dcc_core0_available will be true only if it's available on core 0.
>> + */
>>   static bool hvc_dcc_check(void)
>>   {
>>   	unsigned long time = jiffies + (HZ / 10);
>> +	static bool dcc_core0_available;
>> +
>> +	/*
>> +	 * If we're not on core 0, but we previously confirmed that DCC is
>> +	 * active, then just return true.
> Why?  Don't you want to see if DCC works on the other cores?
>
> What if core 0 is never enabled?

It does check right based on dcc_core0_available below. Is core0 being 
never enabled an option?
I see there is nosmp and maxcpus cmdline which can modify the cores 
which need to be online but
in both cases there isn't a way to actually make core0 unavailable 
because nosmp would make core0
as the only core and maxcpus=1 would also do the same. Do you know of 
any way where core0 which
is a logical cpu 0 to be offline/never enabled other than hotplug case?

>
>> +	 */
>> +	if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP) && smp_processor_id() &&
>> +	    dcc_core0_available)
>> +		return true;
>>   
>>   	/* Write a test character to check if it is handled */
>>   	__dcc_putchar('\n');
>>   
>>   	while (time_is_after_jiffies(time)) {
>> -		if (!(__dcc_getstatus() & DCC_STATUS_TX))
>> +		if (!(__dcc_getstatus() & DCC_STATUS_TX)) {
>> +			if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))
> Why this check again?

Right, it is not required.

>> +				dcc_core0_available = true;
>>   			return true;
>> +		}
>>   	}
>
>
>>   
>>   	return false;
>>   }
>>   
>> +#if defined(CONFIG_HVC_DCC_SERIALIZE_SMP)
> No ifdefs in .c files please.  Make this a separate .c file entirely if
> this really is needed.

Hmm, separate file would cause unnecessary duplication, let me see what 
I can do for this.

>> +
>> +static void dcc_put_work_fn(struct work_struct *work);
>> +static void dcc_get_work_fn(struct work_struct *work);
>> +static DECLARE_WORK(dcc_pwork, dcc_put_work_fn);
>> +static DECLARE_WORK(dcc_gwork, dcc_get_work_fn);
> No need to put "fn" at the end of your function name, we know it's a
> function :)

Ack, will remove it.

>> +static DEFINE_SPINLOCK(dcc_lock);
>> +static DEFINE_KFIFO(inbuf, unsigned char, 128);
>> +static DEFINE_KFIFO(outbuf, unsigned char, 1024);
> Where did these size values come from?

These are random magic values, I will define this as INBUF_SIZE and 
OUTBUF_SIZE.

>> +
>> +/*
>> + * Workqueue function that writes the output FIFO to the DCC on core 0.
>> + */
>> +static void dcc_put_work_fn(struct work_struct *work)
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
> Why is this needed?  Will not the normal input handling deal with this?

Let me check this one.

>
>> +	}
>> +
>> +	spin_unlock_irqrestore(&dcc_lock, irqflags);
>> +}
>> +
>> +/*
>> + * Workqueue function that reads characters from DCC and puts them into the
>> + * input FIFO.
>> + */
>> +static void dcc_get_work_fn(struct work_struct *work)
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
>> +/*
>> + * Write characters directly to the DCC if we're on core 0 and the FIFO
>> + * is empty, or write them to the FIFO if we're not.
>> + */
>> +static int hvc_dcc0_put_chars(u32 vt, const char *buf, int count)
>> +{
>> +	int len;
>> +	unsigned long irqflags;
>> +
>> +	spin_lock_irqsave(&dcc_lock, irqflags);
>> +	if (smp_processor_id() || (!kfifo_is_empty(&outbuf))) {
>> +		len = kfifo_in(&outbuf, buf, count);
>> +		spin_unlock_irqrestore(&dcc_lock, irqflags);
>> +
>> +		if (!cpu_online(0))
>> +			return 0;
>> +		/*
>> +		 * We just push data to the output FIFO, so schedule the
>> +		 * workqueue that will actually write that data to DCC.
>> +		 */
>> +		schedule_work_on(0, &dcc_pwork);
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
>> +	spin_lock_irqsave(&dcc_lock, irqflags);
>> +
>> +	if (smp_processor_id() || (!kfifo_is_empty(&inbuf))) {
>> +		len = kfifo_out(&inbuf, buf, count);
>> +		spin_unlock_irqrestore(&dcc_lock, irqflags);
>> +
>> +		if (!cpu_online(0))
>> +			return 0;
> Why check this here?

I can move it down along with len check for scheduling work on CPU0 
protected by CPU hotplug lock.

>> +		/*
>> +		 * If the FIFO was empty, there may be characters in the DCC
>> +		 * that we haven't read yet.  Schedule a workqueue to fill
>> +		 * the input FIFO, so that the next time this function is
>> +		 * called, we'll have data.
>> +		 */
>> +		if (!len)
>> +			schedule_work_on(0, &dcc_gwork);
> What happened if the cpu went offline between checking and doing this
> call?

We will need to use CPU hotplug lock here.

> thanks,
>
> greg k-h

Thanks,
Sai
