Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95BA54866F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbiFMPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243879AbiFMPRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:17:53 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F131269AC;
        Mon, 13 Jun 2022 05:36:15 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LM9zK4sW9zMpyPc;
        Mon, 13 Jun 2022 14:36:13 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LM9zK0CnPzlqK2h;
        Mon, 13 Jun 2022 14:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1655123773;
        bh=y8WeNC3r3J7KNO7FidESYUF65oAKkpk01OypWCpEEpI=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=0jqca2CqbhDm2H3L9tH3sKXia+64mN5xDGlKUNW9yCxFJv0zD0a0dE5UldOGfNPUx
         X8eLqADKLAK47fE8LhhB7re3x5PwlFGYOZ47hNEBNuPTUvSQJUMZbToTUcdAHgA3k+
         q4aeIrZvnB9nWaIWm73+N4UrUjWtcvj4H+WHnfN4=
Message-ID: <e7850717-dad6-daef-c96c-2a74248e98f6@digikod.net>
Date:   Mon, 13 Jun 2022 14:36:12 +0200
MIME-Version: 1.0
User-Agent: 
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
 <20220611172233.1494073-3-masahiroy@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 3/4] certs: move scripts/check-blacklist-hashes.awk to
 certs/
In-Reply-To: <20220611172233.1494073-3-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2022 19:22, Masahiro Yamada wrote:
> This script is only used in certs/Makefile, so certs/ is a better
> home for it.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   MAINTAINERS                                   | 1 -
>   certs/Makefile                                | 2 +-
>   {scripts => certs}/check-blacklist-hashes.awk | 0
>   3 files changed, 1 insertion(+), 2 deletions(-)
>   rename {scripts => certs}/check-blacklist-hashes.awk (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1fc9ead83d2a..7c2a7c304824 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4627,7 +4627,6 @@ L:	keyrings@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/admin-guide/module-signing.rst
>   F:	certs/
> -F:	scripts/check-blacklist-hashes.awk >   F:	scripts/sign-file.c
>   F:	tools/certs/
>   
> diff --git a/certs/Makefile b/certs/Makefile
> index a8d628fd5f7b..df7aaeafd19c 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -13,7 +13,7 @@ CFLAGS_blacklist_hashes.o := -I $(obj)
>   
>   quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
>         cmd_check_and_copy_blacklist_hash_list = \
> -	$(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> +	$(AWK) -f $(srctree)/$(src)/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
>   	cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
>   
>   $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
> diff --git a/scripts/check-blacklist-hashes.awk b/certs/check-blacklist-hashes.awk
> similarity index 100%
> rename from scripts/check-blacklist-hashes.awk
> rename to certs/check-blacklist-hashes.awk

It looks more appropriate and consistent to me to keep it in scripts/, 
close to other cert scripts. Is there some precedent to move such script?
