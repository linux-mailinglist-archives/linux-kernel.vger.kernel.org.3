Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D0256CB7F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiGIVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGIVQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:16:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B653B4AA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 14:16:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 5so1509844plk.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQshL0ubFsAEbwRRKdyb/1irD0i2pVbsxkak9vbWWbY=;
        b=SnupiACxDcbgC4he6qEmIxmTiXTIyYFXzA2H78F6apwE+otf5xOSO286+uayTPVeK0
         Uw1Gt7z4oygriZ2NRt+ryvI5lG0SfhSYOn0KKQs03n1AW4/345VMVQMRbiHtM+8SHGaq
         W2/oKSlVYOqEutjgIgvFg/V0VePDp7Pejv35si78CYq/6vQt5fn5c/N4rdjEeLzTBp2A
         RwB6Cmxm+E7cKFsusukgN8MZyNX462Dp41J//qJZwoCR5axJqJX4lza4lQp49iZFLoN+
         9C19p06utAjlW/7EiGmAXXH3WaROPGRiGk3KCeTclm+ULdRj83MFDI7H1nkYSzDQC0/8
         8Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQshL0ubFsAEbwRRKdyb/1irD0i2pVbsxkak9vbWWbY=;
        b=CCs1EqzQMsh5eQ48vQutCT1eoe2aj8oxDFVq3GMe+LPJldb3MgA1Pbt0E8UlgBifr1
         EJKaIpsbVyTCRv3NQmX7cL6Ux/EC1OzS9QTwK9lD0rorPsHSKwQqqQEDkWMywzEO6YGm
         Y9psjdWsLivUZbGx6zVsoAL0P3adiMrzXbXDuA5y97wh6TR+sPmERAJu2q2cgQGJ2K/H
         OVPDK/2y/IYXoHg0BFeD5r8R05gIU11nkvDpxLYGfMBSkp90oNJP5NuzV5BeZoVdg2ZG
         U08IosAwvTv+DrOva+9Lm9YQCWEE3kgd4j1c/43mCF7aQAwdagoyS0oQT4S5KpdGoFFF
         HFgQ==
X-Gm-Message-State: AJIora9iUf2BzlXqJLFDvJtyw9VK+s7Kym3FP9YTmLwN6oPFM0spmAmk
        fmTvawV+L9SqHJGDENojhUPxcU6tVQ0=
X-Google-Smtp-Source: AGRyM1vutUmBGnmHcsHSxZEBr06j2+o2lupBHft00wHXPbFp+f4V20AekDvnXrpyAVn9+jM3naCdeQ==
X-Received: by 2002:a17:90b:3e86:b0:1ec:f7e8:e4e4 with SMTP id rj6-20020a17090b3e8600b001ecf7e8e4e4mr8159795pjb.218.1657401397764;
        Sat, 09 Jul 2022 14:16:37 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b0052512fdaa43sm1876822pfb.163.2022.07.09.14.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 14:16:37 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] openrisc: Add pci bus support
Date:   Sun, 10 Jul 2022 06:15:48 +0900
Message-Id: <20220709211549.1163327-2-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220709211549.1163327-1-shorne@gmail.com>
References: <20220709211549.1163327-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds required definitions to allow for PCI buses on OpenRISC.
This is being in the QEMU virt platform.

OpenRISC does not have IO ports so this defines PCI IO to be allowed in
any range.  Keeping PIO_RESERVED defined as 0 allows OpenRISC to use
MMIO for all IO.

Also, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
systems") all platforms that support PCI also need to support parallel
port.  We add a generic header to support parallel port drivers.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig            |  7 ++++---
 arch/openrisc/include/asm/Kbuild |  1 +
 arch/openrisc/include/asm/io.h   |  4 ++--
 arch/openrisc/include/asm/pci.h  | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 5 deletions(-)
 create mode 100644 arch/openrisc/include/asm/pci.h

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e814df4c483c..327241988819 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -21,7 +21,9 @@ config OPENRISC
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IOMAP
+	select GENERIC_PCI_IOMAP
 	select GENERIC_CPU_DEVICES
+	select HAVE_PCI
 	select HAVE_UID16
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS_BROADCAST
@@ -32,6 +34,8 @@ config OPENRISC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
+	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_MSI if PCI
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IRQ_MULTI_HANDLER
 	select MMU_GATHER_NO_RANGE if MMU
@@ -46,9 +50,6 @@ config MMU
 config GENERIC_HWEIGHT
 	def_bool y
 
-config NO_IOPORT_MAP
-	def_bool y
-
 # For now, use generic checksum functions
 #These can be reimplemented in assembly later if so inclined
 config GENERIC_CSUM
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 3386b9c1c073..c8c99b554ca4 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
+generic-y += parport.h
 generic-y += spinlock_types.h
 generic-y += spinlock.h
 generic-y += qrwlock_types.h
diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index c298061c70a7..1595aa69d96d 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -17,9 +17,9 @@
 #include <linux/types.h>
 
 /*
- * PCI: can we really do 0 here if we have no port IO?
+ * PCI: All address space can be used for IO
  */
-#define IO_SPACE_LIMIT		0
+#define IO_SPACE_LIMIT ~(0UL)
 
 /* OpenRISC has no port IO */
 #define HAVE_ARCH_PIO_SIZE	1
diff --git a/arch/openrisc/include/asm/pci.h b/arch/openrisc/include/asm/pci.h
new file mode 100644
index 000000000000..e0865d2f3f42
--- /dev/null
+++ b/arch/openrisc/include/asm/pci.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_OPENRISC_PCI_H
+#define __ASM_OPENRISC_PCI_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/io.h>
+
+#define PCIBIOS_MIN_IO		0
+#define PCIBIOS_MIN_MEM		0
+
+/* OpenRISC bootloaders do not initialize PCI bus */
+#define pcibios_assign_all_busses() 1
+
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE 1
+
+extern int isa_dma_bridge_buggy;
+
+#ifdef CONFIG_PCI
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	/* no legacy IRQs on or1k */
+	return -ENODEV;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	/* always show the domain in /proc */
+	return 1;
+}
+#endif /* CONFIG_PCI */
+
+#endif /* __ASM_OPENRISC_PCI_H */
-- 
2.36.1

