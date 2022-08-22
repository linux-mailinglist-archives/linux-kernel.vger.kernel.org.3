Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21759B774
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiHVCK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiHVCK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:10:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199A1FCCC
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:10:25 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M9wh023fNzXdrl;
        Mon, 22 Aug 2022 10:06:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 10:10:24 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 10:10:23 +0800
Subject: Re: [PATCH -next] driver core: switch to use dev_err_probe()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <rafael@kernel.org>
References: <20220819094656.1945653-1-yangyingliang@huawei.com>
 <Yv9a9+iREzQWYecQ@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <1d4d1ef7-7386-cf8f-0a5a-04690ec27ed6@huawei.com>
Date:   Mon, 22 Aug 2022 10:10:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Yv9a9+iREzQWYecQ@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/8/19 17:42, Greg KH wrote:
> On Fri, Aug 19, 2022 at 05:46:56PM +0800, Yang Yingliang wrote:
>> Use dev_err_probe() to simplify code and print error code.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/base/core.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 753e7cca0f40..e51a09f9d0ec 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -2507,11 +2507,9 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
>>   	int rc;
>>   
>>   	rc = kobject_synth_uevent(&dev->kobj, buf, count);
>> -
>> -	if (rc) {
>> -		dev_err(dev, "uevent: failed to send synthetic uevent\n");
>> -		return rc;
>> -	}
>> +	if (rc)
>> +		return dev_err_probe(dev, rc,
>> +				     "uevent: failed to send synthetic uevent\n");
> I do not understand this at all, this is not on the probe path at all,
> so why is this function needed?
>
> Have you tested this?  What was the resulting output before and after
> this change?
Yes, after this change, the error code will be print.
>
> thanks,
>
> greg k-h
> .
