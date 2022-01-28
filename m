Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4871B4A043D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347616AbiA1XaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344459AbiA1X37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:29:59 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A9FC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:29:59 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t14so11120309ljh.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i321YKyDsRK0btGUb/fjVY8h2mIEqZCos2XNM/JjnFw=;
        b=qFMSnkB/pzMTJLJplSHVcYU1saiukEFW8xraxGaLExeC1AAMl0n2XMcm3aoEEMiTwM
         zji2oSEuFStGWrzkFqZN6yDr0YU+xA/eTp+CxveOXQwqGT9SNlR8e2cc4piZ8M+whbE9
         4p7ziIwZuLxqCrPE1kb7dj/GuKurAUe1PVIUIlppAoEZwuNz/XDcgbtTzfpHLcXsMNwy
         N332MH6mSy0h0ZWARDyEUQUd5IfR1E/OmQsj/p+pwg5/KQ2+bprFYelA+1314ThJE1CN
         zGNsK6KSztz7tg6Yc0sE0T4rHKUiVq5ln3jH5fvedRRT4MKrLj9RvA7MjBxHclujUOL8
         20FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i321YKyDsRK0btGUb/fjVY8h2mIEqZCos2XNM/JjnFw=;
        b=noJpMEqkuZQ+Ci3BtiKYZedkcYS3gR/riYqUh8Hu+82fp7uZqcEcS5PBoEb9csCivV
         jekhHYci8wEaErr0YNeKoanP2A3zjvcpcTsQi7StN7zh+5XS2tcYOAGCfUR5GyZbS3Dq
         CObtd+CW4caQGqP+ZVHedAusQS/udxgmtNa36BYSnZIfF5RghH1WCiduabd61sNiNV8s
         EUGs+dZUJqSxVWpZMkJlNPrCO9c5T+V5i2Fbpb6YD4oU7Yu/JPCvty0R9OnZcHrSm85H
         mAM0j178pXZJWv3BbCrijEitvk13DZ4llOrSpf0MbGm/ZBzywHs94WLSfk/3jx+GxEMV
         eoWA==
X-Gm-Message-State: AOAM533A3b3GsFH8eEP8+J79q90FO9FP1NTmLbyxMWn8Zl19eY5sVBIj
        gUXLhynCaezCTlnLSDAh3QwbJKNnSAJDaZf9V0nATXS4ud/T4w==
X-Google-Smtp-Source: ABdhPJyEmbWFCdyMKn2hzT4GP9wF9nEf2Sld8Uyy7Us3WjksoEfiWszRlnIzTxTDiMhM9MtZqBF4MKyjE0pnac0nsxQ=
X-Received: by 2002:a2e:bd15:: with SMTP id n21mr7203379ljq.128.1643412596849;
 Fri, 28 Jan 2022 15:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
 <20220128220841.3222637-1-quic_eberman@quicinc.com> <20220128224528.f7ejzw55t6kfefmm@google.com>
 <CAKwvOd=Ab+GWNzSC6eaDWTVDF6gJQ9fDDMT3hep-DzhrEA6DpQ@mail.gmail.com> <094ab4eb-b877-2a14-d6c8-1d9e28335d7d@quicinc.com>
In-Reply-To: <094ab4eb-b877-2a14-d6c8-1d9e28335d7d@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 28 Jan 2022 15:29:44 -0800
Message-ID: <CAKwvOd=J=84vad_cR06NFDauMXbXsC2o=X4RbPj2cqA1280D=A@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Add environment variables for userprogs flags
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 3:26 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
>
>
> On 1/28/2022 2:49 PM, Nick Desaulniers wrote:
> >   On Fri, Jan 28, 2022 at 2:45 PM Fangrui Song <maskray@google.com> wrote:
> >>
> >> On 2022-01-28, Elliot Berman wrote:
> >>> Allow additional arguments be passed to userprogs compilation.
> >>> Reproducible clang builds need to provide a sysroot and gcc path to
> >>> ensure same toolchain is used across hosts. KCFLAGS is not currently
> >>> used for any user programs compilation, so add new USERCFLAGS and
> >>> USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
> >>>
> >>> Specifically, I'm trying to force CC_CAN_LINK to consistently fail in
> >>> an environment where a user sysroot is not specifically available.
> >>> Currently, Clang might automatically detect GCC installation on hosts
> >>> which have it installed to a default location in /. With addition of
> >>> these environment variables, you can specify flags such as:
> >>>
> >>> $ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null
> >>>
> >>> to force sysroot detection to fail.
> >>
> >> -Wl,--sysroot=/dev/null => --sysroot
> >>
> >> As I mentioned in
> >> https://lore.kernel.org/all/20220128031549.w5a4bilxbkppagfu@google.com/
> >> -Wl,--sysroot=/dev/null does not suppress search paths like -L/lib .
> >
> > In that case, Elliot, can you please test whether USERLDFLAGS is
> > necessary to be specified AT ALL? Maybe we can drop that addition from
> > this patch if so?
>
> USERLDFLAGS as --sysroot=/dev/null isn't necessary and not needed for
> the Android kernel usecase. I've included here since we have HOSTLDFLAGS
> and LDFLAGS for host programs and kernel respectively.
>

Ok, for symmetry it's ok to keep HOSTLDFLAGS, consider dropping it
from the "example" in the commit message. The note about -Wl, prefixes
exists in the docs now which is good enough for me.
-- 
Thanks,
~Nick Desaulniers
