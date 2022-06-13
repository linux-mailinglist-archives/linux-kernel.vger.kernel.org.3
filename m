Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69645499C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbiFMRWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbiFMRVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:21:13 -0400
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910F3193FB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:34:39 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LM9xT5M4DzMqKD6;
        Mon, 13 Jun 2022 14:34:37 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LM9xS6VH3zlmw88;
        Mon, 13 Jun 2022 14:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1655123677;
        bh=4lFhtOUX5Zu4CCyieZLyhSrt42kxYv3u/95l/zVRkfo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D0q2KaopkzG3xCeNyCnSnqDihTXcOk+GqdMIT87eVyJtjFp82x80RuSyNPRES+Bde
         zqyibOe+UWAb5F86dCmgQbt3tAop6RyXK+vmPig+n2t1dhfKaeSpFW9cPGNLM8o8JK
         nZ/6uQN9Q+X9wRAHiu+Q7S4S5V0XJau92KqIJsgg=
Message-ID: <58a20890-557e-f31c-ed59-7e256445a26c@digikod.net>
Date:   Mon, 13 Jun 2022 14:34:36 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH 2/4] certs: fix and refactor
 CONFIG_SYSTEM_BLACKLIST_HASH_LIST build
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-2-masahiroy@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220611172233.1494073-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2022 19:22, Masahiro Yamada wrote:
> Commit addf466389d9 ("certs: Check that builtin blacklist hashes are
> valid") was applied 8 months after the submission.
> 
> In the meantime, the base code had been removed by commit b8c96a6b466c
> ("certs: simplify $(srctree)/ handling and remove config_filename
> macro").
> 
> Fix the Makefile.
> 
> Create a local copy of $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST). It is
> included from certs/blacklist_hashes.c and also works as a timestamp.
> 
> Send error messages from check-blacklist-hashes.awk to stderr instead
> of stdout.
> 
> Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are valid")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>

As a side note, it may let an orphan certs/blacklist_hashes_checked file 
but we can't really do something about that and it's OK.

Thanks!

> ---
> 
>   certs/.gitignore         |  2 +-
>   certs/Makefile           | 20 ++++++++++----------
>   certs/blacklist_hashes.c |  2 +-
>   3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/certs/.gitignore b/certs/.gitignore
> index 56637aceaf81..cec5465f31c1 100644
> --- a/certs/.gitignore
> +++ b/certs/.gitignore
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -/blacklist_hashes_checked
> +/blacklist_hash_list
>   /extract-cert
>   /x509_certificate_list
>   /x509_revocation_list
> diff --git a/certs/Makefile b/certs/Makefile
> index cb1a9da3fc58..a8d628fd5f7b 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -7,22 +7,22 @@ obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o c
>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
>   obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
>   ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
> -quiet_cmd_check_blacklist_hashes = CHECK   $(patsubst "%",%,$(2))
> -      cmd_check_blacklist_hashes = $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(2); touch $@
>   
> -$(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
> +$(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
> +CFLAGS_blacklist_hashes.o := -I $(obj)
>   
> -$(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
> +quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
> +      cmd_check_and_copy_blacklist_hash_list = \
> +	$(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> +	cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
>   
> -CFLAGS_blacklist_hashes.o += -I$(srctree)
> -
> -targets += blacklist_hashes_checked
> -$(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FORCE
> -	$(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
> +$(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
> +	$(call if_changed,check_and_copy_blacklist_hash_list)
>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
>   else
>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
>   endif
> +targets += blacklist_hash_list
>   
>   quiet_cmd_extract_certs  = CERT    $@
>         cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
> @@ -33,7 +33,7 @@ $(obj)/system_certificates.o: $(obj)/x509_certificate_list
>   $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert FORCE
>   	$(call if_changed,extract_certs)
>   
> -targets += x509_certificate_list blacklist_hashes_checked
> +targets += x509_certificate_list
>   
>   # If module signing is requested, say by allyesconfig, but a key has not been
>   # supplied, then one will need to be generated to make sure the build does not
> diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> index d5961aa3d338..86d66fe11348 100644
> --- a/certs/blacklist_hashes.c
> +++ b/certs/blacklist_hashes.c
> @@ -2,6 +2,6 @@
>   #include "blacklist.h"
>   
>   const char __initconst *const blacklist_hashes[] = {
> -#include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
> +#include "blacklist_hash_list"
>   	, NULL
>   };
