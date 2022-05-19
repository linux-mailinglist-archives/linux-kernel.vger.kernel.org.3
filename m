Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7EA52C948
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiESBjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiESBjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:39:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7979666CB2;
        Wed, 18 May 2022 18:39:40 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3XZZ2JwqzhZ6t;
        Thu, 19 May 2022 09:39:02 +0800 (CST)
Received: from [10.67.111.227] (10.67.111.227) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 09:39:38 +0800
Subject: Re: [PATCH -next] usb: host: ohci-tmio: Remove redundant if statement
To:     Dmitry Baryshkov <dbaryshkov@gmail.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20220518024347.213402-1-lizhengyu3@huawei.com>
 <CALT56yO_ek55BGX4cKuTim2gWwQp7EXUFyh332MPYHPdi7xEWw@mail.gmail.com>
From:   "lizhengyu (E)" <lizhengyu3@huawei.com>
Message-ID: <ab630ed0-25c5-cc92-34c3-a68c0af160df@huawei.com>
Date:   Thu, 19 May 2022 09:39:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CALT56yO_ek55BGX4cKuTim2gWwQp7EXUFyh332MPYHPdi7xEWw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 18:30:15 +0300, Dmitry Baryshkov 
<dbaryshkov@gmail.com> wrote:
> ср, 18 мая 2022 г. в 05:45, Li Zhengyu <lizhengyu3@huawei.com>:
>> (ret == 0) is true when (ret) is false, so remove it.
>> Also remove unreachable code.
>>
>> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
>> ---
>>   drivers/usb/host/ohci-tmio.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
>> index 49539b9f0e94..6bcb0cb53f7c 100644
>> --- a/drivers/usb/host/ohci-tmio.c
>> +++ b/drivers/usb/host/ohci-tmio.c
>> @@ -243,12 +243,8 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
>>          ret = usb_add_hcd(hcd, irq, 0);
>>          if (ret)
>>                  goto err_add_hcd;
>> -
>>          device_wakeup_enable(hcd->self.controller);
> I think the proper patch would be to check the return value of
> device_wakeup_enable(), so NAK.
>
>> -       if (ret == 0)
>> -               return ret;
>> -
>> -       usb_remove_hcd(hcd);
>> +       return ret;
>>
>>   err_add_hcd:
>>          tmio_stop_hc(dev);
>> --
>> 2.17.1
>>
>
Thanks, I will fix it soon.
