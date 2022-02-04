Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD304A9C25
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359815AbiBDPmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:42:17 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40296 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1359806AbiBDPmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:42:15 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214Ebxgf011945;
        Fri, 4 Feb 2022 16:42:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=1UBZ1HQMJGwj58sI+h9K8wE/T4Yj+VGIcEnThWRmLs0=;
 b=SZHUpTBe91uhtNz4Yw90DSS8oqBMB7FjuBQ8DhYZ5x4JUwaJ0mXFa9k/V/eHMHgjqcdg
 9pRCScPVnSVPxWOa4G3e01SM9nM/NV7UkPf6axX0kh9p/kL8pdN1WtJzUOpM8MKZ69E/
 lI/RdxoXOKTCDXzRQowACfiHc3HtGBwy/UnpJDmWRTbuDYnsNq2ZfxnWLIc5O6TbfVrG
 F8oQ4brpgyz8d5pZUQuO4hAM7z7SY3nZC5e3u9zE5zyXLKngQ08gg+Lp9S2yTxJ+WfCA
 8EagOzRcZ6LLc/Pbc9zpJGr4phBQdsy/zVUM+XECpDRYENAtthnmpjP/3Xhag2sH0+MC SQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e0ejjew8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 16:42:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE4BD10002A;
        Fri,  4 Feb 2022 16:41:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E59B9229A8C;
        Fri,  4 Feb 2022 16:41:59 +0100 (CET)
Received: from lmecxl0566.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 4 Feb
 2022 16:41:59 +0100
Subject: Re: [PATCH 1/2] serial: mctrl_gpio: add a new API to enable / disable
 wake_irq
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220203171644.12231-1-erwan.leray@foss.st.com>
 <20220203171644.12231-2-erwan.leray@foss.st.com>
 <CAHp75VfxGj=3mKvjcRpQjyXBCM0szsidHVuJGdAL8yP5SmdBzw@mail.gmail.com>
From:   Erwan LE RAY <erwan.leray@foss.st.com>
Message-ID: <cb09a49a-37f8-9e3f-168c-4c5dd62e2c07@foss.st.com>
Date:   Fri, 4 Feb 2022 16:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfxGj=3mKvjcRpQjyXBCM0szsidHVuJGdAL8yP5SmdBzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2/4/22 10:07 AM, Andy Shevchenko wrote:
> 
> 
> On Thursday, February 3, 2022, Erwan Le Ray <erwan.leray@foss.st.com 
> <mailto:erwan.leray@foss.st.com>> wrote:
> 
>     Add a new API to enable / disable wake_irq in order to enable gpio
>     irqs as
>     wakeup irqs for the uart port.
> 
>     Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com
>     <mailto:erwan.leray@foss.st.com>>
> 
>     diff --git a/drivers/tty/serial/serial_mctrl_gpio.c
>     b/drivers/tty/serial/serial_mctrl_gpio.c
>     index c41d8911ce95..1663b3afc3a0 100644
>     --- a/drivers/tty/serial/serial_mctrl_gpio.c
>     +++ b/drivers/tty/serial/serial_mctrl_gpio.c
>     @@ -299,4 +299,42 @@ void mctrl_gpio_disable_ms(struct mctrl_gpios
>     *gpios)
>       }
>       EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
> 
>     +void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios)
>     +{
>     +       enum mctrl_gpio_idx i;
>     +
>     +       if (!gpios)
>     +               return;
>     +
>     +       if (!gpios->mctrl_on)
>     +               return;
>     +
>     +       for (i = 0; i < UART_GPIO_MAX; ++i) {
>     +               if (!gpios->irq[i])
>     +                       continue;
> 
> 
> 
> Why not simply
> 
>    if (gpios[])
>      enable_irq_...
> 
> ?
> 
> And same for disabling.
> 
>     +
>     +               enable_irq_wake(gpios->irq[i]);
>     +       }
>     +}
>     +EXPORT_SYMBOL_GPL(mctrl_gpio_enable_irq_wake);
>     +
>     +void mctrl_gpio_disable_irq_wake(struct mctrl_gpios *gpios)
>     +{
>     +       enum mctrl_gpio_idx i;
>     +
>     +       if (!gpios)
>     +               return;
>     +
>     +       if (!gpios->mctrl_on)
>     +               return;
>     +
>     +       for (i = 0; i < UART_GPIO_MAX; ++i) {
>     +               if (!gpios->irq[i])
>     +                       continue;
>     +
>     +               disable_irq_wake(gpios->irq[i]);
>     +       }
>     +}
>     +EXPORT_SYMBOL_GPL(mctrl_gpio_disable_irq_wake);
>     +
>       MODULE_LICENSE("GPL");
>     diff --git a/drivers/tty/serial/serial_mctrl_gpio.h
>     b/drivers/tty/serial/serial_mctrl_gpio.h
>     index b134a0ffc894..fc76910fb105 100644
>     --- a/drivers/tty/serial/serial_mctrl_gpio.h
>     +++ b/drivers/tty/serial/serial_mctrl_gpio.h
>     @@ -91,6 +91,16 @@ void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
>        */
>       void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
> 
>     +/*
>     + * Enable gpio wakeup interrupts to enable wake up source.
>     + */
>     +void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios);
>     +
>     +/*
>     + * Disable gpio wakeup interrupts to enable wake up source.
>     + */
>     +void mctrl_gpio_disable_irq_wake(struct mctrl_gpios *gpios);
>     +
>       #else /* GPIOLIB */
> 
>       static inline
>     @@ -142,6 +152,14 @@ static inline void mctrl_gpio_disable_ms(struct
>     mctrl_gpios *gpios)
>       {
>       }
> 
>     +static inline void mctrl_gpio_enable_irq_wake(struct mctrl_gpios
>     *gpios)
>     +{
>     +}
>     +
>     +static inline void mctrl_gpio_disable_irq_wake(struct mctrl_gpios
>     *gpios)
>     +{
>     +}
>     +
>       #endif /* GPIOLIB */
> 
>       #endif
>     -- 
>     2.17.1
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thanks for your review.
I fully agree with your comment, but I wrote this code like it is to 
keep the same structure than all the other ops of serial_mcrtrl_gpio 
driver. I preferred keeping an homogeneous code in the driver rather 
than breaking the driver homogeneity with the addition of an optimized code.

Greg, can you please indicate which solution you recommend ?

Cheers, Erwan.
