Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57C6525A25
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376784AbiEMDcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376767AbiEMDcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:32:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54447E52A6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:32:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so6622158pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=OcucJbRdUHNune3yaXCjGWuujEoA53OSfN/roH/VTmQ=;
        b=h5jdaoNvwxDkNplGIw9oZV3BTnBss2uRogYIhdDM1iyqd7DQUg8qHYA0uSKX6HErki
         oNpj7mhG1PuwLc1MWGSTCGma/aYzA80qCW4A3Vpmj5R1ihdKaw2230FTC4HdcqzZ/VSY
         fDSzYrMs5tKKKC4ZtX7nnF4YH/8fEpctmXxrFsHbiMsCpISNmsd7J6scmRGFqw4dbxGP
         dwoh3occKJnH0peC380StFgJsp2PgLWAzASWlvemOWN/W4HmnMX59+vxpbuHywIuEhVu
         ad7PIsdF3INnlxGSfY1yINLISZX2L/o23JDhmTSz2T4c1PnCAEzk1z88hYzg1xIJnWVf
         uydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=OcucJbRdUHNune3yaXCjGWuujEoA53OSfN/roH/VTmQ=;
        b=xLQxlKoF4cPurLKv3EpWKwg+da9PbhVD0YfsRJxKpTq4SVZztGMtnhj999V6yVe8ms
         tcG94MzB5e/Vkho1woZ/c9RgV+jvzwU+x2lJkW0Dac3FClsEPgcvG6jKdqD/Rdw09s6Z
         pNNgEKLbB0andXgi5xHeo5j4ZgAtrM4+6dMoTsttmDoxixbkM/dkjwdD+ndgudvkzbwg
         eroTLqdldCppubHKj75bcQhKwDILvbeUD14RN87iizic0OkPKK7bSxK+NUqRAGgbhQoL
         r+6WUfQyPO8BLTU3shghkRmNYCmctZYEDBVopXqqcTeqk3ECGg0r4r5gm4rdd/DPf9JX
         U//w==
X-Gm-Message-State: AOAM533p5Qys5C2kMf306kL/nUGuXyRFTKDjMqfZ7RSYLVfv/IGgJf7q
        Scl+xngYDLF268FAWcP/aRB2fQ==
X-Google-Smtp-Source: ABdhPJwDVScCgu2dBXj2idF0HxY+pJjo3fZtT3Ul4qy8cvfw2xsFS8WGa/v3nAY3+jwjxr88011yog==
X-Received: by 2002:a17:90b:1a88:b0:1dc:e4a1:a81e with SMTP id ng8-20020a17090b1a8800b001dce4a1a81emr14242416pjb.96.1652412770529;
        Thu, 12 May 2022 20:32:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i9-20020a632209000000b003db7de758besm510377pgi.5.2022.05.12.20.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 20:32:49 -0700 (PDT)
Date:   Thu, 12 May 2022 20:32:49 -0700 (PDT)
X-Google-Original-Date: Thu, 12 May 2022 20:32:47 PDT (-0700)
Subject:     Re: [PATCH v10 00/12] riscv: support for Svpbmt and D1 memory types
In-Reply-To: <20220511192921.2223629-1-heiko@sntech.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        wens@csie.org, maxime@cerno.tech, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        mick@ics.forth.gr, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, heiko@sntech.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-471ef84f-9ac4-44c9-ae85-0492d2a1ad99@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 12:29:09 PDT (-0700), heiko@sntech.de wrote:
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
> Detection of the svpbmt functionality is done via Atish's isa extension
> handling series [0] and thus does not need any dt-parsing of its own
> anymore.
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
> In theory this series is 2 parts:
> - alternatives improvements
> - svpbmt+d1
>
> I picked the recipient list from the previous versions, hopefully
> I didn't forget anybody.
>
> I tested the series on:
> - qemu-rv32 + buildroot rootfs
> - qemu-rv64 + debian roots
> - Allwinner D1-Nezha
> - BeagleV - it at least reached the same point as without the series

IMO that's fine, it's also broken due to issues around non-coherence but 
it has an entirely different way of handling things than.

> I also ran Palmers CI environment on 5.18-rc6 + this series and
> it passed with all testcases now.

Thanks, I know that's a bit of a mess.  If I ever get some time I'll try 
and clean it up, but it keeps finding issues so I'm sort of stuck with 
it for now.  As expected it now passes locally, so I've put this on 
for-next.  I hadn't noticed your testing was on rc6, I put this on top 
of rc1 -- that's what I usually do for merge window stuff, but if 
there's something specific between rc1 and rc6 this depends on then LMK 
and I'll sort it out.

> changes in v10:
> - add received review-tags
> - put early patching behind a kconfig symbol
> - adapt compiler flags of sources in use by early patching
>   similar to other riscv arch-parts.
>   This fixes the medlow cmodel issue on rv32 and also issues
>   with Kasan.
>
> changes in v9:
> - rebase onto 5.18-rc1
> - drop the sbi null-ptr patch
>   While I still think this to be non-ideal as is, it isn't really
>   necessary for svpbmt support anymore
> - merge cpufeature + svpbmt patch, as otherwise some empty shells
>   cause build warnings when a bisection stops between these two
>   patches
> - address review comments from Christoph Hellwig:
>   - keep alternatives optional, they now get selected by its
>     users (erratas and also the newly introduced svpbmt kconfig)
>   - wrap long lines and keep things below 80 characters
>   - restyle svpbmt + thead errata assembly
>   - introduce a helper for the repeated calls to
>     (val & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT
>
> changes in v8:
> - rebase onto 5.17-final + isa extension series
>   We're halfway through the merge-window, so this series
>   should be merge after that
> - adapt to fix limiting alternatives to non-xip-kernels
> - add .norelax option for alternatives
> - fix unused cpu_apply_errata in thead errata
> - don't use static globals to store cpu-manufacturer data
>   as it makes machines hang if done too early
>
> changes in v7:
> - fix typo in patch1 (Atish)
> - moved to Atish's isa-extension framework
> - and therefore move regular boot-alternatives directly behind fill_hwcaps
> - change T-Head errata Kconfig text (Atish)
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
> [0] https://lore.kernel.org/r/20220222204811.2281949-2-atishp@rivosinc.com
>
> Heiko Stuebner (12):
>   riscv: integrate alternatives better into the main architecture
>   riscv: allow different stages with alternatives
>   riscv: implement module alternatives
>   riscv: implement ALTERNATIVE_2 macro
>   riscv: extend concatenated alternatives-lines to the same length
>   riscv: prevent compressed instructions in alternatives
>   riscv: move boot alternatives to after fill_hwcap
>   riscv: Fix accessing pfn bits in PTEs for non-32bit variants
>   riscv: add RISC-V Svpbmt extension support
>   riscv: remove FIXMAP_PAGE_IO and fall back to its default value
>   riscv: don't use global static vars to store alternative data
>   riscv: add memory-type errata for T-Head
>
>  arch/riscv/Kconfig                          |  28 +++++
>  arch/riscv/Kconfig.erratas                  |  34 ++++--
>  arch/riscv/Kconfig.socs                     |   1 -
>  arch/riscv/Makefile                         |   2 +-
>  arch/riscv/errata/Makefile                  |   2 +-
>  arch/riscv/errata/alternative.c             |  75 ------------
>  arch/riscv/errata/sifive/errata.c           |  20 ++-
>  arch/riscv/errata/thead/Makefile            |  11 ++
>  arch/riscv/errata/thead/errata.c            |  82 +++++++++++++
>  arch/riscv/include/asm/alternative-macros.h | 129 +++++++++++++++-----
>  arch/riscv/include/asm/alternative.h        |  25 +++-
>  arch/riscv/include/asm/errata_list.h        |  59 +++++++++
>  arch/riscv/include/asm/fixmap.h             |   2 -
>  arch/riscv/include/asm/hwcap.h              |   1 +
>  arch/riscv/include/asm/pgtable-32.h         |  17 +++
>  arch/riscv/include/asm/pgtable-64.h         |  79 +++++++++++-
>  arch/riscv/include/asm/pgtable-bits.h       |  10 --
>  arch/riscv/include/asm/pgtable.h            |  55 +++++++--
>  arch/riscv/include/asm/vendorid_list.h      |   1 +
>  arch/riscv/kernel/Makefile                  |  15 +++
>  arch/riscv/kernel/alternative.c             | 118 ++++++++++++++++++
>  arch/riscv/kernel/cpu.c                     |   1 +
>  arch/riscv/kernel/cpufeature.c              |  80 +++++++++++-
>  arch/riscv/kernel/module.c                  |  29 +++++
>  arch/riscv/kernel/setup.c                   |   2 +
>  arch/riscv/kernel/smpboot.c                 |   4 -
>  arch/riscv/kernel/traps.c                   |   2 +-
>  arch/riscv/mm/init.c                        |   1 +
>  28 files changed, 724 insertions(+), 161 deletions(-)
>  delete mode 100644 arch/riscv/errata/alternative.c
>  create mode 100644 arch/riscv/errata/thead/Makefile
>  create mode 100644 arch/riscv/errata/thead/errata.c
>  create mode 100644 arch/riscv/kernel/alternative.c
