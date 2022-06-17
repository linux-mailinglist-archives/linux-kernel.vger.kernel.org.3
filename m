Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B9354EF19
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379675AbiFQCH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379625AbiFQCHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:07:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33FF21279;
        Thu, 16 Jun 2022 19:07:52 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LPMq7648dzjY2m;
        Fri, 17 Jun 2022 10:06:43 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 10:07:41 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 10:07:41 +0800
Subject: Re: [PATCH v2 3/3] crypto: hisilicon/qm - defining the device
 isolation strategy
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-4-yekai13@huawei.com>
 <20220615140249.000077f8@Huawei.com>
 <f4fde630-a2ba-2416-5091-33c510c30593@huawei.com>
 <20220616144547.00003093@Huawei.com>
CC:     Kai Ye via Linux-accelerators 
        <linux-accelerators@lists.ozlabs.org>,
        <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <linux-crypto@vger.kernel.org>,
        <zhangfei.gao@linaro.org>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <ea132cfd-801f-e7f2-57b5-58b7ed12f501@huawei.com>
Date:   Fri, 17 Jun 2022 10:07:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220616144547.00003093@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/16 21:45, Jonathan Cameron wrote:
> ...
>
>>>
>>>> +	hw_err->tick_stamp = jiffies;
>>>> +	list_for_each_entry_safe(err, tmp, &qm->uacce_hw_errs, list) {
>>>
>>> These are ordered (I think). Could take advantage of that by
>>> maintaining count of elements in parallel to the list then walking
>>> list in right direction + stop when you reach last one to need
>>> deleting.
>>>
>>
>> thanks, The current list + jiffies solution seems more simple.
>
> If list always remains relatively short then that's probably fine.
>
>>>
>>>> +		if ((hw_err->tick_stamp - err->tick_stamp) / HZ >
>>>> +		    SECONDS_PER_HOUR) {
>>>> +			list_del(&err->list);
>>>> +			kfree(err);
>>>> +		} else {
>>>> +			count++;
>>>> +		}
>>>> +	}
>>>> +	list_add(&hw_err->list, &qm->uacce_hw_errs);
>>>> +
>>>> +	if (count >= isolate->hw_err_isolate_hz)
>>>> +		atomic_set(&isolate->is_isolate, 1);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>
>>> ...
>>>
>>>> +static int hisi_qm_isolate_strategy_write(struct uacce_device *uacce,
>>>> +						const char *buf)
>>>> +{
>>>> +	struct hisi_qm *qm = uacce->priv;
>>>> +	unsigned long val = 0;
>>>> +
>>>> +#define MAX_ISOLATE_STRATEGY	65535
>>>> +
>>>> +	if (atomic_read(&qm->uacce_ref))
>>>> +		return -EBUSY;
>>>> +
>>>> +	/* must be set by PF */
>>>> +	if (atomic_read(&qm->isolate_data.is_isolate) || uacce->is_vf)
>>>
>>> Why is the file visible on the vf?  Hide it or don't register it for vfs.
>> Because VF devices can be registered with UACCE. So this file node can
>> be visited on the vf. We're not sure if someone else's device is the
>> same as qm. So i configure it this way by driver. the 'isolate_strategy'
>> must be set by pf.
>>
>
> If possible have the uacce registration from the driver provide information
> on whether this applies to the VF.  Much better to have no file presented
> by the VF than one that always returns an error code.
>
> Jonathan
>
> .
>

Yes, I will provide some information here for VF.

thanks

Kai
