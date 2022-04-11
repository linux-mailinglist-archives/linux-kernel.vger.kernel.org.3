Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D854FB931
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbiDKKQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244848AbiDKKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:16:26 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB7D64
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:14:09 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 11 Apr
 2022 18:14:07 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 11 Apr
 2022 18:14:07 +0800
From:   Haowen Bai <baihaowen@meizu.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools/vm/page_owner: support debug log to avoid huge log print
Date:   Mon, 11 Apr 2022 18:14:04 +0800
Message-ID: <1649672045-5295-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As normal usage, tool will print huge parser log and spend a lot of
time printing, so it would be preferable add "-d" debug control to avoid
this problem.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 tools/vm/page_owner_sort.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index beca990707fb..a32e446e5bb2 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -87,6 +87,7 @@ static int list_size;
 static int max_size;
 static int cull;
 static int filter;
+static bool debug_on;
 
 int read_block(char *buf, int buf_size, FILE *fin)
 {
@@ -211,7 +212,8 @@ static int search_pattern(regex_t *pattern, char *pattern_str, char *buf)
 
 	err = regexec(pattern, buf, 2, pmatch, REG_NOTBOL);
 	if (err != 0 || pmatch[1].rm_so == -1) {
-		fprintf(stderr, "no matching pattern in %s\n", buf);
+		if (debug_on)
+			fprintf(stderr, "no matching pattern in %s\n", buf);
 		return -1;
 	}
 	val_len = pmatch[1].rm_eo - pmatch[1].rm_so;
@@ -276,7 +278,8 @@ static int get_page_num(char *buf)
 	errno = 0;
 	order_val = strtol(order_str, &endptr, 10);
 	if (order_val > 64 || errno != 0 || endptr == order_str || *endptr != '\0') {
-		fprintf(stderr, "wrong order in follow buf:\n%s\n", buf);
+		if (debug_on)
+			fprintf(stderr, "wrong order in follow buf:\n%s\n", buf);
 		return 0;
 	}
 
@@ -293,7 +296,8 @@ static pid_t get_pid(char *buf)
 	errno = 0;
 	pid = strtol(pid_str, &endptr, 10);
 	if (errno != 0 || endptr == pid_str || *endptr != '\0') {
-		fprintf(stderr, "wrong/invalid pid in follow buf:\n%s\n", buf);
+		if (debug_on)
+			fprintf(stderr, "wrong/invalid pid in follow buf:\n%s\n", buf);
 		return -1;
 	}
 
@@ -311,7 +315,8 @@ static pid_t get_tgid(char *buf)
 	errno = 0;
 	tgid = strtol(tgid_str, &endptr, 10);
 	if (errno != 0 || endptr == tgid_str || *endptr != '\0') {
-		fprintf(stderr, "wrong/invalid tgid in follow buf:\n%s\n", buf);
+		if (debug_on)
+			fprintf(stderr, "wrong/invalid tgid in follow buf:\n%s\n", buf);
 		return -1;
 	}
 
@@ -329,7 +334,8 @@ static __u64 get_ts_nsec(char *buf)
 	errno = 0;
 	ts_nsec = strtoull(ts_nsec_str, &endptr, 10);
 	if (errno != 0 || endptr == ts_nsec_str || *endptr != '\0') {
-		fprintf(stderr, "wrong ts_nsec in follow buf:\n%s\n", buf);
+		if (debug_on)
+			fprintf(stderr, "wrong ts_nsec in follow buf:\n%s\n", buf);
 		return -1;
 	}
 
@@ -346,7 +352,8 @@ static __u64 get_free_ts_nsec(char *buf)
 	errno = 0;
 	free_ts_nsec = strtoull(free_ts_nsec_str, &endptr, 10);
 	if (errno != 0 || endptr == free_ts_nsec_str || *endptr != '\0') {
-		fprintf(stderr, "wrong free_ts_nsec in follow buf:\n%s\n", buf);
+		if (debug_on)
+			fprintf(stderr, "wrong free_ts_nsec in follow buf:\n%s\n", buf);
 		return -1;
 	}
 
@@ -362,7 +369,8 @@ static char *get_comm(char *buf)
 	search_pattern(&comm_pattern, comm_str, buf);
 	errno = 0;
 	if (errno != 0) {
-		fprintf(stderr, "wrong comm in follow buf:\n%s\n", buf);
+		if (debug_on)
+			fprintf(stderr, "wrong comm in follow buf:\n%s\n", buf);
 		return NULL;
 	}
 
@@ -594,6 +602,7 @@ static void usage(void)
 		"-a\t\tSort by memory allocate time.\n"
 		"-r\t\tSort by memory release time.\n"
 		"-f\t\tFilter out the information of blocks whose memory has been released.\n"
+		"-d\t\tPrint debug information.\n"
 		"--pid <pidlist>\tSelect by pid. This selects the information of blocks whose process ID numbers appear in <pidlist>.\n"
 		"--tgid <tgidlist>\tSelect by tgid. This selects the information of blocks whose Thread Group ID numbers appear in <tgidlist>.\n"
 		"--name <cmdlist>\n\t\tSelect by command name. This selects the information of blocks whose command name appears in <cmdlist>.\n"
@@ -618,11 +627,14 @@ int main(int argc, char **argv)
 		{ 0, 0, 0, 0},
 	};
 
-	while ((opt = getopt_long(argc, argv, "afmnprstP", longopts, NULL)) != -1)
+	while ((opt = getopt_long(argc, argv, "adfmnprstP", longopts, NULL)) != -1)
 		switch (opt) {
 		case 'a':
 			set_single_cmp(compare_ts, SORT_ASC);
 			break;
+		case 'd':
+			debug_on = true;
+			break;
 		case 'f':
 			filter = filter | FILTER_UNRELEASE;
 			break;
-- 
2.7.4

