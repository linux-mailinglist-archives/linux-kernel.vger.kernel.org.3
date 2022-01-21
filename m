Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7265F4962F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbiAUQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:37:17 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35240 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346487AbiAUQhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:37:05 -0500
Received: from p508fcef5.dip0.t-ipconnect.de ([80.143.206.245] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nAwuE-0008GA-HL; Fri, 21 Jan 2022 17:36:54 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 00/14] riscv: support for svpbmt and D1 memory types
Date:   Fri, 21 Jan 2022 17:36:04 +0100
Message-Id: <20220121163618.351934-1-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this is my try at implementing svpbmt (and the diverging D1 memory
types using the alternatives framework).

This includes a number of changes to the alternatives mechanism itself.
The biggest one being the move to a more central location, as I expect
in the future, nearly every chip needing some sort of patching, be it
either for erratas or for optional features (svpbmt or others).

The dt-binding for svpbmt itself is of course not finished and is still
using the binding introduced in previous versions, as where to put
a svpbmt-property in the devicetree is still under dicussion.
Atish seems to be working on a framework for extensions [0],

The series also introduces support for the memory types of the D1
which are implemented differently to svpbmt. But when patching anyway
it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
location.

The only slightly bigger difference is that the "normal" type is not 0
as with svpbmt, so kernel patches for this PMA type need to be applied
even before the MMU is brought up, so the series introduces a separate
stage for that.


In theory this series is 3 parts:
- sbi cache-flush / null-ptr
- alternatives improvements
- svpbmt+d1

So expecially patches from the first 2 areas could be applied when
deemed ready, I just thought to keep it together to show-case where
the end-goal is and not requiring jumping between different series.


The sbi cache-flush patch is based on Atish's sparse-hartid patch [1],
as it touches a similar area in mm/cacheflush.c


I picked the recipient list from the previous version, hopefully
I didn't forget anybody.


[0] https://lore.kernel.org/r/20211224211632.1698523-1-atishp@rivosinc.com
[1] https://lore.kernel.org/r/20220120090918.2646626-1-atishp@rivosinc.com


Heiko Stuebner (12):
  riscv: only use IPIs to handle cache-flushes on remote cpus
  riscv: integrate alternatives better into the main architecture
  riscv: allow different stages with alternatives
  riscv: implement module alternatives
  riscv: implement ALTERNATIVE_2 macro
  riscv: extend concatenated alternatives-lines to the same length
  riscv: prevent compressed instructions in alternatives
  riscv: move boot alternatives to a slightly earlier position
  riscv: Fix accessing pfn bits in PTEs for non-32bit variants
  riscv: add cpufeature handling via alternatives
  riscv: remove FIXMAP_PAGE_IO and fall back to its default value
  riscv: add memory-type errata for T-Head

Wei Fu (2):
  dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
  riscv: add RISC-V Svpbmt extension supports

 .../devicetree/bindings/riscv/cpus.yaml       |  10 ++
 arch/riscv/Kconfig.erratas                    |  29 ++--
 arch/riscv/Kconfig.socs                       |   1 -
 arch/riscv/Makefile                           |   2 +-
 arch/riscv/errata/Makefile                    |   2 +-
 arch/riscv/errata/sifive/errata.c             |  10 +-
 arch/riscv/errata/thead/Makefile              |   1 +
 arch/riscv/errata/thead/errata.c              |  85 +++++++++++
 arch/riscv/include/asm/alternative-macros.h   | 114 ++++++++-------
 arch/riscv/include/asm/alternative.h          |  16 ++-
 arch/riscv/include/asm/errata_list.h          |  52 +++++++
 arch/riscv/include/asm/fixmap.h               |   2 -
 arch/riscv/include/asm/pgtable-32.h           |  17 +++
 arch/riscv/include/asm/pgtable-64.h           |  79 +++++++++-
 arch/riscv/include/asm/pgtable-bits.h         |  10 --
 arch/riscv/include/asm/pgtable.h              |  53 +++++--
 arch/riscv/include/asm/vendorid_list.h        |   1 +
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/{errata => kernel}/alternative.c   |  47 +++++-
 arch/riscv/kernel/cpufeature.c                | 136 +++++++++++++++++-
 arch/riscv/kernel/head.S                      |   2 +
 arch/riscv/kernel/module.c                    |  29 ++++
 arch/riscv/kernel/smpboot.c                   |   4 -
 arch/riscv/kernel/traps.c                     |   2 +-
 arch/riscv/mm/cacheflush.c                    |   8 +-
 arch/riscv/mm/init.c                          |   2 +
 26 files changed, 599 insertions(+), 116 deletions(-)
 create mode 100644 arch/riscv/errata/thead/Makefile
 create mode 100644 arch/riscv/errata/thead/errata.c
 rename arch/riscv/{errata => kernel}/alternative.c (60%)

-- 
2.30.2

