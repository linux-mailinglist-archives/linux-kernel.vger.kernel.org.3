Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AA14F87E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbiDGTR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347115AbiDGTQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:16:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5988B23F9CB;
        Thu,  7 Apr 2022 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358868; x=1680894868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=EpuU9FnJFmOX+BA1Irm1YxgXVJdK5TXoe/7lCiqp/zk=;
  b=fzDXd6sZNwydbYFLaIluNQIXkc3fT1qQ3RuZNsgIh13Sm43Uw+3srB8C
   TIXRzvOhWGSAsqfePpelCftAQqGaT3s8Z7ySu4/65V58zHyVv8PRHY3bT
   3qsQDtEDl474zmkbXHcFgmMQ1l3LAYA5MKvG4uzLSwtg0t/fFc0HOqPg+
   iY2FIB0o/z9taV/B3t8UcIpDKQQA3mKdJaCmHeo/u5tRQ5tJZWIFWJfOH
   U+rWbflyLiuzQRqe/DW04VdEWH24BTuHQ6L6UTyvc1+Fwe5bFQifO1oG5
   knn4o9jhZ3m2xZll6/rRBtf9GMxtSV6LnB5DfrzNviuL7oEOrdSICSski
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260255390"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="260255390"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571193735"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:19 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v2 10/10] trace: platform/x86/intel/ifs: Add trace point to track Intel IFS operations
Date:   Thu,  7 Apr 2022 12:13:47 -0700
Message-Id: <20220407191347.9681-11-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407191347.9681-1-jithu.joseph@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Add tracing support which may be useful for debugging systems that fail to complete
In Field Scan tests.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/runtest.c |  5 ++++
 include/trace/events/intel_ifs.h         | 38 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 include/trace/events/intel_ifs.h

diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index f9c98d84183f..b9fac2ac7107 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -10,6 +10,9 @@
 
 #include "ifs.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/intel_ifs.h>
+
 bool ifs_disabled;
 
 static int ifs_retry_set(const char *val, const struct kernel_param *kp);
@@ -204,6 +207,8 @@ static void ifs_work_func(struct work_struct *work)
 
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
2.17.1

