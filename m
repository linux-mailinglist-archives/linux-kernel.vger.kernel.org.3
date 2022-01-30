Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DCE4A38C3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiA3Tzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:55:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57208 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiA3Tzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:55:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FF21B82990;
        Sun, 30 Jan 2022 19:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A452AC340E4;
        Sun, 30 Jan 2022 19:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643572548;
        bh=4zb5UhaLqOlfRtVbPkkYmuMWAyxQjIa7QavGlkoM4eY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmpQdk6vxwUc5/7Me6VbFqowflhqyb21APAhIUHdRbQqNByAIP3Yy97ZJuFCKVCl8
         Fdu3jHEYvu9313W7EalsU8hopwAMfD07RixFPkXR3EZrvhFppLmdf0E/KgMUqWHnx/
         05jS6ZyQeyl9kZYjBqmsy1vTis38vM0FsZMN2C6QHyls0JtlXYqynIHzaQ2K8/lNWP
         PrCDa/B+FI6ywZO77WLb//H/6Rgy3x/DhycYIX2O6VwTq3sHNQ67+V9C68Ix2GLr/0
         Sen4s7oAuED/2zCfpUeN7xh704ZRLehX9H/mvdN3QdxZJiD7t6JMzoIZs0/6LZ0ZyG
         covhJhvsAIvSw==
Date:   Sun, 30 Jan 2022 12:55:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fortify: Update compile-time tests for Clang 14
Message-ID: <YfbtQKtpyAM1hHiC@dev-arch.archlinux-ax161>
References: <20220130181616.420092-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130181616.420092-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 10:16:16AM -0800, Kees Cook wrote:
> Clang 14 introduces support for compiletime_assert(). Update the
> compile-time warning regex to catch Clang's variant of the warning text
> in preparation for Clang supporting CONFIG_FORTIFY_SOURCE.
> 
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-hardening@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> I'm splitting this patch out of the main Clang FORTIFY enabling patch.
> ---
>  scripts/test_fortify.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/test_fortify.sh b/scripts/test_fortify.sh
> index a4da365508f0..c2688ab8281d 100644
> --- a/scripts/test_fortify.sh
> +++ b/scripts/test_fortify.sh
> @@ -46,8 +46,12 @@ if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then
>  		status="warning: unsafe ${FUNC}() usage lacked '$WANT' symbol in $IN"
>  	fi
>  else
> -	# If the build failed, check for the warning in the stderr (gcc).
> -	if ! grep -q -m1 "error: call to .\b${WANT}\b." "$TMP" ; then
> +	# If the build failed, check for the warning in the stderr.
> +	# GCC:
> +	# ./include/linux/fortify-string.h:316:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> +	# Clang 14:
> +	# ./include/linux/fortify-string.h:316:4: error: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> +	if ! grep -Eq -m1 "error: call to .?\b${WANT}\b.?" "$TMP" ; then
>  		status="warning: unsafe ${FUNC}() usage lacked '$WANT' warning in $IN"
>  	fi
>  fi
> -- 
> 2.30.2
> 
