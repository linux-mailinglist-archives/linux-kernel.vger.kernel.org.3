Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF64771D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhLPMbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhLPMbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:31:18 -0500
X-Greylist: delayed 1231 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Dec 2021 04:31:18 PST
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50128C061574;
        Thu, 16 Dec 2021 04:31:18 -0800 (PST)
Received: from [81.101.6.87] (port=52570 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxpuh-0005Cz-Dz; Thu, 16 Dec 2021 12:31:11 +0000
Date:   Thu, 16 Dec 2021 12:36:27 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: stmpe-adc: Use correctly sized arguments for bit
 field
Message-ID: <20211216123615.3e311c2b@jic23-huawei>
In-Reply-To: <20211215232513.2070158-1-keescook@chromium.org>
References: <20211215232513.2070158-1-keescook@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 15:25:13 -0800
Kees Cook <keescook@chromium.org> wrote:

> The find.h APIs are designed to be used only on unsigned long arguments.
> This can technically result in a over-read, but it is harmless in this
> case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
> which we'd like to enable globally:
> 
> In file included from ./include/linux/bitmap.h:9,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:22,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:55,
>                  from ./include/linux/swait.h:7,
>                  from ./include/linux/completion.h:12,
>                  from drivers/iio/adc/stmpe-adc.c:10:
> drivers/iio/adc/stmpe-adc.c: In function 'stmpe_adc_probe':
> ./include/linux/find.h:98:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
>    98 |                 val = *addr | ~GENMASK(size - 1, offset);
>       |                       ^~~~~
> drivers/iio/adc/stmpe-adc.c:258:13: note: while referencing 'norequest_mask'
>   258 |         u32 norequest_mask = 0;
>       |             ^~~~~~~~~~~~~~
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to the togreg branch of iio.git and pushed out as testing to let
0-day have a first poke at it.

I took the view this one was trivial, but if anyone else wants to add
tags there will be a few days before this goes out in a form I'm not happy
to rebase.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stmpe-adc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index fba659bfdb40..d2d405388499 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -256,6 +256,7 @@ static int stmpe_adc_probe(struct platform_device *pdev)
>  	struct stmpe_adc *info;
>  	struct device_node *np;
>  	u32 norequest_mask = 0;
> +	unsigned long bits;
>  	int irq_temp, irq_adc;
>  	int num_chan = 0;
>  	int i = 0;
> @@ -309,8 +310,8 @@ static int stmpe_adc_probe(struct platform_device *pdev)
>  
>  	of_property_read_u32(np, "st,norequest-mask", &norequest_mask);
>  
> -	for_each_clear_bit(i, (unsigned long *) &norequest_mask,
> -			   (STMPE_ADC_LAST_NR + 1)) {
> +	bits = norequest_mask;
> +	for_each_clear_bit(i, &bits, (STMPE_ADC_LAST_NR + 1)) {
>  		stmpe_adc_voltage_chan(&info->stmpe_adc_iio_channels[num_chan], i);
>  		num_chan++;
>  	}

