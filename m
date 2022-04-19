Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D383507B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357707AbiDSUl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357702AbiDSUlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:41:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9019C40E78
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cjz7wKFAsfBMVGPmGUS52OFwFiDPm56/BfR12W6kk4U=; b=N170i8NmuK3H7TF4S48xKXCGg2
        MBDSwfkzfTB9UKpyejYSlI06Evm7PW8/lwrSlvOogIyFd2skJKVL1K5weSkS21/4VjDtuzD1lavmA
        I44a1GEH0e2oW5qPxF0kPHmrJURna8ysOP6byJOFDnE/CUQBk1igAlWEM/txwznnMQCSSBdojkBMN
        Xv1pXJJmdNT5hn2P8YUropp4QOOa1LaUwUcFw4XJJ3+UevHeTfC/1etXl189VFxWHo20sjxoz6YgR
        eBFVKhXdNECGvZG08DKNstStDyzbelWVBnELCrVABah/yJfBUFCh4VMqLeqM60/tcaSuI/UiSBsYW
        Na3oj/dQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nguca-003U9J-LS; Tue, 19 Apr 2022 20:38:48 +0000
Message-ID: <814ae1e7-297f-102f-972f-ae6130128e7a@infradead.org>
Date:   Tue, 19 Apr 2022 13:38:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] RISC-V: Add braces around an empty if statement bodies
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>, panqinglin2020@iscas.ac.cn
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        vitaly.wool@konsulko.com, rppt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220419194846.18318-1-palmer@rivosinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220419194846.18318-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/19/22 12:48, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> This triggers -Wempty-body, which will cause the next statement (eventually
> create_pmd_mapping) to be dropped.  Both of these were introduced by the same
> commit.  This is safe for the reporting config (which is 32-bit), but IIUC
> could result in breakages for 64-bit configs without 4/5 level paging like the
> XIP configs.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 677b9eb8810e ("riscv: mm: Prepare pt_ops helper functions for sv57")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Might be better to define these to functions that are empty, but that's
> slightly different than just fixing the commit/warning in question.

Yes, we usually fix this type of problem by changing these to have empty bodies:

#else
...
#define create_pud_mapping(__pmdp, __va, __pa, __sz, __prot)
#define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot)
#endif /* __PAGETABLE_PMD_FOLDED */

etc.

> ---
>  arch/riscv/mm/init.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9535bea8688c..637916857c4d 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -798,13 +798,15 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
>  			   PGDIR_SIZE,
>  			   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
>  
> -	if (pgtable_l5_enabled)
> +	if (pgtable_l5_enabled) {
>  		create_p4d_mapping(early_dtb_p4d, DTB_EARLY_BASE_VA,
>  				   (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
> +	}
>  
> -	if (pgtable_l4_enabled)
> +	if (pgtable_l4_enabled) {
>  		create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
>  				   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
> +	}
>  
>  	if (IS_ENABLED(CONFIG_64BIT)) {
>  		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,

-- 
~Randy
