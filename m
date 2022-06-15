Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EDF54D11E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350241AbiFOSsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350000AbiFOSsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:48:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C7B427E5;
        Wed, 15 Jun 2022 11:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ADB1B820CE;
        Wed, 15 Jun 2022 18:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A89C34115;
        Wed, 15 Jun 2022 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655318895;
        bh=rMfZlPzH3rsFNG1zLEXYrykD4al7iaf+NOh8lw+/v1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mk2j1akEb5Ib5eTZplnO4HfSdqyNUNM4iM2GZU569SAmwb4GFd26OOvuIZMEf+VFh
         +69B87BdFUNEuzdlMIeXUs5PZl/q8k57YIw4Y4dxHM2CEBwHVbhdaYEVR41e84HAdA
         CFYduW4GiQBeVonsAKKewqMlPxRdzfbUHLdNnV59wbte78+RIhIAhVB/vuBRcGcOZp
         npsgWticzkdhX8j6bgK1iCTDWQTxuULIkCcPno2LlDGAjR7TSjw2rJzlQNs/x7rPwv
         4I8ajie8cNZlz4gX5v6Qp9p7Rti3OVRLdcqMYvfSZ85pwdM4ZiL0itdvUAf2dl8EYa
         OIAolRufwRAeQ==
Date:   Wed, 15 Jun 2022 21:46:07 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>,
        =?utf-8?B?TWlja2Hvv73vv73vv71sIFNhbGHvv73vv73vv71u?= 
        <mic@linux.microsoft.com>, David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] certs/blacklist_hashes.c: fix const confusion in
 certs blacklist
Message-ID: <Yqoo7xyJHhfC8RbV@iki.fi>
References: <20220611172233.1494073-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220611172233.1494073-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:22:30AM +0900, Masahiro Yamada wrote:
> This file fails to compile as follows:
> 
>   CC      certs/blacklist_hashes.o
> certs/blacklist_hashes.c:4:1: error: ignoring attribute ‘section (".init.data")’ because it conflicts with previous ‘section (".init.rodata")’ [-Werror=attributes]
>     4 | const char __initdata *const blacklist_hashes[] = {
>       | ^~~~~
> In file included from certs/blacklist_hashes.c:2:
> certs/blacklist.h:5:38: note: previous declaration here
>     5 | extern const char __initconst *const blacklist_hashes[];
>       |                                      ^~~~~~~~~~~~~~~~
> 
> Apply the same fix as commit 2be04df5668d ("certs/blacklist_nohashes.c:
> fix const confusion in certs blacklist").
> 
> Fixes: 734114f8782f ("KEYS: Add a system blacklist keyring")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  certs/blacklist_hashes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
> index 344892337be0..d5961aa3d338 100644
> --- a/certs/blacklist_hashes.c
> +++ b/certs/blacklist_hashes.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "blacklist.h"
>  
> -const char __initdata *const blacklist_hashes[] = {
> +const char __initconst *const blacklist_hashes[] = {
>  #include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
>  	, NULL
>  };
> -- 
> 2.32.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
