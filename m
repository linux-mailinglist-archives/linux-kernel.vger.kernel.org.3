Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7EA52A1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346401AbiEQMsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243529AbiEQMsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:48:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6883C70B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:48:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L2bX221Lwz4xZ2;
        Tue, 17 May 2022 22:48:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652791714;
        bh=TDeqjo10z/lPZ0BTlKdpVqFzl6dlu8tIpR5fp3YJtjE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QiiFptg0D+ihDZM7seo2f+wYINfaOQNzMLR2VUHUpdeOE9fgLMzgZG8P6+JxAZ/EZ
         s9p7+wdZZVWhxWP+MfhjuHYudBMb/UAx8dzeYhWd0diY2cArjEdh5wsZzEkYcX3cmb
         9tJUCVSHBHPpqLwbQMheLzEZzX3kcPFW+b2JIDzYWKapSFKpzGd+wnGbLMsx7cEGCO
         Hu1/l2PeemupH2wtS6DrVtVfhQwkPHPgYNkC5ukyXdHX2iahKgUglygE2HH9PgOKVL
         WNDGK6AT5tNxuDYULhkA/m1akdKYydLpFO1S65TSHdqOjwwz4zeVE6uLGr9aq/XGTC
         R4Ly3ybYFX18Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/irq: Remove arch_local_irq_restore() for
 !CONFIG_CC_HAS_ASM_GOTO
In-Reply-To: <58df50c9e77e2ed945bacdead30412770578886b.1652715336.git.christophe.leroy@csgroup.eu>
References: <58df50c9e77e2ed945bacdead30412770578886b.1652715336.git.christophe.leroy@csgroup.eu>
Date:   Tue, 17 May 2022 22:48:32 +1000
Message-ID: <871qwspbof.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> All supported versions of GCC support asm goto.

I thought clang was the one that only recently added support for asm
goto.

<looks>

Apparently clang added support in 2019, in clang 9. The earliest clang
we claim to support is 11.

So this patch is good, I'll just adjust the change log to say GCC/clang.

cheers

> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index c768cde03e36..dd09919c3c66 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -216,7 +216,6 @@ static inline void replay_soft_interrupts_irqrestore(void)
>  #define replay_soft_interrupts_irqrestore() replay_soft_interrupts()
>  #endif
>  
> -#ifdef CONFIG_CC_HAS_ASM_GOTO
>  notrace void arch_local_irq_restore(unsigned long mask)
>  {
>  	unsigned char irq_happened;
> @@ -312,82 +311,6 @@ notrace void arch_local_irq_restore(unsigned long mask)
>  	__hard_irq_enable();
>  	preempt_enable();
>  }
> -#else
> -notrace void arch_local_irq_restore(unsigned long mask)
> -{
> -	unsigned char irq_happened;
> -
> -	/* Write the new soft-enabled value */
> -	irq_soft_mask_set(mask);
> -	if (mask)
> -		return;
> -
> -	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> -		WARN_ON_ONCE(in_nmi() || in_hardirq());
> -
> -	/*
> -	 * From this point onward, we can take interrupts, preempt,
> -	 * etc... unless we got hard-disabled. We check if an event
> -	 * happened. If none happened, we know we can just return.
> -	 *
> -	 * We may have preempted before the check below, in which case
> -	 * we are checking the "new" CPU instead of the old one. This
> -	 * is only a problem if an event happened on the "old" CPU.
> -	 *
> -	 * External interrupt events will have caused interrupts to
> -	 * be hard-disabled, so there is no problem, we
> -	 * cannot have preempted.
> -	 */
> -	irq_happened = get_irq_happened();
> -	if (!irq_happened) {
> -		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> -			WARN_ON_ONCE(!(mfmsr() & MSR_EE));
> -		return;
> -	}
> -
> -	/* We need to hard disable to replay. */
> -	if (!(irq_happened & PACA_IRQ_HARD_DIS)) {
> -		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> -			WARN_ON_ONCE(!(mfmsr() & MSR_EE));
> -		__hard_irq_disable();
> -		local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
> -	} else {
> -		/*
> -		 * We should already be hard disabled here. We had bugs
> -		 * where that wasn't the case so let's dbl check it and
> -		 * warn if we are wrong. Only do that when IRQ tracing
> -		 * is enabled as mfmsr() can be costly.
> -		 */
> -		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG)) {
> -			if (WARN_ON_ONCE(mfmsr() & MSR_EE))
> -				__hard_irq_disable();
> -		}
> -
> -		if (irq_happened == PACA_IRQ_HARD_DIS) {
> -			local_paca->irq_happened = 0;
> -			__hard_irq_enable();
> -			return;
> -		}
> -	}
> -
> -	/*
> -	 * Disable preempt here, so that the below preempt_enable will
> -	 * perform resched if required (a replayed interrupt may set
> -	 * need_resched).
> -	 */
> -	preempt_disable();
> -	irq_soft_mask_set(IRQS_ALL_DISABLED);
> -	trace_hardirqs_off();
> -
> -	replay_soft_interrupts_irqrestore();
> -	local_paca->irq_happened = 0;
> -
> -	trace_hardirqs_on();
> -	irq_soft_mask_set(IRQS_ENABLED);
> -	__hard_irq_enable();
> -	preempt_enable();
> -}
> -#endif
>  EXPORT_SYMBOL(arch_local_irq_restore);
>  
>  /*
> -- 
> 2.35.1
