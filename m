Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956A054067E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348261AbiFGRgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346757AbiFGR2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:28:38 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157B115CA2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:24:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c30so3403198ljr.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGXDbLLtqPgbZ/3WaqTn0w4G97KhWPUzyJUyHiAl65c=;
        b=fXcRlI2bJl9PYMBbbXYz5hPVac9Q75B5BigJvoztYYM/pVGzLkBAOAilWRze4d2fcW
         rFJNGasK2WrVTwzztCCogHov0MUhSjZOalC1T3G/O40MKOiJpHmp2kL4C+8U1FeabOFK
         2sMuoLNSnITfk1n8NZpfORm0Lmgl8pG8furTP91T9b+w5xow9FxFbueWE6KOeeA+Onb7
         RRBfeaUQ6e3NR2lT8g4nQEMkRn9uGcqMpRgKcv9Ai6wZQ+OqTgDkPvwrEKXOqMTZJaZn
         a6D4k2GdYxEoTIs2uJERv1QWHVkYumcq9CU1sqa8TWf7bqaCHMHc9v8vCdJQxCkrXqr6
         E2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGXDbLLtqPgbZ/3WaqTn0w4G97KhWPUzyJUyHiAl65c=;
        b=5Wo/aOARm3TBATgcJBrViKntLEybxgopkforQ3VQeQ3Z2RH14/KeMVKWkTTjJ/Ch7C
         CEY2H2LFTaIoq8xXdw+wmkc2q+0ZUHqO2xujLbmBJriOjxiaqgxQOp7b/LPLikheidcJ
         aPZwzdrpRpNXFYVkb6zG0ud7SsisIsPJeQYhZ0C+HPYZ6Ya79Ob6vwo5GyVbNoyM09Nr
         vvp9coCULlGzknx2sjG0mQEm8MiuHit3C29oIV6Jfi4Yl0m7z7NkXPaouYG87eIpOCyU
         iRXE5MqAcc6PvauuioDP3UU0PosqcDeV0ClD3AZ7AmpGCVSBPu/+iJ8Zht8aqLsC6V6Z
         J6lw==
X-Gm-Message-State: AOAM531KPcnDpsQYVzMkfcayexg5so5DHBMm7YXm9Ssml1rcxKiXIMeY
        IVW9B6PIYiRCq7PE6y/3zBZztlHb2MXpmAJa9X9a0Q==
X-Google-Smtp-Source: ABdhPJzZdGRm7zcejXzLCc1zvFixbWQgiEqigChk9f/02vn2hn+b1/g4LqMUsjcR0t4jXmGw+tReeOy+II+7fLstzEg=
X-Received: by 2002:a2e:8715:0:b0:255:a7e5:d50d with SMTP id
 m21-20020a2e8715000000b00255a7e5d50dmr3573997lji.26.1654622671928; Tue, 07
 Jun 2022 10:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220607164000.447941-1-masahiroy@kernel.org>
In-Reply-To: <20220607164000.447941-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Jun 2022 10:24:20 -0700
Message-ID: <CAKwvOdk5ZrcSmQSPrFzreZ-z_Hpi4Lc-D-Y4NDuHPiUWpXdwzA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/check-local-export: avoid 'wait $!' for
 process substitution
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 9:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Bash>=4.4 supports 'wait $!' to check the exit status of a process
> substitution, but some people using older bash versions reported an
> error like this:
>
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Tested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

Some comments below.

> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 34415ae1af1b..19c286c23786 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -32,6 +32,7 @@ you probably needn't concern yourself with pcmciautils.
>  GNU C                  5.1              gcc --version
>  Clang/LLVM (optional)  11.0.0           clang --version
>  GNU make               3.81             make --version
> +bash                   4.2              bash --version

/usr/bin/env bash
and definitely /bin/bash
both show up a lot in kernel sources. At this point, I think bash is a
requirement at this point, so it's good to document it finally.

> +# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm) shows
> +# 'no symbols' diagnostic (but exits with 0). It is harmless and hidden by
> +# '2>/dev/null'. However, it suppresses real error messages as well. Add a
> +# hand-crafted error message here.
> +#
> +# Use --quiet instead of 2>/dev/null when we upgrade the minimum version of
> +# binutils to 2.37, llvm to 13.0.0.

Might be nice to include `TODO:` in the comment block. Vim will
highlight these in comments.

-- 
Thanks,
~Nick Desaulniers
