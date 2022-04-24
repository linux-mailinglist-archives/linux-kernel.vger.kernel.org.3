Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01D50D5AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiDXWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiDXWUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C9B6D86A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 15:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D85661354
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE35C385A7;
        Sun, 24 Apr 2022 22:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650838667;
        bh=aCUo1AIugUEcO35y/pU9+Q9FKJzq4qO/ICqLjl72B94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sh+ivT3b3v1+G2ABXiYchKxVUsVkrcPie+pUNZayfM4CmKxby6BG2RTMeIX3KbK7o
         z50QWP+uNmdyWWTldFp0bXqiTPmRr10AeAyrFS2s8JWbZoSHUxZvpafQUW6nmzjtQT
         I6dxB/37tkvdssNaYbbc0Uce6LzDaolmcVbBCdBJA7uWa8t4L/dnPRBLthPVw2KusV
         q0WKWOPhHnRgSnevAJ8Kz5AtzRG8Bd+aVyF6YYQWzfm+ceuanapUzstzlI6W4agoXT
         a4rjvlrT7BVymkzgCA/7bLoxs+qDbG6NXIfk3q57JQXj/e1foE4VEtK/ltSzgEzetB
         OoViz9Uoin5mw==
Date:   Sun, 24 Apr 2022 15:17:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] checksyscalls: ignore -Wunused-macros
Message-ID: <YmXMiTXEvFXZ/swU@dev-arch.thelio-3990X>
References: <20220422151725.1336997-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422151725.1336997-1-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Sat, Apr 23, 2022 at 12:17:25AM +0900, Vincent Mailhol wrote:
> The macros defined in this file are for testing only and are purposely
> not used. When compiled with W=2, both gcc and clang yield some
> -Wunused-macros warnings. Ignore them.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The change itself looks fine but a couple of comments:

1. Nick and I do not pick up patches, we rely on others to do so.
   Additionally, this is not really something within our domain, despite
   what get_maintainer.pl might say. This change should be sent to
   either

   Masahiro Yamada <masahiroy@kernel.org>
   linux-kbuild@vger.kernel.org

   or

   Andrew Morton <akpm@linux-foundation.org>

   so that it can be applied by one of them.

2. I am not sure that silencing warnings from W=2 is that useful, as
   they are unlikely to be real issues. Not to discourage you by any
   means but it might be more useful to focus on cleaning up warnings
   from W=1 and getting those promoted to regular build warnings.

Cheers,
Nathan

> ---
>  scripts/checksyscalls.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> index 9dbab13329fa..cde15f22ec98 100755
> --- a/scripts/checksyscalls.sh
> +++ b/scripts/checksyscalls.sh
> @@ -255,6 +255,7 @@ cat << EOF
>  /* 64-bit ports never needed these, and new 32-bit ports can use statx */
>  #define __IGNORE_fstat64
>  #define __IGNORE_fstatat64
> +
>  EOF
>  }
>  
> @@ -268,4 +269,4 @@ syscall_list() {
>  }
>  
>  (ignore_list && syscall_list $(dirname $0)/../arch/x86/entry/syscalls/syscall_32.tbl) | \
> -$* -Wno-error -E -x c - > /dev/null
> +$* -Wno-error -Wno-unused-macros -E -x c - > /dev/null
> -- 
> 2.35.1
> 
