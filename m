Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67FA47D73D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbhLVS4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbhLVS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD224C061574;
        Wed, 22 Dec 2021 10:56:10 -0800 (PST)
Date:   Wed, 22 Dec 2021 18:56:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640199369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKdN7+w4EN3FW49jAPoN4rvi+So6S6nIMcIa4gRUpSc=;
        b=bkkcPVyD/auTvLURjsMCJR3vYIQyCqNVPCMkyAPl9rTXcflutIGZZdfkvAXC9Hu/ZaInS/
        DAoifko+4u0rgaL/A8AHLrF2G3iS7id9O5L7vEh/eatskvViTmdo172is/ZdEUljNSUgXs
        BL4EpjGcanF1nq/JbzdaL9OAbsherQYtR7u/COmKzLmwA5xvc9tB/Av72lhwseL3Zw+B4R
        EEHpERnIV9zQzZfWle3vLTolgr8yMLr/zvn3Y0JpoRRMbOcP1+BKmzNXv6SeY9SUNVIBpN
        QHo0Miv2NINHPbxNcdfrEwiEitXFTEHA2TFIxSkkoH78S4LSxFNULb3mR9Z8yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640199369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKdN7+w4EN3FW49jAPoN4rvi+So6S6nIMcIa4gRUpSc=;
        b=bedsZ87HwzorqCnKzJ49aF1xPgucKzG1AaWeDWoaJ79WoO550OBno8nf9RY0f5Sr5Esa47
        qQM7nA+pjXSRd8Bw==
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/mtrr: Remove the mtrr_bp_init() stub
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211215165612.554426-2-hch@lst.de>
References: <20211215165612.554426-2-hch@lst.de>
MIME-Version: 1.0
Message-ID: <164019936800.16921.666959600116418934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     4d5cff69fbddbbefef2903faa48263cc5d3ca382
Gitweb:        https://git.kernel.org/tip/4d5cff69fbddbbefef2903faa48263cc5d3ca382
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Wed, 15 Dec 2021 17:56:11 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Dec 2021 19:50:26 +01:00

x86/mtrr: Remove the mtrr_bp_init() stub

Add an IS_ENABLED() check in setup_arch() and call pat_disable()
directly if MTRRs are not supported. This allows to remove the
<asm/memtype.h> include in <asm/mtrr.h>, which pull in lowlevel x86
headers that should not be included for UML builds and will cause build
warnings with a following patch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211215165612.554426-2-hch@lst.de
---
 arch/x86/include/asm/mtrr.h | 8 +-------
 arch/x86/kernel/setup.c     | 7 ++++++-
 arch/x86/kvm/mmu/spte.c     | 1 +
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 829df26..76d7260 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -24,8 +24,8 @@
 #define _ASM_X86_MTRR_H
 
 #include <uapi/asm/mtrr.h>
-#include <asm/memtype.h>
 
+void mtrr_bp_init(void);
 
 /*
  * The following functions are for use by other drivers that cannot use
@@ -43,7 +43,6 @@ extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
 extern void mtrr_ap_init(void);
-extern void mtrr_bp_init(void);
 extern void set_mtrr_aps_delayed_init(void);
 extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
@@ -84,11 +83,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 {
 }
-static inline void mtrr_bp_init(void)
-{
-	pat_disable("PAT support disabled because CONFIG_MTRR is disabled in the kernel.");
-}
-
 #define mtrr_ap_init() do {} while (0)
 #define set_mtrr_aps_delayed_init() do {} while (0)
 #define mtrr_aps_init() do {} while (0)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6a190c7..2f5129b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -40,6 +40,7 @@
 #include <asm/kasan.h>
 #include <asm/kaslr.h>
 #include <asm/mce.h>
+#include <asm/memtype.h>
 #include <asm/mtrr.h>
 #include <asm/realmode.h>
 #include <asm/olpc_ofw.h>
@@ -979,7 +980,11 @@ void __init setup_arch(char **cmdline_p)
 	max_pfn = e820__end_of_ram_pfn();
 
 	/* update e820 for memory not covered by WB MTRRs */
-	mtrr_bp_init();
+	if (IS_ENABLED(CONFIG_MTRR))
+		mtrr_bp_init();
+	else
+		pat_disable("PAT support disabled because CONFIG_MTRR is disabled in the kernel.");
+
 	if (mtrr_trim_uncached_memory(max_pfn))
 		max_pfn = e820__end_of_ram_pfn();
 
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 0c76c45..fad546d 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -16,6 +16,7 @@
 #include "spte.h"
 
 #include <asm/e820/api.h>
+#include <asm/memtype.h>
 #include <asm/vmx.h>
 
 static bool __read_mostly enable_mmio_caching = true;
