Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0F588159
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiHBRux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHBRus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:50:48 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1C5F8C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:50:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z4so1763158ljn.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xdy7hWwptYMJy32CiaLwvAQbz8oNM1G9eZE8H1Il2oY=;
        b=CGwnOqBC+bjVuuqljzZFhjGYoj4lHLYyCUnrDtGSSqJucGri6nZoc/hBXxxFf1weV7
         V4oal4+Max/oDV/0+y8aGt1jat7tkecMaC95ZpF+X/OBbV1m2/PcmjbkfjrQnCmmsH+H
         wgNG5l+3bQJcguuLMDZEL9eWW23Vq4GcNLbXFczCWoMVIJBTEJVhLjiZ4dLmrQEbR81m
         5pmTLa0mGQvFa4Q1wo7shcUKT8FGLhq/FQ9wQzgt4EKk9ZA4GAC7hY5Gt0eSkIVhsYdL
         NNbDdEIHdPs+PH1DAwL3qzMSZVnj5NfxICUvnRq7x8zoPlvwcNUBjhtdgkZBv4KUD8YP
         ygUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xdy7hWwptYMJy32CiaLwvAQbz8oNM1G9eZE8H1Il2oY=;
        b=g3fEEWgJGQ4NvRajhS22ClFiCs406Udpqu+FE93F/sg2mhjSl7W/HWPa8/SlHVxvyx
         smp9uFA+hykSUIKyWGO9iWuG4so3wSVgLafS/KR6RiO29QyU07AMLC0JgmeXVX4CtGzh
         8VEvpRgKj2qNm/Xd2u7wizRw8ddZECVx/Bf7m87F8muhllhSOYqftSXWc40+VBvvbJWe
         AnCkF4EupjLCFsNBArT7Kn60r16Kh2vWl+rqzfJq0wWbAfdOl8J/AfT2uVsj46efkgwy
         XrjaPpbylAghVwdGZAD87bi9C7zNp0RapeCHuu7f4RKJPOueap9SISv0lsGC4ZwvoueW
         aJHQ==
X-Gm-Message-State: ACgBeo0DAW3Bluisf7mGDFa4I+mIkehykLSGExhpVytm2U+bx6SXUBxA
        zz4qLF8imiGyYdTVDnwz4R5spe4pkLaOpawT+xuhRg==
X-Google-Smtp-Source: AA6agR4YwbemLLnQOTtoivWc2JzeSJXcJqlpsoikkvB0iGAZPbYKpfBqi1u5j2VaWEn/Rh9iqR8Q4kcjsdpzDL4rzbI=
X-Received: by 2002:a2e:be10:0:b0:25e:55bb:7296 with SMTP id
 z16-20020a2ebe10000000b0025e55bb7296mr2622841ljq.400.1659462645710; Tue, 02
 Aug 2022 10:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180748.4101236-1-masahiroy@kernel.org>
In-Reply-To: <20220726180748.4101236-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Aug 2022 10:50:34 -0700
Message-ID: <CAKwvOdkMzzG_a3BHociq23JeyyOAawgPTUm3UAzx2BzZOh2z-g@mail.gmail.com>
Subject: Re: [PATCH] modpost: refactor get_secindex()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 11:08 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> SPECIAL() is only used in get_secindex(). Squash it.
>
> Make the code more readable with more comments.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.h | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index bd874f906781..33b376d9ba71 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -156,22 +156,28 @@ static inline int is_shndx_special(unsigned int i)
>         return i != SHN_XINDEX && i >= SHN_LORESERVE && i <= SHN_HIRESERVE;
>  }
>
> -/*
> - * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
> - * the way to -256..-1, to avoid conflicting with real section
> - * indices.
> - */
> -#define SPECIAL(i) ((i) - (SHN_HIRESERVE + 1))
> -
>  /* Accessor for sym->st_shndx, hides ugliness of "64k sections" */
>  static inline unsigned int get_secindex(const struct elf_info *info,
>                                         const Elf_Sym *sym)
>  {
> -       if (is_shndx_special(sym->st_shndx))
> -               return SPECIAL(sym->st_shndx);
> -       if (sym->st_shndx != SHN_XINDEX)
> -               return sym->st_shndx;
> -       return info->symtab_shndx_start[sym - info->symtab_start];
> +       unsigned int index = sym->st_shndx;

I think `Elf_Section` would be preferable to `unsigned int` for the
type of `index`?

> +
> +       /*
> +        * Elf{32,64}_Sym::st_shndx is 2 byte. Big section numbers are available

Then I'd update the comment, too, to mention `Elf_Section` rather than
`Elf{32,64}_Sym::st_shndx`.

> +        * in the .symtab_shndx section.
> +        */
> +       if (index == SHN_XINDEX)
> +               return info->symtab_shndx_start[sym - info->symtab_start];
> +
> +       /*
> +        * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
> +        * the way to UINT_MAX-255..UINT_MAX, to avoid conflicting with real
> +        * section indices.
> +        */
> +       if (index >= SHN_LORESERVE)

^ should this also check that `index <= SHN_HIRESERVE`?  Perhaps just
call is_shndx_special() like the code did before?

Or SHN_HIRESERVE is #defined in include/uapi/linux/elf.h to 0xffff and
SHN_XINDEX is ... not defined in kernel sources (what?! perhaps
<elf.h>?)...but should have the same value of 0xffff according to
https://docs.oracle.com/cd/E19683-01/817-3677/chapter6-94076/index.html

I guess this is fine then, but I would prefer not open coding types
when dealing with ELF. (i.e. my first suggestion in this thread).

> +               return index - SHN_HIRESERVE - 1;
> +
> +       return index;
>  }
>
>  /* file2alias.c */
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
