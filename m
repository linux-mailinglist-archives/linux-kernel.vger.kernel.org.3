Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B31F50E824
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiDYS14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244406AbiDYS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:27:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBE1112466
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:24:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x33so27731960lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+Bm1DAFY3a8c577iEDG2hIjq68c814xK3d9uMwZmUM=;
        b=YhgUKDTxWXPeGRi2+kquXswG35aUOTl/8oXm32nfH4U/Ixt2ZBAnHY0/swZ7jBoPol
         sESc2sUaZk2B0yfa7VPQFAy3bJK7bM/mNma/RGSoqH68b7vWFTTPl2m8TOmkRAG2gkhD
         jOuwFtQMVi+5h1WGEhRlen6K3pIR104qz8ZZkltxPfF0e6SsLNP9fC0jiG6wsOUTjwm8
         uc7uAVbtUz4gd9Gr/dLx28JBzsBUf0319BUy7ZoIK4KQSE3n6njN/1/VxGwTOkVXEfV8
         zm7DPKEiPVIDsLiPm98mqddIB7E0wRs2Y+zcBxclJxxXiOAGj0s9ncPQd6ksDt4F3Ih+
         H7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+Bm1DAFY3a8c577iEDG2hIjq68c814xK3d9uMwZmUM=;
        b=Fcj0M3iCcmLfYaCVtlnwO6qAonRE4HvuQaP71pedkPTUn7ol43bcUAikeRXsCeD3Vv
         HMgKZ8y5FXq8yXvvHp1/jeWxnjd/WscW36hcVI0c9EkyjSSaHpovKDXy1L82Z06B0AfC
         E2VhufmYMaoGf04PKzuQ3OWXjgWgmZ15kUbwVF+ryVfzMJQEyNrixb8YML/CVoZFpsjc
         ARNG+UADNZu2eIPQ8OT/HL0KUGGfrTkoMOx+CSCRrYRrCPAIdyoHE+R/E1Z8MP6BQY26
         SGW9iSfMK3W0IsmVNwM/d8elT1cR4EiwPNm3mPSCb/tZA9zT2wOdx4WFx3i9WUbmjOHw
         FiNQ==
X-Gm-Message-State: AOAM531LwIOYGrIm7UnJRHXOp5VRwGaOHu+hG6jBgC6ppdGC5NXJFt65
        syc8tdDSNkSqsJXD85IN8Eg1TE1LyK7z4/JDO095Ob3v7QY=
X-Google-Smtp-Source: ABdhPJxOcDZUVTz/YHvMTfvHtM7X3O1aySJYZAE8sk2pPu5R2svDimItoW/LQNuuJT2Yz0RxxEoyyr5plEP2rzhchdQ=
X-Received: by 2002:ac2:4188:0:b0:471:96f4:c1d4 with SMTP id
 z8-20020ac24188000000b0047196f4c1d4mr14006334lfh.626.1650911079102; Mon, 25
 Apr 2022 11:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <20220424190811.1678416-6-masahiroy@kernel.org>
In-Reply-To: <20220424190811.1678416-6-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Apr 2022 11:24:27 -0700
Message-ID: <CAKwvOdm=m7uZC5p52RZTBQ7NpaRS+s_wBtC6K0M1CzQyOUjadA@mail.gmail.com>
Subject: Re: [PATCH 05/27] modpost: retrieve the module dependency and CRCs in check_exports()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
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

On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Do not repeat the similar code.
>
> It is simpler to do this in check_exports() instead of add_versions().

The 2 loops have been fused into 1. :)
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 969a081dba62..f9cbb6b6b7a5 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2159,6 +2159,11 @@ static void check_exports(struct module *mod)
>                               s->name, mod->name);
>                         continue;
>                 }
> +
> +               s->module = exp->module;
> +               s->crc_valid = exp->crc_valid;
> +               s->crc = exp->crc;
> +
>                 basename = strrchr(mod->name, '/');
>                 if (basename)
>                         basename++;
> @@ -2251,16 +2256,7 @@ static void add_staging_flag(struct buffer *b, const char *name)
>   **/
>  static void add_versions(struct buffer *b, struct module *mod)
>  {
> -       struct symbol *s, *exp;
> -
> -       for (s = mod->unres; s; s = s->next) {
> -               exp = find_symbol(s->name);
> -               if (!exp || exp->module == mod)
> -                       continue;
> -               s->module = exp->module;
> -               s->crc_valid = exp->crc_valid;
> -               s->crc = exp->crc;
> -       }
> +       struct symbol *s;
>
>         if (!modversions)
>                 return;
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
