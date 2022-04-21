Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B31509839
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbiDUGyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385224AbiDUGv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:51:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2A319C23
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40F2CB81A10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E836C385BE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650523588;
        bh=WLcq0GdQen5yk3/RVh8Mf7eEU1B/s0OWeYJVrPZbDag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LAEQYR7sX7YDMyXV78AAfqajN8SSZo764KzAzfQb/vG1LF1YgTimIiIy4sh5VyVyV
         8OrYUYBNvCqy9hKdsXOizDQGoWSdVEwfjTrd7akcSHrBenqG2IQZX2izSTU5WOFPbt
         9B+ypR6vIHD7qEyxaIcxYZrD8IDjKgUsXlmDtLsH8Vpg964BaOCp+FZkZlQIVYcOqN
         soNwKn1RlSNSVRUjAsCjRKFeUoEbNLmRoNZs5Yk0JlR+ocDs2lGJdVV1yaDhqqOvog
         Gs8FVyCe2I0ogZmPC/awI/wVPvMAB2+1YsQJYBQ4bVNO5QpPPoyEJLr/TM+NwPEIug
         dV/ilnnCC0kGA==
Received: by mail-ua1-f51.google.com with SMTP id a14so1458529uan.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:46:28 -0700 (PDT)
X-Gm-Message-State: AOAM530mzCpcUdcjeT40K/eXDN335Rk+S4r/x59o36DKNZ4fAwKxK+AX
        A2SZ87Ly3Hv2bEUAe7Xs79CIJ8YMWEEF+Z2HgtE=
X-Google-Smtp-Source: ABdhPJzfifliJQXuUzw+tNmc9xepcsDv53ylKDVONRQ7bmS/cqwxPIrc+JIGKlw6PJxKHEWSXiCwU0HKC2YG/Dzd8R8=
X-Received: by 2002:a05:6130:9d:b0:35d:352e:2810 with SMTP id
 x29-20020a056130009d00b0035d352e2810mr7376432uaf.106.1650523586998; Wed, 20
 Apr 2022 23:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220420184056.7886-1-palmer@rivosinc.com> <20220420184056.7886-5-palmer@rivosinc.com>
In-Reply-To: <20220420184056.7886-5-palmer@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 21 Apr 2022 14:46:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ2hdv5w5W-U=PxMsNZrL4ZPx=f_m93nZ3FSUfWUUJr3A@mail.gmail.com>
Message-ID: <CAJF2gTQ2hdv5w5W-U=PxMsNZrL4ZPx=f_m93nZ3FSUfWUUJr3A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] RISC-V: Fix the XIP build
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Vincent Chen <vincent.chen@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        jszhang@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
        gatecat@ds0.me, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        =?UTF-8?B?5r2Y5bqG6ZyW?= <panqinglin2020@iscas.ac.cn>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Apr 21, 2022 at 2:48 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> A handful of functions unused functions were enabled during XIP builds,
> which themselves didn't build correctly.  This just disables the
> functions entirely.
>
> Fixes: e8a62cc26ddf ("riscv: Implement sv48 support")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 7bc9a21e29fb..d2054a6cd791 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -660,7 +660,7 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
>  }
>  #endif /* CONFIG_STRICT_KERNEL_RWX */
>
> -#ifdef CONFIG_64BIT
> +#if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
>  static void __init disable_pgtable_l5(void)
>  {
>         pgtable_l5_enabled = false;
> --
> 2.34.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
