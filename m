Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EEE513DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352414AbiD1Vvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiD1Vvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:51:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F330BB0A8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:48:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w17-20020a17090a529100b001db302efed6so4079023pjh.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sLdFSM+gbbluSAusN2hlLl8hXUCFXq74MUxOmPI7lC0=;
        b=3c5J22p40msR1l4Xh1SUIN5QgolDrzxQVQG2JpLcEVDr9mNIJeAISUgdjeEfg1sJyi
         YL/8puFtsiANQ6jN74xg+Hp1RLFxl41WZ4wGvwETlk7A9r9pIpLJtq81CEkMEHo7ir6z
         PD4U3xSe9A0v4VdHDz/bVNlrA9NFKHBTQ7VXgy1HMVYmy68DRh1qk4rvKvHw50zqPRYQ
         NC/YJg+JCBA9uUTBlqOD9WqfZOEUAXg6Li01tkS+2A2TyMECJ/bcbRDjCwInb+27Yq1z
         gdmycesrmfxSR74zLeak0/mshq8XIL8hVLVMqH0zosqpFmlxRdeTyXenBQqp3mUCd+WW
         xkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sLdFSM+gbbluSAusN2hlLl8hXUCFXq74MUxOmPI7lC0=;
        b=7t3dFYhC6uluRLUzWaDNfOOys9hJz9qb/zic/LG9ZePxe6WLEqOUkHUq1jea53wBW+
         hk00kNp+PQ02FhEMRmi0rU8XinlnqFzqgFT28CyioU5rvImp4aKjyq0gpYz5tiO6bQmH
         cwph4rAhMqHp4Bj97r3RHIhF2nXMLc1vqV8HqFvcdEv0oYlyc9KTx40xy2OAzxxrcHj7
         9yg2M66KB5VAgc0ztk1DBCIO/9qZOKR4MRBkpc4o6GdKtkAhOsm847COwD+op90ft/73
         68poZh9XB+WR+hwMauFMKv+y5I4iIQhrvcu6hRmuu2B618zptwA57lOoMqf7JstIgH0F
         z3vw==
X-Gm-Message-State: AOAM530f57lm/03OMJdY1g9uDmFX3mYH8eTHVhhj8R9/7292fLPNX1wm
        nOWB/VmZrtkOI6GuUnqV/XQERg==
X-Google-Smtp-Source: ABdhPJyZ461f7KmmDTWkjWxNRvaneb+mjQfX0cue1QcDfBWULJ9LAvQD9+v472RbAJl4R22HUghsdg==
X-Received: by 2002:a17:90b:4b4f:b0:1db:d2ac:8f8c with SMTP id mi15-20020a17090b4b4f00b001dbd2ac8f8cmr306376pjb.237.1651182495382;
        Thu, 28 Apr 2022 14:48:15 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id l22-20020a17090a071600b001d9781de67fsm7631976pjl.31.2022.04.28.14.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:14 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:48:14 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Apr 2022 14:48:01 PDT (-0700)
Subject:     Re: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
In-Reply-To: <8491e0c3-3e6e-325e-0cc1-5b237ce4f9fd@ics.forth.gr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Message-ID: <mhng-9aafbd90-eb33-4f43-afa3-b9f9338c2a70@palmer-ri-x1c9>
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

On Mon, 25 Apr 2022 23:11:23 PDT (-0700), mick@ics.forth.gr wrote:
> Hello Palmer,
>
> Any updates on this ?

Sorry about that, it's on fixes.

>
> Regards,
> Nick
>
> On 3/22/22 15:28, Nick Kossifidis wrote:
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
