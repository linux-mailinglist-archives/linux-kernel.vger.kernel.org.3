Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367F14B01E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiBJBUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:20:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBJBUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:20:39 -0500
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746072629;
        Wed,  9 Feb 2022 17:20:38 -0800 (PST)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-07.nifty.com with ESMTP id 21A0sXbt021538;
        Thu, 10 Feb 2022 09:54:33 +0900
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 21A0s7YW021042;
        Thu, 10 Feb 2022 09:54:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 21A0s7YW021042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644454448;
        bh=GzF9d1CPJ6YQKFkbbGBhv3+4+f8c6oA7UoFBRscMx1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xvGvf1XYqFFIJt4Otcj/oDt5pe8gRh6D7SbUOuChUJOgUD5sptvKTvlrK7lDb2hqp
         NBb0T5F/mj1Zf43Pke58lSfGTU2XaLdZ0HuNo5u6a8xGDLl7i04ApNkv0WijbKup3w
         +9wZrS6yaJu4vMSopyBIppW8ic52RbYqR9DpZmjqFgRUiy7jhP0jxb/IC/302wis/I
         GG4RW0/n6aQkhzwUtDXdE6e5KrAXFAIm+cfnhajL2izuqSAxt/df8wFRFWlFh59H9I
         HJgjz8PmFdnNEU2RmJEq2l+kQF+0mT3HQV8rOzlplllBR2PRCyhJ1nn7AnabZNLobs
         pofTxmTSjMfNw==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id c8-20020a17090a674800b001b91184b732so4448996pjm.5;
        Wed, 09 Feb 2022 16:54:08 -0800 (PST)
X-Gm-Message-State: AOAM533OpxsU4JIrDxZI5PJt4Bd76G/Jbc632UaLIAWf0uqFECOrh08V
        WKzMTdrpbl8ZfhbMcZd4zRuAEhECJyD+lyX+u14=
X-Google-Smtp-Source: ABdhPJxYNdvbvsgfJh3s8wRrHOxkb+ZVxnQom67+weOLsIwyXbGJaZTgP6KgRQYD3yXAWw8K9ul72rUx61a9pv7ueFo=
X-Received: by 2002:a17:903:22c5:: with SMTP id y5mr2853067plg.99.1644454447226;
 Wed, 09 Feb 2022 16:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20220208062618.1869210-1-masahiroy@kernel.org>
In-Reply-To: <20220208062618.1869210-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 10 Feb 2022 09:53:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNASojfnOaAmgwwCsA9J-nhYtRzJx8AKmy8OpRm50uWfegQ@mail.gmail.com>
Message-ID: <CAK7LNASojfnOaAmgwwCsA9J-nhYtRzJx8AKmy8OpRm50uWfegQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix missing fclose() on error paths
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Ryan Cai <ycaibb@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 3:26 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The file is not closed when ferror() fails.
>
> Fixes: 00d674cb3536 ("kconfig: refactor conf_write_dep()")
> Fixes: 57ddd07c4560 ("kconfig: refactor conf_write_autoconf()")
> Reported-by: Ryan Cai <ycaibb@gmail.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


Applied to linux-kbuild/fixes.


>
>  scripts/kconfig/confdata.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 59717be31210..16897cb8cefd 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -979,10 +979,10 @@ static int conf_write_autoconf_cmd(const char *autoconf_name)
>
>         fprintf(out, "\n$(deps_config): ;\n");
>
> -       if (ferror(out)) /* error check for all fprintf() calls */
> -               return -1;
> -
> +       ret = ferror(out); /* error check for all fprintf() calls */
>         fclose(out);
> +       if (ret)
> +               return -1;
>
>         if (rename(tmp, name)) {
>                 perror("rename");
> @@ -1093,10 +1093,10 @@ static int __conf_write_autoconf(const char *filename,
>                         print_symbol(file, sym);
>
>         /* check possible errors in conf_write_heading() and print_symbol() */
> -       if (ferror(file))
> -               return -1;
> -
> +       ret = ferror(file);
>         fclose(file);
> +       if (ret)
> +               return -1;
>
>         if (rename(tmp, filename)) {
>                 perror("rename");
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
