Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99029527DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbiEPGyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbiEPGyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:54:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD7A18E10
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C243E60FF0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8F8C341CB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652684071;
        bh=tM8VdVpQeGWfsS/JGL2TFIz5I1GWH0ZJrplDr+il9hM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nvec5QiUWWMTDk/FGmTf3HFsKY7hZlFrs2v/UcJp5CQvPFw9mu4fya6JfpfVU2hvb
         u4t90qgveCOR3D4pGB8xm0N5LCK2XO/BInWRXIKr3VqwyNlwM0icdD0ctzYWoQQdzZ
         1LdK5r+fEObsm8pA4Dif3Nqdx0wIf8kw/tGBng69G2UKEk+VX3Poed3Xt4BLVzM9ja
         mHygaV8JoPDdJ8mBqtDgMP05Zs0E59akJ1MTbnRa47gYaqgz4rTIMLaPZWqXo6vi/e
         CftXqUt6zHffjEL1vZX4AJ8DhjXKZFQnZ/HBdFrxjHERZHcA5pybm1Au5LaP7WkAil
         kO9cGattCGZWQ==
Received: by mail-vs1-f41.google.com with SMTP id z144so14475393vsz.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:54:31 -0700 (PDT)
X-Gm-Message-State: AOAM531+FmLERcx4PXLqgLYHerWiPGbNfuLpw0BSeDk8+Uz19cajzNls
        qTCXWj+1+gQP0DfCyourHJResSUQX5GL7AjKGmI=
X-Google-Smtp-Source: ABdhPJwZBD52gp8yNtPoCr6xpm2XLKUyPVBcohCmwY5Uk7D3sNSl2jSgSrlxEtR9wLD7ZFNpAp4+wVs+U7n7NYbTt88=
X-Received: by 2002:a67:ca09:0:b0:32d:4069:5657 with SMTP id
 z9-20020a67ca09000000b0032d40695657mr5513114vsk.59.1652684069944; Sun, 15 May
 2022 23:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-4-heiko@sntech.de>
In-Reply-To: <20220511192921.2223629-4-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 16 May 2022 14:54:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSrLArzaY7wdWF5XrPniF0C=r-2rcv59CteV68A8Uy=Uw@mail.gmail.com>
Message-ID: <CAJF2gTSrLArzaY7wdWF5XrPniF0C=r-2rcv59CteV68A8Uy=Uw@mail.gmail.com>
Subject: Re: [PATCH 03/12] riscv: implement module alternatives
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, liush <liush@allwinnertech.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        "Xinhaoqu (Freddie)" <xinhaoqu@huawei.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, May 12, 2022 at 3:29 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> This allows alternatives to also be applied when loading modules
> and follows the implementation of other architectures (e.g. arm64).
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
> ---
>  arch/riscv/errata/sifive/errata.c    | 14 +++++++++-----
>  arch/riscv/include/asm/alternative.h |  3 +++
>  arch/riscv/kernel/alternative.c      | 18 +++++++++++++----
>  arch/riscv/kernel/module.c           | 29 ++++++++++++++++++++++++++++
>  4 files changed, 55 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
> index 4fe03ac41fd7..3e39587a49dc 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/string.h>
>  #include <linux/bug.h>
>  #include <asm/patch.h>
> @@ -54,7 +55,8 @@ static struct errata_info_t errata_list[ERRATA_SIFIVE_NUMBER] = {
>         },
>  };
>
> -static u32 __init sifive_errata_probe(unsigned long archid, unsigned long impid)
> +static u32 __init_or_module sifive_errata_probe(unsigned long archid,
> +                                               unsigned long impid)
>  {
>         int idx;
>         u32 cpu_req_errata = 0;
> @@ -66,7 +68,7 @@ static u32 __init sifive_errata_probe(unsigned long archid, unsigned long impid)
>         return cpu_req_errata;
>  }
>
> -static void __init warn_miss_errata(u32 miss_errata)
> +static void __init_or_module warn_miss_errata(u32 miss_errata)
>  {
>         int i;
>
> @@ -79,9 +81,11 @@ static void __init warn_miss_errata(u32 miss_errata)
>         pr_warn("----------------------------------------------------------------\n");
>  }
>
> -void __init sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> -                                    unsigned long archid, unsigned long impid,
> -                                    unsigned int stage)
> +void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
> +                                              struct alt_entry *end,
> +                                              unsigned long archid,
> +                                              unsigned long impid,
> +                                              unsigned int stage)
>  {
>         struct alt_entry *alt;
>         u32 cpu_req_errata = sifive_errata_probe(archid, impid);
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index 0ff550667e94..0859529ff08e 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -20,8 +20,10 @@
>  #include <asm/hwcap.h>
>
>  #define RISCV_ALTERNATIVES_BOOT                0 /* alternatives applied during regular boot */
> +#define RISCV_ALTERNATIVES_MODULE      1 /* alternatives applied during module-init */
>
>  void __init apply_boot_alternatives(void);
> +void apply_module_alternatives(void *start, size_t length);
>
>  struct alt_entry {
>         void *old_ptr;           /* address of original instruciton or data  */
> @@ -43,6 +45,7 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  #else /* CONFIG_RISCV_ALTERNATIVE */
>
>  static inline void apply_boot_alternatives(void) { }
> +static inline void apply_module_alternatives(void *start, size_t length) { }
>
>  #endif /* CONFIG_RISCV_ALTERNATIVE */
>
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index 02db62f55bac..223770b3945c 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/cpu.h>
>  #include <linux/uaccess.h>
>  #include <asm/alternative.h>
> @@ -23,7 +24,7 @@ static struct cpu_manufacturer_info_t {
>
>  static void (*vendor_patch_func)(struct alt_entry *begin, struct alt_entry *end,
>                                  unsigned long archid, unsigned long impid,
> -                                unsigned int stage) __initdata;
> +                                unsigned int stage) __initdata_or_module;
>
>  static inline void __init riscv_fill_cpu_mfr_info(void)
>  {
> @@ -58,9 +59,9 @@ static void __init init_alternative(void)
>   * a feature detect on the boot CPU). No need to worry about other CPUs
>   * here.
>   */
> -static void __init _apply_alternatives(struct alt_entry *begin,
> -                                      struct alt_entry *end,
> -                                      unsigned int stage)
> +static void __init_or_module _apply_alternatives(struct alt_entry *begin,
> +                                                struct alt_entry *end,
> +                                                unsigned int stage)
>  {
>         if (!vendor_patch_func)
>                 return;
> @@ -81,3 +82,12 @@ void __init apply_boot_alternatives(void)
>                             (struct alt_entry *)__alt_end,
>                             RISCV_ALTERNATIVES_BOOT);
>  }
> +
> +#ifdef CONFIG_MODULES
> +void apply_module_alternatives(void *start, size_t length)
> +{
> +       _apply_alternatives((struct alt_entry *)start,
> +                           (struct alt_entry *)(start + length),
> +                           RISCV_ALTERNATIVES_MODULE);
> +}
> +#endif
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index c29cef90d1dd..91fe16bfaa07 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -11,6 +11,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
>  #include <linux/pgtable.h>
> +#include <asm/alternative.h>
>  #include <asm/sections.h>
>
>  /*
> @@ -427,3 +428,31 @@ void *module_alloc(unsigned long size)
>                                     __builtin_return_address(0));
>  }
>  #endif
> +
> +static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
> +                                   const Elf_Shdr *sechdrs,
> +                                   const char *name)
> +{
> +       const Elf_Shdr *s, *se;
> +       const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> +
> +       for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
> +               if (strcmp(name, secstrs + s->sh_name) == 0)
> +                       return s;
> +       }
> +
> +       return NULL;
> +}
> +
> +int module_finalize(const Elf_Ehdr *hdr,
> +                   const Elf_Shdr *sechdrs,
> +                   struct module *me)
> +{
> +       const Elf_Shdr *s;
> +
> +       s = find_section(hdr, sechdrs, ".alternative");
> +       if (s)
> +               apply_module_alternatives((void *)s->sh_addr, s->sh_size);
> +
> +       return 0;
> +}
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
