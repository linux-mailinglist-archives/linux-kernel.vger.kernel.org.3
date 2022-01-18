Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB956492D49
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348014AbiARS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:27:00 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:65458 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiARS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:26:59 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 20IIQRnB016066;
        Wed, 19 Jan 2022 03:26:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 20IIQRnB016066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642530388;
        bh=dHrjvzYeF+kmk6NZ+W9xqKFkk9zOX9Dzya0WrCoKlAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oT5cHkFct229ODIuv4JraSS6f8cTYWv0T5MAWmq/aKl8lEs+wRoinca6wCQVskIyo
         S223ri9LJqhBOovWHvSD9yCAQxb0u9u5gXPWQEDUJTHQ6YwjPzLWfXNH+g1nRjQOfy
         zKBLv5mAgZRrptnTlGz+BdGgQEx8aNNobnkBG0ZT97ebr4u3BMqMgiUpbgyPTNNdAo
         cBicae3TdS8131slFA2TckVDmQf04mmDjhwzGryesNyzZK5gzd7Tuyk9soDUsp5Wkj
         +hnsfiEgnAkEezVSYur6t8bwrPx7/cxjZ0p7/aQra9bnc7QRlSqCCutOSCthDYoxHs
         wuThbla2rIoNg==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id d7so3804177plr.12;
        Tue, 18 Jan 2022 10:26:28 -0800 (PST)
X-Gm-Message-State: AOAM531Nw2xYCG38Mmc5Rq3CaH7jXeZhvozeDDPscEyKj29jENfxrkpU
        dCs6RBoRRC0vrTGcshIOvADOuEdm5q/19e8XiLg=
X-Google-Smtp-Source: ABdhPJzKrkCv71ig/BNJ0ZyxgSk6dQ/7l7G0qIoM5buPY1ZaOu+6gOyiW2PfFi5szwauRcrJFTq+4QIT1Nx23A2rgjc=
X-Received: by 2002:a17:902:6a89:b0:149:732e:d335 with SMTP id
 n9-20020a1709026a8900b00149732ed335mr29134357plk.136.1642530387508; Tue, 18
 Jan 2022 10:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20211213100043.45645-1-arielmarcovitch@gmail.com> <20211213100043.45645-3-arielmarcovitch@gmail.com>
In-Reply-To: <20211213100043.45645-3-arielmarcovitch@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 19 Jan 2022 03:25:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQb8ivsQX-0YDNx6B_ZTBUq9v7SSG+m8=e1GsGL-DuBsg@mail.gmail.com>
Message-ID: <CAK7LNAQb8ivsQX-0YDNx6B_ZTBUq9v7SSG+m8=e1GsGL-DuBsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kconfig: Make comments look different than menus in .config
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
> Currently, the same code that handles menus in the write to .config
> handles comments as well. That's why comments look exactly like menus in
> the .config except for the 'end of menu' comments that appear only for
> menus. This makes sense because sometimes comments are used as sort of
> submenus. However for the other cases, it looks kinda weird because one
> might attempt to look for the 'end of menu' for comments as well and be
> very confused.
>
> Make comments look different than menus. For the following:
> ```kconfig
> menu "Stuff"
>
> config FOO
>         def_bool y
>
> comment "Some comment"
>
> config BAR
>         def_bool n
>
> endmenu
> ```
>
> The .config will look like this:
> ```
>  #
>  # Stuff
>  #
>  CONFIG_FOO=y
>
>  ### Some comment
>  # CONFIG_BAR is not defined
>  # end of Stuff
>
> ```
>
> Signed-off-by: Ariel Marcovitch <arielmarcovitch@gmail.com>
> ---
>  scripts/kconfig/confdata.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 9f2c22f46ee0..d3ec1ad67d92 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -880,10 +880,16 @@ int conf_write(const char *name)
>
>                         if (type == P_MENU || type == P_COMMENT) {
>                                 str = menu_get_prompt(menu);
> -                               fprintf(out, "\n"
> -                                       "#\n"
> -                                       "# %s\n"
> -                                       "#\n", str);
> +
> +                               if (type == P_MENU)
> +                                       fprintf(out, "\n"
> +                                               "#\n"
> +                                               "# %s\n"
> +                                               "#\n", str);
> +                               else
> +                                       fprintf(out, "\n"
> +                                               "### %s\n", str);
> +
>                                 need_newline = false;
>                         }
>                 }
> --
> 2.25.1
>


Since "# CONFIG... is not set" looks like a comment,
I am not sure if this improves the visibility.

I will not pick up this until I find out what a really good format is.

-- 
Best Regards
Masahiro Yamada
