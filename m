Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C8E59B9A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiHVGgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiHVGf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:35:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B2B24BED
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:35:56 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MB2dN3t1YzGpkg;
        Mon, 22 Aug 2022 14:34:16 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 14:35:53 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 14:35:53 +0800
Subject: Re: [PATCH -next] driver core: switch to use dev_err_probe()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <rafael@kernel.org>
References: <20220819094656.1945653-1-yangyingliang@huawei.com>
 <Yv9a9+iREzQWYecQ@kroah.com>
 <1d4d1ef7-7386-cf8f-0a5a-04690ec27ed6@huawei.com>
 <YwMdl/3ZBKAYsqN1@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <8a7afe46-1720-67c7-0068-0d80f0ec3f50@huawei.com>
Date:   Mon, 22 Aug 2022 14:35:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YwMdl/3ZBKAYsqN1@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


On 2022/8/22 14:09, Greg KH wrote:
> On Mon, Aug 22, 2022 at 10:10:22AM +0800, Yang Yingliang wrote:
>> Hi,
>>
>> On 2022/8/19 17:42, Greg KH wrote:
>>> On Fri, Aug 19, 2022 at 05:46:56PM +0800, Yang Yingliang wrote:
>>>> Use dev_err_probe() to simplify code and print error code.
>>>>
>>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>>> ---
>>>>    drivers/base/core.c | 8 +++-----
>>>>    1 file changed, 3 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>> index 753e7cca0f40..e51a09f9d0ec 100644
>>>> --- a/drivers/base/core.c
>>>> +++ b/drivers/base/core.c
>>>> @@ -2507,11 +2507,9 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
>>>>    	int rc;
>>>>    	rc = kobject_synth_uevent(&dev->kobj, buf, count);
>>>> -
>>>> -	if (rc) {
>>>> -		dev_err(dev, "uevent: failed to send synthetic uevent\n");
>>>> -		return rc;
>>>> -	}
>>>> +	if (rc)
>>>> +		return dev_err_probe(dev, rc,
>>>> +				     "uevent: failed to send synthetic uevent\n");
>>> I do not understand this at all, this is not on the probe path at all,
>>> so why is this function needed?
>>>
>>> Have you tested this?  What was the resulting output before and after
>>> this change?
>> Yes, after this change, the error code will be print.
> You did not answer my question.
>
> Again, this is not on the probe() callback path, so why are you wanting
> to call dev_err_probe()?
I was trying to simplify the code, I think I misuse the helper, you can 
ignore this patch.

Thanks,
Yang
>
> thanks,
>
> greg k-h
> .
