Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A4B51DCE9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443424AbiEFQKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiEFQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:10:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBEB2E2
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:06:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p189so4713105wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GiGYPfDnrElOyMsDApPC2Vl2Va3S+4P5NKMxYV1zAmk=;
        b=lUkxe24y6Ui8kS++T8mYWcacJPpKLPNIJaWeyUX87JhzgES+ovJhMmJ38yK3Zof7pS
         nSBZXN4ia0XhLgcDNqlRocf/dct3tfTvO6ZVG6hM8dyZ0RB4R5ONHTKOOehLlG1U13eQ
         X22h+QvrtRW5lXBSqB6z+nULEExE9kjvfJ0PckfeMxdxjggOtxBpEddacB+BLnTUG/T+
         PUkIHQ15QSugefzrpIp8gPKEwxoi+rM1KxvbF/QVz9vXa49yZNSiEUmJuIPVc9vNY+8w
         xhZq6S8ysFv4aPO+nDMX6fGNa4vm7ijKpsvj+xiwj2za9HdHOcMuokRTCZCT9FisH1Xp
         oRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GiGYPfDnrElOyMsDApPC2Vl2Va3S+4P5NKMxYV1zAmk=;
        b=Kv77/K3cfL2jk2frS/YTjCukStHfUx7EoNzb2B3emRQ6E+LNJfW5KRUD4eTut2+ChA
         GD63EvqgxOn66XlCtZcAFjIAm2GLqumD9kPnc/c1+ukLS3FEW2LWOtxk0kZdsZaCXebZ
         QKCkW2puelOVIiQ9fUnCZKXwzB2Vd5x+9ixfvDnPAp1MUCVrNuzYHFEC++/cVSj9lD0T
         XZxx7qVvCT8kGfvP258cfQo3bG4UvTJ9KQZRCwpnTeapXv2sADBQyqGM6hkq/VNWhS9a
         pcS01lCsxA1TT6rnJbou/p0MPimDI3UTPqSEF2qQtfvTfJKoW+uGUQgv0dMpFXJA8sXO
         zdNg==
X-Gm-Message-State: AOAM5303kkcyRMfAhj9bNf89e9jyyurII6VxldQ9YDZR+HKP03mhBZHN
        42GDuBjFyQholx3NMZT+WhEwwQ==
X-Google-Smtp-Source: ABdhPJyZNkelDE3X/+S6pxxPzo1OQeDcWxLF/r12HVkibyQPY0EdkRMLU7/s5AK+RHm+08aK+B9QjQ==
X-Received: by 2002:a7b:c5ca:0:b0:394:7a03:48b6 with SMTP id n10-20020a7bc5ca000000b003947a0348b6mr3613589wmk.104.1651853212704;
        Fri, 06 May 2022 09:06:52 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d5607000000b0020c5253d904sm3906391wrv.80.2022.05.06.09.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 09:06:51 -0700 (PDT)
Date:   Fri, 6 May 2022 17:06:49 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, mhiramat@kernel.org,
        jason.wessel@windriver.com, maz@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: entry: Skip single stepping interrupt
 handlers
Message-ID: <20220506160649.ojwc4rqpyhxqyrdo@maple.lan>
References: <20220413065458.88541-1-sumit.garg@linaro.org>
 <20220413065458.88541-2-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413065458.88541-2-sumit.garg@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 12:24:57PM +0530, Sumit Garg wrote:
> Current implementation allows single stepping into interrupt handlers
> for interrupts that were received during single stepping. But interrupt
> handlers aren't something that the user expect to debug. Moreover single
> stepping interrupt handlers is risky as it may sometimes leads to
> unbalanced locking when we resume from single-step debug.

Why does single stepping interrupt handlers cause unbalanced locking
(with the current code)?


> Fix broken single-step implementation via skipping single-step over
> interrupt handlers. The methodology is when we receive an interrupt from
> EL1, check if we are single stepping (pstate.SS). If yes then we save
> MDSCR_EL1.SS and clear the register bit if it was set. Then unmask only
> D and leave I set. On return from the interrupt, set D and restore
> MDSCR_EL1.SS. Along with this skip reschedule if we were stepping.

Does this description really explains the motivation here.

Isn't the goal to meet the user's expectation that when they step then
the system will stop at PC+4 relative the instruction they are stepping
(or PC+I for a branch that gets taken)?

To be clear, I've no objections to leaving interrupt handling enabled
when single stepping (AFAIK it is similar to what x86 does) but I think
this patch description will be difficult for future adventurers to
comprehend.


Daniel.


> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/kernel/entry-common.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 878c65aa7206..dd2d3af615de 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -458,19 +458,35 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
>  	do_interrupt_handler(regs, handler);
>  	irq_exit_rcu();
>  
> -	arm64_preempt_schedule_irq();
> +	/* Don't reschedule in case we are single stepping */
> +	if (!(regs->pstate & DBG_SPSR_SS))
> +		arm64_preempt_schedule_irq();
>  
>  	exit_to_kernel_mode(regs);
>  }
> +
>  static void noinstr el1_interrupt(struct pt_regs *regs,
>  				  void (*handler)(struct pt_regs *))
>  {
> +	unsigned long reg;
> +
> +	/* Disable single stepping within interrupt handler */
> +	if (regs->pstate & DBG_SPSR_SS) {
> +		reg = read_sysreg(mdscr_el1);
> +		write_sysreg(reg & ~DBG_MDSCR_SS, mdscr_el1);
> +	}
> +
>  	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
>  
>  	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
>  		__el1_pnmi(regs, handler);
>  	else
>  		__el1_irq(regs, handler);
> +
> +	if (regs->pstate & DBG_SPSR_SS) {
> +		write_sysreg(DAIF_PROCCTX_NOIRQ | PSR_D_BIT, daif);
> +		write_sysreg(reg, mdscr_el1);
> +	}
>  }
>  
>  asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> -- 
> 2.25.1
