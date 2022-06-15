Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8075054C45D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiFOJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiFOJKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:10:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA1611C26;
        Wed, 15 Jun 2022 02:10:50 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LNKH65t0Wz1K9xV;
        Wed, 15 Jun 2022 17:08:50 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 17:10:48 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 17:10:48 +0800
Subject: Re: [PATCH v2 3/3] crypto: hisilicon/qm - defining the device
 isolation strategy
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-4-yekai13@huawei.com> <YqiCaTAaRoq7c0y0@kroah.com>
 <b597023a-5569-f4be-1e30-78d0d961dfdc@huawei.com>
 <YqiNHOfXHRtaQyZV@kroah.com>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <ed292f66-fcec-3803-4f29-b94e60ee913e@huawei.com>
Date:   Wed, 15 Jun 2022 17:10:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YqiNHOfXHRtaQyZV@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/14 21:29, Greg KH wrote:
> On Tue, Jun 14, 2022 at 09:24:08PM +0800, yekai(A) wrote:
>>>>  struct hisi_qm {
>>>>  	enum qm_hw_ver ver;
>>>>  	enum qm_fun_type fun_type;
>>>> @@ -335,6 +341,9 @@ struct hisi_qm {
>>>>  	struct qm_shaper_factor *factor;
>>>>  	u32 mb_qos;
>>>>  	u32 type_rate;
>>>> +	struct list_head uacce_hw_errs;
>>>> +	atomic_t uacce_ref; /* reference of the uacce */
>>>
>>> That is not how reference counts work, sorry.  Please use 'struct kref'
>>> for a real reference count, never roll your own.
>>>
>>> thanks,
>>>
>>> greg k-h
>>> .
>>>
>>
>> this atomic_t reference is lightweight than 'struct kref',
>
> It's the same size, why would it be "lighter"?  Why do you need it to be
> lighter, what performance issue is there with a kref?
>
>> this reference
>> means whether the task is running. So would it be better to use atomic_t
>> reference?
>
> I do not know, as "running or not running" is a state, not a count or a
> reference.  why does this have to be atomic at all?
>
> thanks,
>
> greg k-h
> .
>

I will use 'qm_state' instead of reference count by zhangfei Gao's opinion.

Thanks
Kai
