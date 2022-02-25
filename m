Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC3B4C3B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbiBYCJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiBYCJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:09:18 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 130AD1AF8D6;
        Thu, 24 Feb 2022 18:08:45 -0800 (PST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxSMkrOhhi_bUGAA--.7957S3;
        Fri, 25 Feb 2022 10:08:44 +0800 (CST)
Subject: Re: [PATCH] MIPS: Refactor early_parse_mem() to fix mem= parameter
To:     Youling Tang <tangyouling@loongson.cn>
References: <1645707132-10121-1-git-send-email-yangtiezhu@loongson.cn>
 <20d9c6d4-7df4-8a26-4b0f-a5a192cae78d@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <49f2ebe6-406a-9646-3384-224d0be77b1c@loongson.cn>
Date:   Fri, 25 Feb 2022 10:08:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20d9c6d4-7df4-8a26-4b0f-a5a192cae78d@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxSMkrOhhi_bUGAA--.7957S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCry8Wr18GF4fCw17Jr45trb_yoW5Zry7pw
        4xAa4fKFs8JFnrZa4xtrn3XryrZwn7CFyIqa42kwn5Ar1qkr1xGF1IgF4ruryIqrW8A3W0
        vF1qqF9Y939Fy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfU0GYLUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/25/2022 09:12 AM, Youling Tang wrote:
> Hi, Tiezhu
>
> On 02/24/2022 08:52 PM, Tiezhu Yang wrote:
>> According to Documentation/admin-guide/kernel-parameters.txt,
>> the kernel command-line parameter mem= means "Force usage of
>> a specific amount of memory", but when add "mem=3G" to the
>> command-line, kernel boot hangs in sparse_init().
>>
>> This commit is similar with the implementation of the other
>> archs such as arm64, powerpc and riscv, refactor the function
>> early_parse_mem() and then use memblock_enforce_memory_limit()
>> to limit the memory size.
>>
>> With this patch, when add "mem=3G" to the command-line, the
>> kernel boots successfully, we can see the following messages:
>>
>>    [    0.000000] Memory limited to 3072MB
>>    ...
>>    [    0.000000] Memory: 2991952K/3145728K available (...)
>>
>> After login, the output of free command is consistent with the
>> above log.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   arch/mips/kernel/setup.c | 25 ++++++++-----------------
>>   1 file changed, 8 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> index f979adf..2917412 100644
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -339,27 +339,15 @@ static void __init bootmem_init(void)
>>   #endif    /* CONFIG_SGI_IP27 */
>>     static int usermem __initdata;
>> +static phys_addr_t memory_limit;
>>     static int __init early_parse_mem(char *p)
>>   {
>> -    phys_addr_t start, size;
>> -
>> -    /*
>> -     * If a user specifies memory size, we
>> -     * blow away any automatically generated
>> -     * size.
>> -     */
>> -    if (usermem == 0) {
>> -        usermem = 1;
>> -        memblock_remove(memblock_start_of_DRAM(),
>> -            memblock_end_of_DRAM() - memblock_start_of_DRAM());
>> -    }
>> -    start = 0;
>> -    size = memparse(p, &p);
>> -    if (*p == '@')
>> -        start = memparse(p + 1, &p);
>> +    if (!p)
>> +        return 1;
>>   -    memblock_add(start, size);
>> +    memory_limit = memparse(p, &p) & PAGE_MASK;
>> +    pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
>>         return 0;
>
> After applying this patch, my guess is that the kdump operation will fail.
>
> In the MIPS architecture, when the kdump operation is performed, a
> "mem=YM@XM" parameter will be added to the capture kernel (added by
> kexec-tools), indicating that the available memory range of the
> capture kernel is [X, X+Y).
>
> After the "mem" parameter is changed to the above, there will be only
> a similar parsing function like "mem=3G", and the type like
> "mem=128M@64M" cannot be correctly parsed.

Hi Youling,

Don't worry, it is another issue, I will take that into account
once this patch is applied.

This commit is the first step to fix the issue about mem=limit,
I think it is possible to support mem=limit@base and I will do
that later.

Thanks,
Tiezhu

>
> Thanks,
> Youling.
>>   }
>> @@ -633,6 +621,9 @@ static void __init arch_mem_init(char **cmdline_p)
>>         parse_early_param();
>>   +    /* Limit the memory size via mem= command-line parameter */
>> +    memblock_enforce_memory_limit(memory_limit);
>> +
>>       if (usermem)
>>           pr_info("User-defined physical RAM map overwrite\n");
>>

