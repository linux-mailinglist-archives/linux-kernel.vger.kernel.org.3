Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084B751CE86
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388070AbiEFBo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388011AbiEFBob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:44:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE665DBFA;
        Thu,  5 May 2022 18:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651801250; x=1683337250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cOpo1cxKQZOorn/YwjgOZeIpxyqd7qk0J0cuvEnrJsw=;
  b=a7DOMJeTK3bZEomwmbb54Ni+cDf/5VRyGO8GVivUZ0H8C6reRyPOvyEY
   n6Sa2xNhxpuR7PrZaZuFUuwSztUJG9j6oKpW6tk+vACoK1hbm/gJgV0yP
   zQ3eUpoiJTM0OYsCrPk4Q225Q3QmHRE+3kRqX6U13vORbfB4dckk1AL70
   dc0fZRrAN0aDYF5z2DdED5CIaGbrsH1mXvTjRdvYmFwz1YkOTv4c+ng+h
   NV+upbUZA0EktLbeZnrUZAVJe8CkClPczaVSCXQBuwHhD4E8FEY6MoR8U
   cziekBkU26qtanYx4eKA23mtu+x5vXWlUqbn4ZH8REKaDpC7cWgreVKns
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293519440"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293519440"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:40:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537645059"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:40:47 -0700
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
Subject: [PATCH v6 10/11] trace: platform/x86/intel/ifs: Add trace point to track Intel IFS operations
Date:   Thu,  5 May 2022 18:40:34 -0700
Message-Id: <20220506014035.1173578-11-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506014035.1173578-1-tony.luck@intel.com>
References: <20220428153849.295779-1-tony.luck@intel.com>
 <20220506014035.1173578-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tracing support which may be useful for debugging systems that fail to complete
In Field Scan tests.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS                              |  1 +
 drivers/platform/x86/intel/ifs/runtest.c |  5 +++
 include/trace/events/intel_ifs.h         | 41 ++++++++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 include/trace/events/intel_ifs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bb0c4ff25942..6864fa039974 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9868,6 +9868,7 @@ R:	Ashok Raj <ashok.raj@intel.com>
 R:	Tony Luck <tony.luck@intel.com>
 S:	Maintained
 F:	drivers/platform/x86/intel/ifs
+F:	include/trace/events/intel_ifs.h
 
 INTEL INTEGRATED SENSOR HUB DRIVER
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index fd3f5f3f31e5..cd25817ceda0 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -19,6 +19,9 @@
 struct workqueue_struct *ifs_wq;
 static bool scan_enabled = true;
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/intel_ifs.h>
+
 /* Max retries on the same chunk */
 #define MAX_IFS_RETRIES  5
 
@@ -191,6 +194,8 @@ static void ifs_test_core(int cpu, struct device *dev)
 
 		status.data = msrvals[1];
 
+		trace_ifs_status(cpu, activate, status);
+
 		/* Some cases can be retried, give up for others */
 		if (!can_restart(status))
 			break;
diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
new file mode 100644
index 000000000000..d7353024016c
--- /dev/null
+++ b/include/trace/events/intel_ifs.h
@@ -0,0 +1,41 @@
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
+	TP_PROTO(int cpu, union ifs_scan activate, union ifs_status status),
+
+	TP_ARGS(cpu, activate, status),
+
+	TP_STRUCT__entry(
+		__field(	u64,	status	)
+		__field(	int,	cpu	)
+		__field(	u8,	start	)
+		__field(	u8,	stop	)
+	),
+
+	TP_fast_assign(
+		__entry->cpu	= cpu;
+		__entry->start	= activate.start;
+		__entry->stop	= activate.stop;
+		__entry->status	= status.data;
+	),
+
+	TP_printk("cpu: %d, start: %.2x, stop: %.2x, status: %llx",
+		__entry->cpu,
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

