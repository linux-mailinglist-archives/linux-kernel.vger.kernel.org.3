Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE935373A0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 04:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiE3CsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 22:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiE3CsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 22:48:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508A23EF04
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 19:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDBB6B80B8B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5616C341D0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653878883;
        bh=YoRGxfq1Yea8HRZlBDQS2oqp73Xku6gJh6IZaXEOUT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IBYxtq5gyzzz6NoUQdgfTtSYIgZ3KWqAdLPQMAaWnPLuJ/YDqgxsQLwBbN6PzFQ4/
         ynoZELeNvrjeF0rsNXYNDgK/Kw39SRFuXzc+saHjBG0+T7m+50D+YCtWB9onXw/yxW
         eM24Jm2i0VjJc2nV5fEWZRAtu1IzaFyKQPmUfaOtCzt9TQC7Q8p7HY4ZoUrrlUtJsv
         smdsNxszWiJHC3wgku0JpcwM4w8Y8I3Z9AuAZMd9dLLevOrdKaKnrHQlQvEMqBhEKo
         bCHa4Dn2mSL61TjjKpIOSiw6fws/SGfe2AcstVkd0NnYqleGUnH6XKCmLZIFuyBK5K
         Q4qqk8qcSKuxA==
Received: by mail-vs1-f46.google.com with SMTP id 68so9590367vse.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 19:48:03 -0700 (PDT)
X-Gm-Message-State: AOAM532O8KvOprM6WKrIeRTuyovpXGFjUZrm8tqojVUk4kc5qc5Zg171
        FEwVjM5sf5pPPhurs0vsE6oi26gVSGDR+ffZKdQ=
X-Google-Smtp-Source: ABdhPJzvEfegwzjtbzbneiuCB+i9dHMhbVAfv1BIeisWjXZ/dtthImdOsnOoQKcAkgNwBZcem3RsjgMXsyI5j2ahuf0=
X-Received: by 2002:a05:6102:151c:b0:337:d985:1764 with SMTP id
 f28-20020a056102151c00b00337d9851764mr10556500vsv.51.1653878882062; Sun, 29
 May 2022 19:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220518013428.1338983-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220518013428.1338983-1-xianting.tian@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 30 May 2022 10:47:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRZCchLk9apNQagNmsNb3Pv+WfPTisrsWDDrQyVncUYeA@mail.gmail.com>
Message-ID: <CAJF2gTRZCchLk9apNQagNmsNb3Pv+WfPTisrsWDDrQyVncUYeA@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Mark IORESOURCE_EXCLUSIVE for reserved mem
 instead of IORESOURCE_BUSY
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, wangborong@cdjrlc.com,
        twd2 <twd2.me@gmail.com>, seanjc@google.com,
        Alex Ghiti <alex@ghiti.fr>, petr.pavlu@suse.com,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jianghuaming.jhm@alibaba-inc.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

Please have a look at this patch which is a critical fixup. Our
current riscv implementation has broken the reserved memory.

On Wed, May 18, 2022 at 9:34 AM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> Commit 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
> marked IORESOURCE_BUSY for reserved memory, which caused resource map
> failed in subsequent operations of related driver, so remove the
> IORESOURCE_BUSY flag. In order to prohibit userland mapping reserved
> memory, mark IORESOURCE_EXCLUSIVE for it.
>
> The code to reproduce the issue,
> dts:
>         mem0: memory@a0000000 {
>                 reg = <0x0 0xa0000000 0 0x1000000>;
>                 no-map;
>         };
>
>         &test {
>                 status = "okay";
>                 memory-region = <&mem0>;
>         };
>
> code:
>         np = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
>         ret = of_address_to_resource(np, 0, &r);
>         base = devm_ioremap_resource(&pdev->dev, &r);
>         // base = -EBUSY
>
> Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
> Reported-by: Huaming Jiang <jianghuaming.jhm@alibaba-inc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
> Changes from v2:
> - Fix typo in commit message: casued -> caused
> - Remove Reviewed-by of Nick Kossifidis, who didn't give Reviewed-by actually
> - Add Co-developed-by of Nick
>
> Changes from v1:
> - Mark reserved memory as IORESOURCE_EXCLUSIVE, suggested by Nick
> ---
>  arch/riscv/kernel/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 834eb652a7b9..e0a00739bd13 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -189,7 +189,7 @@ static void __init init_resources(void)
>                 res = &mem_res[res_idx--];
>
>                 res->name = "Reserved";
> -               res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +               res->flags = IORESOURCE_MEM | IORESOURCE_EXCLUSIVE;
>                 res->start = __pfn_to_phys(memblock_region_reserved_base_pfn(region));
>                 res->end = __pfn_to_phys(memblock_region_reserved_end_pfn(region)) - 1;
>
> @@ -214,7 +214,7 @@ static void __init init_resources(void)
>
>                 if (unlikely(memblock_is_nomap(region))) {
>                         res->name = "Reserved";
> -                       res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +                       res->flags = IORESOURCE_MEM | IORESOURCE_EXCLUSIVE;
>                 } else {
>                         res->name = "System RAM";
>                         res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
