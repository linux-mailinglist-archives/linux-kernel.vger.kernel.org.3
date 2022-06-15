Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4539B54D12E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353025AbiFOSvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345773AbiFOSvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:51:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B9E4B41B;
        Wed, 15 Jun 2022 11:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D750461C18;
        Wed, 15 Jun 2022 18:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80696C34115;
        Wed, 15 Jun 2022 18:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655319063;
        bh=GnZfgvOrH9mrrcvvYQgPANHs5nDHlMsLFHFAYJcrIC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=memS1VJJiclI8dsM+WxYbHq2xPW3MTby9Gf6CQVDi2okhI52Ly9A3MqBXoNIVsw3v
         wSpwd6C41jKMUfFEq9ROkjNjB9xpHk5ywPJJyLcLV1fl+7FN/KN0rye6Vg99E4Hby6
         8kIi89VLR0uhac/XUlK9Gqduk+Lx32gXt/5L5cc99VHUIo35iM3B51LnZKxrUuGMI0
         X55JfneWAIWuADLBl7QjAXgSUl0uBxCsGuFKmbH2wsSpseFsjTyKMafmLKmSzLCM4q
         2Ecdv4eFnZiWCoZ86I0/1TvcA8Rw5WgPQ7YShJxAlbVKUnWE/qY+rsyYsTOD2H0iGk
         pN1ujoG9RyyPw==
Date:   Wed, 15 Jun 2022 21:48:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH 2/4] certs: fix and refactor
 CONFIG_SYSTEM_BLACKLIST_HASH_LIST build
Message-ID: <YqopiZgC8vNSKYPt@iki.fi>
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-2-masahiroy@kernel.org>
 <58a20890-557e-f31c-ed59-7e256445a26c@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58a20890-557e-f31c-ed59-7e256445a26c@digikod.net>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:34:36PM +0200, Mickaël Salaün wrote:
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
> > Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are valid")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>
> 
> As a side note, it may let an orphan certs/blacklist_hashes_checked file but
> we can't really do something about that and it's OK.
> 
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
> > @@ -7,22 +7,22 @@ obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o c
> >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
> >   obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
> >   ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
> > -quiet_cmd_check_blacklist_hashes = CHECK   $(patsubst "%",%,$(2))
> > -      cmd_check_blacklist_hashes = $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(2); touch $@
> > -$(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
> > +$(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
> > +CFLAGS_blacklist_hashes.o := -I $(obj)
> > -$(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
> > +quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
> > +      cmd_check_and_copy_blacklist_hash_list = \
> > +	$(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> > +	cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
> > -CFLAGS_blacklist_hashes.o += -I$(srctree)
> > -
> > -targets += blacklist_hashes_checked
> > -$(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FORCE
> > -	$(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
> > +$(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
> > +	$(call if_changed,check_and_copy_blacklist_hash_list)
> >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
> >   else
> >   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
> >   endif
> > +targets += blacklist_hash_list
> >   quiet_cmd_extract_certs  = CERT    $@
> >         cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
> > @@ -33,7 +33,7 @@ $(obj)/system_certificates.o: $(obj)/x509_certificate_list
> >   $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert FORCE
> >   	$(call if_changed,extract_certs)
> > -targets += x509_certificate_list blacklist_hashes_checked
> > +targets += x509_certificate_list
> >   # If module signing is requested, say by allyesconfig, but a key has not been
> >   # supplied, then one will need to be generated to make sure the build does not
> > diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> > index d5961aa3d338..86d66fe11348 100644
> > --- a/certs/blacklist_hashes.c
> > +++ b/certs/blacklist_hashes.c
> > @@ -2,6 +2,6 @@
> >   #include "blacklist.h"
> >   const char __initconst *const blacklist_hashes[] = {
> > -#include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
> > +#include "blacklist_hash_list"
> >   	, NULL
> >   };

I'll make a PR for 1/4 and 2/4 so that they get into 5.19.

BR, Jarkko
