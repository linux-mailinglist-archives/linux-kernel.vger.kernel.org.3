Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656B34EEECD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbiDAOHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbiDAOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:07:39 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234C2215460;
        Fri,  1 Apr 2022 07:05:49 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 231E5YY8009590;
        Fri, 1 Apr 2022 23:05:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 231E5YY8009590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648821935;
        bh=lYJwx2t5MLUO2TNFBKPB81K9TnxZtWUlueGyUcuAKt4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DeUicgDCLU0/I7bvjyVh/zIhL5pGUu8QUaRmKYeYQSP6Q6Qmfchk/WNw10t+R+HlG
         XiHlRDhM4WmNiROyhitLzGpezCwBrUsSGmT0SNFn6oaDMVnPJd4J+6CYrbBlAZYpNE
         2FJkiITK6nB0jbG5qWAWRuBJVu98a69hcNTKJnE7eUO9iP0UVe6GWpTrzxSy9aWPzQ
         7NJktYBq0gOQylUJXQ0C0gwtQKSP3h1oo/eHLaTRXW/mAr+SyZLrheFxjeToeI1k8H
         i3pHT5NBJKYtpWhcrcNCVnN7WVJPJiPyz9HjjlmiHNi04b081YylpguE4JhLdzqE/y
         Loiieqy7orymQ==
X-Nifty-SrcIP: [209.85.216.49]
Received: by mail-pj1-f49.google.com with SMTP id c15-20020a17090a8d0f00b001c9c81d9648so2641827pjo.2;
        Fri, 01 Apr 2022 07:05:34 -0700 (PDT)
X-Gm-Message-State: AOAM531cAmEKxJR4malj11OPZ5ll6HZP/w7QoEJRfRvYe58QqpBdksEu
        OnuuhjSbzj4Puy0CDNydCOOlb13ek/JJc56Sw6M=
X-Google-Smtp-Source: ABdhPJyXJLqPhis5QHe17xlqCcalXu5IQ0bAvKEu3AgBBYL3izojvU6lopGH/jRrVFJaqFeKZg0NsEkHRqBFanL3wOk=
X-Received: by 2002:a17:90b:4d01:b0:1c9:ec79:1b35 with SMTP id
 mw1-20020a17090b4d0100b001c9ec791b35mr11774590pjb.77.1648821934090; Fri, 01
 Apr 2022 07:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220330182329.52310-1-s23265@iisve.it>
In-Reply-To: <20220330182329.52310-1-s23265@iisve.it>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Apr 2022 23:04:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvEsh3+dix+EdcXnm2L0rh8hndQD5N2vyc0q_c0Vf7gQ@mail.gmail.com>
Message-ID: <CAK7LNARvEsh3+dix+EdcXnm2L0rh8hndQD5N2vyc0q_c0Vf7gQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use hostname -s along uname to obtain LINUX_COMPILE_HOST
To:     FraSharp <f.duca00@gmail.com>
Cc:     Francesco Duca <s23265@iisve.it>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Thu, Mar 31, 2022 at 3:23 AM FraSharp <f.duca00@gmail.com> wrote:
>
> From: Francesco Duca <s23265@iisve.it>
>
> * On some systems (e.g. macOS), using commands like 'uname -n' or
>   'hostname' will print something similar to "hostname.domain"


Not only macOS, but also on Linux systems such as Fedora, Debian.

'uname -s' or 'hostname' prints "hostname.domain"




>   ("Francescos-Air.fritz.box" for example), which is very annoying.

I do not think so.


>   What works instead is 'hostname -s', which will only write hostname
>   without the domain ("Francescos-Air" for example),
>   but also keep 'uname -n', as some systems as Arch Linux does not have
>   'hostname' as command.

If so, on Arch Linux, will this patch spit
  hostname: command not found
error message because   "2>/dev/null" is missing ?


And, the intention of this patch is,
print  Francescos-Air if the 'hostname -s' command is available,
but Francescos-Air.fritz.box  otherwise, correct  ?






>
> * This commit is complementary to
>   1e66d50ad3a1dbf0169b14d502be59a4b1213149
>   ("kbuild: Use uname for LINUX_COMPILE_HOST detection")
>
> Signed-off-by: Francesco Duca <s23265@iisve.it>
> ---
>  scripts/mkcompile_h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> index ca40a5258..6054e3eee 100755
> --- a/scripts/mkcompile_h
> +++ b/scripts/mkcompile_h
> @@ -34,7 +34,7 @@ else
>         LINUX_COMPILE_BY=$KBUILD_BUILD_USER
>  fi
>  if test -z "$KBUILD_BUILD_HOST"; then
> -       LINUX_COMPILE_HOST=`uname -n`
> +       LINUX_COMPILE_HOST=$(hostname -s || uname -n)
>  else
>         LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
>  fi
> --
> 2.32.0 (Apple Git-132)
>


-- 
Best Regards
Masahiro Yamada
