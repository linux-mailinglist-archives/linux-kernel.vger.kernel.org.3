Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62EE562A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGAEZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGAEZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:25:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F5344E9;
        Thu, 30 Jun 2022 21:25:26 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LZ2B23MnYz1L8VN;
        Fri,  1 Jul 2022 12:23:06 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 12:25:25 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 12:25:24 +0800
Subject: Re: [PATCH 1/2] serial: sh-sci: fix missing sci_cleanup_single() in
 sci_probe_single()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <geert+renesas@glider.be>, <peter@hurleysoftware.com>,
        <sjoerd.simons@collabora.co.uk>
References: <20220630140919.3857698-1-yangyingliang@huawei.com>
 <Yr29tlTOTrBfJPBP@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <46cdf509-c3ff-982d-33fe-ced7159f5093@huawei.com>
Date:   Fri, 1 Jul 2022 12:25:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Yr29tlTOTrBfJPBP@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/30 23:13, Greg KH wrote:
> On Thu, Jun 30, 2022 at 10:09:18PM +0800, Yang Yingliang wrote:
>> Add missing sci_cleanup_single() in error case in sci_probe_single()
>>
>> Fixes: f907c9ea8835 ("serial: sh-sci: Add support for GPIO-controlled modem lines")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/tty/serial/sh-sci.c | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index 0075a1420005..ca5a58f01aff 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -3283,25 +3283,31 @@ static int sci_probe_single(struct platform_device *dev,
>>   		return ret;
>>   
>>   	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
>> -	if (IS_ERR(sciport->gpios))
>> -		return PTR_ERR(sciport->gpios);
>> +	if (IS_ERR(sciport->gpios)) {
>> +		ret = PTR_ERR(sciport->gpios);
>> +		goto err_cleanup_single;
>> +	}
>>   
>>   	if (sciport->has_rtscts) {
>>   		if (mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_CTS) ||
>>   		    mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_RTS)) {
>>   			dev_err(&dev->dev, "Conflicting RTS/CTS config\n");
>> -			return -EINVAL;
>> +			ret = -EINVAL;
>> +			goto err_cleanup_single;
>>   		}
>>   		sciport->port.flags |= UPF_HARD_FLOW;
>>   	}
>>   
>>   	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
>> -	if (ret) {
>> -		sci_cleanup_single(sciport);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		goto err_cleanup_single;
>>   
>>   	return 0;
>> +
>> +err_cleanup_single:
>> +	sci_cleanup_single(sciport);
>> +
>> +	return ret;
>>   }
>>   
>>   static int sci_probe(struct platform_device *dev)
>> -- 
>> 2.25.1
>>
> How was this tested?
I found this by read the code, pm_runtime_enable() is called in 
sci_init_single(), but
pm_runtime_disable() is only called when uart_add_one_port() fails, so I 
add the
pm_runtime_disable() in other error case. Please correct me if I am wrong.

Thanks,
Yang
>
> thanks,
>
> greg k-h
> .
