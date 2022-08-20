Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C859AD04
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 11:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343849AbiHTJlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 05:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTJlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 05:41:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61C31C133
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 02:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DE3FB8013A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 09:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B3AC433C1;
        Sat, 20 Aug 2022 09:40:55 +0000 (UTC)
Date:   Sat, 20 Aug 2022 10:40:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: mte: move register initialization to C
Message-ID: <YwCsIm2nCXCEEgAd@arm.com>
References: <20220819013526.2682765-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819013526.2682765-1-pcc@google.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 06:35:26PM -0700, Peter Collingbourne wrote:
> If FEAT_MTE2 is disabled via the arm64.nomte command line argument on a
> CPU that claims to support FEAT_MTE2, the kernel will use Tagged Normal
> in the MAIR. If we interpret arm64.nomte to mean that the CPU does not
> in fact implement FEAT_MTE2, setting the system register like this may
> lead to UNSPECIFIED behavior.

I'm not convinced by this wording. There is no UNDEFINED behaviour since
proc.S checks the raw ID regs. Just passing arm64.nomte currently still
allows fully defined behaviour (well, unless you try to map tag storage
into the linear map but changing MAIR doesn't solve that anyway).

[...]
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 907401e4fffb..3554ff869f4b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2030,8 +2030,47 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
>  #ifdef CONFIG_ARM64_MTE
>  static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>  {
> +	u64 rgsr;
> +
>  	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
> +
> +	/*
> +	 * CnP must be enabled only after the MAIR_EL1 register has been set
> +	 * up. Inconsistent MAIR_EL1 between CPUs sharing the same TLB may
> +	 * lead to the wrong memory type being used for a brief window during
> +	 * CPU power-up.
> +	 *
> +	 * CnP is not a boot feature so MTE gets enabled before CnP, but let's
> +	 * make sure that is the case.
> +	 */
> +	BUG_ON(read_sysreg(ttbr0_el1) & TTBR_CNP_BIT);
> +	BUG_ON(read_sysreg(ttbr1_el1) & TTBR_CNP_BIT);

Ah, good point. SCOPE_BOOT_CPU features are initialised before the
others even for late secondary CPUs, so that should work without having
to reorder the features table.

> +
> +	/* Normal Tagged memory type at the corresponding MAIR index */
> +	sysreg_clear_set(
> +		mair_el1, MAIR_ATTRIDX(MAIR_ATTR_MASK, MT_NORMAL_TAGGED),
> +		MAIR_ATTRIDX(MAIR_ATTR_NORMAL_TAGGED, MT_NORMAL_TAGGED));

Nitpick: keep 'mair_el1' on the same line with sysreg_clear_set, I think
it looks slightly better if MAIR_ATTRIDX are both aligned.

[...]
> -	/* set the TCR_EL1 bits */
> -	mov_q	x10, TCR_MTE_FLAGS
> -	orr	tcr, tcr, x10

I'd keep the TCR setting under #ifdef MTE or rather the TCR_MTE_FLAGS
and make them 0 if !MTE. It gives us a chance to still test a kernel
configuration where TBI1 == 0.

BTW, we end up setting the TCMA1 bit even when MTE is not supported. It
shouldn't be a problem usually with RES0 bits which we know what they
do.

-- 
Catalin
