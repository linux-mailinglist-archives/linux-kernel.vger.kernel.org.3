Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EAB4C953F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbiCAT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiCAT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:56:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26EC6CA59;
        Tue,  1 Mar 2022 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164557; x=1677700557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Fl34ROTLcd+eMllC9hzRVku13lC3x4b2npFrIe2SmFc=;
  b=dP3MGgq4pFzAEn5dJbLWWQmKXi4RCFGcDybzALGcz0OLyo2xBhVP08zI
   Xn6OTFKcjx9aWsdhMzztqnaXfL7y6CQfpJPnSfig20gJK6AoH7oMunKrV
   Bl2ZldRkmPJ3QuLLGSsX+SJ5QC9H+ZQBiG3XFxF4qSQ42ZZ06bdgLJkmQ
   Ib0F9gbvEJcY0jS7e/zL2kBD8tNd3Q6QgSge9Cy/7zHBkqJyY0xjcy8r0
   KZyQuosQYn40gLr/rJeLFgcAlmtYHqNbkVPD71ppGsd/1pNeMrQZyp4VZ
   SlYoju/DY2cBeR4Oy2i4CPEMTHDWDVBfHrLtQA/tSPxlVF6jQGte0uuUr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233194906"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233194906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630133183"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:54 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: [RFC 10/10] trace: platform/x86/intel/ifs: Add trace point to track Intel IFS operations
Date:   Tue,  1 Mar 2022 11:54:57 -0800
Message-Id: <20220301195457.21152-11-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220301195457.21152-1-jithu.joseph@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Add tracing support which may be useful for debugging systems that fail to complete
In Field Scan tests.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/core.c |  5 ++++
 include/trace/events/ifs.h            | 38 +++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 include/trace/events/ifs.h

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index c9ca385082e9..dec2a72eb95a 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -13,6 +13,9 @@
 
 #include "ifs.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/ifs.h>
+
 static enum cpuhp_state cpuhp_scan_state;
 struct ifs_params ifs_params;
 int cpu_sibl_ct;
@@ -217,6 +220,8 @@ static int scan_test_worker(void *info)
 
 			rdmsrl(MSR_SCAN_STATUS, status.data);
 
+			trace_ifs_status(activate, status);
+
 			/* Some cases can be retried, give up for others */
 			if (!can_restart(status))
 				break;
diff --git a/include/trace/events/ifs.h b/include/trace/events/ifs.h
new file mode 100644
index 000000000000..3c6ef33c7b3b
--- /dev/null
+++ b/include/trace/events/ifs.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ifs
+
+#if !defined(_TRACE_IFS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_IFS_H
+
+#include <linux/ktime.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(ifs_status,
+
+	TP_PROTO(union ifs_scan activate, union ifs_status status),
+
+	TP_ARGS(activate, status),
+
+	TP_STRUCT__entry(
+		__field(	u8,	start	)
+		__field(	u8,	stop	)
+		__field(	u64,	status	)
+	),
+
+	TP_fast_assign(
+		__entry->start	= activate.start;
+		__entry->stop	= activate.stop;
+		__entry->status	= status.data;
+	),
+
+	TP_printk("start: %.2x, stop: %.2x, status: %llx",
+		__entry->start,
+		__entry->stop,
+		__entry->status)
+);
+
+#endif /* _TRACE_IFS_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

