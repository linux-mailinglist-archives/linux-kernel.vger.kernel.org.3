Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE5543C5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiFHTGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiFHTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:06:24 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222CE4AE0C;
        Wed,  8 Jun 2022 12:03:49 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id a10so19873521ioe.9;
        Wed, 08 Jun 2022 12:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=uHvO6lASenJXAwmtol028iE9jl3QIf1MGNf5sYAD2mI=;
        b=mCzgaJ5RtUYhEB7TvHlxTBehiR1oOVyn5iAnL2NYhYfUTBEpRGyLQQIlfu/Pkjp41N
         d+ToihCuCXnhN/EOcOn4VXOJd0D2nUFMx8b2ynE7wq8VLYDAbts2Fqlsypxa0BjUGTJI
         OC2AzPMxMVPfXZVcC1kngUyf8XdkfJfMcx2BeyhsBP/8eVfjWejkDpY6R4G8wQjBo9C0
         u6pGK9zoPI39Shrk2R7FLhiQDdA59H3KPEPk1ubgMoO9ml86fC98s5w5UNeXe96sMU7X
         UA0kJzEDY0GdGSyTDxFv7l1QzrGPLcGEIgCeipt6Lnf/ExBnQ3zWOEWw1OJIuSicWkD7
         0mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=uHvO6lASenJXAwmtol028iE9jl3QIf1MGNf5sYAD2mI=;
        b=MEn+LBr1yIYwU4SxjHSedzvsCJZMqypWwIzAe/w3PZek1yihDTKQP9ihyHnLnitiu8
         3/5vdq5mOWYERVuD4oYSw1smH6abdUHDrxV3J3ntFqHsDWh06t4DBhYfHrbP7JuUl9Pd
         /vybifgoI0l0Vgagn/q5JU6Y2RV2dh536nTkT+RRl+O0Au98nzyWq9hzWrsD8si4HRPQ
         9g225nDTXZKgyib3jIyXn9fdQhwtlUUQMuS48QmJ4vgrdZdwc231BQLG4014cntgIzyM
         NZMe48KnHTfu3I/ZRy5HS+Ti+7uK8cOCY2vpaF1Xe++LClU1a7yywM7BEWFKeOZbrcvn
         8ncg==
X-Gm-Message-State: AOAM533nfN21469GZHKywSMGt+Pe4+pZk6meJPpYxR/U+lewRMYn8hre
        2J84Kha/yWeNjHd0LvM518Fyn/PNOrCbcNS6RSPzierx4OA=
X-Google-Smtp-Source: ABdhPJyPfBPW81UGtdc6N58+KH5F9Ju0Yh1bhwA/dhd1CNQBi4oFOkgVajdsRbnFlopI7Jcb7mSItJulOzBqKQr6Sc0=
X-Received: by 2002:a05:6638:2188:b0:331:cf8b:af23 with SMTP id
 s8-20020a056638218800b00331cf8baf23mr5436095jaj.80.1654715021475; Wed, 08 Jun
 2022 12:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220607164000.447941-1-masahiroy@kernel.org> <CAKwvOdk5ZrcSmQSPrFzreZ-z_Hpi4Lc-D-Y4NDuHPiUWpXdwzA@mail.gmail.com>
In-Reply-To: <CAKwvOdk5ZrcSmQSPrFzreZ-z_Hpi4Lc-D-Y4NDuHPiUWpXdwzA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 8 Jun 2022 21:03:05 +0200
Message-ID: <CA+icZUUZ0_92vDofYkgG3QzyuhC3wABwdT16ZPbH=92_0pGoRQ@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/check-local-export: avoid 'wait $!' for
 process substitution
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 8:42 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Jun 7, 2022 at 9:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Bash>=4.4 supports 'wait $!' to check the exit status of a process
> > substitution, but some people using older bash versions reported an
> > error like this:
> >
> > Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> > Tested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)

-Sedat-

> Some comments below.
>
> > diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> > index 34415ae1af1b..19c286c23786 100644
> > --- a/Documentation/process/changes.rst
> > +++ b/Documentation/process/changes.rst
> > @@ -32,6 +32,7 @@ you probably needn't concern yourself with pcmciautils.
> >  GNU C                  5.1              gcc --version
> >  Clang/LLVM (optional)  11.0.0           clang --version
> >  GNU make               3.81             make --version
> > +bash                   4.2              bash --version
>
> /usr/bin/env bash
> and definitely /bin/bash
> both show up a lot in kernel sources. At this point, I think bash is a
> requirement at this point, so it's good to document it finally.
>
> > +# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm) shows
> > +# 'no symbols' diagnostic (but exits with 0). It is harmless and hidden by
> > +# '2>/dev/null'. However, it suppresses real error messages as well. Add a
> > +# hand-crafted error message here.
> > +#
> > +# Use --quiet instead of 2>/dev/null when we upgrade the minimum version of
> > +# binutils to 2.37, llvm to 13.0.0.
>
> Might be nice to include `TODO:` in the comment block. Vim will
> highlight these in comments.
>
> --
> Thanks,
> ~Nick Desaulniers
