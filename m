Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4923246A123
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbhLFQYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244404AbhLFQYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:24:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DE4C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:20:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76ABFB81163
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0E6C341C1;
        Mon,  6 Dec 2021 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638807631;
        bh=nHfd4LeuCF/C6Shj1iP5OtMCx+jUnbWosXyDdMp0EoY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YONjoOnBukCbNSrNFewClrSbRWEBiW9L4Z/H9vaEkO8VulH6oDfpm+nu+1hTvg64u
         PmHk9ino0T5DBmPYJTqkc8ddQkxW2rN9ertTH+jBvMSOrf9oO61pdFKpc6ppYz9njZ
         QrgXdXDBLP3MLYzM6VewX8kz8t59bRPBkgHmKQ8HuWgoUN9zfXgTQKJDQDVKPj+h4/
         rDERGUPrVFUIGy3zsd45I2BhpybrijnUPWXW2f2KgmGS8EtILNuPuRBevO/Rggby+C
         h9JXMt9gGlyLHCjuW/PTGoYedLQz/ecNmgacdkvxhTczu5TAVmEi/5piv0frgn7Srh
         zaVvOYKHFRtRw==
Date:   Tue, 7 Dec 2021 00:12:50 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Make vmalloc/vmemmap end equal to the start of
 the next region
In-Reply-To: <20211118134539.137212-1-alexandre.ghiti@canonical.com>
References: <20211118134539.137212-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20211206162029.AD0E6C341C1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 14:45:39 +0100
Alexandre Ghiti <alexandre.ghiti@canonical.com> wrote:

> We used to define VMALLOC_END equal to the start of the next region
> *minus one* which is inconsistent with the use of this define in the
> core code (for example, see the definitions of VMALLOC_TOTAL and
> is_vmalloc_addr).
> 
> And then make the definition of VMEMMAP_END consistent with VMALLOC_END
> and all other regions actually.
> 
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> ---
>  arch/riscv/include/asm/pgtable.h | 4 ++--
>  arch/riscv/mm/fault.c            | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index d34f3a7a9701..5155048274c2 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -25,7 +25,7 @@
>  #endif
>  
>  #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> -#define VMALLOC_END      (PAGE_OFFSET - 1)
> +#define VMALLOC_END      PAGE_OFFSET
>  #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
>  
>  #define BPF_JIT_REGION_SIZE	(SZ_128M)
> @@ -53,7 +53,7 @@
>  #define VMEMMAP_SHIFT \
>  	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>  #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
> -#define VMEMMAP_END	(VMALLOC_START - 1)
> +#define VMEMMAP_END	VMALLOC_START
>  #define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
>  
>  /*
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index aa08dd2f8fae..41ae0aa8f2b8 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -235,7 +235,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	 * only copy the information from the master page table,
>  	 * nothing more.
>  	 */
> -	if (unlikely((addr >= VMALLOC_START) && (addr <= VMALLOC_END))) {
> +	if (unlikely((addr >= VMALLOC_START) && (addr < VMALLOC_END))) {
>  		vmalloc_fault(regs, code, addr);
>  		return;
>  	}

