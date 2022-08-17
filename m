Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9A59797F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbiHQWIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiHQWIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:08:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7BE67473
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:08:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so20720003lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MdXe9v7V/n49BLfPIm7mAPC3zaXea5taJTJFdb6i330=;
        b=ad2R800fXpR9dwOXrfOT66zX7atkDbWCJuzExzeA9SOHu6hrhhW8FD8ZkdBXt3Kkvz
         p5k4JJVQcAihCgjScizrSXVM3UdAV4Zh3VB8ZMz6m4XaheZD4gJUsX53gDk3DJh3phIv
         Jh+RrCh9xONalatJVG1gRFh7dkx6m1j17YDDM4wqkLvpzWQyk9M1dQ89vS7yktQjlyrY
         nSWyuVfMRdfAK0GBQKm0OiruU5DHNr7/F/jDfH9hXxUO1XQjUKfnoZCtLgIc6RPEobpj
         rRMXGAl/y44i9E9X207ThzhY3fB/MJhKPsB6QDT9zugoQhc4vkvZf0dG80xd5hfJ+VrR
         A5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MdXe9v7V/n49BLfPIm7mAPC3zaXea5taJTJFdb6i330=;
        b=5aeDIVaIk3Ec6VsTFRdQYE+mt8kUuUi1QQPzSsvCouTOcZoQZry2sI9bCDu0S5xF8v
         iruscSfSP09Vo8tjgtRFuiNXH3k8OCHnP+GAv2R5CR8VjyGJ9Dp9PtoLVvTgEHGdWcHR
         V6DnasEKbyPzNIDePDpMlkRRwOup+jAEfPyT9CQfxpkB311zfGtjCsh1anC8CaTpE6zJ
         QFcNS2GFkk8O0tBQ5hgnRlgOU0foWyaBjaKKTuSPGP/lVdtfzAQ7TTpr7RTJqp09vEoD
         SK54m3vl2pELcY90qQfyUm5PT99iE1kaSKO+COcwxmOg/fF+sUw8Wrq7vJNwEGWGCK2G
         4jyg==
X-Gm-Message-State: ACgBeo0H+/5xlyGNmnZNWkf74MWkBFG9HUOe8RiG6YHbQSQwMcLyftH+
        jknYiyC9oy7lu8w0pIMM0/Q05lJSRtTydN4R3X/ZKQ==
X-Google-Smtp-Source: AA6agR6bbMV/+NnYEX/0CwW9iDlRuDXiyrW9k/uewNGpLosZ7a2gJKZGRauS38UPO+Ee/bRdMTB7b5oOC3RJt7neQAs=
X-Received: by 2002:ac2:4f03:0:b0:48a:6061:bd8e with SMTP id
 k3-20020ac24f03000000b0048a6061bd8emr59229lfr.647.1660774094305; Wed, 17 Aug
 2022 15:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220817185410.1174782-1-nathan@kernel.org>
In-Reply-To: <20220817185410.1174782-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 Aug 2022 15:08:01 -0700
Message-ID: <CAKwvOd=0R76r6YqNiOhGNt_XrA_t_ZbuBbNNdNXV4CWpDy0+Bg@mail.gmail.com>
Subject: Re: [PATCH] x86/build: Move '-mindirect-branch-cs-prefix' out of
 GCC-only block
To:     Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:56 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> LLVM 16 will have support for this flag so move it out of the GCC-only
> block to allow LLVM builds to take advantage of it.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1665
> Link: https://github.com/llvm/llvm-project/commit/6f867f9102838ebe314c1f3661fdf95700386e5a
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch, I also boot tested this (in virtual guests for
both 64b and 32b).

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Peter, is there anything else special about these prefixes needed to
make use of them?

> ---
>
> I was not sure if this information is relevant for the commit message
> but I can boot without any issues on my test machines (two Intel and one
> AMD).
>
>  arch/x86/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 7854685c5f25..987da87c7778 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -14,13 +14,13 @@ endif
>
>  ifdef CONFIG_CC_IS_GCC
>  RETPOLINE_CFLAGS       := $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
> -RETPOLINE_CFLAGS       += $(call cc-option,-mindirect-branch-cs-prefix)
>  RETPOLINE_VDSO_CFLAGS  := $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
>  endif
>  ifdef CONFIG_CC_IS_CLANG
>  RETPOLINE_CFLAGS       := -mretpoline-external-thunk
>  RETPOLINE_VDSO_CFLAGS  := -mretpoline
>  endif
> +RETPOLINE_CFLAGS       += $(call cc-option,-mindirect-branch-cs-prefix)
>
>  ifdef CONFIG_RETHUNK
>  RETHUNK_CFLAGS         := -mfunction-return=thunk-extern
>
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> --
> 2.37.2
>
>


-- 
Thanks,
~Nick Desaulniers
