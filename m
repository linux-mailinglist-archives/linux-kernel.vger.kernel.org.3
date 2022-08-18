Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8932D598139
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbiHRKBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiHRKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:00:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676AA8E995
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5192B82131
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77919C433B5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660816852;
        bh=tXtuArrAzWG5jhfgb+zOZA/1Co/OAJtYIqCfLsXWGDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nhsjyJ4dg4b3NR6rKj+N58B2oZdidRq23ugaRZ3QmrZzzoMifAsssMYVA9EWa5gHT
         z4D1MusoJRaSC1QPShQ9iieuHBlEb4czWTBox62hWC367xWLhGb20EISN1/LPoAgyw
         pHuY+F/JUNWqvCQ2q9VMhI4+DQMr+Zq1LhZQ73lxIYaeYK7s+Zfm2P5a0SZG5mropH
         pnUtuwPvXYfWkJ3cauuK6HZ/w1zJfIDOO3MeUlLaZq1ycOzzPUvM+qLPATyfH16jB+
         ej5F0u8Vr9k0VXmIPvKCXIyQRdgEG6XH7OBabQZ8ylpDoq1iqkNZ6hCJkJvuaR9pVW
         tj9PoSzGxYH2w==
Received: by mail-wm1-f47.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso651072wmr.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:00:52 -0700 (PDT)
X-Gm-Message-State: ACgBeo2ERkkT9d8FOcylb4jX/ujNAG052XQHiYl0lVmvcQxwWuaL4xfC
        1X9Y8P2YIc9hBsF7tUNrRL9AvTSCpwcT+WV9qIY=
X-Google-Smtp-Source: AA6agR6elH7PGceZPPudd6UOUhoew0Dsy1k4hauzfNRHmsAPwomVJwAD4eBbFrAUSEA2GCuccGawB2a0RAWRDYN0oyY=
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id
 l20-20020a7bc354000000b0039c675321f8mr1387579wmj.113.1660816850708; Thu, 18
 Aug 2022 03:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220817154022.3974645-1-mark.rutland@arm.com>
In-Reply-To: <20220817154022.3974645-1-mark.rutland@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 Aug 2022 12:00:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHWjZ5zt6CB9kwGYTwy57KqdBMrAAV7gEMjHpvict64PA@mail.gmail.com>
Message-ID: <CAMj1kXHWjZ5zt6CB9kwGYTwy57KqdBMrAAV7gEMjHpvict64PA@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix rodata=full
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, catalin.marinas@arm.com,
        jvgediya@linux.ibm.com, rdunlap@infradead.org, will@kernel.org,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 at 17:40, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On arm64, "rodata=full" has been suppored (but not documented) since
> commit:
>
>   c55191e96caa9d78 ("arm64: mm: apply r/o permissions of VM areas to its linear alias as well")
>
> As it's necessary to determine the rodata configuration early during
> boot, arm64 has an early_param() handler for this, whereas init/main.c
> has a __setup() handler which is run later.
>
> Unfortunately, this split meant that since commit:
>
>   f9a40b0890658330 ("init/main.c: return 1 from handled __setup() functions")
>
> ... passing "rodata=full" would result in a spurious warning from the
> __setup() handler (though RO permissions would be configured
> appropriately).
>
> Further, "rodata=full" has been broken since commit:
>
>   0d6ea3ac94ca77c5 ("lib/kstrtox.c: add "false"/"true" support to kstrtobool()")
>
> ... which caused strtobool() to parse "full" as false (in addition to
> many other values not documented for the "rodata=" kernel parameter.
>
> This patch fixes this breakage by:
>
> * Moving the core parameter parser to an __early_param(), such that it
>   is available early.
>
> * Adding an (optional) arch hook which arm64 can use to parse "full".
>
> * Updating the documentation to mention that "full" is valid for arm64.
>
> * Having the core parameter parser handle "on" and "off" explicitly,
>   such that any undocumented values (e.g. typos such as "ful") are
>   reported as errors rather than being silently accepted.
>
> Note that __setup() and early_param() have opposite conventions for
> their return values, where __setup() uses 1 to indicate a parameter was
> handled and early_param() uses 0 to indicate a parameter was handled.
>
> Fixes: f9a40b0890658330 ("init/main.c: return 1 from handled __setup() functions")
> Fixes: 0d6ea3ac94ca77c5 ("lib/kstrtox.c: add "false"/"true" support to kstrtobool()")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jagdish Gediya <jvgediya@linux.ibm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Will Deacon <will@kernel.org>

Yuck, thanks for cleaning that up.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  .../admin-guide/kernel-parameters.txt          |  2 ++
>  arch/arm64/include/asm/setup.h                 | 17 +++++++++++++++++
>  arch/arm64/mm/mmu.c                            | 18 ------------------
>  init/main.c                                    | 18 +++++++++++++++---
>  4 files changed, 34 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d7f30902fda02..426fa892d311a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5331,6 +5331,8 @@
>         rodata=         [KNL]
>                 on      Mark read-only kernel memory as read-only (default).
>                 off     Leave read-only kernel memory writable for debugging.
> +               full    Mark read-only kernel memory and aliases as read-only
> +                       [arm64]
>
>         rockchip.usb_uart
>                         Enable the uart passthrough on the designated usb port
> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
> index 6437df6617009..f4af547ef54ca 100644
> --- a/arch/arm64/include/asm/setup.h
> +++ b/arch/arm64/include/asm/setup.h
> @@ -3,6 +3,8 @@
>  #ifndef __ARM64_ASM_SETUP_H
>  #define __ARM64_ASM_SETUP_H
>
> +#include <linux/string.h>
> +
>  #include <uapi/asm/setup.h>
>
>  void *get_early_fdt_ptr(void);
> @@ -14,4 +16,19 @@ void early_fdt_map(u64 dt_phys);
>  extern phys_addr_t __fdt_pointer __initdata;
>  extern u64 __cacheline_aligned boot_args[4];
>
> +static inline bool arch_parse_debug_rodata(char *arg)
> +{
> +       extern bool rodata_enabled;
> +       extern bool rodata_full;
> +
> +       if (arg && !strcmp(arg, "full")) {
> +               rodata_enabled = true;
> +               rodata_full = true;
> +               return true;
> +       }
> +
> +       return false;
> +}
> +#define arch_parse_debug_rodata arch_parse_debug_rodata
> +
>  #endif
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index db7c4e6ae57bb..e7ad44585f40a 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -642,24 +642,6 @@ static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
>         vm_area_add_early(vma);
>  }
>
> -static int __init parse_rodata(char *arg)
> -{
> -       int ret = strtobool(arg, &rodata_enabled);
> -       if (!ret) {
> -               rodata_full = false;
> -               return 0;
> -       }
> -
> -       /* permit 'full' in addition to boolean options */
> -       if (strcmp(arg, "full"))
> -               return -EINVAL;
> -
> -       rodata_enabled = true;
> -       rodata_full = true;
> -       return 0;
> -}
> -early_param("rodata", parse_rodata);
> -
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  static int __init map_entry_trampoline(void)
>  {
> diff --git a/init/main.c b/init/main.c
> index 91642a4e69be6..1fe7942f5d4a8 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1446,13 +1446,25 @@ static noinline void __init kernel_init_freeable(void);
>
>  #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
>  bool rodata_enabled __ro_after_init = true;
> +
> +#ifndef arch_parse_debug_rodata
> +static inline bool arch_parse_debug_rodata(char *str) { return false; }
> +#endif
> +
>  static int __init set_debug_rodata(char *str)
>  {
> -       if (strtobool(str, &rodata_enabled))
> +       if (arch_parse_debug_rodata(str))
> +               return 0;
> +
> +       if (str && !strcmp(str, "on"))
> +               rodata_enabled = true;
> +       else if (str && !strcmp(str, "off"))
> +               rodata_enabled = false;
> +       else
>                 pr_warn("Invalid option string for rodata: '%s'\n", str);
> -       return 1;
> +       return 0;
>  }
> -__setup("rodata=", set_debug_rodata);
> +early_param("rodata", set_debug_rodata);
>  #endif
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> --
> 2.30.2
>
