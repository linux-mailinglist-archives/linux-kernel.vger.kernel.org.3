Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C19475DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245054AbhLOQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245042AbhLOQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:56:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4382C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vMoMSP66J6zumO8g1XSMzCnJQ+BfHUkgoHykHWTGxAY=; b=Ceybxd6Zk17UJYhkHlXhUOAKp1
        BqmcdI0nSckyKJNVDstkkNsS2K1K4837amZbRnV8FlmhpJDG2Ep0tMqGE8oVW/xUCCNw3dEAWV7dH
        tP6OOnvNh+NRg09LkHve/Jr7VysYK3wWS14ONT/bLc8+Iy6ielma4a9VO1TGlByyh/+f/bNvLO+Mc
        kDqM6QuLjbxFsvUD1MOhGZvz/A5WZ9H23Cw45QEpPY7RQqdhDeYWUejGW3Qa0S2LyYTF6PVDZbqMr
        06vB6DVI/QVWEkybO+2d07zg8S91w48YuwQneZDRKibIY3Mnb7I0XrBiEmabqiaTEbwn5oP//9Nnz
        esBTa7qQ==;
Received: from [2001:4bb8:184:5c65:a9d9:2b74:3491:e72b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxXZf-00EpXY-0e; Wed, 15 Dec 2021 16:56:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     x86@kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/mtrr: remove the mtrr_bp_init stub
Date:   Wed, 15 Dec 2021 17:56:11 +0100
Message-Id: <20211215165612.554426-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215165612.554426-1-hch@lst.de>
References: <20211215165612.554426-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an IS_ENABLED check in setup_arch and call pat_disable directly
if MTRRs are not supported.  This allows to remove the <asm/memtype.h>
include in <asm/mtrr.h>, which pull in lowlevel x86 headers that should
not be included for UML builds and will cause build warnings with a
futher patch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/mtrr.h | 8 +-------
 arch/x86/kernel/setup.c     | 7 ++++++-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 829df26fd7a3e..76d726074c163 100644
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
index 6a190c7f4d71b..2f5129bd49dc4 100644
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
 
-- 
2.30.2

