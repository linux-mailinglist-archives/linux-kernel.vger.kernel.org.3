Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12854DA7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbiCPCMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352578AbiCPCLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:11:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344F5E767
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647396608; x=1678932608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dzu8akcs7blNRRO8/pUW5R9IMAEFEgrRrysou/I9Yv4=;
  b=cFR8MmWqJOzubBglQmRFQsFA8+FBNmad5I3NjaG0ykkijoe5bgIU/xZT
   Jks75yntw+kif2wYZxRdvyW8kyW/92aEkReLHsGVuwROBW8Ici1i3eMT+
   pwlmglZ39irdDn/m+99xxg5ZdCiLj1RoyVeEqSxLXsjXMqr6dFy51RxlJ
   tyxeV52g/aqpeJYZh5BqppwMcUQpnjzYTcq/BpfnYvAO6i1ss4oIukst3
   yzjb1TXOLYPYi9l6KFMs0DyB9TzpaZWsxgQZi+M7Uiiwhwfs545CcR+N8
   /QcemSEGhm/QBqOWACGRHq4O7tWtFEiEm/1yFIGjwutg8jIPwD6lsT7kQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256422508"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256422508"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="690414206"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2022 19:09:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2D19D8BC; Wed, 16 Mar 2022 04:10:10 +0200 (EET)
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
Subject: [PATCHv6 13/30] x86: Adjust types used in port I/O helpers
Date:   Wed, 16 Mar 2022 05:08:39 +0300
Message-Id: <20220316020856.24435-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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

