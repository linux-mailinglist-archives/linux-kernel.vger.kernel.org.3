Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E1753F34B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiFGBWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiFGBVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:21:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B11190CF8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:21:47 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LHCGn27T4zjXPP;
        Tue,  7 Jun 2022 09:20:49 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 09:21:45 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 09:21:44 +0800
Message-ID: <b2a45f97-0f97-6621-bb7e-11f51282c468@huawei.com>
Date:   Tue, 7 Jun 2022 09:21:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] RISC-V: Add fixup to support fast call of
 crash_kexec()
Content-Language: en-US
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <philipp.tomsich@vrull.eu>,
        <ebiederm@xmission.com>, <heiko@sntech.de>,
        <vitaly.wool@konsulko.com>, <tongtiangen@huawei.com>,
        <guoren@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220606123750.2884245-1-xianting.tian@linux.alibaba.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220606123750.2884245-1-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/6 20:37, Xianting Tian wrote:
> Currently, almost all archs (x86, arm64, mips...) support fast call
> of crash_kexec() when "regs && kexec_should_crash()" is true. But
> RISC-V not, it can only enter crash system via panic(). However panic()
> doesn't pass the regs of the real accident scene to crash_kexec(),
> it caused we can't get accurate backtrace via gdb,
> 	$ riscv64-linux-gnu-gdb vmlinux vmcore
> 	Reading symbols from vmlinux...
> 	[New LWP 95]
> 	#0  console_unlock () at kernel/printk/printk.c:2557
> 	2557                    if (do_cond_resched)
> 	(gdb) bt
> 	#0  console_unlock () at kernel/printk/printk.c:2557
> 	#1  0x0000000000000000 in ?? ()
>
> With the patch we can get the accurate backtrace,
> 	$ riscv64-linux-gnu-gdb vmlinux vmcore
> 	Reading symbols from vmlinux...
> 	[New LWP 95]
> 	#0  0xffffffe00063a4e0 in test_thread (data=<optimized out>) at drivers/test_crash.c:81
> 	81             *(int *)p = 0xdead;
> 	(gdb)
> 	(gdb) bt
> 	#0  0xffffffe00064d5c0 in test_thread (data=<optimized out>) at drivers/test_crash.c:81
> 	#1  0x0000000000000000 in ?? ()
>
> Test code to produce NULL address dereference in test_crash.c,
> 	void *p = NULL;
> 	*(int *)p = 0xdead;
>
> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
> Changes from v1:
> - simplify the commit message
> Changes from v2:
> - add fixup in title
> ---
>   arch/riscv/kernel/traps.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index b40426509244..39d0f8bba4b4 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -16,6 +16,7 @@
>   #include <linux/mm.h>
>   #include <linux/module.h>
>   #include <linux/irq.h>
> +#include <linux/kexec.h>
>   
>   #include <asm/asm-prototypes.h>
>   #include <asm/bug.h>
> @@ -44,6 +45,9 @@ void die(struct pt_regs *regs, const char *str)
>   
>   	ret = notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSEGV);
>   
> +	if (regs && kexec_should_crash(current))
> +		crash_kexec(regs);
> +

It seems that the regs won't be null, right? except that,

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>   	bust_spinlocks(0);
>   	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>   	spin_unlock_irq(&die_lock);
