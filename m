Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8A5ABDED
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 10:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiICIyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 04:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiICIyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 04:54:49 -0400
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A962D1F3
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 01:54:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436378|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0832323-0.00195295-0.914815;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.P6puSW6_1662195252;
Received: from 192.168.220.144(mailfrom:victor@allwinnertech.com fp:SMTPD_---.P6puSW6_1662195252)
          by smtp.aliyun-inc.com;
          Sat, 03 Sep 2022 16:54:13 +0800
Message-ID: <b07d8b91-d0d7-fbf1-681c-2801fc77f81c@allwinnertech.com>
Date:   Sat, 3 Sep 2022 16:54:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ARM: mmu: fix access to illegal address when using
 earlycon & memblock=debug
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        yanfei.xu@windriver.com, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220316023356.120595-1-victor@allwinnertech.com>
 <CGME20220831115257eucas1p20d37a01c51e42767860920a936255bd7@eucas1p2.samsung.com>
 <9a425a51-9460-6c4d-e331-5cd5873f8a43@samsung.com>
 <dda053b1-2d4f-153b-b811-78021eae3882@allwinnertech.com>
 <6c14e174-cdb6-c1fc-58cc-d579111d2328@allwinnertech.com>
 <CAL_JsqKEEc=sWdNURUoM8mR675Fz-4VfsFQXxnPCtiOQ5QfM0w@mail.gmail.com>
From:   Victor Hassan <victor@allwinnertech.com>
In-Reply-To: <CAL_JsqKEEc=sWdNURUoM8mR675Fz-4VfsFQXxnPCtiOQ5QfM0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rob,

On 2022/9/1 21:21, Rob Herring wrote:
> On Thu, Sep 1, 2022 at 7:54 AM Victor Hassan <victor@allwinnertech.com> wrote:
>>
>>
>>
>> On 2022/8/31 20:37, Victor Hassan wrote:
>>> On 8/31/2022 7:52 PM, Marek Szyprowski wrote:
>>>> Hi Victor,
>>>>
>>>> On 16.03.2022 03:33, Victor Hassan wrote:
>>>>> earlycon uses fixmap to create a memory map,
>>>>> So we need to close earlycon before closing fixmap,
>>>>> otherwise printk will access illegal addresses.
> 
> How? Due to recent changes in how printk and the consoles work or just
> because create_mapping() can print? In the latter case, the only
> variable input is the phys address. I think most if not all prints
> cannot occur.
> 
>>>>> After creating a new memory map, we open earlycon again.
>>>>>
>>>>> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
>>>>
>>>> This patch landed in linux next-20220831 as commit a76886d117cb ("ARM:
>>>> 9223/1: mmu: fix access to illegal address when using earlycon &
>>>> memblock=debug"). Unfortunately it breaks booting of all my test boards
>>>> which *do not* use earlycon. It can be easily reproduced even with QEMU.
>>>>
>>>> With kernel compiled from multi_v7_defconfig the following setup boots:
>>>>
>>>> $ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append
>>>> "console=ttyAMA0 earlycon" -M virt -smp 2 -m 512
>>>>
>>>> while this one doesn't:
>>>>
>>>> $ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append
>>>> "console=ttyAMA0" -M virt -smp 2 -m 512
>>>>
>>>>
>>>>> ---
>>>>>     arch/arm/mm/mmu.c | 7 +++++++
>>>>>     1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>>>>> index 274e4f73fd33..f3511f07a7d0 100644
>>>>> --- a/arch/arm/mm/mmu.c
>>>>> +++ b/arch/arm/mm/mmu.c
>>>>> @@ -14,6 +14,7 @@
>>>>>     #include <linux/fs.h>
>>>>>     #include <linux/vmalloc.h>
>>>>>     #include <linux/sizes.h>
>>>>> +#include <linux/console.h>
>>>>>     #include <asm/cp15.h>
>>>>>     #include <asm/cputype.h>
>>>>> @@ -1695,6 +1696,9 @@ static void __init early_fixmap_shutdown(void)
>>>>>         pmd_clear(fixmap_pmd(va));
>>>>>         local_flush_tlb_kernel_page(va);
>>>>> +#ifdef CONFIG_FIX_EARLYCON_MEM
>>>>> +    console_stop(console_drivers);
>>>>> +#endif
>>>>>         for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
>>>>>             pte_t *pte;
>>>>>             struct map_desc map;
>>>>> @@ -1713,6 +1717,9 @@ static void __init early_fixmap_shutdown(void)
>>>>>             create_mapping(&map);
>>>>>         }
>>>>> +#ifdef CONFIG_FIX_EARLYCON_MEM
>>>>> +    console_start(console_drivers);
>>>>> +#endif
>>>>>     }
>>>>>     /*
>>>>
>>>> Best regards
>>>
>>> Dear Marek,
>>> Thank you for the notice. I'll figure it out and feed back to you as
>>> soon as possible.
>>>
>>> Regards,
>>> Victor
>>
>> Hi Marek,
>>
>> Sorry, didn't take into account that console_drivers is NULL when
>> earlycon is not used.
>>
>> Here is the patch-v2. Please review:
>>
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index a49f0b9..a240f38 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -14,6 +14,7 @@
>>    #include <linux/fs.h>
>>    #include <linux/vmalloc.h>
>>    #include <linux/sizes.h>
>> +#include <linux/console.h>
>>
>>    #include <asm/cp15.h>
>>    #include <asm/cputype.h>
>> @@ -1730,6 +1731,10 @@
>>          pmd_clear(fixmap_pmd(va));
>>          local_flush_tlb_kernel_page(va);
>>
>> +#ifdef CONFIG_FIX_EARLYCON_MEM
> 
> This is always true for CONFIG_MMU and this file is only built for
> CONFIG_MMU. So you don't need it.

Yes, you are right.

> 
>> +       if (console_drivers)
>> +               console_stop(console_drivers);
> 
> console_drivers is a list, so you are only stopping the 1st one.
> Couldn't console_lock() be used here?
> 

Thanks for the suggestion: console_lock is actually the same as 
console_stop in the test, and the code is more compact.

> Also, this should be before pmd_clear().

During the test, I found that the console failed after executing 
local_flush_tlb_kernel_page, so I think the pmd_clear function can 
output in time if there is printing. This doesn't seem possible, so 
before pmd_clear it's not bad either.

> 
>> +#endif
>>          for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
>>                  pte_t *pte;
>>                  struct map_desc map;
>> @@ -1748,6 +1753,10 @@
>>
>>                  create_mapping(&map);
>>          }
>> +#ifdef CONFIG_FIX_EARLYCON_MEM
>> +       if (console_drivers)
>> +               console_start(console_drivers);
>> +#endif
>>    }
>>
>> BTW, should I resend the patch-v2 through the site
>> (https://www.armlinux.org.uk/developer/patches/add.php), or should I
>> send the patch-v2 through E-mail to Linux-Mainline?
>>
>> Thanks you.
>>
>> Regards,
>> Victor
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Here is the patch-v3. Please review:

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a49f0b9..57ca77f 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -14,6 +14,7 @@
  #include <linux/fs.h>
  #include <linux/vmalloc.h>
  #include <linux/sizes.h>
+#include <linux/console.h>

  #include <asm/cp15.h>
  #include <asm/cputype.h>
@@ -1727,6 +1728,7 @@
  	unsigned long va = fix_to_virt(__end_of_permanent_fixed_addresses - 1);

  	pte_offset_fixmap = pte_offset_late_fixmap;
+	console_lock();
  	pmd_clear(fixmap_pmd(va));
  	local_flush_tlb_kernel_page(va);

@@ -1748,6 +1750,7 @@

  		create_mapping(&map);
  	}
+	console_unlock();
  }

Thanks you.

Regards,
Victor
