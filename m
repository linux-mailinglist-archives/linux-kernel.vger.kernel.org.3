Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62A529D11
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbiEQI57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbiEQI5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:57:08 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AB912ACC;
        Tue, 17 May 2022 01:57:07 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24H6ehTU014061;
        Tue, 17 May 2022 10:56:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=NFkSiXvk9GeH0y6id+39wV1HHzqLZwH5JZ5X47VuFQs=;
 b=Sw6zuW7U2QLFAgPcGmuguFRvRlsQG4SHf5B1trNsqp6tRzu5sf/iHAxdxRd2VMT00QzR
 xqWm3+U73dYKoGrkccH+PSAw4aZdmjNcOlsyQY2AP3yfMcts+yg5tA6vlBvXFmWsdoCr
 dsqWMkTKAaoVIjbTtxa+jwGNwXOW2JYUsqhzeTEyWyzhAvb/idoRrWozhyFv/9tG5c7l
 VM3+gG1MpMxWshzzDOixrTT778pxG1ZyifDqc8HW3yOfTrhyjNSkCbpKUtAVYduwq4jm
 Hn6WfUNa0KpXZRMoFJLNQ97iRJmVxZEJAn2YN0RklRfQOoR2Q3J44RLMD575r3ytTxR9 jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23ahgnun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:56:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BD21F10002A;
        Tue, 17 May 2022 10:56:43 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B35F4214D1B;
        Tue, 17 May 2022 10:56:43 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 17 May
 2022 10:56:43 +0200
Message-ID: <bd36b061-9838-868e-d8c6-c7d1b01ea4ab@foss.st.com>
Date:   Tue, 17 May 2022 10:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] iio: adc: stm32: Fix IRQs on STM32F4 by removing
 custom spurious IRQs message
Content-Language: en-US
To:     Yannick Brosseau <yannick.brosseau@gmail.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <olivier.moysan@foss.st.com>
CC:     <paul@crapouillou.net>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220516203939.3498673-1-yannick.brosseau@gmail.com>
 <20220516203939.3498673-3-yannick.brosseau@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20220516203939.3498673-3-yannick.brosseau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_01,2022-05-16_02,2022-02-23_01
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 22:39, Yannick Brosseau wrote:
> The check for spurious IRQs introduced in 695e2f5c289bb assumed that the bits
> in the control and status registers are aligned. This is true for the H7 and MP1
> version, but not the F4. The interrupt was then never handled on the F4.
> 
> Instead of increasing the complexity of the comparison and check each bit specifically,
> we remove this check completely and rely on the generic handler for spurious IRQs.
> 
> Fixes: 695e2f5c289b ("iio: adc: stm32-adc: fix a regression when using dma and irq")
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>

Hi Yannick,

Feel free to add my:

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> ---
>  drivers/iio/adc/stm32-adc.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index a68ecbda6480..8c5f05f593ab 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1407,7 +1407,6 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	const struct stm32_adc_regspec *regs = adc->cfg->regs;
>  	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
> -	u32 mask = stm32_adc_readl(adc, regs->ier_eoc.reg);
>  
>  	/* Check ovr status right now, as ovr mask should be already disabled */
>  	if (status & regs->isr_ovr.mask) {
> @@ -1422,11 +1421,6 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
>  		return IRQ_HANDLED;
>  	}
>  
> -	if (!(status & mask))
> -		dev_err_ratelimited(&indio_dev->dev,
> -				    "Unexpected IRQ: IER=0x%08x, ISR=0x%08x\n",
> -				    mask, status);
> -
>  	return IRQ_NONE;
>  }
>  
> @@ -1436,10 +1430,6 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	const struct stm32_adc_regspec *regs = adc->cfg->regs;
>  	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
> -	u32 mask = stm32_adc_readl(adc, regs->ier_eoc.reg);
> -
> -	if (!(status & mask))
> -		return IRQ_WAKE_THREAD;
>  
>  	if (status & regs->isr_ovr.mask) {
>  		/*
