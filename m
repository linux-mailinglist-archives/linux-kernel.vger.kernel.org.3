Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDBC492FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349739AbiARUop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:44:45 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43838 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349130AbiARUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:43:33 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id F335220B9283;
        Tue, 18 Jan 2022 12:43:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F335220B9283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642538613;
        bh=kv0wHco5EwAEJeOx8KcU5U1Oq+sRrfrasJlUzpwkVMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GN0474JlUnGY3rhpKvqTfScmeQBuGYpooiTO7pzQ4FkVyIWHp7M66XEfF1qCOWtym
         WXbBA0expHMu8NJWbbZo+gQ9iMPbu6AoOeRErpqYfrruraB5Pfkm0u7LfmCU1XQVZ6
         T4tShzSch+aHF7NHOnzeyH2PInYF3BQgl7oM60bM=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v10 11/12] user_events: Add sample code for typical usage
Date:   Tue, 18 Jan 2022 12:43:25 -0800
Message-Id: <20220118204326.2169-12-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118204326.2169-1-beaub@linux.microsoft.com>
References: <20220118204326.2169-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sample code for user_events typical usage to show how to register
and monitor status, as well as to write out data.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 samples/user_events/Makefile  |  5 ++
 samples/user_events/example.c | 91 +++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 samples/user_events/Makefile
 create mode 100644 samples/user_events/example.c

diff --git a/samples/user_events/Makefile b/samples/user_events/Makefile
new file mode 100644
index 000000000000..7252b589db57
--- /dev/null
+++ b/samples/user_events/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wl,-no-as-needed -Wall -I../../usr/include
+
+example: example.o
+example.o: example.c
diff --git a/samples/user_events/example.c b/samples/user_events/example.c
new file mode 100644
index 000000000000..4f5778e441c0
--- /dev/null
+++ b/samples/user_events/example.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ *
+ * Authors:
+ *   Beau Belgrave <beaub@linux.microsoft.com>
+ */
+
+#include <errno.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <linux/user_events.h>
+
+/* Assumes debugfs is mounted */
+const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
+const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
+
+static int event_status(char **status)
+{
+	int fd = open(status_file, O_RDONLY);
+
+	*status = mmap(NULL, sysconf(_SC_PAGESIZE), PROT_READ,
+		       MAP_SHARED, fd, 0);
+
+	close(fd);
+
+	if (*status == MAP_FAILED)
+		return -1;
+
+	return 0;
+}
+
+static int event_reg(int fd, const char *command, int *status, int *write)
+{
+	struct user_reg reg = {0};
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)command;
+
+	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
+		return -1;
+
+	*status = reg.status_index;
+	*write = reg.write_index;
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int data_fd, status, write;
+	char *status_page;
+	struct iovec io[2];
+	__u32 count = 0;
+
+	if (event_status(&status_page) == -1)
+		return errno;
+
+	data_fd = open(data_file, O_RDWR);
+
+	if (event_reg(data_fd, "test u32 count", &status, &write) == -1)
+		return errno;
+
+	/* Setup iovec */
+	io[0].iov_base = &write;
+	io[0].iov_len = sizeof(write);
+	io[1].iov_base = &count;
+	io[1].iov_len = sizeof(count);
+
+ask:
+	printf("Press enter to check status...\n");
+	getchar();
+
+	/* Check if anyone is listening */
+	if (status_page[status]) {
+		/* Yep, trace out our data */
+		writev(data_fd, (const struct iovec *)io, 2);
+
+		/* Increase the count */
+		count++;
+
+		printf("Something was attached, wrote data\n");
+	}
+
+	goto ask;
+
+	return 0;
+}
-- 
2.17.1

