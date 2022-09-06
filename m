Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF9A5AE545
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiIFKXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiIFKWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:22:55 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEFE87A51D;
        Tue,  6 Sep 2022 03:22:11 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,293,1654527600"; 
   d="scan'208";a="133888032"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Sep 2022 19:22:09 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B847841BDC42;
        Tue,  6 Sep 2022 19:22:05 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 0/2] AX45MP: Add support to non-coherent DMA
Date:   Tue,  6 Sep 2022 11:21:52 +0100
Message-Id: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On the Andes AX45MP core, cache coherency is a specification option so it
may not be supported. In this case DMA will fail. To get around with this
issue this patch series  does the below:

Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
block that allows dynamic adjustment of memory attributes in the runtime.
It contains a configurable amount of PMA entries implemented as CSR
registers to control the attributes of memory locations in interest. PMA
regions are passed from the cpu core node which are configured as
non-cacheable and non-bufferable with the SBI call.

        ax45mp: cpu@0 {
                compatible = "andestech,ax45mp", "riscv";
                device_type = "cpu";
                ....
                pma-regions = <0x0 0x00000000 0x0 0x14000000>,
                              <0x0 0x20000000 0x0 0x10000000>,
                              <0x0 0x58000000 0x0 0x08000000>;
                ....
        };

We provide callbacks to synchronize specific content between memory and
cache. We allocate a global DMA coherent pool (which is marked as
non-cached using PMA) so that DMA memory allocations happens from this
pool and we implement the below callbacks:

- arch_sync_dma_for_device()
- arch_sync_dma_for_cpu()
- arch_dma_alloc()
- arch_dma_free()

Below are the configs that are enabled:

- DMA_GLOBAL_POOL
- ARCH_HAS_SYNC_DMA_FOR_CPU
- ARCH_HAS_SYNC_DMA_FOR_DEVICE

        l2cache: cache-controller@13400000 {
                compatible = "andestech,ax45mp-cache", "cache";
                cache-size = <0x40000>;
                cache-line-size = <64>;
                cache-sets = <1024>;
                cache-unified;
                reg = <0x0 0x13400000 0x0 0x100000>;
	};

Due to the above approach custom SBI calls have been implemented. The
above implementation is in preparation for adding support for Renesas
RZ/Five SoC which uses the AX45MP core. As with the above approach the
kernel image might not be generic so that it can be used on other
platforms, so sending it as an RFC (without DT binding patches).

OpenSBI implementation isn't upstreamed yet, public repo for access is
available at [0].

[0] https://github.com/renesas-rz/rz_opensbi/tree/work/OpenSBI-PMA

Cheers,
Prabhakar

Lad Prabhakar (2):
  riscv: vendors: andes: Add support to configure the PMA regions
  riscv: vendors: andes: Add support for non-cohernet dma

 arch/riscv/Kbuild                             |   2 +
 arch/riscv/include/asm/sbi.h                  |   1 +
 arch/riscv/vendors/Makefile                   |   3 +
 arch/riscv/vendors/andes/Makefile             |   4 +
 arch/riscv/vendors/andes/ax45mp.c             |  93 ++++++
 arch/riscv/vendors/andes/ax45mp_cache.c       | 296 ++++++++++++++++++
 arch/riscv/vendors/andes/ax45mp_nocache_dma.c |  65 ++++
 arch/riscv/vendors/andes/include/proc.h       |   9 +
 arch/riscv/vendors/andes/include/sbi.h        |  27 ++
 9 files changed, 500 insertions(+)
 create mode 100644 arch/riscv/vendors/Makefile
 create mode 100644 arch/riscv/vendors/andes/Makefile
 create mode 100644 arch/riscv/vendors/andes/ax45mp.c
 create mode 100644 arch/riscv/vendors/andes/ax45mp_cache.c
 create mode 100644 arch/riscv/vendors/andes/ax45mp_nocache_dma.c
 create mode 100644 arch/riscv/vendors/andes/include/proc.h
 create mode 100644 arch/riscv/vendors/andes/include/sbi.h

-- 
2.25.1

