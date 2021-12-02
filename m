Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA9466558
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358601AbhLBOjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358563AbhLBOjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:39:41 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B229C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 06:36:19 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id t19so55881539oij.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 06:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lc5f8V7U1qeIZMO/3oPn6uEImdj6hfKGGM9TNkHj2Xk=;
        b=HWplDAiYE/bfYKcxYxJZTdeU94qjLg13BvzdPO4g7ih9KOKMe2SrJtUcEHelW3SHAz
         VSEr4hgGVpQo1cAzH09mGF+9fj7Pj3WIgnBZKBiN2ajivkM7MK1nUlk3JoteFCYz67sR
         ZR3weVDCtWuSRSF6kWiFOjhhMOpfSXaH0KDswyKfc3TnEHp+R0l54oSNFc2f+VCpdohL
         ISlicDg1KT1zM2R5rdykFeujqPuROa0/oWFs0/BlVPvx5/q4MMknOQA0xANVQKtZ2ujw
         xJ4Fi7+odqxOibQZvzunJcLbADcdyxTBkDgp1CcrRwF/+FNExhlbYJM9fCTH2KuezQTZ
         Xrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lc5f8V7U1qeIZMO/3oPn6uEImdj6hfKGGM9TNkHj2Xk=;
        b=iXet+6OKQPbxRLxqTBkBdM4OT4MIIpw2Fd2VbxhngIOV4g98uwS37q2wW3SugcVfmQ
         SVmlKCxzLOhrlnBia3fzRzdCJ39QrlFMhgLsu7OGtNe7NnX52F+JHiFe2z3YgqqofJbG
         hnmLDKH3W/z95rfScTh3jzTGuN+CH4rFDn0qEnauTjXOm1oTukmeF6gNkTo95+SIssXp
         9jUdiV4QP3SvctPLXlDhHzrDMi2sH+X1AIlDgicS05NzSf6uxG0UA29iw6Sg7aZ9IlYs
         oUtC9liqQ0yg1bj1YLPyOGdYiBXglfSZxi6CNJHSPMlGouJiMECbdt+EygBih3buog4N
         5WXw==
X-Gm-Message-State: AOAM530rqD8N9eZOa7tzIsmY7FRa6rzVfg/lhXyKKJXx0u3XV5ZUxB8J
        TwOkQe+0w6jysiATguxvEf4Ss5ON1tPLPRFKdCGko7w+o0sUGg==
X-Google-Smtp-Source: ABdhPJww3T7wVoEMLLphTGCtsexdTb9S+iBjJpV6IYKDAw3axBzsEcnpum0KKk+vtDsuZTG452EOwcToO/wTPIdP54c=
X-Received: by 2002:a05:6808:1903:: with SMTP id bf3mr4698798oib.7.1638455778073;
 Thu, 02 Dec 2021 06:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20211202143331.15259-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20211202143331.15259-1-wangkefeng.wang@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Dec 2021 15:36:06 +0100
Message-ID: <CANpmjNO5DUk=biDkfP9iepKYBeROO8wL58n8HziOTXuRMOXpvQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: Enable KCSAN
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 at 15:23, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> This patch enables KCSAN for arm64, with updates to build rules
> to not use KCSAN for several incompatible compilation units.
>
> Resent GCC version(at least GCC10) made outline-atomics as the

s/Resent/Recent/

> default option(unlike Clang), which will cause linker errors
> for kernel/kcsan/core.o. Disables the out-of-line atomics by
> no-outline-atomics to fix the linker errors.
>
> Meanwhile, as Mark said[1], there is a specific issue on arm64
> about ARM64_BTI with Clang 11 if KCSAN enabled, which is fixed
> by Clang 12, add CLANG_VERSION check. And also some latent issues
> are need to be fixed which isn't just a KCSAN problem, we make
> the KCSAN depends on EXPERT for now.
>
> Tested selftest and kcsan_test(built with GCC11 and Clang 13),
> and all passed.
>
> [1] https://lkml.org/lkml/2021/12/1/354

Please use lore/kernel.org permalinks. For this one it'd be:
https://lkml.kernel.org/r/YadiUPpJ0gADbiHQ@FVFF77S0Q05N

(But I think if this is the final version of the patch, hopefully a
maintainer can amend the commit message.)

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Marco Elver <elver@google.com> # kernel/kcsan

is still valid, given nothing changed there. I leave the rest to Mark.

Thanks,
-- Marco

> ---
> Tested on Qemu with clang 13 / gcc 11, based on 5.16-rc3.
>
> [    0.221518] kcsan: enabled early
> [    0.222422] kcsan: strict mode configured
> ...
> [    5.839223] kcsan: selftest: 3/3 tests passed
> ...
> [  517.895102] # kcsan: pass:24 fail:0 skip:0 total:24
> [  517.896393] # Totals: pass:168 fail:0 skip:0 total:168
> [  517.897502] ok 1 - kcsan
>
> v3:
> - add EXPERT and CLANG_VERSION depends suggested by Mark Rutland
> v2:
> - tested on GCC11 and disable outline-atomics for kernel/kcsan/core.c
>   suggested by Marco Elver
>
>  arch/arm64/Kconfig               | 1 +
>  arch/arm64/kernel/vdso/Makefile  | 1 +
>  arch/arm64/kvm/hyp/nvhe/Makefile | 1 +
>  kernel/kcsan/Makefile            | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4ff73299f8a9..3a7b17742cde 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -150,6 +150,7 @@ config ARM64
>         select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
>         select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
>         select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
> +       select HAVE_ARCH_KCSAN if EXPERT && (CC_IS_GCC || CLANG_VERSION >= 120000)
>         select HAVE_ARCH_KFENCE
>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_MMAP_RND_BITS
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 700767dfd221..60813497a381 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -32,6 +32,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
>  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
>                                 $(CC_FLAGS_LTO)
>  KASAN_SANITIZE                 := n
> +KCSAN_SANITIZE                 := n
>  UBSAN_SANITIZE                 := n
>  OBJECT_FILES_NON_STANDARD      := y
>  KCOV_INSTRUMENT                        := n
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index c3c11974fa3b..24b2c2425b38 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -89,6 +89,7 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI)
>  # cause crashes. Just disable it.
>  GCOV_PROFILE   := n
>  KASAN_SANITIZE := n
> +KCSAN_SANITIZE := n
>  UBSAN_SANITIZE := n
>  KCOV_INSTRUMENT        := n
>
> diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> index c2bb07f5bcc7..e893b0e1d62a 100644
> --- a/kernel/kcsan/Makefile
> +++ b/kernel/kcsan/Makefile
> @@ -8,6 +8,7 @@ CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
>
>  CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
> +       $(call cc-option,-mno-outline-atomics) \
>         -fno-stack-protector -DDISABLE_BRANCH_PROFILING
>
>  obj-y := core.o debugfs.o report.o
> --
> 2.26.2
>
