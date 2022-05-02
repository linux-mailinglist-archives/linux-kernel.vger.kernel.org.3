Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE5F5171AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385768AbiEBOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385591AbiEBOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:38:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FE626E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:35:17 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34B321EC0455;
        Mon,  2 May 2022 16:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651502112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xkMo8IXjwSpSn3yFdYrBLF5OKTpukIzfN2ZfXfe5+JU=;
        b=g8WtUhdLz2SwUpnTdEDnmjnBUusVsLPo7yw8+u9/0uiq9mWgDDR8mXLZXugOnq9DoJxLmf
        ezQRZbpCUAmqqk75bJOKYGvzmq02HnYfd/pASAPgRdp0AOSEXHDBW5ZkQwVE+qPP3uFiPB
        JXxd1a1acDHm+4KatO1jsnNabZ4DXYE=
Date:   Mon, 2 May 2022 16:35:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <Ym/sHqKqmLOJubgE@zn.tnic>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220501193102.704267030@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 09:31:47PM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -42,7 +42,7 @@ struct fpu_state_config fpu_user_cfg __r
>  struct fpstate init_fpstate __ro_after_init;
>  
>  /* Track in-kernel FPU usage */
> -static DEFINE_PER_CPU(bool, in_kernel_fpu);
> +static DEFINE_PER_CPU(bool, fpu_in_use);
>  
>  /*
>   * Track which context is using the FPU on the CPU:
> @@ -50,6 +50,50 @@ static DEFINE_PER_CPU(bool, in_kernel_fp
>  DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
>  
>  /**
> + * fpregs_lock - Lock FPU state for maintenance operations

"maintenance"?

> + *
> + * This protects against preemption, soft interrupts and in-kernel FPU
> + * usage on both !RT and RT enabled kernels.
> + *
> + * !RT kernels use local_bh_disable() to prevent soft interrupt processing
> + * and preemption.
> + *
> + * On RT kernels local_bh_disable() is not sufficient because it only
> + * serializes soft interrupt related sections via a local lock, but stays
> + * preemptible. Disabling preemption is the right choice here as bottom
> + * half processing is always in thread context on RT kernels so it
> + * implicitly prevents bottom half processing as well.
> + */
> +void fpregs_lock(void)
> +{
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		local_bh_disable();
> +	else
> +		preempt_disable();

So I'm wondering: can we get rid of this distinction and simply do
preempt_disable()?

Or can FPU be used in softirq processing too so we want to block that
there?

But even if, fpu_in_use will already state that fact...

...

> @@ -410,10 +433,9 @@ void kernel_fpu_begin_mask(unsigned int
>  {
>  	preempt_disable();
>  
> -	WARN_ON_FPU(!kernel_fpu_usable());
> -	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
> +	WARN_ON_ONCE(!kernel_fpu_usable());
>  
> -	this_cpu_write(in_kernel_fpu, true);
> +	this_cpu_write(fpu_in_use, true);

This starts to look awfully similar to fpregs_lock()...

>  
>  	if (!(current->flags & PF_KTHREAD) &&
>  	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
> @@ -433,9 +455,9 @@ EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask)
>  
>  void kernel_fpu_end(void)
>  {
> -	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
> +	WARN_ON_ONCE(!this_cpu_read(fpu_in_use));
>  
> -	this_cpu_write(in_kernel_fpu, false);
> +	this_cpu_write(fpu_in_use, false);
>  	preempt_enable();

... and this to fpregs_unlock().

Can we use those here too instead of open-coding them mostly?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
