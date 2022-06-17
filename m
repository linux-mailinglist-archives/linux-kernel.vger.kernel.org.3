Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4274454FF6B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbiFQVf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiFQVf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C94D9C1;
        Fri, 17 Jun 2022 14:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15C9C620C1;
        Fri, 17 Jun 2022 21:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE608C3411B;
        Fri, 17 Jun 2022 21:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655501756;
        bh=j5IG0RuYe4c8P+06bU1ts5x/YGPNXkMabsyeDG0567M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulIQ/PO2Ow2biHD/bub+oaqDoKnt4xTYLHAoXPRTxI7dSJ3NLlpFR7zQ8xZiNXoSP
         AFlVEtaRreoXOLo9m9PvE+RiVZGsS/pBlH1VwBpXJAiBmmSrxNfxR+RIZ3gatdVWKw
         0HSWQ8iAtv4JPshUiZZpsitl448nve6wqH7o8M67t15P0LT9VPvhvHLn/jpMfANPZg
         01bB9BrJPJS7pTqSdL6lrV/ERWCuj9Z7/9ZQ4EpVcvEvFqRztMbfa640V4g45+fenN
         jvnZfQjl1nYJ4X6zDoGPQ9fMXiH6BKPAMP2JT6lxH/vFn38kJBWIhnPr5HtnvZjq6p
         7DO9IUUGZF4ag==
Date:   Fri, 17 Jun 2022 14:35:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Kbuild: change CONFIG_FRAME_WARN for 32-bit
Message-ID: <Yqzzuk+Wv5q1zIKm@dev-arch.thelio-3990X>
References: <20220617150922.1878926-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220617150922.1878926-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Jun 17, 2022 at 05:08:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The introduction of CONFIG_GCC_PLUGIN_LATENT_ENTROPY raised the
> warning limit for 32-bit architectures to a much higher value in
> 2016. Initially this had no effect for Arm machines as their kernels
> tend to be cross-compiled, and the feature detection for the plugin did
> not work with common cross compilers.
> 
> I could not find the original regression report that led to the warning
> limit getting raised, but I have been unable to reproduce this with gcc-12
> and linux-5.18 -- all frame sizes appear to be be below the normal 1024
> byte limit on at least arm32 and i386.
> 
> However, the KASAN feature introduced later on does raise the frame size
> of a number of functions above the warning limit, in almost all cases to
> somewhere below 1280 bytes. The effect is that an arm allmodconfig build
> produces no warnings because of the check for the latent entropy plugin,
> but a normal KASAN based build with gcc does produce build warnings or
> failures when CONFIG_WERROR is set.
> 
> The 1280 byte limit is an arbitrary choice here, as it disables almost
> all warnings but leaves a few outliers that are probably better addressed
> with code changes. There are a number of functions that are just below the
> normal 1024 byte limit at the moment, and an extra 256 bytes for those
> is within the expectation, but more than that is probably an indication
> of a bad design or a real bug.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3da5f9acb966..8a3afd837e99 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -387,9 +387,9 @@ endif # DEBUG_INFO
>  config FRAME_WARN
>  	int "Warn for stack frames larger than"
>  	range 0 8192
> -	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>  	default 2048 if PARISC
>  	default 1536 if (!64BIT && XTENSA)
> +	default 1280 if (!64BIT && KASAN_STACK)

For what it's worth, if this was changed to just KASAN, this would
improve the situation for clang and ARCH=arm allmodconfig as well. It
leaves just two -Wframe-larger-than warnings in
drivers/gpu/drm/amd/display, which can be worked around with a kernel
side change:

https://github.com/ClangBuiltLinux/linux/issues/1455#issuecomment-995337569

Cheers,
Nathan
