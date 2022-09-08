Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37835B1B14
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiIHLPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIHLO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:14:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0E146D8D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:14:53 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MNbz72k7LzjWvs;
        Thu,  8 Sep 2022 19:11:15 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 19:14:51 +0800
Message-ID: <c2fcb59f-85a5-fbb5-138f-d02962351a28@huawei.com>
Date:   Thu, 8 Sep 2022 19:14:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] riscv/kprobes: allocate detour buffer from module area
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <mhng-0e2f7f49-2680-4341-83dc-0e7cd042a3fa@palmer-mbp2014>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <mhng-0e2f7f49-2680-4341-83dc-0e7cd042a3fa@palmer-mbp2014>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/8/12 1:09, Palmer Dabbelt 写道:
> On Tue, 28 Jun 2022 18:13:17 PDT (-0700), liaochang1@huawei.com wrote:
>> To address the limitation of PC-relative branch instruction
>> on riscv architecture, detour buffer slot is allocated from
>> a area, the distance of which from kernel should be less than 4GB.
>>
>> For the time being, Modules region always live before the kernel.
>> But Vmalloc region reside far away from kernel, the distance is
>> half of the kernel address space.
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  arch/riscv/kernel/probes/kprobes.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
>> index e6e950b7cf32..bc027a663b17 100644
>> --- a/arch/riscv/kernel/probes/kprobes.c
>> +++ b/arch/riscv/kernel/probes/kprobes.c
>> @@ -6,12 +6,14 @@
>>  #include <linux/extable.h>
>>  #include <linux/slab.h>
>>  #include <linux/stop_machine.h>
>> +#include <linux/moduleloader.h>
>>  #include <asm/ptrace.h>
>>  #include <linux/uaccess.h>
>>  #include <asm/sections.h>
>>  #include <asm/cacheflush.h>
>>  #include <asm/bug.h>
>>  #include <asm/patch.h>
>> +#include <asm/set_memory.h>
>>
>>  #include "decode-insn.h"
>>
>> @@ -86,10 +88,28 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>  #ifdef CONFIG_MMU
>>  void *alloc_insn_page(void)
>>  {
>> +#if defined(CONFIG_MODULES) && defined(CONFIG_64BIT)
>> +    void *page;
>> +
>> +    page = module_alloc(PAGE_SIZE);
>> +    if (!page)
>> +        return NULL;
>> +
>> +    set_vm_flush_reset_perms(page);
>> +    /*
>> +     * First make the page read-only, and only then make it executable to
>> +     * prevent it from being W+X in between.
>> +     */
>> +    set_memory_ro((unsigned long)page, 1);
>> +    set_memory_x((unsigned long)page, 1);
>> +
>> +    return page;
>> +#else
>>      return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
>>                       GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
>>                       VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
>>                       __builtin_return_address(0));
>> +#endif
>>  }
>>  #endif
> 
> This probably shouldn't depend on CONFIG_MODULES, it's just as broken to assume we can jump to the vmalloc region regardless of whether modules are enabled or disabled.  We should be able to just allocate from the jump-safe region either way.
> .

Yes, there is no need to invoke module_alloc to allocate buffer from jump-safe region,
just use __vmalloc_node_range directly, thanks for reminding me.

-- 
BR,
Liao, Chang
