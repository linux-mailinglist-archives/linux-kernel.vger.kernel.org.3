Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3A3502588
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350423AbiDOG1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350458AbiDOG1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:27:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF750456;
        Thu, 14 Apr 2022 23:25:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95DD1B8282C;
        Fri, 15 Apr 2022 06:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44CEC385A5;
        Fri, 15 Apr 2022 06:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650003905;
        bh=9somcnQvWkyycNoN1ADACuIY2DPS8FNvFNEFHfqU6To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ucvt0KzlhA+G4Na6BsxEv7AGZExI9Gbmr5OBxD9oeZ/uS4Dvf/76i3aScCMxJ8oPI
         DLaD998xvOsxIb5kJzcFjXdmLeENoLKohf2FySOBq2OMlXG3B68FlfVSydcE3B42f7
         epy6cFcfmSMk3aYROsd6U7bEB0bZqi4ONut2VQcM=
Date:   Fri, 15 Apr 2022 08:25:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>
Subject: Re: [PATCHv6] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Message-ID: <YlkPvnBYzJo9aeZ2@kroah.com>
References: <20220310032636.7286-1-quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310032636.7286-1-quic_saipraka@quicinc.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,THIS_AD,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 08:56:36AM +0530, Sai Prakash Ranjan wrote:
> From: Shanker Donthineni <shankerd@codeaurora.org>
> 
> Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
> reads/writes from/to DCC on secondary cores. Each core has its
> own DCC device registers, so when a core reads or writes from/to DCC,
> it only accesses its own DCC device. Since kernel code can run on
> any core, every time the kernel wants to write to the console, it
> might write to a different DCC.
> 
> In SMP mode, Trace32 creates multiple windows, and each window shows
> the DCC output only from that core's DCC. The result is that console
> output is either lost or scattered across windows.
> 
> Selecting this option will enable code that serializes all console
> input and output to core 0. The DCC driver will create input and
> output FIFOs that all cores will use. Reads and writes from/to DCC
> are handled by a workqueue that runs only core 0.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Acked-by: Adam Wallis <awallis@codeaurora.org>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
> 
> Changes in v6:
>  * Disable CPU hotplug when CONFIG_HVC_DCC_SERIALIZE_SMP=y.
> 
> Changes in v5:
>  * Use get_cpu() and put_cpu() for CPU id check in preemptible context.
>  * Revert back to build time Kconfig.
>  * Remove unnecessary hotplug locks, they result in sleeping in atomic context bugs.
>  * Add a comment for the spinlock.
> 
> Changes in v4:
>  * Use module parameter for runtime choice of enabling this feature.
>  * Use hotplug locks to avoid race between cpu online check and work schedule.
>  * Remove ifdefs and move to common ops.
>  * Remove unnecessary check for this configuration.
>  * Use macros for buf size instead of magic numbers.
>  * v3 - https://lore.kernel.org/lkml/20211213141013.21464-1-quic_saipraka@quicinc.com/
> 
> Changes in v3:
>  * Handle case where core0 is not online.
> 
> Changes in v2:
>  * Checkpatch warning fixes.
>  * Use of IS_ENABLED macros instead of ifdefs.
> 
> ---
>  drivers/tty/hvc/Kconfig   |  20 +++++
>  drivers/tty/hvc/hvc_dcc.c | 175 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 192 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 8d60e0ff67b4..62560cd0c04d 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -87,6 +87,26 @@ config HVC_DCC
>  	  driver. This console is used through a JTAG only on ARM. If you don't have
>  	  a JTAG then you probably don't want this option.
>  
> +config HVC_DCC_SERIALIZE_SMP
> +	bool "Use DCC only on CPU core 0"
> +	depends on SMP && HVC_DCC
> +	help
> +	  Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
> +	  reads/writes from/to DCC on more than one CPU core. Each core has its
> +	  own DCC device registers, so when a CPU core reads or writes from/to
> +	  DCC, it only accesses its own DCC device. Since kernel code can run on
> +	  any CPU core, every time the kernel wants to write to the console, it
> +	  might write to a different DCC.
> +
> +	  In SMP mode, Trace32 creates multiple windows, and each window shows
> +	  the DCC output only from that core's DCC. The result is that console
> +	  output is either lost or scattered across windows.

Why are we documenting, and supporting, a closed source userspace tool
with kernel changes?  Does this advertisement deserve to be in the
kernel source tree?

And why can't they just fix their tool if this is such a big issue?  Why
does this only affect this one platform and not all other smp systems?

> +
> +	  Selecting this option will enable code that serializes all console
> +	  input and output to CPU core 0. The DCC driver will create input and
> +	  output FIFOs that all cores will use. Reads and writes from/to DCC
> +	  are handled by a workqueue that runs only CPU core 0.

No need to describe implementation details in a help text, right?  What
happens when we change this to not be a workqueue?



> +
>  config HVC_RISCV_SBI
>  	bool "RISC-V SBI console support"
>  	depends on RISCV_SBI_V01
> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index 8e0edb7d93fd..e87b82e873d7 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c
> @@ -2,9 +2,14 @@
>  /* Copyright (c) 2010, 2014 The Linux Foundation. All rights reserved.  */

No copyright update?

>  
>  #include <linux/console.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
>  #include <linux/init.h>
> +#include <linux/kfifo.h>
>  #include <linux/serial.h>
>  #include <linux/serial_core.h>
> +#include <linux/smp.h>
> +#include <linux/spinlock.h>
>  
>  #include <asm/dcc.h>
>  #include <asm/processor.h>
> @@ -15,6 +20,15 @@
>  #define DCC_STATUS_RX		(1 << 30)
>  #define DCC_STATUS_TX		(1 << 29)
>  
> +#define DCC_INBUF_SIZE		128
> +#define DCC_OUTBUF_SIZE		1024
> +
> +/* Lock to serialize access to DCC fifo */
> +static DEFINE_SPINLOCK(dcc_lock);
> +
> +static DEFINE_KFIFO(inbuf, unsigned char, DCC_INBUF_SIZE);
> +static DEFINE_KFIFO(outbuf, unsigned char, DCC_OUTBUF_SIZE);
> +
>  static void dcc_uart_console_putchar(struct uart_port *port, int ch)
>  {
>  	while (__dcc_getstatus() & DCC_STATUS_TX)
> @@ -67,24 +81,176 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
>  	return i;
>  }
>  
> +/*
> + * Check if the DCC is enabled. If CONFIG_HVC_DCC_SERIALIZE_SMP is enabled,
> + * then we assume then this function will be called first on core0. That way,
> + * dcc_core0_available will be true only if it's available on core0.
> + */
>  static bool hvc_dcc_check(void)
>  {
>  	unsigned long time = jiffies + (HZ / 10);
> +	static bool dcc_core0_available;
> +
> +	/*
> +	 * If we're not on core 0, but we previously confirmed that DCC is
> +	 * active, then just return true.
> +	 */
> +	int cpu = get_cpu();
> +
> +	if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP) && cpu && dcc_core0_available) {
> +		put_cpu();
> +		return true;
> +	}
> +
> +	put_cpu();
>  
>  	/* Write a test character to check if it is handled */
>  	__dcc_putchar('\n');
>  
>  	while (time_is_after_jiffies(time)) {
> -		if (!(__dcc_getstatus() & DCC_STATUS_TX))
> +		if (!(__dcc_getstatus() & DCC_STATUS_TX)) {
> +			dcc_core0_available = true;
>  			return true;
> +		}
>  	}
>  
>  	return false;
>  }
>  
> +/*
> + * Workqueue function that writes the output FIFO to the DCC on core 0.
> + */
> +static void dcc_put_work(struct work_struct *work)
> +{
> +	unsigned char ch;
> +	unsigned long irqflags;
> +
> +	spin_lock_irqsave(&dcc_lock, irqflags);
> +
> +	/* While there's data in the output FIFO, write it to the DCC */
> +	while (kfifo_get(&outbuf, &ch))
> +		hvc_dcc_put_chars(0, &ch, 1);
> +
> +	/* While we're at it, check for any input characters */
> +	while (!kfifo_is_full(&inbuf)) {
> +		if (!hvc_dcc_get_chars(0, &ch, 1))
> +			break;
> +		kfifo_put(&inbuf, ch);
> +	}
> +
> +	spin_unlock_irqrestore(&dcc_lock, irqflags);
> +}
> +
> +static DECLARE_WORK(dcc_pwork, dcc_put_work);
> +
> +/*
> + * Workqueue function that reads characters from DCC and puts them into the
> + * input FIFO.
> + */
> +static void dcc_get_work(struct work_struct *work)
> +{
> +	unsigned char ch;
> +	unsigned long irqflags;
> +
> +	/*
> +	 * Read characters from DCC and put them into the input FIFO, as
> +	 * long as there is room and we have characters to read.
> +	 */
> +	spin_lock_irqsave(&dcc_lock, irqflags);
> +
> +	while (!kfifo_is_full(&inbuf)) {
> +		if (!hvc_dcc_get_chars(0, &ch, 1))
> +			break;
> +		kfifo_put(&inbuf, ch);
> +	}
> +	spin_unlock_irqrestore(&dcc_lock, irqflags);
> +}
> +
> +static DECLARE_WORK(dcc_gwork, dcc_get_work);
> +
> +/*
> + * Write characters directly to the DCC if we're on core 0 and the FIFO
> + * is empty, or write them to the FIFO if we're not.
> + */
> +static int hvc_dcc0_put_chars(u32 vt, const char *buf, int count)
> +{
> +	int len;
> +	unsigned long irqflags;
> +
> +	if (!IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))
> +		return hvc_dcc_put_chars(vt, buf, count);
> +
> +	spin_lock_irqsave(&dcc_lock, irqflags);
> +	if (smp_processor_id() || (!kfifo_is_empty(&outbuf))) {
> +		len = kfifo_in(&outbuf, buf, count);
> +		spin_unlock_irqrestore(&dcc_lock, irqflags);
> +
> +		/*
> +		 * We just push data to the output FIFO, so schedule the
> +		 * workqueue that will actually write that data to DCC.
> +		 * CPU hotplug is disabled so CPU0 cannot be offlined
> +		 * after the cpu online check.

How is cpu hotplug disabled here?

> +		 */
> +		if (cpu_online(0))

What happens if the cpu state changes right after checking it?

> +			schedule_work_on(0, &dcc_pwork);

What happens if cpu 0 never comes back?

> +
> +		return len;
> +	}
> +
> +	/*
> +	 * If we're already on core 0, and the FIFO is empty, then just
> +	 * write the data to DCC.
> +	 */
> +	len = hvc_dcc_put_chars(vt, buf, count);
> +	spin_unlock_irqrestore(&dcc_lock, irqflags);
> +
> +	return len;
> +}
> +
> +/*
> + * Read characters directly from the DCC if we're on core 0 and the FIFO
> + * is empty, or read them from the FIFO if we're not.
> + */
> +static int hvc_dcc0_get_chars(u32 vt, char *buf, int count)
> +{
> +	int len;
> +	unsigned long irqflags;
> +
> +	if (!IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))
> +		return hvc_dcc_get_chars(vt, buf, count);
> +
> +	spin_lock_irqsave(&dcc_lock, irqflags);
> +
> +	if (smp_processor_id() || (!kfifo_is_empty(&inbuf))) {
> +		len = kfifo_out(&inbuf, buf, count);
> +		spin_unlock_irqrestore(&dcc_lock, irqflags);
> +
> +		/*
> +		 * If the FIFO was empty, there may be characters in the DCC
> +		 * that we haven't read yet.  Schedule a workqueue to fill
> +		 * the input FIFO, so that the next time this function is
> +		 * called, we'll have data. CPU hotplug is disabled so CPU0
> +		 * cannot be offlined after the cpu online check.

Again, how is cpu hotplug disabled?

> +		 */
> +		if (!len && cpu_online(0))
> +			schedule_work_on(0, &dcc_gwork);
> +
> +		return len;
> +	}
> +
> +	/*
> +	 * If we're already on core 0, and the FIFO is empty, then just
> +	 * read the data from DCC.
> +	 */
> +	len = hvc_dcc_get_chars(vt, buf, count);
> +	spin_unlock_irqrestore(&dcc_lock, irqflags);
> +
> +	return len;
> +}
> +
>  static const struct hv_ops hvc_dcc_get_put_ops = {
> -	.get_chars = hvc_dcc_get_chars,
> -	.put_chars = hvc_dcc_put_chars,
> +	.get_chars = hvc_dcc0_get_chars,
> +	.put_chars = hvc_dcc0_put_chars,
>  };
>  
>  static int __init hvc_dcc_console_init(void)
> @@ -108,6 +274,9 @@ static int __init hvc_dcc_init(void)
>  	if (!hvc_dcc_check())
>  		return -ENODEV;
>  
> +	if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))
> +		cpu_hotplug_disable();

Ah.  And you never enable it again?  This feels very very wrong.  Did
you just ensure that you can never use this option in a real system?

For this reason alone I can't take this change, as you just increased
the power consumption of any system with this enabled :(

greg k-h
