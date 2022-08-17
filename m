Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6059770B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbiHQTow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbiHQTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:44:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268FE26
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:44:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jl18so5039650plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+OZ/5bQF40s37Fa6tM5DQdE3Vk1tx4PHZdxoOH4WI2I=;
        b=FDoXJkM5SdlAJajohu2gaEzhtWxFgu8Q7Nv1cHzZ+vOqsIHhWLkPPn0Ofsc59VnPix
         HvocUpM6HGbN5Ne6yODd5JTPnUQDkWXIN4q+eW+XzTsZbTcvlOQlSQzbd4j5wjTnPZA2
         C0aJ5bBbjypplDmJ9mXe3hZn7vnuX3KqXaPpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+OZ/5bQF40s37Fa6tM5DQdE3Vk1tx4PHZdxoOH4WI2I=;
        b=kb25F2WPSXL11t7EjPfibpXY5Ns5FJtVHZvdXXvlYU1hdR6rmnAnG3/8wmIrCXS9eC
         nzS7vlqwKgpm6JxwcV+VKFCvzI2EzWQMam+Aityw/u4/YfNAt4s6L46KGFsx6UpuhX7D
         wvIY32sUCr5nbP1fsm0x2eztohbVVEYCCjNlIIxv+GvhcJwxwBFB/F0lSGz+vaHyYdc5
         a79XaE60G3NYxkEEzFz/WFLRG+Wi7n3Zry7Lr7TP8yQvu9XCaCmpM9ABIIlCjJ+af7Go
         iSZKNAWz/L6Nc/VuCd6yQkb26SmNm1HlJTvVsan80k5aDX+Na34erUJCGc0BBaaTV/Gu
         64Mw==
X-Gm-Message-State: ACgBeo27hQrUJL05dDy1Zl8RrxIBq3tE7R5whV8vwZGzTarvIuSd+aYX
        n99SNomC5lVN+SkUFG4MuWPudw==
X-Google-Smtp-Source: AA6agR7eUrlWKcz3P98uwKH5BeSncJ3YjJrFQ5ojIIhW3Rd59bOmpIlH9h5doqqHgc0MBF6T7yRNzQ==
X-Received: by 2002:a17:902:f7cf:b0:172:9ca3:3052 with SMTP id h15-20020a170902f7cf00b001729ca33052mr3759074plw.77.1660765483175;
        Wed, 17 Aug 2022 12:44:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t7-20020a634607000000b0041b5b929664sm9670814pga.24.2022.08.17.12.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 12:44:42 -0700 (PDT)
Date:   Wed, 17 Aug 2022 12:44:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Wei Liu <wei.liu@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v9 06/27] rust: add C helpers
Message-ID: <202208171240.8B10053B9D@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-7-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-7-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:41:51PM +0200, Miguel Ojeda wrote:
> This source file contains forwarders to C macros and inlined
> functions.

Perhaps:

"Introduce the source file that will contain forwarders to common C
macros as inlined Rust functions. Initially this only contains type
size asserts, but will gain more helpers in subsequent patches."

> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Geoffrey Thomas <geofft@ldpreload.com>
> Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/helpers.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 rust/helpers.c
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> new file mode 100644
> index 000000000000..b4f15eee2ffd
> --- /dev/null
> +++ b/rust/helpers.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Non-trivial C macros cannot be used in Rust. Similarly, inlined C functions
> + * cannot be called either. This file explicitly creates functions ("helpers")
> + * that wrap those so that they can be called from Rust.
> + *
> + * Even though Rust kernel modules should never use directly the bindings, some
> + * of these helpers need to be exported because Rust generics and inlined
> + * functions may not get their code generated in the crate where they are
> + * defined. Other helpers, called from non-inline functions, may not be
> + * exported, in principle. However, in general, the Rust compiler does not
> + * guarantee codegen will be performed for a non-inline function either.
> + * Therefore, this file exports all the helpers. In the future, this may be
> + * revisited to reduce the number of exports after the compiler is informed
> + * about the places codegen is required.
> + *
> + * All symbols are exported as GPL-only to guarantee no GPL-only feature is
> + * accidentally exposed.
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/build_bug.h>
> +
> +__noreturn void rust_helper_BUG(void)
> +{
> +	BUG();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_BUG);

Given the distaste for ever using BUG()[1], why does this helper exist?

> +
> +/*
> + * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
> + * as the Rust `usize` type, so we can use it in contexts where Rust
> + * expects a `usize` like slice (array) indices. `usize` is defined to be
> + * the same as C's `uintptr_t` type (can hold any pointer) but not
> + * necessarily the same as `size_t` (can hold the size of any single
> + * object). Most modern platforms use the same concrete integer type for
> + * both of them, but in case we find ourselves on a platform where
> + * that's not true, fail early instead of risking ABI or
> + * integer-overflow issues.
> + *
> + * If your platform fails this assertion, it means that you are in
> + * danger of integer-overflow bugs (even if you attempt to remove
> + * `--size_t-is-usize`). It may be easiest to change the kernel ABI on
> + * your platform such that `size_t` matches `uintptr_t` (i.e., to increase
> + * `size_t`, because `uintptr_t` has to be at least as big as `size_t`).
> + */
> +static_assert(
> +	sizeof(size_t) == sizeof(uintptr_t) &&
> +	__alignof__(size_t) == __alignof__(uintptr_t),
> +	"Rust code expects C `size_t` to match Rust `usize`"
> +);

-Kees

[1] https://docs.kernel.org/process/deprecated.html#bug-and-bug-on

-- 
Kees Cook
