Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE6D5A7D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiHaMhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaMho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:37:44 -0400
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F0167D9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:37:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07722721|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0675243-0.00153387-0.930942;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.P4QJDlq_1661949456;
Received: from 192.168.220.136(mailfrom:victor@allwinnertech.com fp:SMTPD_---.P4QJDlq_1661949456)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 20:37:39 +0800
Message-ID: <dda053b1-2d4f-153b-b811-78021eae3882@allwinnertech.com>
Date:   Wed, 31 Aug 2022 20:37:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ARM: mmu: fix access to illegal address when using
 earlycon & memblock=debug
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>, linux@armlinux.org.uk,
        rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
        yanfei.xu@windriver.com, ardb@kernel.org, tglx@linutronix.de,
        mirq-linux@rere.qmqm.pl, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220316023356.120595-1-victor@allwinnertech.com>
 <CGME20220831115257eucas1p20d37a01c51e42767860920a936255bd7@eucas1p2.samsung.com>
 <9a425a51-9460-6c4d-e331-5cd5873f8a43@samsung.com>
From:   Victor Hassan <victor@allwinnertech.com>
In-Reply-To: <9a425a51-9460-6c4d-e331-5cd5873f8a43@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2022 7:52 PM, Marek Szyprowski wrote:
> Hi Victor,
> 
> On 16.03.2022 03:33, Victor Hassan wrote:
>> earlycon uses fixmap to create a memory map,
>> So we need to close earlycon before closing fixmap,
>> otherwise printk will access illegal addresses.
>> After creating a new memory map, we open earlycon again.
>>
>> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> 
> This patch landed in linux next-20220831 as commit a76886d117cb ("ARM:
> 9223/1: mmu: fix access to illegal address when using earlycon &
> memblock=debug"). Unfortunately it breaks booting of all my test boards
> which *do not* use earlycon. It can be easily reproduced even with QEMU.
> 
> With kernel compiled from multi_v7_defconfig the following setup boots:
> 
> $ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append
> "console=ttyAMA0 earlycon" -M virt -smp 2 -m 512
> 
> while this one doesn't:
> 
> $ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append
> "console=ttyAMA0" -M virt -smp 2 -m 512
> 
> 
>> ---
>>    arch/arm/mm/mmu.c | 7 +++++++
>>    1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index 274e4f73fd33..f3511f07a7d0 100644
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
>> @@ -1695,6 +1696,9 @@ static void __init early_fixmap_shutdown(void)
>>    	pmd_clear(fixmap_pmd(va));
>>    	local_flush_tlb_kernel_page(va);
>>    
>> +#ifdef CONFIG_FIX_EARLYCON_MEM
>> +	console_stop(console_drivers);
>> +#endif
>>    	for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
>>    		pte_t *pte;
>>    		struct map_desc map;
>> @@ -1713,6 +1717,9 @@ static void __init early_fixmap_shutdown(void)
>>    
>>    		create_mapping(&map);
>>    	}
>> +#ifdef CONFIG_FIX_EARLYCON_MEM
>> +	console_start(console_drivers);
>> +#endif
>>    }
>>    
>>    /*
> 
> Best regards

Dear Marek,
Thank you for the notice. I'll figure it out and feed back to you as 
soon as possible.

Regards,
Victor
