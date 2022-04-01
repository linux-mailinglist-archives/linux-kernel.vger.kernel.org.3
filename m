Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B04EF96E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347853AbiDASBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346539AbiDASBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:01:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6A36440
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:59:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v12so4936833ljd.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVo2yneeaoxV8R6Z7eFrjSGIjEuANhXKz6InNmADjE4=;
        b=VGVRglkQ5qT4QrFHTstzXLRNvKIXaFc/bd4yzqo+pIEHf/eHKnIB9w4H/LXNbkJgoi
         07dUE722eMqQPOTQz5VtHjFY4MwJEeQpXLP1cH+bPNKnIJ1wS69+6xZB5jlhq7T9ex8K
         C92uUGXEqPBNFrHhCfgEe/wnGQjH7eqVizKBxwOeW2xNEMV1/HnyClk7uxDwRjre2+2u
         OeRWnfIATizFCQmWuUwDf+090/sQv9OT0MQFhF+M+6mMQ8/jZlC2Bna3mKdQnrSNXrGH
         wFXSkgUYzcHtYdldWljBvbwgz0q96wDMuaAId8QiyjgvR6puPJLuaEAjji9l5sN+N/vl
         ePgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVo2yneeaoxV8R6Z7eFrjSGIjEuANhXKz6InNmADjE4=;
        b=m/8q2TqVOS5eam5GVwXcwJN7KeFMcAjerdR3dLXEetSsWt49FNZZeTlvXqdyEwYMvb
         fMfl8yMek9X2RC0x0BoKE+a443j4qib104mV/Vo/fduN6qRJ02xVfin8R3h6JpBwEdWK
         mCpT5rmHpwIzNjj+QJc03QPw5ZdBK2A/hnowTuMzmsebHXxIwX2h/59qKiWa7caUbtf6
         dXLwzgnbcY/OWyzQHXPh4l+9wY9CumdDRv9jyAL30Uh98ZJ6LV60/p0VztqiGoND7mlh
         OnElBff4SKxupQ19fn5dbjEqXr0Aypdb74V5mrRXCYQxJ/UwPJDXSAlJMg5NN3pNolZU
         sLrQ==
X-Gm-Message-State: AOAM532Z1sv74qQxZqIYFdQkjLOny/Tr4OSPileoBeLfGLJOvDLIqwCy
        M9EFrRxtuW5V5mk/MO7PBEmblbN9qJ9FabM64dHE51WWhI84cA==
X-Google-Smtp-Source: ABdhPJz52xEbRMdX+J6RoF1PxIaVh4m7s0dsr5oimFatM/w31uwQdcfsTkc+f2SlEfD8uh7GODGMndZxkW2SY+pQS/k=
X-Received: by 2002:a05:651c:19a8:b0:249:a7f3:25e7 with SMTP id
 bx40-20020a05651c19a800b00249a7f325e7mr13589488ljb.352.1648835977151; Fri, 01
 Apr 2022 10:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220401155610.1280262-1-masahiroy@kernel.org>
In-Reply-To: <20220401155610.1280262-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 1 Apr 2022 10:59:25 -0700
Message-ID: <CAKwvOdnwSnoiP3Vnf-77VGeD6nKc7gLa-nc-ipoCsRBk2m3ueQ@mail.gmail.com>
Subject: Re: [PATCH] modpost: restore the warning message for missing symbol versions
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
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

On Fri, Apr 1, 2022 at 8:56 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This log message was accidentally chopped off.
>
> I was wondering why this happened, but checking the ML log, Mark
> precisely followed my suggestion [1].
>
> I just used "..." because I was too lazy to type the sentence fully.
> Sorry for the confusion.
>
> [1]: https://lore.kernel.org/all/CAK7LNAR6bXXk9-ZzZYpTqzFqdYbQsZHmiWspu27rtsFxvfRuVA@mail.gmail.com/
>
> Fixes: 4a6795933a89 ("kbuild: modpost: Explicitly warn about unprototyped symbols")
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index d10f93aac1c8..ed9d056d2108 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -674,7 +674,7 @@ static void handle_modversion(const struct module *mod,
>         unsigned int crc;
>
>         if (sym->st_shndx == SHN_UNDEF) {
> -               warn("EXPORT symbol \"%s\" [%s%s] version ...\n"
> +               warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n"
>                      "Is \"%s\" prototyped in <asm/asm-prototypes.h>?\n",
>                      symname, mod->name, mod->is_vmlinux ? "" : ".ko",
>                      symname);
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
