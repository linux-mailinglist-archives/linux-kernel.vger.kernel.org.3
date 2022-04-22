Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB950B497
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446377AbiDVKEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446354AbiDVKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052D853B4E;
        Fri, 22 Apr 2022 03:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 959B461BCE;
        Fri, 22 Apr 2022 10:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A024C385AA;
        Fri, 22 Apr 2022 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650621699;
        bh=axp9HX7cH7ozyam8yOtFy1KzpmCbuDnkcf64PAIPMj8=;
        h=From:To:Cc:Subject:Date:From;
        b=lp1i8A7HK35Z3HUTkFGQ0rxRAAHA6XB4dh1OCejV16WOt7HNoZzPjOqgEqtgxRlfy
         eJz6WJtuduEAOeEFZq9mFScEe7PZUaZvbPFjYqorKuAt/c9PLiy95ChAZpgVjfxRfu
         tit9ItGbfWRovD3ZH/mm0yuCoPiDt58dHNBSjEEpOaraWxXnaoZrfvmIKBYD2jkPCM
         3+pRE9SuqDXgxuCF6Y6Nz3gjM6JMODye189vPlmxGJLwO/00FtkapNpvaNn5bOC5eN
         Dc/kJAo2if8mz7hkImM4nvBh1I/12kk3T2xdixuChTmuZoie2X41PVIuTds23Wzs84
         +B8YCslEOAovg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 1/2] rtla: Remove procps-ng dependency
Date:   Fri, 22 Apr 2022 12:01:31 +0200
Message-Id: <52161d343abeda6d039d2f0734904a1383a4c62e.1650617571.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Wagner reported to me that readproc.h got deprecated. Also,
while the procps-ng library was available on Fedora, it was not available
on RHEL, which is a piece of evidence that it was not that used.

rtla uses procps-ng only to find the PID of the tracers' workload.

I used the procps-ng library to avoid reinventing the wheel. But in this
case, reinventing the wheel took me less time than the time we already
took trying to work around problems.

Implement a function that reads /proc/ entries, checking if:
	- the entry is a directory
	- the directory name is composed only of digits (PID)
	- the directory contains the comm file
	- the comm file contains a comm that matches the tracers'
	  workload prefix.
	- then return true; otherwise, return false.

And use it instead of procps-ng.

Cc: John Kacur <jkacur@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: b1696371d865 ("rtla: Helper functions for rtla")
Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/Makefile    |  2 +-
 tools/tracing/rtla/README.txt  |  1 -
 tools/tracing/rtla/src/utils.c | 83 +++++++++++++++++++++++++++-------
 tools/tracing/rtla/src/utils.h |  1 +
 4 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 11fb417abb42..90b8e20d1118 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -31,7 +31,7 @@ TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
 
 CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS)
 LDFLAGS	:=	-ggdb
-LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs) -lprocps
+LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
 
 SRC	:=	$(wildcard src/*.c)
 HDR	:=	$(wildcard src/*.h)
diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
index 6c88446f7e74..7bc0b931ddfd 100644
--- a/tools/tracing/rtla/README.txt
+++ b/tools/tracing/rtla/README.txt
@@ -13,7 +13,6 @@ following libraries:
 
  - libtracefs
  - libtraceevent
- - procps
 
 It also depends on python3-docutils to compile man pages.
 
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index da2b590edaed..baf9003d5d41 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
 
-#include <proc/readproc.h>
+#include <dirent.h>
 #include <stdarg.h>
 #include <stdlib.h>
 #include <string.h>
@@ -262,6 +262,62 @@ int __set_sched_attr(int pid, struct sched_attr *attr)
 
 	return 0;
 }
+
+/*
+ * procfs_is_workload_pid - check if a procfs entry contains a workload_prefix* comm
+ *
+ * Check if the procfs entry is a directory of a process, and then check if the
+ * process has a comm with the prefix set in char *workload_prefix. As the
+ * current users of this function only check for kernel threads, there is no
+ * need to check for the threads for the process.
+ *
+ * Return: True if the proc_entry contains a comm file with workload_prefix*.
+ * Otherwise returns false.
+ */
+static int procfs_is_workload_pid(const char *workload_prefix, struct dirent *proc_entry)
+{
+	char comm_path[MAX_PATH], comm[MAX_PATH];
+	int comm_fd, retval;
+	char *t_name;
+
+	if (proc_entry->d_type != DT_DIR)
+		return 0;
+
+	if (*proc_entry->d_name == '.')
+		return 0;
+
+	/* check if the string is a pid */
+	for (t_name = proc_entry->d_name; t_name; t_name++) {
+		if (!isdigit(*t_name))
+			break;
+	}
+
+	if (*t_name != '\0')
+		return 0;
+
+	snprintf(comm_path, MAX_PATH, "/proc/%s/comm", proc_entry->d_name);
+	comm_fd = open(comm_path, O_RDONLY);
+	if (comm_fd < 0)
+		return 0;
+
+	memset(comm, 0, MAX_PATH);
+	retval = read(comm_fd, comm, MAX_PATH);
+
+	close(comm_fd);
+
+	if (retval <= 0)
+		return 0;
+
+	retval = !strncmp(workload_prefix, comm, strlen(workload_prefix));
+	if (!retval)
+		return 0;
+
+	/* comm already have \n */
+	debug_msg("Found workload pid:%s comm:%s", proc_entry->d_name, comm);
+
+	return 1;
+}
+
 /*
  * set_comm_sched_attr - set sched params to threads starting with char *comm
  *
@@ -272,33 +328,26 @@ int __set_sched_attr(int pid, struct sched_attr *attr)
  */
 int set_comm_sched_attr(const char *comm, struct sched_attr *attr)
 {
-	int flags = PROC_FILLCOM | PROC_FILLSTAT;
-	PROCTAB *ptp;
-	proc_t task;
+	struct dirent *proc_entry;
+	DIR *procfs;
 	int retval;
 
-	ptp = openproc(flags);
-	if (!ptp) {
-		err_msg("error openproc()\n");
-		return -ENOENT;
-	}
+	procfs = opendir("/proc");
 
-	memset(&task, 0, sizeof(task));
+	while ((proc_entry = readdir(procfs))) {
 
-	while (readproc(ptp, &task)) {
-		retval = strncmp(comm, task.cmd, strlen(comm));
-		if (retval)
+		retval = procfs_is_workload_pid(comm, proc_entry);
+		if (!retval)
 			continue;
-		retval = __set_sched_attr(task.tid, attr);
+
+		/* procfs_is_workload_pid confirmed it is a pid */
+		retval = __set_sched_attr(atoi(proc_entry->d_name), attr);
 		if (retval)
 			goto out_err;
 	}
-
-	closeproc(ptp);
 	return 0;
 
 out_err:
-	closeproc(ptp);
 	return 1;
 }
 
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index fa08e374870a..4959a3e2c0d5 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -6,6 +6,7 @@
  * '18446744073709551615\0'
  */
 #define BUFF_U64_STR_SIZE	24
+#define MAX_PATH		1024
 
 #define container_of(ptr, type, member)({			\
 	const typeof(((type *)0)->member) *__mptr = (ptr);	\
-- 
2.35.1

