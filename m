Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6675014A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244669AbiDNNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244219AbiDNN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:26:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C03E9E9CE;
        Thu, 14 Apr 2022 06:19:55 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.96.207]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Frd-1ncUUo06fH-006M6Y; Thu, 14 Apr 2022 15:16:41 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id F148D3C07B;
        Thu, 14 Apr 2022 15:16:38 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 176FB489; Thu, 14 Apr 2022 15:09:43 +0200 (CEST)
Date:   Thu, 14 Apr 2022 15:09:43 +0200
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
Message-ID: <YlgdF9qmJyYGHKXZ@bergen.fjasle.eu>
References: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com>
 <20220408084607.106468-1-ydroneaud@opteya.com>
 <CAK7LNAQZLt_OecOogOQiSu5snW+sffsMoFgVcjPTx_idj_=_tQ@mail.gmail.com>
 <CAKwvOd=yNnKsHJo0QWvoTuFF9p-y=cTftTD+7FY-wJ_f23zFTQ@mail.gmail.com>
 <81585705-6ed8-12e5-1355-332a6a5d2b17@infradead.org>
 <CAK7LNAS6ap9dR=kzRgQgt+d7FBBbVrwEqGU9g_pFD+nzMUt+gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAS6ap9dR=kzRgQgt+d7FBBbVrwEqGU9g_pFD+nzMUt+gQ@mail.gmail.com>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:VTplRYcqIA5m2LMYqAqfH7kOd6LlSKl27R7wPnUpoSX7DH+yGlI
 RdfbT5Dvgi1MV94r997k8qAfnPAh9w/CQ3C7C0GRNvpCsdEA1pn71/H/o3GPfzye/76CSfx
 dIl8ftEj0I1iuA5ikapiNgX2Rdtf7LnynYC9QbICwSIRgg9t/qJN91tNKyqipzTSYZgwRyU
 H9kv5Re/u8EPsrx8a1Tjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:frxQrqfiJnI=:fPuItlHpxR50/T1pphQzzo
 YNfmgEBLM2Wulpvd6R7Yycyca81nrmYHvKCdFb4vLTkH0Tw8APtUX7ZI/3O2VsVUDUjbbnUbz
 19UhkPEzJHAa9XUhhvEafoUgtKDuEZ9Jqgpo1RQK6ASk6yxu2lwKY4r5WS45MngI9Oa/MGyPm
 s2jpq4OkSPTS40K+3kZbPFRlE2CltVwT38uKO1zbui6HA91gLNY6ftVFKi0S/AySx5h9eLZzj
 8tw6dwkL/HL6YNB9P0Wg6zcfyTdaRT5aabguMW+viGWLJN8QSEQgQ9hv7NCah2mLs3hPgdsbK
 wEzuWvmjFcnHtl5CJLx/25MRinnqPUfb89GhAXAR4LL9J2lSuASkrlJta8SS40JmWEpgTuyOK
 JodFVro5mQ3TBRh47F0yMhHqp5KfoiIqDAULNDS3TVWYs5eD2nLMG97xJgpOWLCGB4UfsCUnr
 n4dHxnI2Y9I4Whm1ZNJU0BjEGsp94Czcyui58oOQo9h0MtJM6aWiryQCRfbPRNggqL/NP4q1+
 n66vqIYQDyn19VmKIJccd0q8zzYDaL573K87fY1gxziLJjEWkgTTdkvwmIslAPExDxXnis2eQ
 NJqgkhuWJwPG2y/FwUyhobYrrWHud9wj8nE9QXAlvJys6kMDuQG6WBS7Q3ufCQ/NXwXHIXRSq
 8LAfQO7c3SAJUri3ZYauvPUH3zCuIohyXQ7u7UmFRdfliHg+2bsEnuxrWS5vy1zxDo74=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

På lø. 09. april 2022 kl. 10.47 +0000 skrev Masahiro Yamada:
> On Sat, Apr 9, 2022 at 5:36 AM Randy Dunlap <rdunlap@infradead.org> Wrote:
> >
> >
> >
> > On 4/8/22 13:29, Nick Desaulniers wrote:
> > > On Fri, Apr 8, 2022 at 4:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >>
> > >> On Fri, Apr 8, 2022 at 5:46 PM Yann Droneaud <ydroneaud@opteya.com> wrote:
> > >>>
> > >>> When developing new code/feature, CONFIG_WERROR is most
> > >>> often turned off, especially for people using make W=12 to
> > >>> get more warnings.
> > >>>
> > >>> In such case, turning on -Werror temporarily would require
> > >>> switching on CONFIG_WERROR in the configuration, building,
> > >>> then switching off CONFIG_WERROR.
> > >>>
> > >>> For this use case, this patch introduces a new 'e' modifier
> > >>> to W= as a short hand for KCFLAGS+=-Werror" so that -Werror
> > >>> got added to the kernel (built-in) and modules' CFLAGS.
> > >>>
> > >>> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> > >>> ---
> > >>>  Makefile                   |  1 +
> > >>>  scripts/Makefile.extrawarn | 13 +++++++++++--
> > >>>  2 files changed, 12 insertions(+), 2 deletions(-)
> > >>>
> > >>> Changes since v0[0]:
> > >>>
> > >>>  - rebase on top of commit 64a91907c896 ("kbuild: refactor scripts/Makefile.extrawarn")
> > >>>  - document use case after commit 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
> > >>>
> > >>> [0] https://lore.kernel.org/all/1422803720-14723-1-git-send-email-ydroneaud@opteya.com/
> > >>
> > >>
> > >> I remembered the previous submission, I liked it, but I had lost it.
> > >>
> > >> It seems already 7 years ago, (before I became the Kbuild maintainer).
> > >> Thanks for coming back to this.
> > >>
> > >>
> > >> I like this, but I will wait some time for review comments.
> > >
> > > Dunno, this seems pretty simple:
> > >
> > > $ ./scripts/config -e WERROR
> > > $ make ... W=12
> >
> > Yeah, that's about what I was thinking too..
> 
> 
> 
> But, you cannot change the .config
> when you build external modules.
> 
> "make W=e" might be useful for people who strive to
> keep their downstream modules warning-free.
> 
> 
> W=e is the same pattern.
> I do not see much downside.

If I set CONFIG_WERROR=y on the make command line, I could have the 
same result, don't I?

  make CONFIG_WERROR=1 ...

no matter if in-tree or for external kernel modules.

Kind regards,
Nicolas
