Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86DB58B47F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiHFIMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHFIM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:12:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9D1DF0D
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3l/KxdlC5ECTHLfEYr3776uNDKuaqbR7whmW5K5ctqs=; b=z+TVL1+1wnQO5mswo5rS8SFvoz
        jAym3/RSXw6aXeN14e7mLnawaLGQ3exth9P5nTdN+QEN4cMIQ4+KA4/fGnYDcbG8ZJqArm1WV0jJC
        5GKNxMnn7gj1M+JhTQ5CCAOCQziFK3uUebmHQOmME/03XHsB+Jq6tCX3NKX4KN6xUHhGoSJaUPj3O
        QjmNlfAhxvrqw2D3OzJWVVvbeMunfbWe+XjFM4rNgDd0bBTCTC03g+7RPmmUzpPZILcaZ/nQLwAgW
        s3w7regju64TrZMzHRwYejQSoo/XTNHnN80uX2TNOR4ripFUhrXRpjNyP58umzGpeQoBwAUp4LpPv
        ZErZ+50w==;
Received: from [2001:4bb8:192:6d54:4997:d9fe:27ec:4c3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEv3-006PBN-FA; Sat, 06 Aug 2022 08:12:25 +0000
Date:   Sat, 6 Aug 2022 10:12:23 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for the kernel formetly known as 5.20
Message-ID: <Yu4iZzP92/f/lNEx@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.20-2022-08-06

for you to fetch changes up to 5c850d31880e00f063fa2a3746ba212c4bcc510f:

  swiotlb: fix passing local variable to debugfs_create_ulong() (2022-07-28 07:23:30 -0700)

----------------------------------------------------------------
dma-mapping updates

 - convert arm32 to the common dma-direct code (Arnd Bergmann, Robin Murphy,
   Christoph Hellwig)
 - restructure the PCIe peer to peer mapping support (Logan Gunthorpe)
 - allow the IOMMU code to communicate an optional DMA mapping length
   and use that in scsi and libata (John Garry)
 - split the global swiotlb lock (Tianyu Lan)
 - various fixes and cleanup (Chao Gao, Dan Carpenter, Dongli Zhang,
   Lukas Bulwahn, Robin Murphy)

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: sa1100/assabet: move dmabounce hack to ohci driver

Chao Gao (3):
      swiotlb: remove unused fields in io_tlb_mem
      swiotlb: consolidate rounding up default_nslabs
      swiotlb: ensure a segment doesn't cross the area boundary

Christoph Hellwig (7):
      ARM/dma-mapping: remove dmabounce
      ARM/dma-mapping: mark various dma-mapping routines static in dma-mapping.c
      ARM/dma-mapping: remove the unused virt_to_dma helper
      ARM/dma-mapping: use dma_to_phys/phys_to_dma in the dma-mapping code
      ARM/dma-mapping: use the generic versions of dma_to_phys/phys_to_dma by default
      ARM/dma-mapping: use dma-direct unconditionally
      swiotlb: move struct io_tlb_slot to swiotlb.c

Dan Carpenter (1):
      swiotlb: fix use after free on error handling path

Dongli Zhang (4):
      swiotlb: remove the unused swiotlb_force declaration
      swiotlb: remove a useless return in swiotlb_init
      x86/swiotlb: fix param usage in boot-options.rst
      swiotlb: panic if nslabs is too small

John Garry (7):
      dma-mapping: add dma_opt_mapping_size()
      dma-iommu: add iommu_dma_opt_mapping_size()
      scsi: core: cap shost max_sectors according to DMA limits only once
      scsi: sd: allow max_sectors be capped at DMA optimal size limit
      scsi: scsi_transport_sas: cap shost opt_sectors according to DMA optimal limit
      ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors
      scsi: sd: Add a comment about limiting max_sectors to shost optimal limit

Logan Gunthorpe (14):
      lib/scatterlist: add flag for indicating P2PDMA segments in an SGL
      PCI/P2PDMA: Attempt to set map_type if it has not been set
      PCI/P2PDMA: Introduce helpers for dma_map_sg implementations
      dma-mapping: allow EREMOTEIO return code for P2PDMA transfers
      dma-direct: support PCI P2PDMA pages in dma-direct map_sg
      dma-mapping: add flags to dma_map_ops to indicate PCI P2PDMA support
      iommu: Explicitly skip bus address marked segments in __iommu_map_sg()
      iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg
      nvme-pci: check DMA ops when indicating support for PCI P2PDMA
      nvme-pci: convert to using dma_map_sgtable()
      RDMA/core: introduce ib_dma_pci_p2p_dma_supported()
      RDMA/rw: drop pci_p2pdma_[un]map_sg()
      PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()
      dma-mapping: reformat comment to suppress htmldoc warning

Lukas Bulwahn (1):
      dma-mapping: update comment after dmabounce removal

Robin Murphy (4):
      ARM/dma-mapping: drop .dma_supported for IOMMU ops
      ARM/dma-mapping: consolidate IOMMU ops callbacks
      ARM/dma-mapping: merge IOMMU ops
      swiotlb: fail map correctly with failed io_tlb_default_mem

Tianyu Lan (3):
      swiotlb: split up the global swiotlb lock
      swiotlb: clean up some coding style and minor issues
      swiotlb: fix passing local variable to debugfs_create_ulong()

 Documentation/admin-guide/kernel-parameters.txt    |   5 +-
 Documentation/core-api/dma-api.rst                 |  14 +
 Documentation/x86/x86_64/boot-options.rst          |   8 +-
 arch/arm/Kconfig                                   |   5 +-
 arch/arm/common/Kconfig                            |   6 +-
 arch/arm/common/Makefile                           |   1 -
 arch/arm/common/dmabounce.c                        | 582 ------------------
 arch/arm/common/sa1111.c                           |  64 --
 arch/arm/include/asm/device.h                      |   3 -
 arch/arm/include/asm/dma-direct.h                  |  49 +-
 arch/arm/include/asm/dma-mapping.h                 | 128 ----
 arch/arm/include/asm/memory.h                      |   2 -
 arch/arm/mach-footbridge/Kconfig                   |   1 +
 arch/arm/mach-footbridge/common.c                  |  19 +-
 arch/arm/mach-footbridge/include/mach/dma-direct.h |   8 +
 arch/arm/mach-footbridge/include/mach/memory.h     |   4 -
 arch/arm/mach-highbank/highbank.c                  |   2 +-
 arch/arm/mach-mvebu/coherency.c                    |   2 +-
 arch/arm/mm/dma-mapping.c                          | 652 +++------------------
 drivers/ata/libata-scsi.c                          |   1 +
 drivers/infiniband/core/rw.c                       |  45 +-
 drivers/iommu/dma-iommu.c                          | 105 +++-
 drivers/iommu/iommu.c                              |   4 +
 drivers/iommu/iova.c                               |   5 +
 drivers/nvme/host/core.c                           |   3 +-
 drivers/nvme/host/nvme.h                           |   2 +-
 drivers/nvme/host/pci.c                            |  81 ++-
 drivers/nvme/target/rdma.c                         |   2 +-
 drivers/pci/Kconfig                                |   5 +
 drivers/pci/p2pdma.c                               |  93 +--
 drivers/scsi/hosts.c                               |   5 +
 drivers/scsi/scsi_lib.c                            |   4 -
 drivers/scsi/scsi_transport_sas.c                  |   6 +
 drivers/scsi/sd.c                                  |   7 +
 drivers/usb/core/hcd.c                             |  17 +-
 drivers/usb/host/ohci-sa1111.c                     |  25 +
 include/linux/dma-map-ops.h                        |  64 ++
 include/linux/dma-mapping.h                        |  10 +
 include/linux/iova.h                               |   2 +
 include/linux/pci-p2pdma.h                         |  27 -
 include/linux/scatterlist.h                        |  69 +++
 include/linux/swiotlb.h                            |  17 +-
 include/rdma/ib_verbs.h                            |  11 +
 include/scsi/scsi_host.h                           |   1 +
 kernel/dma/direct.c                                |  43 +-
 kernel/dma/direct.h                                |   8 +-
 kernel/dma/mapping.c                               |  47 +-
 kernel/dma/swiotlb.c                               | 263 +++++++--
 48 files changed, 833 insertions(+), 1694 deletions(-)
 delete mode 100644 arch/arm/common/dmabounce.c
 delete mode 100644 arch/arm/include/asm/dma-mapping.h
 create mode 100644 arch/arm/mach-footbridge/include/mach/dma-direct.h
