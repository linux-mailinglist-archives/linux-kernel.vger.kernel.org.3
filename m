Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20295740F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiGNBaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiGNBaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:30:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B21140E5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:30:13 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LjxfC2SPvzVft0;
        Thu, 14 Jul 2022 09:26:27 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 09:30:06 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 09:30:05 +0800
Message-ID: <d5b32c3f-b0dd-a816-5ddf-ecf4032aa571@huawei.com>
Date:   Thu, 14 Jul 2022 09:30:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Linux 5.19-rc6
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Daniel Axtens" <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/14 3:48, Russell King (Oracle) wrote:
> On Wed, Jul 13, 2022 at 12:36:50PM -0700, Linus Torvalds wrote:
>> On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>> OF: amba_device_add() failed (-19) for /amba/smc@10100000
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
>>> refcount_t: underflow; use-after-free.
Sorry to lead to this issue,
>> This too has been going on since -rc1, but it's not obvious what caused it.
>>
>> At a guess, looking around the amba changes, I'm assuming it's
>>
>>    7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
>>
>> Does reverting that commit make it go away?
> There may be a patch that solves that, but it's never been submitted to
> my patch system:
>
> https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
This patch is to fix the above issue reported-by Guenter, and it merged 
into linux-next
for a while, which Applied in 
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9207/1
>
> I'm sorry, but I'm utterly crap at picking up patches off mailing lists,
> so if stuff doesn't end up inthe patch system, it gets missed.
Is there some special for bugfix patch when send to arm patch system, please
let me know if I missed.
