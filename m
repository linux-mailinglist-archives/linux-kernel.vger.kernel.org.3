Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57973465332
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351629AbhLAQsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:48:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:26296 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351622AbhLAQr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:47:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216512582"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="216512582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:31 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="512784042"
Received: from razaahme-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.36.3])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:29 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [RFCv3 7/7] samples: hid: convert USI sample to use unix socket for comms
Date:   Wed,  1 Dec 2021 18:43:01 +0200
Message-Id: <20211201164301.44653-8-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201164301.44653-1-tero.kristo@linux.intel.com>
References: <20211201164301.44653-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert USI hid sample userspace interface from using unix fifo to unix
socket. This allows sending results back via the communication channel
also.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 samples/bpf/hid_usi_user.c | 73 ++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 23 deletions(-)

diff --git a/samples/bpf/hid_usi_user.c b/samples/bpf/hid_usi_user.c
index b05a3f768835..5bf5ebc21a30 100644
--- a/samples/bpf/hid_usi_user.c
+++ b/samples/bpf/hid_usi_user.c
@@ -14,6 +14,8 @@
 #include <libgen.h>
 #include <sys/resource.h>
 #include <getopt.h>
+#include <sys/socket.h>
+#include <sys/un.h>
 
 #include "bpf_util.h"
 #include <bpf/bpf.h>
@@ -24,15 +26,15 @@
 #include "hid_usi.h"
 
 static char *sysfs_path;
-static char *fifoname = "/tmp/usi";
+static char *sockname = "/tmp/usi";
 static int sysfs_fd;
-static int fifo_fd;
+static int sock_fd;
 static int prog_count;
 static int cache, wr_cache;
 
 static const struct option long_options[] = {
 	{ "help", no_argument, NULL, 'h' },
-	{ "fifo", required_argument, NULL, 'f' },
+	{ "sock", required_argument, NULL, 's' },
 };
 
 struct prog {
@@ -53,15 +55,15 @@ static void int_exit(int sig)
 	}
 
 	close(sysfs_fd);
-	close(fifo_fd);
-	remove(fifoname);
+	close(sock_fd);
+	remove(sockname);
 	exit(0);
 }
 
 static void usage(const char *prog)
 {
 	fprintf(stderr,
-		"usage: %s [-f <fifoname>] /dev/HIDRAW\n\n",
+		"usage: %s [-s <sockname>] /dev/HIDRAW\n\n",
 		prog);
 }
 
@@ -84,15 +86,17 @@ static int write_value(const char *param, int value)
 
 	printf("%s: param=%s (%d), value=%d\n", __func__, param, idx, value);
 	err = bpf_map_update_elem(wr_cache, &idx, &value, BPF_ANY);
-	if (err)
+	if (err) {
 		printf("Update failed for %d, err=%d\n", idx, err);
+		return err;
+	}
 
 	return 0;
 }
 
 static int read_value(const char *param)
 {
-	int value;
+	int value = -ENOENT;
 	int idx = param_to_idx(param);
 
 	printf("%s: param=%s (%d)\n", __func__, param, idx);
@@ -102,7 +106,7 @@ static int read_value(const char *param)
 	else
 		printf("Value for %d = %d\n", idx, value);
 
-	return 0;
+	return value;
 }
 
 static int attach_progs(int argc, char **argv)
@@ -118,6 +122,9 @@ static int attach_progs(int argc, char **argv)
 	char op[8];
 	int value;
 	int m, n;
+	struct sockaddr_un addr;
+	struct sockaddr_un from;
+	socklen_t from_len = sizeof(from);
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
@@ -177,28 +184,48 @@ static int attach_progs(int argc, char **argv)
 		goto cleanup;
 	}
 
-	mkfifo(fifoname, 0666);
+	sock_fd = socket(PF_UNIX, SOCK_DGRAM, 0);
+	if (sock_fd < 0) {
+		perror("socket open error.\n");
+		err = sock_fd;
+		goto cleanup;
+	}
+
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, sockname);
+	unlink(sockname);
 
-	fifo_fd = open(fifoname, O_RDWR);
-	if (fifo_fd < 0) {
-		perror("Fifo open error.\n");
-		err = fifo_fd;
+	if (bind(sock_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("bind");
 		goto cleanup;
 	}
 
 	while (1) {
-		n = read(fifo_fd, buf, BUFSIZ);
+		n = recvfrom(sock_fd, buf, BUFSIZ, 0, (struct sockaddr *)&from,
+			     &from_len);
 		if (n < 0)
 			break;
 		buf[n] = 0;
 
 		printf("%s: received '%s'\n", __func__, buf);
 
+		printf("%s: from_len=%d, from=%s\n", __func__, from_len,
+		       from.sun_path);
+
 		m = sscanf(buf, "%16s %8s %d", param, op, &value);
-		if (m == 2 && strcmp(op, "get") == 0)
-			read_value(param);
-		else if (m == 3 && strcmp(op, "set") == 0)
-			write_value(param, value);
+		if (m == 2 && strcmp(op, "get") == 0) {
+			value = read_value(param);
+			sprintf(buf, "%s: %d\n", param, value);
+			printf("%s: sending '%s'\n", __func__, buf);
+			sendto(sock_fd, buf, strlen(buf) + 1, 0,
+			       (struct sockaddr *)&from, from_len);
+		} else if (m == 3 && strcmp(op, "set") == 0) {
+			err = write_value(param, value);
+			sprintf(buf, "%s: %d, err=%d\n", param, value, err);
+			printf("%s: sending '%s'\n", __func__, buf);
+			sendto(sock_fd, buf, strlen(buf) + 1, 0,
+			       (struct sockaddr *)&from, from_len);
+		}
 	}
 
 	return 0;
@@ -217,11 +244,11 @@ int main(int argc, char **argv)
 {
 	int opt;
 
-	while ((opt = getopt_long(argc, argv, "f:", long_options,
+	while ((opt = getopt_long(argc, argv, "s:", long_options,
 				  NULL)) != -1) {
 		switch (opt) {
-		case 'f':
-			fifoname = optarg;
+		case 's':
+			sockname = optarg;
 			break;
 		default:
 			usage(basename(argv[0]));
@@ -240,7 +267,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	printf("fifoname: %s\n", fifoname);
+	printf("sockname: %s\n", sockname);
 	printf("sysfs_path: %s\n", sysfs_path);
 
 	return attach_progs(argc, argv);
-- 
2.25.1

