Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C054F912C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiDHIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiDHIvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:51:10 -0400
Received: from srv1.home.kabele.me (gw.home.kabele.me [195.88.143.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABC32357713;
        Fri,  8 Apr 2022 01:49:06 -0700 (PDT)
Received: from srv1.home.kabele.me (localhost [IPv6:::1])
        by srv1.home.kabele.me (Postfix) with ESMTP id 05783188967;
        Fri,  8 Apr 2022 10:49:02 +0200 (CEST)
Received: from localhost ([77.8.79.100])
        by srv1.home.kabele.me with ESMTPSA
        id jqVFOf72T2LBmRcAnmUwTQ
        (envelope-from <vit@kabele.me>); Fri, 08 Apr 2022 10:49:02 +0200
Date:   Fri, 8 Apr 2022 10:46:46 +0200
From:   Vit Kabele <vit@kabele.me>
To:     platform-driver-x86@vger.kernel.org
Cc:     r.marek@assembler.cz, x86@kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, mingo@redhat.com
Subject: [PATCH v2] arch/x86: Check validity of EBDA pointer in mpparse.c
Message-ID: <Yk/2dh4kDobivStp@czspare1-lap.sysgo.cz>
References: <CAJZ5v0gBbdzUO9MRxbKESEnaeaNAu-+3oP6ADMretch=iHPNJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gBbdzUO9MRxbKESEnaeaNAu-+3oP6ADMretch=iHPNJA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer to EBDA area is retrieved from a word at 0x40e in BDA.
In case that the memory there is not initialized and contains garbage,
it might happen that the kernel touches memory above 640K.

This may cause unwanted reads from VGA memory which may not be decoded,
or even present when running under virtualization.

This patch adds sanity check for the EBDA pointer retrieved from the memory
so that scanning EBDA does not leave the low memory.

Signed-off-by: Vit Kabele <vit@kabele.me>
Reviewed-by: Rudolf Marek <r.marek@assembler.cz>
---
changes in v2:
 * Fix the comment formating
 * Change the condition. I used already defined symbol for easier
    interpretation

 arch/x86/include/asm/bios_ebda.h |  3 +++
 arch/x86/kernel/ebda.c           |  3 ---
 arch/x86/kernel/mpparse.c        | 14 ++++++++++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/bios_ebda.h b/arch/x86/include/asm/bios_ebda.h
index 4d5a17e2febe..c3133c01d5b7 100644
--- a/arch/x86/include/asm/bios_ebda.h
+++ b/arch/x86/include/asm/bios_ebda.h
@@ -4,6 +4,9 @@
 
 #include <asm/io.h>
 
+#define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
+#define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
+
 /*
  * Returns physical address of EBDA.  Returns 0 if there is no EBDA.
  */
diff --git a/arch/x86/kernel/ebda.c b/arch/x86/kernel/ebda.c
index 38e7d597b660..86c0801fc3ce 100644
--- a/arch/x86/kernel/ebda.c
+++ b/arch/x86/kernel/ebda.c
@@ -50,9 +50,6 @@
 
 #define BIOS_RAM_SIZE_KB_PTR	0x413
 
-#define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
-#define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
-
 void __init reserve_bios_regions(void)
 {
 	unsigned int bios_start, ebda_start;
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fed721f90116..9e0b4820f33b 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -633,8 +633,18 @@ void __init default_find_smp_config(void)
 	 */
 
 	address = get_bios_ebda();
-	if (address)
-		smp_scan_config(address, 0x400);
+
+	/*
+	 * Check that the EBDA address is sane and the get_bios_ebda() did not
+	 * return just garbage from memory.
+	 * The upper bound is considered valid if it points below 1K before
+	 * end of the lower memory (i.e. 639K). The EBDA can be smaller
+	 * than 1K in which case the pointer will point above 639K but that
+	 * case is handled in step 2) above, and we don't need to adjust scan
+	 * size to not bump into the memory above 640K.
+	 */
+	if (address >= BIOS_START_MIN && address < (BIOS_START_MAX - 1024))
+		smp_scan_config(address, 1024);
 }
 
 #ifdef CONFIG_X86_IO_APIC
-- 
2.30.2

