Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674865AAB46
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiIBJW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiIBJWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:22:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939EC7F9B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:22:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j26so921232wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/C7RwhByTdUP1+TnbaoYX2Ts5Wnty/4rGeK1KUWN06M=;
        b=lh3d+no8joYHCHPHo+Gc5tbpyQ0MTyMJY4Ej08d5sJocxi5X7/d2G6IRrkWL4czNhU
         /Mmfe6+5KGf9SgHQ0bLRteA4BUiVAhlnUbd1aOEvk2VNA/5OSr8lPiYqNG3RSBpfIKdq
         wJ9QgnxvnS8288gT7VNCbD9SI6PFVHtQee95bXsGgU/4ZGkRJxKYPjMFiiO8e7ZH3+OE
         kCusFNP8rYvFsHCAzhUMX0MwvS/5KFlQEoHrlTS02Ux5YbveXp1FgsngNRJi2+Vtc059
         OWZak6VVknNWTEfQwkeBmu3oMjFjFYEOD/jBPxWM2Vl+4Ajwixb7DgG1VttsVo5lcrKe
         h5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/C7RwhByTdUP1+TnbaoYX2Ts5Wnty/4rGeK1KUWN06M=;
        b=KW7+mSnmczwnof0yFW5YW7RCO6grO7zeiD/m7Mz9hHSRaP3Ng5u5xkhmdCGWZbNCZk
         /yuUkaFEPcv2y+gpMF+UidG/O26GewiqDB7W56e97V0mJEaUMUifAg7kULgmk7GafQc7
         8h4sei2dtGrNhygUs8k6eblnWWjPyDqfJWbpGqzDHA2zvumTX8nJWKqADSimdqOXQj+v
         W/CgqeQMI7A9pV2/zv2dB1TZNYEjBC0Rs+wLLvR0hdbFHbQ6sPjkS/COtQhiZQF0dA5p
         yvjrEzCHe1uNzZcT/oCUspMgNNg0wXz1uzbuav9+t69tfFDtXKZ//kB109WJrxrck/Db
         kA0Q==
X-Gm-Message-State: ACgBeo3fg9ciYodko+HGf/HUze03lkUdD9fKLIGwk2iQo2zUfjAsz3Gt
        wkkoCS3lxu1Dd9PCjr1sz1pnF57lq4/HEw==
X-Google-Smtp-Source: AA6agR5FjFJhvxzRFHHVTDqYt7V8n6WL9uP4+1ZPwqFi1jH92Af7U+J1YF+j6Z9mYqxWiQyWuk1pWQ==
X-Received: by 2002:a1c:7214:0:b0:3a5:ea1c:c55b with SMTP id n20-20020a1c7214000000b003a5ea1cc55bmr2219205wmc.190.1662110567142;
        Fri, 02 Sep 2022 02:22:47 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4302000000b0021e51c039c5sm1037769wrq.80.2022.09.02.02.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:22:46 -0700 (PDT)
Date:   Fri, 2 Sep 2022 11:22:45 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix a nasty sigreturn bug...
Message-ID: <20220902092245.ande6fvievnbn35h@kamzik>
References: <YU0wDzeS/jXwkAca@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU0wDzeS/jXwkAca@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 01:55:27AM +0000, Al Viro wrote:
> riscv has an equivalent of arm bug fixed by 653d48b22166; if signal
> gets caught by an interrupt that hits when we have the right value
> in a0 (-513), *and* another signal gets delivered upon sigreturn()
> (e.g. included into the blocked mask for the first signal and posted
> while the handler had been running), the syscall restart logics will
> see regs->cause equal to EXC_SYSCALL (we are in a syscall, after all)
> and a0 already restored to its original value (-513, which happens to
> be -ERESTARTNOINTR) and assume that we need to apply the usual
> syscall restart logics.
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index c2d5ecbe55264..f8fb85dc94b7a 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -121,6 +121,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  	if (restore_altstack(&frame->uc.uc_stack))
>  		goto badframe;
>  
> +	regs->cause = -1UL;
> +
>  	return regs->a0;
>  
>  badframe:
>

This looks good to me based on what other architectures do.

For example, arm64 does

  rt_sigreturn
    restore_sigframe
      forget_syscall
        regs->syscallno = NO_SYSCALL

  which results in do_signal avoiding syscall restarting

And x86 does

  rt_sigreturn
    restore_sigcontext
      regs->orig_ax = -1

  where its handle_signal only restarts syscalls when regs->orig_ax != -1

So, for riscv, where in do_signal and handle_signal syscall restarting
is avoided when regs->cause != EXC_SYSCALL and it's common to set cause
to -1 to avoid it, then it makes sense to set regs->cause != EXEC_SYSCALL
in rt_sigreturn or in restore_sigcontext, which rt_sigreturn calls, as
well.

So the only question I have is whether or not the cause assignment
is better in restore_sigcontext() like other architectures? At least,
since rt_sigreturn is the only caller of restore_sigcontext, it can't
break anything putting it there atm...

Anyway,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

BTW, I ran the testcase from 653d48b22166 with the asm modified for
riscv for a while over QEMU. It didn't reproduce, but I suppose that
doesn't mean much.

Thanks,
drew
