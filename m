Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB7951ECE8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiEHKcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiEHKcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:32:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4ACDFBD
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 03:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 992DBB80D75
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 10:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0E9C385B3
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 10:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652005687;
        bh=lTqCp5J7KZYPMfSCve/gMBXjy4K1hDRCCDO9pSAkrCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jhm+liNuNsbsvNmvCYcx5p+Lt1dXtcVhg5oh5d9dnlbbrAyI+VIXxC5RNVnC5hiPy
         uDDWLcmtoMgqPvsgPlp9Y1Pz+L5szViBph1p66PawV2TDLp8r34OSESKNH45HCLUWS
         4jfmiT7kqfZNKFMKt95hpmk2myPCcTIXrT+RZJbibNA+KHHtvVFj9qKVAnXTWD40Rh
         9O7TvS4JtJ2abyxECgYZYsON3O++JsJpE3hrFD+SaBNcQBOOTkBiaxa35l5Sax5Mbc
         RWBK5JP82/A6c007XwSnBtQObSNS+4OD25hCjSJW9yWDjZKp4Hqc1Sj3kLKpCu05LH
         x0LuiLhfZgOuA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso118576117b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 03:28:07 -0700 (PDT)
X-Gm-Message-State: AOAM532ZmtAGGLAC/utQwBh0SfzizOm+9kcnOQPf/CWJfpVJegMoZE20
        MzxJQAPQ5rXOpVbIzSn9tsx55PQbQo2Lgli0Y50=
X-Google-Smtp-Source: ABdhPJx1enxRFFVVUEhNzg0zrvmj8KrLesGxusj+Va47XXliX8c5Gdd3wKWfovwycjdDspSk70LOhFKJwYet7yHXbOU=
X-Received: by 2002:a81:2305:0:b0:2f7:dadb:2162 with SMTP id
 j5-20020a812305000000b002f7dadb2162mr9219506ywj.42.1652005686253; Sun, 08 May
 2022 03:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr> <20220508100907.61231-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220508100907.61231-1-mailhol.vincent@wanadoo.fr>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 8 May 2022 12:27:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Fw2T0WSkxv4DiTG2wGkKcs24StPx-BG_vi=ffa9OLVA@mail.gmail.com>
Message-ID: <CAK8P3a3Fw2T0WSkxv4DiTG2wGkKcs24StPx-BG_vi=ffa9OLVA@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] x86/build: add -fno-builtin flag to prevent shadowing
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 8, 2022 at 12:09 PM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> Aside of the __builtin_foo() ones, x86 does not directly rely on any
> builtin functions.
>
> However, such builtin functions are not explicitly deactivated,
> creating some collisions, concrete example being ffs() from bitops.h,
> c.f.:
>
> | ./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs' shadows a built-in function [-Wshadow]
> |   283 | static __always_inline int ffs(int x)
>
> This patch adds -fno-builtin to KBUILD_CFLAGS for the x86
> architectures in order to prevent shadowing of builtin functions.
>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> FYI, I tested this patch on a "make allyesconfig" for both x86_32 and
> x86_64.
>
> This is a resend. Only difference is that I dropped the RFC flag and
> added Arnd in CC because he did a similar patch to fix ffs shadow
> warnings in the past:
>
> https://lore.kernel.org/all/20201026160006.3704027-1-arnd@kernel.org/

I think this is a correct change, but unfortunately it exposes a clang bug
 with -mregparm=3. Nick should be able to provide more details, I think
he has a plan.

> ---
>  arch/x86/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index e84cdd409b64..5ff7b6571dd2 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -53,6 +53,8 @@ export REALMODE_CFLAGS
>  # e.g.: obj-y += foo_$(BITS).o
>  export BITS
>
> +KBUILD_CFLAGS += -fno-builtin
> +
>  #
>  # Prevent GCC from generating any FP code by mistake.
>  #
> --
> 2.34.1
>
