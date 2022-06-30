Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852D0562023
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiF3QT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiF3QTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:19:55 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8344C2E9D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:19:54 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id d5so34638239yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siGKi/dIfvfe8+iskQhGtDTJS7NXa0bDAndCilNFqRU=;
        b=PY172wygPNzbXx/MtlL0kVYhRqHP/PMSgMPKfMe5d3bzaiPOFgDA24BfmJk1n+zPMX
         fc/bD2b+O9jTkZx6hTCu9mc5JivMe1meY8jOCRsG//k9b88HjGzDX8h8Y69vjuHcXDCy
         xOoQL6P5l7QZgCNx+04KtnwvzbIl2DoRn3J24x5aHkRHyB1J6Dz3f/03FXjJ2oV40NI3
         h+LLWTCGpXw7DUWpa9ZIxtFe99Y48TMHMZfWnjuIh7rvMkm1AdEkL4gjOPQE4a0SFeZd
         i5/7o/AYKlRkjlV+w7+lMcU1gD2PdeXYLEPIxdLD1dPp9eAwQRuekkzRPpPNu8Pt+g4m
         Fj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siGKi/dIfvfe8+iskQhGtDTJS7NXa0bDAndCilNFqRU=;
        b=YiogEZGu0f+A4YYikaGqy2g1gPfdwZW2OoHHHPuF/YsQwfmuHaB/62r+yAsiRV3lID
         riM07ueMQSDpps7aM75/lGvjgqe+iw7C4XzrUUI0v/aKS4QZkrE2yVAkdGNxM5bP0T1W
         l9ZgUEeSNXKQb3oSO6JXBqp5MpiR/dfhwIZIg4TxO/1Eqv66M6xZ/YYT9vKrNABWlude
         +XjP+7nXULnqT57qHaaM7RlkOQsyvSfIXpGKPO4Rir92O0pd3FXxsQ9Fc/+E6f0OeD5I
         xddnzMvflI5JC2NO5mTktLpbOtPBTQzYh7k9feOpKJE9sYug1juazs+ro2KdYPxzSy1T
         whYw==
X-Gm-Message-State: AJIora+sG6XllTRGeUdU5QMkbGPE0p7u3XtZD0onNyzdAenQzCt8gd5l
        TDuRhp0JHMLCRDlgWUwZVI3Naxa0iqlkG4xIlYdDhg==
X-Google-Smtp-Source: AGRyM1u8XSsovv5uNzas0O9wEpepGNCy07fQqznwcLEuYGbRz6VCy/lpNKM9Tcq6oR2CJ4QgsTgK4lCOy2Z0yZIqcoU=
X-Received: by 2002:a25:c646:0:b0:669:b341:a595 with SMTP id
 k67-20020a25c646000000b00669b341a595mr10978550ybf.304.1656605993493; Thu, 30
 Jun 2022 09:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220630094646.91837-1-haibo.li@mediatek.com> <20220630094646.91837-2-haibo.li@mediatek.com>
In-Reply-To: <20220630094646.91837-2-haibo.li@mediatek.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 30 Jun 2022 09:19:17 -0700
Message-ID: <CABCJKucgdTqDFyTumSCBHiyRVWgvJEhR2Fn=MxyMpTjWtvCV=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ANDROID: cfi: enable sanitize for cfi.c
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     xiaoming.yu@mediatek.com, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Aaron Tomlin <atomlin@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
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

On Thu, Jun 30, 2022 at 2:47 AM Haibo Li <haibo.li@mediatek.com> wrote:
>
> currenly,cfi.c is excluded from cfi sanitize because of cfi handler.
> The side effect is that we can not transfer function pointer to
> other files which enable cfi sanitize.
>
> Enable cfi sanitize for cfi.c and bypass cfi check for __cfi_slowpath_diag
>
> Signed-off-by: Haibo Li <haibo.li@mediatek.com>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  kernel/Makefile | 3 ---
>  kernel/cfi.c    | 8 +++++++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index a7e1f49ab2b3..a997bef1a200 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -40,9 +40,6 @@ KCSAN_SANITIZE_kcov.o := n
>  UBSAN_SANITIZE_kcov.o := n
>  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
>
> -# Don't instrument error handlers
> -CFLAGS_REMOVE_cfi.o := $(CC_FLAGS_CFI)
> -
>  obj-y += sched/
>  obj-y += locking/
>  obj-y += power/
> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index 08102d19ec15..456771c8e454 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -311,7 +311,7 @@ static inline cfi_check_fn find_check_fn(unsigned long ptr)
>         return fn;
>  }
>
> -void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
> +static inline void __nocfi _run_cfi_check(u64 id, void *ptr, void *diag)
>  {
>         cfi_check_fn fn = find_check_fn((unsigned long)ptr);
>
> @@ -320,6 +320,12 @@ void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
>         else /* Don't allow unchecked modules */
>                 handle_cfi_failure(ptr);
>  }
> +
> +void __cfi_slowpath_diag(u64 id, void *ptr, void *diag)
> +{
> +       /*run cfi check without cfi sanitize to avoid calling cfi handler recursively*/
> +       _run_cfi_check(id, ptr, diag);
> +}
>  EXPORT_SYMBOL(__cfi_slowpath_diag);

You can just add __nocfi to __cfi_slowpath_diag, right? There's no
need for the separate function.

Sami
