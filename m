Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47939558F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiFXDZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXDZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:25:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923436271F;
        Thu, 23 Jun 2022 20:25:19 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTj8b3mLdzShKB;
        Fri, 24 Jun 2022 11:21:51 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 11:25:11 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 11:25:10 +0800
Subject: Re: [PATCH v4 2/3] Documentation: add a isolation strategy sysfs node
 for uacce
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220623061452.40732-1-yekai13@huawei.com>
 <20220623061452.40732-3-yekai13@huawei.com> <YrQr/3URWsdowov9@kroah.com>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <f25514f8-2d34-5911-b29f-a520d1df3db4@huawei.com>
Date:   Fri, 24 Jun 2022 11:25:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YrQr/3URWsdowov9@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/23 17:01, Greg KH wrote:
> On Thu, Jun 23, 2022 at 02:14:51PM +0800, Kai Ye wrote:
>> Update documentation describing sysfs node that could help to
>> configure isolation method command for users in th user space.
>>
>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>> ---
>>  Documentation/ABI/testing/sysfs-driver-uacce | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
>> index 08f2591138af..8784efa96e01 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-uacce
>> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
>> @@ -19,6 +19,24 @@ Contact:        linux-accelerators@lists.ozlabs.org
>>  Description:    Available instances left of the device
>>                  Return -ENODEV if uacce_ops get_available_instances is not provided
>>
>> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
>> +Date:           Jun 2022
>> +KernelVersion:  5.20
>> +Contact:        linux-accelerators@lists.ozlabs.org
>> +Description:    A sysfs node that used to configures the hardware error
>> +                isolation method command. The command can be parsed
>> +                in correct driver. e.g. If the device slot reset frequency
>> +                exceeds the preset value in a time window, the device will be
>> +                isolated.
>
> What is the "command"?  What is being parsed?  This needs to be
> documented a lot more here, this is very vague and not obvious at all.
>
>

This command is a string command issued by the user. After the command 
is configured, the acc driver parses the command.
>> +
>> +What:           /sys/class/uacce/<dev_name>/isolate
>> +Date:           Jun 2022
>> +KernelVersion:  5.20
>> +Contact:        linux-accelerators@lists.ozlabs.org
>> +Description:    A sysfs node that show the device isolated state. The value 0
>> +                means that the device is working. The value 1 means that the
>> +                device has been isolated.
>
> Are these read-only?  Write only?  read/write?

this node is read-only
>
> thanks,
>
> greg k-h
> .
>

Thanks
Kai
