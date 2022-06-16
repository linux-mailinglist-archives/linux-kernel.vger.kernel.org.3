Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A4754DB49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358728AbiFPHLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiFPHLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:11:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655362B1BD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:11:48 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNtbn5XrSzjY3t;
        Thu, 16 Jun 2022 15:10:13 +0800 (CST)
Received: from [10.174.176.103] (10.174.176.103) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 15:11:45 +0800
Message-ID: <71004ab9-38e0-4323-2506-38d6e71130f6@huawei.com>
Date:   Thu, 16 Jun 2022 15:11:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH -next] driver core: fix deadlock in __driver_attach
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>
References: <20220608094355.3298420-1-zhangwensheng5@huawei.com>
From:   "zhangwensheng (E)" <zhangwensheng5@huawei.com>
In-Reply-To: <20220608094355.3298420-1-zhangwensheng5@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.103]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping...

在 2022/6/8 17:43, Zhang Wensheng 写道:
> In __driver_attach function, There are also potential AA deadlock
> problem, like the commit b232b02bf3c2 ("driver core: fix deadlock
> in __device_attach").
>
> Fixes: ef0ff68351be ("driver core: Probe devices asynchronously instead of the driver")
> Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
> ---
>   drivers/base/dd.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 11b0fb6414d3..b766968a873c 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1115,6 +1115,7 @@ static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
>   static int __driver_attach(struct device *dev, void *data)
>   {
>   	struct device_driver *drv = data;
> +	bool async = false;
>   	int ret;
>   
>   	/*
> @@ -1153,9 +1154,11 @@ static int __driver_attach(struct device *dev, void *data)
>   		if (!dev->driver && !dev->p->async_driver) {
>   			get_device(dev);
>   			dev->p->async_driver = drv;
> -			async_schedule_dev(__driver_attach_async_helper, dev);
> +			async = true;
>   		}
>   		device_unlock(dev);
> +		if (async)
> +			async_schedule_dev(__driver_attach_async_helper, dev);
>   		return 0;
>   	}
>   
