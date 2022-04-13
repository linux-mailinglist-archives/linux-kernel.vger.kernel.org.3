Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E634FED46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiDMDF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiDMDFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:05:43 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44B95469A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:03:21 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1neTHl-0006sN-VP; Wed, 13 Apr 2022 05:03:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        hch@lst.de, arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v9 00/12] riscv: support for Svpbmt and D1 memory types
Date:   Wed, 13 Apr 2022 05:02:55 +0200
Message-Id: <20220413030307.133807-1-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Svpbmt is an extension defining "Supervisor-mode: page-based memory types"
for things like non-cacheable pages or I/O memory pages.


So this is my 2nd try at implementing Svpbmt (and the diverging D1 memory
types) using the alternatives framework.

This includes a number of changes to the alternatives mechanism itself.
The biggest one being the move to a more central location, as I expect
in the future, nearly every chip needing some sort of patching, be it
either for erratas or for optional features (svpbmt or others).

Detection of the svpbmt functionality is done via Atish's isa extension
handling series [0] and thus does not need any dt-parsing of its own
anymore.

The series also introduces support for the memory types of the D1
which are implemented differently to svpbmt. But when patching anyway
it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
location.

The only slightly bigger difference is that the "normal" type is not 0
as with svpbmt, so kernel patches for this PMA type need to be applied
even before the MMU is brought up, so the series introduces a separate
stage for that.


In theory this series is 2 parts:
- alternatives improvements
- svpbmt+d1

I picked the recipient list from the previous versions, hopefully
I didn't forget anybody.

I tested the series on:
- qemu-rv32 + buildroot rootfs
- qemu-rv64 + debian roots
- Allwinner D1-Nezha
- BeagleV - it at least reached the same point as without the series


changes in v9:
- rebase onto 5.18-rc1
- drop the sbi null-ptr patch
  While I still think this to be non-ideal as is, it isn't really
  necessary for svpbmt support anymore
- merge cpufeature + svpbmt patch, as otherwise some empty shells
  cause build warnings when a bisection stops between these two
  patches
- address review comments from Christoph Hellwig:
  - keep alternatives optional, they now get selected by its
    users (erratas and also the newly introduced svpbmt kconfig)
  - wrap long lines and keep things below 80 characters
  - restyle svpbmt + thead errata assembly
  - introduce a helper for the repeated calls to
    (val & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT

changes in v8:
- rebase onto 5.17-final + isa extension series
  We're halfway through the merge-window, so this series
  should be merge after that
- adapt to fix limiting alternatives to non-xip-kernels
- add .norelax option for alternatives
- fix unused cpu_apply_errata in thead errata
- don't use static globals to store cpu-manufacturer data
  as it makes machines hang if done too early

changes in v7:
- fix typo in patch1 (Atish)
- moved to Atish's isa-extension framework
- and therefore move regular boot-alternatives directly behind fill_hwcaps
- change T-Head errata Kconfig text (Atish)

changes in v6:
- rebase onto 5.17-rc1
- handle sbi null-ptr differently
- improve commit messages
- use riscv,mmu as property name

changes in v5:
- move to use alternatives for runtime-patching
- add D1 variant


[0] https://lore.kernel.org/r/20220222204811.2281949-2-atishp@rivosinc.com

Heiko Stuebner (12):
  riscv: integrate alternatives better into the main architecture
  riscv: allow different stages with alternatives
  riscv: implement module alternatives
  riscv: implement ALTERNATIVE_2 macro
  riscv: extend concatenated alternatives-lines to the same length
  riscv: prevent compressed instructions in alternatives
  riscv: move boot alternatives to after fill_hwcap
  riscv: Fix accessing pfn bits in PTEs for non-32bit variants
  riscv: add RISC-V Svpbmt extension support
  riscv: remove FIXMAP_PAGE_IO and fall back to its default value
  riscv: don't use global static vars to store alternative data
  riscv: add memory-type errata for T-Head

 arch/riscv/Kconfig                          |  22 ++++
 arch/riscv/Kconfig.erratas                  |  33 +++--
 arch/riscv/Kconfig.socs                     |   1 -
 arch/riscv/Makefile                         |   2 +-
 arch/riscv/errata/Makefile                  |   2 +-
 arch/riscv/errata/alternative.c             |  75 ------------
 arch/riscv/errata/sifive/errata.c           |  20 ++-
 arch/riscv/errata/thead/Makefile            |   1 +
 arch/riscv/errata/thead/errata.c            |  82 +++++++++++++
 arch/riscv/include/asm/alternative-macros.h | 129 +++++++++++++++-----
 arch/riscv/include/asm/alternative.h        |  25 +++-
 arch/riscv/include/asm/errata_list.h        |  59 +++++++++
 arch/riscv/include/asm/fixmap.h             |   2 -
 arch/riscv/include/asm/hwcap.h              |   1 +
 arch/riscv/include/asm/pgtable-32.h         |  17 +++
 arch/riscv/include/asm/pgtable-64.h         |  79 +++++++++++-
 arch/riscv/include/asm/pgtable-bits.h       |  10 --
 arch/riscv/include/asm/pgtable.h            |  55 +++++++--
 arch/riscv/include/asm/vendorid_list.h      |   1 +
 arch/riscv/kernel/Makefile                  |   1 +
 arch/riscv/kernel/alternative.c             | 104 ++++++++++++++++
 arch/riscv/kernel/cpu.c                     |   1 +
 arch/riscv/kernel/cpufeature.c              |  80 +++++++++++-
 arch/riscv/kernel/module.c                  |  29 +++++
 arch/riscv/kernel/setup.c                   |   2 +
 arch/riscv/kernel/smpboot.c                 |   4 -
 arch/riscv/kernel/traps.c                   |   2 +-
 arch/riscv/mm/init.c                        |   1 +
 28 files changed, 679 insertions(+), 161 deletions(-)
 delete mode 100644 arch/riscv/errata/alternative.c
 create mode 100644 arch/riscv/errata/thead/Makefile
 create mode 100644 arch/riscv/errata/thead/errata.c
 create mode 100644 arch/riscv/kernel/alternative.c

-- 
2.35.1

