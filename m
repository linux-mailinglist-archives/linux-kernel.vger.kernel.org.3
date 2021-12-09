Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3CD46F6E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhLIWf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:35:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58920 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhLIWfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:35:51 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 97BAB20B717B;
        Thu,  9 Dec 2021 14:32:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 97BAB20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639089137;
        bh=lad/j+ot53rXPTIMEBiBmAPcSVSE3JYr+2WF4ax63Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFsAC9Ut8L0Zaus+DhUNRIstL9N3qw+tpz39RtQvsvTcvEufFXhyoNNkUKhCsoZ3k
         jysohcsTJbz155ruNgIijWJSRCBsiviLzxLGA1PS30I4I7RbTb35YnOuAvAkeYvqFM
         2a83UG44pBALzlgUdJlGqhK2hCeu9iuAj29f5suI=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v7 01/13] user_events: Add UABI header for user access to user_events
Date:   Thu,  9 Dec 2021 14:31:58 -0800
Message-Id: <20211209223210.1818-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209223210.1818-1-beaub@linux.microsoft.com>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the basic structs and ioctl commands that allow user processes to
interact with user_events.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/uapi/linux/user_events.h | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 include/uapi/linux/user_events.h

diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
new file mode 100644
index 000000000000..5bff99418deb
--- /dev/null
+++ b/include/uapi/linux/user_events.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ *
+ * Authors:
+ *   Beau Belgrave <beaub@linux.microsoft.com>
+ */
+#ifndef _UAPI_LINUX_USER_EVENTS_H
+#define _UAPI_LINUX_USER_EVENTS_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#ifdef __KERNEL__
+#include <linux/uio.h>
+#else
+#include <sys/uio.h>
+#endif
+
+#define USER_EVENTS_SYSTEM "user_events"
+#define USER_EVENTS_PREFIX "u:"
+
+/* Bits 0-6 are for known probe types, Bit 7 is for unknown probes */
+#define EVENT_BIT_FTRACE 0
+#define EVENT_BIT_PERF 1
+#define EVENT_BIT_OTHER 7
+
+#define EVENT_STATUS_FTRACE (1 << EVENT_BIT_FTRACE)
+#define EVENT_STATUS_PERF (1 << EVENT_BIT_PERF)
+#define EVENT_STATUS_OTHER (1 << EVENT_BIT_OTHER)
+
+/* Use raw iterator for attached BPF program(s), no affect on ftrace/perf */
+#define FLAG_BPF_ITER (1 << 0)
+
+struct user_reg {
+	__u32 size;
+	__u64 name_args;
+	__u32 status_index;
+	__u32 write_index;
+};
+
+#define DIAG_IOC_MAGIC '*'
+#define DIAG_IOCSREG _IOWR(DIAG_IOC_MAGIC, 0, struct user_reg*)
+#define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char*)
+
+enum {
+	USER_BPF_DATA_KERNEL,
+	USER_BPF_DATA_USER,
+	USER_BPF_DATA_ITER,
+};
+
+struct user_bpf_iter {
+	__u32 iov_offset;
+	__u32 nr_segs;
+	const struct iovec *iov;
+};
+
+struct user_bpf_context {
+	__u32 data_type;
+	__u32 data_len;
+	union {
+		void *kdata;
+		void *udata;
+		struct user_bpf_iter *iter;
+	};
+};
+
+#endif /* _UAPI_LINUX_USER_EVENTS_H */
-- 
2.17.1

