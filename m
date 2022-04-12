Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9F24FE15B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354820AbiDLM7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355146AbiDLM5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:57:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92CC59A55;
        Tue, 12 Apr 2022 05:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B941B81D2D;
        Tue, 12 Apr 2022 12:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F2FC385A6;
        Tue, 12 Apr 2022 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649766688;
        bh=qvgvgPlnqIF4Nwhd/KVD2DfqHWxVoFnWvDT/T+pTUxg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gTRMUm9FpmPdmWAYUNF0Kc1HCctRfKCsfzRNc8O0rE2QQNaVs7Bbf3tO3vEpfeGyB
         47992792v7zS+xdeFT9wflnpVYqhWy/HbjpSHRFIzC9cgzzOhLa8ciB6t+6fKAlE/b
         pEckANQRnyja2+s6hKMB7oTTHQMz2esUuQQ3BZL7GME/qxyNtNtXaOMWQhOdgnxBU4
         8zXSGsbrGWqonXrebx/UcEuPe11BJ+sfypdhvHLk55txlYM8yy91qmKEMyKSty9Z4A
         TVe5BgdOyX5yOIu13InAyvW0wlloyI6adBEcilfN2wdOpCN5A0UGQZASr1b4L7Z87c
         caY85b2Z+Q+sg==
Received: by mail-io1-f46.google.com with SMTP id r2so22030592iod.9;
        Tue, 12 Apr 2022 05:31:28 -0700 (PDT)
X-Gm-Message-State: AOAM533bBAbNFQoXpLFchMd9p6ApHn5yASO7/oI/QpZgxGXumvqGwz6S
        ywytT+cq/etYYTwW4Ef/onPdp85OYK5rEiYxaw==
X-Google-Smtp-Source: ABdhPJzysinMng65dytPxyEs+g/U4hp7xMDUjNUwYTOhCqrvOU3/Ba48iG7ejIU9HPu1N2kuCqqb1gTfROoyF+ACUnU=
X-Received: by 2002:a05:6602:1645:b0:646:4780:fc28 with SMTP id
 y5-20020a056602164500b006464780fc28mr15420111iow.194.1649766687353; Tue, 12
 Apr 2022 05:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220412045228.35306-1-patrick.wang.shcn@gmail.com>
In-Reply-To: <20220412045228.35306-1-patrick.wang.shcn@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 Apr 2022 07:31:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ3Vi18RizzkKok5Rg8AM3U3Eytaunqk-5RF795ma=wcA@mail.gmail.com>
Message-ID: <CAL_JsqJ3Vi18RizzkKok5Rg8AM3U3Eytaunqk-5RF795ma=wcA@mail.gmail.com>
Subject: Re: [PATCH] of: fdt: do not reserve memory below MIN_MEMBLOCK_ADDR
To:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

+Mike Rapoport

On Mon, Apr 11, 2022 at 11:52 PM Patrick Wang
<patrick.wang.shcn@gmail.com> wrote:
>
> Dt reserve memory without base checking, which will trigger an oops in
> kmemleak when the base address is below MIN_MEMBLOCK_ADDR:

Why does the caller need to know what this address is? Shouldn't
memblock handle all this internally?

What about when EFI memory maps are used?

>
> # echo scan > /sys/kernel/debug/kmemleak
> [   54.888353] Unable to handle kernel paging request at virtual address ff5fffffffe00000
> [   54.888932] Oops [#1]
> [   54.889102] Modules linked in:
> [   54.889326] CPU: 2 PID: 134 Comm: bash Not tainted 5.18.0-rc1-next-20220407 #33
> [   54.889620] Hardware name: riscv-virtio,qemu (DT)
> [   54.889901] epc : scan_block+0x74/0x15c
> [   54.890215]  ra : scan_block+0x72/0x15c
> [   54.890390] epc : ffffffff801e5806 ra : ffffffff801e5804 sp : ff200000104abc30
> [   54.890607]  gp : ffffffff815cd4e8 tp : ff60000004cfa340 t0 : 0000000000000200
> [   54.890835]  t1 : 00aaaaaac23954cc t2 : 00000000000003ff s0 : ff200000104abc90
> [   54.891024]  s1 : ffffffff81b0ff28 a0 : 0000000000000000 a1 : ff5fffffffe01000
> [   54.891201]  a2 : ffffffff81b0ff28 a3 : 0000000000000002 a4 : 0000000000000001
> [   54.891377]  a5 : 0000000000000000 a6 : ff200000104abd7c a7 : 0000000000000005
> [   54.891552]  s2 : ff5fffffffe00ff9 s3 : ffffffff815cd998 s4 : ffffffff815d0e90
> [   54.891727]  s5 : ffffffff81b0ff28 s6 : 0000000000000020 s7 : ffffffff815d0eb0
> [   54.891903]  s8 : ffffffffffffffff s9 : ff5fffffffe00000 s10: ff5fffffffe01000
> [   54.892078]  s11: 0000000000000022 t3 : 00ffffffaa17db4c t4 : 000000000000000f
> [   54.892271]  t5 : 0000000000000001 t6 : 0000000000000000
> [   54.892408] status: 0000000000000100 badaddr: ff5fffffffe00000 cause: 000000000000000d
> [   54.892643] [<ffffffff801e5a1c>] scan_gray_list+0x12e/0x1a6
> [   54.892824] [<ffffffff801e5d3e>] kmemleak_scan+0x2aa/0x57e
> [   54.892961] [<ffffffff801e633c>] kmemleak_write+0x32a/0x40c
> [   54.893096] [<ffffffff803915ac>] full_proxy_write+0x56/0x82
> [   54.893235] [<ffffffff801ef456>] vfs_write+0xa6/0x2a6
> [   54.893362] [<ffffffff801ef880>] ksys_write+0x6c/0xe2
> [   54.893487] [<ffffffff801ef918>] sys_write+0x22/0x2a
> [   54.893609] [<ffffffff8000397c>] ret_from_syscall+0x0/0x2
> [   54.894183] ---[ end trace 0000000000000000 ]---
>
> Add base checking and ignore the range lower than MIN_MEMBLOCK_ADDR.
>
> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
> ---
>  drivers/of/fdt.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index ec315b060..296c4ab8e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -33,6 +33,13 @@
>
>  #include "of_private.h"
>
> +#ifndef MIN_MEMBLOCK_ADDR
> +#define MIN_MEMBLOCK_ADDR      __pa(PAGE_OFFSET)
> +#endif
> +#ifndef MAX_MEMBLOCK_ADDR
> +#define MAX_MEMBLOCK_ADDR      ((phys_addr_t)~0)
> +#endif
> +
>  /*
>   * of_fdt_limit_memory - limit the number of regions in the /memory node
>   * @limit: maximum entries
> @@ -480,6 +487,19 @@ static u32 of_fdt_crc32;
>  static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
>                                         phys_addr_t size, bool nomap)
>  {
> +       const u64 phys_offset = MIN_MEMBLOCK_ADDR;
> +
> +       if (base < phys_offset) {
> +               pr_warn("Ignoring reserved memory range 0x%llx - 0x%llx\n",
> +                       base, phys_offset);
> +               size = (phys_offset - base) < size ?
> +                       size - (phys_offset - base) : 0;
> +               base = phys_offset;
> +
> +               if (!size)
> +                       return -EFAULT;
> +       }
> +
>         if (nomap) {
>                 /*
>                  * If the memory is already reserved (by another region), we
> @@ -1198,13 +1218,6 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>         return 0;
>  }
>
> -#ifndef MIN_MEMBLOCK_ADDR
> -#define MIN_MEMBLOCK_ADDR      __pa(PAGE_OFFSET)
> -#endif
> -#ifndef MAX_MEMBLOCK_ADDR
> -#define MAX_MEMBLOCK_ADDR      ((phys_addr_t)~0)
> -#endif
> -
>  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
>         const u64 phys_offset = MIN_MEMBLOCK_ADDR;
> --
> 2.25.1
>
