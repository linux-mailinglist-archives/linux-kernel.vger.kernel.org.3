Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451034709A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245414AbhLJTHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhLJTHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:07:33 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2995EC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:03:57 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b40so19703914lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YRIlmq1+iZrjFvchtZLa2XEWbp2/+L1kaW6ixwhNcKk=;
        b=dC55T7NVec8zDfqI25DC4orPrU+YljERqdmhvP8BSBfOEWGs7/rj+vdItXMhXXpORv
         eqMpdz/v19NnizJpYYgCcjJRlV+J6XYem0gws42YVfFsXBJmlqrGGE344hZBH/SVGQro
         ZWBUDmPBDw4rOgQ57hZJSHhW9QwTw39/ALNiRcI2h8V8YfSlfCdsVyd3Nza14RKySlsH
         /tvXJPmp8AaLbq6w0IZIbr3IBqhe0TZyHifZFrVa0z4PldqmMPPOkjqUzT2l0qK21eAI
         Tr0Khghv2uXuSopdQZ6ruVbeDM3Ymgu8WJnj+/lUgLWY285GHGHm3Ejo8K4fF6rO2qD2
         u3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YRIlmq1+iZrjFvchtZLa2XEWbp2/+L1kaW6ixwhNcKk=;
        b=5Iwc12KbpWGIQEiNLodwcT7f/XLcRO84AMWNQrPjnHdvnKHrcIRi0TXevQVF/UtnbH
         q4R0E0ArFDskVyPM2ukr17bfiQ3fCVdo68t84dWPQ+m/xPb9wRWERs83wmpd41BBZ0Lz
         U9z3NCSiTu8EmdFjr6npNiZI6LbRx/tQ2Si/ESPJ6PeaJ5PVof2c9XT7qgCP8L3ztfJ7
         BZec/2eaQhfqzD3uxfD7crdmbHD90hntDVgtNz4x7FxIk4mwqJMGRUCv5ajsqRGKIzUj
         LUkd/KhG62YHLXgue338SkODodoIFazmCifMPBuxCk3Ji89HEJmhhYUiUrUzxM+bovzO
         EfvQ==
X-Gm-Message-State: AOAM532FFK3yWFX+w4m/H7kOruwy7XWrZ9XsoIwbbJc43+y+OCpumH/C
        uG0cmgc/UcZnOOi5MlQtDpAXbVx6sr3VCaubQI6Jnw==
X-Google-Smtp-Source: ABdhPJyoOVN7O/8fGgT5BJ/zKJF8IlTUbgLWM2OtohJe4qNABNx3FzVkhf8SEU9GV7/dxhmyOUNT4D+MIizWI79sKB4=
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr13734844lfi.82.1639163035097;
 Fri, 10 Dec 2021 11:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20211210165528.3232292-1-nathan@kernel.org>
In-Reply-To: <20211210165528.3232292-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Dec 2021 11:03:43 -0800
Message-ID: <CAKwvOdktm1p-ZxdOmQnGvdeq1zbPd1C5c7Mp0Co55=prccdcrg@mail.gmail.com>
Subject: Re: [PATCH v2] soc/tegra: fuse: Fix bitwise vs. logical OR warning
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 8:57 AM Nathan Chancellor <nathan@kernel.org> wrote=
:
>
> A new warning in clang points out two instances where boolean
> expressions are being used with a bitwise OR instead of logical OR:
>
> drivers/soc/tegra/fuse/speedo-tegra20.c:72:9: warning: use of bitwise '|'=
 with boolean operands [-Wbitwise-instead-of-logical]
>                 reg =3D tegra_fuse_read_spare(i) |
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>                                                ||
> drivers/soc/tegra/fuse/speedo-tegra20.c:72:9: note: cast one or both oper=
ands to int to silence this warning
> drivers/soc/tegra/fuse/speedo-tegra20.c:87:9: warning: use of bitwise '|'=
 with boolean operands [-Wbitwise-instead-of-logical]
>                 reg =3D tegra_fuse_read_spare(i) |
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>                                                ||
> drivers/soc/tegra/fuse/speedo-tegra20.c:87:9: note: cast one or both oper=
ands to int to silence this warning
> 2 warnings generated.
>
> The motivation for the warning is that logical operations short circuit
> while bitwise operations do not.
>
> In this instance, tegra_fuse_read_spare() is not semantically returning
> a boolean, it is returning a bit value. Use u32 for its return type so
> that it can be used with either bitwise or boolean operators without any
> warnings.
>
> Fixes: 25cd5a391478 ("ARM: tegra: Add speedo-based process identification=
")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1488
> Suggested-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the revised patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v1 -> v2: https://lore.kernel.org/r/20211021214500.2388146-1-nathan@kerne=
l.org/
>
> * Change return type of tegra_fuse_read_spare(), instead of changing
>   bitwise OR to logical OR in tegra20_init_speedo_data() (Micha=C5=82).
>
> It would be nice to get this fixed sooner rather than later, as ARCH=3Dar=
m
> allmodconfig is broken due to -Werror.

Yes please let's try to get this into 5.16-rc5 if possible!

>
>  drivers/soc/tegra/fuse/fuse-tegra.c | 2 +-
>  drivers/soc/tegra/fuse/fuse.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse=
/fuse-tegra.c
> index f2151815db58..e714ed3b61bc 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
> @@ -320,7 +320,7 @@ static struct platform_driver tegra_fuse_driver =3D {
>  };
>  builtin_platform_driver(tegra_fuse_driver);
>
> -bool __init tegra_fuse_read_spare(unsigned int spare)
> +u32 __init tegra_fuse_read_spare(unsigned int spare)
>  {
>         unsigned int offset =3D fuse->soc->info->spare + spare * 4;
>
> diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.=
h
> index de58feba0435..ecff0c08e959 100644
> --- a/drivers/soc/tegra/fuse/fuse.h
> +++ b/drivers/soc/tegra/fuse/fuse.h
> @@ -65,7 +65,7 @@ struct tegra_fuse {
>  void tegra_init_revision(void);
>  void tegra_init_apbmisc(void);
>
> -bool __init tegra_fuse_read_spare(unsigned int spare);
> +u32 __init tegra_fuse_read_spare(unsigned int spare);
>  u32 __init tegra_fuse_read_early(unsigned int offset);
>
>  u8 tegra_get_major_rev(void);
>
> base-commit: 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
> --
> 2.34.1
>
>


--=20
Thanks,
~Nick Desaulniers
