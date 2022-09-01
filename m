Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10535A9E98
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiIASHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiIASGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:06:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B331114E;
        Thu,  1 Sep 2022 11:06:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2951061456;
        Thu,  1 Sep 2022 18:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA638C433D6;
        Thu,  1 Sep 2022 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662055608;
        bh=dx+lbNdZhrbcSwJy0QSUk/lhfZMvh0A57p9uFTmJk8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CN399PbRaB4h4fOuo/mP+ZJlQs4+eg5E6oM/kEo5LjYIqb3F0LrrpJM09OblTL9sl
         twDItFo5WWfzH5JkAwkJLB+eXX2n0GufLvK2ceWKnBvCM7uKfy3cItK2Drs0xKcoeL
         1RMJzUWGI5nzSM8eDEMjui8wdcqHaQZGPnqBJ13Si/KKy4VJ9CjXery9Vr3FX2Ivot
         kfzAPNdN7QHJkRUEdFt1ZWQ1T/pDJ6sHsHSEFdWGdyC6dm1j6k6MCwSPAkCYRQQtXQ
         7RKQlLKJh8fi88xp+C8SsToLORLvM+LDAnyNKhC6vRkafN+OK6BAG4SRG5I3p5jfhL
         fHHl6G0+oLXzw==
Date:   Thu, 1 Sep 2022 11:06:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Justin Stitt <jstitt007@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>
Subject: Re: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang; take 2
Message-ID: <YxD0tg4O1Y6MqP0X@dev-arch.thelio-3990X>
References: <CAHk-=wiW_LjFRE9wFMj-j2gp9=u8jqrMVZtT3n4-oJWtQ6E0iQ@mail.gmail.com>
 <20220901175913.2183047-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901175913.2183047-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:59:13AM -0700, Nick Desaulniers wrote:
> -Wformat was recently re-enabled for builds with clang, then quickly
> re-disabled, due to concerns stemming from the frequency of default
> argument promotion related warning instances.
> 
> commit 258fafcd0683 ("Makefile.extrawarn: re-enable -Wformat for clang")
> commit 21f9c8a13bb2 ("Revert "Makefile.extrawarn: re-enable -Wformat for clang"")
> 
> ISO WG14 has ratified N2562 to address default argument promotion
> explicitly for printf, as part of the upcoming ISO C2X standard.
> 
> The behavior of clang was changed in clang-16 to not warn for the cited
> cases in all language modes.
> 
> Add a version check, so that users of clang-16 now get the full effect
> of -Wformat. For older clang versions, re-enable flags under the
> -Wformat group that way users still get some useful checks related to
> format strings, without noisy default argument promotion warnings. I
> intentionally omitted -Wformat-y2k and -Wformat-security from being
> re-enabled, which are also part of -Wformat in clang-16.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Link: https://github.com/llvm/llvm-project/issues/57102
> Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2562.pdf
> Suggested-by: Justin Stitt <jstitt007@gmail.com>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Youngmin Nam <youngmin.nam@samsung.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Linus, I figured I'd send this to you to see whether you'd prefer to
> apply it, or let it "ride the trains" up through the kbuild tree? I do
> have another series I'm working on to improve the compiler version
> checks
> <https://lore.kernel.org/llvm/20220831184408.2778264-4-ndesaulniers@google.com/>
> where I can/will improve the checks used here, but I'm also interested in
> having something that might backport cleanly to stable.
> 
>  scripts/Makefile.extrawarn | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 0621c39a3955..6ae482158bc4 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -47,7 +47,19 @@ else
>  
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CFLAGS += -Wno-initializer-overrides
> +# Clang before clang-16 would warn on default argument promotions.
> +ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -lt 160000 ] && echo y),y)
> +# Disable -Wformat
>  KBUILD_CFLAGS += -Wno-format
> +# Then re-enable flags that were part of the -Wformat group that aren't
> +# problematic.
> +KBUILD_CFLAGS += -Wformat-extra-args -Wformat-invalid-specifier
> +KBUILD_CFLAGS += -Wformat-zero-length -Wnonnull
> +# Requires clang-12+.
> +ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -ge 120000 ] && echo y),y)
> +KBUILD_CFLAGS += -Wformat-insufficient-args
> +endif
> +endif
>  KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
>  KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
> 
> base-commit: 2880e1a175b9f31798f9d9482ee49187f61b5539
> -- 
> 2.37.2.789.g6183377224-goog
> 
