Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79FF4C910D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiCARBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiCARBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:01:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAC21AD82;
        Tue,  1 Mar 2022 09:00:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E9FA60FCD;
        Tue,  1 Mar 2022 17:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A3DC340EE;
        Tue,  1 Mar 2022 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646154051;
        bh=h907ipPkeeK8P2nHj6SjBPg75fPHts99jpm7hU3oTe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uejxuz68JNN+P/Ws/LbTy+IcncnwZTwo3NQso7ZdH7w978wfAVW3186wDBd9SzsvQ
         kNm3lkRQv5WwuJB/zW5sCTRZw66PNcdHW0Y8xqQzw6dI5HVsJZofimyKsKGnA23U26
         pm1v1ubbzy45uxc1q1rpOavS/mjiXtwgBo5eyrEsQLMhAHhiNWjvnMUZHulkbiDtey
         zoovisI+XRC+c3rMe9bDqCkk4dhfLZA9Sz+xxGcMKgexowZ1PBAjwmUFgxDEf7BIU3
         +QI1xlshWc56KtdACRoQy2cp54d1DnemenhEjTrXbUzW6dj/1IqTUJWR7wl21ymGDK
         /6i415XEZ/Tqg==
Date:   Tue, 1 Mar 2022 10:00:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
Message-ID: <Yh5RPeqikTtoUS80@dev-arch.archlinux-ax161>
References: <20220301145233.3689119-1-arnd@kernel.org>
 <20220301145233.3689119-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301145233.3689119-3-arnd@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 03:52:33PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As we change the C language standard for the kernel from gnu89 to
> gnu11, it makes sense to also update the version for user space
> compilation.
> 
> Some users have older native compilers than what they use for
> kernel builds, so I considered using gnu99 as the default version
> for wider compatibility with gcc-4.6 and earlier.
> 
> However, testing with older compilers showed that we already require
> HOSTCC version 5.1 as well because a lot of host tools include
> linux/compiler.h that uses __has_attribute():
> 
>   CC      tools/objtool/exec-cmd.o
> In file included from tools/include/linux/compiler_types.h:36:0,
>                  from tools/include/linux/compiler.h:5,
>                  from exec-cmd.c:2:
> tools/include/linux/compiler-gcc.h:19:5: error: "__has_attribute" is not defined [-Werror=undef]

For what it's worth, I think this is a bug:

https://lore.kernel.org/r/c1b1a299-c60d-28a4-07ab-1ecd211d6da9@i-love.sakura.ne.jp/
https://lore.kernel.org/r/20220102120201.594408-1-xu.xin16@zte.com.cn/

I never got clear feedback on resolving it from the first thread and
nobody bothered to pick up the second patch.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nobody has yelled that loud though, so this is probably fine.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 37ef6a555dcd..7c9be7f1ccd4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -432,7 +432,7 @@ HOSTCXX	= g++
>  endif
>  
>  export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> -			    -O2 -fomit-frame-pointer -std=gnu89 \
> +			    -O2 -fomit-frame-pointer -std=gnu11 \
>  			    -Wdeclaration-after-statement
>  export KBUILD_USERLDFLAGS :=
>  
> -- 
> 2.29.2
> 
> 
