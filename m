Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FFD49AE01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450466AbiAYI2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:28:03 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:20300 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376941AbiAYIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:25:58 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 20P8PMwk017766;
        Tue, 25 Jan 2022 17:25:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 20P8PMwk017766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1643099122;
        bh=SXcYTM/qBmgbG6//jXK+Wh8gfPtK3akJ9sIl9wIufX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tyqBYwZC7AUwq59c7mPEA50sH66TwySMKzl1xNzrX2h2nlQqCLrMZYHycVUGDBEKv
         jhlinySD1mLWqwULzjCUdaGkaf5HdRYPc2B+GK+i/Hsk5FSlyCk8C/NiGzSEUgPKNR
         x76uvz70hViES1YF4NdMYGaZ7bmfaxlHdAU+6ZPpSolKEXrFzyB4fuCFUuyRuvK6WU
         jk/Opnb+w1amTb0M7u1bUohB5FNBm0n/RZ400248drcmMbM1liHX2jShdoA/Y3zOb9
         oE6xmEyqKOIAwtlGLEoKrtHr9qazeSLNyOa6E5pyoAKrUbmJ1uordiHKo06+9QQ46k
         xlS3sSk0TepBQ==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id k17so979905plk.0;
        Tue, 25 Jan 2022 00:25:22 -0800 (PST)
X-Gm-Message-State: AOAM531JG80fJ3r5W4I5vEegRT+fpLmdcNAIvwlMAZJ7hGA7m0KDUaq4
        H1k40x4Kr9Jb3cVJfM0hubY8aHIxRair3syjwX4=
X-Google-Smtp-Source: ABdhPJxnq0/zopDDBClwpC1WWbEaUfQvqa+dxOhu1M/cgTm623thDpCkX5xNmcrJJWJV87TY2I+pnoc03tlKyBpghQc=
X-Received: by 2002:a17:902:6a89:b0:149:732e:d335 with SMTP id
 n9-20020a1709026a8900b00149732ed335mr17953179plk.136.1643099121719; Tue, 25
 Jan 2022 00:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20220125075126.891825-1-keescook@chromium.org>
In-Reply-To: <20220125075126.891825-1-keescook@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 25 Jan 2022 17:24:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATxgwygLbrSKPTDEenYRT-ARtVxPqR+ybLOObzXBHHzhw@mail.gmail.com>
Message-ID: <CAK7LNATxgwygLbrSKPTDEenYRT-ARtVxPqR+ybLOObzXBHHzhw@mail.gmail.com>
Subject: Re: [PATCH v3] Kconfig.debug: Make DEBUG_INFO selectable from a choice
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 4:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> Currently it's not possible to enable DEBUG_INFO for an all*config build,
> since it is marked as "depends on !COMPILE_TEST". This generally makes
> sense because a debug build of an all*config target ends up taking much
> longer and the output is much larger. Having this be "default off" makes
> sense. However, there are cases where enabling DEBUG_INFO for such builds
> is useful for doing treewide A/B comparisons of build options, etc.
>
> Make DEBUG_INFO selectable from any of the DWARF version choice options,
> with DEBUG_INFO_NONE being the default for COMPILE_TEST. The mutually
> exclusive relationship between DWARF5 and BTF must be inverted, but the
> result remains the same. Additionally moves DEBUG_KERNEL and DEBUG_MISC
> up to the top of the menu because they were enabling features _above_
> it, making it weird to navigate menuconfig.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20211210000910.3597609-1-keescook@chromium.org
> v2: https://lore.kernel.org/lkml/20220121001204.4023842-1-keescook@chromium.org
> v3: - rebase to v5.17-rc1
> ---


-- 
Best Regards
Masahiro Yamada
