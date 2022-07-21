Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF0A57D636
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiGUVm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiGUVm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:42:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5570936AA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:42:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a10so3382474ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRbqgW25Md992aZiFQNaLfMNuOXLSkIclPSTYF16KUU=;
        b=kI3RWq6qU86SvhXJ+n4czGx32GlH4FX7gQPfGn/pCa+Z8RzNmoP1Z6qIBESW7Kr+25
         SpDwme5otXH0/kXwSzId0A2MvBEcMqpD9IN/UpRs+w+9oUS5SEBn9eNYe2plOp0AynYL
         OjltcH/TTdeL+Bi5wTm9B4D5uh0aZTVp1qKCIbMpti2LAAcCtpT8e/xe9P0SyX/lCH+b
         X2FSuTg87lwBMuJ4h27KrXBbdJt4kZdMJOHFAQXnY233rTuuM+lNnHTusvpbUicBjdNZ
         eJzxUSUosPMukXDVLdoGfH2HmvzJkiIwGKydvsOh5RJY5jNHpA4ry1QVsHjXwwMoyOG/
         uZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRbqgW25Md992aZiFQNaLfMNuOXLSkIclPSTYF16KUU=;
        b=fTgAQ2wVAOO2x68RnKMWhjlAkN5MUhHpvIhcStH++JGU+h9c2OOm6smAi/wVxBfjMU
         6BJ8FVPNnmI+4uonvQIY3216XdP1PkIxL0RKcgfVHaUjzMR5LL5n4+ueMkazl+FPjEkz
         V5TGXIL2yO/RTOqWqQ0FDprFoB0o+Fn4mVFw7N656tmEYMJJ4gL4TktxbMkXeniWGsNH
         hDRIbOI0tZvJaHHebLLiqvF8HUhCkhYBW1+Tu5TShS7uKkalJMIXAH8wUW/8VslT5one
         TIQChEyGyIh74IOzH52ODeH9drAdmAUZPl6DrfCrZoHBaPkdkDywKNAyg0+S1fI9Dvhv
         qBDQ==
X-Gm-Message-State: AJIora8BMZfRE+gDqhL6qkUQRKlJ+JAK/MufLtw4S3fJhdCSITruh5Zc
        qgbB3ImqxrkLOMGJ33hksAmB9KlFvCn/W9XPpKVT7A==
X-Google-Smtp-Source: AGRyM1vOumvDj2RLhisOcU/m0l4DiaopArK0kFTBoJQSufKneeNaEsTSPD2PHZBdOJhBe2j7q/PVSkIkkssHHXRraU4=
X-Received: by 2002:a2e:3109:0:b0:25a:8a0c:40e2 with SMTP id
 x9-20020a2e3109000000b0025a8a0c40e2mr120698ljx.26.1658439741750; Thu, 21 Jul
 2022 14:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220721212012.4060328-1-justinstitt@google.com>
In-Reply-To: <20220721212012.4060328-1-justinstitt@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Jul 2022 14:42:10 -0700
Message-ID: <CAKwvOd=wn=tbX7ixs9a=4zoVSbAU1qP-6NE04hGG9dzvo0zFJw@mail.gmail.com>
Subject: Re: [PATCH] drivers: lkdtm: fix clang -Wformat warning
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 2:20 PM Justin Stitt <justinstitt@google.com> wrote:
>
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

`THREAD_SIZE / 8UL` might be more concise.

>  #endif
>  #define REC_NUM_DEFAULT ((THREAD_SIZE / REC_STACK_SIZE) * 2)
>
> --
> 2.37.1.359.gd136c6c3e2-goog
>


-- 
Thanks,
~Nick Desaulniers
