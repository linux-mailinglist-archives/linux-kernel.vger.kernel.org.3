Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75065499D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbiFMRXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbiFMRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:22:52 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C222536;
        Mon, 13 Jun 2022 05:38:03 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LMB1M31q6zMpt89;
        Mon, 13 Jun 2022 14:37:59 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LMB1L5mZPzlmw7y;
        Mon, 13 Jun 2022 14:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1655123879;
        bh=CFrbP6NAnep/uRfS4DXF/JGcmyrnfXN/8k2zjVoJmus=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KNig8/rih8RGxFYrWUxBTVY8iMKdsC3bvch75EnH2jHFG9eTzjtGXtZ4xPoDqFsCH
         OXVtTkMxReVaqnpl2e3+rEOMb5qLFa+7I4oi8R6xEZlYjqVJ1PycrfIKV5rQP5PTUr
         CvnMMV+B5QsC5SS2cxpA560hAZXcb136lFwqnYCM=
Message-ID: <c27c75ab-bb59-10a2-653e-a80d648bbcaa@digikod.net>
Date:   Mon, 13 Jun 2022 14:37:58 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH 4/4] certs: unify blacklist_hashes.c and
 blacklist_nohashes.c
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
 <20220611172233.1494073-4-masahiroy@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220611172233.1494073-4-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2022 19:22, Masahiro Yamada wrote:
> These two files are very similar. Unify them.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>

> ---
> 
>   certs/Makefile             | 12 +++++-------
>   certs/blacklist_hashes.c   |  1 -
>   certs/blacklist_nohashes.c |  6 ------
>   3 files changed, 5 insertions(+), 14 deletions(-)
>   delete mode 100644 certs/blacklist_nohashes.c
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index df7aaeafd19c..7068d45db807 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -4,24 +4,22 @@
>   #
>   
>   obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o common.o
> -obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
> +obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o blacklist_hashes.o
>   obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
> -ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
>   
>   $(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
>   CFLAGS_blacklist_hashes.o := -I $(obj)
>   
>   quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
>         cmd_check_and_copy_blacklist_hash_list = \
> +	$(if $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST), \
>   	$(AWK) -f $(srctree)/$(src)/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> -	cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
> +	{ cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST); echo $(comma) NULL; } > $@, \
> +	echo NULL > $@)
>   
>   $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
>   	$(call if_changed,check_and_copy_blacklist_hash_list)
> -obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
> -else
> -obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
> -endif
> +
>   targets += blacklist_hash_list
>   
>   quiet_cmd_extract_certs  = CERT    $@
> diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> index 86d66fe11348..0c5476abebd9 100644
> --- a/certs/blacklist_hashes.c
> +++ b/certs/blacklist_hashes.c
> @@ -3,5 +3,4 @@
>   
>   const char __initconst *const blacklist_hashes[] = {
>   #include "blacklist_hash_list"
> -	, NULL
>   };
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
