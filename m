Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB844686D5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385328AbhLDR6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhLDR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:58:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C43C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 09:55:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35F9460E33
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 17:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BE9C341C9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638640519;
        bh=MsdZF5FrrSi9Tcnn9w/s8NpxeYl91jS0lBMGm17oxmY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pu4WU8ZDH5XclGPW5SJmHLztAo4T6sdLs8FVn91uKdzHwGKN6gWex8WlhWMZnc6ao
         gKUu62JWTdzK72zIfvlWmErr0eGH311pbU4L52n/FtYLTxOLdRjIeD2+4/bCnZZNoa
         dyVr5124N25mCvdqGWya/aE5MWAxlzhtfuRpj1mrok0qdCdquJn11PjtpdJwbGMGfo
         67pHXUunwA6aCL2Wa+4/eYPih8ltgs4U8dUJQWGUAyrxlPb0wR3jbw5DepUga5Thcg
         +Re6HqYpO+AoLNEd4OBknZCTkQY0xCgXKCn2QfvoczoM/LMtSV37HByGU7L6l2z/m3
         KJyHGwWALET0Q==
Received: by mail-oi1-f178.google.com with SMTP id o4so12672811oia.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 09:55:19 -0800 (PST)
X-Gm-Message-State: AOAM53030RDDkmUWxQm++S3sVf8t06hpnmklQp+X0zenDliB++7XAdVd
        lWiYbt6gcDNzTvMloGoDvRsmwCSqs2JOGs04mS8=
X-Google-Smtp-Source: ABdhPJyel86dmPEzBEcJLPiCfEaQ3wOoNboXYxp5jyfi6GYDFMcwasis1pW7n2UzZ20uopiLk99hBLM2wL4W1yLpJ2Y=
X-Received: by 2002:a05:6808:1919:: with SMTP id bf25mr16381541oib.33.1638640518810;
 Sat, 04 Dec 2021 09:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20211204174156.977245-1-arnd@kernel.org>
In-Reply-To: <20211204174156.977245-1-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 4 Dec 2021 18:55:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGj=AGp6im71+OETHGSCat0mQfOf7FcDdyKwxFEBubzdw@mail.gmail.com>
Message-ID: <CAMj1kXGj=AGp6im71+OETHGSCat0mQfOf7FcDdyKwxFEBubzdw@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: select ARCH_USE_MEMREMAP_PROT
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 at 18:42, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The patch to map the EFI memmap as encrypted introduces a
> link failure in configurations without encryption support:
>
> x86_64-linux-ld: arch/x86/platform/efi/quirks.o: in function `efi_arch_mem_reserve':
> quirks.c:(.init.text+0x127): undefined reference to `early_memremap_prot'
>
> Select the necessary symbol here as well to fix the build.
>
> Fixes: 8f1dd76c9b55 ("x86/sme: Explicitly map new EFI memmap table as encrypted")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the report. I'll fold this fix into the original patch instead.

> ---
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 05362527f6b5..93befe25d787 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1934,6 +1934,7 @@ config EFI
>         depends on ACPI
>         select UCS2_STRING
>         select EFI_RUNTIME_WRAPPERS
> +       select ARCH_USE_MEMREMAP_PROT
>         help
>           This enables the kernel to use EFI runtime services that are
>           available (such as the EFI variable services).
> --
> 2.29.2
>
