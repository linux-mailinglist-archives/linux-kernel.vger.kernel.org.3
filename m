Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4737647A891
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhLTLZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:25:51 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:37216 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhLTLZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:25:51 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru D4AA2232DC0A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <d7974f16-74b1-4d8a-2c28-8acb710d6310@omp.ru>
Date:   Mon, 20 Dec 2021 14:25:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] usb: dwc3: qcom: Check for null irq pointer
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211220101520.930658-1-jiasheng@iscas.ac.cn>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211220101520.930658-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.2021 13:15, Jiasheng Jiang wrote:

> The return value of platform_get_irq() needs to be checked.
> To avoid use of null pointer

   What null pointer, could you please clarify?

in case that there is no irq.
> 
> Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/usb/dwc3/dwc3-qcom.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 49e6ca94486d..f04fb3f2fb85 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -614,6 +614,11 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
>   		qcom->acpi_pdata->dwc3_core_base_size;
>   
>   	irq = platform_get_irq(pdev_irq, 0);
> +	if (!irq) {

    This is totally wrong! That function returns negative error codes in case 
of failure.

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>   	child_res[1].flags = IORESOURCE_IRQ;
>   	child_res[1].start = child_res[1].end = irq;

MBR, Sergey
