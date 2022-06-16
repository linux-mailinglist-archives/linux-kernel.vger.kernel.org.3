Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51E954DA54
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359042AbiFPGKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358969AbiFPGKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:10:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED2F2A256;
        Wed, 15 Jun 2022 23:10:20 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LNsDM2ZWRz1KB5t;
        Thu, 16 Jun 2022 14:08:19 +0800 (CST)
Received: from [10.174.178.212] (10.174.178.212) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 14:10:17 +0800
Subject: Re: [PATCH -next] power: supply: ab8500: add missing
 destroy_workqueue in ab8500_charger_bind
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gaochao49@huawei.com>
References: <20220512093844.1109923-1-zhengbin13@huawei.com>
 <20220609222239.5fssqczkdqy4inoz@mercury.elektranox.org>
From:   "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Message-ID: <27654cfe-4d6e-8b5f-aaee-9f9a3117b3a2@huawei.com>
Date:   Thu, 16 Jun 2022 14:10:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20220609222239.5fssqczkdqy4inoz@mercury.elektranox.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.212]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/10 6:22, Sebastian Reichel wrote:
> Hi,
>
> On Thu, May 12, 2022 at 05:38:44PM +0800, Zheng Bin wrote:
>> ab8500_charger_bind misses destroy_workqueue in error path,
>> this patch fixes that.
>>
>> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
>> ---
> LGTM, but adding Linus to Cc and waiting a bit to give him time to
> react.
>
> -- Sebastian
ping
>
>>   drivers/power/supply/ab8500_charger.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
>> index d04d087caa50..a5d055a628e7 100644
>> --- a/drivers/power/supply/ab8500_charger.c
>> +++ b/drivers/power/supply/ab8500_charger.c
>> @@ -3378,6 +3378,7 @@ static int ab8500_charger_bind(struct device *dev)
>>   	ret = component_bind_all(dev, di);
>>   	if (ret) {
>>   		dev_err(dev, "can't bind component devices\n");
>> +		destroy_workqueue(di->charger_wq);
>>   		return ret;
>>   	}
>>
>> --
>> 2.31.1
>>
