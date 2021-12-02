Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957E54669AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348306AbhLBSSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhLBSSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:18:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA48C06174A;
        Thu,  2 Dec 2021 10:15:10 -0800 (PST)
Date:   Thu, 02 Dec 2021 18:15:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638468908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BrF3Lpl38xw4GjI5AYCD/2kHblDIHWUggd56B1HbR9s=;
        b=QncW17azzEh9KJD/h8ABsFEJmlUESrmWiWaD7GHLSM4+UuStWlYAMv/CfAVHWX9Jnudgel
        2FTfCSozbg9TKoKpRQchS6upAlVu4le5HFPnq68AWlQqXnBsQXuHN0Sc6hIlfCpg1iv2Qk
        r1kaNS5I+YH4MJDx1iVIHuyFYYe8ggbVwuLYOcVhqZerrx36lIOXeHu6HmoW9P7hS4AZj/
        QScxBKa+KacSCoN7OnZsPKThCl5VfwAP51rp8Mvnk3xPVvplXJ/1Eo0T5IPzWAoUspURVs
        EiGsNz7DhTDx6ImIhvelp3ZcgiumctS0hqlpuHA1HsVgoi3KPelpHLT7kYsx4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638468908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BrF3Lpl38xw4GjI5AYCD/2kHblDIHWUggd56B1HbR9s=;
        b=Q/x7qj7bv2P2KvTx1mqMn7UGHWIam9uGt9SLYreQv4MgktpKDeF135rvJyelqiGpGNCY4a
        41GST6JRNsJuXUDw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Fix PAGE_KERNEL_IO removal breakage
Cc:     Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211202144646.23186-1-joro@8bytes.org>
References: <20211202144646.23186-1-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <163846890716.11128.7464150139974319110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     9a951429b2e1670a76b68c90880b01430fe509e4
Gitweb:        https://git.kernel.org/tip/9a951429b2e1670a76b68c90880b01430fe509e4
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Thu, 02 Dec 2021 15:46:46 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 02 Dec 2021 09:41:24 -08:00

x86/mm: Fix PAGE_KERNEL_IO removal breakage

The removal of PAGE_KERNEL_IO broke SEV-ES because it changed the
mapping of ioremap and some fixmap areas (like the local APIC page)
from unencrypted to encrypted. Change those mappings back to
be unencrypted.

Fixes: 27dff0f58bde ("x86/mm: Nuke PAGE_KERNEL_IO")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20211202144646.23186-1-joro@8bytes.org
---
 arch/x86/include/asm/fixmap.h        |  2 +-
 arch/x86/include/asm/pgtable_types.h | 21 +++++++++++----------
 arch/x86/mm/ioremap.c                |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 5e186a6..a2eaf26 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -173,7 +173,7 @@ static inline void __set_fixmap(enum fixed_addresses idx,
  * supported for MMIO addresses, so make sure that the memory encryption
  * mask is not part of the page attributes.
  */
-#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
+#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE_NOENC
 
 /*
  * Early memremap routines used for in-place encryption. The mappings created
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index a872247..fc9b699 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -208,16 +208,17 @@ enum page_cache_mode {
 
 #define __pgprot_mask(x)	__pgprot((x) & __default_kernel_pte_mask)
 
-#define PAGE_KERNEL		__pgprot_mask(__PAGE_KERNEL            | _ENC)
-#define PAGE_KERNEL_NOENC	__pgprot_mask(__PAGE_KERNEL            |    0)
-#define PAGE_KERNEL_RO		__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
-#define PAGE_KERNEL_EXEC	__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
-#define PAGE_KERNEL_EXEC_NOENC	__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
-#define PAGE_KERNEL_ROX		__pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
-#define PAGE_KERNEL_NOCACHE	__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
-#define PAGE_KERNEL_LARGE	__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
-#define PAGE_KERNEL_LARGE_EXEC	__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
-#define PAGE_KERNEL_VVAR	__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
+#define PAGE_KERNEL			__pgprot_mask(__PAGE_KERNEL            | _ENC)
+#define PAGE_KERNEL_NOENC		__pgprot_mask(__PAGE_KERNEL            |    0)
+#define PAGE_KERNEL_RO			__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
+#define PAGE_KERNEL_EXEC		__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
+#define PAGE_KERNEL_EXEC_NOENC		__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
+#define PAGE_KERNEL_ROX			__pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
+#define PAGE_KERNEL_NOCACHE		__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
+#define PAGE_KERNEL_NOCACHE_NOENC	__pgprot_mask(__PAGE_KERNEL_NOCACHE    |    0)
+#define PAGE_KERNEL_LARGE		__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
+#define PAGE_KERNEL_LARGE_EXEC		__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
+#define PAGE_KERNEL_VVAR		__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
 
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 3102dda..4fe8d43 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -243,7 +243,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	 * make sure the memory encryption attribute is enabled in the
 	 * resulting mapping.
 	 */
-	prot = PAGE_KERNEL;
+	prot = PAGE_KERNEL_NOENC;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
 
