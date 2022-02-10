Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257B94B1050
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbiBJOYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:24:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiBJOYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:24:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEF021B;
        Thu, 10 Feb 2022 06:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BF4CB8242B;
        Thu, 10 Feb 2022 14:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136FBC004E1;
        Thu, 10 Feb 2022 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644503070;
        bh=vlIFPYvkjSkOpL2HPlt0rUGcV+Ocy5LzZaD62R1oaS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qnchhmCVQZ6NnnxeaYiw/Ou2N+c77xr6j1hxt35A8TA/DycP5FN/In/sgxdJBdD3J
         j2JSx80DKyvmgHCpV0A0eggRepPZ/fGmd5Cqr6LWGt2AOVDQz9sbQZUvdZxxcFqruR
         VImkB79OFFqH0pcI+wKyMET+zE+u7uUmCopaCwro=
Date:   Thu, 10 Feb 2022 15:24:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>
Subject: Re: [PATCHv4] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Message-ID: <YgUgG/rjIGEvB8pB@kroah.com>
References: <20220210135632.24638-1-quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210135632.24638-1-quic_saipraka@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 07:26:32PM +0530, Sai Prakash Ranjan wrote:
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
> Changes in v4:
>  * Use module parameter for runtime choice of enabling this feature.

No, this is not the 1990's, module parameters do not work and are not
sustainable.  They operate on a code-level while you are modifying a
device-specific attribute here.  Please make this per-device if you
really want to be able to somehow turn this on or off.

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
>  drivers/tty/hvc/hvc_dcc.c | 177 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 174 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index 8e0edb7d93fd..535b09441e55 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c
> @@ -2,19 +2,35 @@
>  /* Copyright (c) 2010, 2014 The Linux Foundation. All rights reserved.  */
>  
>  #include <linux/console.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
>  #include <linux/init.h>
> +#include <linux/kfifo.h>
> +#include <linux/moduleparam.h>
>  #include <linux/serial.h>
>  #include <linux/serial_core.h>
> +#include <linux/spinlock.h>
>  
>  #include <asm/dcc.h>
>  #include <asm/processor.h>
>  
>  #include "hvc_console.h"
>  
> +static bool serialize_smp;
> +module_param(serialize_smp, bool, 0444);
> +MODULE_PARM_DESC(serialize_smp, "Serialize all DCC console input and output to CPU core 0");
> +
>  /* DCC Status Bits */
>  #define DCC_STATUS_RX		(1 << 30)
>  #define DCC_STATUS_TX		(1 << 29)
>  
> +#define DCC_INBUF_SIZE		128
> +#define DCC_OUTBUF_SIZE		1024

Why these random sizes?  Why is one bigger than the other?  Why are they
these specific numbers?

> +
> +static DEFINE_SPINLOCK(dcc_lock);

What is this locking?  Please document it (didn't checkpatch complain?)

> +static DEFINE_KFIFO(inbuf, unsigned char, DCC_INBUF_SIZE);
> +static DEFINE_KFIFO(outbuf, unsigned char, DCC_OUTBUF_SIZE);
> +
>  static void dcc_uart_console_putchar(struct uart_port *port, int ch)
>  {
>  	while (__dcc_getstatus() & DCC_STATUS_TX)
> @@ -67,24 +83,179 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
>  	return i;
>  }
>  
> +/*
> + * Check if the DCC is enabled. If serialize_smp module param is enabled,
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
> +	if (serialize_smp && smp_processor_id() && dcc_core0_available)

Why are you checking smp_processor_id()?  Are you sure it is safe to do
that here?



> +		return true;
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

That's a hard busy loop, are you sure it will always exit?

thanks,

greg k-h
