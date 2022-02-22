Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF714C058C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiBVXto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbiBVXth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:49:37 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02EE3E5E8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:49:02 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z15so7904046pfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k4qXAFqi0ySdR1Aw0Ol4TjEnW6pDCjdujI4uqf/WnnU=;
        b=ZmrKv5e3LteilLdgvO0riCg56HCfXHzS5Oo12KO3OkOWIYQXyGiLi5XNNrLgp7YCf8
         l5gxN2WmuRZRBBtn709j//Go662IvHPvA09LL+YE0r/+SjxWQ1G/4wdDPRIWlAeSKINo
         DdZK8E6mAVsQ3HcXj2qgWqTojpwo1DHXZrcEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k4qXAFqi0ySdR1Aw0Ol4TjEnW6pDCjdujI4uqf/WnnU=;
        b=jlqCOT8bdDTQJziUDt7uBNeFzko28D1loKcq/XJBgfMDXekXnEvE9IrdWIwTqULD56
         mRD+2KY4CmPnuA5WhQ6SE+n/nHP4qwPQrUrVGiPb+EPsTx2nezqWSp7+ZTTpgsR9bjN4
         BO2h/B0thjPcvzkN+PM3GepeTA0kuMkM//NAB3j35Xa/3NdbF4Y0wrCRy6jKhm6LRhDJ
         Aj9cL2wRoepmo3xI+dL7rJ2Ztog0mWMMCPm1idsBXqqbaUFVIsw7sZm5lJ4jzxvE7V9Q
         o0E1JnoRDWwhbwMIXL1hLf/cr6f1++w7GcSee9OcQFUqqncV+IgiCkivuN8QKIDZEHNo
         xJpA==
X-Gm-Message-State: AOAM533/o1nq7j8gxTNRgcjWs3rx8nBVD3ZBC6hnAngLIs+TAUgt/QCG
        Wu+3FbiCtDel/h6xlVbaXkIl9g==
X-Google-Smtp-Source: ABdhPJwO85XCsJ5U7aygs5T7n4qrv8cEaxFM6h8IIKkhSD3i+A4YChQvIGP8qo+3GKsOKcHea9z9KA==
X-Received: by 2002:a63:224c:0:b0:372:9ec7:e7e4 with SMTP id t12-20020a63224c000000b003729ec7e7e4mr21075101pgm.385.1645573742144;
        Tue, 22 Feb 2022 15:49:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z14sm19080775pfe.30.2022.02.22.15.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:49:01 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:49:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Juxin Gao <gaojuxin@loongson.cn>, linux-mips@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MIPS: Modernize READ_IMPLIES_EXEC
Message-ID: <202202221548.40C0AA5E@keescook>
References: <20210901194208.2420671-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901194208.2420671-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping. :)

On Wed, Sep 01, 2021 at 12:42:08PM -0700, Kees Cook wrote:
> I'm doing some thread necromancy of
> https://lore.kernel.org/lkml/202007081624.82FA0CC1EA@keescook/
> 
> x86, arm64, and arm32 adjusted their READ_IMPLIES_EXEC logic to better
> align with the safer defaults and the interactions with other mappings,
> which I illustrated with this comment on x86:
> 
> /*
>  * An executable for which elf_read_implies_exec() returns TRUE will
>  * have the READ_IMPLIES_EXEC personality flag set automatically.
>  *
>  * The decision process for determining the results are:
>  *
>  *                 CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
>  * ELF:                 |            |                  |                |
>  * ---------------------|------------|------------------|----------------|
>  * missing PT_GNU_STACK | exec-all   | exec-all         | exec-none      |
>  * PT_GNU_STACK == RWX  | exec-stack | exec-stack       | exec-stack     |
>  * PT_GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
>  *
>  *  exec-all  : all PROT_READ user mappings are executable, except when
>  *              backed by files on a noexec-filesystem.
>  *  exec-none : only PROT_EXEC user mappings are executable.
>  *  exec-stack: only the stack and PROT_EXEC user mappings are
>  *  executable.
>  *
>  *  *this column has no architectural effect: NX markings are ignored by
>  *   hardware, but may have behavioral effects when "wants X" collides with
>  *   "cannot be X" constraints in memory permission flags, as in
>  *   https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
>  *
>  */
> 
> For MIPS, the "lacks NX" above is the "!cpu_has_rixi" check. On x86,
> we decided that the READ_IMPLIES_EXEC flag needed to reflect the
> expectations, not the architectural behavior due to bad interactions
> as noted above, as always returning "1" on non-NX hardware breaks
> some mappings.
> 
> The other part of the issue is "what does the MIPS toolchain do for
> PT_GNU_STACK?" The answer seems to be "by default, include PT_GNU_STACK,
> but mark it executable" (likely due to concerns over non-NX hardware):
> 
> $ mipsel-linux-gnu-gcc -o hello_world hello_world.c
> $ llvm-readelf -lW hellow_world | grep GNU_STACK
>   GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x10
> 
> Given that older hardware doesn't support non-executable memory, it
> seems safe to make the "PT_GNU_STACK is absent" logic mean "assume
> non-executable", but this might break very old software running on
> modern MIPS. This situation matches the ia32-on-x86_64 logic x86
> uses (which assumes needing READ_IMPLIES_EXEC in that situation). But
> modern toolchains on modern MIPS hardware should follow a safer default
> (assume NX stack).
> 
> A follow-up to this change would be to switch the MIPS toolchain to emit
> a non-executable PT_GNU_STACK, as this seems to be unneeded.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Xuefeng Li <lixuefeng@loongson.cn>
> Cc: Juxin Gao <gaojuxin@loongson.cn>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/mips/kernel/elf.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> index 7b045d2a0b51..5582a4ca1e9e 100644
> --- a/arch/mips/kernel/elf.c
> +++ b/arch/mips/kernel/elf.c
> @@ -328,16 +328,10 @@ void mips_set_personality_nan(struct arch_elf_state *state)
>  
>  int mips_elf_read_implies_exec(void *elf_ex, int exstack)
>  {
> -	if (exstack != EXSTACK_DISABLE_X) {
> -		/* The binary doesn't request a non-executable stack */
> -		return 1;
> -	}
> -
> -	if (!cpu_has_rixi) {
> -		/* The CPU doesn't support non-executable memory */
> -		return 1;
> -	}
> -
> -	return 0;
> +	/*
> +	 * Set READ_IMPLIES_EXEC only on non-NX systems that
> +	 * do not request a specific state via PT_GNU_STACK.
> +	 */
> +	return (!cpu_has_rixi && exstack == EXSTACK_DEFAULT);
>  }
>  EXPORT_SYMBOL(mips_elf_read_implies_exec);
> -- 
> 2.30.2
> 

-- 
Kees Cook
