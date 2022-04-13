Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE3E4FEEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiDMFt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiDMFtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:49:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF7950051
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9D37B82101
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB90C385AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649828820;
        bh=HDKik8QF3OtnxnBSdiMFywaH7pAjKSH73aE+xYfjwA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eIUg5nGiYGotfBgo8RxQz4+LyghtaVqFkBnLdhVPxYY7akTr4OCQ0qdvly8M0D79S
         v0+MxRjCkViWbtPsqyIun9qISL4E8ike+U4MWhUsrMoXSnztORxCK/sMHIILwHuprB
         xv7Vv+LTN5dRjvGWGTzVWNQv4WHqpGe515bYOOAcZlc2yDmlZU1u+EC9ivd64p0Wri
         efCASxI23Mu6zRMcTrQshhN8gXWAbhbbAieaROJAMlrqqM0dGaxWTMePr04AJbKtYB
         t944UHn10ij7ms1lOuAtD7We5taCXFnDQj4TYNyzofhux53DrU+MDhyLxc8sQbi0m2
         Fboo/kG9QkrGg==
Received: by mail-vk1-f177.google.com with SMTP id w67so371587vkw.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:47:00 -0700 (PDT)
X-Gm-Message-State: AOAM531hVInFa9msaZBetKPEDOnS7Cv+Q+tw5M1ru3waBmQOnNPBWfca
        4tMFAiNpKSJByo4ZNBLsfw2X/4pZesaUGU16Znw=
X-Google-Smtp-Source: ABdhPJzxdy1DgTdwkI5mBFUoZAa1bIFYSMWm6GZIzpP6qxRS7suwlxoA4eehs1H37b+vIAsfZDceddRYN0OimyFQs/o=
X-Received: by 2002:a05:6122:16a2:b0:345:62c8:2321 with SMTP id
 34-20020a05612216a200b0034562c82321mr5788236vkl.8.1649828819427; Tue, 12 Apr
 2022 22:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-8-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-8-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Apr 2022 13:46:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRj_Lwz_krceR+8UzttsCoJgB5w1ng1cVf5J=5cUbdZ=Q@mail.gmail.com>
Message-ID: <CAJF2gTRj_Lwz_krceR+8UzttsCoJgB5w1ng1cVf5J=5cUbdZ=Q@mail.gmail.com>
Subject: Re: [PATCH v9 07/12] riscv: move boot alternatives to after fill_hwcap
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Apr 13, 2022 at 11:03 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Move the application of boot alternatives to after the hw-capabilities
> are populated. This allows to check for available extensions when
> determining which alternatives to apply and also makes it actually
> work if CONFIG_SMP is disabled for whatever reason.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/kernel/setup.c   | 2 ++
>  arch/riscv/kernel/smpboot.c | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index f4f4a64bc3a0..9162e9a824d2 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -21,6 +21,7 @@
>  #include <linux/efi.h>
>  #include <linux/crash_dump.h>
>
> +#include <asm/alternative.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/early_ioremap.h>
>  #include <asm/pgtable.h>
> @@ -295,6 +296,7 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>
>         riscv_fill_hwcap();
> +       apply_boot_alternatives();
>  }
>
>  static int __init topology_init(void)
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index a6d13dca1403..f1e4948a4b52 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -32,7 +32,6 @@
>  #include <asm/sections.h>
>  #include <asm/sbi.h>
>  #include <asm/smp.h>
> -#include <asm/alternative.h>
>
>  #include "head.h"
>
> @@ -41,7 +40,6 @@ static DECLARE_COMPLETION(cpu_running);
>  void __init smp_prepare_boot_cpu(void)
>  {
>         init_cpu_topology();
> -       apply_boot_alternatives();
>  }
>
>  void __init smp_prepare_cpus(unsigned int max_cpus)
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
