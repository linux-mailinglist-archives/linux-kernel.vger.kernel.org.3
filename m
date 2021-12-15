Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB74753B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbhLOHc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbhLOHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:32:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D4EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:32:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB538617CC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4298EC34607
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639553575;
        bh=nF1BuyrdfYviJ1LvdCFhedgh6PAdAr4LVJs8j+DARW8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HqDNnF5k1ul8iV5ZWtUkUhjD2RKms1bf0nZB4jil6D3tUKJds0je90vekmZF0PIG+
         lfmOcqy7sUgw2YFMO1UTYw7OiNkArg7KSUlMiJgf9zJJjnxLu9C9V0NUcrkTPEznNU
         gqa8r72UA6KnW1dxtHvcLttiwlcYyBXvfr8MqaQKWeYbOaVUyqlIqnBVta6gFAXI7P
         1ydJQ0kTJsjJg94p7fFyDlTyWh+KZiTQm1ZXAF0bunxi7iVXGBdlaoJySCdOBstuIJ
         vQcjpWcKxB9KAf64Cuk/KAslakU/mi0vW8kS80DEmZgVYNBI0luWXnNu28sXNouGCH
         QJJJ/5nRc11Fw==
Received: by mail-wr1-f43.google.com with SMTP id e5so3116074wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:32:55 -0800 (PST)
X-Gm-Message-State: AOAM533DzNoHk0vswz0a+DZGtHgDbZiiRUILGsLP8rEGcBgDWkdjuJ08
        JrBOrlIO6dhfq+8lUJ786GI4ObYMX/JOdmOl8dU=
X-Google-Smtp-Source: ABdhPJy9TJqvB4Ar5cwUeouN3PfD1VPNsXQi9x5PZ8Y/0A7yEZ4OY0O7CHT2/FImY//EvK5dYGaPtWjNTSgcUrvreRY=
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr3138496wrc.417.1639553573545;
 Tue, 14 Dec 2021 23:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com> <20211215064559.2843555-2-peng.fan@oss.nxp.com>
In-Reply-To: <20211215064559.2843555-2-peng.fan@oss.nxp.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Dec 2021 08:32:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE8AQaiyHQU9k18P7dK81xhuWRmh3BhpOSP_qPnsX+sRg@mail.gmail.com>
Message-ID: <CAMj1kXE8AQaiyHQU9k18P7dK81xhuWRmh3BhpOSP_qPnsX+sRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 07:56, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> There is a "mem=[x]" boot parameter, but when there is a whole reserved
> by secure TEE, the continuous DRAM area is split with two memblocks.
>
> For example, DRAM area [0x40000000, 0xffffffff], when TEE uses
> [0x50000000, 0x51000000), the memblock will be split into
> [0x40000000, 0x50000000) and [0x51000000, 0xffffffff].
>
> If pass "mem=1024MB", the actually max addr will be 0x81000000.
> However if need the max addr be 0x80000000, mem=1008MB should be used.
>
> There also might be multiple other holes that no visible to Linux, when
> we wanna to limit the max addr usable by Linux, using "max_addr=[X]" is
> much easier than "mem=[X]"
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

mem= is a hack already, please don't add another one. Limiting the
memory like this is far too tricky, given that the kernel itself and
the initrd could end up in memory that is excluded, and we have to go
and fix things up if that happens.


> ---
>  arch/arm64/mm/init.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index db63cc885771..3364b5e7a7fe 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -173,6 +173,7 @@ int pfn_is_map_memory(unsigned long pfn)
>  EXPORT_SYMBOL(pfn_is_map_memory);
>
>  static phys_addr_t memory_limit __ro_after_init = PHYS_ADDR_MAX;
> +static phys_addr_t max_addr __ro_after_init = PHYS_ADDR_MAX;
>
>  /*
>   * Limit the memory size that was specified via FDT.
> @@ -189,6 +190,18 @@ static int __init early_mem(char *p)
>  }
>  early_param("mem", early_mem);
>
> +static int __init set_max_addr(char *p)
> +{
> +       if (!p)
> +               return 1;
> +
> +       max_addr = memparse(p, &p) & PAGE_MASK;
> +       pr_notice("Memory max addr set to 0x%llx\n", max_addr);
> +
> +       return 0;
> +}
> +early_param("max_addr", set_max_addr);
> +
>  void __init arm64_memblock_init(void)
>  {
>         s64 linear_region_size = PAGE_END - _PAGE_OFFSET(vabits_actual);
> @@ -253,6 +266,9 @@ void __init arm64_memblock_init(void)
>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>         }
>
> +       if (max_addr != PHYS_ADDR_MAX)
> +               memblock_cap_memory_range(0, max_addr);
> +
>         if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>                 /*
>                  * Add back the memory we just removed if it results in the
> @@ -427,4 +443,9 @@ void dump_mem_limit(void)
>         } else {
>                 pr_emerg("Memory Limit: none\n");
>         }
> +
> +       if (max_addr != PHYS_ADDR_MAX)
> +               pr_emerg("Max addr: 0x%llx\n", max_addr);
> +       else
> +               pr_emerg("Max addr: none\n");
>  }
> --
> 2.25.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
