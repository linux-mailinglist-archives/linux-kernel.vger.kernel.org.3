Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC16489F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbiAJSuG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 13:50:06 -0500
Received: from mxchg03.rrz.uni-hamburg.de ([134.100.38.113]:60695 "EHLO
        mxchg03.rrz.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242332AbiAJSuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:50:05 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jan 2022 13:50:04 EST
X-Virus-Scanned: by University of Hamburg ( RRZ / mgw05.rrz.uni-hamburg.de )
Received: from exchange.uni-hamburg.de (UN-EX-MR08.uni-hamburg.de [134.100.84.75])
        by mxchg03.rrz.uni-hamburg.de (Postfix) with ESMTPS;
        Mon, 10 Jan 2022 19:44:22 +0100 (CET)
Received: from plasteblaster (89.244.206.250) by UN-EX-MR08.uni-hamburg.de
 (134.100.84.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 19:44:22 +0100
Date:   Mon, 10 Jan 2022 19:44:21 +0100
From:   "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
To:     Balbir Singh <bsingharora@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [RFC] [PATCH 2/2] taskstats: introduce version 12 with exe file
 info
Message-ID: <20220110194421.03fb558b@plasteblaster>
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg
X-Mailer: Claws Mail (x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [89.244.206.250]
X-ClientProxiedBy: UN-EX-MR05.uni-hamburg.de (134.100.84.72) To
 UN-EX-MR08.uni-hamburg.de (134.100.84.75)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 4f5e7d46af70ed4b05261c6c097f7dd1c8a2268d Mon Sep 17 00:00:00 2001
From: "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Date: Mon, 10 Jan 2022 18:23:38 +0100
Subject: [PATCH 2/2] taskstats: introduce version 12 with exe file info

This adds fields to the taskstats struct that give device and
inode info for the executable file associated with the process
as a safer way to get that than polling /proc/$pid/exe before
a process ends.

The getdelay example program is accompanied by a variant that
just prints a stream of exiting tasks with the added info
(as well es the recently added tgid field to identify multithreaded
processes).

The idea is to be able to collect global statistics about use of certain
programs installed on a system by associating process/task stats with
an absolute executable path. The command field is unsuitable as it
does not distinguish between /foo/bar/v1.2.3/bin/bar_exe and
/foo/bar/v2.3.4/bin/bar_exe and is generally rather arbitrary.

I would like to just get the path communicated to userspace,
but I presume the growth of the struct by PATH_MAX bytes would
not be welcomed.

This version of the patch returns correct device IDs by copying
what fs/stat.c does, despite the claim that the s_dev member of
struct super_block is not supposed to be a search index and not
a device ID (include/linux/fs.h).

I left a number of comments and humbly ask for confirmation of
the approach or any treatment for my doubts. I am running variants
of this patch on kernel 4.14.x since several years now on a
400-node cluster, but I am mostly cargo-coding in kernel space
and might have gotten things horribly wrong.

I am open to alternatives for identifying the program executable
belonging to certain tasks, but imagine that communicating
the inode is the cheapest way for the kernel. The remaining
style warnings of the added procacct.c example program are
inherited from getdelays.c. I hope they don't distract from the
core question.

Signed-off-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
---
 include/uapi/linux/taskstats.h |  17 +-
 kernel/taskstats.c             |  20 ++
 tools/accounting/.gitignore    |   1 +
 tools/accounting/Makefile      |   2 +-
 tools/accounting/procacct.c    | 418 +++++++++++++++++++++++++++++++++
 5 files changed, 456 insertions(+), 2 deletions(-)
 create mode 100644 tools/accounting/procacct.c

diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index 9248dc6bcb4a..891d092512ff 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	11
+#define TASKSTATS_VERSION	12
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -174,6 +174,21 @@ struct taskstats {
 	__u64	ac_btime64;		/* 64-bit begin time */
 	/* v11: thread group ID to identify process vs. (non-leader) thread */
 	__u32   ac_tgid;
+	/* v12: lightweight information to identify process binary files
+	 * I would prefer the fully resolved path, but presume that would need
+	 * growing of the struct by PATH_MAX bytes. A hash sum might be an
+	 * alternative, but expensive again. Suggestions welcome. My client
+	 * application maps device and inode to path in userspace, having
+	 * possible failure modes (changes in mounts, filesystem operations),
+	 * in mind.
+	 *
+	 * I kept both fields at 64 bits. Device ID usually has only 16 bits
+	 * relevant for userspace resolving it to MAJOR and MINOR. Limiting
+	 * to that preferred? Or store MAJOR:MINOR as two values here?
+	 * Both values are zero if no executable file is present.
+	 */
+	__u64   ac_exe_dev;     /* program binary device ID */
+	__u64   ac_exe_inode;   /* program binary inode number */
 };
 
 
diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 2b4898b4752e..c06e31db9a68 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -152,6 +152,23 @@ static void send_cpu_listeners(struct sk_buff *skb,
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
@@ -174,6 +191,9 @@ static void fill_stats(struct user_namespace *user_ns,
 
 	/* fill in extended acct fields */
 	xacct_add_tsk(stats, tsk);
+
+	/* add executable info */
+	exe_add_tsk(stats, tsk);
 }
 
 static int fill_stats_for_pid(pid_t pid, struct taskstats *stats)
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
index 000000000000..9e2d54a62d8d
--- /dev/null
+++ b/tools/accounting/procacct.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0
+/* procacct.c
+ *
+ * Demonstrator of fetching resource data on task exit, as a way
+ * to accumulate accurate program resource usage statistics, without
+ * prior identification of the programs. For that, the fields for
+ * device and inode of the program executable binary file are also
+ * extracted in addition to the command string.
+ *
+ * The TGID together with the PID allows identification of additional
+ * threads vs. single-threaded tasks and helps summing resource usage
+ * (e.g. walltime) correctly.
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
+	printf(
+		"pid=%lu uid=%lu wall=%llu cpu=%llu vmpeak=%llu rsspeak=%llu"
+		" dev=%llu:%llu inode=%llu comm=%s\n"
+	,	(unsigned long)t->ac_pid
+	,	(unsigned long)(t->version >= 11 ? t->ac_tgid : 0)
+	,	(unsigned long)t->ac_uid
+	,	(unsigned long long)t->ac_etime
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
2.29.2



-- 
Dr. Thomas Orgis
HPC @ Universität Hamburg
