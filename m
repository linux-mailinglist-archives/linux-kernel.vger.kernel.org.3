Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A0857B72E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiGTNTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:19:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1916043E43;
        Wed, 20 Jul 2022 06:19:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso2156485pjk.5;
        Wed, 20 Jul 2022 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6L5s6bowO6qitLYG2OCtNOs5gt9AhxRdQFqZVW9zhIg=;
        b=W/mSQeRFEY4VCjg+VDolqQCfRBElGv/3AiMkl4gd7XS1baupuj9+mr/+jZSVf5lIlZ
         kTx9qAT4OzatQNM5RUKDA2WjJPBuI+Yi3QXkLM1rg8tIQQClULRUyuUpq0kK2TJvE2Hf
         KcJ0x+RVMCBxrIJOcZcmdhPqLCSjV/og0aA0uG54O06Qhhib8Jrrfy2ll0IK2dWsIEC8
         CqM+YjwHA2mV/JqIIJcPeZKB1+JUIFvOJBjGWBMnArXtMxUWLjbQ0A7o6k0vaSIAzArk
         UaRDZ/4niPjGY+IHLAY7TJfU3M/2ONkWUHy30HoKu238laXCY+PfoOYV1R9hgfpcXBaL
         K0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6L5s6bowO6qitLYG2OCtNOs5gt9AhxRdQFqZVW9zhIg=;
        b=jvcWA9g7N4q7xn1M197pH9s3wxG68YSRaxpXk8zOBDtuTTklvzF+7dN7HOVPL6cbni
         +ZoxKvJW6HYjSlKNBkscVbdgs7aYmmRyxkZ3sKKxvVyfIO3b2eV81URDSmSVfoZ7+Zvo
         3Q8dpfGV7bwf60WQTzbL7kVC7TkNmlD2zmprwVqBnMpmKX5Z0bSqXkfZEeNl2l+x8cYL
         XNnjZvlCHxM4r5D3zfTyZ/RuOKuNHnwLN1W43bz+tyXtAmxuxHl78MeBVbPzEcVRoKiZ
         wHRb2xkRhGx6C0ED7DjGUKmZXBl7rg6ySCj3xT3lnXez/WgYTxGc9XHoPQENOQx8K/Ef
         AtZw==
X-Gm-Message-State: AJIora+CCk2oq9J3OWtp22w52gmfV5i/r92Me6AXexjqmx7yS1d3SdAd
        wk3POCiWskyuvyJUAtULteyXsPKcqHOCOw==
X-Google-Smtp-Source: AGRyM1sdxwIBYX1/l+0yxcq9Emi2HTOcPl29jI2KpdaiR+BmYsFP35rTk7GJYu1Suo9CkuG9sD+9ow==
X-Received: by 2002:a17:902:cccf:b0:168:e13c:5cd9 with SMTP id z15-20020a170902cccf00b00168e13c5cd9mr39310489ple.53.1658323178275;
        Wed, 20 Jul 2022 06:19:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id g8-20020aa796a8000000b0051be16492basm13620223pfk.195.2022.07.20.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:19:37 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: [PATCH v4 0/3] Cleanups for asm-generic/pci.h
Date:   Wed, 20 Jul 2022 22:19:31 +0900
Message-Id: <20220720131934.373932-1-shorne@gmail.com>
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



Stafford Horne (3):
  PCI: Remove pci_get_legacy_ide_irq and asm-generic/pci.h
  PCI: Move isa_dma_bridge_buggy out of dma.h
  asm-generic: Add new pci.h and use it

 arch/alpha/include/asm/dma.h           |  9 ------
 arch/alpha/include/asm/pci.h           |  6 ----
 arch/arc/include/asm/dma.h             |  5 ---
 arch/arm/include/asm/dma.h             |  6 ----
 arch/arm/include/asm/pci.h             |  5 ---
 arch/arm64/include/asm/pci.h           | 18 ++---------
 arch/csky/include/asm/pci.h            | 24 +++-----------
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
 arch/riscv/include/asm/pci.h           | 25 ++-------------
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
 37 files changed, 64 insertions(+), 241 deletions(-)
 create mode 100644 include/linux/isa-dma.h

-- 
2.36.1

