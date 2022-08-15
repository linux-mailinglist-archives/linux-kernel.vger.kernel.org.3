Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A85C592882
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiHOEPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiHOEPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:15:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEA01401B
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660536905; x=1692072905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Rvd/xrgf0B0RTbzc+Lnz5LTd3QpoAfiklT1FBTqlT4=;
  b=NbM/OlfKOabkmUR3228TVR3y+/OFryVXBVfXs9M74xP8V6YfEGhCakf5
   77CehFhJel2VDcDoWXBycCI1akVdafE9wZNkEqKZ8mPhhFyCpaCnmGRyu
   1WEx85nc2xDbQBFReJoQld1rWua99awY96yoZW6quX5TSkA1A8j6ulSt9
   grvqwLidls0KqUWSzhhC+yEEWZTELbTxB5MpikyUbRhZ8cITTcQC9H9Sn
   /LP4aHjdHP9aZ0nAgzt6zMir7pFhDSDuB9tf0SNOwvL/qNW5m3tR1d4s/
   PBhlqZvxVtMWGLWxmHHHbW5Mhp2mZhzb+lkMR7kd+gLOmYac1i8R+yoVA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="290639847"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="290639847"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:15:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="606530103"
Received: from dmalka-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.42.26])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:15:01 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 413D1104A65; Mon, 15 Aug 2022 07:18:04 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 02/11] x86: CPUID and CR3/CR4 flags for Linear Address Masking
Date:   Mon, 15 Aug 2022 07:17:54 +0300
Message-Id: <20220815041803.17954-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enumerate Linear Address Masking and provide defines for CR3 and CR4
flags.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/asm/processor-flags.h      | 2 ++
 arch/x86/include/uapi/asm/processor-flags.h | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 235dc85c91c3..73c0cf5bd8a1 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index a7f3d9100adb..d8cccadc83a6 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -28,6 +28,8 @@
  * On systems with SME, one bit (in a variable position!) is stolen to indicate
  * that the top-level paging structure is encrypted.
  *
+ * On systemms with LAM, bits 61 and 62 are used to indicate LAM mode.
+ *
  * All of the remaining bits indicate the physical address of the top-level
  * paging structure.
  *
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index c47cc7f2feeb..d898432947ff 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -82,6 +82,10 @@
 #define X86_CR3_PCID_BITS	12
 #define X86_CR3_PCID_MASK	(_AC((1UL << X86_CR3_PCID_BITS) - 1, UL))
 
+#define X86_CR3_LAM_U57_BIT	61 /* Activate LAM for userspace, 62:57 bits masked */
+#define X86_CR3_LAM_U57		_BITULL(X86_CR3_LAM_U57_BIT)
+#define X86_CR3_LAM_U48_BIT	62 /* Activate LAM for userspace, 62:48 bits masked */
+#define X86_CR3_LAM_U48		_BITULL(X86_CR3_LAM_U48_BIT)
 #define X86_CR3_PCID_NOFLUSH_BIT 63 /* Preserve old PCID */
 #define X86_CR3_PCID_NOFLUSH    _BITULL(X86_CR3_PCID_NOFLUSH_BIT)
 
@@ -132,6 +136,8 @@
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
 #define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
 #define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
+#define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
+#define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
-- 
2.35.1

