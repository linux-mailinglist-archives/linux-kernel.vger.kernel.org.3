Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622204B1372
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiBJQtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:49:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiBJQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:49:34 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF1BF9;
        Thu, 10 Feb 2022 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644511775; x=1676047775;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XFTz7D6gnwARd2VsLzxYNL+mypNZoPXHjFE83pC5u1Y=;
  b=nXmCKMd91GvOPkjcAJYPHMmdRcCJdcShl5s701gKIVI7kmTV+U6qInek
   cXQVni/AdMdhs61xaXMZyxa2rW0Fd9qHaIo5vwVLHpf3TeGmo88ji9owT
   YK7V0yP0RYo6P8nl9kEJnmY6BCt+W4dABRNvuxqc9Z3wD7nRqXVNF95O0
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Feb 2022 08:49:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 08:49:34 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 08:49:33 -0800
Received: from [10.50.12.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 10 Feb
 2022 08:49:30 -0800
Message-ID: <2866a87b-d1d2-7e9e-57d6-fdcfcd62e27e@quicinc.com>
Date:   Thu, 10 Feb 2022 22:19:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv4] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shanker Donthineni" <shankerd@codeaurora.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>
References: <20220210135632.24638-1-quic_saipraka@quicinc.com>
 <YgUgG/rjIGEvB8pB@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YgUgG/rjIGEvB8pB@kroah.com>
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

Hi,

On 2/10/2022 7:54 PM, Greg Kroah-Hartman wrote:
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
>> Changes in v4:
>>   * Use module parameter for runtime choice of enabling this feature.
> No, this is not the 1990's, module parameters do not work and are not
> sustainable.  They operate on a code-level while you are modifying a
> device-specific attribute here.  Please make this per-device if you
> really want to be able to somehow turn this on or off.

Can you please explain how is this a device-specific thing? I guess you 
mean something like a device
tree property but that is not what it is used for, it is for hardware 
description of a device and this is not a
HW description but a software feature. Arch information such as DCC 
existing only on ARM64 is already
implied in Kconfig when this driver was merged before. Anyone with an 
ARM64 device with DCC can use
this feature. So anyone be it Mediatek, Qualcomm or any others can use 
this and there is nothing device
specific here. We need something on code level which is why the earlier 
version had build time Kconfig but
you mentioned something about runtime choice, so I modified to use 
module parameter. I will move back
to build time configuration for next version unless you have something 
else in mind when you mean a
runtime choice?

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
> Why these random sizes?  Why is one bigger than the other?  Why are they
> these specific numbers?

These are input and output kfifo sizes, it is a software construct and 
there is no specification as such.
As per kfifo documentation, size must be a power of 2. As for the sizes, 
IN_BUF size is less assuming
that amount of input data (RX) is usually less when compared to the 
output data (TX ) on the DCC console.
For ex, during boot the output kernel logs on the DCC console would be 
more than the input.
Given DCC console is very slow, we wouldn't want to make the sizes too 
large, hence 1024.
This configuration is well tested for years now and I would like to keep 
these numbers unless someone
else comes with some issue with these sizes.

>> +
>> +static DEFINE_SPINLOCK(dcc_lock);
> What is this locking?  Please document it (didn't checkpatch complain?)

Sure, I will document this and no checkpatch doesn't complain even with 
--strict option.


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
> Why are you checking smp_processor_id()?  Are you sure it is safe to do
> that here?

It is to check for non-zero CPU core as mentioned in the comment above 
the check.
On safety, thanks for that, I guess you meant about calling 
smp_processor_id() in preemptible
context bug, so I tested with CONFIG_DEBUG_PREEMPT=y and that is a 
premptible section
and makes my system unbootable. I'll use proper get_cpu() and put_cpu() 
around this check.

>
>
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
> That's a hard busy loop, are you sure it will always exit?

How? Nothing is changed there from before except setting a variable and 
the loop never checks
for that variable.

Thanks,
Sai
