Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0B75917FA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 03:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiHMBJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 21:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbiHMBJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:09:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE5E7333B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 18:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660352940; x=1691888940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=htBXzFuj58kSVBgpeaRLCDJaLlWQVrwWv47Dz051D/g=;
  b=iUfuIuIKeGi7G4MXOuqOnCWRKZEZJ1a1MS/JvW3tE/czdnZrBmzcFT4y
   /RaIkmFCue2JKlaJ6iotByD+AKGfT9rAOgPttB6Hg7vgG/z35gAdXNhEu
   RuBzi8OMDnnyZuYEx8x5nnyOHJJh9A/H4prOQEds8Px/3DAE2bX7bC74O
   Ib7m4DLLe6BGDegrA+O3s6C9rheAIwmOWyXtHx1LdXC96cG5ecEFdRokd
   7cen3Ik6KiorOOgiA0COWjEml8Tkjd5l5GIbHyUdj4S76hPL2PlZzbEVi
   JbkUGHZttFwOE5f/zYnnNlWcTbxy2b2pVPiKNDyF1t1sAE84Jeu6E7BXY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="271488712"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="271488712"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 18:09:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="666038345"
Received: from akoska-mobl1.ger.corp.intel.com (HELO hades.ger.corp.intel.com) ([10.252.36.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 18:08:57 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@linux.ie,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com
Subject: [PATCH v6 2/8] util_macros: Add exact_type macro to catch type mis-match while compiling
Date:   Sat, 13 Aug 2022 04:08:51 +0300
Message-Id: <20220813010857.4043956-3-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220813010857.4043956-1-gwan-gyeong.mun@intel.com>
References: <20220813010857.4043956-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.34.1

