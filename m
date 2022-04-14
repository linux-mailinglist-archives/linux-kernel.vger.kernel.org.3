Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F258B501C75
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346191AbiDNURt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243237AbiDNURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:17:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8142BEB08C;
        Thu, 14 Apr 2022 13:15:15 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.96.207]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MJm8H-1nLeGJ0fAv-00K4sE; Thu, 14 Apr 2022 22:14:10 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id F0BAE3C09D; Thu, 14 Apr 2022 22:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1649967248; bh=Y5+nnmHzcrg7jFOuw1SkjjKBoEj4u51ooH34L5VRHzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfvBI+2jVnexVnxkHPw4UkgVzyvDVQAUkhCA7Ie0nUitCMGPKveYkFhvNZyfhMZ3A
         0u7dRSRqiOx89iXnNYasbUqLKyQKkgIcQEpaGATkufgj8da/hy75UO8B7Rz4MH4DDI
         x/g/UR90CXCymJrlptlgvBsbbHSZ0TxrFWOBLu1A=
Date:   Thu, 14 Apr 2022 22:14:07 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv1] kbuild: support W=e to make build abort in case of
 warning
Message-ID: <YliAjz/OwW5kXx+r@fjasle.eu>
References: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com>
 <20220408084607.106468-1-ydroneaud@opteya.com>
 <CAK7LNAQZLt_OecOogOQiSu5snW+sffsMoFgVcjPTx_idj_=_tQ@mail.gmail.com>
 <CAKwvOd=yNnKsHJo0QWvoTuFF9p-y=cTftTD+7FY-wJ_f23zFTQ@mail.gmail.com>
 <81585705-6ed8-12e5-1355-332a6a5d2b17@infradead.org>
 <CAK7LNAS6ap9dR=kzRgQgt+d7FBBbVrwEqGU9g_pFD+nzMUt+gQ@mail.gmail.com>
 <YlgdF9qmJyYGHKXZ@bergen.fjasle.eu>
 <CAK7LNARVKL4vCRHz5=_sW_oBpkpqhDu5Hp1hfG+Hnwqg-61HVA@mail.gmail.com>
 <YlhfMqQ+ypf4OdkN@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlhfMqQ+ypf4OdkN@fjasle.eu>
X-Provags-ID: V03:K1:Y6ud/MyDh4zcSOf3AEgV/WM8ljaiaEjH28dpuDMiBnEg4M6iLvg
 fcI4bA5LaLldtv51wqF9HL4STHwDFGZuPsnh+dm9lrMdWGP6Thw0xyMFUFclqWC1O2oJwxA
 mo2eE8dUiIldIsaQnS7lpqOZ6RI9C4Vh2oayHwOb23TOpdacx1XAMXtO4+jrxO1DmE6inbd
 sahZPt/H2EDeryyO5nWDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6q18BLTH5Us=:jlm4YMwsE9JQ6htF4M899Q
 CcPaYW5Ge6ibVrhvAcAEy0bay8ZTd72NvyXC8zv/yL+hgGHcwwlKf2Hux/CDtZJl5IaYWQSDR
 /gBoxVo4HwzznjVA/p/sEI1BVQBMumIacuve23loknJhUSSyIbuugxNpv7mgRkMvRdnODuiv9
 4pfUIZ1mbzcweYRGPf7WdfAwgOQmq4baSN8PZzU2JlhyPS8IfDYn4TDsS9yoIonAo5av4C7ZV
 mGvu+zYa//diH0dt1SI1En3D5+Dtwpi5vCYO7+FEQNKjdOjnAVvUyqhMz6ni0WMz2Rv4y4l+m
 2xdTL6AwsZNZu7i3e95puXOJhPh2e0YGlV239IxyTlZ+cQC1S7IhfRWl0x0txcct1FAF+jaHH
 TzV1b1mHvETCjIW5bQQWyS+HZCW+ucXRzS1svUKMGjgBxZbPeidsyT37uYx8aUmThXIBBfKEf
 lszf+PE4l08TegKFf/y0HTc9ZG9utbs14rYKJr9zSG021tIo3yJQ687132jdfOmLnRCvMDVZc
 L+VHz99csyTLKncy6di2Hz9RNB04AsK7d5WoK6g1h3kRE6cy3usXPdDqoDtvnuAlzoA1kDa3I
 2UaG8Fsynp1pJZrvLRAZfrZIJYfjIjiH7W4TDkzb3UzXPQ2JcU2/EvBbyEhbPPC+pCEG3eqXm
 yqpoc9qcLB2S/XkjfLDhgPQfwSCiLpreou9wQYzPjU9MHmaZ1Q+Md2TpEHkg75bvic28=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 07:51:46PM +0200 Nicolas Schier wrote:
> On Fri, Apr 15, 2022 at 12:15:40AM +0900 Masahiro Yamada wrote:
> > On Thu, Apr 14, 2022 at 10:19 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
> > >
> > > På lø. 09. april 2022 kl. 10.47 +0000 skrev Masahiro Yamada:
> > > > On Sat, Apr 9, 2022 at 5:36 AM Randy Dunlap <rdunlap@infradead.org> Wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 4/8/22 13:29, Nick Desaulniers wrote:
> > > > > > On Fri, Apr 8, 2022 at 4:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > >>
> > > > > >> On Fri, Apr 8, 2022 at 5:46 PM Yann Droneaud <ydroneaud@opteya.com> wrote:
> > > > > >>>
> > > > > >>> When developing new code/feature, CONFIG_WERROR is most
> > > > > >>> often turned off, especially for people using make W=12 to
> > > > > >>> get more warnings.
> > > > > >>>
> > > > > >>> In such case, turning on -Werror temporarily would require
> > > > > >>> switching on CONFIG_WERROR in the configuration, building,
> > > > > >>> then switching off CONFIG_WERROR.
> > > > > >>>
> > > > > >>> For this use case, this patch introduces a new 'e' modifier
> > > > > >>> to W= as a short hand for KCFLAGS+=-Werror" so that -Werror
> > > > > >>> got added to the kernel (built-in) and modules' CFLAGS.
> > > > > >>>
> > > > > >>> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> > > > > >>> ---
> > > > > >>>  Makefile                   |  1 +
> > > > > >>>  scripts/Makefile.extrawarn | 13 +++++++++++--
> > > > > >>>  2 files changed, 12 insertions(+), 2 deletions(-)
> > > > > >>>
> > > > > >>> Changes since v0[0]:
> > > > > >>>
> > > > > >>>  - rebase on top of commit 64a91907c896 ("kbuild: refactor scripts/Makefile.extrawarn")
> > > > > >>>  - document use case after commit 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
> > > > > >>>
> > > > > >>> [0] https://lore.kernel.org/all/1422803720-14723-1-git-send-email-ydroneaud@opteya.com/
> > > > > >>
> > > > > >>
> > > > > >> I remembered the previous submission, I liked it, but I had lost it.
> > > > > >>
> > > > > >> It seems already 7 years ago, (before I became the Kbuild maintainer).
> > > > > >> Thanks for coming back to this.
> > > > > >>
> > > > > >>
> > > > > >> I like this, but I will wait some time for review comments.
> > > > > >
> > > > > > Dunno, this seems pretty simple:
> > > > > >
> > > > > > $ ./scripts/config -e WERROR
> > > > > > $ make ... W=12
> > > > >
> > > > > Yeah, that's about what I was thinking too..
> > > >
> > > >
> > > >
> > > > But, you cannot change the .config
> > > > when you build external modules.
> > > >
> > > > "make W=e" might be useful for people who strive to
> > > > keep their downstream modules warning-free.
> > > >
> > > >
> > > > W=e is the same pattern.
> > > > I do not see much downside.
> > >
> > > If I set CONFIG_WERROR=y on the make command line, I could have the
> > > same result, don't I?
> > >
> > >   make CONFIG_WERROR=1 ...
> > >
> > > no matter if in-tree or for external kernel modules.
> > 
> > Yes.
> > 
> > If you can change the kernel configuration,
> > you can enable CONFIG_WERROR.
> > 
> > To build external modules against the read-only
> > /lib/modules/$(uname -r)/build/,
> > it is not so feasible to change the .config file, though.
> 
> hm, I wanted to point out something different.  When I build an external module
> against a read-only kbuild-tree, I _can_ change kconfig values by specifying
> them on the make command line, just as I can add 'W=e':
> 
>   make -C /lib/modules/$(uname -r)/build M=~+ CONFIG_SAMPLE_KOBJECT=m CONFIG_WERROR=y
> 
> Thus, I suspect, that this is the very same as if I'd run
> 
>   make -C /lib/modules/$(uname -r)/build M=~+ CONFIG_SAMPLE_KOBJECT=m W=e
> 
> So, "W=e" is actually just a shortcut for "CONFIG_WERROR=1".  Or have I missed
> something?
> 
> Kind regards,
> Nicolas

oh, sorry.  Yann wrote it already in his commit message, please excuse the noise.

Kind regards,
Nicolas
