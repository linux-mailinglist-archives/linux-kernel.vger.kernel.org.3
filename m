Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA07F514F74
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbiD2PcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378507AbiD2PcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:32:09 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38502D4C87
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:28:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x12so6785653pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=e37KpWOvnJl8DV6RpvFm8R8ciIf9e11j1e98qdA+nR0=;
        b=CQH14jLE8Ms+j8J1oP8clFORtMf0mx0Gh4b+0HDNYIdpNqAe7n8P3wKFp+gPmBt4C2
         XGh14y7IZWaD/d1rfA5DQcS1OJMA/A89Ahx765rBST+rLzMPQKxuGe47JP9qORF7tHsu
         0vLmqZAjh4Z4o4FaPUwFm3n74p6oo5io3GYhFz8FjY1dsOISjYDkrBzh72QbOfO3q3+R
         tnq81POYf+Q1TKbz/w6ZQ3lVKILKwFfBsLJPMqOrTbYtPEgJ87ITuyvw3V0UMTCBPojD
         gLqEgErM/FJraX1LagRCx1d20ZNyakv3/QZlO8Z+a1+Gbat/3H6QYtbAtIzAokzNNuL7
         EHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=e37KpWOvnJl8DV6RpvFm8R8ciIf9e11j1e98qdA+nR0=;
        b=0yt7aR/BdevW9ktRYbEzSLLw8NZQyK9/gpOMONtiof9IzAFs87IA1APLTcflqs8VVX
         OUoLYueg8ffh3pO34UtsEse/TrmY+Jk3tvgqF4P/vEzeEAbzmJ2i6xst0kJSpPW3AeJD
         Re7XFjjGWjXyx1+zjiP2lcPFYMnrIUHVFBny4S4cbFW+gwGX0IyEmWj/+y1FFURo7eIs
         QgwhL0yQ0ymECmQ/UBT6SdNZwUPBTqtZvUZdDsYdbJIs2cEy7v1EPcJEH2skb17JrOEY
         vE34oV7c3ke3/iwS+ImCbKK48IamAEkNiNxEUiT6xXPYImcRxkR04tjH76eOf+ofXlTX
         +lrg==
X-Gm-Message-State: AOAM531ZeH73Z1YQz/dm3ZuxZXoLDqH3Fp6JgXOqbaOPu33z30h7gy+0
        6TTXADwtHyPELDY/MlCcct7+OQ==
X-Google-Smtp-Source: ABdhPJzo5Fg9L/6IHNj66qUgf0n1g8y00zwYhwFSYEOwGBZ58KZH+MxD4trY5ygLoSvgdmUYu2btMg==
X-Received: by 2002:a63:e513:0:b0:3ab:a3fb:f100 with SMTP id r19-20020a63e513000000b003aba3fbf100mr13900099pgh.70.1651246115507;
        Fri, 29 Apr 2022 08:28:35 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id m1-20020a637d41000000b003c14af5063esm6628648pgn.86.2022.04.29.08.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:28:34 -0700 (PDT)
Date:   Fri, 29 Apr 2022 08:28:34 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Apr 2022 08:12:57 PDT (-0700)
Subject:     Re: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
In-Reply-To: <mhng-9aafbd90-eb33-4f43-afa3-b9f9338c2a70@palmer-ri-x1c9>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Message-ID: <mhng-6c123e84-9530-46f6-a5ec-6b908bb92f95@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 14:48:14 PDT (-0700), Palmer Dabbelt wrote:
> On Mon, 25 Apr 2022 23:11:23 PDT (-0700), mick@ics.forth.gr wrote:
>> Hello Palmer,
>>
>> Any updates on this ?
>
> Sorry about that, it's on fixes.

Not sure if I just wasn't paying attention yesterday or if I'm grumpier 
this morning, but that "RISC-V-fixes: " prefix is just a bit too odd -- 
I know we've got a split between "RISC-V" and "riscv" so maybe it 
doesn't matter, but even that is kind of ugly.

I re-wrote it, but I'm going to let it round trip through linux-next so 
I'll send it up next time.

Sorry, I know this happened twice recently but I'll try not to make a 
habit of it.

>
>>
>> Regards,
>> Nick
>>
>> On 3/22/22 15:28, Nick Kossifidis wrote:
>>> In case the DTB provided by the bootloader/BootROM is before the kernel
>>> image or outside /memory, we won't be able to access it through the
>>> linear mapping, and get a segfault on setup_arch(). Currently OpenSBI
>>> relocates DTB but that's not always the case (e.g. if FW_JUMP_FDT_ADDR
>>> is not specified), and it's also not the most portable approach since
>>> the default FW_JUMP_FDT_ADDR of the generic platform relocates the DTB
>>> at a specific offset that may not be available. To avoid this situation
>>> copy DTB so that it's visible through the linear mapping.
>>>
>>> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
>>> ---
>>>   arch/riscv/mm/init.c | 21 +++++++++++++++++++--
>>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index 0d588032d..697a9aed4 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -206,8 +206,25 @@ static void __init setup_bootmem(void)
>>>   	 * early_init_fdt_reserve_self() since __pa() does
>>>   	 * not work for DTB pointers that are fixmap addresses
>>>   	 */
>>> -	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
>>> -		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>>> +	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
>>> +		/*
>>> +		 * In case the DTB is not located in a memory region we won't
>>> +		 * be able to locate it later on via the linear mapping and
>>> +		 * get a segfault when accessing it via __va(dtb_early_pa).
>>> +		 * To avoid this situation copy DTB to a memory region.
>>> +		 * Note that memblock_phys_alloc will also reserve DTB region.
>>> +		 */
>>> +		if (!memblock_is_memory(dtb_early_pa)) {
>>> +			size_t fdt_size = fdt_totalsize(dtb_early_va);
>>> +			phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
>>> +			void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
>>> +
>>> +			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
>>> +			early_memunmap(new_dtb_early_va, fdt_size);
>>> +			_dtb_early_pa = new_dtb_early_pa;
>>> +		} else
>>> +			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>>> +	}
>>>
>>>   	early_init_fdt_scan_reserved_mem();
>>>   	dma_contiguous_reserve(dma32_phys_limit);
