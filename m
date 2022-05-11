Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA55229CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiEKCaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbiEKC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDD721AABC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236184; x=1683772184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVhiT6aKeF/Rpr/dJksjmlkONreh2kMGvoLBNiaVHv4=;
  b=E032CCyWLsZ6zZQXqH4b94PYGQ8IAR13GteQ5ZPd6vKWxRzzWi997eZT
   7BICAZUNV/bSZlngp/luXJ9CUKzTmJa8u8WZFiuVOuJnM2Tmt8CSikFFU
   J+OFxIbUvrWD/wYoTrFQLMpMpUPfoqtlR9pffeoNkT2x3cnF0o9vkJk9g
   Sd73qGk0Xkunfm8XVuCKdtgqKC1eJsE7Uw09b6sblXuvKSnGxfXujNrLz
   qE9TKqLZD17/syHM/xxH+jKQOUPN7pH7ljDdhj6lX+SaNaNV/dGSQF9oc
   nWbw1xOriSAZLnpD6XKSPBgt9vwvx6MwMAg2K9gyflaG2+m0p2Bfe8bQi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="294798606"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="294798606"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="553112425"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2022 19:29:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 495565C1; Wed, 11 May 2022 05:28:01 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFCv2 06/10] x86/uaccess: Remove tags from the address before checking
Date:   Wed, 11 May 2022 05:27:47 +0300
Message-Id: <20220511022751.65540-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tags must not be included into check whether it's okay to access the
userspace address.

Strip tags in  access_ok().

get_user() and put_user() don't use access_ok(), but check access
against TASK_SIZE directly in assembly. Strip tags, before calling into
the assembly helper.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/uaccess.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index f78e2b3501a1..0f5bf7db4ec9 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -40,7 +40,7 @@ static inline bool pagefault_disabled(void);
 #define access_ok(addr, size)					\
 ({									\
 	WARN_ON_IN_IRQ();						\
-	likely(__access_ok(addr, size));				\
+	likely(__access_ok(untagged_addr(addr), size));			\
 })
 
 #include <asm-generic/access_ok.h>
@@ -125,7 +125,12 @@ extern int __get_user_bad(void);
  * Return: zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define get_user(x,ptr) ({ might_fault(); do_get_user_call(get_user,x,ptr); })
+#define get_user(x,ptr)							\
+({									\
+	__typeof__(*(ptr)) __user *__ptr_clean = untagged_ptr(ptr);	\
+	might_fault();							\
+	do_get_user_call(get_user,x,__ptr_clean);			\
+})
 
 /**
  * __get_user - Get a simple variable from user space, with less checking.
@@ -222,7 +227,11 @@ extern void __put_user_nocheck_8(void);
  *
  * Return: zero on success, or -EFAULT on error.
  */
-#define put_user(x, ptr) ({ might_fault(); do_put_user_call(put_user,x,ptr); })
+#define put_user(x, ptr) ({						\
+	__typeof__(*(ptr)) __user *__ptr_clean = untagged_ptr(ptr);	\
+	might_fault();							\
+	do_put_user_call(put_user,x,__ptr_clean);			\
+})
 
 /**
  * __put_user - Write a simple value into user space, with less checking.
-- 
2.35.1

