Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F247A57D90D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiGVDlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVDlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:41:13 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D870F47B91
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:41:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VK3QLxV_1658461267;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VK3QLxV_1658461267)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 11:41:08 +0800
Subject: Re: [RESEND PATCH v2] RISC-V: Add fast call path of crash_kexec()
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        wangkefeng.wang@huawei.com, philipp.tomsich@vrull.eu,
        ebiederm@xmission.com, heiko@sntech.de, vitaly.wool@konsulko.com,
        tongtiangen@huawei.com, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-c42cbd7f-4935-4d16-9150-5504fd06aedd@palmer-mbp2014>
From:   tianxianting <xianting.tian@linux.alibaba.com>
Message-ID: <6412d106-24c0-a2ad-79b9-de6664c8723d@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 11:41:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <mhng-c42cbd7f-4935-4d16-9150-5504fd06aedd@palmer-mbp2014>
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


在 2022/7/22 上午8:11, Palmer Dabbelt 写道:
> On Mon, 06 Jun 2022 01:23:08 PDT (-0700), 
> xianting.tian@linux.alibaba.com wrote:
>> Currently, almost all archs (x86, arm64, mips...) support fast call
>> of crash_kexec() when "regs && kexec_should_crash()" is true. But
>> RISC-V not, it can only enter crash system via panic(). However panic()
>> doesn't pass the regs of the real accident scene to crash_kexec(),
>> it caused we can't get accurate backtrace via gdb,
>>     $ riscv64-linux-gnu-gdb vmlinux vmcore
>>     Reading symbols from vmlinux...
>>     [New LWP 95]
>>     #0  console_unlock () at kernel/printk/printk.c:2557
>>     2557                    if (do_cond_resched)
>>     (gdb) bt
>>     #0  console_unlock () at kernel/printk/printk.c:2557
>>     #1  0x0000000000000000 in ?? ()
>>
>> With the patch we can get the accurate backtrace,
>>     $ riscv64-linux-gnu-gdb vmlinux vmcore
>>     Reading symbols from vmlinux...
>>     [New LWP 95]
>>     #0  0xffffffe00063a4e0 in test_thread (data=<optimized out>) at 
>> drivers/test_crash.c:81
>>     81             *(int *)p = 0xdead;
>>     (gdb)
>>     (gdb) bt
>>     #0  0xffffffe00064d5c0 in test_thread (data=<optimized out>) at 
>> drivers/test_crash.c:81
>>     #1  0x0000000000000000 in ?? ()
>>
>> Test code to produce NULL address dereference in test_crash.c,
>>     void *p = NULL;
>>     *(int *)p = 0xdead;
>>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> Tested-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>> Changes from v1:
>> - simplify the commit message
>> ---
>>  arch/riscv/kernel/traps.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index fe92e119e6a3..e666ebfa2a64 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/module.h>
>>  #include <linux/irq.h>
>> +#include <linux/kexec.h>
>>
>>  #include <asm/asm-prototypes.h>
>>  #include <asm/bug.h>
>> @@ -44,6 +45,9 @@ void die(struct pt_regs *regs, const char *str)
>>
>>      ret = notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSEGV);
>>
>> +    if (regs && kexec_should_crash(current))
>> +        crash_kexec(regs);
>> +
>>      bust_spinlocks(0);
>>      add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>>      spin_unlock_irq(&die_lock);
>
> Thanks, this is on for-next.

Palmer, thanks for the reply,

Last week, I commit a series of 
patches(https://lkml.org/lkml/2022/7/17/64 
<https://lkml.org/lkml/2022/7/17/64>), which contains this one.

This series of patches worked with crash-utility for RISCV64, Could you 
please review it?

We expect 5.19 could support crash-utility, it is a good functionality.

crash-utility patches for RISCV64:

https://lore.kernel.org/all/20220718025346.411758-1-xianting.tian@linux.alibaba.com/ 
<https://lore.kernel.org/all/20220718025346.411758-1-xianting.tian@linux.alibaba.com/>

