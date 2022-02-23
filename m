Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D344C1C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbiBWTej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiBWTeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:34:37 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0324D12AB1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:34:10 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z4so21057101pgh.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xx/nJWtKVQ2r/ghOXNBRnDRbIE8tV+oqAzOXtwE9kSk=;
        b=NGFREi7RSyhoYdxZH62APfuJu96ZfTSnPYczoNDq3FSnlXjP36rJtsApFddUhDQaxn
         JS2RlR7sDyWXhntPdpagf9gOdxsybBiqrqogzOWijA3Dmev4Mgr/Jtx4HYBTgKBoodfB
         S6dl220f0XV8muWKQAz+uRlRpFqN8095CatAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xx/nJWtKVQ2r/ghOXNBRnDRbIE8tV+oqAzOXtwE9kSk=;
        b=TibDBWnk7VggMYu5VQvwHctwAjbJ8EruPjJkKPvUJDe2GcebMYRcElPpBa84gS2Zoc
         544s03KM2BmSAOdw3Lq2GzXdIOWxnKdp9zkwosP2pSTJuqqyTfhMdMd/gLTIbnFExIDY
         Ne3wVZ4mGB2bHxpcv//qnbDf/G7gktQxHX0BqlKSA4Q+K7j/VUv/m/OCP/N+ZyI2z5Ie
         SR3GcPCX6/Qzwpm0990Y6F50VNQLLSztyekRur2Tya+mS7gZ+bVkq+GGPI2LGPsaMO6I
         5WSMBcY/ruPf2Sl/PwclGG0Ay1qrM1YfT+JTCC5zpSwQ85VDn1qSvTyK+pWu6NEe6jA3
         v9JA==
X-Gm-Message-State: AOAM532p5u4FGjUh4saxRkpXtzUzt0Srvr41pAH2+DT9rJ0HcH5y2zYy
        81Kec9EwtRxsOQ7nIfE2nd2fTIMFMDOa1w==
X-Google-Smtp-Source: ABdhPJxX/URmFtB+GXqYaAMCGSemAGI+Rp5Jz/r2/uASmwJg/jbwKZ3HQtTIl5ed4mWRIOcd7rbayw==
X-Received: by 2002:a63:d306:0:b0:34e:4330:efea with SMTP id b6-20020a63d306000000b0034e4330efeamr901399pgg.174.1645644849526;
        Wed, 23 Feb 2022 11:34:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm297782pfu.79.2022.02.23.11.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:34:09 -0800 (PST)
Date:   Wed, 23 Feb 2022 11:34:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Clear volatile regs on syscall exit
Message-ID: <202202231131.08B7EC1@keescook>
References: <28b040bd2357a1879df0ca1b74094323f778a472.1645636285.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b040bd2357a1879df0ca1b74094323f778a472.1645636285.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 06:11:36PM +0100, Christophe Leroy wrote:
> Commit a82adfd5c7cb ("hardening: Introduce CONFIG_ZERO_CALL_USED_REGS")
> added zeroing of used registers at function exit.
> 
> At the time being, PPC64 clears volatile registers on syscall exit but
> PPC32 doesn't do it for performance reason.
> 
> Add that clearing in PPC32 syscall exit as well, but only when
> CONFIG_ZERO_CALL_USED_REGS is selected.
> 
> On an 8xx, the null_syscall selftest gives:
> - Without CONFIG_ZERO_CALL_USED_REGS		: 288 cycles
> - With CONFIG_ZERO_CALL_USED_REGS		: 305 cycles
> - With CONFIG_ZERO_CALL_USED_REGS + this patch	: 319 cycles
> 
> Note that (independent of this patch), with pmac32_defconfig,
> vmlinux size is as follows with/without CONFIG_ZERO_CALL_USED_REGS:
> 
>    text	   	data	    bss	    dec	    hex		filename
> 9578869		2525210	 194400	12298479	bba8ef	vmlinux.without
> 10318045	2525210  194400	13037655	c6f057	vmlinux.with
> 
> That is a 7.7% increase on text size, 6.0% on overall size.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/entry_32.S | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 7748c278d13c..199f23092c02 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -151,6 +151,21 @@ syscall_exit_finish:
>  	bne	3f
>  	mtcr	r5
>  
> +#ifdef CONFIG_ZERO_CALL_USED_REGS
> +	/* Zero volatile regs that may contain sensitive kernel data */
> +	li	r0,0
> +	li	r4,0
> +	li	r5,0
> +	li	r6,0
> +	li	r7,0
> +	li	r8,0
> +	li	r9,0
> +	li	r10,0
> +	li	r11,0
> +	li	r12,0
> +	mtctr	r0
> +	mtxer	r0
> +#endif

I think this should probably be unconditional -- if this is actually
leaking kernel pointers (or data) that's pretty bad. :|

If you really want to leave it build-time selectable, maybe add a new
config that gets "select"ed by CONFIG_ZERO_CALL_USED_REGS?

(And you may want to consider wiping all "unused" registers at syscall
entry as well.)

-Kees

>  1:	lwz	r2,GPR2(r1)
>  	lwz	r1,GPR1(r1)
>  	rfi
> -- 
> 2.34.1
> 

-- 
Kees Cook
