Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E569465F50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356084AbhLBIa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:30:57 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:32413 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbhLBIa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:30:56 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 1B28QxlN006678;
        Thu, 2 Dec 2021 17:26:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 1B28QxlN006678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1638433619;
        bh=/yQg01BYOJFXppdxBduRNih3r4B6OrrFie8TdUvWsH4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JXmvbWDwG9IKGlbZi3rbZ3DTGFqHrgLL6Wyi619NwvTKYg8SHvNOybbAxsGCdO5xu
         VbcVLiI7JlVuom+6954OzZVFHrAQQh7Q7TD8PIonFkZLHYzlRsyDyoW1Cq7Ii3YV3I
         a/aAQNHf7HDmnAqcUIJ9Ls+C3LZrzPL6OHxVVPyTlBfR4xBKOiKx30wsOTi2Zujxgf
         w6c/XhJ5i31O+1loPUWXpp85931taW/uJbfgZJKbCH/QqS8x3rD82cHMXE6Md/2ydt
         JfekgAj+MXdPlj3EW2wlizT7qgZgy8THxlcxRKRmU42qTVO+ObvwY/g34km16pYT9p
         b67OTJ/Qdxktg==
X-Nifty-SrcIP: [209.85.210.180]
Received: by mail-pf1-f180.google.com with SMTP id o4so27185407pfp.13;
        Thu, 02 Dec 2021 00:26:59 -0800 (PST)
X-Gm-Message-State: AOAM531WuF2zNyUTA5yII3D3aikMz6xZSxn0UtLyJHYZSgwkWdQkrM6B
        4sue8ZQM/9ElJ9FwOyR24Ts/iVAd6ujzS5t2V3k=
X-Google-Smtp-Source: ABdhPJxcPQ85vfjbSc2TTaMucoAVuXnzpKovoHhZYYdrtl4XmPNKKDlS6sEvhw15FBEyiNyupWGC01mqEQnCKEu0WzM=
X-Received: by 2002:a65:50c6:: with SMTP id s6mr8754532pgp.352.1638433618425;
 Thu, 02 Dec 2021 00:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20211129165803.470795-1-nathan@kernel.org> <202112011140.DA93B3E@keescook>
In-Reply-To: <202112011140.DA93B3E@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 2 Dec 2021 17:26:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASW2F3SxgR6ydMaW7-ZumsxDv2QQTDqVxqJA1JWN3r4FA@mail.gmail.com>
Message-ID: <CAK7LNASW2F3SxgR6ydMaW7-ZumsxDv2QQTDqVxqJA1JWN3r4FA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Bump minimum supported version of LLVM to 11.0.0
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tom Stellard <tstellar@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, cki-project@redhat.com,
        kernelci@groups.io, llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 4:41 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Nov 29, 2021 at 09:57:57AM -0700, Nathan Chancellor wrote:
> > This patch series raises the minimum supported version of LLVM to
> > 11.0.0.
> >
> > Patch #1 outlines the issue, goes over the potential impact of the
> > change, and does the actual bump. Subsequent patches clean up the
> > various checks that are always true after the bump.
> >
> > I have marked this revision as RFC to give various parties the option to
> > comment on this bump before it is done, namely KernelCI and Linaro's
> > LKFT, who are still testing clang-10. I have added some other folks to
> > CC that I know are testing with clang to see if this impacts them in any
> > way (as I would like to impact as few people as possible) but as far as
> > I am aware, most other CIs and developers are testing closer to tip of
> > tree. If that is not true, scream so that we can see what can be done
> > about that. If I missed anyone who is actively testing with clang,
> > please key them in and I will make sure to include them in future
> > revisions (if any are needed).
> >
> > It probably makes sense for this series to live in -mm.
>
> Sounds good to me. Thanks!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook


Only positive feedback so far.

All applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada
