Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBA75AD208
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiIEMC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiIEMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:02:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281FA5D0D9;
        Mon,  5 Sep 2022 05:02:55 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MLnB12zYqzjXf8;
        Mon,  5 Sep 2022 19:59:21 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 20:02:53 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 20:02:53 +0800
Subject: Re: [PATCH v7 2/3] Documentation: add a isolation strategy sysfs node
 for uacce
To:     Greg KH <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20220806022943.47292-1-yekai13@huawei.com>
 <20220806022943.47292-3-yekai13@huawei.com> <YxDJ6PEWd/3c1jPd@kroah.com>
 <YxDlOFYih5tQ37Av@sol.localdomain> <YxD1byMGE03R8YWT@kroah.com>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <58cecd16-c992-c6b0-76b1-0ba7f2ac4845@huawei.com>
Date:   Mon, 5 Sep 2022 20:02:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YxD1byMGE03R8YWT@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/2 2:09, Greg KH wrote:
> On Thu, Sep 01, 2022 at 10:00:40AM -0700, Eric Biggers wrote:
>> On Thu, Sep 01, 2022 at 05:04:08PM +0200, Greg KH wrote:
>>> On Sat, Aug 06, 2022 at 10:29:42AM +0800, Kai Ye wrote:
>>>> Update documentation describing sysfs node that could help to
>>>> configure isolation strategy for users in the user space. And
>>>> describing sysfs node that could read the device isolated state.
>>>>
>>>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-driver-uacce | 26 ++++++++++++++++++++
>>>>  1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
>>>> index 08f2591138af..e09fd160d3fa 100644
>>>> --- a/Documentation/ABI/testing/sysfs-driver-uacce
>>>> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
>>>> @@ -19,6 +19,32 @@ Contact:        linux-accelerators@lists.ozlabs.org
>>>>  Description:    Available instances left of the device
>>>>                  Return -ENODEV if uacce_ops get_available_instances is not provided
>>>>  
>>>> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
>>>> +Date:           Jul 2022
>>> July was a while ago, you sent this patch in August :(
>>>
>> Does the date in the sysfs documentation files serve any purpose besides making
>> people have to update their patchsets every month?
>>
>> The kernel version number would be more useful to readers of the documentation,
>> and it wouldn't have to be updated quite as often.
> True, I have seen people use that instead, or no date at all, I don't
> require it.  But if you do put the field in there, it should at least be
> correct :)
>
> thanks,
>
> greg k-h
> .
>
I have fixed the date in version v8

thanks
Kai
