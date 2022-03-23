Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0934E4B01
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiCWCoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbiCWCoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:44:07 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90ED5673ED;
        Tue, 22 Mar 2022 19:42:37 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxaswUiTpiuWQOAA--.13880S3;
        Wed, 23 Mar 2022 10:42:29 +0800 (CST)
Subject: Re: [PATCH 3/3] MIPS: Use memblock_add_node() in early_parse_mem()
 under CONFIG_NUMA
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <1647615920-23103-1-git-send-email-yangtiezhu@loongson.cn>
 <1647615920-23103-4-git-send-email-yangtiezhu@loongson.cn>
 <33241bd3-2f12-954c-6701-56cf563060bb@flygoat.com>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <fb188614-0301-3255-c31c-3d443cf17b91@loongson.cn>
Date:   Wed, 23 Mar 2022 10:42:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <33241bd3-2f12-954c-6701-56cf563060bb@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxaswUiTpiuWQOAA--.13880S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WryDGw4xKFW3ZFyUur4UArb_yoW8urW5pF
        1qkFWrKF4DXFyjgay8A390kw13t3Z5GryftFyUW34UZ3Wvqw17JrsavF1DtryjqayxtF40
        qFyfWw15ZF409w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUgVyxUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/22/2022 09:19 PM, Jiaxun Yang wrote:
>
>
> 在 2022/3/18 15:05, Tiezhu Yang 写道:
>> Use memblock_add_node to add new memblock region within a NUMA node
>> in early_parse_mem() under CONFIG_NUMA, otherwise the mem parameter
>> can not work well.
>
> Hi Tiezhu,
>
> pa_to_nid doesn't exist when CONFIG_NUME is disabled.
> So probably you want #ifdef macro instead ？

Hi Jiaxun,

Thank you for your reply.

As far as I can tell, if CONFIG_NUMA is set, IS_ENABLED(CONFIG_NUMA)
is 1, pa_to_nid() is defined in the platform dependent header file:

	arch/mips/include/asm/mach-ip27/mmzone.h
	arch/mips/include/asm/mach-loongson64/mmzone.h

if CONFIG_NUMA is not set, IS_ENABLED(CONFIG_NUMA) is 0, pa_to_nid()
is always 0 which is defined in arch/mips/include/asm/mmzone.h:

	#ifdef CONFIG_NUMA
	# include <mmzone.h>
	#endif

	#ifndef pa_to_nid
	#define pa_to_nid(addr) 0
	#endif

So pa_to_nid() is defined under both CONFIG_NUMA and !CONFIG_NUMA,
there is no build error.

Additionally, use #ifdef CONFIG_NUMA is also OK, but I prefer to
use IS_ENABLED(CONFIG_NUMA).

If I am missing something, please let me know, thank you.

Thanks,
Tiezhu

>
> Thanks.
> - Jiaxun
>
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   arch/mips/kernel/setup.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> index c8c8f60..50cdc08 100644
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -37,6 +37,7 @@
>>   #include <asm/cdmm.h>
>>   #include <asm/cpu.h>
>>   #include <asm/debug.h>
>> +#include <asm/mmzone.h>
>>   #include <asm/sections.h>
>>   #include <asm/setup.h>
>>   #include <asm/smp-ops.h>
>> @@ -378,7 +379,10 @@ static int __init early_parse_mem(char *p)
>>               memblock_end_of_DRAM() - memblock_start_of_DRAM());
>>       }
>>   -    memblock_add(start, size);
>> +    if (IS_ENABLED(CONFIG_NUMA))
>> +        memblock_add_node(start, size, pa_to_nid(start), MEMBLOCK_NONE);
>> +    else
>> +        memblock_add(start, size);
>>         return 0;
>>   }

