Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1C4653C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351862AbhLARUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:20:22 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37036 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351824AbhLARUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:20:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D35D7CE1DC5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2980C53FCC;
        Wed,  1 Dec 2021 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638379003;
        bh=m4QfiTILg87tWxt/kfjtoKVqJF2k40c2px3xeNlJk9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkBZyK01ewyh9q4uDGAnOVjmQErjlM1r3b++EL27Qez5tP5QhbobJ9LePtCxYAOKE
         ME4fNuKs/XfPh8qtQ7xNDt+eyExB6jtzZUBKhDd1F1LHizJU5MIvQzpNuBzZyX99KT
         8qWGgmkxl8pXgHUuzzHnTfkU5K7OWaaiz97UxwtCE+3P46s3WUP/vQsff6sD/qpsd9
         KsLHjHR1nImLNwE/RstP4bAAFu7rxPISLKMltOWElDDfeKo/TbM22yQI8wWfRReUci
         /l8JprUo/rHJslfYjxF4NwElGUAt612tKxUchl+/+qGa9GyrGMosMaoNwIfupJ/4D2
         WNZ3eQZCR7OLg==
Date:   Wed, 1 Dec 2021 10:16:35 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kcov: fix generic Kconfig dependencies if
 ARCH_WANTS_NO_INSTR
Message-ID: <Yaet8x/1WYiADlPh@archlinux-ax161>
References: <20211201152604.3984495-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201152604.3984495-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 04:26:04PM +0100, Marco Elver wrote:
> Until recent versions of GCC and Clang, it was not possible to disable
> KCOV instrumentation via a function attribute. The relevant function
> attribute was introduced in 540540d06e9d9 ("kcov: add
> __no_sanitize_coverage to fix noinstr for all architectures").
> 
> x86 was the first architecture to want a working noinstr, and at the
> time no compiler support for the attribute existed yet. Therefore,
> 0f1441b44e823 ("objtool: Fix noinstr vs KCOV") introduced the ability to
> NOP __sanitizer_cov_*() calls in .noinstr.text.
> 
> However, this doesn't work for other architectures like arm64 and s390
> that want a working noinstr per ARCH_WANTS_NO_INSTR.
> 
> At the time of 0f1441b44e823, we didn't yet have ARCH_WANTS_NO_INSTR,
> but now we can move the Kconfig dependency checks to the generic KCOV
> option. KCOV will be available if:
> 
> 	- architecture does not care about noinstr, OR
> 	- we have objtool support (like on x86), OR
> 	- GCC is 12.0 or newer, OR
> 	- Clang is 13.0 or newer.
> 
> Signed-off-by: Marco Elver <elver@google.com>

It might have been nice to do a feature check in Kconfig like we do in
compiler-{clang,gcc}.h but I assume it's highly unlikely that the GCC
change would get backported (and it obviously won't for clang because
older versions are not supported) plus the attributes are different
between clang and GCC.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/Kconfig  | 2 +-
>  lib/Kconfig.debug | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 95dd1ee01546..c030b2ee93b3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -78,7 +78,7 @@ config X86
>  	select ARCH_HAS_FILTER_PGPROT
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> -	select ARCH_HAS_KCOV			if X86_64 && STACK_VALIDATION
> +	select ARCH_HAS_KCOV			if X86_64
>  	select ARCH_HAS_MEM_ENCRYPT
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ef7ce18b4f5..589c8aaa2d5b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1977,6 +1977,8 @@ config KCOV
>  	bool "Code coverage for fuzzing"
>  	depends on ARCH_HAS_KCOV
>  	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
> +	depends on !ARCH_WANTS_NO_INSTR || STACK_VALIDATION || \
> +		   GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
>  	select DEBUG_FS
>  	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
>  	help
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 
