Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81D655F1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiF1Xd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiF1XdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E0234676
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B40D61B49
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07A5C341C8;
        Tue, 28 Jun 2022 23:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656459202;
        bh=XsW9jPBF5USPjAiBFULkL0LVTQOhRUT5Y8j6A3FY8Hs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W6C24EOP20h8WRx2/7nLBblc+/nmXG7fIVtSpjAVQoCRy1sH5zgfj7zBtwJejmYN9
         4g5DKMr/9Cbc4OCoJVgfK6THmBudCAXTh9Iq0poIes5wtdtxr9lSVUmNHPhdcz5WoO
         Y/sDOFUF5q+gadS9ORNbTJDrWY55QjB8FNYUNboAY8JaPiLR6i7KeaBW5g4JnsfxYu
         EQ1vzWdppVMQ8vDSfaxohvhaALT/Sd65vRzdKC8AzR9Y8mDRmQCHoPWxzjoetI5WOj
         nRkEP8wkHQbliuYs1s1Ib0ozDF5h7ZhxfJVw4tVRIIWdxqby+HPHt/mwr/qFOQ7AUH
         f1wFpWZ7cMngg==
Message-ID: <9efc4129-e82b-740f-3d6d-67f1468879bb@kernel.org>
Date:   Tue, 28 Jun 2022 16:33:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 07:35, Kirill A. Shutemov wrote:
> Linear Address Masking mode for userspace pointers encoded in CR3 bits.
> The mode is selected per-thread. Add new thread features indicate that the
> thread has Linear Address Masking enabled.
> 
> switch_mm_irqs_off() now respects these flags and constructs CR3
> accordingly.
> 
> The active LAM mode gets recorded in the tlb_state.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/include/asm/mmu.h         |  1 +
>   arch/x86/include/asm/mmu_context.h | 24 ++++++++++++
>   arch/x86/include/asm/tlbflush.h    |  3 ++
>   arch/x86/mm/tlb.c                  | 62 ++++++++++++++++++++++--------
>   4 files changed, 75 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 5d7494631ea9..d150e92163b6 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -40,6 +40,7 @@ typedef struct {
>   
>   #ifdef CONFIG_X86_64
>   	unsigned short flags;
> +	u64 lam_cr3_mask;
>   #endif
>   
>   	struct mutex lock;
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index b8d40ddeab00..e6eac047c728 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -91,6 +91,29 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
>   }
>   #endif
>   
> +#ifdef CONFIG_X86_64
> +static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
> +{
> +	return mm->context.lam_cr3_mask;
> +}
> +
> +static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
> +{
> +	mm->context.lam_cr3_mask = oldmm->context.lam_cr3_mask;
> +}
> +
> +#else
> +
> +static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
> +{
> +	return 0;
> +}
> +
> +static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
> +{
> +}
> +#endif

Do we really need the ifdeffery here?  I see no real harm in having the 
field exist on 32-bit -- we don't care much about performance for 32-bit 
kernels.

> -	if (real_prev == next) {
> +	if (real_prev == next && prev_lam == new_lam) {
>   		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
>   			   next->context.ctx_id);

This looks wrong to me.  If we change threads within the same mm but lam 
changes (which is certainly possible by a race if nothing else) then 
this will go down the "we really are changing mms" path, not the "we're 
not changing but we might need to flush something" path.
