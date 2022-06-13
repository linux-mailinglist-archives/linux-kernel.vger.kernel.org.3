Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C49D549BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbiFMShK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243819AbiFMSgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:36:49 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB78D0283;
        Mon, 13 Jun 2022 07:56:26 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 25DEtxY8031566;
        Mon, 13 Jun 2022 23:56:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 25DEtxY8031566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655132161;
        bh=F7E1ooLwJvZaNNuNVEpt9SOkSdikaNq0G7A5Jym3rdc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zeCOZCT/q0yOoPvEZy8qLM7OV0T7nV5M5lYdJLOiX4EML5vhpT0svT0LD802O95t3
         bc5dHdE5CYW7yhR2NemElaneklJO73cqdJsKMwzInQwB6qu/uWHKgxwzQ4rtk1Dcs3
         AmVkXWF97r3EHuVULO+CvFXZF4NIKaDQsDjJND9xH6FK/TREz5UBnXXLwPoysvQXu5
         4M10a3Wx+zjZ9WpH8vG0YVGuRZ56V3UyiKhEISS5PU9fwgdZ8Vhf2X4spYTl8CGq9F
         7Zxnb6MqlttgnI8MRR4ZDAzvXfQjClAcaJuP/PIHlWaL/l5UkpxTHeBtyGPBQN+a4Y
         k9wlr1AF7Epsg==
X-Nifty-SrcIP: [209.85.221.53]
Received: by mail-wr1-f53.google.com with SMTP id h5so7525875wrb.0;
        Mon, 13 Jun 2022 07:56:00 -0700 (PDT)
X-Gm-Message-State: AJIora+8gym9FjzINGMO5O32V0dRlpk1HzsyUSvFtYLPoMaQhl21BJ8a
        32JRd0nNvOwQ+2T5xv1C/wqLJOfL1DPhN8CJb6U=
X-Google-Smtp-Source: AGRyM1uKAoKm86msS5f400EfHj3dFPo7TEojMgXqKbyoFmcd8UWeSFj46lIvK+Cgb4yr0bBkZxCSwsIpT9yxvEVeuC8=
X-Received: by 2002:a05:6000:1f09:b0:21a:5f3:316a with SMTP id
 bv9-20020a0560001f0900b0021a05f3316amr255199wrb.682.1655132158937; Mon, 13
 Jun 2022 07:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-2-masahiroy@kernel.org> <58a20890-557e-f31c-ed59-7e256445a26c@digikod.net>
In-Reply-To: <58a20890-557e-f31c-ed59-7e256445a26c@digikod.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 13 Jun 2022 23:55:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3p2XiLO7tJSJ9JWnqRomCwjYeQy-Z3j0m904Yn6Av_g@mail.gmail.com>
Message-ID: <CAK7LNAQ3p2XiLO7tJSJ9JWnqRomCwjYeQy-Z3j0m904Yn6Av_g@mail.gmail.com>
Subject: Re: [PATCH 2/4] certs: fix and refactor CONFIG_SYSTEM_BLACKLIST_HASH_LIST
 build
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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

On Mon, Jun 13, 2022 at 9:34 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
>
>
> On 11/06/2022 19:22, Masahiro Yamada wrote:
> > Commit addf466389d9 ("certs: Check that builtin blacklist hashes are
> > valid") was applied 8 months after the submission.
> >
> > In the meantime, the base code had been removed by commit b8c96a6b466c
> > ("certs: simplify $(srctree)/ handling and remove config_filename
> > macro").
> >
> > Fix the Makefile.
> >
> > Create a local copy of $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST). It is
> > included from certs/blacklist_hashes.c and also works as a timestamp.
> >
> > Send error messages from check-blacklist-hashes.awk to stderr instead
> > of stdout.
> >
> > Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are va=
lid")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Reviewed-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> As a side note, it may let an orphan certs/blacklist_hashes_checked file
> but we can't really do something about that and it's OK.


GNU Make uses timestamps of files for dependency tracking,
so Kbuild keeps all intermediate files.

Keeping certs/blacklist_hashes_checked
is the right thing to do.



> Thanks!
>
> > ---
> >
> >   certs/.gitignore         |  2 +-
> >   certs/Makefile           | 20 ++++++++++----------
> >   certs/blacklist_hashes.c |  2 +-
> >   3 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/certs/.gitignore b/certs/.gitignore
> > index 56637aceaf81..cec5465f31c1 100644
> > --- a/certs/.gitignore
> > +++ b/certs/.gitignore
> > @@ -1,5 +1,5 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> > -/blacklist_hashes_checked
> > +/blacklist_hash_list
> >   /extract-cert
> >   /x509_certificate_list
> >   /x509_revocation_list
> > diff --git a/certs/Makefile b/certs/Makefile
> > index cb1a9da3fc58..a8d628fd5f7b 100644
> > --- a/certs/Makefile
> > +++ b/certs/Makefile
> > @@ -7,22 +7,22 @@ obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) +=3D system_keyr=
ing.o system_certificates.o c
> >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist.o common.o
> >   obj-$(CONFIG_SYSTEM_REVOCATION_LIST) +=3D revocation_certificates.o
> >   ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
> > -quiet_cmd_check_blacklist_hashes =3D CHECK   $(patsubst "%",%,$(2))
> > -      cmd_check_blacklist_hashes =3D $(AWK) -f $(srctree)/scripts/chec=
k-blacklist-hashes.awk $(2); touch $@
> >
> > -$(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
> > +$(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
> > +CFLAGS_blacklist_hashes.o :=3D -I $(obj)
> >
> > -$(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
> > +quiet_cmd_check_and_copy_blacklist_hash_list =3D GEN     $@
> > +      cmd_check_and_copy_blacklist_hash_list =3D \
> > +     $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_=
SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> > +     cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
> >
> > -CFLAGS_blacklist_hashes.o +=3D -I$(srctree)
> > -
> > -targets +=3D blacklist_hashes_checked
> > -$(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFI=
X)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk=
 FORCE
> > -     $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_=
LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
> > +$(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
> > +     $(call if_changed,check_and_copy_blacklist_hash_list)
> >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_hashes.o
> >   else
> >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_nohashes.o
> >   endif
> > +targets +=3D blacklist_hash_list
> >
> >   quiet_cmd_extract_certs  =3D CERT    $@
> >         cmd_extract_certs  =3D $(obj)/extract-cert $(extract-cert-in) $=
@
> > @@ -33,7 +33,7 @@ $(obj)/system_certificates.o: $(obj)/x509_certificate=
_list
> >   $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/ex=
tract-cert FORCE
> >       $(call if_changed,extract_certs)
> >
> > -targets +=3D x509_certificate_list blacklist_hashes_checked
> > +targets +=3D x509_certificate_list
> >
> >   # If module signing is requested, say by allyesconfig, but a key has =
not been
> >   # supplied, then one will need to be generated to make sure the build=
 does not
> > diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> > index d5961aa3d338..86d66fe11348 100644
> > --- a/certs/blacklist_hashes.c
> > +++ b/certs/blacklist_hashes.c
> > @@ -2,6 +2,6 @@
> >   #include "blacklist.h"
> >
> >   const char __initconst *const blacklist_hashes[] =3D {
> > -#include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
> > +#include "blacklist_hash_list"
> >       , NULL
> >   };



--
Best Regards
Masahiro Yamada
