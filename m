Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4D59E44A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiHWNWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241499AbiHWNVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:21:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF51435B8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661250000; x=1692786000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pHZpD5R55mDNFmQEydujAwEmg6PN38/zVmQNxisp2i4=;
  b=I3wD8sN79CN/W86+t/PWDlhMEH/VLYzz9xlvmxu79CMECC6xHUcV5iD8
   V/GRPx23/0GtzZJy94z31m0v33wlu2ztkg0sZib8H5T9dWLFPZqArF4EP
   Rhy/Vt0NuSn24gDUGByeaTs+F5A0lvtj7Om0p4y0+2HVi1vpHl7Ah0dC1
   JhzWhLOBN99H0XTp2/umJVsWSFIEN6teC1qpE6AvXqdlvW5qFuqpQPdPL
   u/rITvsjfJbc2qJMFh2SHy8vSC+8jBjouxwkK65qXiPH8VZyc7ehXQPhl
   LLo6o65HMkzt73KYBDUR16igAraHIdDcfebZGlqzUoVkSGiLtX4wnL5CH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="357627033"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="357627033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 03:17:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="751639883"
Received: from jabish-mobl2.amr.corp.intel.com (HELO paris.amr.corp.intel.com) ([10.254.9.209])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 03:17:47 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@linux.ie,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com,
        intel-gfx-trybot@lists.freedesktop.org
Subject: [PATCH v8 1/8] overflow: Move and add few utility macros into overflow
Date:   Tue, 23 Aug 2022 19:17:22 +0900
Message-Id: <20220823101729.2098841-2-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823101729.2098841-1-gwan-gyeong.mun@intel.com>
References: <20220823101729.2098841-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It moves overflows_type utility macro into overflow header from i915_utils
header. The overflows_type can be used to catch the truncaion (overflow)
between different data types. And it adds check_assign() macro which
performs an assigning source value into destination ptr along with an
overflow check. overflow_type macro has been improved to handle the signbit
by gcc's built-in overflow check function. And it adds overflows_ptr()
helper macro for checking the overflows between a value and a pointer
type/value.

v3: Add is_type_unsigned() macro (Mauro)
    Modify overflows_type() macro to consider signed data types (Mauro)
    Fix the problem that safe_conversion() macro always returns true
v4: Fix kernel-doc markups
v6: Move macro addition location so that it can be used by other than drm
    subsystem (Jani, Mauro, Andi)
    Change is_type_unsigned to is_unsigned_type to have the same name form
    as is_signed_type macro
v8: Add check_assign() and remove safe_conversion() (Kees)
    Fix overflows_type() to use gcc's built-in overflow function (Andrzej)
    Add overflows_ptr() to allow overflow checking when assigning a value
    into a pointer variable (G.G.)

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org> (v5)
---
 drivers/gpu/drm/i915/i915_user_extensions.c |  2 +-
 drivers/gpu/drm/i915/i915_utils.h           |  5 +-
 include/linux/overflow.h                    | 67 +++++++++++++++++++++
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_user_extensions.c b/drivers/gpu/drm/i915/i915_user_extensions.c
index c822d0aafd2d..0fb2fecbcaae 100644
--- a/drivers/gpu/drm/i915/i915_user_extensions.c
+++ b/drivers/gpu/drm/i915/i915_user_extensions.c
@@ -51,7 +51,7 @@ int i915_user_extensions(struct i915_user_extension __user *ext,
 			return err;
 
 		if (get_user(next, &ext->next_extension) ||
-		    overflows_type(next, ext))
+		    overflows_ptr(next, ext))
 			return -EFAULT;
 
 		ext = u64_to_user_ptr(next);
diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index c10d68cdc3ca..eb0ded23fa9c 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -32,6 +32,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/sched/clock.h>
+#include <linux/overflow.h>
 
 #ifdef CONFIG_X86
 #include <asm/hypervisor.h>
@@ -111,10 +112,6 @@ bool i915_error_injected(void);
 #define range_overflows_end_t(type, start, size, max) \
 	range_overflows_end((type)(start), (type)(size), (type)(max))
 
-/* Note we don't consider signbits :| */
-#define overflows_type(x, T) \
-	(sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
-
 #define ptr_mask_bits(ptr, n) ({					\
 	unsigned long __v = (unsigned long)(ptr);			\
 	(typeof(ptr))(__v & -BIT(n));					\
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index f1221d11f8e5..4016f1378bcc 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -52,6 +52,73 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	return unlikely(overflow);
 }
 
+/**
+ * overflows_type - helper for checking the overflows between data types or
+ *                  values
+ *
+ * @x: Source value or data type for overflow check
+ * @T: Destination value or data type for overflow check
+ *
+ * It compares the values or data type between the first and second argument to
+ * check whether overflow can occur when assigning the first argument to the
+ * variable of the second argument. Source and Destination can be singned or
+ * unsigned data types.
+ *
+ * Returns:
+ * True if overflow can occur, false otherwise.
+ */
+#define overflows_type(x, T) __must_check_overflow(({	\
+	typeof(T) v = 0;				\
+	__builtin_add_overflow_p((x), v, v);		\
+}))
+
+/**
+ * overflows_ptr - helper for checking the overflows between a value and
+ *                 a pointer type/value
+ *
+ * @x: Source value for overflow check
+ * @T: Destination pointer type or value for overflow check
+ *
+ * gcc's built-in overflow check functions don't support checking between the
+ * pointer type and non-pointer type. Therefore it compares the values and
+ * size of each data type between the first and second argument to check whether
+ * truncation can occur when assigning the first argument to the variable of the
+ * second argument. It checks internally the ptr is a pointer type.
+ *
+ * Returns:
+ * True if overflow can occur, false otherwise.
+ */
+#define overflows_ptr(x, T) __must_check_overflow(({	\
+	typecheck_pointer(T);				\
+	((x) < 0) ? 1 : (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T)) ? 1 : 0; \
+}))
+
+/**
+ * check_assign - perform an assigning source value into destination ptr along
+ *                with an overflow check.
+ *
+ * @value: Source value
+ * @ptr: Destination pointer address, If the pointer type is not used,
+ *       a warning message is output during build.
+ *
+ * It checks internally the ptr is a pointer type. And it uses gcc's built-in
+ * overflow check function.
+ * It does not use the check_*() wrapper functions, but directly uses gcc's
+ * built-in overflow check function so that it can be used even when
+ * the type of value and the type pointed to by ptr are different without build
+ * warning messages.
+ *
+ * Returns:
+ * If the value would overflow the destination, it returns true. If not return
+ * false. When overflow does not occur, the assigning into ptr from value
+ * succeeds. It follows the return policy as other check_*_overflow() functions
+ * return non-zero as a failure.
+ */
+#define check_assign(value, ptr) __must_check_overflow(({	\
+	typecheck_pointer(ptr); 		\
+	__builtin_add_overflow(0, value, ptr);	\
+}))
+
 /*
  * For simplicity and code hygiene, the fallback code below insists on
  * a, b and *d having the same type (similar to the min() and max()
-- 
2.37.1

