Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F35595991
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiHPLL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiHPLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:11:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F4D631C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660642658; x=1692178658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uNOE1dTwztKIHhBeWOrKk5mBYn1U2LqIR0BM6RNHtw0=;
  b=E/+i0JII4p4Ar7zOarhRKn+AjO2e7eyNzT0mnD5oOf3TVSB+STZiaV2D
   dvDkU7FEk5IqRrjHMmugYYi0nLhopXBKo5FuwFhmCyVg1kiqXxmtiMXB9
   6F7UoO46n89AR08E9CqjSK46P2jN3IdcedQtHdF/rLIpumVuN8BYJCLad
   K7wjM6nAeyQya1gj4C6oQFkY/I7fBNQjvlzQZhitWpL4H/efyMtqMCiQI
   kGPlgVJ4hRxcxkAUSg8DFIBJlCahb2uSnTIo0y58fhG4LluXZceybaM+m
   2QtilptQ/kM8C4wNQYFmqNt+7n28hs2OBkhKKoyXOW65H63JIa4AthoyN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293446796"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="293446796"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:35:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="733231028"
Received: from clbarnes-mobl.amr.corp.intel.com (HELO paris.amr.corp.intel.com) ([10.254.7.166])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:35:43 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@linux.ie,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com
Subject: [PATCH v7 1/8] overflow: Move and add few utility macros into overflow
Date:   Tue, 16 Aug 2022 18:35:18 +0900
Message-Id: <20220816093525.184940-2-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816093525.184940-1-gwan-gyeong.mun@intel.com>
References: <20220816093525.184940-1-gwan-gyeong.mun@intel.com>
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
header. The overflows_type can be used to catch the truncation between data
types. And it adds safe_conversion() macro which performs a type conversion
(cast) of an source value into a new variable, checking that the
destination is large enough to hold the source value. And the functionality
of overflows_type has been improved to handle the signbit.
The is_unsigned_type macro has been added to check the sign bit of the
built-in type.

v3: Add is_type_unsigned() macro (Mauro)
    Modify overflows_type() macro to consider signed data types (Mauro)
    Fix the problem that safe_conversion() macro always returns true
v4: Fix kernel-doc markups
v6: Move macro addition location so that it can be used by other than drm
    subsystem (Jani, Mauro, Andi)
    Change is_type_unsigned to is_unsigned_type to have the same name form
    as is_signed_type macro

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org> (v5)
---
 drivers/gpu/drm/i915/i915_utils.h |  5 +--
 include/linux/overflow.h          | 54 +++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 4 deletions(-)

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
index f1221d11f8e5..462a03454377 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -35,6 +35,60 @@
 #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
 #define type_min(T) ((T)((T)-type_max(T)-(T)1))
 
+/**
+ * is_unsigned_type - helper for checking data type which is an unsigned data
+ * type or not
+ * @x: The data type to check
+ *
+ * Returns:
+ * True if the data type is an unsigned data type, false otherwise.
+ */
+#define is_unsigned_type(x) ((typeof(x))-1 >= (typeof(x))0)
+
+/**
+ * overflows_type - helper for checking the truncation between data types
+ * @x: Source for overflow type comparison
+ * @T: Destination for overflow type comparison
+ *
+ * It compares the values and size of each data type between the first and
+ * second argument to check whether truncation can occur when assigning the
+ * first argument to the variable of the second argument.
+ * Source and Destination can be used with or without sign bit.
+ * Composite data structures such as union and structure are not considered.
+ * Enum data types are not considered.
+ * Floating point data types are not considered.
+ *
+ * Returns:
+ * True if truncation can occur, false otherwise.
+ */
+#define overflows_type(x, T) \
+	(is_unsigned_type(x) ? \
+		is_unsigned_type(T) ? \
+			(sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
+			: (sizeof(x) >= sizeof(T) && (x) >> (BITS_PER_TYPE(T) - 1)) ? 1 : 0 \
+	: is_unsigned_type(T) ? \
+		((x) < 0) ? 1 : (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
+		: (sizeof(x) > sizeof(T)) ? \
+			((x) < 0) ? (((x) * -1) >> BITS_PER_TYPE(T)) ? 1 : 0 \
+				: ((x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
+			: 0)
+
+/**
+ * safe_conversion - perform a type conversion (cast) of an source value into
+ * a new variable, checking that the destination is large enough to hold the
+ * source value.
+ * @ptr: Destination pointer address
+ * @value: Source value
+ *
+ * Returns:
+ * If the value would overflow the destination, it returns false.
+ */
+#define safe_conversion(ptr, value) ({ \
+	typeof(value) __v = (value); \
+	typeof(ptr) __ptr = (ptr); \
+	overflows_type(__v, *__ptr) ? 0 : ((*__ptr = (typeof(*__ptr))__v), 1); \
+})
+
 /*
  * Avoids triggering -Wtype-limits compilation warning,
  * while using unsigned data types to check a < 0.
-- 
2.37.1

