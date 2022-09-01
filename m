Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC375A976D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiIAMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIAMx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:53:27 -0400
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42DB7C9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:53:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07441293|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0137863-0.000745102-0.985469;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.P5JnUS1_1662036799;
Received: from 192.168.220.144(mailfrom:victor@allwinnertech.com fp:SMTPD_---.P5JnUS1_1662036799)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 20:53:20 +0800
Message-ID: <6c14e174-cdb6-c1fc-58cc-d579111d2328@allwinnertech.com>
Date:   Thu, 1 Sep 2022 20:53:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ARM: mmu: fix access to illegal address when using
 earlycon & memblock=debug
Content-Language: en-US
From:   Victor Hassan <victor@allwinnertech.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>, linux@armlinux.org.uk,
        rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
        yanfei.xu@windriver.com, ardb@kernel.org, tglx@linutronix.de,
        mirq-linux@rere.qmqm.pl, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220316023356.120595-1-victor@allwinnertech.com>
 <CGME20220831115257eucas1p20d37a01c51e42767860920a936255bd7@eucas1p2.samsung.com>
 <9a425a51-9460-6c4d-e331-5cd5873f8a43@samsung.com>
 <dda053b1-2d4f-153b-b811-78021eae3882@allwinnertech.com>
In-Reply-To: <dda053b1-2d4f-153b-b811-78021eae3882@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/31 20:37, Victor Hassan wrote:
> On 8/31/2022 7:52 PM, Marek Szyprowski wrote:
>> Hi Victor,
>>
>> On 16.03.2022 03:33, Victor Hassan wrote:
>>> earlycon uses fixmap to create a memory map,
>>> So we need to close earlycon before closing fixmap,
>>> otherwise printk will access illegal addresses.
>>> After creating a new memory map, we open earlycon again.
>>>
>>> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
>>
>> This patch landed in linux next-20220831 as commit a76886d117cb ("ARM:
>> 9223/1: mmu: fix access to illegal address when using earlycon &
>> memblock=debug"). Unfortunately it breaks booting of all my test boards
>> which *do not* use earlycon. It can be easily reproduced even with QEMU.
>>
>> With kernel compiled from multi_v7_defconfig the following setup boots:
>>
>> $ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append
>> "console=ttyAMA0 earlycon" -M virt -smp 2 -m 512
>>
>> while this one doesn't:
>>
>> $ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append
>> "console=ttyAMA0" -M virt -smp 2 -m 512
>>
>>
>>> ---
>>>    arch/arm/mm/mmu.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>>> index 274e4f73fd33..f3511f07a7d0 100644
>>> --- a/arch/arm/mm/mmu.c
>>> +++ b/arch/arm/mm/mmu.c
>>> @@ -14,6 +14,7 @@
>>>    #include <linux/fs.h>
>>>    #include <linux/vmalloc.h>
>>>    #include <linux/sizes.h>
>>> +#include <linux/console.h>
>>>    #include <asm/cp15.h>
>>>    #include <asm/cputype.h>
>>> @@ -1695,6 +1696,9 @@ static void __init early_fixmap_shutdown(void)
>>>        pmd_clear(fixmap_pmd(va));
>>>        local_flush_tlb_kernel_page(va);
>>> +#ifdef CONFIG_FIX_EARLYCON_MEM
>>> +    console_stop(console_drivers);
>>> +#endif
>>>        for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
>>>            pte_t *pte;
>>>            struct map_desc map;
>>> @@ -1713,6 +1717,9 @@ static void __init early_fixmap_shutdown(void)
>>>            create_mapping(&map);
>>>        }
>>> +#ifdef CONFIG_FIX_EARLYCON_MEM
>>> +    console_start(console_drivers);
>>> +#endif
>>>    }
>>>    /*
>>
>> Best regards
> 
> Dear Marek,
> Thank you for the notice. I'll figure it out and feed back to you as 
> soon as possible.
> 
> Regards,
> Victor

Hi Marek,

Sorry, didn't take into account that console_drivers is NULL when 
earlycon is not used.

Here is the patch-v2. Please review:

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a49f0b9..a240f38 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -14,6 +14,7 @@
  #include <linux/fs.h>
  #include <linux/vmalloc.h>
  #include <linux/sizes.h>
+#include <linux/console.h>

  #include <asm/cp15.h>
  #include <asm/cputype.h>
@@ -1730,6 +1731,10 @@
  	pmd_clear(fixmap_pmd(va));
  	local_flush_tlb_kernel_page(va);

+#ifdef CONFIG_FIX_EARLYCON_MEM
+	if (console_drivers)
+		console_stop(console_drivers);
+#endif
  	for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
  		pte_t *pte;
  		struct map_desc map;
@@ -1748,6 +1753,10 @@

  		create_mapping(&map);
  	}
+#ifdef CONFIG_FIX_EARLYCON_MEM
+	if (console_drivers)
+		console_start(console_drivers);
+#endif
  }

BTW, should I resend the patch-v2 through the site 
(https://www.armlinux.org.uk/developer/patches/add.php), or should I 
send the patch-v2 through E-mail to Linux-Mainline?

Thanks you.

Regards,
Victor
