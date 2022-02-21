Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40B4BEA89
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiBUSh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:37:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiBUSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:36:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A01CDE;
        Mon, 21 Feb 2022 10:35:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AECC7B8171E;
        Mon, 21 Feb 2022 18:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1725C340E9;
        Mon, 21 Feb 2022 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645468552;
        bh=G3CJzFus6V7dveT4A6woSe2QF4JQ0FJdn58uV9CbRTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ju5zojroPnCMVbZ08puXhSwIKvi/ZWPosjAWMQy/l79cYqdkpKaTuWwHPC4OZYGMH
         Zm9yIkr0bYC83K5U+5KV+9xRWd/BMikok5Bn+IkRS2JWqXSbg60Fwmz3xO+HUgunpw
         2+5A8HB0ouGQ8SgbosYugsj5bnH/JwU2q8vYFRp0=
Date:   Mon, 21 Feb 2022 19:35:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>
Subject: Re: [PATCHv5] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Message-ID: <YhPbhZTtf1/4l6/I@kroah.com>
References: <20220214031322.7498-1-quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214031322.7498-1-quic_saipraka@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 08:43:22AM +0530, Sai Prakash Ranjan wrote:
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
> Changes in v5:
>  * Use get_cpu() and put_cpu() for CPU id check in preemptible context.
>  * Revert back to build time Kconfig.

Why did you do this?  Why would you provide the option to not do this?

Either it works properly or not at all.

>  * Remove unnecessary hotplug locks, they result in sleeping in atomic context bugs.

Are you sure you can remove the locks?

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
>  drivers/tty/hvc/hvc_dcc.c | 171 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 188 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 8d60e0ff67b4..c0754a2e3fe4 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -87,6 +87,26 @@ config HVC_DCC
>  	  driver. This console is used through a JTAG only on ARM. If you don't have
>  	  a JTAG then you probably don't want this option.
>  
> +config HVC_DCC_SERIALIZE_SMP
> +	bool "Use DCC only on core 0"
> +	depends on SMP && HVC_DCC
> +	help
> +	  Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
> +	  reads/writes from/to DCC on more than one core. Each core has its
> +	  own DCC device registers, so when a core reads or writes from/to DCC,
> +	  it only accesses its own DCC device. Since kernel code can run on
> +	  any core, every time the kernel wants to write to the console, it
> +	  might write to a different DCC.
> +
> +	  In SMP mode, Trace32 creates multiple windows, and each window shows
> +	  the DCC output only from that core's DCC. The result is that console
> +	  output is either lost or scattered across windows.
> +
> +	  Selecting this option will enable code that serializes all console
> +	  input and output to core 0. The DCC driver will create input and
> +	  output FIFOs that all cores will use. Reads and writes from/to DCC
> +	  are handled by a workqueue that runs only core 0.
> +
>  config HVC_RISCV_SBI
>  	bool "RISC-V SBI console support"
>  	depends on RISCV_SBI_V01
> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index 8e0edb7d93fd..6144135c24ed 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c
> @@ -2,9 +2,13 @@
>  /* Copyright (c) 2010, 2014 The Linux Foundation. All rights reserved.  */
>  
>  #include <linux/console.h>
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
> @@ -15,6 +19,15 @@
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
> @@ -67,24 +80,176 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
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
> +		 * No hotplug lock required as we are in atomic context
> +		 * with interrupts and preemption disabled.
> +		 */
> +		if (cpu_online(0))
> +			schedule_work_on(0, &dcc_pwork);

Why is put_chars always called from atomic context?  Where is that
documented?

And that really will prevent another cpu from going offline after this
call has been checked?


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
> +		 * called, we'll have data. No hotplug lock required as we are
> +		 * in atomic context with interrupts and preemption disabled.
> +		 */
> +		if (!len && cpu_online(0))
> +			schedule_work_on(0, &dcc_gwork);

get_chars is in atomic context?  Even from the poll_get_char() callback?

thanks,

greg k-h
