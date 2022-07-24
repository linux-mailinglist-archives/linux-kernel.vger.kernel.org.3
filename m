Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A8B57F2B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 04:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiGXCiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 22:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXCiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 22:38:14 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4CD13DE2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:38:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VKC1zl0_1658630286;
Received: from 192.168.1.4(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKC1zl0_1658630286)
          by smtp.aliyun-inc.com;
          Sun, 24 Jul 2022 10:38:08 +0800
Subject: Re: [Crash-utility] [PATCH 0/5] Fixups to work with crash tool
To:     Dave Young <dyoung@redhat.com>,
        "Discussion list for crash utility usage, maintenance and development" 
        <crash-utility@redhat.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, huanyi.xj@alibaba-inc.com,
        hschauhan@nulltrace.org, linux-kernel@vger.kernel.org,
        heinrich.schuchardt@canonical.com, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org
References: <20220717101323.370245-1-xianting.tian@linux.alibaba.com>
 <CALu+AoTpiQh7NUJJZs+6A7MCUNWJq=NeSimoF=AVHpRptd36eA@mail.gmail.com>
From:   tianxianting <xianting.tian@linux.alibaba.com>
Message-ID: <afbf1692-9942-b337-4195-a38c0cba793e@linux.alibaba.com>
Date:   Sun, 24 Jul 2022 10:38:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CALu+AoTpiQh7NUJJZs+6A7MCUNWJq=NeSimoF=AVHpRptd36eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/22 下午4:13, Dave Young 写道:
> Hi,
>
> On Sun, 17 Jul 2022 at 18:13, Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> I ever sent the patch 1,2 in the link:
>> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-2-xianting.tian@linux.alibaba.com/
>> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
>> And patch 3,4 in the link:
>> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
>> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/
>>
>> This patch series just put these patches together, and with a new patch 5.
>> these five patches are the fixups for kexec, vmcore and improvements
>> for vmcoreinfo and memory layout dump.
>>
>> The main changes in the five patchs as below,
>> Patch 1: Add a fast call path of crash_kexec() as other Arch(x86, arm64) do.
>> Patch 2: use __smp_processor_id() instead of smp_processor_id() to cleanup
>>           the console prints.
>> Patch 3: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
>>           the development of crash tool as ARM64 already did
>>           (arch/arm64/kernel/crash_core.c).
>> Patch 4: Add modules to virtual kernel memory layout dump.
>> Patch 5: Fixup to get correct kernel mode PC for vmcore
>>
>> With these 5 patches(patch 3 is must), crash tool can work well to analyze
>> a vmcore. The patches for crash tool for RISCV64 is in the link:
>> https://lore.kernel.org/linux-riscv/20220717042929.370022-1-xianting.tian@linux.alibaba.com/
>>
>> Xianting Tian (5):
>>    RISC-V: Fixup fast call of crash_kexec()
>>    RISC-V: use __smp_processor_id() instead of smp_processor_id()
>>    RISC-V: Add arch_crash_save_vmcoreinfo support
> Vmcoreinfo changes need to be documented in
> Documentation/admin-guide/kdump/vmcoreinfo.rst
>
> Otherwise, I suggest to always cc kexec mail list (added in cc) for
> kexec | kdump patches.
>
> thanks, I will fix it in v3.
>>    riscv: Add modules to virtual kernel memory layout dump
>>    RISC-V: Fixup getting correct current pc
>>
>>   arch/riscv/kernel/Makefile          |  1 +
>>   arch/riscv/kernel/crash_core.c      | 29 +++++++++++++++++++++++++++++
>>   arch/riscv/kernel/crash_save_regs.S |  2 +-
>>   arch/riscv/kernel/machine_kexec.c   |  2 +-
>>   arch/riscv/kernel/traps.c           |  4 ++++
>>   arch/riscv/mm/init.c                |  4 ++++
>>   6 files changed, 40 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/riscv/kernel/crash_core.c
>>
>> --
>> 2.17.1
>>
>> --
>> Crash-utility mailing list
>> Crash-utility@redhat.com
>> https://listman.redhat.com/mailman/listinfo/crash-utility
>> Contribution Guidelines: https://github.com/crash-utility/crash/wiki
>>
> Thanks
> Dave
