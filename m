Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD653B3A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiFBGge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiFBGgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:36:33 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB2021D4B7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:36:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VF9JFIl_1654151783;
Received: from 192.168.1.5(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VF9JFIl_1654151783)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jun 2022 14:36:25 +0800
Subject: Re: [PATCH v3] RISC-V: Mark IORESOURCE_EXCLUSIVE for reserved mem
 instead of IORESOURCE_BUSY
To:     Palmer Dabbelt <palmer@dabbelt.com>, guoren@kernel.org
Cc:     mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        rppt@kernel.org, david@redhat.com, wangborong@cdjrlc.com,
        twd2.me@gmail.com, seanjc@google.com, alex@ghiti.fr,
        petr.pavlu@suse.com, Atish Patra <atishp@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianghuaming.jhm@alibaba-inc.com, heiko@sntech.de
References: <mhng-d1f0bf41-82a3-4e76-98a0-c787ebcd0799@palmer-ri-x1c9>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <a5470d2b-9706-b89d-b6ca-8e18ab812c40@linux.alibaba.com>
Date:   Thu, 2 Jun 2022 14:36:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <mhng-d1f0bf41-82a3-4e76-98a0-c787ebcd0799@palmer-ri-x1c9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/6/2 下午1:57, Palmer Dabbelt 写道:
> On Sun, 29 May 2022 19:47:51 PDT (-0700), guoren@kernel.org wrote:
>> Hi Palmer,
>>
>> Please have a look at this patch which is a critical fixup. Our
>> current riscv implementation has broken the reserved memory.
>
> Putting "fix" somewhere in the subject is generally the best way to do 
> that, this one just looked like a feature and I stumbled into it when 
> going through stuff for this merge window.

Thanks for the advice.

Could you also keep an eye on this patch? 
https://lkml.org/lkml/2022/5/15/140 <https://lkml.org/lkml/2022/5/15/140>

>
> It's in for-next, which is still aimed at 5.19.
>
> Thanks!
>
>>
>> On Wed, May 18, 2022 at 9:34 AM Xianting Tian
>> <xianting.tian@linux.alibaba.com> wrote:
>>>
>>> Commit 00ab027a3b82 ("RISC-V: Add kernel image sections to the 
>>> resource tree")
>>> marked IORESOURCE_BUSY for reserved memory, which caused resource map
>>> failed in subsequent operations of related driver, so remove the
>>> IORESOURCE_BUSY flag. In order to prohibit userland mapping reserved
>>> memory, mark IORESOURCE_EXCLUSIVE for it.
>>>
>>> The code to reproduce the issue,
>>> dts:
>>>         mem0: memory@a0000000 {
>>>                 reg = <0x0 0xa0000000 0 0x1000000>;
>>>                 no-map;
>>>         };
>>>
>>>         &test {
>>>                 status = "okay";
>>>                 memory-region = <&mem0>;
>>>         };
>>>
>>> code:
>>>         np = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
>>>         ret = of_address_to_resource(np, 0, &r);
>>>         base = devm_ioremap_resource(&pdev->dev, &r);
>>>         // base = -EBUSY
>>>
>>> Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the 
>>> resource tree")
>>> Reported-by: Huaming Jiang <jianghuaming.jhm@alibaba-inc.com>
>>> Reviewed-by: Guo Ren <guoren@kernel.org>
>>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
>>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>>> ---
>>> Changes from v2:
>>> - Fix typo in commit message: casued -> caused
>>> - Remove Reviewed-by of Nick Kossifidis, who didn't give Reviewed-by 
>>> actually
>>> - Add Co-developed-by of Nick
>>>
>>> Changes from v1:
>>> - Mark reserved memory as IORESOURCE_EXCLUSIVE, suggested by Nick
>>> ---
>>>  arch/riscv/kernel/setup.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>> index 834eb652a7b9..e0a00739bd13 100644
>>> --- a/arch/riscv/kernel/setup.c
>>> +++ b/arch/riscv/kernel/setup.c
>>> @@ -189,7 +189,7 @@ static void __init init_resources(void)
>>>                 res = &mem_res[res_idx--];
>>>
>>>                 res->name = "Reserved";
>>> -               res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>>> +               res->flags = IORESOURCE_MEM | IORESOURCE_EXCLUSIVE;
>>>                 res->start = 
>>> __pfn_to_phys(memblock_region_reserved_base_pfn(region));
>>>                 res->end = 
>>> __pfn_to_phys(memblock_region_reserved_end_pfn(region)) - 1;
>>>
>>> @@ -214,7 +214,7 @@ static void __init init_resources(void)
>>>
>>>                 if (unlikely(memblock_is_nomap(region))) {
>>>                         res->name = "Reserved";
>>> -                       res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>>> +                       res->flags = IORESOURCE_MEM | 
>>> IORESOURCE_EXCLUSIVE;
>>>                 } else {
>>>                         res->name = "System RAM";
>>>                         res->flags = IORESOURCE_SYSTEM_RAM | 
>>> IORESOURCE_BUSY;
>>> -- 
>>> 2.17.1
>>>
