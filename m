Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9229B4D2A33
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiCIH7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiCIH6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:58:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132DC16A595;
        Tue,  8 Mar 2022 23:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FCEDB81FEB;
        Wed,  9 Mar 2022 07:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58358C36AF4;
        Wed,  9 Mar 2022 07:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646812603;
        bh=vSiQIpNhcZaMMK6brddWstUw5Q0bgZrXYlMHRYATWFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M6jAhByhAD2U56JWMoKivaUsoeeC7YnZ7K6cvGBcBJXFcmIJjv/fU6rEqQwUcycqz
         jMZUI4LRQGu6RL1/jZNM50M7D9tQyZalxiBrjFRkOOyA86CNQ77rfUIE/K0CcZIeaF
         7eLUZU+Kb1OmaTTuB1vS996a3nriF23IOyghHSj4nYPzzOMK6ZWMTuhkgxDIv58ZQF
         tnd+4ZBR41106aG1BauD6ldDH/YD95yPNTjWkcoKYWWgdSx0X47bwQFfyI+p245uWZ
         QhGVg30eCQkNftQDpBbw/LjOi3tGa3oUCalj1S4szHwCB+9W2GLITapPyerpLr+/ky
         ViLH2ODEN9FzA==
Received: by mail-vk1-f182.google.com with SMTP id w128so829724vkd.3;
        Tue, 08 Mar 2022 23:56:43 -0800 (PST)
X-Gm-Message-State: AOAM532a72mS4udw7dpvVWuq9ffZcblT5NpbCOyTeLov2iuZfzfuZist
        abZTijAl0voIj5D2m6itaYYHAy9b0gK4/wqGWRM=
X-Google-Smtp-Source: ABdhPJzMXc9YRIc4Pf7+ezNcKvkgBK+1tmciBOGXjLIl0yFLW5B6EU+m/7bu29v9BP6Sbveb2WXHhw/aopFCL2nkhpo=
X-Received: by 2002:a1f:1dce:0:b0:337:2726:d30f with SMTP id
 d197-20020a1f1dce000000b003372726d30fmr7908443vkd.2.1646812602000; Tue, 08
 Mar 2022 23:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20220209123800.269774-1-heiko@sntech.de>
In-Reply-To: <20220209123800.269774-1-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Mar 2022 15:56:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRRF-=GCsRRm5+JZ=uHXSX=mwE0anQsRtRXEDPPBkDB7w@mail.gmail.com>
Message-ID: <CAJF2gTRRF-=GCsRRm5+JZ=uHXSX=mwE0anQsRtRXEDPPBkDB7w@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] riscv: support for Svpbmt and D1 memory types
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        liush <liush@allwinnertech.com>,
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
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After trying it on my SMP 4*910 platform, it could boot normally.

Tested-by: Guo Ren <guoren@kernel.org>

On Wed, Feb 9, 2022 at 8:38 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Svpbmt is an extension defining "Supervisor-mode: page-based memory types"
> for things like non-cacheable pages or I/O memory pages.
>
>
> So this is my 2nd try at implementing Svpbmt (and the diverging D1 memory
> types) using the alternatives framework.
>
> This includes a number of changes to the alternatives mechanism itself.
> The biggest one being the move to a more central location, as I expect
> in the future, nearly every chip needing some sort of patching, be it
> either for erratas or for optional features (svpbmt or others).
>
> The dt-binding for svpbmt itself is of course not finished and is still
> using the binding introduced in previous versions, as where to put
> a svpbmt-property in the devicetree is still under dicussion.
> Atish seems to be working on a framework for extensions [0],
>
> The series also introduces support for the memory types of the D1
> which are implemented differently to svpbmt. But when patching anyway
> it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
> location.
>
> The only slightly bigger difference is that the "normal" type is not 0
> as with svpbmt, so kernel patches for this PMA type need to be applied
> even before the MMU is brought up, so the series introduces a separate
> stage for that.
>
>
> In theory this series is 3 parts:
> - sbi cache-flush / null-ptr
> - alternatives improvements
> - svpbmt+d1
>
> So expecially patches from the first 2 areas could be applied when
> deemed ready, I just thought to keep it together to show-case where
> the end-goal is and not requiring jumping between different series.
>
>
> The sbi cache-flush patch is based on Atish's sparse-hartid patch [1],
> as it touches a similar area in mm/cacheflush.c
>
>
> I picked the recipient list from the previous version, hopefully
> I didn't forget anybody.
>
> changes in v6:
> - rebase onto 5.17-rc1
> - handle sbi null-ptr differently
> - improve commit messages
> - use riscv,mmu as property name
>
> changes in v5:
> - move to use alternatives for runtime-patching
> - add D1 variant
>
>
> [0] https://lore.kernel.org/r/20211224211632.1698523-1-atishp@rivosinc.com
> [1] https://lore.kernel.org/r/20220120090918.2646626-1-atishp@rivosinc.com
>
>
> Heiko Stuebner (12):
>   riscv: prevent null-pointer dereference with sbi_remote_fence_i
>   riscv: integrate alternatives better into the main architecture
>   riscv: allow different stages with alternatives
>   riscv: implement module alternatives
>   riscv: implement ALTERNATIVE_2 macro
>   riscv: extend concatenated alternatives-lines to the same length
>   riscv: prevent compressed instructions in alternatives
>   riscv: move boot alternatives to a slightly earlier position
>   riscv: Fix accessing pfn bits in PTEs for non-32bit variants
>   riscv: add cpufeature handling via alternatives
>   riscv: remove FIXMAP_PAGE_IO and fall back to its default value
>   riscv: add memory-type errata for T-Head
>
> Wei Fu (2):
>   dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
>   riscv: add RISC-V Svpbmt extension support
>
>  .../devicetree/bindings/riscv/cpus.yaml       |  10 ++
>  arch/riscv/Kconfig.erratas                    |  29 ++--
>  arch/riscv/Kconfig.socs                       |   1 -
>  arch/riscv/Makefile                           |   2 +-
>  arch/riscv/errata/Makefile                    |   2 +-
>  arch/riscv/errata/sifive/errata.c             |  10 +-
>  arch/riscv/errata/thead/Makefile              |   1 +
>  arch/riscv/errata/thead/errata.c              |  85 +++++++++++
>  arch/riscv/include/asm/alternative-macros.h   | 114 ++++++++-------
>  arch/riscv/include/asm/alternative.h          |  16 ++-
>  arch/riscv/include/asm/errata_list.h          |  52 +++++++
>  arch/riscv/include/asm/fixmap.h               |   2 -
>  arch/riscv/include/asm/pgtable-32.h           |  17 +++
>  arch/riscv/include/asm/pgtable-64.h           |  79 +++++++++-
>  arch/riscv/include/asm/pgtable-bits.h         |  10 --
>  arch/riscv/include/asm/pgtable.h              |  53 +++++--
>  arch/riscv/include/asm/vendorid_list.h        |   1 +
>  arch/riscv/kernel/Makefile                    |   1 +
>  arch/riscv/{errata => kernel}/alternative.c   |  48 ++++++-
>  arch/riscv/kernel/cpufeature.c                | 136 +++++++++++++++++-
>  arch/riscv/kernel/head.S                      |   2 +
>  arch/riscv/kernel/module.c                    |  29 ++++
>  arch/riscv/kernel/sbi.c                       |  10 +-
>  arch/riscv/kernel/smpboot.c                   |   4 -
>  arch/riscv/kernel/traps.c                     |   2 +-
>  arch/riscv/mm/init.c                          |   1 +
>  26 files changed, 606 insertions(+), 111 deletions(-)
>  create mode 100644 arch/riscv/errata/thead/Makefile
>  create mode 100644 arch/riscv/errata/thead/errata.c
>  rename arch/riscv/{errata => kernel}/alternative.c (59%)
>
> --
> 2.30.2
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
