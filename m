Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF8513DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352402AbiD1Vvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiD1Vva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:51:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D34BB0A8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:48:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c23so5539240plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6aiXY/c63MQElXVJZh4bp/etzqtyXVUX7hMM9mMLHGU=;
        b=CDsBib5aq7IfrlvyLb8w8JRjnuqiDUws2JBZNYWpIl+AzVDEcfcTizafbjhpqg0ZLx
         I7GTVsj6m9m6GY+fweX99+VGrsy2+dXb87n+3GxlYaXfih9dCeTEP4/5cJpUSeAI57mz
         u8/hiPJbx1G8a5A12C3DNrTZ6wtLaE90WGWuzrKwRplGHAQPknvu0oDde4DP7bj4WwJK
         Ng7pi649QKwig8o4B4iAOTrzskyaaU7F/P6lmynpCBcLZ2Z1RUkgQnhCDZ5UBnCSNcvF
         RKnZpRZmScCTudvfxfBPgjg3myOhVFe1BHRzg2DGkNXHdN0YOrg+HqCGCGLpL1Gv4EVh
         W6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6aiXY/c63MQElXVJZh4bp/etzqtyXVUX7hMM9mMLHGU=;
        b=5Z+4CSrv0zvST6VyzXH+GD8MkCbsNzMjqqnoFSGADnoUbiZyovbaefpEWL8WIOrm4M
         zEZ4yp323p4qyiTapLIpgXaI3n8/lFGvDu11AKHPMhvob5TLvvXGZ1Oh9o2RBTk/FJCP
         NP77bSuuLDnKV2FyBcJ5HjzECv0LY6nJVEVc0VDbUEdhZ1NCX1apfnw80yMKbh+M4rVo
         5jehoVSHumKvYX1bYve/o66+m8oAkYLS8X+4xYxgPWDUlNs5bKSUGojwrDtkiKQ0morD
         wa+zxUuPy4/rfV2Ti0qOtbaJHx/1NTo1yPsLynTY84jw1hq2NllLz68CrbeIgrAM8Kio
         haPQ==
X-Gm-Message-State: AOAM531hK7/2FU+bwDG1U0QtBx251mVFmxVoQgJUtQenPv/FU19MRU4/
        bFXRbORJ372LAVJrrq3cyJSoUytDnwGBAg==
X-Google-Smtp-Source: ABdhPJy8Q8A0jLt1ox9LopY9ts+S70U0VlX1tlbLstodvaNMSxFJhocQiO6iKxVYqE0ssmlm72i2vA==
X-Received: by 2002:a17:902:dac1:b0:15d:356:887c with SMTP id q1-20020a170902dac100b0015d0356887cmr24921840plx.78.1651182493502;
        Thu, 28 Apr 2022 14:48:13 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a6d8800b001cd4c118b07sm8048593pjk.16.2022.04.28.14.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:12 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:48:12 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Apr 2022 13:25:03 PDT (-0700)
Subject:     Re: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
In-Reply-To: <ebaa9b4e-9e37-e2f4-2bee-37d324e7302b@microchip.com>
CC:     mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor.Dooley@microchip.com
Message-ID: <mhng-525e0b77-f9af-4cba-a985-f8872835574e@palmer-ri-x1c9>
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

On Thu, 24 Mar 2022 02:37:29 PDT (-0700), Conor.Dooley@microchip.com wrote:
> 
> On 22/03/2022 13:28, Nick Kossifidis wrote:
>> In case the DTB provided by the bootloader/BootROM is before the kernel
>> image or outside /memory, we won't be able to access it through the
>> linear mapping, and get a segfault on setup_arch(). Currently OpenSBI
>> relocates DTB but that's not always the case (e.g. if FW_JUMP_FDT_ADDR
>> is not specified), and it's also not the most portable approach since
>> the default FW_JUMP_FDT_ADDR of the generic platform relocates the DTB
>> at a specific offset that may not be available. To avoid this situation
>> copy DTB so that it's visible through the linear mapping.
>> 
>> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> 
> Albeit in a backport, I tested this on a PolarFire SoC based board.
> So I guess, Tested-by: Conor Dooley <conor.dooley@microchip.com>

My scripts don't pick these up unless they're on their own line, not 
sure if that's too conservative but it's on purpose.  I just sort of 
stumbled into this one so it's in.

> 
> And a lot cleaner than using create_pgd_mapping in setup_vm_final to do it :)
> 
> Thanks,
> Conor.
> 
>> ---
>>   arch/riscv/mm/init.c | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 0d588032d..697a9aed4 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -206,8 +206,25 @@ static void __init setup_bootmem(void)
>>   	 * early_init_fdt_reserve_self() since __pa() does
>>   	 * not work for DTB pointers that are fixmap addresses
>>   	 */
>> -	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
>> -		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>> +	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
>> +		/*
>> +		 * In case the DTB is not located in a memory region we won't
>> +		 * be able to locate it later on via the linear mapping and
>> +		 * get a segfault when accessing it via __va(dtb_early_pa).
>> +		 * To avoid this situation copy DTB to a memory region.
>> +		 * Note that memblock_phys_alloc will also reserve DTB region.
>> +		 */
>> +		if (!memblock_is_memory(dtb_early_pa)) {
>> +			size_t fdt_size = fdt_totalsize(dtb_early_va);
>> +			phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
>> +			void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
>> +
>> +			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
>> +			early_memunmap(new_dtb_early_va, fdt_size);
>> +			_dtb_early_pa = new_dtb_early_pa;
>> +		} else
>> +			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>> +	}
>>   
>>   	early_init_fdt_scan_reserved_mem();
>>   	dma_contiguous_reserve(dma32_phys_limit);
