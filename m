Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9B94FA169
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbiDIBvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiDIBvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:51:14 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2138DB3;
        Fri,  8 Apr 2022 18:49:06 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2391mnuC020059;
        Sat, 9 Apr 2022 10:48:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2391mnuC020059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649468930;
        bh=+B+buYCd5DTvQhQP1G5l8ktKEW8nJuwsrG2dTasBNH0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=srh3uR511AVfrMG43JNh/vm2ReLdtOahBCGuTN94aq3s1vWBRtCqfCJjU9ghdtJe6
         XfIWy0CeXiDz5XAnuupBNQozAcYGH9woTSOGyEbxWUaLFNSZvO4U2FDhrbjAFzq46c
         eUoSfKd3CPs9A7QR3YTWlpJa7ihrXK+uPWxQa5SP4n8mBF3PbPu+b6ehBg3HoMpGRy
         jQ8DU6HVJIm+q8i9DxPq5pbjX64iqssfdKIHZYOhQ8gQjKn5VipEUPoOnDYOmc89HV
         vcOvW3YWPxLH8tLku2JnJbPvVkYy80GzpVGKUh7Rv79HwADqRqCCnBlf9y2D2N5ZnQ
         Ya0NihWhO3aGg==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id s11so9387095pla.8;
        Fri, 08 Apr 2022 18:48:49 -0700 (PDT)
X-Gm-Message-State: AOAM532FBthVPhumYcjUFI7oiw9H9tRiEWT1wU6U2YTumL8BREFyjUyk
        ruEa5BKcoclIniVxGz+2GhSNDTtF52SFhcbOgVw=
X-Google-Smtp-Source: ABdhPJwAQC4deYv2JbUmCqjSjnLk6E9HyaUW/roSKUMl6e3YSuhIIR7w5nsF1pZK3Z3LxjKmVprrwC2yviY1FX3PYX8=
X-Received: by 2002:a17:90b:4d01:b0:1c9:ec79:1b35 with SMTP id
 mw1-20020a17090b4d0100b001c9ec791b35mr24380946pjb.77.1649468928961; Fri, 08
 Apr 2022 18:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com>
 <20220408084607.106468-1-ydroneaud@opteya.com> <CAK7LNAQZLt_OecOogOQiSu5snW+sffsMoFgVcjPTx_idj_=_tQ@mail.gmail.com>
 <CAKwvOd=yNnKsHJo0QWvoTuFF9p-y=cTftTD+7FY-wJ_f23zFTQ@mail.gmail.com> <81585705-6ed8-12e5-1355-332a6a5d2b17@infradead.org>
In-Reply-To: <81585705-6ed8-12e5-1355-332a6a5d2b17@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 9 Apr 2022 10:47:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6ap9dR=kzRgQgt+d7FBBbVrwEqGU9g_pFD+nzMUt+gQ@mail.gmail.com>
Message-ID: <CAK7LNAS6ap9dR=kzRgQgt+d7FBBbVrwEqGU9g_pFD+nzMUt+gQ@mail.gmail.com>
Subject: Re: [PATCHv1] kbuild: support W=e to make build abort in case of warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 5:36 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 4/8/22 13:29, Nick Desaulniers wrote:
> > On Fri, Apr 8, 2022 at 4:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >>
> >> On Fri, Apr 8, 2022 at 5:46 PM Yann Droneaud <ydroneaud@opteya.com> wrote:
> >>>
> >>> When developing new code/feature, CONFIG_WERROR is most
> >>> often turned off, especially for people using make W=12 to
> >>> get more warnings.
> >>>
> >>> In such case, turning on -Werror temporarily would require
> >>> switching on CONFIG_WERROR in the configuration, building,
> >>> then switching off CONFIG_WERROR.
> >>>
> >>> For this use case, this patch introduces a new 'e' modifier
> >>> to W= as a short hand for KCFLAGS+=-Werror" so that -Werror
> >>> got added to the kernel (built-in) and modules' CFLAGS.
> >>>
> >>> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> >>> ---
> >>>  Makefile                   |  1 +
> >>>  scripts/Makefile.extrawarn | 13 +++++++++++--
> >>>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>>
> >>> Changes since v0[0]:
> >>>
> >>>  - rebase on top of commit 64a91907c896 ("kbuild: refactor scripts/Makefile.extrawarn")
> >>>  - document use case after commit 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
> >>>
> >>> [0] https://lore.kernel.org/all/1422803720-14723-1-git-send-email-ydroneaud@opteya.com/
> >>
> >>
> >> I remembered the previous submission, I liked it, but I had lost it.
> >>
> >> It seems already 7 years ago, (before I became the Kbuild maintainer).
> >> Thanks for coming back to this.
> >>
> >>
> >> I like this, but I will wait some time for review comments.
> >
> > Dunno, this seems pretty simple:
> >
> > $ ./scripts/config -e WERROR
> > $ make ... W=12
>
> Yeah, that's about what I was thinking too..



But, you cannot change the .config
when you build external modules.

"make W=e" might be useful for people who strive to
keep their downstream modules warning-free.


W=e is the same pattern.
I do not see much downside.



(BTW, I do not like CONFIG_WERROR.)






-- 
Best Regards
Masahiro Yamada
