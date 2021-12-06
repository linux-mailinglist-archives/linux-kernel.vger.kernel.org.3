Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93691469793
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbhLFN6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:58:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:62317 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244916AbhLFN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:58:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237255046"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="237255046"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="579378095"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Dec 2021 05:55:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0C85A199; Mon,  6 Dec 2021 15:55:17 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, hpa@zytor.com,
        jroedel@suse.de, knsathya@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        thomas.lendacky@amd.com, tony.luck@intel.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 2/3] x86/sev: Rename mem_encrypt.c to mem_encrypt_amd.c
Date:   Mon,  6 Dec 2021 16:55:04 +0300
Message-Id: <20211206135505.75045-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211206135505.75045-1-kirill.shutemov@linux.intel.com>
References: <20211206135505.75045-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Both TDX and AMD SEV/SME implement memory encryption features. But
the bulk of the code in mem_encrypt.c is AMD specific. Rename the
file to mem_encrypt_amd.c. A subsequent patch will extract the
parts that can be shared by both TDX and AMD SEV/SME into a generic
file.

No functional changes.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/Makefile                             | 8 ++++----
 arch/x86/mm/{mem_encrypt.c => mem_encrypt_amd.c} | 0
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/x86/mm/{mem_encrypt.c => mem_encrypt_amd.c} (100%)

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5864219221ca..c9c480641153 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # Kernel does not boot with instrumentation of tlb.c and mem_encrypt*.c
 KCOV_INSTRUMENT_tlb.o			:= n
-KCOV_INSTRUMENT_mem_encrypt.o		:= n
+KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
 KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 
-KASAN_SANITIZE_mem_encrypt.o		:= n
+KASAN_SANITIZE_mem_encrypt_amd.o	:= n
 KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 
 # Disable KCSAN entirely, because otherwise we get warnings that some functions
@@ -12,7 +12,7 @@ KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 KCSAN_SANITIZE := n
 
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_mem_encrypt.o		= -pg
+CFLAGS_REMOVE_mem_encrypt_amd.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 endif
 
@@ -52,6 +52,6 @@ obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt_amd.c
similarity index 100%
rename from arch/x86/mm/mem_encrypt.c
rename to arch/x86/mm/mem_encrypt_amd.c
-- 
2.32.0

