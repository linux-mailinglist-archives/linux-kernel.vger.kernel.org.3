Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28590509490
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 03:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383596AbiDUBPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 21:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiDUBPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:15:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BF513CFA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:13:04 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KkKKK5QPSzhXZd;
        Thu, 21 Apr 2022 09:12:53 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 09:13:02 +0800
Received: from [10.174.177.133] (10.174.177.133) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 09:13:01 +0800
Subject: Re: [RFC PATCH -next v2 0/4] arm64/ftrace: support dynamic trampoline
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <zengshun.wu@outlook.com>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220420141143.23286faa@gandalf.local.home>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <5ddc2722-4489-f66d-552d-1f4c755b5d30@huawei.com>
Date:   Thu, 21 Apr 2022 09:13:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20220420141143.23286faa@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.133]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/21 2:11, Steven Rostedt 写道:
> Is this going anywhere?
>
> -- Steve

Not yet, Steve, ftrace_location() looks has no help to find a right 
rec->ip in our case,

ftrace_location() can find a right rec->ip when input ip is in the range 
between

sym+0 and sym+$end, but our question is how to  identify rec->ip from 
__mcount_loc,

this changed the patchable entry before bti to after in gcc:

    [1] https://reviews.llvm.org/D73680

gcc tells the place of first nop of the 5 NOPs when using 
-fpatchable-function-entry=5,3,

but not tells the first nop after bti, so we don't know how to adjust 
our rec->ip for ftrace.

>
>
> On Wed, 16 Mar 2022 18:01:28 +0800
> Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
>> This implements dynamic trampoline in ARM64, as reference said, we
>> complete whole design of supporting long jump in dynamic trampoline:
>>
>>     .text section:
>>       funcA:         |    funcA():        funcB():|
>>        `->  +-----+  |    |   ...         mov x9  |
>>             | ... |  |    |   adrp   <-   bl  <>  |
>>             | nop |  |    |   mov
>>             | nop |  |    |   br   x16 ---+
>>       funcB | nop |  |                    | ftrace_(regs_)caller_tramp:
>>        `->  +-----+  |                    `--> +---------------------+
>>             | nop |  |                         | ...                 |
>>             | nop |  |       ftrace callsite   +---------------------+
>>             | ... |  |                `----->  | PLT entry:          |
>>             | nop |  |                         |       adrp          |
>>             | nop |  |                         |       add           |
>>      funcC: | nop |  | ftrace graph callsite   |       br   x16      |
>>        `->  +-----+  |                `----->  +---------------------+
>>             | nop |  |                         | ...                 |
>>             | nop |  |                         +---------------------+
>>
>> But there is still a tricky problem that is how to adjust tracing ip,
>> waiting to be solved:
>>
>> For ARM64, somecases there may be extra instructions inserted into the
>> head of tracable functions(but not all) by compiler, for instance BTI[1].
>>
>> This dump vmlinux with CONFIG_BTI=y:
>>
>> (1) function gic_handle_irq has bti in its head, so we adjust rec->ip+=5 to last nop
>>      ffffffc0080100e0:       d53cd042        mrs     x2, tpidr_el2
>>              ...
>>      ffffffc0080100f0:       d503201f        nop     //__mcount_loc tells the rec->ip
>>      ffffffc0080100f4:       d503201f        nop
>>      ffffffc0080100f8:       d503201f        nop
>>
>>      ffffffc0080100fc <gic_handle_irq>:
>>      ffffffc0080100fc:       d503245f        bti     c
>>      ffffffc008010100:       d503201f        nop
>>      ffffffc008010104:       d503201f        nop     //we adjust origin rec->ip+5 to here
>>      ffffffc008010108:       d503233f        paciasp
>> (2) name_to_dev_t.part.0 do not has bti in its head, so we should adjust rec->ip+=4 to last nop
>>      ffff8000080137d4:       d503201f        nop
>>      ffff8000080137d8:       d503201f        nop
>>      ffff8000080137dc:       d503201f        nop
>>      
>>      ffff8000080137e0 <name_to_dev_t.part.0>:
>>      ffff8000080137e0:       d503201f        nop
>>      ffff8000080137e4:       d503201f        nop
>>      ffff8000080137e8:       d503233f        paciasp
>>
>> So at this time we have no idea to identify rec->ip for each tracable function.
>>
>> we are looking forward to follow-up discussions.
>>
>> References:
>> [1] https://developer.arm.com/documentation/100076/0100/a64-instruction-set-reference/a64-general-instructions/bti
>> [2] https://lore.kernel.org/linux-arm-kernel/20200109142736.1122-1-cj.chengjian@huawei.com/
>>
>> Cheng Jian (4):
>>    arm64: introduce aarch64_insn_gen_load_literal
>>    arm64/ftrace: introduce ftrace dynamic trampoline entrances
>>    arm64/ftrace: support dynamically allocated trampolines
>>    arm64/ftrace: implement long jump for dynamic trampolines
>>
>>   arch/arm64/Makefile              |   2 +-
>>   arch/arm64/include/asm/ftrace.h  |  10 +-
>>   arch/arm64/include/asm/insn.h    |   6 +
>>   arch/arm64/include/asm/module.h  |   9 +
>>   arch/arm64/kernel/entry-ftrace.S |  88 ++++++--
>>   arch/arm64/kernel/ftrace.c       | 366 ++++++++++++++++++++++++++++---
>>   arch/arm64/kernel/module-plts.c  |  50 +++++
>>   arch/arm64/lib/insn.c            |  49 +++++
>>   8 files changed, 532 insertions(+), 48 deletions(-)
>>
> .
