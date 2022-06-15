Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE99954D122
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbiFOSsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350694AbiFOSsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:48:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510A46CA2;
        Wed, 15 Jun 2022 11:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7048B82147;
        Wed, 15 Jun 2022 18:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0F2C34115;
        Wed, 15 Jun 2022 18:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655318914;
        bh=gFgJoLcVfJvasnO7FW/JzbZ+FTFFcVnpa5JhwcKj5JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNh5+606GjmDrqcvI199hr0z0cObdndVk1nkJvJWKRbZ2o3MfbvvxdEabl1fie+LT
         7HQe06Ps1CuPB7iRnJZ8Ns/seKG1qowF8wKSNs4U9gBv3bbisERgl17H1BiIKCrp1t
         hiBYWTjPQFTowbISaEK1rd5ED84h2u06IKFC8OePJoqCJobAxAMdiiY4BnMah2bfnq
         qBjC95wR078y4VBUAD2uHzaifNigJSgzKaSEK/KIPdQIpLJcFitPdCar3QNOxN4SXT
         cYFRb+j7py7RM0t+9Sik6/6VGcg4u7YkQjYUhPAYFOkCQeLgvQsd7y2D12AEpxDx9Q
         8Qlq85dUW86ZQ==
Date:   Wed, 15 Jun 2022 21:46:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>,
        =?utf-8?B?TWlja2Hvv73vv73vv71sIFNhbGHvv73vv73vv71u?= 
        <mic@linux.microsoft.com>, David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] certs: fix and refactor
 CONFIG_SYSTEM_BLACKLIST_HASH_LIST build
Message-ID: <YqopAf+uePZx+8Kg@iki.fi>
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611172233.1494073-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:22:31AM +0900, Masahiro Yamada wrote:
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
> ---
> 
>  certs/.gitignore         |  2 +-
>  certs/Makefile           | 20 ++++++++++----------
>  certs/blacklist_hashes.c |  2 +-
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/certs/.gitignore b/certs/.gitignore
> index 56637aceaf81..cec5465f31c1 100644
> --- a/certs/.gitignore
> +++ b/certs/.gitignore
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -/blacklist_hashes_checked
> +/blacklist_hash_list
>  /extract-cert
>  /x509_certificate_list
>  /x509_revocation_list
> diff --git a/certs/Makefile b/certs/Makefile
> index cb1a9da3fc58..a8d628fd5f7b 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -7,22 +7,22 @@ obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o c
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
>  obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
>  ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
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
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
>  else
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
>  endif
> +targets += blacklist_hash_list
>  
>  quiet_cmd_extract_certs  = CERT    $@
>        cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
> @@ -33,7 +33,7 @@ $(obj)/system_certificates.o: $(obj)/x509_certificate_list
>  $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert FORCE
>  	$(call if_changed,extract_certs)
>  
> -targets += x509_certificate_list blacklist_hashes_checked
> +targets += x509_certificate_list
>  
>  # If module signing is requested, say by allyesconfig, but a key has not been
>  # supplied, then one will need to be generated to make sure the build does not
> diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> index d5961aa3d338..86d66fe11348 100644
> --- a/certs/blacklist_hashes.c
> +++ b/certs/blacklist_hashes.c
> @@ -2,6 +2,6 @@
>  #include "blacklist.h"
>  
>  const char __initconst *const blacklist_hashes[] = {
> -#include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
> +#include "blacklist_hash_list"
>  	, NULL
>  };
> -- 
> 2.32.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
