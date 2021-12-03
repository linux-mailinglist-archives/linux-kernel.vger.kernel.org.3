Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55438467825
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380772AbhLCN1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:27:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:36292 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379956AbhLCN1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:27:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="217661390"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="217661390"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 05:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="603603271"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2021 05:23:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0A9EF17D; Fri,  3 Dec 2021 15:23:47 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, tony.luck@intel.com
Subject: [PATCHv2 2/3] x86/sev: Rename mem_encrypt.c to mem_encrypt_amd.c
Date:   Fri,  3 Dec 2021 16:23:39 +0300
Message-Id: <20211203132340.41741-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211203132340.41741-1-kirill.shutemov@linux.intel.com>
References: <20211203132340.41741-1-kirill.shutemov@linux.intel.com>
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

