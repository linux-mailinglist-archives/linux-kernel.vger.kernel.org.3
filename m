Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7804FE690
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357989AbiDLRLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350498AbiDLRLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:11:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D528060AB7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:08:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE6A1424;
        Tue, 12 Apr 2022 10:08:45 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 086BD3F5A1;
        Tue, 12 Apr 2022 10:08:37 -0700 (PDT)
Message-ID: <38c6d4b5-a3db-5c3e-02e7-39875edb3476@arm.com>
Date:   Tue, 12 Apr 2022 18:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH -next V3 4/6] arm64: add copy_{to, from}_user to
 machine check safe
Content-Language: en-GB
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
References: <20220412072552.2526871-1-tongtiangen@huawei.com>
 <20220412072552.2526871-5-tongtiangen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220412072552.2526871-5-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 8:25 am, Tong Tiangen wrote:
[...]
> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> index 0557af834e03..bb17f0829042 100644
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@ -92,4 +92,20 @@ alternative_else_nop_endif
>   
>   		_asm_extable	8888b,\l;
>   	.endm
> +
> +	.macro user_ldp_mc l, reg1, reg2, addr, post_inc
> +8888:		ldtr	\reg1, [\addr];
> +8889:		ldtr	\reg2, [\addr, #8];
> +		add	\addr, \addr, \post_inc;
> +
> +		_asm_extable_uaccess_mc	8888b, \l;
> +		_asm_extable_uaccess_mc	8889b, \l;
> +	.endm

You're replacing the only user of this, so please just 
s/_asm_extable/_asm_extable_uaccess_mc/ in the existing macro and save 
the rest of the churn.

Furthermore, how come you're not similarly updating user_stp, given that 
you *are* updating the other stores in copy_to_user?

> +
> +	.macro user_ldst_mc l, inst, reg, addr, post_inc
> +8888:		\inst		\reg, [\addr];
> +		add		\addr, \addr, \post_inc;
> +
> +		_asm_extable_uaccess_mc	8888b, \l;
> +	.endm

Similarly, I think we can just update user_ldst itself. The two 
instances that you're not replacing here are bogus anyway, and deserve 
to be fixed with the patch below first.

[...]
> @@ -62,7 +63,11 @@ SYM_FUNC_START(__arch_copy_from_user)
>   	ret
>   
>   	// Exception fixups
> -9997:	cmp	dst, dstin
> +9997:	mrs esr, esr_el1			// Check exception first
> +	and esr, esr, #ESR_ELx_FSC
> +	cmp esr, #ESR_ELx_FSC_EXTABT

Should we be checking EC to make sure it's a data abort - and thus FSC 
is valid - in the first place? I'm a little fuzzy on all the possible 
paths into fixup_exception(), and it's not entirely obvious whether this 
is actually safe or not.

Thanks,
Robin.

----->8-----
Subject: [PATCH] arm64: mte: Clean up user tag accessors

Invoking user_ldst to explicitly add a post-increment of 0 is silly.
Just use a normal USER() annotation and save the redundant instruction.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  arch/arm64/lib/mte.S | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index 8590af3c98c0..eeb9e45bcce8 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -93,7 +93,7 @@ SYM_FUNC_START(mte_copy_tags_from_user)
  	mov	x3, x1
  	cbz	x2, 2f
  1:
-	user_ldst 2f, ldtrb, w4, x1, 0
+USER(2f, ldtrb	w4, [x1])
  	lsl	x4, x4, #MTE_TAG_SHIFT
  	stg	x4, [x0], #MTE_GRANULE_SIZE
  	add	x1, x1, #1
@@ -120,7 +120,7 @@ SYM_FUNC_START(mte_copy_tags_to_user)
  1:
  	ldg	x4, [x1]
  	ubfx	x4, x4, #MTE_TAG_SHIFT, #MTE_TAG_SIZE
-	user_ldst 2f, sttrb, w4, x0, 0
+USER(2f, sttrb	w4, [x0])
  	add	x0, x0, #1
  	add	x1, x1, #MTE_GRANULE_SIZE
  	subs	x2, x2, #1
-- 
2.28.0.dirty
