Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426B75A8782
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiHaUXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiHaUXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:23:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF47D99C3;
        Wed, 31 Aug 2022 13:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76521B82301;
        Wed, 31 Aug 2022 20:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563B7C433D6;
        Wed, 31 Aug 2022 20:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661977383;
        bh=5uN7nzPwfI/1N2ti9Lp5VrCgxZVrN89dYdqpAIQOF6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CA23Eldvy/3ULld1WpL1lAnDzzQD1phusjI7CK4wIZvslO1aL8OOfNQ69a8J2Q57A
         COq0zBpdM2bF/6wmcWgj2SMyQ+AoP83IR8EQxGFb2mtdhwuAK1YnBu2Ye7LIElOsrq
         Lb/E943++QUC9yMiSZQoPWJalkuufXONeR4YG/3ddH0k6h2fmi6eE6k32Qf2wnpeRx
         o1o/Ff0E0LUCfcULCF88iJ509Gy964IRaXir+h1Mf/GjC5GQSPhBSDyUJk5/s1CSpx
         weomMrDW+vvhYUhBxrNS7l6Do6OICJRQKOVKucSNDd3DTvYe0lU+zAl/6DOoEyme3w
         1js6ugKD51U9A==
Date:   Wed, 31 Aug 2022 13:23:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 5/5] Makefile.debug: set -g unconditional on
 CONFIG_DEBUG_INFO_SPLIT
Message-ID: <Yw/DJLu10nw4aUDw@dev-arch.thelio-3990X>
References: <20220831184408.2778264-1-ndesaulniers@google.com>
 <20220831184408.2778264-6-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831184408.2778264-6-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:44:08AM -0700, Nick Desaulniers wrote:
> Dmitrii, Fangrui, and Mashahiro note:
> 
>   Before GCC 11 and Clang 12 -gsplit-dwarf implicitly uses -g2.
> 
> Fix CONFIG_DEBUG_INFO_SPLIT for gcc-11+ & clang-12+ which now need -g
> specified in order for -gsplit-dwarf to work at all.
> 
> -gsplit-dwarf has been mutually exclusive with -g since support for
> CONFIG_DEBUG_INFO_SPLIT was introduced in
> commit 866ced950bcd ("kbuild: Support split debug info v4")
> I don't think it ever needed to be.
> 
> Link: https://lore.kernel.org/lkml/20220815013317.26121-1-dmitrii.bundin.a@gmail.com/
> Link: https://lore.kernel.org/lkml/CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com/
> Link: https://reviews.llvm.org/D80391
> Cc: Andi Kleen <ak@linux.intel.com>
> Reported-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> Reported-by: Fangrui Song <maskray@google.com>
> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> Suggested-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes v1 -> v2:
> * Add reference to 866ced950bcd, cc Andi, in commit message.
> 
>  scripts/Makefile.debug | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 46e88f0ca998..b6eb532af3cc 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -1,10 +1,8 @@
> -DEBUG_CFLAGS	:=
> +DEBUG_CFLAGS	:= -g
> +KBUILD_AFLAGS	+= -g
>  
>  ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS	+= -gsplit-dwarf
> -else
> -DEBUG_CFLAGS	+= -g
> -KBUILD_AFLAGS	+= -g
>  endif
>  
>  ifdef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> -- 
> 2.37.2.672.g94769d06f0-goog
> 
