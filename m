Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2CE4BBD4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbiBRQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:18:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbiBRQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:40 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C02AE32
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201040; x=1676737040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YLRcyqnwpgSRCqcWi/554Dc1Exapi/lSv6TTC7rFRfU=;
  b=dHEnAqdapHgtH0W1wZMGipY/ezP32/ZI+jZahZdP+mTHi6ZTN8FsE0Zi
   PjSj2GHy0tM4wmv+HLF0QK1BS1nKrJPDceQGtN1KNfRMdPuzcXuzls4Nf
   OwTX56g4VA6e6tPj6lW6R8pue5gqYt7PWkb2FsekVEZZyFcBrE3ucpAj5
   HPACfEtsIATjcchi7NIe04Yw5Gihcm/GkGLABgKJeKKqyEYkq6DIGo387
   HsYezYY1TGLIHIpp6crlSvYQbfS3E8sYD8jWAYNsc24WgmWtjbliXMEpd
   QxW3rO5k3wBuMNQt2rQNg+exqF0vab/2QWRagiJCy5ZiukDCL3kzYEWTs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238559698"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238559698"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="626675640"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2022 08:17:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B11ACA30; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 14/32] x86: Adjust types used in port I/O helpers
Date:   Fri, 18 Feb 2022 19:17:00 +0300
Message-Id: <20220218161718.67148-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.34.1

