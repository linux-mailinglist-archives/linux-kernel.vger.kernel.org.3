Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AB562939
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiGACe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiGACey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:34:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DFB61D4D;
        Thu, 30 Jun 2022 19:34:52 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LYzkS0fkQzhYtB;
        Fri,  1 Jul 2022 10:32:32 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 10:34:50 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 10:34:50 +0800
Subject: Re: [PATCH 2/2] serial: sh-sci: fix missing uart_unregister_driver()
 in sci_probe_single()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <geert+renesas@glider.be>, <peter@hurleysoftware.com>,
        <sjoerd.simons@collabora.co.uk>
References: <20220630140919.3857698-1-yangyingliang@huawei.com>
 <20220630140919.3857698-2-yangyingliang@huawei.com>
 <Yr29pxQPgGs6/0yr@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <3649d976-8236-6740-98db-79f3cdedcaef@huawei.com>
Date:   Fri, 1 Jul 2022 10:34:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Yr29pxQPgGs6/0yr@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hi,

On 2022/6/30 23:13, Greg KH wrote:
> On Thu, Jun 30, 2022 at 10:09:19PM +0800, Yang Yingliang wrote:
>> Add missing uart_unregister_driver() in error case in sci_probe_single().
>>
>> Fixes: 352b92664549 ("serial: sh-sci: Move uart_register_driver call to device probe")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/tty/serial/sh-sci.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index ca5a58f01aff..08a249eaaa8c 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -3280,7 +3280,7 @@ static int sci_probe_single(struct platform_device *dev,
>>   
>>   	ret = sci_init_single(dev, sciport, index, p, false);
>>   	if (ret)
>> -		return ret;
>> +		goto err_unregister;
>>   
>>   	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
>>   	if (IS_ERR(sciport->gpios)) {
>> @@ -3306,6 +3306,10 @@ static int sci_probe_single(struct platform_device *dev,
>>   
>>   err_cleanup_single:
>>   	sci_cleanup_single(sciport);
>> +err_unregister:
>> +	mutex_lock(&sci_uart_registration_lock);
>> +	uart_unregister_driver(&sci_uart_driver);
>> +	mutex_unlock(&sci_uart_registration_lock);
> Did you test this?
>
> I think you just broke all other devices attached to this driver.
>
> Please always test your code before submitting it, especially for stuff
> like this.
I made a mistake here, the register is for the driver not for single 
port, this breaks
other ports, I will be more careful about this case next time.

Thanks,
Yang
>
> thanks,
>
> greg k-h
> .
