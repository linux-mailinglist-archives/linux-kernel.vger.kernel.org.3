Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6552D50E86F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbiDYSoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiDYSoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:44:19 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147729FEB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:41:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 17so18996547lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29vIgpHiMOT/QpCjFKyRzAyZ0bZDOTDhP1A0AtWid/Y=;
        b=CE4MeQJtaQKXHSTUH4lVceaOQWzd2LYTzFdGFke7eiMWUtnF1/YUhzARcQKJwO890h
         0JjYjVXo3IA6jOL4JeXtr4RoRAOB3Aenb8yynDIgUrO8QWYAZNLQjdewaz+3b5yU2b9Y
         l91UoPZh+RklZV+8rZCR1jasqZHfzFGfJi0AbNdD1+vauDtcUtAoM+BaIOIWx8/9pvFw
         d1jbu++lX1kcc3xpVmwu0sLHNN3xNUkpGsnQYzyEvbIWIh/YAlUyslhewhBx+Qjuuwvv
         1s1Bix8HgORmWctPGndPjVg13XJhCDGuaLQAU0u7IaaecEJDcAjV+q7/z99/Ur9u236O
         h+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29vIgpHiMOT/QpCjFKyRzAyZ0bZDOTDhP1A0AtWid/Y=;
        b=5bE0PvW3WyK06NOVnr9rL0sGMhqtJ8dJHeTn2O3Ths9CPjQVPscQTGuKxtZXLsoy4J
         viypIc/W052nKemejJbiPurBARWMOaW1c+f9+YHx+hBUXfs13jsCRoKwMow2curtIvbC
         0smIE7hMuYfZIvXlQMmoIK7+6yySHsaYNrcO1cyuL9XIvNIAghq3XZR77+AdO1aKz7y2
         fKLd6jbvN1d3qegiDbcNj7ShhYwYmnXunC2M9TfP25KErawW4PrZJVsNELcT5jLVHZsv
         cjj2vzJBx3Lu6r/taINOgC20n7PD87P4IgCwmrchVGLK764cGIQDnlQWHRCC9vvi+6yR
         0rlA==
X-Gm-Message-State: AOAM530KtBlYtACCO+xg1ieaLz8rl65WtnpUlpBAwobR0nNMmV2fie7m
        WYWaoEEwBE0w02ho8BPBdacJJxZe0KeXortuXdWRdqTVSCNhKA==
X-Google-Smtp-Source: ABdhPJzAiO3F27TOYkUMvHm6r/ME45xfOreTX/BpgTFPczggJjakzPgxXMFJACNi9mnfx58/N95zvPR4TiZ3z2TVf2M=
X-Received: by 2002:a05:651c:1507:b0:24e:e69e:9b6e with SMTP id
 e7-20020a05651c150700b0024ee69e9b6emr11769543ljf.468.1650912073156; Mon, 25
 Apr 2022 11:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <20220424190811.1678416-10-masahiroy@kernel.org>
In-Reply-To: <20220424190811.1678416-10-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Apr 2022 11:41:01 -0700
Message-ID: <CAKwvOdkac4Bk+u=v2dwSD=X0kZo2y4UxRUNHJdYiTLTPSp7=kQ@mail.gmail.com>
Subject: Re: [PATCH 09/27] modpost: add sym_add_unresolved() helper
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Add a small helper, sym_add_unresolved() to ease the further
> refactoring.
>
> Remove the 'weak' argument from alloc_symbol() because it is sensible
> only for unresolved symbols.

I did not yet read the rest of the series to see how else your newly
added helper `sym_add_unresolved` is used.
Perhaps the callers of `alloc_symbol` should just set the symbol's
weak member to true if needed, and alloc_symbol can default to setting
it false (as the memset currently does)?

Then, you don't need the helper, and just `handle_symbol` needs the
assignment when `ELF_ST_BIND(sym->st_info) == STB_WEAK`?

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 86416e4af626..1c7d2831e89d 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -230,14 +230,12 @@ static inline unsigned int tdb_hash(const char *name)
>   * Allocate a new symbols for use in the hash of exported symbols or
>   * the list of unresolved symbols per module
>   **/
> -static struct symbol *alloc_symbol(const char *name, bool weak,
> -                                  struct symbol *next)
> +static struct symbol *alloc_symbol(const char *name, struct symbol *next)
>  {
>         struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
>
>         memset(s, 0, sizeof(*s));
>         strcpy(s->name, name);
> -       s->weak = weak;
>         s->next = next;
>         s->is_static = true;
>         return s;
> @@ -250,11 +248,17 @@ static struct symbol *new_symbol(const char *name, struct module *module,
>         unsigned int hash;
>
>         hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
> -       symbolhash[hash] = alloc_symbol(name, false, symbolhash[hash]);
> +       symbolhash[hash] = alloc_symbol(name, symbolhash[hash]);
>
>         return symbolhash[hash];
>  }
>
> +static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
> +{
> +       mod->unres = alloc_symbol(name, mod->unres);
> +       mod->unres->weak = weak;
> +}
> +
>  static struct symbol *find_symbol(const char *name)
>  {
>         struct symbol *s;
> @@ -701,9 +705,8 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
>                         }
>                 }
>
> -               mod->unres = alloc_symbol(symname,
> -                                         ELF_ST_BIND(sym->st_info) == STB_WEAK,
> -                                         mod->unres);
> +               sym_add_unresolved(symname, mod,
> +                                  ELF_ST_BIND(sym->st_info) == STB_WEAK);
>                 break;
>         default:
>                 /* All exported symbols */
> @@ -2073,7 +2076,7 @@ static void read_symbols(const char *modname)
>          * the automatic versioning doesn't pick it up, but it's really
>          * important anyhow */
>         if (modversions)
> -               mod->unres = alloc_symbol("module_layout", false, mod->unres);
> +               sym_add_unresolved("module_layout", mod, false);
>  }
>
>  static void read_symbols_from_files(const char *filename)
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
