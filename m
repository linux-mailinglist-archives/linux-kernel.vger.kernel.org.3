Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2635049F12C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345499AbiA1Clt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:41:49 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:20782 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241696AbiA1Clr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:41:47 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 20S2fY8X008122;
        Fri, 28 Jan 2022 11:41:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 20S2fY8X008122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1643337694;
        bh=4JwARZdKVo3l5mCIOwcu21mpuSYlPGM/jXChU9Tmvv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lMJ1QSht7dX1owf3nll55YpxS/G/4siojSVe7w7p2iLOjEA5y0bMCCqyjSJUN/54B
         +eSlP9dCRjPQUnQd3pqwf3YCEEtCw+z/shb0W6gc2VZT4iOj8Kxeg/j+pXouSgNUjs
         B8oxA1r5s9CiIsu3waOEi6UawlRbFKmYdCSjCTub2bIzh9fh+/JDV2Uz+NQ4XOSoKC
         lD0X3ilOn6GUkg0CjTtQ4EB4CAq/rOIiT+SzHTrkKxH1sPyK37BKuZJeaai8uHJu6S
         hhD+LSPmPrRt5zH0pevbvO9ztWegM52QpkEoxZ3LWd4Q8UPHPOZgqSZHfr2yXA0iT/
         AXH44hL8KcwtQ==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id d5so5161591pjk.5;
        Thu, 27 Jan 2022 18:41:34 -0800 (PST)
X-Gm-Message-State: AOAM533WE2OgiQsewbJZXxBa0Lu0n8DGYHp/J7JO2FiHfZRkWFtc8krV
        FstK4jae3NaRXdcDKdDabGfeE8f8PQkj2NneJ0Y=
X-Google-Smtp-Source: ABdhPJy1GiKZizyfLYhMezNIV1ytKYsoKKMkU59dG1DjFD/iKFc6IodPKJ/Y/ET9SfcyfEuczaNspQfIJ50T03XKddU=
X-Received: by 2002:a17:90b:1647:: with SMTP id il7mr9537952pjb.119.1643337693823;
 Thu, 27 Jan 2022 18:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
In-Reply-To: <20220112224342.958358-1-quic_eberman@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 28 Jan 2022 11:40:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4wXjLfz_+6QeT06tKr_2Pan0qtxf=adKQtCNagZ+5wQ@mail.gmail.com>
Message-ID: <CAK7LNAQ4wXjLfz_+6QeT06tKr_2Pan0qtxf=adKQtCNagZ+5wQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add environment variables for userprogs flags
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Matthias Maennich <maennich@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC: Arnd)

On Thu, Jan 13, 2022 at 7:44 AM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> Allow additional arguments be passed to userprogs compilation.
> Reproducible clang builds need to provide a sysroot and gcc path to
> ensure same toolchain is used across hosts. KCFLAGS is not currently
> used for any user programs compilation, so add new USERCFLAGS and
> USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
>
> Specifically, I'm trying to force CC_CAN_LINK to consistently fail in
> an environment where a user sysroot is not specifically available.
> Currently, Clang might automatically detect GCC installation on hosts
> which have it installed to a default location in /. With addition of
> these environment variables, our build environment can do like
> "--sysroot=/dev/null" to force sysroot detection to fail.
>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---


> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
>  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
>  UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
>
> +# USERCFLAGS might contain sysroot location for CC
> +UAPI_CFLAGS += $(USERCFLAGS)
>

I am OK with this patch, but I was not sure with this line.

Initially, I thought exported UAPI headers should be self-contained.
In other words, we should be able to compile-test them without
relying on compiler or libc headers.

Is this achievable or not?

I think Arnd is an expert in this area.
I hope some input from him.





 +
>  override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
>
>  # The following are excluded for now because they fail to build.
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
