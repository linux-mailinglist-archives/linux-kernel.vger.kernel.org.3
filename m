Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3C057E915
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiGVVt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:49:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1887789AA1;
        Fri, 22 Jul 2022 14:49:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso5281005pjq.1;
        Fri, 22 Jul 2022 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKBAlUu6F1f72gxbqJqNkzmdfmg0eW3VcwrodrFMJSE=;
        b=mLATIobE3QXc7FfUUCgVQLEfCmFrpMZ6GG9uG8a648HLGlUq/fRMW7D9IeWzvGVJak
         yVwqGlUgGhwGkQuGIeZq62C5/vwA6JL3AX9oU0vn++3z4gJHP48Ig+3zIrTo2t5h0Ly0
         PWzcgka4r+5QdEtQ1QUV0n/3UhrkHnHGUyhrj36GuUCI8qmalde+zda1FGWQeru79Nhn
         eB3xFp/s2VffE2PnnHKo5JipBNAXgK+VtSnIUN91e5Tp5M6jQlbx++RmeZRTtvTTNpoU
         fX8p9z8Rg5PN9epjGWBTUl9dntEPAFkIAQuR+Z4wag60+ixl6nNPg+hn179P7CZqSEuW
         fpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKBAlUu6F1f72gxbqJqNkzmdfmg0eW3VcwrodrFMJSE=;
        b=xrKljn13VvvQyyjZjqBuIEkZyWcSZ2Nhcgkt70mPHr/rex5mnc0SbmJIbVE7jLCwuw
         h0TkBwbTVYC0lHOGFwHylrTJTq9ZxTZ8y3n9lPWWL0IS2itIPNdwdDo2JmxD08VfMQza
         n/f1brw4i10QNif6FBH0bE1LrSLJe4Sb/UdO5nADH0Yw5EeOCdOcU2CLbpCJZwSOxpto
         zqCNTVvML0o63xYwLrM7QmU1yw55830s7gGIfSn9LIQU2b+M65mgGAQJ3UkxkbzgpIwv
         yv5GPykbZlY/6ECNNr+nJsMEhAIwvEuLSWK6xxmeX8l7lK85SCkOVPjn5nJIPsWOirkX
         CiYA==
X-Gm-Message-State: AJIora8js7pgVY90rEj+eJU9GgjtfsJ+oeqmttjGi2/MrFxvo2SACgXw
        /KOjT0I5Iyk5MwPWVkWZVn7zU+JJuNlq5Q==
X-Google-Smtp-Source: AGRyM1s8ULJDRpoScEKM1GXhJVRCOVz9MUfNeZH/hFTgO9hmdkx0aULIZ3TJARZkHfVxC90HfRxKKw==
X-Received: by 2002:a17:902:b701:b0:16d:12a7:c2fa with SMTP id d1-20020a170902b70100b0016d12a7c2famr1807096pls.67.1658526593300;
        Fri, 22 Jul 2022 14:49:53 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id r143-20020a632b95000000b0040c9df2b060sm3821257pgr.30.2022.07.22.14.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 14:49:52 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: [PATCH v6 0/4] Cleanups for asm-generic/pci.h
Date:   Sat, 23 Jul 2022 06:49:40 +0900
Message-Id: <20220722214944.831438-1-shorne@gmail.com>
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

Since v5:
 - Remove include of linux/types.h in asm-generic/pci
 - Add Acked-by from Guo Ren on csky patch
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
 arch/arc/include/asm/dma.h             |  5 ----
 arch/arm/include/asm/dma.h             |  6 ----
 arch/arm/include/asm/pci.h             |  5 ----
 arch/arm64/include/asm/pci.h           | 18 ++----------
 arch/csky/include/asm/pci.h            | 23 ++-------------
 arch/ia64/include/asm/dma.h            |  2 --
 arch/ia64/include/asm/pci.h            |  6 ----
 arch/m68k/include/asm/dma.h            |  6 ----
 arch/m68k/include/asm/pci.h            |  2 --
 arch/microblaze/include/asm/dma.h      |  6 ----
 arch/mips/include/asm/dma.h            |  8 ------
 arch/mips/include/asm/pci.h            |  6 ----
 arch/parisc/include/asm/dma.h          |  6 ----
 arch/parisc/include/asm/pci.h          |  5 ----
 arch/powerpc/include/asm/dma.h         |  6 ----
 arch/powerpc/include/asm/pci.h         |  1 -
 arch/riscv/include/asm/pci.h           | 31 +++-----------------
 arch/s390/include/asm/dma.h            |  6 ----
 arch/s390/include/asm/pci.h            |  1 -
 arch/sh/include/asm/dma.h              |  6 ----
 arch/sh/include/asm/pci.h              |  6 ----
 arch/sparc/include/asm/dma.h           |  8 ------
 arch/sparc/include/asm/pci.h           |  9 ------
 arch/um/include/asm/pci.h              | 24 ++--------------
 arch/x86/include/asm/dma.h             |  8 ------
 arch/x86/include/asm/pci.h             |  3 --
 arch/xtensa/include/asm/dma.h          |  7 -----
 arch/xtensa/include/asm/pci.h          |  3 --
 drivers/comedi/drivers/comedi_isadma.c |  2 +-
 drivers/pci/pci.c                      |  2 ++
 drivers/pci/quirks.c                   |  4 ++-
 drivers/pnp/resource.c                 |  5 ++--
 include/asm-generic/pci.h              | 39 +++++++++++++++++---------
 include/linux/isa-dma.h                | 14 +++++++++
 sound/core/isadma.c                    |  2 +-
 37 files changed, 60 insertions(+), 246 deletions(-)
 create mode 100644 include/linux/isa-dma.h

-- 
2.36.1

