Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E41A5190D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiECWAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbiECWAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:00:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D2341F94
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:57:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s27so23690495ljd.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYNCSYzQEXjV7ANQ+gYRAk9M4A9JcODWNhWQSnhodG0=;
        b=ZQEap/fOGdFnCaZLSph51y+I8n6YL6ijpRYS32erFuFJM2ay7sXNpiJQ5fN/hFOEIr
         9NTjxIVpB2MTACZmmge9+z/8GrikSf9oaQnG5aA30+ZZNqLL5tsvWKwT8QnCVHeSitC4
         ZldGkTPsewrnYG7FJvYVynR2uAAyiFyWW5h53a7VXPN8c5xH3Dafb+vRfi1Fo1E4elud
         WcJjZEjm+0XMXX5X/A5/zlsJdG58pOvl5EpLM/BLP04RX33rc+hQ/LnruHyYpVdDwFpx
         2ZEGLxAZrYpinEUIsDVc9v4/wPEhYPu0M53iKpyVnkKg9C53tWdFg/fnLjLZM7ymj1tz
         2xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYNCSYzQEXjV7ANQ+gYRAk9M4A9JcODWNhWQSnhodG0=;
        b=xaYnis6PeRx4xmvT123lSdflI+Ws0+xUdSTV8MRT3YYGRk/kFQY+n5PFiAaIQa65fi
         9NG4M2/sR3xxlv04ZwP0P2ko6pkzGeMy0LTu+xzP9X1m3GkRqI6soPsQWlwkMPT1lj6f
         /nlV7VelO7u2RhTBlue99K7rm6Z1PT2aRtGEFXyIBYGuAEAeje43JuKFyMOhc2aZI5Bd
         Cy/Y8XLBkJefADoIn1ZTsiRO1IlqfVkmuxphT0tXryyL+/D/JXRw/wdT0Y0wAZ08NUd+
         qHKYoE0zIsmnw+hXv9vE0Ft2CtOYgRtp1Ckhy6yT3R9eLOgxgB8p+1PnolrLJ9s3Q4J9
         2Vbw==
X-Gm-Message-State: AOAM5321MLay4Xs/vN71PRDRgaCZU5ASZ1TrniFWmnNGDvZl349auGcH
        TSM7YYuM6LWAKiBtJZAK+CuD0WFQVWEPQ4Tc1pKXcA==
X-Google-Smtp-Source: ABdhPJwI3TzytjNvKh8yN2cfEECQgt2JS+4EpyDOTadY8Qulev4S7kt34QBMMGGeGqgIjLkzOWMoEuJ4WlYlPdhI0Eg=
X-Received: by 2002:a05:651c:552:b0:250:5c23:d0f2 with SMTP id
 q18-20020a05651c055200b002505c23d0f2mr5664571ljp.239.1651615018300; Tue, 03
 May 2022 14:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220501084032.1025918-1-masahiroy@kernel.org> <20220501084032.1025918-13-masahiroy@kernel.org>
In-Reply-To: <20220501084032.1025918-13-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 May 2022 14:56:47 -0700
Message-ID: <CAKwvOdn7qKKXj61htkJVDOE-ZSx4CcWpqjfquiCSVT1=R0xMGA@mail.gmail.com>
Subject: Re: [PATCH v2 12/26] modpost: make sym_add_exported() always allocate
 a new symbol
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
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

On Sun, May 1, 2022 at 1:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Currently, sym_add_exported() does not allocate a symbol if the same
> name symbol already exists in the hash table.
>
> This does not reflect the real use cases. You can let an external
> module override the in-tree one. In this case, the external module
> will export the same name symbols as the in-tree one. However,
> modpost simply ignores those symbols, then Module.symvers for the
> external module loses its symbols.
>
> sym_add_exported() should allocate a new symbol.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> (no changes since v1)
>
>  scripts/mod/modpost.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 1f01fc942f94..c9b75697d0fc 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -412,19 +412,17 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
>  {
>         struct symbol *s = find_symbol(name);
>
> -       if (!s) {
> -               s = new_symbol(name, mod, export);
> -               list_add_tail(&s->list, &mod->exported_symbols);
> -       } else if (!external_module || s->module->is_vmlinux ||
> -                  s->module == mod) {
> +       if (s && (!external_module || s->module->is_vmlinux || s->module == mod)) {
>                 error("%s: '%s' exported twice. Previous export was in %s%s\n",
>                       mod->name, name, s->module->name,
>                       s->module->is_vmlinux ? "" : ".ko");
> -               return s;
>         }
>
> +       s = new_symbol(name, mod, export);
>         s->module = mod;
>         s->export    = export;
> +       list_add_tail(&s->list, &mod->exported_symbols);
> +
>         return s;
>  }
>
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
