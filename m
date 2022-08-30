Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752B15A6529
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiH3Nkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiH3NkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:40:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D02DFCA0C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:38:48 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MH7cM0r6nznTVv;
        Tue, 30 Aug 2022 21:36:03 +0800 (CST)
Received: from [10.67.110.83] (10.67.110.83) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 21:38:28 +0800
Subject: Re: ping //Re: [PATCH v2 0/2] squashfs: Add the mount parameter
 "threads="
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        <linux-kernel@vger.kernel.org>
CC:     <wangle6@huawei.com>, <yi.zhang@huawei.com>,
        <wangbing6@huawei.com>, <zhongjubin@huawei.com>,
        <chenjianguo3@huawei.com>
References: <20220815031100.75243-1-nixiaoming@huawei.com>
 <20220816010052.15764-1-nixiaoming@huawei.com>
 <8d139f03-7845-9c96-fffc-74fdf8b5d78d@huawei.com>
 <60b24133-234f-858b-8e71-e183fe72d2bb@squashfs.org.uk>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <9c5bddc3-fc93-d76a-1163-0278c8d31dc5@huawei.com>
Date:   Tue, 30 Aug 2022 21:38:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <60b24133-234f-858b-8e71-e183fe72d2bb@squashfs.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/29 7:18, Phillip Lougher wrote:
> On 26/08/2022 07:19, Xiaoming Ni wrote:
>> ping
>>
>>
>> On 2022/8/16 9:00, Xiaoming Ni wrote:
>>> Currently, Squashfs supports multiple decompressor parallel modes. 
>>> However, this
>>> mode can be configured only during kernel building and does not 
>>> support flexible
>>> selection during runtime.
>>>
>>> In the current patch set, the mount parameter "threads=" is added to 
>>> allow users
>>> to select the parallel decompressor mode and configure the number of 
>>> decompressors
>>> when mounting a file system.
>>>
>>> v2: fix warning: sparse: incorrect type in initializer (different 
>>> address spaces)
>>>    Reported-by: kernel test robot <lkp@intel.com>
> 
> I have made an initial review of the patches, and I have the following
> comments.
> 
> Good things about the patch-series.
> 
> 1. In principle I have no objections to making this configurable at
>     mount time.  But, a use-case for why this has become necessary
>     would help in the evaluation.
> 
> 2. In general the code changes are good.  They are predominantly
>     exposing the existing different decompressor functionality into
>     structures which can be selected at mount time.  They do not
>     change existing functionality, and so there are no issues
>     about unexpected regressions.
> 
> Things which I don't like about the patch-series.
> 
> 1. There is no default kernel configuration option to keep the existing
>     behaviour, that is build time selectable only.  There may be many
>     companies/people where for "security" reasons the ability to
>     switch to a more CPU/memory intensive decompressor or more threads
>     is a risk.
> 
>     Yes, I know the new kernel configuration options allow only the
>     selected default decompressor mode to be built.  In theory that
>     will restrict the available decompressors to the single decompressor
>     selected at build time.  So not much different to the current
>     position?  But, if the CONFIG_SQUASHFS_DECOMP_MULTI decompressor
>     is selected, that will now allow more threads to be used than is
No more threads than before the patch.

>     current, where it is currently restricted to num_online_cpus() * 2.
After the patch is installed, the maximum number of threads is still 
num_online_cpus() * 2.

[PATCH v2 2/2] squashfs: Allows users to configure the number of 
decompression threads

+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
+    opts->thread_ops = &squashfs_decompressor_multi;
+    if (num > opts->thread_ops->max_decompressors())
+        num = opts->thread_ops->max_decompressors();
+    opts->thread_num = (int)num;
+    return 0;
+#else

> 
> 2. You have decided to allow the mutiple decompressor implementations
>     to be selected at mount time - but you have also allowed only one
>     decompressor to be built at kernel build time.  This means you
>     end up in the fairly silly situation of having a mount time
>     option which allows the user to select between one decompressor.
>     There doesn't seem much point in having an option which allows
>     nothing to be changed.
When multiple decompression modes are selected during kernel build, or 
only SQUASHFS_DECOMP_MULTI is selected during kernel build, the mount 
parameter "threads=" is meaningful,
However, when only SQUASHFS_DECOMP_SINGLE or 
SQUASHFS_DECOMP_MULTI_PERCPU is selected, the mount parameter "threads=" 
is meaningless.

Thank you for your guidance


> 
> 3. Using thread=<number>, where thread=1 you use SQUASHFS_DECOMP_SINGLE
>     if it has been built, otherwise you fall back to
>     SQUASHFS_DECOMP_MULTI.  This meants the effect of thread=1 is
>     indeterminate and depends on the build options.  I would suggest
>     thread=1 should always mean use SQUASHFS_DECOMP_SINGLE.

SQUASHFS_DECOMP_MULTI and SQUASHFS_DECOMP_SINGLE are selected during 
construction. Thread=1 indicates that SQUASHFS_DECOMP_SINGLEI is used.

If only SQUASHFS_DECOMP_MULTI is selected during construction, thread=1 
indicates that SQUASHFS_DECOMP_MULTI is used, and only one decompression 
thread is created.

Would it be better to provide more flexible mount options for images 
that build only SQUASHFS_DECOMP_MULTI?

> 
> 4. If SQUASHFS_DECOMP_MULTI is selected, there isn't a limit on the
>     maximum amount of threads allowed, and there is no ability to
>     set the maximum number of threads allowed at kernel build time
>     either.
After the patch is installed, the maximum number of threads is still 
num_online_cpus() * 2.

[PATCH v2 2/2] squashfs: Allows users to configure the number of 
decompression threads

+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
+    opts->thread_ops = &squashfs_decompressor_multi;
+    if (num > opts->thread_ops->max_decompressors())
+        num = opts->thread_ops->max_decompressors();
+    opts->thread_num = (int)num;
+    return 0;

Did I misunderstand your question?


> 
> All of the above seems to be a bit of a mess.
> 
> As regards points 1 - 3, personally I would add a default kernel
> configuration option that keeps the existing behaviour, build time
> selectable only, no additional mount time options.  Then a
> kernel configuration option that allows the different decompressors
> to be selected at mount time, but which always builds all the
> decompressors.  This will avoid the silliness of point 2, and
Would it be better to allow flexible selection of decompression mode 
combinations?

> the indeterminate behaviour of point 3.
> 
> As regards point 4, I think you should require the maximum number
> of threads allowable to be determined at build time, this is
> good for security and avoids attempts to use too much CPU
> and memory.  The default at kernel build time should be minimal,
> to avoid cases where an unchanged value can cause a potential
> security hazard on a low end system.  In otherwords it is
> up to the user at build time to set the value to an appropriate
> value for their system.
In patch 2, the maximum number of threads has been limited,
Have I misunderstood your question


> 
> Phillip
> 
> ---
> Phillip Lougher, Squashfs author and maintainer.
> 

Thanks
Xiaoming Ni

>>>
>>> v1: 
>>> https://lore.kernel.org/lkml/20220815031100.75243-1-nixiaoming@huawei.com/ 
>>>
>>> ----
>>>
>>> Xiaoming Ni (2):
>>>    squashfs: add the mount parameter theads=<single|multi|percpu>
>>>    squashfs: Allows users to configure the number of decompression
>>>      threads.
>>>
>>>   fs/squashfs/Kconfig                     | 24 ++++++++--
>>>   fs/squashfs/decompressor_multi.c        | 32 ++++++++------
>>>   fs/squashfs/decompressor_multi_percpu.c | 39 ++++++++++-------
>>>   fs/squashfs/decompressor_single.c       | 23 ++++++----
>>>   fs/squashfs/squashfs.h                  | 39 ++++++++++++++---
>>>   fs/squashfs/squashfs_fs_sb.h            |  4 +-
>>>   fs/squashfs/super.c                     | 77 
>>> ++++++++++++++++++++++++++++++++-
>>>   7 files changed, 192 insertions(+), 46 deletions(-)
>>>
>>
> 
> 
> .

