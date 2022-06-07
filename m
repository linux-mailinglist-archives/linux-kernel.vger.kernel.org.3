Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D62D53F375
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiFGBqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiFGBqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:46:07 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC979877A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:46:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VFbCL8E_1654566361;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VFbCL8E_1654566361)
          by smtp.aliyun-inc.com;
          Tue, 07 Jun 2022 09:46:02 +0800
Subject: Re: [PATCH v3] RISC-V: Add fixup to support fast call of
 crash_kexec()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        philipp.tomsich@vrull.eu, ebiederm@xmission.com, heiko@sntech.de,
        vitaly.wool@konsulko.com, tongtiangen@huawei.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220606123750.2884245-1-xianting.tian@linux.alibaba.com>
 <b2a45f97-0f97-6621-bb7e-11f51282c468@huawei.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <b1098514-d185-e649-6dea-3c2f01e97ea8@linux.alibaba.com>
Date:   Tue, 7 Jun 2022 09:46:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b2a45f97-0f97-6621-bb7e-11f51282c468@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/6/7 上午9:21, Kefeng Wang 写道:
>
> On 2022/6/6 20:37, Xianting Tian wrote:
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
>> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>> Changes from v1:
>> - simplify the commit message
>> Changes from v2:
>> - add fixup in title
>> ---
>>   arch/riscv/kernel/traps.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index b40426509244..39d0f8bba4b4 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/mm.h>
>>   #include <linux/module.h>
>>   #include <linux/irq.h>
>> +#include <linux/kexec.h>
>>     #include <asm/asm-prototypes.h>
>>   #include <asm/bug.h>
>> @@ -44,6 +45,9 @@ void die(struct pt_regs *regs, const char *str)
>>         ret = notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSEGV);
>>   +    if (regs && kexec_should_crash(current))
>> +        crash_kexec(regs);
>> +
>
> It seems that the regs won't be null, right? except that,

Autually both regs won't be null, But if it is triggered by panic() , 
the regs are got via riscv_crash_save_regs(), which are the regs of that 
moment, but not the real accident scene.

>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
>>       bust_spinlocks(0);
>>       add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>>       spin_unlock_irq(&die_lock);
