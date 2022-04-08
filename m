Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4637E4F9E30
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiDHUbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiDHUbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:31:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F968BD2EF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:29:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a30so12854240ljq.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZrdFf2yh42JrHc2Dek+WObBYvTZikKF1XOl4wbzHjs=;
        b=lVvgZ8xLHBXTpDM+wZmf05pbYzXDDYFJUck/bcRj31lOoWi0SeIlLtxNJ8FIljVBlK
         Qqp5QgGws8wpwIEjsDGSJYMCz0SL87NgXL9GmQtcnmc6yTvkHf2aTbHrg9z8cJM/Doto
         vpiY0x7FlfFhh5pASFjGfs6uu9T5XsSZK+9GrDG5WPVOuNsxOLftZboRi1Wl61lrf94s
         zSEagVKiDnhil68YIOv7CuW/ZqIvpjG0GivpragadYpt9RBLtsiQCrzAjTye+Og8/pM9
         pLr3MK9NrkmxLxmQZNridF7aKHXLuU9TToR54QH8C6lnSE9G+B/Bp7WZ1km2kFyxb7jp
         TCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZrdFf2yh42JrHc2Dek+WObBYvTZikKF1XOl4wbzHjs=;
        b=MEaOadlG/PveiYt28GE30KRMC2MIMoyEWHAqTZ3iEgvvTN0ZirYrUDkCfgowBcm1Zs
         Ib4Gl/X+ffz0KvN4Io1VgjZVure93JADxvmPaDCpZxOY82leox7OgoXsj1V9pEFVbpw+
         R+QooRk9E2BAxv6TA7yQ0xeMrztf5aA05qUvs7zxiYkGwl9doHT2hVGbMN1pa/hsz0nY
         WF29sj75rHgzyi9kI7/rPTGMZbH36qnRBqEO6qemPY8goan5GwROAhNbi+SO+N+yn2QP
         YJyunp0bK4BKNYsPVOV5go73ubOZ2IQbPkDxGisSv7Dy14/EoVeRAcGf1z5yu9slvTwz
         r0og==
X-Gm-Message-State: AOAM531nW2pPVJuf1Z6G/PebUZfn9yekCbsEU02+Mvc0b6uw9Ehb4pHI
        rDSGR38ZrAVaG+QraG+Ycy6JS4gKD+Ts8s7XtNciICI/txA=
X-Google-Smtp-Source: ABdhPJxH3D8gXPBoV4TSDcjzoHzG6H+bMKJDFDSrEQDpRK80a/mazb9kGKiK8ZFBujQSP4LFFtjxw9PdktULlxVPdL4=
X-Received: by 2002:a05:651c:19a8:b0:249:a7f3:25e7 with SMTP id
 bx40-20020a05651c19a800b00249a7f325e7mr12377184ljb.352.1649449767522; Fri, 08
 Apr 2022 13:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com>
 <20220408084607.106468-1-ydroneaud@opteya.com> <CAK7LNAQZLt_OecOogOQiSu5snW+sffsMoFgVcjPTx_idj_=_tQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQZLt_OecOogOQiSu5snW+sffsMoFgVcjPTx_idj_=_tQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Apr 2022 13:29:16 -0700
Message-ID: <CAKwvOd=yNnKsHJo0QWvoTuFF9p-y=cTftTD+7FY-wJ_f23zFTQ@mail.gmail.com>
Subject: Re: [PATCHv1] kbuild: support W=e to make build abort in case of warning
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 4:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Apr 8, 2022 at 5:46 PM Yann Droneaud <ydroneaud@opteya.com> wrote:
> >
> > When developing new code/feature, CONFIG_WERROR is most
> > often turned off, especially for people using make W=12 to
> > get more warnings.
> >
> > In such case, turning on -Werror temporarily would require
> > switching on CONFIG_WERROR in the configuration, building,
> > then switching off CONFIG_WERROR.
> >
> > For this use case, this patch introduces a new 'e' modifier
> > to W= as a short hand for KCFLAGS+=-Werror" so that -Werror
> > got added to the kernel (built-in) and modules' CFLAGS.
> >
> > Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> > ---
> >  Makefile                   |  1 +
> >  scripts/Makefile.extrawarn | 13 +++++++++++--
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > Changes since v0[0]:
> >
> >  - rebase on top of commit 64a91907c896 ("kbuild: refactor scripts/Makefile.extrawarn")
> >  - document use case after commit 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
> >
> > [0] https://lore.kernel.org/all/1422803720-14723-1-git-send-email-ydroneaud@opteya.com/
>
>
> I remembered the previous submission, I liked it, but I had lost it.
>
> It seems already 7 years ago, (before I became the Kbuild maintainer).
> Thanks for coming back to this.
>
>
> I like this, but I will wait some time for review comments.

Dunno, this seems pretty simple:

$ ./scripts/config -e WERROR
$ make ... W=12
-- 
Thanks,
~Nick Desaulniers
