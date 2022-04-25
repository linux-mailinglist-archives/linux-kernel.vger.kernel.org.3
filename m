Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5050E8B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243503AbiDYSvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbiDYSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:51:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD68982315
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:48:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 4so5449063ljw.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97ircpnTlmecwY/7O+f+s+rA+JVviEWlUCrBMQWwcqc=;
        b=LH4UVHiUiNGOVOcy7rAkGBU3Uqijf2xz8x8fGioIs4FMpDBYDJDYsxQ4gXJWDt8tfu
         dwjmc/QpOAieK8jh5b7FvvuDCYeaq4DtbzxgIrRdc67VTCz9BySBqpmuxXCrZww5DB8w
         XK6LIxQeNZSx+s4gqELNTw+jZfOl+Gk4bHKWi3OPz6cRDjIHy6lZF5V4dmEeOv7zoWi7
         FRenu0w1vcqmdL2GmM6mWp6jrcGS3PjoT2HxJUb1vl4GL1Ejjij3xYg3bIJVV2LnhoTE
         FcboLj+ify+UEdkej5pwo4FHilN2jpNz2s3FMrc/y8KpjeNdd6GYgNIfDUHKEziP3YW0
         K95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97ircpnTlmecwY/7O+f+s+rA+JVviEWlUCrBMQWwcqc=;
        b=BC61Ma/SbYQ+Fo1xELoEojurIE6xZ3zFhny1VsUkLUURX6A5BwMJeixbjhUMnmFZsI
         8J1etKUpvmQhuW/nxxRrmo52RNRXBAxRrJLaeJhy04Sv8/XfuBIhA7gM6ghU9JX75iv/
         J4k7kRFDTZpc8bIdGm1itQQVLahiyfBKsFjvbhNtb9YM8BoH50adbxYh2F/8iGJPtELf
         L8Xf/7aYETvxAfgD40QO+XINskGEPYMgTEytVDE0BUbc4WgMIZdDdZKYHFwfPLVdF9GS
         X9WsM83LNIsWf0fbD/rHbZGnqkYLwcdwFog13sLlJC1x9uk8UOnMU9MeSldomigq+glD
         RNWA==
X-Gm-Message-State: AOAM532HtRGg7kMiDkeFWAbnHGXSHUjE9FfQVx38afVvpMnew719nKB8
        +3XqU2ZqbiLG552T5I4g+FsIH1PDuMEdj4wS4mfH+Q==
X-Google-Smtp-Source: ABdhPJxRXmciVkJZwv+akqFKplpsCGdSmQLA0b/s/4YsRcp1++XrM7F1dp5IgDYIENLS8+9Tz0OajwOk7Oy9xPvk5bg=
X-Received: by 2002:a05:651c:553:b0:24f:18c1:d2a1 with SMTP id
 q19-20020a05651c055300b0024f18c1d2a1mr472938ljp.239.1650912491821; Mon, 25
 Apr 2022 11:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <20220424190811.1678416-17-masahiroy@kernel.org>
In-Reply-To: <20220424190811.1678416-17-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Apr 2022 11:48:00 -0700
Message-ID: <CAKwvOdk1nt4b9am=_BP=U3igkSRBN14nx+5oS8iaaw9zhbH5JA@mail.gmail.com>
Subject: Re: [PATCH 16/27] modpost: make multiple export error
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
> This is currently a warning, but I think modpost should stop building
> in this case.
>
> If the same symbol is exported multiple times and we let it keep going,
> the sanity check becomes difficult.
>
> Only the legitimate case is that an external module overrides the
> corresponding in-tree module to provide a different implementation
> with the same interface.

Could the same module export a weak version of a symbol, and a strong one?

Can kernel modules override in-kernel strong symbols?

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 14044cd94aaa..73f0b98e3b5a 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -411,9 +411,9 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
>                 list_add_tail(&s->list, &mod->exported_symbols);
>         } else if (!external_module || s->module->is_vmlinux ||
>                    s->module == mod) {
> -               warn("%s: '%s' exported twice. Previous export was in %s%s\n",
> -                    mod->name, name, s->module->name,
> -                    s->module->is_vmlinux ? "" : ".ko");
> +               error("%s: '%s' exported twice. Previous export was in %s%s\n",
> +                     mod->name, name, s->module->name,
> +                     s->module->is_vmlinux ? "" : ".ko");
>                 return s;
>         }
>
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
