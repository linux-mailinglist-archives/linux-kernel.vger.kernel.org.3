Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D810529298
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbiEPVSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349478AbiEPVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:18:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F9625C6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:16:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bx33so19596074ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pyM/dGPrMvG6mnoHbdfk5duPjwZk8VDdfN9LbJtBhU=;
        b=oLmIvXsVQtmo+mQoKeM5Ng+2p865gPqUSRlJzomijrfZR+uRnEu6S5gmFr51O79oF9
         HXFOmuFFAU9ydlxwXXqzayQ+CuxmYdyJVZSSoeXwSUsvImcAKagHjoDrUkxN7L8Qt3JQ
         8VXxa1NoZ755myqvlKHgqJj3nwyi0SI3x/8gqsLsKcM3LSWoqKd6zxEOSL79tByeqfYM
         CqXSvgYpUBJg8ADvoLvsVF7zRIqd0fmtzm9dMYMt5Ze9m7cs6jHpKDiqprwZNxpSWCyU
         tRXXVQpBxULun68DVKnrBwVWl9owNDHhOT1OCOZe84PFupYW3qfslsZyTRMrmDqvpPJ+
         LLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pyM/dGPrMvG6mnoHbdfk5duPjwZk8VDdfN9LbJtBhU=;
        b=jwpQP98e0IWcMl+eNa8cvoHkMCfvUiZNG9mdd1zugJBnc0lZoU0+EuGiV6X0Au8aF1
         tlfZ/iDTNj2cv8NrhlKmFTvr6ikpF9w3117p37UsIv/SMRmNGWUC+hASsLe9ko9/tb1i
         VqGzIpbKeNaEgnS5yBWijH+MknC23AUG1mLrmlVGhKMSq4U9u4i4iv3hOf2UDGtclDag
         9MIIltDge4kIhr6XxK91JHENXGWaAEYevi3yO9CnZdDGugATiT/TpHN85sDiNbkwgUNh
         PJPqwUzI11Ux6YuI2QGs6MGTwpyEWB9OSlM8XQYe5AW3p4XbNGLkQB+T/DysAjJ7pgW+
         3/TQ==
X-Gm-Message-State: AOAM5316RvXqZis3H2HXkmnj49zq2At3DAo3wtO8OqMneZuLByuAheet
        nbrnjX6MU1yZLgqBCfBKksXJrG0R+FsMtu6DAU0+lg==
X-Google-Smtp-Source: ABdhPJw9PQYQgUgAt8gKkAfmc4S1ts/cLSZQ0l2aqvl1K3hvc5CDrxCDVNwyaXc4Z9rbV1eOXjAYjhrw+SOFBSg6ktY=
X-Received: by 2002:a05:651c:101:b0:250:896d:f870 with SMTP id
 a1-20020a05651c010100b00250896df870mr12063160ljb.235.1652735770007; Mon, 16
 May 2022 14:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220516210954.1660716-1-ndesaulniers@google.com> <20220516210954.1660716-4-ndesaulniers@google.com>
In-Reply-To: <20220516210954.1660716-4-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 May 2022 14:15:58 -0700
Message-ID: <CAKwvOd=x9Fcedp8TaHtReLtjc0MARRH8Wo7aCCLfyG-rV02okA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ARM: only use -mtp=cp15 for the compiler
To:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

+ Ard (I messed up my command line invocation of git send-email, sorry
for more noise)
https://lore.kernel.org/llvm/20220516210954.1660716-1-ndesaulniers@google.com/

On Mon, May 16, 2022 at 2:10 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Avoids an error from the assembler for CONFIG_THUMB2 kernels:
>
> clang-15: error: hardware TLS register is not supported for the thumbv4t
> sub-architecture
>
> This flag only makes sense to pass to the compiler, not the assembler.
>
> Perhaps CFLAGS_ABI can be renamed to CPPFLAGS_ABI to reflect that they
> will be passed to both the compiler and assembler for sources that
> require pre-processing.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 99a7ed7e9f09..1029c2503aef 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -108,7 +108,7 @@ CFLAGS_ABI  += -meabi gnu
>  endif
>
>  ifeq ($(CONFIG_CURRENT_POINTER_IN_TPIDRURO),y)
> -CFLAGS_ABI     += -mtp=cp15
> +KBUILD_CFLAGS  += -mtp=cp15
>  endif
>
>  # Accept old syntax despite ".syntax unified"
> --
> 2.36.0.550.gb090851708-goog
>


-- 
Thanks,
~Nick Desaulniers
