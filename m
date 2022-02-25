Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38754C3F19
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiBYHha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiBYHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:37:27 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0411AEF0A;
        Thu, 24 Feb 2022 23:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645774615; x=1677310615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KCskv1w22hj0gLP7vINQmo/MIRAACxuvRN4z4n3BQEY=;
  b=SOrXuq6fK1ktnJjhigeeiOdlWTjm+2nPPJvt+oX9N+Nfn5t5PZk/qLtT
   IsjAq3Qs6crjjtYkmHdY0ksxUlVDzeZG3t/415FK0V6FkB0R/5xpIAL2Y
   IIhOj0dvvfReUh+6YKC9CFLHPdWSpg0yHc5P2iy+TiIPYhJNu1z0jzbth
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Feb 2022 23:36:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 23:36:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 23:36:54 -0800
Received: from [10.50.41.45] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 24 Feb
 2022 23:36:51 -0800
Message-ID: <04907d26-db69-7d2d-ec05-59e7164b429e@quicinc.com>
Date:   Fri, 25 Feb 2022 13:06:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv5] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Shanker Donthineni" <shankerd@codeaurora.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>
References: <20220214031322.7498-1-quic_saipraka@quicinc.com>
 <YhPbhZTtf1/4l6/I@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YhPbhZTtf1/4l6/I@kroah.com>
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

Hi,

On 2/22/2022 12:05 AM, Greg Kroah-Hartman wrote:
> On Mon, Feb 14, 2022 at 08:43:22AM +0530, Sai Prakash Ranjan wrote:
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
>> Changes in v5:
>>   * Use get_cpu() and put_cpu() for CPU id check in preemptible context.
>>   * Revert back to build time Kconfig.
> Why did you do this?  Why would you provide the option to not do this?
>
> Either it works properly or not at all.

Huh? I don't understand what you mean here. This config is for the feature and not a
hack around for non-working case. It is just like any other configs which are available
throughout kernel for new features, what different thing are you seeing exactly?

I have explained why device attribute like device tree property is not suitable in [1], if you
insist then we can add Rob Herring and apparently as per your comment in previous
version, we are not in 1990s to use module param :), so what other options are available to
enable this feature?

[1] https://lore.kernel.org/lkml/2866a87b-d1d2-7e9e-57d6-fdcfcd62e27e@quicinc.com/

>
>>   * Remove unnecessary hotplug locks, they result in sleeping in atomic context bugs.
> Are you sure you can remove the locks?

Please see below.

>
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
>>   drivers/tty/hvc/hvc_dcc.c | 171 +++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 188 insertions(+), 3 deletions(-)
>>
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
>> +
>>   config HVC_RISCV_SBI
>>   	bool "RISC-V SBI console support"
>>   	depends on RISCV_SBI_V01
>> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
>> index 8e0edb7d93fd..6144135c24ed 100644
>> --- a/drivers/tty/hvc/hvc_dcc.c
>> +++ b/drivers/tty/hvc/hvc_dcc.c
>> @@ -2,9 +2,13 @@
>>   /* Copyright (c) 2010, 2014 The Linux Foundation. All rights reserved.  */
>>   
>>   #include <linux/console.h>
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
>> @@ -15,6 +19,15 @@
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
>> @@ -67,24 +80,176 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
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
>> +		 * No hotplug lock required as we are in atomic context
>> +		 * with interrupts and preemption disabled.
>> +		 */
>> +		if (cpu_online(0))
>> +			schedule_work_on(0, &dcc_pwork);
> Why is put_chars always called from atomic context?  Where is that
> documented?

It is called from vprintk_emit->console_unlock() which I believe runs in atomic context, see below stack trace.

[   68.804747] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49
[   68.804752] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1, name: swapper/0
[   68.804757] preempt_count: 1, expected: 0
[   68.804794] Preemption disabled at:
[   68.804796] [<ffffa9d50eb198fc>] vprintk_emit+0xc4/0x2e0
[   68.804802] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G W         5.17.0-rc3-next-20220210-00001-g682663ac97d4-dirty #20
[   68.804810] Call trace:
[   68.804812]  dump_backtrace.part.6+0xd8/0xe8
[   68.804820]  show_stack+0x14/0x60
[   68.804827]  dump_stack_lvl+0x88/0xb0
[   68.804831]  dump_stack+0x14/0x2c
[   68.804836]  __might_resched+0x21c/0x268
[   68.804840]  __might_sleep+0x44/0x78
[   68.804844]  cpus_read_lock+0x20/0x168
[   68.804848]  hvc_dcc0_put_chars+0x6c/0x110
[   68.804852]  hvc_console_print+0x144/0x1d8
[   68.804857]  console_unlock+0x2d8/0x5f8
[   68.804862]  vprintk_emit+0xd0/0x2e0
[   68.804867]  vprintk_default+0x30/0x38
[   68.804871]  vprintk+0xcc/0xe8
[   68.804876]  _printk+0x64/0x84

> And that really will prevent another cpu from going offline after this
> call has been checked?
>

I wasn't able to find any hotplug lock which can be used in atomic context, do you
have any idea?

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
>> +		 * called, we'll have data. No hotplug lock required as we are
>> +		 * in atomic context with interrupts and preemption disabled.
>> +		 */
>> +		if (!len && cpu_online(0))
>> +			schedule_work_on(0, &dcc_gwork);
> get_chars is in atomic context?  Even from the poll_get_char() callback?
>
>

 From __hvc_poll(), see below stack trace:

[   22.503594] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49
[   22.503634] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 49, name: khvcd
[   22.503659] preempt_count: 1, expected: 0
[   22.503677] RCU nest depth: 0, expected: 0
[   22.503701] 2 locks held by khvcd/49:
[   22.835450]  #0: ffffcbfe39f05868 (hvc_structs_mutex){+.+.}-{3:3}, at: khvcd+0x94/0x180
[   22.835513]  #1: ffff44a5026723b0 (&hp->lock){....}-{2:2}, at: __hvc_poll+0x218/0x370
[   23.477496] Preemption disabled at:
[   23.477502] [<ffffcbfe38269540>] __hvc_poll+0x218/0x370
[   23.602048] CPU: 1 PID: 49 Comm: khvcd Tainted: G W         5.17.0-rc3-next-20220210-00001-ga7a30b39bb99-dirty #33
[   23.602100] Call trace:
[   23.602115]  dump_backtrace.part.6+0xd8/0xe8
[   23.602140]  show_stack+0x14/0x60
[   23.602160]  dump_stack_lvl+0x98/0xd0
[   23.602181]  dump_stack+0x14/0x2c
[   23.602200]  __might_resched+0x21c/0x268
[   23.602221]  __might_sleep+0x44/0x78
[   23.602240]  cpus_read_lock+0x20/0x168
[   23.602259]  hvc_dcc0_get_chars+0x70/0x128
[   23.602278]  __hvc_poll+0x104/0x370
[   23.602297]  khvcd+0xb8/0x180
[   23.602316]  kthread+0xec/0x110
[   23.602338]  ret_from_fork+0x10/0x20


Thanks,
Sai
