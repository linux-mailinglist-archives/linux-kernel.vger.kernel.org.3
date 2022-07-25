Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD49580326
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiGYQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiGYQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:53:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125D91D0E2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:53:36 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o12so13841265ljc.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qC6jLS4IBP8KcMghgftdhKr7IWXyVuOWjf7QInzDOY=;
        b=iLlriYvFj1J57mpeQrtLp6H3buKCysZi+d2PGYRmnf0fMae4Ss1YqqoIyYjDlVneao
         0sBZwxqyg6sSk1UX884E2a2Y7rKLbMJBO3zxsvuneS5CbXz4AaVRl3yvoq1QxBa9oBO6
         IRalGQS9i7ixCpgdz4p6OaIMt/etdgj5v8Ub5HACtSZ+bagRGjnbxdq9b+5FLQqOB1zr
         OAu3quOLQHpt40yPiqQ17awhJ8Jc+bXnZVSSIM4FAl+z6xhvR6i6/uPgVHLFS3KKwDwU
         Aq0aKxEXppD2ctplRoJ+ioa08Ax1Tq20TYCuxVPIg5wTOyc5YBWOEPhy0nk5STNzu1Ne
         cxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qC6jLS4IBP8KcMghgftdhKr7IWXyVuOWjf7QInzDOY=;
        b=RTEwNN9Dm2s4FtMx1XafWIOFPfEbzJ6X5f0nF6lCigY1ulHlyOPpiRzVfx+p8iXah8
         PaCTU/863AT0pPCXrYWf5crGTwTOk88bWFk/Ix5ZQ6AQeD6Z9JdEPtlxSE8Y0CIiadHw
         TW8z/z6IVM9WSIc6s1AOoDR1YeAGMKptltDwzL2pYuGO+74QGoU8Nc/LY8Qq4VJxyaMN
         qogbUE15AyZTYhK+O/1xSGhCY9hw/j1SWSEz+69I8Af8KjYmdHGeIRyByq7KtEguW6R/
         pQ13uKNNe5hf8uba39ceFiOYxMAG8pfJBpt0jPQb1urHyv3JxTbrXc0WOkXWHXZSmSMW
         Yq2Q==
X-Gm-Message-State: AJIora8RRDe0gSgEea94wSyoDA7W1g0NHJ5LNF50HSIqWnjOA8UO4lXG
        iEVx396ys6DCHWWAmh/06C75NMmtY2Myb24yLLkAkbly7js=
X-Google-Smtp-Source: AGRyM1vHOyCTXVJpCqHZPL5lZxdt/g6JYSmqZi7q120V6BCVVhb2AolH1enQmPFbfpdpOhT45Pi5DABp2WNESf39e6M=
X-Received: by 2002:a2e:920e:0:b0:25d:ed6f:e66b with SMTP id
 k14-20020a2e920e000000b0025ded6fe66bmr4283266ljg.103.1658768014269; Mon, 25
 Jul 2022 09:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220719165300.3000580-1-masahiroy@kernel.org> <20220719165300.3000580-2-masahiroy@kernel.org>
In-Reply-To: <20220719165300.3000580-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jul 2022 09:53:22 -0700
Message-ID: <CAKwvOdmV55_q_niHFP26i9US9OBbTaHVNDhOya+yLR2CTEZLjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] modpost: use sym_get_data() to get module
 device_table data
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

On Tue, Jul 19, 2022 at 9:53 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Use sym_get_data() to replace the long code.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/file2alias.c | 4 +---
>  scripts/mod/modpost.c    | 2 +-
>  scripts/mod/modpost.h    | 1 +
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index cbd6b0f48b4e..80d973144fde 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1571,9 +1571,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>                 zeros = calloc(1, sym->st_size);
>                 symval = zeros;
>         } else {
> -               symval = (void *)info->hdr
> -                       + info->sechdrs[get_secindex(info, sym)].sh_offset
> -                       + sym->st_value;
> +               symval = sym_get_data(info, sym);
>         }
>
>         /* First handle the "special" cases */
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 6370f9accb8e..26254e96c300 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -324,7 +324,7 @@ static void *sym_get_data_by_offset(const struct elf_info *info,
>         return (void *)info->hdr + sechdr->sh_offset + offset;
>  }
>
> -static void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym)
> +void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym)
>  {
>         return sym_get_data_by_offset(info, get_secindex(info, sym),
>                                       sym->st_value);
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 044bdfb894b7..4d8a1ae1d1e3 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -187,6 +187,7 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen);
>  /* from modpost.c */
>  char *read_text_file(const char *filename);
>  char *get_line(char **stringp);
> +void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym);
>
>  enum loglevel {
>         LOG_WARN,
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
