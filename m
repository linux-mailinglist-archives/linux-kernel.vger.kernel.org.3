Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8544EFBCC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352620AbiDAUvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDAUvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:51:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00DB1C2DB8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:49:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h7so7056629lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6d2skYVql+tVSKN+LeWI4wqrla7+wIiNypxUwRkHa4=;
        b=hMYd6pmTPI97+AcCZJh/Dn8QrpJ9HZZTcdS8TTMPkGWVSlqDKFYucXq6uh7LsUsts7
         XYPQnt6lwklNXpyprFv5V31939VSdLI/WWh9ySAmPfOmfEEOraklJJtoDhwbNPL7uVl0
         c0QHb14+qWmOw6B7QrY5S4H1spDxTv0lSNah/dILmDC1ONV8QwXT0XywtWhVLu5hTJFI
         X/tz9fDtANJolNAaaHFOIDu2Voab/vkYf6vCK5+yw4RcHvnhF7fOPHsN2yDybtQ9buZP
         rRdsBilp4kXieYloEzL5TNYP8JnzdEymBVGCCoRXt7qqpCf2WqsP9Vbc086TuWB9PWr8
         Csfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6d2skYVql+tVSKN+LeWI4wqrla7+wIiNypxUwRkHa4=;
        b=VciqLPaqu8e6HJkuGcNIESIU+dFuVwQ7NS10T5pIufcsmyg7R+Ema1XtL3s/CYRFvD
         aDBMWsMwNxxxQMDRtPtlWfkmuroSMWw0FG/k1Id8WtwvDCoxSBX8xkhUeLmd3qeSOjwU
         /Q5PLle1UnritdZyvEfHD0tuCtc9J6O9WYya053R78l2O5ImBZ5bewHDz+T8Z3TT+9k7
         7ldoj8eJES8uU3V2ADB6RVphdK48rJTjts+hLBwFplufhaZuu38943OPGFEOE2jRViJO
         w0odwViJPS7fTG56zloO38BJB9bn3uY7wd/RTVaE/rpxGcnfzxUQA5lsxcodZsb0NGD8
         lVzQ==
X-Gm-Message-State: AOAM532vmI1wEPL93Vly3VMP4YNTv8R5qw69qitCcU3HlogXonRmzCCo
        CQAKNlo/k+NkleUUHVeBx0Jm/4r7Q0zZdKM1lneGPw==
X-Google-Smtp-Source: ABdhPJwtN5JV7Er0QkmPA4FTptAsdOeyV1pqpypoQcR+zJKtwpSy5DFfObCmyKJ5WiGZs0EFARcFSwsA/J9wRS8COWQ=
X-Received: by 2002:ac2:5223:0:b0:448:5100:e427 with SMTP id
 i3-20020ac25223000000b004485100e427mr15308996lfl.87.1648846169999; Fri, 01
 Apr 2022 13:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220401201916.1487500-1-samitolvanen@google.com>
In-Reply-To: <20220401201916.1487500-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 1 Apr 2022 13:49:18 -0700
Message-ID: <CAKwvOdmHarC+O71PPJwUSnP4oZjknD0FHPZ5b9JbMJ-xOgwMwg@mail.gmail.com>
Subject: Re: [PATCH 0/3] cfi: Use __builtin_function_start
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>,
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

On Fri, Apr 1, 2022 at 1:19 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Clang 14 introduced the __builtin_function_start intrinsic, which
> makes it possible to cleanly implement the function_nocfi() macro in a
> way that also works with static initializers. Add a default
> function_nocfi() implementation and drop the arm64 inline assembly
> version.

For the series
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I wouldn't mind if patch 1/3 included a link to the llvm commit in the
commit message.

Link: https://github.com/llvm/llvm-project/commit/ec2e26eaf63558934f5b73a6e530edc453cf9508
Link: https://github.com/ClangBuiltLinux/linux/issues/1353

>
> Sami Tolvanen (3):
>   kbuild: Change CFI_CLANG to depend on __builtin_function_start
>   linux/compiler-clang.h: define function_nocfi
>   arm64: Drop the inline assembly implementation of function_nocfi
>
>  arch/Kconfig                      |  5 +----
>  arch/arm64/include/asm/compiler.h | 16 ----------------
>  include/linux/compiler-clang.h    | 10 ++++++++++
>  init/Kconfig                      |  3 +++
>  4 files changed, 14 insertions(+), 20 deletions(-)
>
> --
> 2.35.0
>


-- 
Thanks,
~Nick Desaulniers
