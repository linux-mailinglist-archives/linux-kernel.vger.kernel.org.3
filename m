Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B955332A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbiEXUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbiEXUvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:51:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A93D31354
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:51:32 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w14so32766548lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmogMWNp0qvu2mm31zmFjP6h+axm+XxtnUaHfKWv+xM=;
        b=RR6mv2dpN07ZtLDjgj/gqKwZLXyst5QN24l2SvqPkG15iuStCrKQ41Fl3l85Lg6Tdf
         vo4zP0ogMNAYQkmt5LjmX2wvt9aMXCU9tI7A8BYlyHSJ3w0lGXEts6mPqi2wakkKfsAq
         iBcQfmsq1u/dCBzyJ3eyDOwHDoWMIQbF0qe91RsjQ1jotJ9Klr82gRna/odaaQYjAV7p
         LHIOtPbttOTW9Hcb8kEmiBcBI0HJiKQ+5r18GF5O5uLCzY8rr7PNDf5/Ad1BdnxtkDll
         i3Eh0+X8VOOVyAfZ0SIC2bAZIkMnFNADAzOGmGOhWEJMWh52/l9sNRt4biSBxBs/AxUd
         7UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmogMWNp0qvu2mm31zmFjP6h+axm+XxtnUaHfKWv+xM=;
        b=O9BHVJDmcjqBty5HF4kYG/qQBA/P0siONo0r+slO+sN5lcIAAWTe2cUSgpmLD74y3b
         P/HsFLzv+HN/1shX4RJV4T8XwmoftCF1Go/6mSqmghI8OpAUuOzUOZMwOcJVkpsDlmwG
         qBu6Kdy3ZOP+A70buIz5pQnLzdLsU6HoMTWRGTxbMgICFh8e+3j7UnTTjMCuAun3LKV4
         M4qMgdrDcYFLJRaQ97JhtFE8UMySHAepoJb9X/6KYY4UGexdU83Jbm5SZJei/m3Djyk/
         y6hmxhi+agC08Lhy/yZtWoZxj/zvcgedMSrkqcotxU7ezgGw3EogVuqcLtUrq5Btrc6O
         E65g==
X-Gm-Message-State: AOAM5339sQOE6P0ApY/ZJeBTXRaWj4qbyY/TsR/isAhHG56IFOfzHgwP
        +cZbV3cPSjQPMdnW8tf98lrv8xhgXbLD6jT2IUIx4+yYPW8=
X-Google-Smtp-Source: ABdhPJzleqZnjuGchdQgqqN8WkUodSeI7NY6Jg+gW6AX7R8T4w34/0v35vDm+YNngitG5zX+TsGnV80HTTcpTjrvAUg=
X-Received: by 2002:a05:6512:48e:b0:477:c024:1a1c with SMTP id
 v14-20020a056512048e00b00477c0241a1cmr21489946lfq.100.1653425490353; Tue, 24
 May 2022 13:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220523164626.858340-1-masahiroy@kernel.org> <20220523164626.858340-5-masahiroy@kernel.org>
In-Reply-To: <20220523164626.858340-5-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 May 2022 13:51:19 -0700
Message-ID: <CAKwvOdn00NxJo+_SCHcBx2JO0doZQx9cL0TdFDfQAwMOXDMc8w@mail.gmail.com>
Subject: Re: [PATCH 5/5] modpost: squash if...else if in find_elf_symbol2()
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

On Mon, May 23, 2022 at 9:48 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>     if ((addr - sym->st_value) < distance) {
>             distance = addr - sym->st_value;
>             near = sym;
>     } else if ((addr - sym->st_value) == distance) {
>             near = sym;
>     }
>
> is equivalent to:
>
>     if ((addr - sym->st_value) <= distance) {
>             distance = addr - sym->st_value;
>             near = sym;
>     }
>
> (The else-if part can overwrite 'distance' with the same value).
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Sure, thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 48a18b59f908..8c8d2a4bc0b0 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1270,13 +1270,9 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
>                         continue;
>                 if (!is_valid_name(elf, sym))
>                         continue;
> -               if (sym->st_value <= addr) {
> -                       if ((addr - sym->st_value) < distance) {
> -                               distance = addr - sym->st_value;
> -                               near = sym;
> -                       } else if ((addr - sym->st_value) == distance) {
> -                               near = sym;
> -                       }
> +               if (sym->st_value <= addr && addr - sym->st_value <= distance) {
> +                       distance = addr - sym->st_value;
> +                       near = sym;
>                 }
>         }
>         return near;
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
