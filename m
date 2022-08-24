Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE28B59F59B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiHXIp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiHXIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:45:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F8E6B8FB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661330735; x=1692866735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uWNiR7M8bUT4JAhynBPIOlI6cvuOcXNpkpD1siwzhag=;
  b=bR9Qn8//HPNLY+nH+ZEYu4iwTetoAuUWvrPWDthMaINP6lonhgob7eLv
   r5eiTq5ZWfkl88Zr6STUdkmemLf5zV+23FiF8bSW3qX2GAE9aYjzhd3Li
   enA8ETkYgFSdSO/iDFIaMRn1JqNjx72XNxZSj4/WeXAxPK2UDkwTJfULX
   wtjpjDGOSsFScMWsEsB/VcjnnqJdv1zbVnc0Nk3X6QqlAXP0DKF8coym1
   0RzSTsE6xPzA64tx7pEWREEDNeYru5c76HfP+kmM15D+ud445qafBTjlG
   z4pU0q8tPKASb6zZVmnwBqDyALaGGd24VivAnru0L14uoq637LToTv7Yt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="357882474"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="357882474"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 01:45:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="785553971"
Received: from yuhsuanc-mobl.gar.corp.intel.com (HELO paris.amr.corp.intel.com) ([10.254.38.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 01:45:31 -0700
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
Subject: [PATCH v9 2/8] util_macros: Add exact_type macro to catch type mis-match while compiling
Date:   Wed, 24 Aug 2022 17:45:08 +0900
Message-Id: <20220824084514.2261614-3-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824084514.2261614-1-gwan-gyeong.mun@intel.com>
References: <20220824084514.2261614-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds exact_type and exactly_pgoff_t macro to catch type mis-match while
compiling. The existing typecheck() macro outputs build warnings, but the
newly added exact_type() macro uses the BUILD_BUG_ON() macro to generate
a build break when the types are different and can be used to detect
explicit build errors.

v6: Move macro addition location so that it can be used by other than drm
    subsystem (Jani, Mauro, Andi)

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 include/linux/util_macros.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 72299f261b25..b6624b275257 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_HELPER_MACROS_H_
 #define _LINUX_HELPER_MACROS_H_
 
+#include <linux/types.h>
+#include <linux/bug.h>
+
 #define __find_closest(x, a, as, op)					\
 ({									\
 	typeof(as) __fc_i, __fc_as = (as) - 1;				\
@@ -38,4 +41,26 @@
  */
 #define find_closest_descending(x, a, as) __find_closest(x, a, as, >=)
 
+/**
+ * exact_type - break compile if source type and destination value's type are
+ * not the same
+ * @T: Source type
+ * @n: Destination value
+ *
+ * It is a helper macro for a poor man's -Wconversion: only allow variables of
+ * an exact type. It determines whether the source type and destination value's
+ * type are the same while compiling, and it breaks compile if two types are
+ * not the same
+ */
+#define exact_type(T, n) \
+	BUILD_BUG_ON(!__builtin_constant_p(n) && !__builtin_types_compatible_p(T, typeof(n)))
+
+/**
+ * exactly_pgoff_t - helper to check if the type of a value is pgoff_t
+ * @n: value to compare pgoff_t type
+ *
+ * It breaks compile if the argument value's type is not pgoff_t type.
+ */
+#define exactly_pgoff_t(n) exact_type(pgoff_t, n)
+
 #endif
-- 
2.37.1

