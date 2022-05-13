Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280FD5262B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380603AbiEMNO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiEMNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:14:24 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576E56767;
        Fri, 13 May 2022 06:14:23 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24D9bGVa024730;
        Fri, 13 May 2022 15:13:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=IzNl3ypvVSCffY9EMumhPtUXRrFQRfuRQsI8WhiD7Bs=;
 b=R9br9S/jj1VNI29zac5haQIXRO7ozP7dOi0w7TqvuXYAN1GirwpWnpRiRnZyEObZdkZy
 eatXHagoKmbDH9F7cOuBvO2R60dtcRAuyyxUdBkx073bI7Eu5tqKUNHGND2+xJQtLSfn
 hVL+fqNg0atIWAeAl9fjmDIDJfq7v38RpD4OdAIwOW09tUF1dCuqRC8KbYm9oCg59XxO
 a3YDRIX6DwZQfe69c8QlI0vWrPd+9v75OPbQRyHcM8CuS+LjZXyAY69Q3euG7oUDCJLi
 uG+T+QGc3OoFGmd5TlM17AF2H2RK3jJ0G/WCkwBb96i0vWSp+cma2ZX3rotUKF+XBobv Lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g1mv1s9xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 15:13:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED03210002A;
        Fri, 13 May 2022 15:13:54 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E59E421ED55;
        Fri, 13 May 2022 15:13:54 +0200 (CEST)
Received: from [10.252.23.200] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 13 May
 2022 15:13:53 +0200
Message-ID: <32a7849b-c631-f80d-b29c-2a790ac641ec@foss.st.com>
Date:   Fri, 13 May 2022 15:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] iio: adc: stm32: Fix check for spurious IRQs on
 STM32F4
Content-Language: en-US
To:     Yannick Brosseau <yannick.brosseau@gmail.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <olivier.moysan@foss.st.com>
CC:     <paul@crapouillou.net>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220506225617.1774604-1-yannick.brosseau@gmail.com>
 <20220506225617.1774604-3-yannick.brosseau@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20220506225617.1774604-3-yannick.brosseau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/22 00:56, Yannick Brosseau wrote:
> The check for spurious IRQs introduced in 695e2f5c289bb assumed that the bits
> in the control and status registers are aligned. This is true for the H7 and MP1
> version, but not the F4.
> 
> Instead of comparing both registers bitwise, we check the bit in the status and control
> for each interrupt we are interested in.
> 

Hi Yannick,

I propose a different approach, see here after.

Same as for patch one,
Fixes: 695e2f5c289b ("iio: adc: stm32-adc: fix a regression when using
dma and irq")

> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> ---
>  drivers/iio/adc/stm32-adc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index a68ecbda6480..5b0f138333ee 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1422,9 +1422,10 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
>  		return IRQ_HANDLED;
>  	}
>  
> -	if (!(status & mask))
> +	if(!((status & regs->isr_eoc.mask) && (mask & regs->ier_eoc.mask)) ||
> +           ((status & regs->isr_ovr.mask) && (mask & regs->ier_ovr.mask)))
>  		dev_err_ratelimited(&indio_dev->dev,
> -				    "Unexpected IRQ: IER=0x%08x, ISR=0x%08x\n",
> +				    "Unexpected IRQ: CR1/IER=0x%08x, SR/ISR=0x%08x\n",
>  				    mask, status);


Here, a slightly different approach could be used... There's a long
pending discussion, where Olivier or I should push further patches to
support threadirqs (hopefully soon).
In this discussion with Jonathan [1], he exposed the need to remove this
message. Words from Jonathan:
"This seems 'unusual'.  If this is a spurious interrupt we should be
returning IRQ_NONE and letting the spurious interrupt protection
stuff kick in."

[1]
https://lore.kernel.org/linux-arm-kernel/20210116175333.4d8684c5@archlinux/

So basically, I suggest to completely get rid of this message:

-	if (!(status & mask))
-		dev_err_ratelimited(&indio_dev->dev,
-				    "Unexpected IRQ: IER=0x%08x, ISR=0x%08x\n",
-				    mask, status);

>  
>  	return IRQ_NONE;
> @@ -1438,7 +1439,9 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
>  	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
>  	u32 mask = stm32_adc_readl(adc, regs->ier_eoc.reg);
>  
> -	if (!(status & mask))
> +	/* Check that we have the interrupt we care about are enabled and active */
> +        if(!((status & regs->isr_eoc.mask) && (mask & regs->ier_eoc.mask)) ||
> +           ((status & regs->isr_ovr.mask) && (mask & regs->ier_ovr.mask)))
>  		return IRQ_WAKE_THREAD;

Here the statement becomes useless, so it could be removed:
-	u32 mask = stm32_adc_readl(adc, regs->ier_eoc.reg);
-
-	if (!(status & mask))
-		return IRQ_WAKE_THREAD;

This would avoid some complexity here (and so headaches or regressions
like the one you've hit).

This also should serve the two purposes:
- fall into kernel generic handler for spurious IRQs (by returning
IRQ_NONE below)
- by the way fix current issue in stm32f4


I Hope this is still inline with Jonathan's words earlier ;-)

Best Regards,
Fabrice

>  
>  	if (status & regs->isr_ovr.mask) {
