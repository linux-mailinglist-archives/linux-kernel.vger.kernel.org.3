Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D06526644
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382138AbiEMPhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382238AbiEMPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:37:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C089092D2A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:36:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A06B113E;
        Fri, 13 May 2022 08:36:58 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3C83F73D;
        Fri, 13 May 2022 08:36:55 -0700 (PDT)
Date:   Fri, 13 May 2022 16:36:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 5/7] arm64: mte: Clean up user tag accessors
Message-ID: <Yn57FT9k2XoU3MT+@lakrids>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
 <20220420030418.3189040-6-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420030418.3189040-6-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:04:16AM +0000, Tong Tiangen wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Invoking user_ldst to explicitly add a post-increment of 0 is silly.
> Just use a normal USER() annotation and save the redundant instruction.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Tong Tiangen <tongtiangen@huawei.com>

When posting someone else's patch, you need to add your own
Signed-off-by tag. Please see:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

That said, the patch itself looks sane, and matches its original posting
at:

  https://lore.kernel.org/linux-arm-kernel/38c6d4b5-a3db-5c3e-02e7-39875edb3476@arm.com/

So:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

Catalin, are you happy to pick up this patch as a cleanup?

Thanks,
Mark.

> ---
>  arch/arm64/lib/mte.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> index 8590af3c98c0..eeb9e45bcce8 100644
> --- a/arch/arm64/lib/mte.S
> +++ b/arch/arm64/lib/mte.S
> @@ -93,7 +93,7 @@ SYM_FUNC_START(mte_copy_tags_from_user)
>  	mov	x3, x1
>  	cbz	x2, 2f
>  1:
> -	user_ldst 2f, ldtrb, w4, x1, 0
> +USER(2f, ldtrb	w4, [x1])
>  	lsl	x4, x4, #MTE_TAG_SHIFT
>  	stg	x4, [x0], #MTE_GRANULE_SIZE
>  	add	x1, x1, #1
> @@ -120,7 +120,7 @@ SYM_FUNC_START(mte_copy_tags_to_user)
>  1:
>  	ldg	x4, [x1]
>  	ubfx	x4, x4, #MTE_TAG_SHIFT, #MTE_TAG_SIZE
> -	user_ldst 2f, sttrb, w4, x0, 0
> +USER(2f, sttrb	w4, [x0])
>  	add	x0, x0, #1
>  	add	x1, x1, #MTE_GRANULE_SIZE
>  	subs	x2, x2, #1
> -- 
> 2.25.1
> 
