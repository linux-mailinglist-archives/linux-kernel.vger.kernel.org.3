Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5164055513C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359003AbiFVQW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376532AbiFVQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:22:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E463F885
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655914965; x=1687450965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=95bhHx1Juu5Tt/MFhkDa/aMyBcRcrNVaIQO2CZMJjSk=;
  b=LHd68nqQy/84hLL459Wp1nVFEPJVYXoBKypC/1ci5grvRY0Sj+TZHCIP
   m4M1LNibjxpWJDU/7tmwILRuyWrD/zBpFYpfTkg/u0MCUt5S1ryC7jeV7
   /06MqazNfMlCd7pLUXYvyzx479bR+C1MXBKFppWo73ssgQC3p16WcYNR7
   Yv9dvQTkOwytKkDwVLD8R8vudKPYx5R02EV/lSvkqJ+4ftlwKCELW4+U1
   OfxSnLEhAMAsPGBn4FnwskLI6YTD0t+ZXpq0xDGJaRK30VDkx/CrvXVRJ
   QUjEjvNn9i4YmFcn/BHReMxw62I+uI8t+1xSzJMkmmbGTGXINXc9j+aVe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342152844"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="342152844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 09:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="690579459"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2022 09:22:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 301CC199; Wed, 22 Jun 2022 19:22:43 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 2/8] x86: CPUID and CR3/CR4 flags for Linear Address Masking
Date:   Wed, 22 Jun 2022 19:22:24 +0300
Message-Id: <20220622162230.83474-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/uapi/asm/processor-flags.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 03acc823838a..6ad5841e087f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -300,6 +300,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
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

