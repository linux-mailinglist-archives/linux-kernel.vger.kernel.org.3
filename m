Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5E4BAFC4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiBRCfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:35:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiBRCfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:35:52 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC016F0F;
        Thu, 17 Feb 2022 18:35:36 -0800 (PST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 21I2ZFv5005356;
        Fri, 18 Feb 2022 11:35:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 21I2ZFv5005356
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645151715;
        bh=puHr9io6ldcFQQ1FxuWLJFlpKkiHzLgrPODpqV1G2ww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X3YQOuzBkdRDyohTWDOpIqTthO/KxHIDE/1mbyEzhruMVjmcU2nJcvW+ohSVjCV1Y
         YDnnIvyeEgfZaoz6aHozcY1QGc5hyOR6fA59USHB6QfuAO7cz9WpfKUzXtmDg936Y+
         6bU9ehj8yJjt16mCFddE8F76/Wdx/7xdGUNpYRr0/Lzov2WG1X+GNOCbVsfe/vwbny
         OI7cHPoEQFH2QbtloWfvK0XH5l3+h7zgZfJpuFB7TcZLyAuUf8yFm0elK5CjthJ3AL
         UNc2YsBQiOZoteUDhr+ZBJHDPvk4ZpVN8U0K9cKYPEqPN3iQBvIb1QIckbhjHeCZRI
         5gfJGyKEhlkBw==
X-Nifty-SrcIP: [209.85.216.41]
Received: by mail-pj1-f41.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so11092570pjv.5;
        Thu, 17 Feb 2022 18:35:15 -0800 (PST)
X-Gm-Message-State: AOAM532YeGIHvLtrqVpCOhec28oarGXek0jNkTUj6pX1JUcVVzAWDnJS
        /tfveAWLzgPV83b7/QDi7Y9s4zRsl1zm836cakc=
X-Google-Smtp-Source: ABdhPJx2M577DIVzSuh6cjkua+KA3A1yP4/J9t7KP2negUHOk2j3T9i+nN0eBU7O6OaFqVrN22vOJHec8G2kFAOfc38=
X-Received: by 2002:a17:902:d2d1:b0:149:732e:d335 with SMTP id
 n17-20020a170902d2d100b00149732ed335mr5490327plc.136.1645151714541; Thu, 17
 Feb 2022 18:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20220212161837.2235261-1-masahiroy@kernel.org>
In-Reply-To: <20220212161837.2235261-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 18 Feb 2022 11:34:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNm7Ly6AEx1XBD=gSbQs=Av+TM1bcX5m=DGRSs5BhKqA@mail.gmail.com>
Message-ID: <CAK7LNAQNm7Ly6AEx1XBD=gSbQs=Av+TM1bcX5m=DGRSs5BhKqA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: add fflush() before ferror() check
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 1:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> As David Laight pointed out, there is not much point in calling
> ferror() unless you call fflush() first.
>
> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Applied to linux-kbuild.


>
>  scripts/kconfig/confdata.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index d3c3a61308ad..94dcec2cc803 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -979,6 +979,7 @@ static int conf_write_autoconf_cmd(const char *autoconf_name)
>
>         fprintf(out, "\n$(deps_config): ;\n");
>
> +       fflush(out);
>         ret = ferror(out); /* error check for all fprintf() calls */
>         fclose(out);
>         if (ret)
> @@ -1097,6 +1098,7 @@ static int __conf_write_autoconf(const char *filename,
>                 if ((sym->flags & SYMBOL_WRITE) && sym->name)
>                         print_symbol(file, sym);
>
> +       fflush(file);
>         /* check possible errors in conf_write_heading() and print_symbol() */
>         ret = ferror(file);
>         fclose(file);
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
