Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A255073E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 00:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiFRWNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 18:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiFRWNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 18:13:33 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA083265E;
        Sat, 18 Jun 2022 15:13:30 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 25IMD8iG007387;
        Sun, 19 Jun 2022 07:13:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 25IMD8iG007387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655590389;
        bh=7jwbvyrhQLV+4aegmk22DRd9SYJoD6/Ana8x4b/1QLk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HMFT5yD4HPzN0/ok5qxydwtXHQ/zhALcx64F9y1ip3MY6bbwMhcN7cQZ7CNF9HYQp
         od4k1EOCwEwtaYVr8vDt/jOKNXuujz4L2xAIz7rI8Cu+fHoC/86KZCa0YgO3F4iHWu
         gt88uw2M1ibhIDrgPZlwHHNrx7BG6/iLMDcfhB13MjRX+t7Nq+WyHFL4TpnoYhvqKN
         zLanyNywu11ddt+7IAuOb3DlNOi1E35e58XzTFcjzGek1DxCWghlBRruFIMtBS5rsm
         b7139uVNXxh9zUjilp1WZAbXrwyCx3lb10aGD8HYcQMlp+MNQAExP0lmIpWhtSN7up
         yy3tnTkOPmK5A==
X-Nifty-SrcIP: [209.85.221.50]
Received: by mail-wr1-f50.google.com with SMTP id g4so9839701wrh.11;
        Sat, 18 Jun 2022 15:13:09 -0700 (PDT)
X-Gm-Message-State: AJIora/S/9tmwtuJxPrjPXuWdl+K0GETTbwicPs3OWPAuFgvA6818z91
        qa0mQ57gX3XHgFZVgVtHKWPSnoxVAI0lB/gQReQ=
X-Google-Smtp-Source: AGRyM1sML4k/551cdhdkCWZlW1l3J3kC8wOqKO/VYoNqgy7eljBeD2d9mRgOZD6mP5Qa9NRBtiZhiYtiGyCKEx6860c=
X-Received: by 2002:a5d:5e92:0:b0:21a:278c:b901 with SMTP id
 ck18-20020a5d5e92000000b0021a278cb901mr15492125wrb.461.1655590387823; Sat, 18
 Jun 2022 15:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-2-masahiroy@kernel.org> <58a20890-557e-f31c-ed59-7e256445a26c@digikod.net>
 <YqopiZgC8vNSKYPt@iki.fi>
In-Reply-To: <YqopiZgC8vNSKYPt@iki.fi>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Jun 2022 07:12:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSYSupt1nL_JS2prLunRpOhMRG_pPhHfto7+K+QDVp2Q@mail.gmail.com>
Message-ID: <CAK7LNARSYSupt1nL_JS2prLunRpOhMRG_pPhHfto7+K+QDVp2Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] certs: fix and refactor CONFIG_SYSTEM_BLACKLIST_HASH_LIST
 build
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 3:51 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 02:34:36PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> >
> >
> > On 11/06/2022 19:22, Masahiro Yamada wrote:
> > > Commit addf466389d9 ("certs: Check that builtin blacklist hashes are
> > > valid") was applied 8 months after the submission.
> > >
> > > In the meantime, the base code had been removed by commit b8c96a6b466=
c
> > > ("certs: simplify $(srctree)/ handling and remove config_filename
> > > macro").
> > >
> > > Fix the Makefile.
> > >
> > > Create a local copy of $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST). It is
> > > included from certs/blacklist_hashes.c and also works as a timestamp.
> > >
> > > Send error messages from check-blacklist-hashes.awk to stderr instead
> > > of stdout.
> > >
> > > Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are =
valid")
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Reviewed-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >
> > As a side note, it may let an orphan certs/blacklist_hashes_checked fil=
e but
> > we can't really do something about that and it's OK.
> >
> > Thanks!
> >
> > > ---
> > >
> > >   certs/.gitignore         |  2 +-
> > >   certs/Makefile           | 20 ++++++++++----------
> > >   certs/blacklist_hashes.c |  2 +-
> > >   3 files changed, 12 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/certs/.gitignore b/certs/.gitignore
> > > index 56637aceaf81..cec5465f31c1 100644
> > > --- a/certs/.gitignore
> > > +++ b/certs/.gitignore
> > > @@ -1,5 +1,5 @@
> > >   # SPDX-License-Identifier: GPL-2.0-only
> > > -/blacklist_hashes_checked
> > > +/blacklist_hash_list
> > >   /extract-cert
> > >   /x509_certificate_list
> > >   /x509_revocation_list
> > > diff --git a/certs/Makefile b/certs/Makefile
> > > index cb1a9da3fc58..a8d628fd5f7b 100644
> > > --- a/certs/Makefile
> > > +++ b/certs/Makefile
> > > @@ -7,22 +7,22 @@ obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) +=3D system_ke=
yring.o system_certificates.o c
> > >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist.o common.o
> > >   obj-$(CONFIG_SYSTEM_REVOCATION_LIST) +=3D revocation_certificates.o
> > >   ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
> > > -quiet_cmd_check_blacklist_hashes =3D CHECK   $(patsubst "%",%,$(2))
> > > -      cmd_check_blacklist_hashes =3D $(AWK) -f $(srctree)/scripts/ch=
eck-blacklist-hashes.awk $(2); touch $@
> > > -$(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
> > > +$(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
> > > +CFLAGS_blacklist_hashes.o :=3D -I $(obj)
> > > -$(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
> > > +quiet_cmd_check_and_copy_blacklist_hash_list =3D GEN     $@
> > > +      cmd_check_and_copy_blacklist_hash_list =3D \
> > > +   $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_=
SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> > > +   cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
> > > -CFLAGS_blacklist_hashes.o +=3D -I$(srctree)
> > > -
> > > -targets +=3D blacklist_hashes_checked
> > > -$(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPRE=
FIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.a=
wk FORCE
> > > -   $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_=
LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
> > > +$(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FOR=
CE
> > > +   $(call if_changed,check_and_copy_blacklist_hash_list)
> > >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_hashes.o
> > >   else
> > >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_nohashes.o
> > >   endif
> > > +targets +=3D blacklist_hash_list
> > >   quiet_cmd_extract_certs  =3D CERT    $@
> > >         cmd_extract_certs  =3D $(obj)/extract-cert $(extract-cert-in)=
 $@
> > > @@ -33,7 +33,7 @@ $(obj)/system_certificates.o: $(obj)/x509_certifica=
te_list
> > >   $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/=
extract-cert FORCE
> > >     $(call if_changed,extract_certs)
> > > -targets +=3D x509_certificate_list blacklist_hashes_checked
> > > +targets +=3D x509_certificate_list
> > >   # If module signing is requested, say by allyesconfig, but a key ha=
s not been
> > >   # supplied, then one will need to be generated to make sure the bui=
ld does not
> > > diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> > > index d5961aa3d338..86d66fe11348 100644
> > > --- a/certs/blacklist_hashes.c
> > > +++ b/certs/blacklist_hashes.c
> > > @@ -2,6 +2,6 @@
> > >   #include "blacklist.h"
> > >   const char __initconst *const blacklist_hashes[] =3D {
> > > -#include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
> > > +#include "blacklist_hash_list"
> > >     , NULL
> > >   };
>
> I'll make a PR for 1/4 and 2/4 so that they get into 5.19.
>
> BR, Jarkko


Thank you!

What shall we do for 3/4 and 4/4?

Do you have a plan to queue them up for the next MW?

Or, shall I apply them to my kbuild tree with your reivewed-by?




--=20
Best Regards
Masahiro Yamada
