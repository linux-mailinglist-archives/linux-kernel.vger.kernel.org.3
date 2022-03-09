Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F04D319E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiCIPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiCIPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:19:14 -0500
Received: from mxchg04.rrz.uni-hamburg.de (mxchg04.rrz.uni-hamburg.de [134.100.38.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D6449FA9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:18:13 -0800 (PST)
X-Virus-Scanned: by University of Hamburg ( RRZ / mgw04.rrz.uni-hamburg.de )
Received: from exchange.uni-hamburg.de (UN-EX-MR08.uni-hamburg.de [134.100.84.75])
        by mxchg04.rrz.uni-hamburg.de (Postfix) with ESMTPS;
        Wed,  9 Mar 2022 16:18:12 +0100 (CET)
Received: from cortex.rrz.uni-hamburg.de (134.100.3.33) by
 UN-EX-MR08.uni-hamburg.de (134.100.84.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 9 Mar 2022 16:18:11 +0100
Date:   Wed, 9 Mar 2022 16:16:37 +0100
From:   "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
To:     Balbir Singh <bsingharora@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ismael Luceno <ismael@iodev.co.uk>, <hannes@cmpxchg.org>
Subject: [PATCH RESEND] taskstats: version 12 with thread group and exe info
Message-ID: <20220309161637.23f082d3@cortex.rrz.uni-hamburg.de>
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [134.100.3.33]
X-ClientProxiedBy: UN-EX-MR08.uni-hamburg.de (134.100.84.75) To
 UN-EX-MR08.uni-hamburg.de (134.100.84.75)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task exit struct needs some cruciual information to be able
to provide an enhanced version of process and thread accounting. This
change provides:

1. ac_tgid in additon to ac_pid
2. thread group execution walltime in ac_tgetime
3. flag AGROUP in ac_flag to indicate the last task
   in a thread group / process
4. device ID and inode of task's /proc/self/exe in
   ac_exe_dev and ac_exe_inode
5. tools/accounting/procacct as demonstrator

When a task exits, taskstats are reported to userspace including the
task's pid and ppid, but without the id of the thread group this task
is part of. Without the tgid, the stats of single tasks cannot be
correlated to each other as a thread group (process).

The taskstats documentation suggests that on process exit a data set
consisting of accumulated stats for the whole group is produced. But
such an additional set of stats is only produced for actually
multithreaded processes, not groups that had only one thread, and
also those stats only contain data about delay accounting and not
the more basic information about CPU and memory resource usage. Adding
the AGROP flag to be set when the last task of a group exited enables
determination of process end also for single-threaded processes.

My applicaton basically does enhanced process accounting with
summed cputime, biggest maxrss, tasks per process. The data is not
available with the traditional BSD process accounting (which is not
designed to be extensible) and the taskstats interface allows more
efficient on-the-fly grouping and summing of the stats, anyway,
without intermediate disk writes.

Furthermore, I do carry statistics on which exact program binary
is used how often with associated resources, getting a picture
on how important which parts of a collection of installed scientific
software in different versions are, and how well they put load on the
machine. This is enabled by providing information on /proc/self/exe
for each task. I assume the two 64-bit fields for device ID and
inode are more appropriate than the possibly large resolved path
to keep the data volume down.

Add the tgid to the stats to complete task identification,
the flag AGROUP to mark the last task of a group, the group wallclock
time, and inode-based identification of the associated executable file.

Add tools/accounting/procacct.c as a simplified fork of getdelays.c
to demonstrate process and thread accounting.

Base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5

Signed-off-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
Reviewed-by: Ismael Luceno <ismael@iodev.co.uk>
---
 include/uapi/linux/acct.h      |   3 +-
 include/uapi/linux/taskstats.h |  23 +-
 kernel/taskstats.c             |  23 ++
 kernel/tsacct.c                |  10 +-
 tools/accounting/.gitignore    |   1 +
 tools/accounting/Makefile      |   2 +-
 tools/accounting/procacct.c    | 421 +++++++++++++++++++++++++++++++++
 7 files changed, 476 insertions(+), 7 deletions(-)
 create mode 100644 tools/accounting/procacct.c

diff --git a/include/uapi/linux/acct.h b/include/uapi/linux/acct.h
index 985b89068591..0e591152aa8a 100644
--- a/include/uapi/linux/acct.h
+++ b/include/uapi/linux/acct.h
@@ -103,12 +103,13 @@ struct acct_v3
 /*
  *  accounting flags
  */
-				/* bit set when the process ... */
+				/* bit set when the process/task ... */
 #define AFORK		0x01	/* ... executed fork, but did not exec */
 #define ASU		0x02	/* ... used super-user privileges */
 #define ACOMPAT		0x04	/* ... used compatibility mode (VAX only not used) */
 #define ACORE		0x08	/* ... dumped core */
 #define AXSIG		0x10	/* ... was killed by a signal */
+#define AGROUP		0x20	/* ... was the last task of the process (task group) */
 
 #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
 #define ACCT_BYTEORDER	0x80	/* accounting file is big endian */
diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index 12327d32378f..aaddbca7fbb8 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	11
+#define TASKSTATS_VERSION	12
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -48,7 +48,8 @@ struct taskstats {
 	__u32	ac_exitcode;		/* Exit status */
 
 	/* The accounting flags of a task as defined in <linux/acct.h>
-	 * Defined values are AFORK, ASU, ACOMPAT, ACORE, and AXSIG.
+	 * Defined values are AFORK, ASU, ACOMPAT, ACORE, AXSIG, and AGROUP.
+	 * (AGROUP since version 11).
 	 */
 	__u8	ac_flag;		/* Record flags */
 	__u8	ac_nice;		/* task_nice */
@@ -173,9 +174,25 @@ struct taskstats {
 	/* v10: 64-bit btime to avoid overflow */
 	__u64	ac_btime64;		/* 64-bit begin time */
 
-	/* Delay waiting for memory compact */
+	/* v11: Delay waiting for memory compact */
 	__u64	compact_count;
 	__u64	compact_delay_total;
+
+	/* v12 begin */
+	__u32   ac_tgid;	/* thread group ID */
+	/* Thread group walltime up to now. This is total process walltime if
+	 * AGROUP flag is set. */
+	__u64	ac_tgetime __attribute__((aligned(8)));
+	/* Lightweight information to identify process binary files.
+	 * This leaves userspace to match this to a file system path, using
+	 * MAJOR() and MINOR() macros to identify a device and mount point,
+	 * the inode to identify the executable file. This is /proc/self/exe
+	 * at the end, so matching the most recent exec(). Values are zero
+	 * for kernel threads.
+	 */
+	__u64   ac_exe_dev;     /* program binary device ID */
+	__u64   ac_exe_inode;   /* program binary inode number */
+	/* v12 end */
 };
 
 
diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 2b4898b4752e..55c532214ca3 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/taskstats_kern.h>
 #include <linux/tsacct_kern.h>
+#include <linux/acct.h>
 #include <linux/delayacct.h>
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
@@ -152,6 +153,23 @@ static void send_cpu_listeners(struct sk_buff *skb,
 	up_write(&listeners->sem);
 }
 
+static void exe_add_tsk(struct taskstats *stats, struct task_struct *tsk)
+{
+	/* No idea if I'm allowed to access that here, now. */
+	struct file *exe_file = get_task_exe_file(tsk);
+
+	if (exe_file) {
+		/* Following cp_new_stat64() in stat.c . */
+		stats->ac_exe_dev =
+			huge_encode_dev(exe_file->f_inode->i_sb->s_dev);
+		stats->ac_exe_inode = exe_file->f_inode->i_ino;
+		fput(exe_file);
+	} else {
+		stats->ac_exe_dev = 0;
+		stats->ac_exe_inode = 0;
+	}
+}
+
 static void fill_stats(struct user_namespace *user_ns,
 		       struct pid_namespace *pid_ns,
 		       struct task_struct *tsk, struct taskstats *stats)
@@ -174,6 +192,9 @@ static void fill_stats(struct user_namespace *user_ns,
 
 	/* fill in extended acct fields */
 	xacct_add_tsk(stats, tsk);
+
+	/* add executable info */
+	exe_add_tsk(stats, tsk);
 }
 
 static int fill_stats_for_pid(pid_t pid, struct taskstats *stats)
@@ -619,6 +640,8 @@ void taskstats_exit(struct task_struct *tsk, int group_dead)
 		goto err;
 
 	fill_stats(&init_user_ns, &init_pid_ns, tsk, stats);
+	if(group_dead)
+		stats->ac_flag |= AGROUP;
 
 	/*
 	 * Doesn't matter if tsk is the leader or the last group member leaving
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 1d261fbe367b..4252f0645b9e 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -23,15 +23,20 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 {
 	const struct cred *tcred;
 	u64 utime, stime, utimescaled, stimescaled;
-	u64 delta;
+	u64 now_ns, delta;
 	time64_t btime;
 
 	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
 
 	/* calculate task elapsed time in nsec */
-	delta = ktime_get_ns() - tsk->start_time;
+	now_ns = ktime_get_ns();
+	/* store whole group time first */
+	delta = now_ns - tsk->group_leader->start_time;
 	/* Convert to micro seconds */
 	do_div(delta, NSEC_PER_USEC);
+	stats->ac_tgetime = delta;
+	delta = now_ns - tsk->start_time;
+	do_div(delta, NSEC_PER_USEC);
 	stats->ac_etime = delta;
 	/* Convert to seconds for btime (note y2106 limit) */
 	btime = ktime_get_real_seconds() - div_u64(delta, USEC_PER_SEC);
@@ -51,6 +56,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	stats->ac_nice	 = task_nice(tsk);
 	stats->ac_sched	 = tsk->policy;
 	stats->ac_pid	 = task_pid_nr_ns(tsk, pid_ns);
+	stats->ac_tgid   = task_tgid_nr_ns(tsk, pid_ns);
 	rcu_read_lock();
 	tcred = __task_cred(tsk);
 	stats->ac_uid	 = from_kuid_munged(user_ns, tcred->uid);
diff --git a/tools/accounting/.gitignore b/tools/accounting/.gitignore
index c45fb4ed4309..522a690aaf3d 100644
--- a/tools/accounting/.gitignore
+++ b/tools/accounting/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 getdelays
+procacct
diff --git a/tools/accounting/Makefile b/tools/accounting/Makefile
index 03687f19cbb1..11def1ad046c 100644
--- a/tools/accounting/Makefile
+++ b/tools/accounting/Makefile
@@ -2,7 +2,7 @@
 CC := $(CROSS_COMPILE)gcc
 CFLAGS := -I../../usr/include
 
-PROGS := getdelays
+PROGS := getdelays procacct
 
 all: $(PROGS)
 
diff --git a/tools/accounting/procacct.c b/tools/accounting/procacct.c
new file mode 100644
index 000000000000..8390d1251bc9
--- /dev/null
+++ b/tools/accounting/procacct.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0
+/* procacct.c
+ *
+ * Demonstrator of fetching resource data on task exit, as a way
+ * to accumulate accurate program resource usage statistics, without
+ * prior identification of the programs. For that, the fields for
+ * device and inode of the program executable binary file are also
+ * extracted in addition to the command string.
+ *
+ * The TGID together with the PID and the AGROUP flag allow
+ * identification of threads in a process and single-threaded processes.
+ * The ac_tgetime field gives proper whole-process walltime.
+ *
+ * Written (changed) by Thomas Orgis, University of Hamburg in 2022
+ *
+ * This is a cheap derivation (inheriting the style) of getdelays.c:
+ *
+ * Utility to get per-pid and per-tgid delay accounting statistics
+ * Also illustrates usage of the taskstats interface
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2005
+ * Copyright (C) Balbir Singh, IBM Corp. 2006
+ * Copyright (c) Jay Lan, SGI. 2006
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <poll.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <signal.h>
+
+#include <linux/genetlink.h>
+#include <linux/acct.h>
+#include <linux/taskstats.h>
+#include <linux/kdev_t.h>
+
+/*
+ * Generic macros for dealing with netlink sockets. Might be duplicated
+ * elsewhere. It is recommended that commercial grade applications use
+ * libnl or libnetlink and use the interfaces provided by the library
+ */
+#define GENLMSG_DATA(glh)	((void *)(NLMSG_DATA(glh) + GENL_HDRLEN))
+#define GENLMSG_PAYLOAD(glh)	(NLMSG_PAYLOAD(glh, 0) - GENL_HDRLEN)
+#define NLA_DATA(na)		((void *)((char *)(na) + NLA_HDRLEN))
+#define NLA_PAYLOAD(len)	(len - NLA_HDRLEN)
+
+#define err(code, fmt, arg...)			\
+	do {					\
+		fprintf(stderr, fmt, ##arg);	\
+		exit(code);			\
+	} while (0)
+
+int done;
+int rcvbufsz;
+char name[100];
+int dbg;
+int print_delays;
+int print_io_accounting;
+int print_task_context_switch_counts;
+
+#define PRINTF(fmt, arg...) {			\
+		if (dbg) {			\
+			printf(fmt, ##arg);	\
+		}				\
+	}
+
+/* Maximum size of response requested or message sent */
+#define MAX_MSG_SIZE	1024
+/* Maximum number of cpus expected to be specified in a cpumask */
+#define MAX_CPUS	32
+
+struct msgtemplate {
+	struct nlmsghdr n;
+	struct genlmsghdr g;
+	char buf[MAX_MSG_SIZE];
+};
+
+char cpumask[100+6*MAX_CPUS];
+
+static void usage(void)
+{
+	fprintf(stderr, "procacct [-v] [-w logfile] [-r bufsize] [-m cpumask]\n");
+	fprintf(stderr, "  -v: debug on\n");
+}
+
+/*
+ * Create a raw netlink socket and bind
+ */
+static int create_nl_socket(int protocol)
+{
+	int fd;
+	struct sockaddr_nl local;
+
+	fd = socket(AF_NETLINK, SOCK_RAW, protocol);
+	if (fd < 0)
+		return -1;
+
+	if (rcvbufsz)
+		if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF,
+				&rcvbufsz, sizeof(rcvbufsz)) < 0) {
+			fprintf(stderr, "Unable to set socket rcv buf size to %d\n",
+				rcvbufsz);
+			goto error;
+		}
+
+	memset(&local, 0, sizeof(local));
+	local.nl_family = AF_NETLINK;
+
+	if (bind(fd, (struct sockaddr *) &local, sizeof(local)) < 0)
+		goto error;
+
+	return fd;
+error:
+	close(fd);
+	return -1;
+}
+
+
+static int send_cmd(int sd, __u16 nlmsg_type, __u32 nlmsg_pid,
+	     __u8 genl_cmd, __u16 nla_type,
+	     void *nla_data, int nla_len)
+{
+	struct nlattr *na;
+	struct sockaddr_nl nladdr;
+	int r, buflen;
+	char *buf;
+
+	struct msgtemplate msg;
+
+	msg.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	msg.n.nlmsg_type = nlmsg_type;
+	msg.n.nlmsg_flags = NLM_F_REQUEST;
+	msg.n.nlmsg_seq = 0;
+	msg.n.nlmsg_pid = nlmsg_pid;
+	msg.g.cmd = genl_cmd;
+	msg.g.version = 0x1;
+	na = (struct nlattr *) GENLMSG_DATA(&msg);
+	na->nla_type = nla_type;
+	na->nla_len = nla_len + 1 + NLA_HDRLEN;
+	memcpy(NLA_DATA(na), nla_data, nla_len);
+	msg.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
+
+	buf = (char *) &msg;
+	buflen = msg.n.nlmsg_len;
+	memset(&nladdr, 0, sizeof(nladdr));
+	nladdr.nl_family = AF_NETLINK;
+	while ((r = sendto(sd, buf, buflen, 0, (struct sockaddr *) &nladdr,
+			   sizeof(nladdr))) < buflen) {
+		if (r > 0) {
+			buf += r;
+			buflen -= r;
+		} else if (errno != EAGAIN)
+			return -1;
+	}
+	return 0;
+}
+
+
+/*
+ * Probe the controller in genetlink to find the family id
+ * for the TASKSTATS family
+ */
+static int get_family_id(int sd)
+{
+	struct {
+		struct nlmsghdr n;
+		struct genlmsghdr g;
+		char buf[256];
+	} ans;
+
+	int id = 0, rc;
+	struct nlattr *na;
+	int rep_len;
+
+	strcpy(name, TASKSTATS_GENL_NAME);
+	rc = send_cmd(sd, GENL_ID_CTRL, getpid(), CTRL_CMD_GETFAMILY,
+			CTRL_ATTR_FAMILY_NAME, (void *)name,
+			strlen(TASKSTATS_GENL_NAME)+1);
+	if (rc < 0)
+		return 0;	/* sendto() failure? */
+
+	rep_len = recv(sd, &ans, sizeof(ans), 0);
+	if (ans.n.nlmsg_type == NLMSG_ERROR ||
+	    (rep_len < 0) || !NLMSG_OK((&ans.n), rep_len))
+		return 0;
+
+	na = (struct nlattr *) GENLMSG_DATA(&ans);
+	na = (struct nlattr *) ((char *) na + NLA_ALIGN(na->nla_len));
+	if (na->nla_type == CTRL_ATTR_FAMILY_ID)
+		id = *(__u16 *) NLA_DATA(na);
+
+	return id;
+}
+
+#define average_ms(t, c) (t / 1000000ULL / (c ? c : 1))
+
+static void print_procacct(struct taskstats *t)
+{
+	printf( /* First letter: T is a mere thread, G the last in a group, U  unknown. */
+		"%c pid=%lu tgid=%lu uid=%lu wall=%llu gwall=%llu cpu=%llu vmpeak=%llu rsspeak=%llu"
+		" dev=%llu:%llu inode=%llu comm=%s\n"
+	,	t->version >= 12 ? (t->ac_flag & AGROUP ? 'P' : 'T') : '?'
+	,	(unsigned long)t->ac_pid
+	,	(unsigned long)(t->version >= 12 ? t->ac_tgid : 0)
+	,	(unsigned long)t->ac_uid
+	,	(unsigned long long)t->ac_etime
+	,	(unsigned long long)(t->version >= 12 ? t->ac_tgetime : 0)
+	,	(unsigned long long)(t->ac_utime+t->ac_stime)
+	,	(unsigned long long)t->hiwater_vm
+	,	(unsigned long long)t->hiwater_rss
+	,	(unsigned long)(t->version >= 12 ? MAJOR(t->ac_exe_dev) : 0)
+	,	(unsigned long)(t->version >= 12 ? MINOR(t->ac_exe_dev) : 0)
+	,	(unsigned long long)(t->version >= 12 ? t->ac_exe_inode : 0)
+	,	t->ac_comm
+	);
+}
+
+int main(int argc, char *argv[])
+{
+	int c, rc, rep_len, aggr_len, len2;
+	int cmd_type = TASKSTATS_CMD_ATTR_UNSPEC;
+	__u16 id;
+	__u32 mypid;
+
+	struct nlattr *na;
+	int nl_sd = -1;
+	int len = 0;
+	pid_t tid = 0;
+	pid_t rtid = 0;
+
+	int fd = 0;
+	int count = 0;
+	int write_file = 0;
+	int maskset = 0;
+	char *logfile = NULL;
+	int loop = 1;
+	int containerset = 0;
+	char *containerpath = NULL;
+	int cfd = 0;
+	int forking = 0;
+	sigset_t sigset;
+
+	struct msgtemplate msg;
+
+	while (!forking) {
+		c = getopt(argc, argv, "m:vr:");
+		if (c < 0)
+			break;
+
+		switch (c) {
+		case 'w':
+			logfile = strdup(optarg);
+			printf("write to file %s\n", logfile);
+			write_file = 1;
+			break;
+		case 'r':
+			rcvbufsz = atoi(optarg);
+			printf("receive buf size %d\n", rcvbufsz);
+			if (rcvbufsz < 0)
+				err(1, "Invalid rcv buf size\n");
+			break;
+		case 'm':
+			strncpy(cpumask, optarg, sizeof(cpumask));
+			cpumask[sizeof(cpumask) - 1] = '\0';
+			maskset = 1;
+			break;
+		case 'v':
+			printf("debug on\n");
+			dbg = 1;
+			break;
+		default:
+			usage();
+			exit(-1);
+		}
+	}
+	if (!maskset) {
+		maskset = 1;
+		strncpy(cpumask, "1", sizeof(cpumask));
+		cpumask[sizeof(cpumask) - 1] = '\0';
+	}
+	printf("cpumask %s maskset %d\n", cpumask, maskset);
+
+	if (write_file) {
+		fd = open(logfile, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+		if (fd == -1) {
+			perror("Cannot open output file\n");
+			exit(1);
+		}
+	}
+
+	nl_sd = create_nl_socket(NETLINK_GENERIC);
+	if (nl_sd < 0)
+		err(1, "error creating Netlink socket\n");
+
+	mypid = getpid();
+	id = get_family_id(nl_sd);
+	if (!id) {
+		fprintf(stderr, "Error getting family id, errno %d\n", errno);
+		goto err;
+	}
+	PRINTF("family id %d\n", id);
+
+	if (maskset) {
+		rc = send_cmd(nl_sd, id, mypid, TASKSTATS_CMD_GET,
+			      TASKSTATS_CMD_ATTR_REGISTER_CPUMASK,
+			      &cpumask, strlen(cpumask) + 1);
+		PRINTF("Sent register cpumask, retval %d\n", rc);
+		if (rc < 0) {
+			fprintf(stderr, "error sending register cpumask\n");
+			goto err;
+		}
+	}
+
+	do {
+		rep_len = recv(nl_sd, &msg, sizeof(msg), 0);
+		PRINTF("received %d bytes\n", rep_len);
+
+		if (rep_len < 0) {
+			fprintf(stderr, "nonfatal reply error: errno %d\n",
+				errno);
+			continue;
+		}
+		if (msg.n.nlmsg_type == NLMSG_ERROR ||
+		    !NLMSG_OK((&msg.n), rep_len)) {
+			struct nlmsgerr *err = NLMSG_DATA(&msg);
+
+			fprintf(stderr, "fatal reply error,  errno %d\n",
+				err->error);
+			goto done;
+		}
+
+		PRINTF("nlmsghdr size=%zu, nlmsg_len=%d, rep_len=%d\n",
+		       sizeof(struct nlmsghdr), msg.n.nlmsg_len, rep_len);
+
+
+		rep_len = GENLMSG_PAYLOAD(&msg.n);
+
+		na = (struct nlattr *) GENLMSG_DATA(&msg);
+		len = 0;
+		while (len < rep_len) {
+			len += NLA_ALIGN(na->nla_len);
+			int mother = na->nla_type;
+
+			PRINTF("mother=%i\n", mother);
+			switch (na->nla_type) {
+			case TASKSTATS_TYPE_AGGR_PID:
+				/* Fall through */
+			case TASKSTATS_TYPE_AGGR_TGID:
+				aggr_len = NLA_PAYLOAD(na->nla_len);
+				len2 = 0;
+				/* For nested attributes, na follows */
+				na = (struct nlattr *) NLA_DATA(na);
+				done = 0;
+				while (len2 < aggr_len) {
+					switch (na->nla_type) {
+					case TASKSTATS_TYPE_PID:
+						rtid = *(int *) NLA_DATA(na);
+						PRINTF("PID\t%d\n", rtid);
+						break;
+					case TASKSTATS_TYPE_TGID:
+						rtid = *(int *) NLA_DATA(na);
+						PRINTF("TGID\t%d\n", rtid);
+						break;
+					case TASKSTATS_TYPE_STATS:
+						count++;
+						if (mother == TASKSTATS_TYPE_AGGR_PID)
+							print_procacct((struct taskstats *) NLA_DATA(na));
+						if (fd) {
+							if (write(fd, NLA_DATA(na), na->nla_len) < 0)
+								err(1, "write error\n");
+						}
+						if (!loop)
+							goto done;
+						break;
+					case TASKSTATS_TYPE_NULL:
+						break;
+					default:
+						fprintf(stderr, "Unknown nested"
+							" nla_type %d\n",
+							na->nla_type);
+						break;
+					}
+					len2 += NLA_ALIGN(na->nla_len);
+					na = (struct nlattr *)((char *)na +
+							       NLA_ALIGN(na->nla_len));
+				}
+				break;
+
+			default:
+				fprintf(stderr, "Unexpected nla_type %d\n",
+					na->nla_type);
+			case TASKSTATS_TYPE_NULL:
+				break;
+			}
+			na = (struct nlattr *) (GENLMSG_DATA(&msg) + len);
+		}
+	} while (loop);
+done:
+	if (maskset) {
+		rc = send_cmd(nl_sd, id, mypid, TASKSTATS_CMD_GET,
+			      TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK,
+			      &cpumask, strlen(cpumask) + 1);
+		printf("Sent deregister mask, retval %d\n", rc);
+		if (rc < 0)
+			err(rc, "error sending deregister cpumask\n");
+	}
+err:
+	close(nl_sd);
+	if (fd)
+		close(fd);
+	if (cfd)
+		close(cfd);
+	return 0;
+}
-- 
2.35.0

