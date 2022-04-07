Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA64F86B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiDGR6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346729AbiDGR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:57:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE5FC6EEB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:55:48 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b43so8435219ljr.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsMDlG11v+MVtQRsFhP/CQ1OTrnQ8uEDOmS4RecRlkI=;
        b=ORkOlLgSKF3a29cfSn0mL3YU5r8sMjqP6eNNEVAVlMWqH8cZr59z4KSyJBj8Rg5uPV
         Kat/nGraoT5MR97d0DbYvZIsJUqUEynZetH3yz51Ow3TyKFYIjw7341i+nn1RM2todwp
         DiAHsiTV5wgiPoC91gUO6eZX+IZVmAdg6PkgwomeVonA3bcISCOr/o7MdLHGK0f2lXkz
         Uxe/eixgFe6VUNM+tzU0Rb5HForMwAvuwVdLbr3CZQK72QXhoPkjH/6jAI9kAhCykZWH
         Smv8VlghFDTQMxdzmruQJUb2iaBCLz6MPwVAzDR+AT7iHv4YxxoUTHY4C4x6ozBJBs0y
         Cwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsMDlG11v+MVtQRsFhP/CQ1OTrnQ8uEDOmS4RecRlkI=;
        b=CRxJ1Im35Px38MfMKgoeRRya913GEkawI5AhLcZUrtVscIhAgLt+v2PDxwt3DWWkPZ
         ta2sRfbXGMaCLgkzq4P2KFWWXu3LO5KbeP2/5tYXuVmbZjDiQvY//zxTvZSsq2QD+Lnk
         +pjGUpqbnEO50v0YcPH0vyjZ/LYaRlA5HkVPLSc8WJYDA6CMQYyf1orhmf5ay7n9HVbP
         vh/1lkN3hgTPAahugA3Gg1P0uE3lNktbRdbkSJojT9YiGnPfhgodefgc33iYURgSDGpO
         7U/b4AKQ3sjQZGWYV7gagKLzSNWHMn8X//iHqI0ikj8gEqzoYxs1/Q29vZcwgRW5OrKb
         gYXw==
X-Gm-Message-State: AOAM532H3S/+jFQx8/LZQHf6pInOe1oY34uV42ct7ObN3LFnaZzwEHxB
        eC4dOZv6Xl0/O1tSDWRobLK6KcBt3Cr8Y1HPNJv4mQ==
X-Google-Smtp-Source: ABdhPJxLqzjwmj+80D/xgfjXP3EthWdIu26JGyBg/CC+rJTVqdM0C3HXG4yahc/S0m8P4pjLJk5kGUCEi83OBzFt8ek=
X-Received: by 2002:a2e:8859:0:b0:249:83e5:9f9b with SMTP id
 z25-20020a2e8859000000b0024983e59f9bmr5065725ljj.165.1649354146111; Thu, 07
 Apr 2022 10:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org> <20220406153023.500847-6-masahiroy@kernel.org>
In-Reply-To: <20220406153023.500847-6-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Apr 2022 10:55:34 -0700
Message-ID: <CAKwvOdnHneCy6YeanmvDrabYMWysfQ=WMopsT_gRyrruT8=1Dw@mail.gmail.com>
Subject: Re: [PATCH 5/7] kbuild: get rid of duplication in *.mod files
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 8:31 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> It is allowed to add the same objects multiple times to obj-y / obj-m:
>
>   obj-y += foo.o foo.o foo.o
>   obj-m += bar.o bar.o bar.o
>
> It is also allowed to add the same objects multiple times to a composite
> module:
>
>   obj-m    += foo.o
>   foo-objs := foo1.o foo2.o foo2.o foo1.o
>
> This flexibility is useful because the same object might be selected by
> different CONFIG options, like this:
>
>   obj-m               += foo.o
>   foo-y               := foo1.o
>   foo-$(CONFIG_FOO_X) += foo2.o
>   foo-$(CONFIG_FOO_Y) += foo2.o
>
> The duplicated objects are omitted at link time. It works naturally in
> Makefiles because GNU Make removes duplication in $^ without changing
> the order.
>
> It is working well, almost...
>
> A small flaw I notice is, *.mod contains duplication in such a case.
>
> This is probably not a big deal. As far as I know, the only small
> problem is scripts/mod/sumversion.c parses the same file multiple
> times.
>
> I am fixing this because I plan to reuse *.mod for other purposes,
> where the duplication can be problematic.
>
> The code change is quite simple. We already use awk to drop duplicated
> lines in modules.order (see cmd_modules_order in the same file).

Why does the top level Makefile reassign cmd_modules_order rather than
use the original value in scripts/Makefile.build?

> I copied the code, but changed RS to use spaces as record separators.
>
> I also changed the file format to list one object per line.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/Makefile.build   | 3 ++-
>  scripts/mod/sumversion.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 6ae92d119dfa..f7a30f378e20 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -303,7 +303,8 @@ $(obj)/%.prelink.o: $(obj)/%.o FORCE
>         $(call if_changed,cc_prelink_modules)
>  endif
>
> -cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) > $@
> +cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) | \
> +       $(AWK) -v RS='( |\n)' '!x[$$0]++' > $@

God AWK is unreadable. Any reason we can't use GNU make's sort builtin?
https://www.gnu.org/software/make/manual/html_node/Text-Functions.html

>
>  $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
>         $(call if_changed,mod)
> diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
> index 0125698f2037..79bb9eaa65ac 100644
> --- a/scripts/mod/sumversion.c
> +++ b/scripts/mod/sumversion.c
> @@ -398,7 +398,7 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
>         buf = read_text_file(filelist);
>
>         md4_init(&md);
> -       while ((fname = strsep(&buf, " \n"))) {
> +       while ((fname = strsep(&buf, "\n"))) {
>                 if (!*fname)
>                         continue;
>                 if (!(is_static_library(fname)) &&
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
