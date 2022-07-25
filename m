Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3957F829
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiGYCIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiGYCIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:08:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A48FEE3C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:08:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bk6-20020a17090b080600b001f2138a2a7bso10240352pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bb8XU1Bnk4jusD63lmk3Ol2o00AOfRxKRkmAkiDP4o=;
        b=fZIYHmc8N+T0x4kQRJbfoR40FVeWXHFoj1Ez9pMFcXxzgRhu2PqfTJX13WZ/W+RErc
         OPcB5PlL1q7UBLiBsWYp3lmlcvt9LTpbaSGcKj1OlF3D9EJ2VUaL0wG5GK4fm3QG6s3F
         CqsJ4rBlixoSyIwWe1Al7OeyD+ZwvQEXYZw1+eILqV8AEuRLuJ+TYwAvQon6qTm4+0Wu
         gWL3JwtDy4xRDqckeXp1Os7f93urL1kvSDpHRRwv7nzF1i1sITAxOcmqV6odWEh4z8OZ
         XhuLNTpmXovVM+mTrmFrG3WgCoM+U4Llhuo/N2j7RE1xvfb7kkfWmTc0wYInGzP5GKZs
         AqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bb8XU1Bnk4jusD63lmk3Ol2o00AOfRxKRkmAkiDP4o=;
        b=WGg6rllkwofRNuBo6jMTfzkOT2TCZNFtOlxUd4pJ5n+NgxL1osopHIOxHDJAW3mnkX
         CZr/RtFegGtXkZKXE/F9r7Cfb2cqK11wNqkaNT00kyeogoeFPvXuOClKOBeAjs5azBxL
         qxpJxJBkii0mqI6blvp3rFDdaBfqe0fWIW0j68a50EbGIC6ja3LYQ+IiiKtbYGsVQppb
         8jniYdpyYut34gNWW24oshoTOluT/1UGSUimcZNXsn6G5rNh134PsO7Bi5D37ibmwjPo
         di8izbCU6rfcuEtLhV3Ew8F/kIncrLo+1fSDHPrPf+5N15Io/g6inG0wy4aqeA72ep6Z
         yMbg==
X-Gm-Message-State: AJIora9pGWo2mD5FQzWmpmVbBwjEqdxfF7zeJmq7+VgQLGIZqYFdN5fa
        SXabK6CpV3798p+i3YeWHFRkmq4xvZk0jQ==
X-Google-Smtp-Source: AGRyM1vZnZRBfbk7P18DqP3O8ruzD393p79BGSWNpGSjB7sr0RoO7KDfhkFVa9m61iUpftGqgqdWYg==
X-Received: by 2002:a17:902:8a86:b0:16c:4292:9f56 with SMTP id p6-20020a1709028a8600b0016c42929f56mr10268982plo.36.1658714893200;
        Sun, 24 Jul 2022 19:08:13 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902d51100b0016c50179b1esm1691376plg.152.2022.07.24.19.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 19:08:12 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 2/3] openrisc: Add pci bus support
Date:   Mon, 25 Jul 2022 11:07:36 +0900
Message-Id: <20220725020737.1221739-3-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725020737.1221739-1-shorne@gmail.com>
References: <20220725020737.1221739-1-shorne@gmail.com>
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

This patch adds required definitions to allow for PCI buses on OpenRISC.
This is being tested on the OpenRISC QEMU virt platform which is in
development.

OpenRISC does not have IO ports so we keep the definition of
IO_SPACE_LIMIT and PIO_RESERVED to be 0.

Note, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
systems") all platforms that support PCI also need to support parallel
port.  We add a generic header to support compiling parallel port
drivers, though they generally will not work as they require IO ports.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig            | 5 ++++-
 arch/openrisc/include/asm/Kbuild | 1 +
 arch/openrisc/include/asm/io.h   | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e814df4c483c..c7f282f60f64 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -20,8 +20,9 @@ config OPENRISC
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
-	select GENERIC_IOMAP
+	select GENERIC_PCI_IOMAP
 	select GENERIC_CPU_DEVICES
+	select HAVE_PCI
 	select HAVE_UID16
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS_BROADCAST
@@ -32,6 +33,8 @@ config OPENRISC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
+	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_MSI if PCI
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IRQ_MULTI_HANDLER
 	select MMU_GATHER_NO_RANGE if MMU
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
 
-- 
2.36.1

