Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999EA4BA7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbiBQSLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:11:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240897AbiBQSLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6BF1728AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:10:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD5EAB8236E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A23C340ED;
        Thu, 17 Feb 2022 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645121446;
        bh=Hi+Ar05nZMqm8BXX26kxdr85zbba8q8TbryW7LweA3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVCs7ejqocuGzwtHq/5DmqXZibFcA9pvBc3lf4cteChr/P/9a1sWX6e2+cjVrjwnm
         43wkg2S7U5Of5PsoezfEdaf6aP1+4sOGbRCzRHbqDmV6WUmf6qHbvLR/i3lPqr5562
         ZHLJOiIlX8xGnLGX/Mq8vVnCPrP28kKHx63MUV2w9vbRXqSOc9HANNVPU2gZpp2zVy
         ZAZFGfUR7MRXXW4Ezu+oLMeDdnAEjndCLSP/5VviFJcN1hC6nhvtv0lTxkCTiq37Ui
         iPSWwwkY4f035I7fg/+17T4uofEMKcdVpcIcYjAWc6jpsq7DQdi+vSgM5PLmEtO3/V
         ULBidDjnnvp9g==
Date:   Thu, 17 Feb 2022 11:10:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.com>
Subject: Re: [PATCH] tools: fix unavoidable GCC call in Clang builds
Message-ID: <Yg6PousYSZXimFCS@dev-arch.archlinux-ax161>
References: <20220217033648.1453303-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217033648.1453303-1-adrian.ratiu@collabora.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian

On Thu, Feb 17, 2022 at 05:36:48AM +0200, Adrian Ratiu wrote:
> In ChromeOS and Gentoo we catch any unwanted mixed Clang/LLVM
> and GCC/binutils usage via toolchain wrappers which fail builds.

Neat for hermetic builds.

> This has revealed that GCC is called unconditionally in Clang
> configured builds to populate GCC_TOOLCHAIN_DIR.
> 
> Allow overriding the variable to avoid the GCC call - in our
> case we can set GCC_TOOLCHAIN_DIR directly in the ebuild recipe.

Would you just set GCC_TOOLCHAIN_DIR to nothing to avoid triggering the
'gcc -print-sysroot' call?

An alternative might be allowing CLANG_CROSS_FLAGS to be supplied by the
user, so that you can stil benefit from cross compiling tools, but with
the flags and sysroot that you expect.

> Suggested-by: Manoj Gupta <manojgupta@chromium.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

Regardless, as long as it works for your use case:

Acked-by: Nathan Chancellor <nathan@kernel.org>

The change that this patch fixes [1] went via bpf-next [2] last cycle,
you could either target that tree to have it fixed for 5.18 or make a
case for having it merged in the 5.17 cycle via bpf [3]. I would resend
this change to the kernel/bpf maintainers, as Nick and I do not
currently pick up patches.

[1]: https://lore.kernel.org/r/20211216163842.829836-2-jean-philippe@linaro.org/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/

> ---
>  tools/scripts/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index 79d102304470..98c098c064dd 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -90,7 +90,7 @@ EXTRA_WARNINGS += -Wstrict-aliasing=3
>  
>  else ifneq ($(CROSS_COMPILE),)
>  CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
> -GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc 2>/dev/null))
> +GCC_TOOLCHAIN_DIR ?= $(dir $(shell which $(CROSS_COMPILE)gcc 2>/dev/null))
>  ifneq ($(GCC_TOOLCHAIN_DIR),)
>  CLANG_CROSS_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
>  CLANG_CROSS_FLAGS += --sysroot=$(shell $(CROSS_COMPILE)gcc -print-sysroot)
> -- 
> 2.35.0
> 
