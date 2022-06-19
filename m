Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AEE550CF3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiFSUco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 16:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiFSUch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 16:32:37 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F86B7FE;
        Sun, 19 Jun 2022 13:32:34 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o31am-0000EW-MI; Sun, 19 Jun 2022 22:32:20 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, rdunlap@infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v4 0/4] riscv: implement Zicbom-based CMO instructions + the t-head variant
Date:   Sun, 19 Jun 2022 22:32:08 +0200
Message-Id: <20220619203212.3604485-1-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on the alternatives changes done in my svpbmt series
and thus also depends on Atish's isa-extension parsing series.

It implements using the cache-management instructions from the  Zicbom-
extension to handle cache flush, etc actions on platforms needing them.

SoCs using cpu cores from T-Head like the Allwinne D1 implement a
different set of cache instructions. But while they are different,
instructions they provide the same functionality, so a variant can
easly hook into the existing alternatives mechanism on those.


An ongoing discussion is about the currently used pre-coded
instructions. Palmer's current thinking is that we should wait
until the relevant instructions have landed in binutils.

The main Zicbom instructions are in toolchains now and at least
Debian also carries a binutils snapshot with it, but the T-Head
variant still uses pre-coded instructions for now.

The series sits on top of my svpbmt fixup series, which
for example includes the conversion away from function pointers
for the check-functions. And also uses my nops-series.


Hopefully I caught all the review-comments from v3.


changes in v4:
- modify of_dma_is_coherent() also handle coherent system
  with maybe noncoherent devices
- move Zicbom to use real instructions
- split off the actual dma-noncoherent code from the Zicbom
  extension
- Don't assumes devices are non-coherent, instead default to
  coherent and require the non-coherent ones to be marked
- CPUFEATURE_ZICBOM instead of CPUFEATURE_CMO
- fix used cache addresses
- drop some unused headers from dma-noncoherent.c
- move unsigned long cast when calling ALT_CMO_OP
- remove unneeded memset-0
- define ARCH_DMA_MINALIGN
- use flush instead of inval in arch_sync_dma_for_cpu()
- depend on !XIP_KERNEL
- trim some line lengths
- improve Kconfig description

changes in v3:
- rebase onto 5.19-rc1 + svpbmt-fixup-series
- adapt wording for block-size binding
- include asm/cacheflush.h into dma-noncoherent to fix the
  no-prototype error clang seems to generate
- use __nops macro for readability
- add some received tags
- add a0 to the clobber list

changes in v2:
- cbom-block-size is hardware-specific and comes from firmware
- update Kconfig name to use the ISA extension name
- select the ALTERNATIVES symbol when enabled
- shorten the line lengths of the errata-assembly

Heiko Stuebner (4):
  of: also handle dma-noncoherent in of_dma_is_coherent()
  dt-bindings: riscv: document cbom-block-size
  riscv: Implement Zicbom-based cache management operations
  riscv: implement cache-management errata for T-Head SoCs

 .../devicetree/bindings/riscv/cpus.yaml       |  5 +
 arch/riscv/Kconfig                            | 31 ++++++
 arch/riscv/Kconfig.erratas                    | 11 +++
 arch/riscv/Makefile                           |  4 +
 arch/riscv/errata/thead/errata.c              | 15 +++
 arch/riscv/include/asm/cache.h                |  4 +
 arch/riscv/include/asm/cacheflush.h           |  6 ++
 arch/riscv/include/asm/errata_list.h          | 59 +++++++++++-
 arch/riscv/include/asm/hwcap.h                |  1 +
 arch/riscv/kernel/cpu.c                       |  1 +
 arch/riscv/kernel/cpufeature.c                | 18 ++++
 arch/riscv/kernel/setup.c                     |  2 +
 arch/riscv/mm/Makefile                        |  1 +
 arch/riscv/mm/dma-noncoherent.c               | 96 +++++++++++++++++++
 drivers/of/address.c                          | 16 +++-
 15 files changed, 263 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/mm/dma-noncoherent.c

-- 
2.35.1

