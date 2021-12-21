Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAE247BBE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhLUIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhLUIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:31:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C1DC061574;
        Tue, 21 Dec 2021 00:31:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70816B80E07;
        Tue, 21 Dec 2021 08:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD66C36AE2;
        Tue, 21 Dec 2021 08:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640075506;
        bh=60FSywWzdYsHJHMdx2FttrIaMi3V98PGqVc2kPOJQA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R48sImFtLDh4jETSb+Wnb9zOI8Ujh24+g2cMtqjfAPolHCvkYl0amyx95HZ2UPPUA
         mFMH8fyiKR5sj9MbmUO67WQgisy20cme3S9+XAK4Jz+c/yYnTLrzCJyT3uK5KpIN/H
         ns/WQmeG+Ei/X0HnioACBJDuDjouB3zc1Xyaa5R0=
Date:   Tue, 21 Dec 2021 09:31:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_eberman@quicinc.com,
        quic_tsoni@quicinc.com,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>
Subject: Re: [PATCHv3] tty: hvc: dcc: Bind driver to core0 for reads and
 writes
Message-ID: <YcGQ72wQB1CLkvur@kroah.com>
References: <20211213141013.21464-1-quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213141013.21464-1-quic_saipraka@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 07:40:13PM +0530, Sai Prakash Ranjan wrote:
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
> Changes in v3:
>  * Handle case where core0 is not online.
> 
> Changes in v2:
>  * Checkpatch warning fixes.
>  * Use of IS_ENABLED macros instead of ifdefs.
> 
> ---
>  drivers/tty/hvc/Kconfig   |  20 +++++
>  drivers/tty/hvc/hvc_dcc.c | 161 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 180 insertions(+), 1 deletion(-)

What has changed in the kernel in the past decade that this is suddenly
an issue?  Why can't userspace debuggers handle this today, merging all
of the data from different cores together?

And why does this have to be a build-time option and not a runtime
choice?  How are you going to build a universal kernel that works for
both types of systems?

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

So this drops down to only one device, not multiple ones?  Or is it the
other way around?

> +
>  config HVC_RISCV_SBI
>  	bool "RISC-V SBI console support"
>  	depends on RISCV_SBI_V01
> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index 8e0edb7d93fd..24e3770219bc 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c
> @@ -2,9 +2,12 @@
>  /* Copyright (c) 2010, 2014 The Linux Foundation. All rights reserved.  */
>  
>  #include <linux/console.h>
> +#include <linux/cpumask.h>
>  #include <linux/init.h>
> +#include <linux/kfifo.h>
>  #include <linux/serial.h>
>  #include <linux/serial_core.h>
> +#include <linux/spinlock.h>
>  
>  #include <asm/dcc.h>
>  #include <asm/processor.h>
> @@ -67,26 +70,182 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
>  	return i;
>  }
>  
> +/*
> + * Check if the DCC is enabled.  If CONFIG_HVC_DCC_SERIALIZE_SMP is enabled,
> + * then we assume then this function will be called first on core 0.  That
> + * way, dcc_core0_available will be true only if it's available on core 0.
> + */
>  static bool hvc_dcc_check(void)
>  {
>  	unsigned long time = jiffies + (HZ / 10);
> +	static bool dcc_core0_available;
> +
> +	/*
> +	 * If we're not on core 0, but we previously confirmed that DCC is
> +	 * active, then just return true.

Why?  Don't you want to see if DCC works on the other cores?

What if core 0 is never enabled?

> +	 */
> +	if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP) && smp_processor_id() &&
> +	    dcc_core0_available)
> +		return true;
>  
>  	/* Write a test character to check if it is handled */
>  	__dcc_putchar('\n');
>  
>  	while (time_is_after_jiffies(time)) {
> -		if (!(__dcc_getstatus() & DCC_STATUS_TX))
> +		if (!(__dcc_getstatus() & DCC_STATUS_TX)) {
> +			if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP))

Why this check again?

> +				dcc_core0_available = true;
>  			return true;
> +		}
>  	}



>  
>  	return false;
>  }
>  
> +#if defined(CONFIG_HVC_DCC_SERIALIZE_SMP)

No ifdefs in .c files please.  Make this a separate .c file entirely if
this really is needed.

> +
> +static void dcc_put_work_fn(struct work_struct *work);
> +static void dcc_get_work_fn(struct work_struct *work);
> +static DECLARE_WORK(dcc_pwork, dcc_put_work_fn);
> +static DECLARE_WORK(dcc_gwork, dcc_get_work_fn);

No need to put "fn" at the end of your function name, we know it's a
function :)

> +static DEFINE_SPINLOCK(dcc_lock);
> +static DEFINE_KFIFO(inbuf, unsigned char, 128);
> +static DEFINE_KFIFO(outbuf, unsigned char, 1024);

Where did these size values come from?

> +
> +/*
> + * Workqueue function that writes the output FIFO to the DCC on core 0.
> + */
> +static void dcc_put_work_fn(struct work_struct *work)
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

Why is this needed?  Will not the normal input handling deal with this?

> +	}
> +
> +	spin_unlock_irqrestore(&dcc_lock, irqflags);
> +}
> +
> +/*
> + * Workqueue function that reads characters from DCC and puts them into the
> + * input FIFO.
> + */
> +static void dcc_get_work_fn(struct work_struct *work)
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
> +/*
> + * Write characters directly to the DCC if we're on core 0 and the FIFO
> + * is empty, or write them to the FIFO if we're not.
> + */
> +static int hvc_dcc0_put_chars(u32 vt, const char *buf, int count)
> +{
> +	int len;
> +	unsigned long irqflags;
> +
> +	spin_lock_irqsave(&dcc_lock, irqflags);
> +	if (smp_processor_id() || (!kfifo_is_empty(&outbuf))) {
> +		len = kfifo_in(&outbuf, buf, count);
> +		spin_unlock_irqrestore(&dcc_lock, irqflags);
> +
> +		if (!cpu_online(0))
> +			return 0;
> +		/*
> +		 * We just push data to the output FIFO, so schedule the
> +		 * workqueue that will actually write that data to DCC.
> +		 */
> +		schedule_work_on(0, &dcc_pwork);
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
> +	spin_lock_irqsave(&dcc_lock, irqflags);
> +
> +	if (smp_processor_id() || (!kfifo_is_empty(&inbuf))) {
> +		len = kfifo_out(&inbuf, buf, count);
> +		spin_unlock_irqrestore(&dcc_lock, irqflags);
> +
> +		if (!cpu_online(0))
> +			return 0;

Why check this here?

> +		/*
> +		 * If the FIFO was empty, there may be characters in the DCC
> +		 * that we haven't read yet.  Schedule a workqueue to fill
> +		 * the input FIFO, so that the next time this function is
> +		 * called, we'll have data.
> +		 */
> +		if (!len)
> +			schedule_work_on(0, &dcc_gwork);

What happened if the cpu went offline between checking and doing this
call?

thanks,

greg k-h
