Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3967353CDF9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbiFCRVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbiFCRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:21:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D6252536
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654276870; x=1685812870;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vIiK49QJMGH4Ib8ni1/aaFpvDGucIOFDdBdBnD3oc/8=;
  b=lk4aTWUkE2UJ+VT+EerTRo4WE1JKICdx4lGKTSd9wIE7J3Kcbp5JtGkk
   aVbAREtO+JoG8/vlJPqQek7L7GL4Y5Tik4uaE7uSfuVqcFvtbU5wuLpls
   yWL6T9yiAK2x6DKfYRU2/pvy1iHzaBry4TnDc/bneObwRKTya+bpJN6tp
   82Oi9TxVNXoqgcHt4ZMsF2o5ky2z4BdlVGIs24I4gMdA9XWGNRjVTyeOm
   AUNm6oFjPz9GtqpW6Josunn9E42CpiEhpCIi6FoyZw196i3YaAKeZNp84
   eHiSg9Kkciw7SXFObPnyg+gAPLNTVylNVenF4PE7kYE5kBFk0sgeU6S9X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="258386608"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="258386608"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="708113744"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 03 Jun 2022 10:21:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B894F8; Fri,  3 Jun 2022 20:21:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] kernel.h: Move sysfs related macro to sysfs.h
Date:   Fri,  3 Jun 2022 20:21:01 +0300
Message-Id: <20220603172101.49950-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the comment of VERIFY_OCTAL_PERMISSIONS() it's related to sysfs.
Move it to the corresponding header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h | 12 ------------
 include/linux/sysfs.h  | 13 +++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 239e36248980..1934a77d2c84 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -489,16 +489,4 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 # define REBUILD_DUE_TO_FTRACE_MCOUNT_RECORD
 #endif
 
-/* Permissions on a sysfs file: you didn't miss the 0 prefix did you? */
-#define VERIFY_OCTAL_PERMISSIONS(perms)						\
-	(BUILD_BUG_ON_ZERO((perms) < 0) +					\
-	 BUILD_BUG_ON_ZERO((perms) > 0777) +					\
-	 /* USER_READABLE >= GROUP_READABLE >= OTHER_READABLE */		\
-	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 4) < (((perms) >> 3) & 4)) +	\
-	 BUILD_BUG_ON_ZERO((((perms) >> 3) & 4) < ((perms) & 4)) +		\
-	 /* USER_WRITABLE >= GROUP_WRITABLE */					\
-	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 2) < (((perms) >> 3) & 2)) +	\
-	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
-	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
-	 (perms))
 #endif
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index e3f1e8ac1f85..10c9e731c250 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -98,6 +98,19 @@ struct attribute_group {
 
 #define SYSFS_PREALLOC 010000
 
+/* Permissions on a sysfs file: you didn't miss the 0 prefix did you? */
+#define VERIFY_OCTAL_PERMISSIONS(perms)						\
+	(BUILD_BUG_ON_ZERO((perms) < 0) +					\
+	 BUILD_BUG_ON_ZERO((perms) > 0777) +					\
+	 /* USER_READABLE >= GROUP_READABLE >= OTHER_READABLE */		\
+	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 4) < (((perms) >> 3) & 4)) +	\
+	 BUILD_BUG_ON_ZERO((((perms) >> 3) & 4) < ((perms) & 4)) +		\
+	 /* USER_WRITABLE >= GROUP_WRITABLE */					\
+	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 2) < (((perms) >> 3) & 2)) +	\
+	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
+	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
+	 (perms))
+
 #define __ATTR(_name, _mode, _show, _store) {				\
 	.attr = {.name = __stringify(_name),				\
 		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
-- 
2.35.1

