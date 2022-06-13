Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3F5499A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbiFMRR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbiFMROD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:14:03 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D4B5549E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:20:08 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LM9cj5FsVzMpwtX;
        Mon, 13 Jun 2022 14:20:05 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LM9cd4MYKzlpb2d;
        Mon, 13 Jun 2022 14:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1655122805;
        bh=P8NVyXj34ZvJVQWESPk01PC8KYswBLc2J5cBfxA5wlI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aOumEP/IoqVDxckhdOnow8XBOtzF6rPUHSpjAaEiKv4s4qTv9+QazdFI/MV0sY9Oj
         WNcCDGC2NsIWSWr8htmOXQonlVhjqK6/U6g/yYRD9VTzd/JdIjpyOFwXcDvdlX4LMS
         ZPoJ0aNzkEJ9Yh+5Wu0QvJ3PdsdwNy2lAdCZDTxY=
Message-ID: <ff05d732-3202-7c9c-0d4c-d95101ed6ba3@digikod.net>
Date:   Mon, 13 Jun 2022 14:20:00 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH 1/4] certs/blacklist_hashes.c: fix const confusion in
 certs blacklist
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220611172233.1494073-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> This file fails to compile as follows:
> 
>    CC      certs/blacklist_hashes.o
> certs/blacklist_hashes.c:4:1: error: ignoring attribute ‘section (".init.data")’ because it conflicts with previous ‘section (".init.rodata")’ [-Werror=attributes]
>      4 | const char __initdata *const blacklist_hashes[] = {
>        | ^~~~~
> In file included from certs/blacklist_hashes.c:2:
> certs/blacklist.h:5:38: note: previous declaration here
>      5 | extern const char __initconst *const blacklist_hashes[];
>        |                                      ^~~~~~~~~~~~~~~~
> 
> Apply the same fix as commit 2be04df5668d ("certs/blacklist_nohashes.c:
> fix const confusion in certs blacklist").
> 
> Fixes: 734114f8782f ("KEYS: Add a system blacklist keyring")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>

> ---
> 
>   certs/blacklist_hashes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> index 344892337be0..d5961aa3d338 100644
> --- a/certs/blacklist_hashes.c
> +++ b/certs/blacklist_hashes.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include "blacklist.h"
>   
> -const char __initdata *const blacklist_hashes[] = {
> +const char __initconst *const blacklist_hashes[] = {
>   #include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
>   	, NULL
>   };
