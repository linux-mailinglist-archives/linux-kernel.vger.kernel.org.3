Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDB492D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244394AbiARSVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:21:47 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:33809 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244323AbiARSVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:21:45 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 20IILSee011882;
        Wed, 19 Jan 2022 03:21:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 20IILSee011882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642530089;
        bh=RDC2Fjwcdz1UygYpDoeHxvqZCWGtSgJ9ZjIXI8tV+ew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mfFin+KCmPBqKmbXzoh3r93wOV+yaxUedaMyO9+I3TG8tVz0NoUmSUaInWEyg/QnG
         0/CNliD0nNuOqCUuIi116VSprw7PMXnGPst2kARVqhpf1o1xvkC2PFql1Ggk9Jc7Vx
         hbvOgnd16yMyMsNQqCjjwbjSidwSOvjrcedWxTe3Fi5RqGR1QSEYcnFnMx3i6xq2Aw
         7wEZYCHlYZrQXJGMvS5LiETzLMTRpRDj78uYOWN0ZB8+FJB1/6I5T4MNZt/wDYK7eD
         PpAwlw8Gvrh4hlhGU7iUKA0jnSivKf3s3+2f/QwvlAKekEpH6hHswrx2MqPJ9jJkjj
         pNUfU04PtzOcw==
X-Nifty-SrcIP: [209.85.215.170]
Received: by mail-pg1-f170.google.com with SMTP id r11so2038420pgr.6;
        Tue, 18 Jan 2022 10:21:28 -0800 (PST)
X-Gm-Message-State: AOAM533WSndfyBPrWtLYCZGT26aw4w02jXB5x44k00xy6CNP/GATFrkW
        Be2326zhhdqx5goIjIUabdDq/rpwRXUxzBr91lM=
X-Google-Smtp-Source: ABdhPJxppakuZNPZqJ8qO8K8ZnlZedADMwxwZPJWvK53Cb26njShi1VOp3FVrSTverXM6Z5OxoMeUzwigo4tAEzELgU=
X-Received: by 2002:a63:7148:: with SMTP id b8mr24532460pgn.616.1642530087928;
 Tue, 18 Jan 2022 10:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20211213100043.45645-1-arielmarcovitch@gmail.com> <20211213100043.45645-2-arielmarcovitch@gmail.com>
In-Reply-To: <20211213100043.45645-2-arielmarcovitch@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 19 Jan 2022 03:20:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+Df_V-B9Qy_39hgUZF1b6UeiHQ5m-25JekiVYSQ67dQ@mail.gmail.com>
Message-ID: <CAK7LNAS+Df_V-B9Qy_39hgUZF1b6UeiHQ5m-25JekiVYSQ67dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: Show menuconfigs as menus in the .config file
To:     Ariel Marcovitch <arielmarcovitch@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 7:01 PM Ariel Marcovitch
<arielmarcovitch@gmail.com> wrote:
>
> Until now, menuconfigs were considered configs because they had non-zero
> sym attribute. This meant that instead of having the nice menu comment
> block in the .config output file, they were merely shown as single
> configs.
>
> For example:
> ```Kconfig
> menu "Foo"
> endmenu
>
> menuconfig BAR
>         bool "Bar"
>
> config OTHER
>         bool "Other"
>         depends on BAR
> ```
>
> Will be shown as:
> ```.config
>  #
>  # Foo
>  #
>  # end of Foo


I am OK with this patch.

Just a nit.

As far as I tested your sample code (without applying this patch),
I did not see the line "# end of Foo".

The line "# end of ..." is printed when the last child gets back to
its parent, but the "Foo" menu has no child menu here.

This is out of scope of this patch, but can you update the
commit log so it matches the current behavior?

(or add one config into the "Foo" menu)







>
>  CONFIG_BAR=y
>  CONFIG_OTHER=y
> ```
>
> Instead of using the sym attribute to decide whether or not to print the
> menu block comment, check menu->prompt->type explicitly (after checking
> that menu_is_visible(menu) which means menu->prompt is not none). The
> only prompt types we actually show as menus are P_MENU and P_COMMENT. At
> the end of the menu we need to show the end of block only for P_MENU
> (although P_COMMENT prompts will not get to this flow because they don't
> have children).
>
> Signed-off-by: Ariel Marcovitch <arielmarcovitch@gmail.com>
> ---
>  scripts/kconfig/confdata.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 42bc56ee238c..9f2c22f46ee0 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -874,16 +874,21 @@ int conf_write(const char *name)
>         menu = rootmenu.list;
>         while (menu) {
>                 sym = menu->sym;
> -               if (!sym) {
> -                       if (!menu_is_visible(menu))
> -                               goto next;
> -                       str = menu_get_prompt(menu);
> -                       fprintf(out, "\n"
> -                                    "#\n"
> -                                    "# %s\n"
> -                                    "#\n", str);
> -                       need_newline = false;
> -               } else if (!(sym->flags & SYMBOL_CHOICE) &&
> +
> +               if (menu_is_visible(menu)) {
> +                       enum prop_type type = menu->prompt->type;
> +
> +                       if (type == P_MENU || type == P_COMMENT) {
> +                               str = menu_get_prompt(menu);
> +                               fprintf(out, "\n"
> +                                       "#\n"
> +                                       "# %s\n"
> +                                       "#\n", str);
> +                               need_newline = false;
> +                       }
> +               }
> +
> +               if (sym && !(sym->flags & SYMBOL_CHOICE) &&
>                            !(sym->flags & SYMBOL_WRITTEN)) {
>                         sym_calc_value(sym);
>                         if (!(sym->flags & SYMBOL_WRITE))
> @@ -904,7 +909,8 @@ int conf_write(const char *name)
>                 if (menu->next)
>                         menu = menu->next;
>                 else while ((menu = menu->parent)) {
> -                       if (!menu->sym && menu_is_visible(menu) &&
> +                       if (menu_is_visible(menu) &&
> +                           menu->prompt->type == P_MENU &&
>                             menu != &rootmenu) {
>                                 str = menu_get_prompt(menu);
>                                 fprintf(out, "# end of %s\n", str);
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
