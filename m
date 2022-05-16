Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B04527DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiEPGvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiEPGvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:51:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7530A36695
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C09FB80E9D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EAAC341C6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652683896;
        bh=ZIB7dC8NtI67j/b6vpXXZknBP0LWu3oU+SBW5aK8PLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q5Few4/dhDYGSRcopONYyCXYqszi7Oz5ErPLLfu/rQKX2Mkl++OdWWmKKD4FDBaIO
         U8Lt815l52n7/HI88QlBilj55iXUcTsUpE0LgkApCNLpJLkOhgw1PwgKzw34m3L8q9
         DQSjKBRVRhEVULvj0WWQlJMwDFEaX4iJHwea+LvFrtWTP+gLKnvntbMg8ZgqTPdoqe
         qSIZgUWyM5PLypr6JuJip/seoCip196ZRpbpIeraNL9t1JLacIIxe9w3BPX15YvaRw
         HQRo/0p/T3UjJOG4nwsd/wrSj/nWYtSFrHDWgdr+jJyeU1RT+OeTldwqcwaqzBFXZz
         wfZvSFA/m9Ebw==
Received: by mail-vs1-f51.google.com with SMTP id t85so14506008vst.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:51:36 -0700 (PDT)
X-Gm-Message-State: AOAM533L4EGfQrF+s0gNCDI35wc74s6T5sFjcdGoph7COqwIwhFF9GgH
        ssVEE/0wAjuZ//v28GOvBMEX6Q90r4jM7nZLO/c=
X-Google-Smtp-Source: ABdhPJzGb0Pw089mtPFdIIzqP5DcyX1HLdLL0vBSYLdgeIwnhLDR+ogeJoLMkAYNcXUhpaIIsHxLRBQgGyoxl3AlYF8=
X-Received: by 2002:a67:fc86:0:b0:32d:18ed:e71b with SMTP id
 x6-20020a67fc86000000b0032d18ede71bmr5321965vsp.51.1652683895775; Sun, 15 May
 2022 23:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-3-heiko@sntech.de>
In-Reply-To: <20220511192921.2223629-3-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 16 May 2022 14:51:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQKsJ00MAyXGnBXR-tK1pAnHeuEr6Se79OYN4_kvPjjFQ@mail.gmail.com>
Message-ID: <CAJF2gTQKsJ00MAyXGnBXR-tK1pAnHeuEr6Se79OYN4_kvPjjFQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] riscv: allow different stages with alternatives
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
> Future features may need to be applied at a different
> time during boot, so allow defining stages for alternatives
> and handling them differently depending on the stage.
>
> Also make the alternatives-location more flexible so that
> future stages may provide their own location.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
> ---
>  arch/riscv/errata/sifive/errata.c    |  3 ++-
>  arch/riscv/include/asm/alternative.h |  5 ++++-
>  arch/riscv/kernel/alternative.c      | 26 +++++++++++++++++---------
>  3 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
> index f5e5ae70e829..4fe03ac41fd7 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -80,7 +80,8 @@ static void __init warn_miss_errata(u32 miss_errata)
>  }
>
>  void __init sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> -                                    unsigned long archid, unsigned long impid)
> +                                    unsigned long archid, unsigned long impid,
> +                                    unsigned int stage)
>  {
>         struct alt_entry *alt;
>         u32 cpu_req_errata = sifive_errata_probe(archid, impid);
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index 7b42bcef0ecf..0ff550667e94 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -19,6 +19,8 @@
>  #include <linux/stddef.h>
>  #include <asm/hwcap.h>
>
> +#define RISCV_ALTERNATIVES_BOOT                0 /* alternatives applied during regular boot */
> +
>  void __init apply_boot_alternatives(void);
>
>  struct alt_entry {
> @@ -35,7 +37,8 @@ struct errata_checkfunc_id {
>  };
>
>  void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> -                             unsigned long archid, unsigned long impid);
> +                             unsigned long archid, unsigned long impid,
> +                             unsigned int stage);
>
>  #else /* CONFIG_RISCV_ALTERNATIVE */
>
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index e8b4a0fe488c..02db62f55bac 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -22,8 +22,8 @@ static struct cpu_manufacturer_info_t {
>  } cpu_mfr_info;
>
>  static void (*vendor_patch_func)(struct alt_entry *begin, struct alt_entry *end,
> -                                unsigned long archid,
> -                                unsigned long impid) __initdata;
> +                                unsigned long archid, unsigned long impid,
> +                                unsigned int stage) __initdata;
>
>  static inline void __init riscv_fill_cpu_mfr_info(void)
>  {
> @@ -58,6 +58,18 @@ static void __init init_alternative(void)
>   * a feature detect on the boot CPU). No need to worry about other CPUs
>   * here.
>   */
> +static void __init _apply_alternatives(struct alt_entry *begin,
> +                                      struct alt_entry *end,
> +                                      unsigned int stage)
> +{
> +       if (!vendor_patch_func)
> +               return;
> +
> +       vendor_patch_func(begin, end,
> +                         cpu_mfr_info.arch_id, cpu_mfr_info.imp_id,
> +                         stage);
> +}
> +
>  void __init apply_boot_alternatives(void)
>  {
>         /* If called on non-boot cpu things could go wrong */
> @@ -65,11 +77,7 @@ void __init apply_boot_alternatives(void)
>
>         init_alternative();
>
> -       if (!vendor_patch_func)
> -               return;
> -
> -       vendor_patch_func((struct alt_entry *)__alt_start,
> -                         (struct alt_entry *)__alt_end,
> -                         cpu_mfr_info.arch_id, cpu_mfr_info.imp_id);
> +       _apply_alternatives((struct alt_entry *)__alt_start,
> +                           (struct alt_entry *)__alt_end,
> +                           RISCV_ALTERNATIVES_BOOT);
>  }
> -
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
