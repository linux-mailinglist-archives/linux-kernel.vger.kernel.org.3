Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA245708F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiGKRiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGKRim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:38:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE106569
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:38:40 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r9so7058704ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQj9SC9LzzvOt29hChR7g7E0Lc7GX6Hy0KSuYXInGDE=;
        b=f1TD0jljg/IWNfS09CDUXQ2i7XWpMyLwkZYu7JGV2gzXGa2UVnksceghpfLAy/UQC6
         AJ114v+NuGgFr7knklFFpz6ynue3oYETOfOm5R//r6OUBA7BELjDo5Wk3tlBs1wDb689
         O923kaNhZUnHvdp476b/5NIklZmtWSPbnYd5u8VIpENd0nwqvMtIwuwospT0OuzRRfFD
         yM6dWj90pCYNGJRTDqlWUJo/Nu7KHUnfX0Dzn2Dj1MmFEQJwptkhESV4I+WFwN4PRbMS
         wIrYu07ulUmuOQggE46pqVEpy2So5a9Vp6pUcKuZ+2W31x+Drf9hUABiGkzYO5DfaZ+C
         dJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQj9SC9LzzvOt29hChR7g7E0Lc7GX6Hy0KSuYXInGDE=;
        b=OwNFnGOEOzq7RRnHRcdppk9CbjGHu0jQyqQ7Kwz9Qsg2JPUOvV+cwg1eJHwRlhLG2+
         lk+mPyrdY4M8FiTouV2/3bv2RCERVp13LOuzxENjL6Daylq5P9SytmHSjWckv+a5fhDD
         dBxmMCaFK8ad5Bn5zZtu3PJap4XdliMcbonP9ce/5W22wlRWV18jwtJnYpV9kRIqdgGV
         gjD+sqEekASw/6GIQUWicYFm0Nov/GXhhn4MiBGTeIMz2nHYqgG8k7eUAPYhasf8wBRw
         E4uFGTLG6qpWOIiiDHzfTri2+1sVvfbde75BA6JHLE2iOZWNXCn3ZDHzDvGdaaXIv1wT
         dopg==
X-Gm-Message-State: AJIora+Tok/+qy72VklFc/ooa2igLdNjgs5Jx7Dvsr3aZPfjbOI3A7u/
        IbgDYd/TSRO1FT5ngFtbSJEUL7eTdYiUt6hwd6kczg==
X-Google-Smtp-Source: AGRyM1u0DMzzoMdO3sxBWXuOKwxHG4cPlzL7241+1VuSMH0ejamZIb6JycU8Bwpc+nLYSgUU3vNiSrLtM6MHva0BM8c=
X-Received: by 2002:a05:651c:2104:b0:25b:f4ed:db93 with SMTP id
 a4-20020a05651c210400b0025bf4eddb93mr10900111ljq.295.1657561118922; Mon, 11
 Jul 2022 10:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220710071117.446112-1-maskray@google.com>
In-Reply-To: <20220710071117.446112-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Jul 2022 10:38:25 -0700
Message-ID: <CAKwvOd=yTio6SDG-dEEB1W3nQdZZNk67x_DsiedmC5t95P8XNg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Pass -mno-relax only on lld < 15.0.0
To:     Fangrui Song <maskray@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Khem Raj <raj.khem@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 12:11 AM Fangrui Song <maskray@google.com> wrote:
>
> lld since
> https://github.com/llvm/llvm-project/commit/6611d58f5bbcbec77262d392e2923e1d680f6985
> (milestone: 15.0.0) has implemented some RISC-V linker relaxation.
> -mno-relax is no longer needed in KBUILD_CFLAGS/KBUILD_AFLAGS to
> suppress R_RISCV_ALIGN which older lld can not handle:
>
> ld.lld: error: capability.c:(.fixup+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax but the .o is already compiled with -mno-relax
>
> Signed-off-by: Fangrui Song <maskray@google.com>

Thanks for implementing relaxation in LLD for RISC-V!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/riscv/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 34cf8a598617..7e4ceb2a0981 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -37,6 +37,7 @@ else
>  endif
>
>  ifeq ($(CONFIG_LD_IS_LLD),y)
> +ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 150000; echo $$?),0)
>         KBUILD_CFLAGS += -mno-relax
>         KBUILD_AFLAGS += -mno-relax
>  ifndef CONFIG_AS_IS_LLVM
> @@ -44,6 +45,7 @@ ifndef CONFIG_AS_IS_LLVM
>         KBUILD_AFLAGS += -Wa,-mno-relax
>  endif
>  endif
> +endif
>
>  # ISA string setting
>  riscv-march-$(CONFIG_ARCH_RV32I)       := rv32ima
> --
> 2.37.0.144.g8ac04bfd2-goog
>
>


-- 
Thanks,
~Nick Desaulniers
