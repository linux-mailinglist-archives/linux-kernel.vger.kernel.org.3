Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A95A790A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiHaI3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiHaI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:29:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C435AA4D0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:28:59 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MHcgc5THgzlW0W;
        Wed, 31 Aug 2022 16:25:32 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 16:28:56 +0800
Message-ID: <7cd9d59e-9c5f-bca4-1d77-eeb7f1445979@huawei.com>
Date:   Wed, 31 Aug 2022 16:28:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] arch/riscv: kprobes: implement optprobes
To:     <Conor.Dooley@microchip.com>, <chenguokai17@mails.ucas.ac.cn>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220831041014.1295054-1-chenguokai17@mails.ucas.ac.cn>
 <882e9efc-7222-c3af-e37b-f339789e94c0@microchip.com>
 <2ab8be67-fad5-7bef-6140-43312870d845@huawei.com>
 <8c79280f-ef55-ba38-e1a2-5fd1dbff0114@microchip.com>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <8c79280f-ef55-ba38-e1a2-5fd1dbff0114@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/8/31 15:52, Conor.Dooley@microchip.com 写道:
> On 31/08/2022 08:49, liaochang (A) wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> 在 2022/8/31 15:24, Conor.Dooley@microchip.com 写道:
>>> Hey Chen,
>>>
>>> FYI there is a build warning with this patch:
>>> arch/riscv/kernel/probes/opt.c:34:27: warning: no previous prototype for 'can_kprobe_direct_exec' [-Wmissing-prototypes]
>>>      34 | enum probe_insn __kprobes can_kprobe_direct_exec(kprobe_opcode_t *addr)
>>>
>>> Also, if you run scripts/checkpatch.pl --strict, it will have a
>>> few complaints about code style for you too. Other than that, I
>>> have a few comments for you below:
>>>
>>> On 31/08/2022 05:10, Chen Guokai wrote:
>>>> [You don't often get email from chenguokai17@mails.ucas.ac.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> This patch adds jump optimization support for RISC-V.
>>>
>>> s/This patch adds/Add
>>>
>>>>
>>>> This patch replaces ebreak instructions used by normal kprobes with an
>>>
>>> s/This patch replaces/Replace
>>>
>>>> auipc+jalr instruction pair, at the aim of suppressing the probe-hit
>>>> overhead.
>>>>
>>>> All known optprobe-capable RISC architectures have been using a single
>>>> jump or branch instructions while this patch chooses not. RISC-V has a
>>>> quite limited jump range (4KB or 2MB) for both its branch and jump
>>>> instructions, which prevent optimizations from supporting probes that
>>>> spread all over the kernel.
>>>>
>>>> Auipc-jalr instruction pair is introduced with a much wider jump range
>>>> (4GB), where auipc loads the upper 12 bits to a free register and jalr
>>>> appends the lower 20 bits to form a 32 bit immediate. Note that returning
>>>> from probe handler requires another free register. As kprobes can appear
>>>> almost anywhere inside the kernel, the free register should be found in a
>>>> generic way, not depending on calling convension or any other regulations.
>>>
>>> convention
>>>
>>>>
>>>> The algorithm for finding the free register is inspired by the regiter
>>>
>>> register
>>>
>>>> renaming in modern processors. From the perspective of register renaming, a
>>>> register could be represented as two different registers if two neighbour
>>>> instructions both write to it but no one ever reads. Extending this fact,
>>>> a register is considered to be free if there is no read before its next
>>>> write in the execution flow. We are free to change its value without
>>>> interfering normal execution.
>>>>
>>>> Static analysis shows that 51% instructions of the kernel (default config)
>>>> is capable of being replaced i.e. two free registers can be found at both
>>>> the start and end of replaced instruction pairs while the replaced
>>>> instructions can be directly executed.
>>>>
>>>> Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>>
>>> What does Liao have to do with this patch?
>> I just provide some suggestion to Chen Guokai during development ;)
>> please remove my info from Signed-off-by tag.
> 
> Does that mean that the "copyright 2022 Huawei" is also not accurate?
Inaccurate, please remove "copyright 2022 Huawei",thanks for checking.

>   
> 
> 

-- 
BR,
Liao, Chang
