Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C88513E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351789AbiD1WBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiD1WBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:01:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E57B580DF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:58:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q20so3677373wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MaZRQfW9ohJvJKT8fr3IXNeI9D+wbcHeG3e4b7bWPpU=;
        b=eOgofK72gkImxI4hgh9lOd09qexGIWZcOs7UK2cyYSGjNF0yp6mnirCmber1YJRVTG
         3f8EI3KDwDDT17DUTUKwEdYqcJdqZz6ukrjMB//rxC4s0+XDuBiGCChZeCoYWnizmKbH
         GCbxNtFjkHDIv3VYfPsrz/xsqGmKFSJjVPTRTCOF2m2FxHYp+M2A7oUUzhzZySjRwDNC
         rT1QDMixTawsiqGq+5s9CHeiD9qK4iZzt1NA/LNKcSFF25ofHK5AP4lVs3Eg8ODdsyyO
         gVx7EbS79Ddy0eRVONG28S9yEj/VUYRIO4v9RPjmQBvWWx7dDseRlNySkU7wqh7rUNYw
         SuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MaZRQfW9ohJvJKT8fr3IXNeI9D+wbcHeG3e4b7bWPpU=;
        b=QtsDNutQR620KW4QzE1uS0QofZWt/gEG7RF6Y9mFuKHROu7/Sros7DpnerHwbbik+c
         Tz2suJSIFDKlLISb5h950HeNUgcVyq6b7ljGEY3sTZGyq9pnwuR5Sy/TeNO0pteR1Qdm
         cDd4Ws6BIO7frkzf3c8/ViPTJbwbC4nLL1cgDEuTIxnPHbGnLKpOA5pNVooZ6BPeUOKq
         7pTyuvqGGfeqwnZHSqDbEQiCZmb21AxPtv7hdm3ICXyxuiRs7FUx3h1D//fDWfGiPBJw
         D8fT/pV784ta3cQ+Kzsto5Qf3O3wRlUJamNvOcsBsbrz4yONxRLSJPJIla23S/abQyXU
         JLUA==
X-Gm-Message-State: AOAM531EiwByV9XQTUklinBJY/461w7poe4TWDRfXroe3QBBJs3m/yUl
        Ek7MFL97CLSK4dzSmF67FpS1Wg==
X-Google-Smtp-Source: ABdhPJyocbVaYjH3Q5BHW2MBvbFSgOv9X9OMx5MciBZIpQi1J0XZQ8PqOUZVsiDWIcJ6gETxB3vHlQ==
X-Received: by 2002:a05:600c:206:b0:38e:b6b4:a2d6 with SMTP id 6-20020a05600c020600b0038eb6b4a2d6mr245232wmi.156.1651183100938;
        Thu, 28 Apr 2022 14:58:20 -0700 (PDT)
Received: from [192.168.2.222] ([109.76.156.77])
        by smtp.gmail.com with ESMTPSA id o9-20020adf8b89000000b0020adeb916d8sm896152wra.30.2022.04.28.14.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 14:58:20 -0700 (PDT)
Message-ID: <4eec9cb6-c80e-a5e5-995b-7568d568ad26@conchuod.ie>
Date:   Thu, 28 Apr 2022 22:58:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, Conor.Dooley@microchip.com
Cc:     mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
References: <mhng-525e0b77-f9af-4cba-a985-f8872835574e@palmer-ri-x1c9>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <mhng-525e0b77-f9af-4cba-a985-f8872835574e@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 22:48, Palmer Dabbelt wrote:
> On Thu, 24 Mar 2022 02:37:29 PDT (-0700), Conor.Dooley@microchip.com wrote:
>>
>> On 22/03/2022 13:28, Nick Kossifidis wrote:
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
>>
>> Albeit in a backport, I tested this on a PolarFire SoC based board.
>> So I guess, Tested-by: Conor Dooley <conor.dooley@microchip.com>
> 
> My scripts don't pick these up unless they're on their own line, not sure if that's too conservative but it's on purpose.  I just sort of stumbled into this one so it's in.

Uhh, I checked and b4 doesn't pick it up either. I'm not overly
concerned about getting "credit" for testing it, more interested
in pointing out that it does solve a real issue that I have run
into in case you were looking for incentive to apply it :)
I realised immediately after sending that it was likely an invalid
tag, but figured it'd serve that purpose either way.

Thanks,
Conor.

> 
>>
>> And a lot cleaner than using create_pgd_mapping in setup_vm_final to do it :)
>>
>> Thanks,
>> Conor.
>>
>>> ---
>>>   arch/riscv/mm/init.c | 21 +++++++++++++++++++--
>>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index 0d588032d..697a9aed4 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -206,8 +206,25 @@ static void __init setup_bootmem(void)
>>>        * early_init_fdt_reserve_self() since __pa() does
>>>        * not work for DTB pointers that are fixmap addresses
>>>        */
>>> -    if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
>>> -        memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>>> +    if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
>>> +        /*
>>> +         * In case the DTB is not located in a memory region we won't
>>> +         * be able to locate it later on via the linear mapping and
>>> +         * get a segfault when accessing it via __va(dtb_early_pa).
>>> +         * To avoid this situation copy DTB to a memory region.
>>> +         * Note that memblock_phys_alloc will also reserve DTB region.
>>> +         */
>>> +        if (!memblock_is_memory(dtb_early_pa)) {
>>> +            size_t fdt_size = fdt_totalsize(dtb_early_va);
>>> +            phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
>>> +            void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
>>> +
>>> +            memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
>>> +            early_memunmap(new_dtb_early_va, fdt_size);
>>> +            _dtb_early_pa = new_dtb_early_pa;
>>> +        } else
>>> +            memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>>> +    }
>>>         early_init_fdt_scan_reserved_mem();
>>>       dma_contiguous_reserve(dma32_phys_limit);
