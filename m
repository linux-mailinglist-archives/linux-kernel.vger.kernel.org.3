Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28730466920
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356145AbhLBRe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348085AbhLBReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C74EC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8y2oxAvRHeBlCuC/BEwUyt1WOm4Rdt3hzU8cM2cFMjk=; b=oQbE09PqshRYa9x3xUr5FjKc+J
        77hiORxCfRicAvQ2D+HbOB7mC/S7Z2NoShZynxwAu7Gly5G2U0q849rgNjj/Oq06hH53JAZo0+8Q6
        U/9NkUREUlkPgdfLK8ql0IqgHSWvOdSKz014iZmd01mUNO5gQTJHQWiSWHRMHsnzKncdbY8uFQb5W
        kzHtXuPdHqrTm68YAiyN1DW52ynPu3qi8L21rgrwg6kACSHuygPNVmOPqtsaIUzGtQdWK+PfYc9RO
        QRIlk9ogte0AjXfvzh2ONiF+3/Z7P5tTw+59aSJRUAJgKKc9RwHLM1jxUSJ3zLaXHVBsVkzpnrGNw
        JjOVXa0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mspuv-004vAd-Nb; Thu, 02 Dec 2021 17:30:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA20E300792;
        Thu,  2 Dec 2021 18:30:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0453A200F8FF5; Thu,  2 Dec 2021 15:50:31 +0100 (CET)
Date:   Thu, 2 Dec 2021 15:50:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kcov: fix generic Kconfig dependencies if
 ARCH_WANTS_NO_INSTR
Message-ID: <YajdN5T8vi2ZzP3D@hirez.programming.kicks-ass.net>
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

Can we write that as something like:

	$(cc-attribute,__no_sanitize_coverage)

instead? Other than that, yes totally.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
