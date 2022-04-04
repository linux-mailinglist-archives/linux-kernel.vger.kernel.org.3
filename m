Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4E74F1AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379343AbiDDVTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379404AbiDDRGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:06:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C0C40A22
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:04:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p15so18487876lfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J334O5uYapL/nSov6BZAzFIp7kzwsiEjIccb8+5N22c=;
        b=f07uA2nRdSeYaV6J0y8FPL4bPtqDnXuBCANsO8bx0j7F5mJV3d8FyIxuXDZ9mY5LHa
         GoDjtp8ZFIHxrYd+1KbhjEWgk6q38scATXBkxvTL5bimRO/FxE7oFoKFaFK5u1UPQjhh
         yEM/yzy4sxr3ObXCNh3tJOi5lsE6MzpZKvwQ1xVizV3wq1ht6lmCPkB336REFQ2Da/8i
         uAoPQcV5M7F2YHxdHjtPSeiYJBFRtF8s3C/Hk27Qb+29HmpBV0Cj8mXRMJnMoHGZmClv
         rJJSSIdGGvoR7Lz/ratpwdJS1KfBOdXQfV3LiCnu9zg8jpoJMcCfwSKIEUJWD8/vEuqq
         NP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J334O5uYapL/nSov6BZAzFIp7kzwsiEjIccb8+5N22c=;
        b=4GOnkExjl7j2S+UGqPtJWyFp1XWes68oSJ6cJrLuS3iz5dfBpy6JLLly7FCH4ZqSel
         U3grYCygAiAyX2xGesIACKYFmmf+5JL1uZgQPgx70E6jMKcRADGcyt9uBy6sCepbzklu
         bw1woH3jNL5RJstOPYwOArOgspkylgbmX1OEgmxKGLppRwUthT80rIar4lz++gzF6gBt
         +mmpGpgP/y2XIMf/LK77MxfRp/uk3mhZ7RnYxMUslAAY9Q7dHDeQX8dlQ2qtiVCIWE+I
         cYkz8qtIWTXXEAiyrNgORXnxsnbpTmy52e2CNBGGaetAEPcbWGwLCh4LHxYIbyvEusox
         +6DA==
X-Gm-Message-State: AOAM533yPBnpcssOFwBD0R/sUZIghPj4dUPbew+fcR+iw6Rv7AWKJZ1a
        0SK11Mqp4aCc+ptAviwXjmZNdg+Hl8oT9qpoHCDk6Wmyqc88FQ==
X-Google-Smtp-Source: ABdhPJxSX/N/OBaPWataxe8f7C/8UA4YyOws9Udkg9tB+MjsWXVgKMGfJd5zUxPlMjvU6XV3jv/PVlgrCvTkFoyV5Jc=
X-Received: by 2002:a05:6512:3092:b0:44a:e7bb:e961 with SMTP id
 z18-20020a056512309200b0044ae7bbe961mr314645lfd.190.1649091843129; Mon, 04
 Apr 2022 10:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220402130014.1417773-1-masahiroy@kernel.org> <20220402130014.1417773-2-masahiroy@kernel.org>
In-Reply-To: <20220402130014.1417773-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Apr 2022 10:03:51 -0700
Message-ID: <CAKwvOd=r4JQ0p1xRix934oTaF-7zQJiaNo7Er7ExH0_R3AnmZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] modpost: move export_from_secname() call to more
 relevant place
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
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

On Sat, Apr 2, 2022 at 6:00 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The value returned by export_from_secname() is only used by
> sym_add_exported().
>
> Move export_from_secname() just above sym_add_exported().
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 194ca9083c7a..f9e54247ae1d 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -684,12 +684,8 @@ static void handle_modversion(const struct module *mod,
>  static void handle_symbol(struct module *mod, struct elf_info *info,
>                           const Elf_Sym *sym, const char *symname)
>  {
> -       enum export export;
>         const char *name;
>
> -       if (strstarts(symname, "__ksymtab"))
> -               export = export_from_secname(info, get_secindex(info, sym));
> -
>         switch (sym->st_shndx) {
>         case SHN_COMMON:
>                 if (strstarts(symname, "__gnu_lto_")) {
> @@ -724,7 +720,11 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
>         default:
>                 /* All exported symbols */
>                 if (strstarts(symname, "__ksymtab_")) {
> +                       enum export export;
> +
>                         name = symname + strlen("__ksymtab_");
> +                       export = export_from_secname(info,
> +                                                    get_secindex(info, sym));
>                         sym_add_exported(name, mod, export);
>                 }
>                 if (strcmp(symname, "init_module") == 0)
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
