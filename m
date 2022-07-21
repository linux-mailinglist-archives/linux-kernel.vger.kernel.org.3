Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689D157D610
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiGUVfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiGUVe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FEC9361C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 521CA61A47
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 21:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40031C341C6;
        Thu, 21 Jul 2022 21:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658439294;
        bh=X6md/rKJO+TSATnu9ymd2mEtloui1L+AMk57HNphM98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIEjxkPim65OtK/aPhJ1I8++6uDbbwdU2dTojmTJbKnxXdWNebc7617wpfd0bL4KS
         satN4XPTypFcyFvRJbND5qVqpVZ1L59mBh6SolF953a7kL4voglcAuLRNxv45ehi/n
         0RzZrAjOsS2OhnRUwWnQrKekXlgcVaiyyjUGkjhIR7ZPCq6+oOe17XsVgxsZp9fvXP
         +8Y3FhljvjIYnuLCLLvnybRzGFW6YSiiI0B+8s/j6r8NhkUrhxUBpm994DlFGsHORU
         +ArLn7CXm8plKRTbviCoEpzIxbqBjhyvYs0xnLC9mWdYWCAyeOO9+JnNSxQy2BlnkY
         8oZGdkoKs22iA==
Date:   Thu, 21 Jul 2022 14:34:52 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] drivers: lkdtm: fix clang -Wformat warning
Message-ID: <YtnGfFuYhQrbed76@dev-arch.thelio-3990X>
References: <20220721212012.4060328-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721212012.4060328-1-justinstitt@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 02:20:12PM -0700, Justin Stitt wrote:
> When building with Clang we encounter the following warning
> (ARCH=hexagon + CONFIG_FRAME_WARN=0):
> | ../drivers/misc/lkdtm/bugs.c:107:3: error: format specifies type
> | 'unsigned long' but the argument has type 'int' [-Werror,-Wformat]
> |                 REC_STACK_SIZE, recur_count);
> |                 ^~~~~~~~~~~~~~
> 
> Cast REC_STACK_SIZE to `unsigned long` to match format specifier `%lu`.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

I think this is the right fix, as REC_STACK_SIZE will be 'unsigned long'
when CONFIG_FRAME_WARN is greater than 0 due to the _AC(..., UL) macro,
so the other one should match too. THREAD_SIZE might not be an unsigned
long; I see at least hexagon, microblaze, m68k, powerpc, and sh that
define it as either a regular integer literal with no suffix or
'1 << THREAD_SHIFT', which will both be of type 'int'.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Reported by Nathan here:
> https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/
> 
>  drivers/misc/lkdtm/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 009239ad1d8a..6381255aaecc 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -29,7 +29,7 @@ struct lkdtm_list {
>  #if defined(CONFIG_FRAME_WARN) && (CONFIG_FRAME_WARN > 0)
>  #define REC_STACK_SIZE (_AC(CONFIG_FRAME_WARN, UL) / 2)
>  #else
> -#define REC_STACK_SIZE (THREAD_SIZE / 8)
> +#define REC_STACK_SIZE ((unsigned long)(THREAD_SIZE / 8))
>  #endif
>  #define REC_NUM_DEFAULT ((THREAD_SIZE / REC_STACK_SIZE) * 2)
>  
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 
