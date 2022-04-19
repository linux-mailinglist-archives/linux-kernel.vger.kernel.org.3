Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2E507396
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354998AbiDSQnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354763AbiDSQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A0167DF;
        Tue, 19 Apr 2022 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386351; x=1681922351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GiGJaH71F5oTpM1VXhMQYtv9L+oZv5Oh7aW9Jy9k+CQ=;
  b=BY9+Bpm5Y3DCDGcA91Zlv83lSUOD2LzjmNfU5b0Nc+i8ZYvFRNpwN14f
   JTJION84kvA57goboL+MzoVdNBmctWlsOgdDhIsMeSY/XgfSt9RGivytk
   YHrEYGO4iwoY/vNjjqNFZHV/GS5U7snNuyRF5OqlFXfyr56pjjFpAzhaZ
   aZbr0w04ZtIAyQuBuOqT4Wu3TwBDEzoR0S8+VfjWObIlNJ50c3d20niwK
   jz3+uNaPLa9sdDXQjy//IUk7qgwVEir1tuh2xKhZ8exdEWB9FP8df1PSb
   mEHqvDq5Zvcho/pw0Skfe0kTRTPPm8ymAgoMJ9vY1icfEpCG/aberdHoE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702555"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702555"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802172"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:09 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v3 10/11] trace: platform/x86/intel/ifs: Add trace point to track Intel IFS operations
Date:   Tue, 19 Apr 2022 09:38:58 -0700
Message-Id: <20220419163859.2228874-11-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419163859.2228874-1-tony.luck@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tracing support which may be useful for debugging systems that fail to complete
In Field Scan tests.

Reviewed-by: Dan Williams <dan.j.williams@intel.com
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 MAINTAINERS                              |  1 +
 drivers/platform/x86/intel/ifs/runtest.c |  5 ++++
 include/trace/events/intel_ifs.h         | 38 ++++++++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 include/trace/events/intel_ifs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e372a960fa5..b488ff628a43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9867,6 +9867,7 @@ R:	Ashok Raj <ashok.raj@intel.com>
 R:	Tony Luck <tony.luck@intel.com>
 S:	Maintained
 F:	drivers/platform/x86/intel/ifs
+F:	include/trace/events/intel_ifs.h
 
 INTEL INTEGRATED SENSOR HUB DRIVER
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 246eff250563..c6fa9385dda0 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -24,6 +24,9 @@ static atomic_t siblings_out;
 static int cpu_sibl_ct;
 static bool scan_enabled = true;
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/intel_ifs.h>
+
 struct ifs_work {
 	struct work_struct w;
 	struct device *dev;
@@ -217,6 +220,8 @@ static void ifs_work_func(struct work_struct *work)
 
 		rdmsrl(MSR_SCAN_STATUS, status.data);
 
+		trace_ifs_status(activate, status);
+
 		/* Some cases can be retried, give up for others */
 		if (!can_restart(status))
 			break;
diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
new file mode 100644
index 000000000000..0611f370cb37
--- /dev/null
+++ b/include/trace/events/intel_ifs.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM intel_ifs
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
+		__field(	u64,	status	)
+		__field(	u8,	start	)
+		__field(	u8,	stop	)
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
2.35.1

