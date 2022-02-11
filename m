Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA44B1A64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346323AbiBKA0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:26:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345707AbiBKA0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:26:09 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE83E5594
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:26:09 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id p5so20160112ybd.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83N6vWrDkZWain3/17uq/dXBQLDHd+VSAFLGYlPzOiw=;
        b=ImzKyXL9JdkGxreq3TljkBiZd1/U2yOKqNjkNfES3hHIqCkqc0E0m7Oc1VYnpT7xre
         T1ktfUfsg9ZAC6caxpY83Ize6AJQM2iG+kiFsOG7ZDmqX+9xTYM5FrZ0/HrQzj73phmk
         rrpWGoclZftkmpWT+Ivndn2D/r3rIUPv5ByNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83N6vWrDkZWain3/17uq/dXBQLDHd+VSAFLGYlPzOiw=;
        b=4X+orBnj3sNDGH/tBsu/7B4u40E3/0DM5EFCzGsHAvwn6bQp1+/TstcMK5WWlyIgcD
         JMDw9EjY8ahPLdysjtEH4avhQUnnvYGPaIUdeZ/xJRH1PgulNE+PR1o98g1aZMBd+zrG
         78NpqsgXZAmtBGBKpa6rhzrSm7/aahLGKx8GIuQzgUbgDA+4oHZnD7hT2nhLU5lLegVi
         +aHXrOp0zsvqYNr3vu0/ESfV3qrSjQM10acP3Hy50oXjdSSIKe0t+06qJOg+inasbKPX
         zQwLHmvg3BiTNTIZJqM3P6dUOO34CC+wyR9jnENMJ8/f3ne3PTjuJHhTmLshHLtkcS8x
         sy1w==
X-Gm-Message-State: AOAM533W5VZ9s2BNOFOM4grdE4wNp9lePPxWllfD2h0wD+/WUyKxko7N
        os/TM4hkAxp3Gk9cUGEH/0PmxCf85LJuFzd2hruq
X-Google-Smtp-Source: ABdhPJy4a/432gjLvmZVWdj5crHbM/KsVz7OqHnLg1XVpmyOGMdekEAT80M2FEW71WD3+vYj/xMBF2lWxTdBiWgGtNQ=
X-Received: by 2002:a25:c344:: with SMTP id t65mr9155165ybf.10.1644539168913;
 Thu, 10 Feb 2022 16:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20220209123800.269774-1-heiko@sntech.de>
In-Reply-To: <20220209123800.269774-1-heiko@sntech.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 10 Feb 2022 16:25:58 -0800
Message-ID: <CAOnJCUL5w4+_zJvu-BxP+LGN2ohv6arY+uh0DOU586v_5mCE8g@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] riscv: support for Svpbmt and D1 memory types
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

On Wed, Feb 9, 2022 at 4:38 AM Heiko Stuebner <heiko@sntech.de> wrote:
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

Here is the patch series
https://lore.kernel.org/lkml/20220210214018.55739-1-atishp@rivosinc.com/

I think we can simplify the cpu feature probing in PATCH 10 with the
above series
which simply relies on the existing riscv_isa bitmap.

We also don't need the separate svpbmt property in DT mmu node.
Let me know what you think.

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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
