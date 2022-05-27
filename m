Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385FD5359E6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346752AbiE0HJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbiE0HJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:09:16 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05009FF59B;
        Fri, 27 May 2022 00:08:31 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 24R77wkV008090;
        Fri, 27 May 2022 16:07:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 24R77wkV008090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653635279;
        bh=mV/udz/FFuiifR9fUggl0SWSX/QJeAsM+es90basFQw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bZ6koubBA13dDKKMIF4Qj8XW7ypyDItbXW9QeDuyzuJ1VcBBhpyrPd1gi8XFwNr3C
         FOd4Zi7x5eWmw0zpToh+DeltaWSKMOv/rJxwyEWuGnr2rRR+huri3PWO1akxb4h7I1
         tZiz09bOYz3rRC0z7QF4U2gEbcL0nIpES61RglMsmqC6b0yryiuCq3eSf8ZhXBgtDf
         hnKWIYF7V0iGiHPZOofvvv/OJWvYL8FH4xQfJk9bI4BPVa/NMaAkMwt2u6ndFLh1JY
         mELtIeGoJNElmRK9xbKGUB0+31EPctvX84Akst4scj7aJBtJ952a2NoDH2p7O96d0Y
         GvHqBcnjd7kEg==
X-Nifty-SrcIP: [209.85.214.179]
Received: by mail-pl1-f179.google.com with SMTP id d22so3397859plr.9;
        Fri, 27 May 2022 00:07:59 -0700 (PDT)
X-Gm-Message-State: AOAM5319kLs4zkG44vYOw1K2O0PxjrIoHzqE+zMIiV3gLP1XwS/ir//5
        kTAuvm3Un0tJHnTmopXpbJTS928/ItH0js56/80=
X-Google-Smtp-Source: ABdhPJylxGPI7tDSEZDye7GXUuW8+TbK0iqVGAGVHq+ghY+58bzx25op6jYR9L4MhCmj303SgIUxmq8grFuWppoIVck=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr40896597plp.162.1653635278105; Fri, 27
 May 2022 00:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220524152718.331773-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220524152718.331773-1-alexandr.lobakin@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 27 May 2022 16:06:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNARaUvgOeXg5q9JMErYxQsK16JBmK5sWBxhGSu-d+UyrOA@mail.gmail.com>
Message-ID: <CAK7LNARaUvgOeXg5q9JMErYxQsK16JBmK5sWBxhGSu-d+UyrOA@mail.gmail.com>
Subject: Re: [PATCH] modpost: fix removing numeric suffixes
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Michal Nazarewicz <mina86@mina86.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

On Wed, May 25, 2022 at 12:28 AM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> With the `-z unique-symbol` linker flag or any similar mechanism,
> it is possible to trigger the following:
>
> ERROR: modpost: "param_set_uint.0" [vmlinux] is a static EXPORT_SYMBOL
>
> The reason is that for now the condition from remove_dot():
>
> if (m && (s[n + m] == '.' || s[n + m] == 0))
>
> which was designed to test if it's a dot or a '\0' after the suffix
> is never satisfied.
> This is due to that `s[n + m]` always points to the last digit of a
> numeric suffix, not on the symbol next to it (from a custom debug
> print added to modpost):
>
> param_set_uint.0, s[n + m] is '0', s[n + m + 1] is '\0'
>
> So it's off-by-one and was like that since 2014.
>
> Fix this for the sake of any potential upcoming features, but don't
> bother stable-backporting, as it's well hidden -- apart from that
> LD flag, it can be triggered only with GCC LTO which never landed
> upstream.
>
> Fixes: fcd38ed0ff26 ("scripts: modpost: fix compilation warning")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---


Applied to linux-kbuild.
Thanks.



>  scripts/mod/modpost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 6f5c605ab0fb..fd04ba057490 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1905,7 +1905,7 @@ static char *remove_dot(char *s)
>
>         if (n && s[n]) {
>                 size_t m = strspn(s + n + 1, "0123456789");
> -               if (m && (s[n + m] == '.' || s[n + m] == 0))
> +               if (m && (s[n + m + 1] == '.' || s[n + m + 1] == 0))
>                         s[n] = 0;
>         }
>         return s;
> --
> 2.36.1
>


-- 
Best Regards
Masahiro Yamada
