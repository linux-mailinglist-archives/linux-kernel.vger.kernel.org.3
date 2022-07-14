Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400015743CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiGNEkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbiGNEjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:39:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F33FA3A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:27:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so7067602pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ANa/UfBZBIYOUOOK5aYse1VM4y5RCfZnupJabCiODk=;
        b=XyXet3y8zlu/z59ZUtVcN/LAQQMb4P3DKAdKdThaPQeHyy5vulQIu2gfwRzAn7RkEu
         2lZ8kRNJ+ZpPwkUmYL8qYzJum+5/VYHRnXL8FHQoSEi5zI3v3H7sUn/pcX6mk25sHmaf
         C9kletF+w3P5LhJmWiJrfc4/HYoetV91307ferO9mbnOmbgMUdDnfZQA5F/QxJlqduKJ
         ieEgyKCNexFqoQQ3Zbl6qWDJZq1wHxAme79mdKyNA8LycVz9E4LckfmDB05lnFgHwTYs
         pfpNj3Y7BTkqJy2wkceCOL9HOXr7ICJRQvhaBNrIzaS1E+5dauDwo290aefyausoMcno
         79xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ANa/UfBZBIYOUOOK5aYse1VM4y5RCfZnupJabCiODk=;
        b=Xc3YmI7Buygwje3MFOQa0b7YXtvTHyyi8Xxos15xiCeC47Rj0B9R3qsA62r76jJCAP
         kcrJjI0jq4jltzkZVHQ8aQ61fj+ItsNrDz9JXpy8ERPrn2NubNGec5ZjImwWmIf9/No4
         ktGM11lg6LXKadg3AwEzvsHiARbCtOhP9t3kLG7PRoVLb543ICDMYKuJTHmuhKFiA+Fr
         2AJTa64x9N8r+G2804RYd/HZHk1o65e8QYA/usGkQHprOR3GQbNlIx1QaXdOsWEhCUcQ
         3J2+qiitchBkdWfbmJ50N12cJGrcc8Yc+Q5F9ht9FrzTPVc+nk7iudio22FX7C5WkQiZ
         XtoQ==
X-Gm-Message-State: AJIora8BOgec5SUv2mH08h+dTQn18priL16Q6YWNaGWLutm1QbwF9Xg8
        TJVL9Yv/jJeEPdkrRKKlPselBrA/S50=
X-Google-Smtp-Source: AGRyM1u0MtU6yGx0/BvbIR9/NQQXwtZOS3pQyNLQZrmd5yAt3jnVf7rEUQEGRqrBlIN8HJOwU/KqVA==
X-Received: by 2002:a17:90b:30c4:b0:1ef:8d1b:f9bf with SMTP id hi4-20020a17090b30c400b001ef8d1bf9bfmr7637317pjb.158.1657772869879;
        Wed, 13 Jul 2022 21:27:49 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709027c0700b0016cae5f04e6sm284395pll.135.2022.07.13.21.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 21:27:49 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 1/2] openrisc: Add pci bus support
Date:   Thu, 14 Jul 2022 13:27:34 +0900
Message-Id: <20220714042736.2133067-2-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714042736.2133067-1-shorne@gmail.com>
References: <20220714042736.2133067-1-shorne@gmail.com>
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
Since v1:
 - Revert definition of IO_SPACE_LIMIT

 arch/openrisc/Kconfig            |  7 ++++---
 arch/openrisc/include/asm/Kbuild |  1 +
 arch/openrisc/include/asm/io.h   |  2 +-
 arch/openrisc/include/asm/pci.h  | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 4 deletions(-)
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
index c298061c70a7..625ac6ad1205 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 
 /*
- * PCI: can we really do 0 here if we have no port IO?
+ * PCI: We do not use IO ports in OpenRISC
  */
 #define IO_SPACE_LIMIT		0
 
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

