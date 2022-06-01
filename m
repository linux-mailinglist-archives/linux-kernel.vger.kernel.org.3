Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249F953A0AB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351257AbiFAJfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351217AbiFAJfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:35:23 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87AB8FD50
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:35:21 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id y13-20020a056402358d00b0042dfb820070so615468edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nAAyFhVOk4u65vleHIjgu+W4rGODUec3akAhRLx+y9I=;
        b=fU3U+u9oh7vSMuu1yxC4PQjdqQQGIEkx/Edfk44jtI77jbJEZCIafRg0+hLKVQpUMT
         Do9h3dEQrWc5ATr9aTHFGhcIal3Bpgf6VpNT50CCu1RD528Q6adtg/uF37oWz3MegmOu
         XTPosdYckbfm4DJw2w8V4DizDVrvl6maEh5x5jlGX/BrHRZk2ZAjKFXKa7GZHa4j7Prm
         96KT6NeemVLFju6+dji+EdsONTxV1hz8mmrKTAYWflxknHWdpGTD8J++k93JXnhwy16E
         Vxw5P/mre3HZaNzqxN+gwWpNpr03XGdPxAWCBH04IzAV+3zEF11E3vinUFoaos9dW7ir
         PrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nAAyFhVOk4u65vleHIjgu+W4rGODUec3akAhRLx+y9I=;
        b=1JS/+KM3+HGtw2ggGyNBqBoxClrLqkmHBeh2A60dA1X3EGT0sFOO1jWZ3Gp3fi0SMM
         +xFhNInVxRT8DoOz5LhNgKPftXIY99sd2rnzmC51IWw7FwquW3OHT0YTRRr/ciVeFsLR
         RA1bmmJy6g1wAi4go6u30uBe2obzzA+j184vfb7NTJsPaf9kclXCle6uGsc3BCsrtp1i
         qOZqG1lgr9qbHjlbkkl0uvCXz3fiqcTrgdcFDdnxzuMCHlxYUSnRLRp5oojvUJWTUr3K
         1l6LTbvjg0QkXTJ67WtkYEHSRVQT4QEE68FTnIFh23MG51/s6awMxjcUeTpn+D4UaJJX
         7eaA==
X-Gm-Message-State: AOAM532n42ebWS8f9sDQqJehCpAhK5onDCutAWfOtwYvroLZizzs5GLy
        Bb77Cgi9zeWqmjNjXF8uOwHVCEzzKQ==
X-Google-Smtp-Source: ABdhPJxZHq5XOfwYwtj8MWKx1l8Au10pgCCI/gwzvd5AHmMBrBS2APi4kKt/nbWhVOc6JrCokO6VDIYrIg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:ed43:9390:62cb:50ee])
 (user=elver job=sendgmr) by 2002:a05:6402:2211:b0:42d:cb9e:cbf with SMTP id
 cq17-20020a056402221100b0042dcb9e0cbfmr18833360edb.76.1654076120249; Wed, 01
 Jun 2022 02:35:20 -0700 (PDT)
Date:   Wed,  1 Jun 2022 11:35:02 +0200
Message-Id: <20220601093502.364142-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH RFC] perf: Allow restricted kernel breakpoints on user addresses
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the creation of restricted breakpoint perf events that also fire
in the kernel (!exclude_kernel), if:

  1. No sample information is requested; samples may contain IPs,
     registers, or other information that may disclose kernel addresses.

  2. The breakpoint (viz. data watchpoint) is on a user address.

The rules constrain the allowable perf events such that no sensitive
kernel information can be disclosed.

Despite no explicit kernel information disclosure, the following
questions may need answers:

	1. Is obtaining information that the kernel accessed a
	   particular user's known memory location revealing new
	   information? Given the kernel's user space ABI, there should
	   be no "surprise accesses" to user space memory in the first
	   place.

	2. Does causing breakpoints on user memory accesses by the
	   kernel potentially impact timing in a sensitive way? Given
	   that hardware breakpoints trigger regardless of the state of
	   perf_event_attr::exclude_kernel, but are filtered in the perf
	   subsystem, this possibility already exists independent of the
	   proposed change.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---

RFC:

We are looking to identify a set of constraints on perf events that
would allow them to safely be created by unprivileged users when
perf_event_paranoid > 1 && !perfmon_capable().

Our current (and only) event type of interest is PERF_TYPE_BREAKPOINT.

Any thoughts?

---
 include/linux/perf_event.h |  8 +-------
 kernel/events/core.c       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index af97dd427501..06c2ed46cbf9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1348,13 +1348,7 @@ static inline int perf_is_paranoid(void)
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline int perf_allow_kernel(struct perf_event_attr *attr)
-{
-	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
-		return -EACCES;
-
-	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
-}
+extern int perf_allow_kernel(struct perf_event_attr *attr);
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6eafb1b0ad4a..f37047cfcb2f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3266,6 +3266,12 @@ static int perf_event_modify_attr(struct perf_event *event,
 		return -EOPNOTSUPP;
 	}
 
+	if (!event->attr.exclude_kernel) {
+		err = perf_allow_kernel(attr);
+		if (err)
+			return err;
+	}
+
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 
 	mutex_lock(&event->child_mutex);
@@ -12104,6 +12110,38 @@ perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
 	return is_capable || ptrace_may_access(task, ptrace_mode);
 }
 
+/*
+ * Check if unprivileged users are allowed to set up breakpoints on user
+ * addresses that also count when the kernel accesses them.
+ */
+static bool perf_allow_kernel_breakpoint(struct perf_event_attr *attr)
+{
+	if (attr->type != PERF_TYPE_BREAKPOINT)
+		return false;
+
+	/*
+	 * The sample may contain IPs, registers, or other information that may
+	 * disclose kernel addresses or timing information. Disallow any kind of
+	 * additional sample information.
+	 */
+	if (attr->sample_type)
+		return false;
+
+	/*
+	 * Only allow kernel breakpoints on user addresses.
+	 */
+	return access_ok((void __user *)(unsigned long)attr->bp_addr, attr->bp_len);
+}
+
+int perf_allow_kernel(struct perf_event_attr *attr)
+{
+	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable() &&
+	    !perf_allow_kernel_breakpoint(attr))
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
+}
+
 /**
  * sys_perf_event_open - open a performance event, associate it to a task/cpu
  *
-- 
2.36.1.255.ge46751e96f-goog

