Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39494BBA5C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiBROAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:00:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiBROAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:00:35 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D749D2B04B1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:00:17 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id E214810001E;
        Fri, 18 Feb 2022 14:00:11 +0000 (UTC)
Message-ID: <5d36edd4-39ff-bc52-0b40-6f909a510b9e@ghiti.fr>
Date:   Fri, 18 Feb 2022 15:00:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] riscv: mm: remove the BUG_ON check of mapping the last 4K
 bytes of memory
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     jszhang@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <mhng-790fdd34-b20e-4c0a-b36d-eb91b16a3e44@palmer-ri-x1c9>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <mhng-790fdd34-b20e-4c0a-b36d-eb91b16a3e44@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 2/15/22 00:41, Palmer Dabbelt wrote:
> On Tue, 25 Jan 2022 08:10:41 PST (-0800), alex@ghiti.fr wrote:
>>
>> On 1/25/22 16:55, Jisheng Zhang wrote:
>>> remove the BUG_ON check of mapping the last 4K bytes of the addressable
>>> memory since "this is true for every kernel actually" as pointed out
>>> by Alexandre.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
>>> ---
>>>   arch/riscv/mm/init.c | 8 --------
>>>   1 file changed, 8 deletions(-)
>>>
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index cf4d018b7d66..8347d0fda8cd 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -811,14 +811,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>>       BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
>>>       BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
>>>
>>> -#ifdef CONFIG_64BIT
>>> -    /*
>>> -     * The last 4K bytes of the addressable memory can not be 
>>> mapped because
>>> -     * of IS_ERR_VALUE macro.
>>> -     */
>>> -    BUG_ON((kernel_map.virt_addr + kernel_map.size) > 
>>> ADDRESS_SPACE_END - SZ_4K);
>>> -#endif
>>
>>
>> This BUG_ON seems pretty legit to me: I re-read the exchanges we had,
>> and I see that I didn't notice that in your v2, you actually removed the
>> BUG_ON. So that's my bad, what I meant in the first place was that the
>> BUG_ON is true for 32-bit and 64-bit kernels actually.
>
> There's actually an ifndef 64BIT above that sort of handles this case 
> (though I didn't check to see if we're getting the limits correct, so 
> it may not work properly).  That's shrinking the memory, rather than 
> just firing a BUG, and it's not really any more code so we should go 
> that way for both.  I could see leaving a BUG in there, maybe just 
> explicitly using IS_ERR_VALUE as that's really what we're checking for 
> (though if that's not 4K a bunch of stuff will break, so maybe it just 
> doesn't matter).


I think you're talking about:

memory_limit = KERN_VIRT_SIZE - (IS_ENABLED(CONFIG_64BIT) ? SZ_4G : 0);

If yes, that's shrinking the available physical memory we can map in the 
linear mapping, whereas the BUG_ON here is triggered if the kernel 
mapping is very (very) large and overlaps the last *4K* of the address 
space, so I still think the BUG_ON is legit although very unlikely.

However, I'm wondering if the shrinking still holds with the recent move 
of KASAN, I may be back with a fix for that.

Alex


>
>> Sorry my RB was not right on this one :(
>>
>> Alex
>>
>>
>>> -
>>>       pt_ops_set_early();
>>>
>>>       /* Setup early PGD for fixmap */
