Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC21B4BEB13
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiBUSTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:19:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiBUSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:16:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1DA15A2D;
        Mon, 21 Feb 2022 10:06:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B2EDB816FE;
        Mon, 21 Feb 2022 18:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AD5C340E9;
        Mon, 21 Feb 2022 18:06:53 +0000 (UTC)
Date:   Mon, 21 Feb 2022 18:06:50 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Message-ID: <YhPUuu+6TPMKjhwk@arm.com>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
 <20220218023650.672072-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218023650.672072-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 02:37:04AM +0000, Liam Howlett wrote:
> diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
> index 3455ee4acc04..930a0bc4cac4 100644
> --- a/arch/arm64/kernel/elfcore.c
> +++ b/arch/arm64/kernel/elfcore.c
> @@ -8,9 +8,9 @@
>  #include <asm/cpufeature.h>
>  #include <asm/mte.h>
>  
> -#define for_each_mte_vma(tsk, vma)					\
> +#define for_each_mte_vma(vmi, vma)					\
>  	if (system_supports_mte())					\
> -		for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)	\
> +		for_each_vma(vmi, vma)					\
>  			if (vma->vm_flags & VM_MTE)
>  
>  static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
> @@ -65,8 +65,9 @@ Elf_Half elf_core_extra_phdrs(void)
>  {
>  	struct vm_area_struct *vma;
>  	int vma_count = 0;
> +	VMA_ITERATOR(vmi, current->mm, 0);
>  
> -	for_each_mte_vma(current, vma)
> +	for_each_mte_vma(vmi, vma)
>  		vma_count++;

I'm fine with the patch but it can't be applied to arm64 for-next/mte
branch as it won't build and the maple tree doesn't have the MTE
patches. Do you have a stable branch with the for_each_vma() iterator?

Anyway, if you find a way to solve the problem, for this patch:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
