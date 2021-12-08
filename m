Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9646D4F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhLHOCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:02:33 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56626 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhLHOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:02:33 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B8CY0QY026672;
        Wed, 8 Dec 2021 14:58:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=jOlUtZ/Fpyt6KRs6ErV+q8M/W6PKKOWv3CQH890HmwQ=;
 b=fwLd9HAOULjX0TFoavwNwiRU3frxjeJOe+g+wl8H9UESsZD2/uuWzJgdQLe81Xe7zZ8h
 bljwNplRdAShJVuXvCZMFeoWZ663knvuaOmkh0io5KLlXXRaD5xLn//SFvW1r7cVIg79
 8HzP0mwG84DlBba3+wE74zr4M/y5v9tpA9eXgjL/+LpYlseuDIHPiGvPyQthT9MdiY/H
 MYhIaLO+GgJX/uE+Uypkh/JJ7fAXoMr6KBNHQB5Y5gCf/8N7aMHGD+crWy1oirxMow5O
 8TmEmKyaREmgz54c+8HSUt86ClFGb4DuJv/wpJ85yuAKYvzyvc9gphVsoB1WD7OHbYAT LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ctrpqa1x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:58:48 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7B0C110002A;
        Wed,  8 Dec 2021 14:58:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6EDD4225583;
        Wed,  8 Dec 2021 14:58:47 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 8 Dec
 2021 14:58:46 +0100
Subject: Re: [PATCH 2/3] irqchip/stm32-exti: add STM32MP13 support
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20211208130456.4002-1-alexandre.torgue@foss.st.com>
 <20211208130456.4002-3-alexandre.torgue@foss.st.com>
 <87fsr31aex.wl-maz@kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <fffb9758-8071-edd8-8fe9-d0d2a57fac05@foss.st.com>
Date:   Wed, 8 Dec 2021 14:58:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87fsr31aex.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_05,2021-12-08_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

On 12/8/21 2:41 PM, Marc Zyngier wrote:
> On Wed, 08 Dec 2021 13:04:55 +0000,
> Alexandre Torgue <alexandre.torgue@foss.st.com> wrote:
>>
>> Enhance stm32-exti driver to support STM32MP13 SoC. This SoC uses the same
>> hardware version than STM32MP15. Only EXTI line mapping is changed and
>> following EXTI lines are supported: GPIO, RTC, I2C[1-5], UxART[1-8],
>> USBH_EHCI, USBH_OHCI, USB_OTG, LPTIM[1-5], ETH[1-2].
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>
>> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
>> index b7cb2da71888..9d18f47040eb 100644
>> --- a/drivers/irqchip/irq-stm32-exti.c
>> +++ b/drivers/irqchip/irq-stm32-exti.c
>> @@ -214,6 +214,48 @@ static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
>>   	{ .exti = 73, .irq_parent = 129, .chip = &stm32_exti_h_chip },
>>   };
>>   
>> +static const struct stm32_desc_irq stm32mp13_desc_irq[] = {
>> +	{ .exti = 0, .irq_parent = 6, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 1, .irq_parent = 7, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 2, .irq_parent = 8, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 3, .irq_parent = 9, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 4, .irq_parent = 10, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 5, .irq_parent = 24, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 6, .irq_parent = 65, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 7, .irq_parent = 66, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 8, .irq_parent = 67, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 9, .irq_parent = 68, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 10, .irq_parent = 41, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 11, .irq_parent = 43, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 12, .irq_parent = 77, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 13, .irq_parent = 78, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 14, .irq_parent = 106, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 15, .irq_parent = 109, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 16, .irq_parent = 1, .chip = &stm32_exti_h_chip },
>> +	{ .exti = 19, .irq_parent = 3, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 21, .irq_parent = 32, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 22, .irq_parent = 34, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 23, .irq_parent = 73, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 24, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 25, .irq_parent = 114, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 26, .irq_parent = 38, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 27, .irq_parent = 39, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 28, .irq_parent = 40, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 29, .irq_parent = 72, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 30, .irq_parent = 53, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 31, .irq_parent = 54, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 32, .irq_parent = 83, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 33, .irq_parent = 84, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 44, .irq_parent = 96, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 47, .irq_parent = 92, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 48, .irq_parent = 116, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 50, .irq_parent = 117, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 52, .irq_parent = 118, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 53, .irq_parent = 119, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 68, .irq_parent = 63, .chip = &stm32_exti_h_chip_direct },
>> +	{ .exti = 70, .irq_parent = 98, .chip = &stm32_exti_h_chip_direct },
>> +};
> 
> Why does the driver need to carry these tables? This sort of
> information should really come from DT, instead of being hardcoded in
> the driver and bloating it for no reason. This all has a funny taste
> of the board files we used to have pre-DT.
>

There are absolutely no reason to have it in driver. Honestly It has 
been done in this way to have minimal changes adding this new SoC 
support (and it's not smart, I agree).

I think it is better to abandon this series. I will create a new one 
which moves mapping table for MP15 and adds MP13 support to.

thanks
Alex



> 	M.
> 

