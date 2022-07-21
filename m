Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C251A57D676
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiGUWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiGUWFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:05:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE8C1276C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42E53B826AE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 22:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8B2C3411E;
        Thu, 21 Jul 2022 22:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658441111;
        bh=LvcuNeaTxV66PvKnmvNrKgBUF+QpgGrAAwxXDjh8JUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3DUY5QpK02B5dyP6VKhqCfc4Wprfy7PsekVgbT+uZHlTLs7zs2uMX6j8SYxYODmf
         fd6/BKLrQdUINwXFcRl5s4Zc5awICjOyBDCn8xtSE83tx8ms0DAoiZDDrdU0k2+ntX
         wcCHAnGpX38gTRGrucevYNxUma2oOdca5cxEY986qgQoGxHVHupu+eckJr1PAHFDGT
         6a+TU9pgq6r/ynPe4h6HRluk5hQZf5BODrkCMnmXeRdvFXq6QTk9HLti5o5sFV9ANb
         GECQuhBZSwiVzeYGml/KmNhatDX1s8UZEfsdwZlWNrOo24NAaY4tUOVYNl8vhgKmyk
         FkP9JmivuHAWQ==
Date:   Thu, 21 Jul 2022 15:05:09 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     ndesaulniers@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, trix@redhat.com
Subject: Re: [PATCH v2] drivers: lkdtm: fix clang -Wformat warning
Message-ID: <YtnNlZYZCEVUiuaE@dev-arch.thelio-3990X>
References: <CAKwvOd=wn=tbX7ixs9a=4zoVSbAU1qP-6NE04hGG9dzvo0zFJw@mail.gmail.com>
 <20220721215706.4153027-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721215706.4153027-1-justinstitt@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 02:57:06PM -0700, Justin Stitt wrote:
> When building with Clang we encounter the following warning
> (ARCH=hexagon + CONFIG_FRAME_WARN=0):
> | ../drivers/misc/lkdtm/bugs.c:107:3: error: format specifies type
> | 'unsigned long' but the argument has type 'int' [-Werror,-Wformat]
> |                 REC_STACK_SIZE, recur_count);
> |                 ^~~~~~~~~~~~~~
> 
> Cast REC_STACK_SIZE to `unsigned long` to match format specifier `%lu`
> as well as maintain symmetry with `#define REC_STACK_SIZE
> (_AC(CONFIG_FRAME_WARN, UL) / 2)`.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>

Personally, I would drop this; my suggestion was the cast, which we are
not going with anymore. Not worth a v3 unless there are other changes
requested.

> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Reported by Nathan here:
> https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/
> 
> changes from v1 -> v2:
> * Use implicit division conversion with `/ nUL` instead of verbose
> `(unsigned long)` ~ Thanks Nick
> 
>  drivers/misc/lkdtm/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 009239ad1d8a..48821f4c2b21 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -29,7 +29,7 @@ struct lkdtm_list {
>  #if defined(CONFIG_FRAME_WARN) && (CONFIG_FRAME_WARN > 0)
>  #define REC_STACK_SIZE (_AC(CONFIG_FRAME_WARN, UL) / 2)
>  #else
> -#define REC_STACK_SIZE (THREAD_SIZE / 8)
> +#define REC_STACK_SIZE (THREAD_SIZE / 8UL)
>  #endif
>  #define REC_NUM_DEFAULT ((THREAD_SIZE / REC_STACK_SIZE) * 2)
>  
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 
> 
