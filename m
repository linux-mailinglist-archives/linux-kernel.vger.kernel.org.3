Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840C254D12A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358095AbiFOStr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349667AbiFOStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F284F488B5;
        Wed, 15 Jun 2022 11:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6360E61C65;
        Wed, 15 Jun 2022 18:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46341C34115;
        Wed, 15 Jun 2022 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655318983;
        bh=WeRkWuzfljqlSxGlCkUrB10gGrK8yyoYOm4jNDN7C3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZHeirEK71z+YCsCbmGvnoGOOIol1pe+mfFe+/V8I9jy/jVtEqtrAnUg6IiEciuxa
         CH+g5f07j8eiQE0VVxViPWknMIRlgan3MV6NRC2dLG4MpCWkJiV06O46jmDr4q6j5A
         fMoaa3MAE9Y6EAxr0+84ufRakB5X+nP4zMWwe8gZpILvEzWBOmUxn7mj77GS3xaRGZ
         sGPza6SRY2cFRybq2EuHS35QJxtHLby4We+175lGE7OjhWANFPcw6CiTLESCQPZKvR
         kCCxKpt6b9eiEBBhar61foJdOu6Ee7jnmrh0OcEtx/9UK7KaNG+k8If+6nS3ud1FpP
         6BQxiC0M9uZLQ==
Date:   Wed, 15 Jun 2022 21:47:34 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>,
        =?utf-8?B?TWlja2Hvv73vv73vv71sIFNhbGHvv73vv73vv71u?= 
        <mic@linux.microsoft.com>, David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] certs: unify blacklist_hashes.c and
 blacklist_nohashes.c
Message-ID: <YqopRlZIKvlaAbNZ@iki.fi>
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611172233.1494073-4-masahiroy@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:22:33AM +0900, Masahiro Yamada wrote:
> These two files are very similar. Unify them.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  certs/Makefile             | 12 +++++-------
>  certs/blacklist_hashes.c   |  1 -
>  certs/blacklist_nohashes.c |  6 ------
>  3 files changed, 5 insertions(+), 14 deletions(-)
>  delete mode 100644 certs/blacklist_nohashes.c
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index df7aaeafd19c..7068d45db807 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -4,24 +4,22 @@
>  #
>  
>  obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o common.o
> -obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
> +obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o blacklist_hashes.o
>  obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
> -ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
>  
>  $(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
>  CFLAGS_blacklist_hashes.o := -I $(obj)
>  
>  quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
>        cmd_check_and_copy_blacklist_hash_list = \
> +	$(if $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST), \
>  	$(AWK) -f $(srctree)/$(src)/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> -	cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
> +	{ cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST); echo $(comma) NULL; } > $@, \
> +	echo NULL > $@)
>  
>  $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
>  	$(call if_changed,check_and_copy_blacklist_hash_list)
> -obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
> -else
> -obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
> -endif
> +
>  targets += blacklist_hash_list
>  
>  quiet_cmd_extract_certs  = CERT    $@
> diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> index 86d66fe11348..0c5476abebd9 100644
> --- a/certs/blacklist_hashes.c
> +++ b/certs/blacklist_hashes.c
> @@ -3,5 +3,4 @@
>  
>  const char __initconst *const blacklist_hashes[] = {
>  #include "blacklist_hash_list"
> -	, NULL
>  };
> diff --git a/certs/blacklist_nohashes.c b/certs/blacklist_nohashes.c
> deleted file mode 100644
> index 753b703ef0ef..000000000000
> --- a/certs/blacklist_nohashes.c
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "blacklist.h"
> -
> -const char __initconst *const blacklist_hashes[] = {
> -	NULL
> -};
> -- 
> 2.32.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
