Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48DC5823EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiG0KMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiG0KMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:12:20 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E44A625A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:12:19 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.17])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1oGe1X-0065Nk-78; Wed, 27 Jul 2022 11:12:15 +0100
Message-ID: <20a94c3c-85ed-2227-458e-60c780fd4ad7@codethink.co.uk>
Date:   Wed, 27 Jul 2022 11:12:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
Content-Language: en-GB
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv@lists.infradead.org, Nikita Shubin <n.shubin@yadro.com>
References: <20220727043829.151794-1-apatel@ventanamicro.com>
 <724f176b-02f1-b171-726f-16158c650896@codethink.co.uk>
 <CAAhSdy1tnTDv0AVyo=5FD=aE070ds6qYGGhdup+8jUqr3M66qA@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAAhSdy1tnTDv0AVyo=5FD=aE070ds6qYGGhdup+8jUqr3M66qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2022 11:06, Anup Patel wrote:
> On Wed, Jul 27, 2022 at 2:25 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
>> On 27/07/2022 05:38, Anup Patel wrote:
>>> Identifying the underlying RISC-V implementation can be important
>>> for some of the user space applications. For example, the perf tool
>>> uses arch specific CPU implementation id (i.e. CPUID) to select a
>>> JSON file describing custom perf events on a CPU.
>>>
>>> Currently, there is no way to identify RISC-V implementation so we
>>> add mvendorid, marchid, and mimpid to /proc/cpuinfo output.
>>>
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> Tested-by: Nikita Shubin <n.shubin@yadro.com>
>>> ---
>>> Changes since v1:
>>>    - Use IS_ENABLED() to check CONFIG defines
>>>    - Added RB and TB tags in commit description
>>> ---
>>>    arch/riscv/kernel/cpu.c | 51 +++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 51 insertions(+)
>>>
>>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>>> index fba9e9f46a8c..04bcc91c91ea 100644
>>> --- a/arch/riscv/kernel/cpu.c
>>> +++ b/arch/riscv/kernel/cpu.c
>>> @@ -3,10 +3,13 @@
>>>     * Copyright (C) 2012 Regents of the University of California
>>>     */
>>>
>>> +#include <linux/cpu.h>
>>>    #include <linux/init.h>
>>>    #include <linux/seq_file.h>
>>>    #include <linux/of.h>
>>> +#include <asm/csr.h>
>>>    #include <asm/hwcap.h>
>>> +#include <asm/sbi.h>
>>>    #include <asm/smp.h>
>>>    #include <asm/pgtable.h>
>>>
>>> @@ -64,6 +67,50 @@ int riscv_of_parent_hartid(struct device_node *node)
>>>    }
>>>
>>>    #ifdef CONFIG_PROC_FS
>>> +
>>> +struct riscv_cpuinfo {
>>> +     unsigned long mvendorid;
>>> +     unsigned long marchid;
>>> +     unsigned long mimpid;
>>> +};
>>> +static DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>>> +
>>> +static int riscv_cpuinfo_starting(unsigned int cpu)
>>> +{
>>> +     struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
>>> +
>>> +#if IS_ENABLED(CONFIG_RISCV_SBI)
>>> +     ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
>>> +     ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
>>> +     ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
>>
>> how about:
>>
>>          if (IS_ENABLED(CONFIG_RISCV_SBI)) {
>>                  ...
>>          } ... {
>>
>> or maybe even:
>>
>>
>>          if (IS_ENABLED(CONFIG_RISCV_SBI)) {
>>                  if (sbi_spec_is_0_1()) {
>>                          ...
>>                  }
>>          } ... {
>>
>> would mean better compile coverage (at the slight exepnese of
>> having "false" sbi_spec_is_0_1() implemenation
> 
> Most of the sbi_xyz() functions are not available for NoMMU
> kernel so using "if (IS_ENABLED())" results in compile error.

How about defining "false" versions for no-mmu case and try
and avoid these #if mountains?

>>
>>> +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
>>> +     ci->mvendorid = csr_read(CSR_MVENDORID);
>>> +     ci->marchid = csr_read(CSR_MARCHID);
>>> +     ci->mimpid = csr_read(CSR_MIMPID);
>>> +#else
>>> +     ci->mvendorid = 0;
>>> +     ci->marchid = 0;
>>> +     ci->mimpid = 0;
>>> +#endif
>>
>> Would it be easier to zero out all the fields first and then fill them
>> in if supported?
> 
> Clearing out fields before "#if" ladder results in dead assignments.

Not sure which is worse here, the #if ladder or some possibly dead
assignments.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
