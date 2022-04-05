Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851004F4F16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836938AbiDFAk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457661AbiDEQ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:28:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B507289CCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:26:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h7so24207846lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lWYY7De4WBUMiRj3mzR0cknXK+RlvIrzmLorqOc2As=;
        b=iTrCvQL9sM/MUivHYMPf4aKtiHgt6HV4/9ZxumavdEUbybx2Mmzfcw/oiSfdwl2Zrq
         EhD/G1ftARD2N/Y73EQR3VdBBRBM1j1TGf6b/V0CNMbJFcDDejOS2TPOPdF6bUKoRdd/
         7gNOYlS4qrA/eUNKW2E+uxCkxDs3ns4pTLN9k+vcChjjNvkW03CcLSzN/WmfM6/ohOtR
         5SRkfl97vN+215wkqt0YJ6VcHnqvaCD9K+8JqrAdaKCi5Expud2Nw9PXQZqYecntlWWg
         zv1exSe7AWGBQH3ORUB4oobs2mWIqmKVq21231/XSlykM7pqPzcetba6fb/VTDCumg0a
         Zh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lWYY7De4WBUMiRj3mzR0cknXK+RlvIrzmLorqOc2As=;
        b=icZHu4Cz20nIaCHsHsdiwRcMzl8oqn14d7zWB/Q5uTNDKgAQuXDR6KbnEVY/Kp9Or7
         Qi12ismYH48A1wDWxCypE366qHMJ53ClBnJEiafcequQd6MaaAD3+q3+VAKyhNDqc9q/
         wk0eUIOJv+49nMFBehrhHD8154LUU2WGxHHbHOCFCSdg/YKJkcbC2GoiK2Pxa+RU+Qin
         rl1G9PX1g/Hi+T+MB22HuPRqnMQBUEXvOWBX+vBr1IDqkNrfsyCO17+35HbtWLEDXqob
         6RqI1Q9XnyD4RXgZWs+U/pra2WtUGzb7VogPbG07Mx9ZP65dKgh44Da1A0t8lKeHmbBO
         qCKg==
X-Gm-Message-State: AOAM5306l84tHxUZmnokzP3cOBm2oI058WCgQLZAN3yJ5pGEZYo/Zm3P
        H9QCZ2bhD2vwFQ8dygoxzOOFcXErsf4uHjKBq3xELw==
X-Google-Smtp-Source: ABdhPJzm9QcSluyOhFjGMfELQHjTr0+RTq5+/AG1ZSda5FkvPasWSBysDU69ZMdlhv33y1Ls5e4uCGoXp6//pr3GG5Y=
X-Received: by 2002:a19:651d:0:b0:44a:b88a:b0b1 with SMTP id
 z29-20020a19651d000000b0044ab88ab0b1mr3328216lfb.380.1649175988738; Tue, 05
 Apr 2022 09:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220405113359.2880241-1-masahiroy@kernel.org> <20220405113359.2880241-7-masahiroy@kernel.org>
In-Reply-To: <20220405113359.2880241-7-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Apr 2022 09:26:17 -0700
Message-ID: <CAKwvOdkC3RYjOPx-DS0fSCHsts1YGzotBOs4fTKTQk7WZWfBgg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] modpost: remove annoying namespace_from_kstrtabns()
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

On Tue, Apr 5, 2022 at 4:34 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> There are two call sites for sym_update_namespace().
>
> When the symbol has no namespace, s->namespace is set to NULL,
> but the conversion from "" to NULL is done in two different places.
>
> [1] read_symbols()
>
>   This gets the namespace from __kstrtabns_<symbol>. If the symbol has
>   no namespace, sym_get_data(info, sym) returns the empty string "".
>   namespace_from_kstrtabns() converts it to NULL before it is passed to
>   sym_update_namespace().
>
> [2] read_dump()
>
>   This gets the namespace from the dump file, *.symvers. If the symbol
>   has no namespace, the 'namespace' is the empty string "", which is
>   directly passed into sym_update_namespace(). The conversion from
>   "" to NULL is done in sym_update_namespace().
>
> namespace_from_kstrtabns() exists only for creating this inconsistency.
>
> By removing it, sym_update_namespace() is consistently passed with ""
> when the symbol has no namespace.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v2:
>   - new
>
>  scripts/mod/modpost.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 2a202764ff48..522d5249d196 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -369,13 +369,6 @@ static enum export export_from_secname(struct elf_info *elf, unsigned int sec)
>                 return export_unknown;
>  }
>
> -static const char *namespace_from_kstrtabns(const struct elf_info *info,
> -                                           const Elf_Sym *sym)
> -{
> -       const char *value = sym_get_data(info, sym);
> -       return value[0] ? value : NULL;
> -}
> -
>  static void sym_update_namespace(const char *symname, const char *namespace)
>  {
>         struct symbol *s = find_symbol(symname);
> @@ -391,8 +384,7 @@ static void sym_update_namespace(const char *symname, const char *namespace)
>         }
>
>         free(s->namespace);
> -       s->namespace =
> -               namespace && namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
> +       s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
>  }
>
>  /**
> @@ -2049,9 +2041,7 @@ static void read_symbols(const char *modname)
>                 /* Apply symbol namespaces from __kstrtabns_<symbol> entries. */
>                 if (strstarts(symname, "__kstrtabns_"))
>                         sym_update_namespace(symname + strlen("__kstrtabns_"),
> -                                            namespace_from_kstrtabns(&info,
> -                                                                     sym));
> -
> +                                            sym_get_data(&info, sym));
>                 if (strstarts(symname, "__crc_"))
>                         handle_modversion(mod, &info, sym,
>                                           symname + strlen("__crc_"));
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
