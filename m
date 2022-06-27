Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5316B55B4F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 03:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiF0B1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 21:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiF0B1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 21:27:09 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0A2AEA;
        Sun, 26 Jun 2022 18:27:05 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 25R1QooN004856;
        Mon, 27 Jun 2022 10:26:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 25R1QooN004856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656293211;
        bh=J7USUBBCE7lOKZu9YgsT0+UAz2YBfi4Cwfsxmytok2w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LBCVHIDAHqKYZbElonMxzd8AwubLAuq7UESGuLsulyYoua1d57/3zE0ovAlS7h4om
         I5NIYMxsjZExyCMmC7r0b5pRwgvhdCGWN3e3p1DJarDcgzewJMTyOAt8EoUN4K2w1l
         5Y0ufEuKRzlBdfCwVAxJlnw6Dh62lDyafuiVl+sjHSy790c0Vk5IMTLagzGMAcOUMl
         xkXW7UvRKaqSGHJB5S1Bh3Jm7ZBul7iQyrf0DvOTGkCo901w2wlCLyVjt9Swc16wij
         9L4uJrBpOPzPnz+EYrPJdtAjLLvU/k/DX068Y4d44fFm49najsrkFpc/SMVaQ+7/eU
         gI/AKnQgFB4YQ==
X-Nifty-SrcIP: [209.85.221.41]
Received: by mail-wr1-f41.google.com with SMTP id e28so5719058wra.0;
        Sun, 26 Jun 2022 18:26:51 -0700 (PDT)
X-Gm-Message-State: AJIora+TMMlwaNaktSZF5nHzidC/fm45hGclSbYWMz1DgCvk/WfQlRuy
        n6l/vYvsGNc6NdcC9foNqa2YOtkWRRDpqRQFkkY=
X-Google-Smtp-Source: AGRyM1u+9cSeFheF6odow0N/o7wovS5L8f1Q59BiPp8f4ZwalSRPPgKq01o7gcjahqMGPAzUcXzDpa8udfEx9TpqqSQ=
X-Received: by 2002:adf:e104:0:b0:21b:9938:b07a with SMTP id
 t4-20020adfe104000000b0021b9938b07amr9804261wrz.682.1656293209703; Sun, 26
 Jun 2022 18:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-2-masahiroy@kernel.org> <58a20890-557e-f31c-ed59-7e256445a26c@digikod.net>
 <YqopiZgC8vNSKYPt@iki.fi> <CAK7LNARSYSupt1nL_JS2prLunRpOhMRG_pPhHfto7+K+QDVp2Q@mail.gmail.com>
 <Yrf5wDBWKXCGGkxM@kernel.org>
In-Reply-To: <Yrf5wDBWKXCGGkxM@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 27 Jun 2022 10:26:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARA0OzE3UX6QdaCybZw6N0Sfa0uDCGNU+cV4hzKEf0wPA@mail.gmail.com>
Message-ID: <CAK7LNARA0OzE3UX6QdaCybZw6N0Sfa0uDCGNU+cV4hzKEf0wPA@mail.gmail.com>
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

On Sun, Jun 26, 2022 at 3:16 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Sun, Jun 19, 2022 at 07:12:31AM +0900, Masahiro Yamada wrote:
> > On Thu, Jun 16, 2022 at 3:51 AM Jarkko Sakkinen <jarkko@kernel.org> wro=
te:
> > >
> > > On Mon, Jun 13, 2022 at 02:34:36PM +0200, Micka=C3=ABl Sala=C3=BCn wr=
ote:
> > > >
> > > >
> > > > On 11/06/2022 19:22, Masahiro Yamada wrote:
> > > > > Commit addf466389d9 ("certs: Check that builtin blacklist hashes =
are
> > > > > valid") was applied 8 months after the submission.
> > > > >
> > > > > In the meantime, the base code had been removed by commit b8c96a6=
b466c
> > > > > ("certs: simplify $(srctree)/ handling and remove config_filename
> > > > > macro").
> > > > >
> > > > > Fix the Makefile.
> > > > >
> > > > > Create a local copy of $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST). It i=
s
> > > > > included from certs/blacklist_hashes.c and also works as a timest=
amp.
> > > > >
> > > > > Send error messages from check-blacklist-hashes.awk to stderr ins=
tead
> > > > > of stdout.
> > > > >
> > > > > Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes =
are valid")
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > >
> > > > Reviewed-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> > > >
> > > > As a side note, it may let an orphan certs/blacklist_hashes_checked=
 file but
> > > > we can't really do something about that and it's OK.
> > > >
> > > > Thanks!
> > > >
> > > > > ---
> > > > >
> > > > >   certs/.gitignore         |  2 +-
> > > > >   certs/Makefile           | 20 ++++++++++----------
> > > > >   certs/blacklist_hashes.c |  2 +-
> > > > >   3 files changed, 12 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/certs/.gitignore b/certs/.gitignore
> > > > > index 56637aceaf81..cec5465f31c1 100644
> > > > > --- a/certs/.gitignore
> > > > > +++ b/certs/.gitignore
> > > > > @@ -1,5 +1,5 @@
> > > > >   # SPDX-License-Identifier: GPL-2.0-only
> > > > > -/blacklist_hashes_checked
> > > > > +/blacklist_hash_list
> > > > >   /extract-cert
> > > > >   /x509_certificate_list
> > > > >   /x509_revocation_list
> > > > > diff --git a/certs/Makefile b/certs/Makefile
> > > > > index cb1a9da3fc58..a8d628fd5f7b 100644
> > > > > --- a/certs/Makefile
> > > > > +++ b/certs/Makefile
> > > > > @@ -7,22 +7,22 @@ obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) +=3D syste=
m_keyring.o system_certificates.o c
> > > > >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist.o common.=
o
> > > > >   obj-$(CONFIG_SYSTEM_REVOCATION_LIST) +=3D revocation_certificat=
es.o
> > > > >   ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
> > > > > -quiet_cmd_check_blacklist_hashes =3D CHECK   $(patsubst "%",%,$(=
2))
> > > > > -      cmd_check_blacklist_hashes =3D $(AWK) -f $(srctree)/script=
s/check-blacklist-hashes.awk $(2); touch $@
> > > > > -$(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
> > > > > +$(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
> > > > > +CFLAGS_blacklist_hashes.o :=3D -I $(obj)
> > > > > -$(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
> > > > > +quiet_cmd_check_and_copy_blacklist_hash_list =3D GEN     $@
> > > > > +      cmd_check_and_copy_blacklist_hash_list =3D \
> > > > > +   $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CON=
FIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> > > > > +   cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
> > > > > -CFLAGS_blacklist_hashes.o +=3D -I$(srctree)
> > > > > -
> > > > > -targets +=3D blacklist_hashes_checked
> > > > > -$(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SR=
CPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hash=
es.awk FORCE
> > > > > -   $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_H=
ASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
> > > > > +$(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST)=
 FORCE
> > > > > +   $(call if_changed,check_and_copy_blacklist_hash_list)
> > > > >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_hashes.o
> > > > >   else
> > > > >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_nohashes.=
o
> > > > >   endif
> > > > > +targets +=3D blacklist_hash_list
> > > > >   quiet_cmd_extract_certs  =3D CERT    $@
> > > > >         cmd_extract_certs  =3D $(obj)/extract-cert $(extract-cert=
-in) $@
> > > > > @@ -33,7 +33,7 @@ $(obj)/system_certificates.o: $(obj)/x509_certi=
ficate_list
> > > > >   $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(o=
bj)/extract-cert FORCE
> > > > >     $(call if_changed,extract_certs)
> > > > > -targets +=3D x509_certificate_list blacklist_hashes_checked
> > > > > +targets +=3D x509_certificate_list
> > > > >   # If module signing is requested, say by allyesconfig, but a ke=
y has not been
> > > > >   # supplied, then one will need to be generated to make sure the=
 build does not
> > > > > diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> > > > > index d5961aa3d338..86d66fe11348 100644
> > > > > --- a/certs/blacklist_hashes.c
> > > > > +++ b/certs/blacklist_hashes.c
> > > > > @@ -2,6 +2,6 @@
> > > > >   #include "blacklist.h"
> > > > >   const char __initconst *const blacklist_hashes[] =3D {
> > > > > -#include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
> > > > > +#include "blacklist_hash_list"
> > > > >     , NULL
> > > > >   };
> > >
> > > I'll make a PR for 1/4 and 2/4 so that they get into 5.19.
> > >
> > > BR, Jarkko
> >
> >
> > Thank you!
> >
> > What shall we do for 3/4 and 4/4?
> >
> > Do you have a plan to queue them up for the next MW?
> >
> > Or, shall I apply them to my kbuild tree with your reivewed-by?
>
> If possible, please do, thank you for taking the trouble.
>
> BR, Jarkko

Now, 3/4 and 4/4 applied to linux-kbuild.
Thanks.


--=20
Best Regards
Masahiro Yamada
