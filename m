Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83C4ED1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiCaC0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiCaC0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:26:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9AC6A01E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:24:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id y16so9895912pju.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bLMvLJJFTTmnxhwMXncQg6uKBGHqt+TMaS5Swg1qtTY=;
        b=P0+PdTbCgdxzx5Ecu2iu5B5MNFg4Phl10mw16mT5wgQWLcSo4zDF1Cu/rWPTDKKAjv
         N+OhVapRPmlRHWQmREvIsdcJIZeoMhLQFU1i3yxH9AQtuOEF5LruCaeqn6Gskp23lRrN
         H9TAtZ39yEPTO7uJgeljhiqUXjAi3AONTyW/LtA7axkfhwJ1MkI/ByXzvcoI7UYdd0bm
         OtQi8LqzzcTqwIe1sl6xoAig/BFaIL00GhWJN41hede0BiMUKo4zbJgpoTUsryjgQqE1
         MkHhaumSRG8aaKxyB78l9NF7roqHtDi+6Y13hLqH4l6Aqiw0NPZoU1kUSvTFrAtEeFW4
         sNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bLMvLJJFTTmnxhwMXncQg6uKBGHqt+TMaS5Swg1qtTY=;
        b=lzzXRhV8u3z02CMBoMZTBIUK0iop9Er2SYzj5ufvhWC428VCYn2IrPmSUujfTfsOzR
         o1TfOpRoNeQFvS7CBgwF7718fhnE2HCGFOU//4vSOYj6thQeq35YR1ao5UcQApESpe5t
         SRf31aZjYeiOx45hVP8mE6HEkp5qfjHz9UGRC+x5MuTqAcw7tQ6EdmDfEPJ3yXfvYDw1
         fGBC+7o3FJguY/NpffpwR3ghWMzLVpmJp6zpNwWMtknJ7u3+5r9mE8jjHWPiIAZwro7x
         95mM2XhQx6pq7Jcousp33I+ngCPGhIIOuyOk1/xRAETQpfoQ3SYhUyEY+aTtOyeNTpU/
         0Now==
X-Gm-Message-State: AOAM532pr3xBaFhQnvr4KaWw+11mUE8R/MknBS3yxLRUydIWe4d4nYax
        0z0AvIutUEQcco8rzSy+61pEYA==
X-Google-Smtp-Source: ABdhPJz23UgbrFTHE97IK6+XFdVb+eM237LbXxjvInI+00RE4uYvNl+kQxmBtWASHnOsUtz9BZ090w==
X-Received: by 2002:a17:903:2351:b0:154:5ab7:873d with SMTP id c17-20020a170903235100b001545ab7873dmr2952252plh.57.1648693458221;
        Wed, 30 Mar 2022 19:24:18 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k18-20020a056a00135200b004fb18fc6c78sm21471532pfu.31.2022.03.30.19.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:24:16 -0700 (PDT)
Date:   Wed, 30 Mar 2022 19:24:16 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Mar 2022 19:24:15 PDT (-0700)
Subject:     Re: [PATCH v8 00/14] riscv: support for Svpbmt and D1 memory types
In-Reply-To: <20220324000710.575331-1-heiko@sntech.de>
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
Message-ID: <mhng-0ebca9a9-133b-44d0-92cb-ffd2ec192475@palmer-ri-x1c9>
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

On Wed, 23 Mar 2022 17:06:56 PDT (-0700), heiko@sntech.de wrote:
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
> I picked the recipient list from the previous versions, hopefully
> I didn't forget anybody.
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

I'm still seeing a very similar failure mode.  There were a few merge 
conflicts when I tried to put this on top of my merged first PR, I've 
put what I'm testing at riscv-d1.  Not sure if I'm missing something.

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
>
> Heiko Stuebner (13):
>   riscv: prevent null-pointer dereference with sbi_remote_fence_i
>   riscv: integrate alternatives better into the main architecture
>   riscv: allow different stages with alternatives
>   riscv: implement module alternatives
>   riscv: implement ALTERNATIVE_2 macro
>   riscv: extend concatenated alternatives-lines to the same length
>   riscv: prevent compressed instructions in alternatives
>   riscv: move boot alternatives to after fill_hwcap
>   riscv: Fix accessing pfn bits in PTEs for non-32bit variants
>   riscv: add cpufeature handling via alternatives
>   riscv: remove FIXMAP_PAGE_IO and fall back to its default value
>   riscv: don't use global static vars to store alternative data
>   riscv: add memory-type errata for T-Head
>
> Wei Fu (1):
>   riscv: add RISC-V Svpbmt extension support
>
>  arch/riscv/Kconfig.erratas                  |  31 +++--
>  arch/riscv/Kconfig.socs                     |   1 -
>  arch/riscv/Makefile                         |   2 +-
>  arch/riscv/errata/Makefile                  |   2 +-
>  arch/riscv/errata/alternative.c             |  75 ------------
>  arch/riscv/errata/sifive/errata.c           |  17 ++-
>  arch/riscv/errata/thead/Makefile            |   1 +
>  arch/riscv/errata/thead/errata.c            |  82 +++++++++++++
>  arch/riscv/include/asm/alternative-macros.h | 121 ++++++++++++++------
>  arch/riscv/include/asm/alternative.h        |  16 ++-
>  arch/riscv/include/asm/errata_list.h        |  52 +++++++++
>  arch/riscv/include/asm/fixmap.h             |   2 -
>  arch/riscv/include/asm/hwcap.h              |   1 +
>  arch/riscv/include/asm/pgtable-32.h         |  17 +++
>  arch/riscv/include/asm/pgtable-64.h         |  79 ++++++++++++-
>  arch/riscv/include/asm/pgtable-bits.h       |  10 --
>  arch/riscv/include/asm/pgtable.h            |  53 +++++++--
>  arch/riscv/include/asm/vendorid_list.h      |   1 +
>  arch/riscv/kernel/Makefile                  |   1 +
>  arch/riscv/kernel/alternative.c             | 104 +++++++++++++++++
>  arch/riscv/kernel/cpu.c                     |   1 +
>  arch/riscv/kernel/cpufeature.c              |  80 ++++++++++++-
>  arch/riscv/kernel/module.c                  |  29 +++++
>  arch/riscv/kernel/sbi.c                     |  10 +-
>  arch/riscv/kernel/setup.c                   |   2 +
>  arch/riscv/kernel/smpboot.c                 |   4 -
>  arch/riscv/kernel/traps.c                   |   2 +-
>  arch/riscv/mm/init.c                        |   1 +
>  28 files changed, 629 insertions(+), 168 deletions(-)
>  delete mode 100644 arch/riscv/errata/alternative.c
>  create mode 100644 arch/riscv/errata/thead/Makefile
>  create mode 100644 arch/riscv/errata/thead/errata.c
>  create mode 100644 arch/riscv/kernel/alternative.c
