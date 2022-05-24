Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F1753211E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiEXCnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiEXCnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:43:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDAF38BC0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:43:21 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L6dmN6Y3pzDqNd;
        Tue, 24 May 2022 10:43:16 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 10:43:19 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 10:43:18 +0800
Message-ID: <0ee08b72-d8a7-e016-f47f-213064a6c9ed@huawei.com>
Date:   Tue, 24 May 2022 10:43:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] ARM: 9192/1: amba: fix memory leak in
 amba_device_try_add()
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Russell King <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>
References: <20220523211700.GA236401@roeck-us.net>
 <85df3427-1dc8-aac0-71fc-1a8b81a731d9@huawei.com>
 <92cecde5-3a7e-54c5-de62-12a133f2de88@roeck-us.net>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <92cecde5-3a7e-54c5-de62-12a133f2de88@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/24 10:33, Guenter Roeck wrote:
> On 5/23/22 18:57, Kefeng Wang wrote:
>>
>> On 2022/5/24 5:17, Guenter Roeck wrote:
>>> On Mon, Apr 18, 2022 at 07:07:14AM +0100, Wang Kefeng wrote:
>>>> If amba_device_try_add() return error code (not EPROBE_DEFER),
>>>> memory leak occurred when amba device fails to read periphid.
>>>>
>>> This patch results in a refcount underflow.
>>>
>>> NET: Registered PF_NETLINK/PF_ROUTE protocol family
>>> DMA: preallocated 256 KiB pool for atomic coherent allocations
>>> platform vga: Fixing up cyclic dependency with bridge
>>> OF: amba_device_add() failed (-19) for /amba/smc@10100000
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 
>>> of_platform_bus_create+0x33c/0x3dc
>>> refcount_t: underflow; use-after-free.
>>> Modules linked in:
>>> CPU: 0 PID: 1 Comm: swapper Not tainted 5.18.0-next-20220523 #1
>>> Hardware name: ARM-Versatile (Device Tree Support)
>>>   unwind_backtrace from show_stack+0x10/0x14
>>>   show_stack from dump_stack_lvl+0x38/0x5c
>>>   dump_stack_lvl from __warn+0xc8/0x1d4
>>>   __warn from warn_slowpath_fmt+0x90/0xc8
>>>   warn_slowpath_fmt from of_platform_bus_create+0x33c/0x3dc
>>>   of_platform_bus_create from of_platform_bus_create+0x1ec/0x3dc
>>>   of_platform_bus_create from of_platform_populate+0x68/0xd8
>>>   of_platform_populate from customize_machine+0x1c/0x30
>>>   customize_machine from do_one_initcall+0x8c/0x2fc
>>>   do_one_initcall from kernel_init_freeable+0x190/0x220
>>>   kernel_init_freeable from kernel_init+0x10/0x108
>>>   kernel_init from ret_from_fork+0x14/0x3c
>>
>> Thank,  I use vexpress-v2p-ca15-tc1 and can't reproduce , but after 
>> check the code,
>>
>> amba_device_try_add() is called amba_deferred_retry() and 
>> amba_device_add(),
>>
>> 1) for amba_device_add(), called by of_amba_device_create() and 
>> amba_handler_attach(),
>>
>> which has called amba_device_put() to release resource when meet 
>> error, my
>>
>> patch leads to the above issue.
>>
>> 2) for amba_deferred_retry(),  it only releases the  struct 
>> deferred_device, but forget
>>
>> to call amba_device_put() to release amba device and device name
>>
>> so we only need to call amba_device_put() in amba_deferred_retry(), 
>> could you
>>
>> help me to try the following patch, thanks.
>>
>
> It doesn't apply; it looks like you used cut-and-paste, which replaced
> tabs with spaces. I tried to fix it up, but it didn't work.
> Please send a clean patch.
Please use this one,

https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/T/#u

>
> Thanks,
> Guenter
>
>>
>> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
>> index 0e3ed5eb367b..0cb20324da16 100644
>> --- a/drivers/amba/bus.c
>> +++ b/drivers/amba/bus.c
>> @@ -493,13 +493,8 @@ static int amba_device_try_add(struct 
>> amba_device *dev, struct resource *parent)
>>                  goto skip_probe;
>>
>>          ret = amba_read_periphid(dev);
>> -       if (ret) {
>> -               if (ret != -EPROBE_DEFER) {
>> -                       amba_device_put(dev);
>> -                       goto err_out;
>> -               }
>> +       if (ret)
>>                  goto err_release;
>> -       }
>>
>>   skip_probe:
>>          ret = device_add(&dev->dev);
>> @@ -546,6 +541,7 @@ static int amba_deferred_retry(void)
>>                          continue;
>>
>>                  list_del_init(&ddev->node);
>> +               amba_device_put(ddev->dev);
>>                  kfree(ddev);
>>          }
>>
>>
>>
>>>
>>> Guenter
>>>
>>> ---
>>> # bad: [cc63e8e92cb872081f249ea16e6c460642f3e4fb] Add linux-next 
>>> specific files for 20220523
>>> # good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
>>> git bisect start 'HEAD' 'v5.18'
>>> # bad: [a812cac8ff60a3f57d59225eaf668f574fd36a65] Merge branch 
>>> 'master' of 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>>> git bisect bad a812cac8ff60a3f57d59225eaf668f574fd36a65
>>> # bad: [ad67b5f981704e575b24e3b650653bae607980dc] Merge branch 
>>> 'for-next' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>>> git bisect bad ad67b5f981704e575b24e3b650653bae607980dc
>>> # bad: [793dd6392ef951ae61473acfc7e7016ea22c40f4] Merge branch 
>>> 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
>>> git bisect bad 793dd6392ef951ae61473acfc7e7016ea22c40f4
>>> # good: [00ad84f582be91dd03132c133917cc6b62d754e2] Merge branch 
>>> 'arm/dt' into for-next
>>> git bisect good 00ad84f582be91dd03132c133917cc6b62d754e2
>>> # bad: [5c4a49fbe99c7c9b814d677ac99e3efcc43d019a] Merge branch 
>>> 'for-next/core' of 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
>>> git bisect bad 5c4a49fbe99c7c9b814d677ac99e3efcc43d019a
>>> # good: [33cd6948f953ab47ffa493bac6c0f34feb191e0d] Merge branch 
>>> 'clang-format' of https://github.com/ojeda/linux.git
>>> git bisect good 33cd6948f953ab47ffa493bac6c0f34feb191e0d
>>> # good: [d6fc5db0f82828c74742319cb6c988c4a8aac535] Merge branch 
>>> 'for-next/kselftest' into for-next/core
>>> git bisect good d6fc5db0f82828c74742319cb6c988c4a8aac535
>>> # good: [d7015e50a9ed180dcc3947635bb2b5711c37f48b] perf intel-pt: 
>>> Add support for emulated ptwrite
>>> git bisect good d7015e50a9ed180dcc3947635bb2b5711c37f48b
>>> # good: [5b86b659fa4b3dd45acbdce13f2e94f882a3d125] Merge branch 
>>> 'for-next' of git://git.infradead.org/users/hch/dma-mapping.git
>>> git bisect good 5b86b659fa4b3dd45acbdce13f2e94f882a3d125
>>> # good: [945980a9ba0744038659769e9f04e83e8f6b494b] Merge branch 
>>> 'master' of 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
>>> git bisect good 945980a9ba0744038659769e9f04e83e8f6b494b
>>> # bad: [b6f21d14f1ac1261579b691673a0c823275cbaf8] ARM: 9204/2: 
>>> module: Add all unwind tables when load module
>>> git bisect bad b6f21d14f1ac1261579b691673a0c823275cbaf8
>>> # bad: [c4f486f1e7b34b27ec578494a236061b337d50ae] ARM: 9198/1: 
>>> spectre-bhb: simplify BPIALL vector macro
>>> git bisect bad c4f486f1e7b34b27ec578494a236061b337d50ae
>>> # bad: [7719a68b2fa404fa8af6b0b7119a38c406c74858] ARM: 9192/1: amba: 
>>> fix memory leak in amba_device_try_add()
>>> git bisect bad 7719a68b2fa404fa8af6b0b7119a38c406c74858
>>> # good: [1f44de0f5e309e8699b569b49a8e89ef4e7527c7] ARM: 9193/1: 
>>> amba: Add amba_read_periphid() helper
>>> git bisect good 1f44de0f5e309e8699b569b49a8e89ef4e7527c7
>>> # first bad commit: [7719a68b2fa404fa8af6b0b7119a38c406c74858] ARM: 
>>> 9192/1: amba: fix memory leak in amba_device_try_add()
>>>
>>>
>>> .
>
> .
