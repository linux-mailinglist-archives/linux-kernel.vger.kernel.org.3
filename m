Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72574F53BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359828AbiDFDWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847174AbiDFCQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:16:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926361B48D1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201734; x=1680737734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GHYrYBXq4mhEggBJYnudRifuMOiXqJTa+EAqZsyg7d0=;
  b=GnDB4XGuSDpmJozGXXPsbnihod8lgl4iueVHRYq5C+45qTxTYo6vHCS7
   KqtZxZDPy3/1P8RW0bXo+kTflJDzL7lEALPegtKH5jbquyvPvIZKxV4hR
   h6ULIvtThu5jRsBENynFfoQoi73kACQ9KvBPozsU/IkyvMHKShJ4op7LP
   vVyGAuT+hy/eeWuk0erpNdPrttSyV7Ve41Aj8/JlZju8hXyq0KZyS4kFz
   8s7UQ1duQkG6SLvVu/8StuKEWVDqZOlKo4uwA7R6n/sZ0O7pkb81szQgS
   2hIbeixmFS19XE3TjTx49TQq7neJI1MKlvyfUy42rm/TueK2b8J9WQiaj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="259721501"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="259721501"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="556719067"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Apr 2022 16:34:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 296EC8FD; Wed,  6 Apr 2022 02:29:46 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv8 13/30] x86: Adjust types used in port I/O helpers
Date:   Wed,  6 Apr 2022 02:29:22 +0300
Message-Id: <20220405232939.73860-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change port I/O helpers to use u8/u16/u32 instead of unsigned
char/short/int for values. Use u16 instead of int for port number.

It aligns the helpers with implementation in boot stub in preparation
for consolidation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/io.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index f6d91ecb8026..638c1a2a82e0 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -258,37 +258,37 @@ static inline void slow_down_io(void)
 #endif
 
 #define BUILDIO(bwl, bw, type)						\
-static inline void out##bwl(unsigned type value, int port)		\
+static inline void out##bwl(type value, u16 port)			\
 {									\
 	asm volatile("out" #bwl " %" #bw "0, %w1"			\
 		     : : "a"(value), "Nd"(port));			\
 }									\
 									\
-static inline unsigned type in##bwl(int port)				\
+static inline type in##bwl(u16 port)					\
 {									\
-	unsigned type value;						\
+	type value;							\
 	asm volatile("in" #bwl " %w1, %" #bw "0"			\
 		     : "=a"(value) : "Nd"(port));			\
 	return value;							\
 }									\
 									\
-static inline void out##bwl##_p(unsigned type value, int port)		\
+static inline void out##bwl##_p(type value, u16 port)			\
 {									\
 	out##bwl(value, port);						\
 	slow_down_io();							\
 }									\
 									\
-static inline unsigned type in##bwl##_p(int port)			\
+static inline type in##bwl##_p(u16 port)				\
 {									\
-	unsigned type value = in##bwl(port);				\
+	type value = in##bwl(port);					\
 	slow_down_io();							\
 	return value;							\
 }									\
 									\
-static inline void outs##bwl(int port, const void *addr, unsigned long count) \
+static inline void outs##bwl(u16 port, const void *addr, unsigned long count) \
 {									\
 	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
-		unsigned type *value = (unsigned type *)addr;		\
+		type *value = (type *)addr;				\
 		while (count) {						\
 			out##bwl(*value, port);				\
 			value++;					\
@@ -301,10 +301,10 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 	}								\
 }									\
 									\
-static inline void ins##bwl(int port, void *addr, unsigned long count)	\
+static inline void ins##bwl(u16 port, void *addr, unsigned long count)	\
 {									\
 	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
-		unsigned type *value = (unsigned type *)addr;		\
+		type *value = (type *)addr;				\
 		while (count) {						\
 			*value = in##bwl(port);				\
 			value++;					\
@@ -317,9 +317,9 @@ static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 	}								\
 }
 
-BUILDIO(b, b, char)
-BUILDIO(w, w, short)
-BUILDIO(l, , int)
+BUILDIO(b, b, u8)
+BUILDIO(w, w, u16)
+BUILDIO(l,  , u32)
 
 #define inb inb
 #define inw inw
-- 
2.35.1

