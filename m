Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0654B1870
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345117AbiBJWmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:42:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345093AbiBJWmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:42:47 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAFF26D4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:42:46 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id p19so19776756ybc.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjreJ4Dbxm2NwQlgnQYlRNvrqvyn6H+tQ+K3U0g0mFI=;
        b=LX8u+w3RqcntgJCHyFMV4Fre+NntXNFQQlBWBGTBu67MgFdVmMjY4UPqS9LePVWP9q
         ++KmXmIcvng+CQaKcXpdHGPKgfZw95uSBgxJbFskcujzYu3MN57xy/TWm4L28xAomOPi
         e39N5a0TeU8SvKhzNwQFOmjJdb3DcmqQhtL2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjreJ4Dbxm2NwQlgnQYlRNvrqvyn6H+tQ+K3U0g0mFI=;
        b=YBimH/p0owvdLk+smNRYSOAbftfzCSjP9IMbY9tOoHj7bOHS5LGJ8AADeLuSpNMDul
         LD6ORqHiGTMbhGXORCa+ya2UEd7QSC6LXiEE+I6CK6ETHxJIWe5fJH0C2jP/i5b0mqeP
         1BBsbjU+vy/VF0Nqt9OuAwWiqKUyd1t3Tjde7zM2sh7C8iB5LVW5MV75ZffrRJP+4rk3
         9ZRiK17r8zla86K83HhxDE2Jn2PbOEWXcsUpRafBniiYvwRZVmvDtAcbXJmZYUKqfday
         BIc7JQN+srDLrJKfQ61+8s2TzJVgCmKyNCTptDh21E+Ons63a7FupeW+5a8+DL8w0i9Z
         98aw==
X-Gm-Message-State: AOAM530ioV6EMc3lzh1Q1FBqaPbCBgrbdueLDvXFfj5wfVoCoYIZ4vMP
        o5ZBnWdMaTorTRWcW3T5i2KHTFZClsshT2arp+o6
X-Google-Smtp-Source: ABdhPJyR8oYWkiUH8cQr2NFW+hlos0Nq2+W+WHKskklGcfGFhys92e0ats7QSYkRoCXeYmJAm9nXLikQIY28et3jaCs=
X-Received: by 2002:a81:e241:: with SMTP id z1mr9683966ywl.62.1644532966055;
 Thu, 10 Feb 2022 14:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20220209123800.269774-1-heiko@sntech.de> <20220209123800.269774-9-heiko@sntech.de>
In-Reply-To: <20220209123800.269774-9-heiko@sntech.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 10 Feb 2022 14:42:35 -0800
Message-ID: <CAOnJCULe_5v6cb_JcoPKf-UD3bVze1U=jaYeLTsMu7pFigde+A@mail.gmail.com>
Subject: Re: [PATCH v6 08/14] riscv: move boot alternatives to a slightly
 earlier position
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        liush <liush@allwinnertech.com>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 4:39 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Move the application of boot alternatives to soc_early_init().
> This allows to catch more generic cases of code needing patches
> than doing it in smp_prepare_boot_cpu() and also makes it actually
> work if CONFIG_SMP is disabled for whatever reason.
>
> The position is chosen mainly as it is before the actual soc early
> init runs but also already allows accessing the devicetree
> via fdt_* functions.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/head.S    | 2 ++
>  arch/riscv/kernel/smpboot.c | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 2363b43312fc..0e1bb97f9749 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -10,6 +10,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
> +#include <asm/alternative.h>
>  #include <asm/csr.h>
>  #include <asm/cpu_ops_sbi.h>
>  #include <asm/hwcap.h>
> @@ -341,6 +342,7 @@ clear_bss_done:
>         call kasan_early_init
>  #endif
>         /* Start the kernel */
> +       call apply_boot_alternatives

Do you really need this early ?
if non-smp configuration is the only option, Can you do it in
setup_arch() after riscv_fill_hwcap() is called ?

By doing that, we can unify the cpu feature probing and you don't need
a separate DT parsing just for svpbmt.

>         call soc_early_init
>         tail start_kernel
>
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
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
