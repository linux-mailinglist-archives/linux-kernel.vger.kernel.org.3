Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8655AF6A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiFZGQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiFZGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:16:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18C211155;
        Sat, 25 Jun 2022 23:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C2C5610FB;
        Sun, 26 Jun 2022 06:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4F2C34114;
        Sun, 26 Jun 2022 06:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656224195;
        bh=V0kwl8PvcFuWUQKUbcZaHYnx6/0U8WaC/H8xFjHCvAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1oO92sRoNfKpgTsoGjnLLIuuWNrukLZC1zSr4glAOA6KGrcEkuIZfQauQk5ovdWc
         D+4tq5HVJS02DXrct1Jk6k3o87E92s1LZifsSwpCOhfNrwy2DP/vh1Qzl/OAiaEA7C
         98wVS9fIMoBf5oaxgXgP4EiU6X5vRQJ0NTwZN1SmkcTFGNW8F1k1ywIcCe0b9eCCGi
         1OCQekLZyQDfeevwfpYbhBysl0jlTCo9ZKaxcXZixgKfXh2oZqyxeCEX/RnRi37r/C
         I+MG0EHi22xxkFYezjo6vCCZGSfVhPSdol/BngyexfZFV/t/LycdWzPjSNoJ4R2ptZ
         XAlOIz1VQYRUQ==
Date:   Sun, 26 Jun 2022 09:16:32 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH 2/4] certs: fix and refactor
 CONFIG_SYSTEM_BLACKLIST_HASH_LIST build
Message-ID: <Yrf5wDBWKXCGGkxM@kernel.org>
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-2-masahiroy@kernel.org>
 <58a20890-557e-f31c-ed59-7e256445a26c@digikod.net>
 <YqopiZgC8vNSKYPt@iki.fi>
 <CAK7LNARSYSupt1nL_JS2prLunRpOhMRG_pPhHfto7+K+QDVp2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARSYSupt1nL_JS2prLunRpOhMRG_pPhHfto7+K+QDVp2Q@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 07:12:31AM +0900, Masahiro Yamada wrote:
> On Thu, Jun 16, 2022 at 3:51 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Mon, Jun 13, 2022 at 02:34:36PM +0200, Mickaël Salaün wrote:
> > >
> > >
> > > On 11/06/2022 19:22, Masahiro Yamada wrote:
> > > > Commit addf466389d9 ("certs: Check that builtin blacklist hashes are
> > > > valid") was applied 8 months after the submission.
> > > >
> > > > In the meantime, the base code had been removed by commit b8c96a6b466c
> > > > ("certs: simplify $(srctree)/ handling and remove config_filename
> > > > macro").
> > > >
> > > > Fix the Makefile.
> > > >
> > > > Create a local copy of $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST). It is
> > > > included from certs/blacklist_hashes.c and also works as a timestamp.
> > > >
> > > > Send error messages from check-blacklist-hashes.awk to stderr instead
> > > > of stdout.
> > > >
> > > > Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are valid")
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > >
> > > Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>
> > >
> > > As a side note, it may let an orphan certs/blacklist_hashes_checked file but
> > > we can't really do something about that and it's OK.
> > >
> > > Thanks!
> > >
> > > > ---
> > > >
> > > >   certs/.gitignore         |  2 +-
> > > >   certs/Makefile           | 20 ++++++++++----------
> > > >   certs/blacklist_hashes.c |  2 +-
> > > >   3 files changed, 12 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/certs/.gitignore b/certs/.gitignore
> > > > index 56637aceaf81..cec5465f31c1 100644
> > > > --- a/certs/.gitignore
> > > > +++ b/certs/.gitignore
> > > > @@ -1,5 +1,5 @@
> > > >   # SPDX-License-Identifier: GPL-2.0-only
> > > > -/blacklist_hashes_checked
> > > > +/blacklist_hash_list
> > > >   /extract-cert
> > > >   /x509_certificate_list
> > > >   /x509_revocation_list
> > > > diff --git a/certs/Makefile b/certs/Makefile
> > > > index cb1a9da3fc58..a8d628fd5f7b 100644
> > > > --- a/certs/Makefile
> > > > +++ b/certs/Makefile
> > > > @@ -7,22 +7,22 @@ obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o c
> > > >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
> > > >   obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
> > > >   ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
> > > > -quiet_cmd_check_blacklist_hashes = CHECK   $(patsubst "%",%,$(2))
> > > > -      cmd_check_blacklist_hashes = $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(2); touch $@
> > > > -$(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
> > > > +$(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
> > > > +CFLAGS_blacklist_hashes.o := -I $(obj)
> > > > -$(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
> > > > +quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
> > > > +      cmd_check_and_copy_blacklist_hash_list = \
> > > > +   $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> > > > +   cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
> > > > -CFLAGS_blacklist_hashes.o += -I$(srctree)
> > > > -
> > > > -targets += blacklist_hashes_checked
> > > > -$(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FORCE
> > > > -   $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
> > > > +$(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
> > > > +   $(call if_changed,check_and_copy_blacklist_hash_list)
> > > >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
> > > >   else
> > > >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
> > > >   endif
> > > > +targets += blacklist_hash_list
> > > >   quiet_cmd_extract_certs  = CERT    $@
> > > >         cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
> > > > @@ -33,7 +33,7 @@ $(obj)/system_certificates.o: $(obj)/x509_certificate_list
> > > >   $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert FORCE
> > > >     $(call if_changed,extract_certs)
> > > > -targets += x509_certificate_list blacklist_hashes_checked
> > > > +targets += x509_certificate_list
> > > >   # If module signing is requested, say by allyesconfig, but a key has not been
> > > >   # supplied, then one will need to be generated to make sure the build does not
> > > > diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> > > > index d5961aa3d338..86d66fe11348 100644
> > > > --- a/certs/blacklist_hashes.c
> > > > +++ b/certs/blacklist_hashes.c
> > > > @@ -2,6 +2,6 @@
> > > >   #include "blacklist.h"
> > > >   const char __initconst *const blacklist_hashes[] = {
> > > > -#include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
> > > > +#include "blacklist_hash_list"
> > > >     , NULL
> > > >   };
> >
> > I'll make a PR for 1/4 and 2/4 so that they get into 5.19.
> >
> > BR, Jarkko
> 
> 
> Thank you!
> 
> What shall we do for 3/4 and 4/4?
> 
> Do you have a plan to queue them up for the next MW?
> 
> Or, shall I apply them to my kbuild tree with your reivewed-by?

If possible, please do, thank you for taking the trouble.

BR, Jarkko
