Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E04D2360
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350498AbiCHVfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbiCHVfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:35:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A1B54BF8;
        Tue,  8 Mar 2022 13:34:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C61C0B81DA3;
        Tue,  8 Mar 2022 21:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D0DC340EB;
        Tue,  8 Mar 2022 21:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646775251;
        bh=7IIRlF+xZDsI23R5QSlPyFV9mzJNQRtaRJDooE6ATGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSW01JIzSWeneovsZAbjUGWOojs65aRPa9K80da79jozE3LE+NdwRKGVkzrsM7FIQ
         9Ur7mfuONJDFbBf9hMHEjtutYfCBBWxJwCuUmm25BTll7XitXVF9W/ysDezVHXt8RB
         8g5bvPdT3LtrBtSn6XoUr1Bw9JZUdJWvF67eBazA6wMcvqyq2zb5cnw0F+PjR9J1H4
         isjMZ6dfA6BHB9I83eX/6Ov3PVgLSdzVfuakCt7UYoT7ICJRiS2YvItMOA88F91gN7
         Ntp7TfykOROEBPCUD8INtR2Vi8i84omMucaOaqOYxfeWCvg1XuO/lUH4KjUFyw2pR8
         pikqIdlIMuKXw==
Date:   Tue, 8 Mar 2022 14:34:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Fangrui Song <maskray@google.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] kbuild: add --target to correctly cross-compile UAPI
 headers with Clang
Message-ID: <YifLzLl4IE/xFMdn@dev-arch.thelio-3990X>
References: <20220305125605.149913-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305125605.149913-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 09:56:05PM +0900, Masahiro Yamada wrote:
> When you compile-test UAPI headers (CONFIG_UAPI_HEADER_TEST=y) with
> Clang, they are currently compiled for the host target (likely x86_64)
> regardless of the given ARCH=.
> 
> In fact, some exported headers include libc headers. For example,
> include/uapi/linux/agpgart.h includes <stdlib.h> after being exported.
> The header search paths should match to the target we are compiling
> them for.
> 
> Pick up the --target triple from KBUILD_CFLAGS in the same ways as
> commit 7f58b487e9ff ("kbuild: make Clang build userprogs for target
> architecture").
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I suspect that Android will still need to do something with USERCFLAGS
in its build wrapper to pick up the correct libc (Bionic vs. glibc) but
that is tangential to this patch, we should still do this change
regardless.

> ---
> 
> Changes in v2:
>   - Reword the commit description to mention agpgart.h instead of
>     asound.h because the latter is in the no-header-test list.
> 
>  usr/include/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index ac206fb27c65..4215801e1110 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -10,7 +10,7 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
>  
>  # In theory, we do not care -m32 or -m64 for header compile tests.
>  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
> -UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
> +UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
>  
>  # USERCFLAGS might contain sysroot location for CC.
>  UAPI_CFLAGS += $(USERCFLAGS)
> -- 
> 2.32.0
> 
