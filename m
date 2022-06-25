Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2655A601
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 04:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiFYCKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 22:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFYCKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 22:10:16 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51A0C517DA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 19:10:14 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT093brZiw59YAA--.3186S3;
        Sat, 25 Jun 2022 10:09:59 +0800 (CST)
Subject: Re: [PATCH v2 2/2] LoongArch: No need to call RESTORE_ALL_AND_RET for
 all syscalls
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1655806074-17454-1-git-send-email-yangtiezhu@loongson.cn>
 <1655806074-17454-3-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H6YYhMAyOG+-PDKiLBv1fDoFmkQUSBa4zt=Lf4=HZGxHQ@mail.gmail.com>
 <1a431c16-ecef-f7e9-4c4f-936e4bb3aeea@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d782be07-1cfa-626f-d9f5-d151bd091214@loongson.cn>
Date:   Sat, 25 Jun 2022 10:09:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1a431c16-ecef-f7e9-4c4f-936e4bb3aeea@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxT093brZiw59YAA--.3186S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF17XF4kXw47GF1xGry3Arb_yoW3CF15pF
        WxAFn3KF4DWryUArZ29w4kWFZ0yas3WF15Xr40kFWIkw1v93srJryqvFWjkFyqgw4rCr40
        qay8t3s2gr45J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUomiiDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc loongarch@lists.linux.dev
Arnd Bergmann <arnd@arndb.de>
Guo Ren <guoren@kernel.org>

On 06/23/2022 08:43 AM, Tiezhu Yang wrote:
> Cc Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> On 06/22/2022 06:01 PM, Huacai Chen wrote:
>> Hi, Tiezhu,
>>
>> On Tue, Jun 21, 2022 at 6:08 PM Tiezhu Yang <yangtiezhu@loongson.cn>
>> wrote:
>>>
>>> In handle_syscall, it is unnecessary to call RESTORE_ALL_AND_RET
>>> for all syscalls.
>>>
>>> (1) rt_sigreturn call RESTORE_ALL_AND_RET.
>>> (2) The other syscalls call RESTORE_STATIC_SOME_SP_AND_RET.
>>>
>>> This patch only adds the minimal changes as simple as possible
>>> to reduce the code complexity, at the same time, it can reduce
>>> many load instructions.
>>>
>>> Here are the test environments:
>>>
>>>   Hardware: Loongson-LS3A5000-7A1000-1w-A2101
>>>   Firmware: UDK2018-LoongArch-A2101-pre-beta8 [1]
>>>   System: loongarch64-clfs-system-5.0 [2]
>>>
>>> The system passed functional testing used with the following
>>> test case without and with this patch:
>>>
>>>   git clone https://github.com/hevz/sigaction-test.git
>>>   cd sigaction-test
>>>   make check
>>>
>>> Additionally, use UnixBench syscall to test the performance:
>>>
>>>   git clone https://github.com/kdlucas/byte-unixbench.git
>>>   cd byte-unixbench/UnixBench/
>>>   make
>>>   pgms/syscall 600
>>>
>>> In order to avoid the performance impact, add init=/bin/bash
>>> to the boot cmdline.
>>>
>>> Here is the test result, the bigger the better, it shows about
>>> 1.2% gain tested with close, getpid and exec [3]:
>>>
>>>   duration  without_this_patch  with_this_patch
>>>   600 s     626558267 lps       634244079 lps
>>>
>>> [1] https://github.com/loongson/Firmware/tree/main/5000Series/PC/A2101
>>> [2]
>>> https://github.com/sunhaiyong1978/CLFS-for-LoongArch/releases/tag/5.0
>>> [3]
>>> https://github.com/kdlucas/byte-unixbench/blob/master/UnixBench/src/syscall.c
>>>
>> I test your patch and the whole UnixBench result is like this:
>>
>> Before patch, single thread:
>>
>> System Benchmarks Index Values               BASELINE       RESULT
>> INDEX
>> Dhrystone 2 using register variables         116700.0    9235787.7
>> 791.4
>> Double-Precision Whetstone                       55.0       2758.7
>> 501.6
>> Execl Throughput                                 43.0       2386.8
>> 555.1
>> File Copy 1024 bufsize 2000 maxblocks          3960.0     191752.0
>> 484.2
>> File Copy 256 bufsize 500 maxblocks            1655.0      78737.9
>> 475.8
>> File Copy 4096 bufsize 8000 maxblocks          5800.0     297402.5
>> 512.8
>> Pipe Throughput                               12440.0     353658.1
>> 284.3
>> Pipe-based Context Switching                   4000.0     120140.8
>> 300.4
>> Process Creation                                126.0       5735.0
>> 455.2
>> Shell Scripts (1 concurrent)                     42.4       2701.5
>> 637.1
>> Shell Scripts (8 concurrent)                      6.0        894.9
>> 1491.5
>> System Call Overhead                          15000.0     557467.4
>> 371.6
>>
>> ========
>> System Benchmarks Index Score
>> 516.1
>>
>> After patch, single thread:
>>
>> System Benchmarks Index Values               BASELINE       RESULT
>> INDEX
>> Dhrystone 2 using register variables         116700.0    9235688.9
>> 791.4
>> Double-Precision Whetstone                       55.0       2758.7
>> 501.6
>> Execl Throughput                                 43.0       2377.8
>> 553.0
>> File Copy 1024 bufsize 2000 maxblocks          3960.0     192545.5
>> 486.2
>> File Copy 256 bufsize 500 maxblocks            1655.0      79735.0
>> 481.8
>> File Copy 4096 bufsize 8000 maxblocks          5800.0     299621.9
>> 516.6
>> Pipe Throughput                               12440.0     354969.1
>> 285.3
>> Pipe-based Context Switching                   4000.0     118307.5
>> 295.8
>> Process Creation                                126.0       5757.0
>> 456.9
>> Shell Scripts (1 concurrent)                     42.4       2695.4
>> 635.7
>> Shell Scripts (8 concurrent)                      6.0        894.4
>> 1490.6
>> System Call Overhead                          15000.0     563582.7
>> 375.7
>>
>> ========
>> System Benchmarks Index Score
>> 517.0
>>
>> Before patch, multi-threads:
>>
>> System Benchmarks Index Values               BASELINE       RESULT
>> INDEX
>> Dhrystone 2 using register variables         116700.0   36943633.4
>> 3165.7
>> Double-Precision Whetstone                       55.0      11035.8
>> 2006.5
>> Execl Throughput                                 43.0       8800.1
>> 2046.5
>> File Copy 1024 bufsize 2000 maxblocks          3960.0     277638.3
>> 701.1
>> File Copy 256 bufsize 500 maxblocks            1655.0      92530.5
>> 559.1
>> File Copy 4096 bufsize 8000 maxblocks          5800.0     524344.3
>> 904.0
>> Pipe Throughput                               12440.0    1359237.2
>> 1092.6
>> Pipe-based Context Switching                   4000.0     571511.4
>> 1428.8
>> Process Creation                                126.0      20823.3
>> 1652.6
>> Shell Scripts (1 concurrent)                     42.4       6883.9
>> 1623.6
>> Shell Scripts (8 concurrent)                      6.0        981.7
>> 1636.1
>> System Call Overhead                          15000.0    2029539.8
>> 1353.0
>>
>> ========
>> System Benchmarks Index Score
>> 1367.4
>>
>> After patch, multi-threads:
>>
>> System Benchmarks Index Values               BASELINE       RESULT
>> INDEX
>> Dhrystone 2 using register variables         116700.0   36943793.6
>> 3165.7
>> Double-Precision Whetstone                       55.0      11035.5
>> 2006.4
>> Execl Throughput                                 43.0       8768.3
>> 2039.1
>> File Copy 1024 bufsize 2000 maxblocks          3960.0     277962.9
>> 701.9
>> File Copy 256 bufsize 500 maxblocks            1655.0      92059.7
>> 556.3
>> File Copy 4096 bufsize 8000 maxblocks          5800.0     525937.5
>> 906.8
>> Pipe Throughput                               12440.0    1361566.6
>> 1094.5
>> Pipe-based Context Switching                   4000.0     575835.4
>> 1439.6
>> Process Creation                                126.0      20426.4
>> 1621.1
>> Shell Scripts (1 concurrent)                     42.4       6877.5
>> 1622.0
>> Shell Scripts (8 concurrent)                      6.0        980.3
>> 1633.8
>> System Call Overhead                          15000.0    2049771.6
>> 1366.5
>>
>> ========
>> System Benchmarks Index Score
>> 1366.6
>>
>> From my point of view, the benefit is negligible.
>
> There is another way to look at what is going on.
> This patch is related with syscall, I prefer to
> observe "System Call Overhead" in the test results.
>
> Here are the INDEX of "System Call Overhead" in your test results:
>
> thread   before_patch    after_patch    gain
> single   371.6           375.7          1.103%
> multi    1353.0          1366.5         0.998%
>
> For now, I would like to wait for other people's review.
> If the conclusion is the optimization is meaningless,
> I am fine with ignoring this patch.

Any comments will be much appreciated.

Here is the link:

https://lore.kernel.org/lkml/1655806074-17454-3-git-send-email-yangtiezhu@loongson.cn/

Thanks,
Tiezhu

>
> Thanks,
> Tiezhu
>
>>
>>
>> Huacai
>>
>>>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> ---
>>>  arch/loongarch/include/asm/stackframe.h |  5 +++++
>>>  arch/loongarch/kernel/entry.S           | 15 +++++++++++++++
>>>  2 files changed, 20 insertions(+)
>>>
>>> diff --git a/arch/loongarch/include/asm/stackframe.h
>>> b/arch/loongarch/include/asm/stackframe.h
>>> index 4ca9530..551ab8f 100644
>>> --- a/arch/loongarch/include/asm/stackframe.h
>>> +++ b/arch/loongarch/include/asm/stackframe.h
>>> @@ -216,4 +216,9 @@
>>>         RESTORE_SP_AND_RET \docfi
>>>         .endm
>>>
>>> +       .macro  RESTORE_STATIC_SOME_SP_AND_RET docfi=0
>>> +       RESTORE_STATIC \docfi
>>> +       RESTORE_SOME \docfi
>>> +       RESTORE_SP_AND_RET \docfi
>>> +       .endm
>>>  #endif /* _ASM_STACKFRAME_H */
>>> diff --git a/arch/loongarch/kernel/entry.S
>>> b/arch/loongarch/kernel/entry.S
>>> index d5b3dbc..c764c99 100644
>>> --- a/arch/loongarch/kernel/entry.S
>>> +++ b/arch/loongarch/kernel/entry.S
>>> @@ -14,6 +14,7 @@
>>>  #include <asm/regdef.h>
>>>  #include <asm/stackframe.h>
>>>  #include <asm/thread_info.h>
>>> +#include <asm/unistd.h>
>>>
>>>         .text
>>>         .cfi_sections   .debug_frame
>>> @@ -62,9 +63,23 @@ SYM_FUNC_START(handle_syscall)
>>>         li.d    tp, ~_THREAD_MASK
>>>         and     tp, tp, sp
>>>
>>> +       /* Syscall number held in a7, we can store it in TI_SYSCALL. */
>>> +        LONG_S  a7, tp, TI_SYSCALL
>>> +
>>>         move    a0, sp
>>>         bl      do_syscall
>>>
>>> +       /*
>>> +        * Syscall number held in a7 which is stored in TI_SYSCALL.
>>> +        * rt_sigreturn call RESTORE_ALL_AND_RET.
>>> +        * The other syscalls call RESTORE_STATIC_SOME_SP_AND_RET.
>>> +        */
>>> +       LONG_L  t3, tp, TI_SYSCALL
>>> +       li.w    t4, __NR_rt_sigreturn
>>> +       beq     t3, t4, 1f
>>> +
>>> +       RESTORE_STATIC_SOME_SP_AND_RET
>>> +1:
>>>         RESTORE_ALL_AND_RET
>>>  SYM_FUNC_END(handle_syscall)
>>>
>>> --
>>> 2.1.0
>>>

