Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7984A5242E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbiELCuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbiELCuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:50:09 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1856D1A8E39
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:50:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VCypSA6_1652323800;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VCypSA6_1652323800)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 10:50:02 +0800
Subject: Re: [PATCH] RISC-V: Remove IORESOURCE_BUSY flag for no-map reserved
 memory
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        anup@brainfault.org, wangkefeng.wang@huawei.com, rppt@kernel.org,
        alex@ghiti.fr, twd2.me@gmail.com, david@redhat.com,
        seanjc@google.com, petr.pavlu@suse.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, jianghuaming.jhm@alibaba-inc.com,
        huanyi.xj@alibaba-inc.com
References: <20220511111851.559684-1-xianting.tian@linux.alibaba.com>
 <c794b22ed0e91356e2c1a39849a4b893@mailhost.ics.forth.gr>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <de0fb09f-b966-5c42-7ac6-a68fbff2abad@linux.alibaba.com>
Date:   Thu, 12 May 2022 10:50:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c794b22ed0e91356e2c1a39849a4b893@mailhost.ics.forth.gr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/5/12 上午10:32, Nick Kossifidis 写道:
> Hello Xianting,
>
>> ---
>>  arch/riscv/kernel/setup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 834eb652a7b9..71f2966b1474 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -214,7 +214,7 @@ static void __init init_resources(void)
>>
>>          if (unlikely(memblock_is_nomap(region))) {
>>              res->name = "Reserved";
>> -            res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>> +            res->flags = IORESOURCE_MEM;
>>          } else {
>>              res->name = "System RAM";
>>              res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>
> The short story:
>
> This makes sense but we should at least mark them as 
> IORESOURCE_EXCLUSIVE, and also remove IORESOURCE_BUSY from line 192 
> above 
> (https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/riscv/kernel/setup.c#L192).
Thanks Nick for the detailed reply, I will sent V2 patch soon according 
to your suggestion.
>
> The long story:
>
> The spec says about no-map:
>
> "
> Indicates the operating system must not create a virtual mapping
> of the region as part of its standard mapping of system memory,
> nor permit speculative access to it under any circumstances other
> than under the control of the device driver using the region.
> "
>
> It basically says that only the driver that uses the region should be 
> able to create mappings for it and access it, and even that is not 
> enough to prevent speculative access to the region by someone other 
> than the driver. The thing is we can't implement this in a simple way 
> because -to begin with- we don't have a way to pin those regions to 
> specific devices/drivers, the memory-region binding doesn't say 
> anything about that. When using devm_ioremap_resource() the first 
> driver to claim the resource will mark it as busy so other drivers 
> using the same api won't be able to use it, however the region can 
> still be mapped in other ways (e.g. through ioremap directly) so using 
> the resource tree to track/protect the regions marked with no-map 
> isn't enough. They can even be accessed from userspace through 
> /dev/mem unless we add them to the resource tree as IORESOURCE_MEM and 
> enable/set CONFIG_IO_STRICT_DEVMEM/iomem=strict, but even then in case 
> the corresponding ioresource isn't busy (e.g. hasn't been claimed by a 
> driver yet through devm_ioremap_resource) we still have to mark them 
> as IORESOURCE_EXCLUSIVE for iomem_is_exclusive() to do the trick 
> (https://elixir.bootlin.com/linux/v5.18-rc6/source/kernel/resource.c#L1739) 
> and prevent access through /dev/mem.
>
> Finally the definition of no-map and the definition of MEMBLOCK_NOMAP 
> are not the same, all MEMBLOCK_NOMAP says is "don't add to kernel 
> direct mapping" so ioremap that uses vmalloc can still be used by 
> everyone, in general it's a mess. It becomes worse, if you mark a 
> reserved-memory region with no-map and that region overlaps with 
> /memory, early_init_dt_reserve_memory_arch() will isolate it, mark it 
> as MEMBLOCK_NOMAP and won't add it to memblock.reserved, if it doesn't 
> overlap it will just ignore it and still not add it to 
> memblock.reserved. So if we want to add a reserved-memory region that 
> doesn't overlap with /memory (a valid scenario allowed by the 
> binding), there is no way to mark it with no-map.
>
> When I wrote that code I was looking for a way to prevent access to 
> reserved regions through /dev/mem and by other drivers, regardless of 
> being part of /memory or not, and since I couldn't mark them with 
> no-map to track them because of early_init_dt_reserve_memory_arch(), I 
> marked them as busy and then used them from the driver with ioremap 
> directly. It was a temporary measure until I had a better approach 
> (e.g. override ioremap / devmem_is_allowed like other archs do) but I 
> never got the time to finish it, sorry for the mess !
>
> Regards,
> Nick
