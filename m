Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1FB4DCE49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiCQS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiCQS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:59:56 -0400
X-Greylist: delayed 856 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 11:58:40 PDT
Received: from srv1.home.kabele.me (gw.home.kabele.me [195.88.143.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4651167F8C;
        Thu, 17 Mar 2022 11:58:39 -0700 (PDT)
Received: from srv1.home.kabele.me (localhost [IPv6:::1])
        by srv1.home.kabele.me (Postfix) with ESMTP id 0F0BF1692A5;
        Thu, 17 Mar 2022 19:58:43 +0100 (CET)
Received: from localhost ([2a01:c22:8dfa:1400:beea:2810:7764:7afc])
        by srv1.home.kabele.me with ESMTPSA
        id kQzaAOOEM2JWWDQAnmUwTQ
        (envelope-from <vit@kabele.me>); Thu, 17 Mar 2022 19:58:43 +0100
Date:   Thu, 17 Mar 2022 19:58:37 +0100
From:   Vit Kabele <vit@kabele.me>
To:     platform-driver-x86@vger.kernel.org
Cc:     r.marek@assembler.cz, devel@acpica.org, mingo@redhat.com,
        robert.moore@intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/3 RESEND] platform/x86: Check validity of EBDA pointer in
 mpparse.c
Message-ID: <YjOE3QLbvU1d0wAX@czspare1-lap.sysgo.cz>
Mail-Followup-To: platform-driver-x86@vger.kernel.org, r.marek@assembler.cz,
        devel@acpica.org, mingo@redhat.com, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <cover.1647526995.git.vit@kabele.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647526995.git.vit@kabele.me>
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
 arch/x86/include/asm/bios_ebda.h |  3 +++
 arch/x86/kernel/ebda.c           |  3 ---
 arch/x86/kernel/mpparse.c        | 12 +++++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

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
index fed721f90116..6bba0744d32d 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -633,7 +633,17 @@ void __init default_find_smp_config(void)
 	 */
 
 	address = get_bios_ebda();
-	if (address)
+
+	/* Check that the EBDA address is sane and the get_bios_ebda() did not
+	 * return just garbage from memory.
+	 * The upper bound is considered valid if it points below 1K before
+	 * end of the lower memory (i.e. 639K). The EBDA can be smaller
+	 * than 1K in which case the pointer will point above 639K but that
+	 * case is handled in step 2) above, and we don't need to adjust scan
+	 * size to not bump into the memory above 640K.
+	 */
+	if (address >= BIOS_START_MIN &&
+	    address < 639 * 0x400)
 		smp_scan_config(address, 0x400);
 }
 
-- 
2.30.2

