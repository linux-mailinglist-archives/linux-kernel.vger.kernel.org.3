Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B6557CC88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiGUNtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUNtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:49:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8663CC0;
        Thu, 21 Jul 2022 06:49:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f11so1727738pgj.7;
        Thu, 21 Jul 2022 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gjE/mCYbbSP65o7jJNSxwg8UOz1UiDFn/ArXcu23xc=;
        b=N995SlDL+XA8tQSau6Drcjdn8T1+Hz/P48zIGTY9W17QgUh9S0MBlEDJbOuwgJFT7R
         fnchqm5FwLD3uVrTcBs9/Y1UlAdlbBnH+mmAqpI3afvRqQaGugksGJ0vnliGDevmxn+b
         tAj0vD1ZtP7NvPqArLpRkP03Ixi3j73dVRbnzhOSEdMctzRhEICpiAgnC9Tpj4LKaan4
         WP/mQRDHcS01Rsap9/3efaXcxYkZ5WlqvomoR+xjy5+EgYsxl78+VnSI6puSyM3N5Qas
         gdlo1mIEO+NArhkM1cNELUJ1QEn/BDipwoGjUbts/9PdKBcGQWaHgnGCZ8o54aubVMaq
         O7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gjE/mCYbbSP65o7jJNSxwg8UOz1UiDFn/ArXcu23xc=;
        b=TbwZmeRDwMbOOYushLG2naDezEyWz3Fxh55XIuTCXYYR3H9+dN2CDfLx9kA0NiAtud
         2bMfyTB0rxI03aElpiL4Up0JdgaamlXyDWHPdUUC70XrAjYj9g55ud7diK1CaWpv+PtT
         46f/Y8eg2Q3is1Fodd9rtOC+cznoIVYY0GhUhJ/LusSar/QA+enlVc5vKHNRJsL6MyOh
         ZxHNMJlsfTvi+SHGhlM3UmcK6Ill2M10SDOdDKRMqncitIwR3kOdhYSOqV4yrD5212l6
         f7chSMJKIvx8jdDpGwIpbpiDKsWjq5gPKsElNL/+Nlge9pwQa+XELSiSDLruPUjdjPD0
         YEHw==
X-Gm-Message-State: AJIora86+QRNlAZfrj6YQYq4BsneaFz9CQOsmflbuGxUlkW2kPqH9MN1
        hOb65tMxz8O6P7lxtiSkPZ35YnLqqcwK1A==
X-Google-Smtp-Source: AGRyM1ud/soERWZGCRSjwEjswDaxrjWDFBAuZBJKqFBmkOI2IW4jWgtr9Svq3y5sBoZWAFNSU2cGDA==
X-Received: by 2002:a63:4a62:0:b0:412:8c83:a36c with SMTP id j34-20020a634a62000000b004128c83a36cmr37950436pgl.404.1658411371669;
        Thu, 21 Jul 2022 06:49:31 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id n7-20020a056a00212700b0052ab0a73752sm1789615pfj.198.2022.07.21.06.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:49:31 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: [PATCH v5 0/4] Cleanups for asm-generic/pci.h
Date:   Thu, 21 Jul 2022 22:49:20 +0900
Message-Id: <20220721134924.596152-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the OpenRISC PCI support patch Arnd suggested that
we avoid copying arm64 and riscv asm/pci.h and moving that to be
the new asm-generic/pci.h.

This patch does that by first removing the old pci.h with the definition of
pci_get_legacy_ide_irq completely. We replace it with references to
ATA_PRIMARY_IRQ and ATA_SECONDARY_IRQ macros.

Next, we do further cleanups moving isa_dma_bridge_buggy to be only
x86_32 specific.  This avoids having to have it in dma.h or pci.h headers.

Next, we create the new pci.h definition.

Note, for the series, I am working on these fixups as part of adding PCI to
OpenRISC.  If the series is accepted I would like to merge via the OpenRISC tree
with the OpenRISC PCI support patches to avoid having to coordinate upstream
merges.

Since v4:
 - Move some pci_get_legacy_ide_irq and isa_dma_bridge_buggy cleanups
   into the correct patches.
 - Add csky ARCH_GENERIC_PCI_MMAP_RESOURCE definition patch, suggested by Arnd
Since v3:
 - We now completely remove pci_get_legacy_ide_irq and use libata.h macros.
 - Added a new patch to remove isa_dma_bridge_buggy in architectures
   other than x86_32.
Since v2:
 - Remove pci_get_legacy_ide_irq from m68k.
Since v1:
 - Remove definition of pci_get_legacy_ide_irq on architectures
   not using CONFIG_PNP, which eliminated most.
 - Add ifdef around PCIBIOS_MIN_MEM for consistency.

Stafford Horne (4):
  PCI: Remove pci_get_legacy_ide_irq and asm-generic/pci.h
  PCI: Move isa_dma_bridge_buggy out of dma.h
  csky: PCI: Define ARCH_GENERIC_PCI_MMAP_RESOURCE
  asm-generic: Add new pci.h and use it

 arch/alpha/include/asm/dma.h           |  9 ------
 arch/alpha/include/asm/pci.h           |  6 ----
 arch/arc/include/asm/dma.h             |  5 ---
 arch/arm/include/asm/dma.h             |  6 ----
 arch/arm/include/asm/pci.h             |  5 ---
 arch/arm64/include/asm/pci.h           | 18 ++---------
 arch/csky/include/asm/pci.h            | 23 ++------------
 arch/ia64/include/asm/dma.h            |  2 --
 arch/ia64/include/asm/pci.h            |  6 ----
 arch/m68k/include/asm/dma.h            |  6 ----
 arch/m68k/include/asm/pci.h            |  2 --
 arch/microblaze/include/asm/dma.h      |  6 ----
 arch/mips/include/asm/dma.h            |  8 -----
 arch/mips/include/asm/pci.h            |  6 ----
 arch/parisc/include/asm/dma.h          |  6 ----
 arch/parisc/include/asm/pci.h          |  5 ---
 arch/powerpc/include/asm/dma.h         |  6 ----
 arch/powerpc/include/asm/pci.h         |  1 -
 arch/riscv/include/asm/pci.h           | 31 +++----------------
 arch/s390/include/asm/dma.h            |  6 ----
 arch/s390/include/asm/pci.h            |  1 -
 arch/sh/include/asm/dma.h              |  6 ----
 arch/sh/include/asm/pci.h              |  6 ----
 arch/sparc/include/asm/dma.h           |  8 -----
 arch/sparc/include/asm/pci.h           |  9 ------
 arch/um/include/asm/pci.h              | 24 ++------------
 arch/x86/include/asm/dma.h             |  8 -----
 arch/x86/include/asm/pci.h             |  3 --
 arch/xtensa/include/asm/dma.h          |  7 -----
 arch/xtensa/include/asm/pci.h          |  3 --
 drivers/comedi/drivers/comedi_isadma.c |  2 +-
 drivers/pci/pci.c                      |  2 ++
 drivers/pci/quirks.c                   |  4 ++-
 drivers/pnp/resource.c                 |  5 +--
 include/asm-generic/pci.h              | 43 +++++++++++++++++---------
 include/linux/isa-dma.h                | 14 +++++++++
 sound/core/isadma.c                    |  2 +-
 37 files changed, 63 insertions(+), 247 deletions(-)
 create mode 100644 include/linux/isa-dma.h

-- 
2.36.1

