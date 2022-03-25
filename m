Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9D4E6C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357757AbiCYCcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357725AbiCYCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:32:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BDFB715F;
        Thu, 24 Mar 2022 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648175437; x=1679711437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PTNFCFzP7Qzi5GxtYWpCTaMvmu7DnLjllzpv1VI5L78=;
  b=dvUYMaKiNgtn6W/ia29VVjofGpV+T2IgPBrBvx1t1J9Cu0bjK2bUuv8M
   CLAhH5BcVkJVHNIZOQY8Tcs8yH92+XY0Q8QMo/T3YXVhTSuWDxJ2dmqhN
   rf0twNZ8FJqZTe8BK+4wciTu7fcbLtoScjWWpyI5XiPXqH4DyZC286l3H
   xT4hpeSD3O7KV2hv3/YM41fb/UJpuO+s4VFVwd8GqC3s2cJwt08xN/iRZ
   c2MrXQf1UK6KKc+1j1A7IofzKhisYOldM72HO5Lmr0PfRivVCub+LfK9m
   8zOBIXZ6WJGfmmHc0Yyft8L94+otYk5CUxQYMyJ3DQnlx9+qbHfJtDuhj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="321733682"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="321733682"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 19:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="693531279"
Received: from chang-linux-3.sc.intel.com ([172.25.112.114])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2022 19:30:35 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v3 1/3] x86/fpu: Make XCR0 accessors immune to unwanted compiler reordering
Date:   Thu, 24 Mar 2022 19:22:17 -0700
Message-Id: <20220325022219.829-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220325022219.829-1-chang.seok.bae@intel.com>
References: <20220325022219.829-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some old GCC versions (4.9.x and 5.x) have an issue that incorrectly
reordering volatile asm statements with each other [1]. While this bug was
fixed on later versions (8.1, 7.3, and 6.5), and the kernel's current XCR0
read/write do not appear to be impacted, it is preventive to ensure them on
the program order.

Have a memory clobber for write to prevent caching/reordering memory
accesses across other XCR0 writes. A dummy operand with an arbitrary
address can prevent the compiler from reordering with other writes. Add the
dummy operand for read as used for other accessors in aa5cacdc29d
("x86/asm: Replace __force_order with a memory clobber").

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Add as a new patch (Dave Hansen).
---
 arch/x86/include/asm/fpu/xcr.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xcr.h b/arch/x86/include/asm/fpu/xcr.h
index 9656a5bc6fea..9b513e7c0161 100644
--- a/arch/x86/include/asm/fpu/xcr.h
+++ b/arch/x86/include/asm/fpu/xcr.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_FPU_XCR_H
 #define _ASM_X86_FPU_XCR_H
 
+#include <asm/special_insns.h>
+
 #define XCR_XFEATURE_ENABLED_MASK	0x00000000
 #define XCR_XFEATURE_IN_USE_MASK	0x00000001
 
@@ -9,7 +11,8 @@ static inline u64 xgetbv(u32 index)
 {
 	u32 eax, edx;
 
-	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (index));
+	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (index),
+				__FORCE_ORDER);
 	return eax + ((u64)edx << 32);
 }
 
@@ -18,7 +21,8 @@ static inline void xsetbv(u32 index, u64 value)
 	u32 eax = value;
 	u32 edx = value >> 32;
 
-	asm volatile("xsetbv" :: "a" (eax), "d" (edx), "c" (index));
+	asm volatile("xsetbv" :: "a" (eax), "d" (edx), "c" (index)
+			      :	 "memory");
 }
 
 /*
-- 
2.17.1

