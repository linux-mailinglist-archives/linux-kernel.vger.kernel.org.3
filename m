Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E753EF68
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiFFURA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiFFUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:16:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A1D6FD13
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:16:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h23so25063424lfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvgkNt5AvonmRpEaW+kJLiTrofK1h4p2ZLrrpF3hb6g=;
        b=WhNfhPUvNR4xNPpmPIjOZ33SDP8SNm1f2V4XQziGGsbFEtvGuEO+7kncu8CVybQwni
         AMLGCqzs7wPsZyXipxxAwpUY/yl7XxFEL5XoitJLAncOtiDSdLJcHhE7FP/KDQSZlSXj
         OkM0v+9UL4+z1yVDJoDbPydh4/vFaFxnleL43I4CVAl376fOD4K5ZhSspoxP6eRFVdKe
         LPgZ1RzYk3AVRNPr7YLg2V8pT0sq/EHnrM4pbKL3A5EuWKJ+wRM+VYPPREfAXnoB163b
         zBORHrb5Xncjv7rqstJhMH5ZcWINBCWncuVyK6oUlgMkBcBfmSU2cgqZ0I+bgQN5XY1e
         K1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvgkNt5AvonmRpEaW+kJLiTrofK1h4p2ZLrrpF3hb6g=;
        b=1AV+gEWCbRxAB9sQexY70dlbDr5xYFDGqnfjcgw1D+afAbfJZtBezMImsKmE9z/xTz
         NEW4EPyEWINoTE6nB06m/rZnfK3dH+zw1S/72Izz61SW6id900zSpZ9zrE0LJO4/xFHr
         5J4Mic9zM1rT0Vc/hH6zt1ZsrGTlOx8GIvTiPOvZtyguoBgjEZx4ijVqPGm+sHvBup+Q
         7x8l//yuIAZ+IRswpUbI2os+1xgYKKwBuFgAWfjAqdU3FRGR0Z8DmKRckGAt5sINMcj7
         Cb7xcEaQtoDfQKSZMFfIwFhNV9xWxSGElaoIirqi2pRKQIzUfJWO4l7r+8X++T/8cweZ
         ctRA==
X-Gm-Message-State: AOAM530H5QJcaDGblViTRlEgP6labKhP+lwWLwY6CyeZsDtPd+9eSXfl
        w3rgvmUXb0xtQMg4954o/75Vh2I2K+CTWciPZIdybRlzkE4=
X-Google-Smtp-Source: ABdhPJxTNHkrcmgcUtB/9S/c69fhktonAVfFFFI0WZphFUluFaXX3OOVp1GevheJd7U/W/TTo4Fmhkm5paB4lEM0+lw=
X-Received: by 2002:a05:6512:3f1a:b0:477:8ecd:368c with SMTP id
 y26-20020a0565123f1a00b004778ecd368cmr64495550lfa.403.1654546594123; Mon, 06
 Jun 2022 13:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220530090139.3030866-1-masahiroy@kernel.org> <20220530090139.3030866-2-masahiroy@kernel.org>
In-Reply-To: <20220530090139.3030866-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Jun 2022 13:16:22 -0700
Message-ID: <CAKwvOdn4hf1PHsj6MdN1ZeYSpBBBK=EixCSwn88bnPvhY_F0WA@mail.gmail.com>
Subject: Re: [PATCH 2/2] modpost: use fnmatch() to simplify match()
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

On Mon, May 30, 2022 at 2:03 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Replace the own implementation for wildcard (glob) matching with
> a function call to the library function, fnmatch().
>
> Also, change the return type to 'bool'.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 74 ++++++++-----------------------------------
>  1 file changed, 13 insertions(+), 61 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index c1558bacf717..29d5a841e215 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -13,6 +13,7 @@
>
>  #define _GNU_SOURCE
>  #include <elf.h>
> +#include <fnmatch.h>
>  #include <stdio.h>
>  #include <ctype.h>
>  #include <string.h>
> @@ -710,29 +711,6 @@ static char *get_modinfo(struct elf_info *info, const char *tag)
>         return get_next_modinfo(info, tag, NULL);
>  }
>
> -/**
> - * Test if string s ends in string sub
> - * return 0 if match
> - **/
> -static int strrcmp(const char *s, const char *sub)
> -{
> -       int slen, sublen;
> -
> -       if (!s || !sub)
> -               return 1;
> -
> -       slen = strlen(s);
> -       sublen = strlen(sub);
> -
> -       if ((slen == 0) || (sublen == 0))
> -               return 1;
> -
> -       if (sublen > slen)
> -               return 1;
> -
> -       return memcmp(s + slen - sublen, sub, sublen);
> -}
> -
>  static const char *sym_name(struct elf_info *elf, Elf_Sym *sym)
>  {
>         if (sym)
> @@ -741,48 +719,22 @@ static const char *sym_name(struct elf_info *elf, Elf_Sym *sym)
>                 return "(unknown)";
>  }
>
> -/* The pattern is an array of simple patterns.
> - * "foo" will match an exact string equal to "foo"
> - * "*foo" will match a string that ends with "foo"
> - * "foo*" will match a string that begins with "foo"
> - * "*foo*" will match a string that contains "foo"
> +/*
> + * Check whether the 'string' argument matches one of the 'patterns',
> + * an array of shell wildcard patterns (glob).
> + *
> + * Return true is there is a match.
>   */
> -static int match(const char *sym, const char * const pat[])
> +static bool match(const char *string, const char *const patterns[])
>  {
> -       const char *p;
> -       while (*pat) {
> -               const char *endp;
> -
> -               p = *pat++;
> -               endp = p + strlen(p) - 1;
> +       const char *pattern;
>
> -               /* "*foo*" */
> -               if (*p == '*' && *endp == '*') {
> -                       char *bare = NOFAIL(strndup(p + 1, strlen(p) - 2));
> -                       char *here = strstr(sym, bare);
> -
> -                       free(bare);
> -                       if (here != NULL)
> -                               return 1;
> -               }
> -               /* "*foo" */
> -               else if (*p == '*') {
> -                       if (strrcmp(sym, p + 1) == 0)
> -                               return 1;
> -               }
> -               /* "foo*" */
> -               else if (*endp == '*') {
> -                       if (strncmp(sym, p, strlen(p) - 1) == 0)
> -                               return 1;
> -               }
> -               /* no wildcards */
> -               else {
> -                       if (strcmp(p, sym) == 0)
> -                               return 1;
> -               }
> +       while ((pattern = *patterns++)) {
> +               if (!fnmatch(pattern, string, 0))
> +                       return true;
>         }
> -       /* no match */
> -       return 0;
> +
> +       return false;
>  }
>
>  /* sections that we do not want to do full section mismatch check on */
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
