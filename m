Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB747D370
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245619AbhLVORT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245613AbhLVORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:17:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4517C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:17:17 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A4321EC02B9;
        Wed, 22 Dec 2021 15:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640182630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FlZoGghMQ4khREtqfrp9Oqc2mFbGrigf9icoHLNBM9o=;
        b=ZX1/NyBT2AobUlbwM+QU+FJPRbuuu9+9OhtcDwO1pEz5LuEA/aAcH80njhZlZY4UU8Qczn
        +FkLZ2StBMlq9gATRaAX+/81UCxehmEdx1ryz3lFTYlcj45dwFA1DGzRt+KJSlTW/PFDsw
        ztvsQ9ytva5P7v9u9FPd4MkwIT7f0W0=
Date:   Wed, 22 Dec 2021 15:17:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/boot/compressed: Move CLANG_FLAGS to beginning of
 KBUILD_CFLAGS
Message-ID: <YcMzaBPBF+0rUeag@zn.tnic>
References: <20211222005245.3081136-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211222005245.3081136-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 05:52:45PM -0700, Nathan Chancellor wrote:
> When cross compiling i386_defconfig on an arm64 host with clang, there
> are a few instances of '-Waddress-of-packed-member' and
> '-Wgnu-variable-sized-type-not-at-end' in arch/x86/boot/compressed/,
> which should both be disabled with the cc-disable-warning calls in that
> directory's Makefile, which indicates that cc-disable-warning is failing
> at the point of testing these flags.
> 
> The cc-disable-warning calls fail because at the point that the flags
> are tested, KBUILD_CFLAGS has '-march=i386' without $(CLANG_FLAGS),
> which has the '--target=' flag to tell clang what architecture it is
> targeting. Without the '--target=' flag, the host architecture (arm64)
> is used and i386 is not a valid value for '-march=' in that case. This
> error can be seen by adding some logging to try-run:
> 
> clang-14: error: the clang compiler does not support '-march=i386'
> 
> Invoking the compiler has to succeed prior to calling cc-option or
> cc-disable-warning in order to accurately test whether or not the flag
> is supported; if it doesn't, the requested flag can never be added to
> the compiler flags. Move $(CLANG_FLAGS) to the beginning of KBUILD_FLAGS
> so that any new flags that might be added in the future can be
> accurately tested.
> 
> Fixes: d5cbd80e302d ("x86/boot: Add $(CLANG_FLAGS) to compressed KBUILD_CFLAGS")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/x86/boot/compressed/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 431bf7f846c3..169186dba1d7 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -28,7 +28,7 @@ KCOV_INSTRUMENT		:= n
>  targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>  	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
>  
> -KBUILD_CFLAGS := -m$(BITS) -O2
> +KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)

I don't mind but this makes the placement of that variable magical so it
needs a comment above it that it cannot be moved around freely and why
that is the case.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
