Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED74CE860
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 04:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiCFDIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 22:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiCFDIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 22:08:09 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E337560F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 19:07:18 -0800 (PST)
X-QQ-mid: bizesmtp72t1646536023t06jirgl
Received: from leo.localdomain ( [103.144.149.54])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Mar 2022 11:06:55 +0800 (CST)
X-QQ-SSF: 0140000000800050C000B00A0000000
X-QQ-FEAT: dpyQmELDBxGqV5B59vM7ltXHZbbWXLEL2Tlqn0+ubnjyBMsgjC4hM/5EvnuNy
        woo/Xw3BO+aEy6/v40H6sUEN3TZ3qlO9zm2ioBEczcR7Z2AnSt4KKVED6P/HkFPN12SM8N8
        ULNoyQZZs7dUg2eKqiYA839BxBsFlDWmxaGPDtEHFub4T4gMYQmd3xkJjg8jh46WANZLufr
        vM1kDv32DtQaiOuLtZyh3k4I0iUK5CKIVycmPZ9YfFyP7bfiWbmg+lnyJJ71jjvv+rt9mE6
        sF0peC1ZVZ5AwhhCH9zDnmx9VgiwY61JHyW1KKW7t1Y7wquuaoXDp0nnavnmQtR29oPn3Y0
        ORjqtCvwuN87kbJnxm4/pHj68cHDSgxniKGh7Dt
X-QQ-GoodBg: 2
From:   Jiajian Ye <yejiajian2018@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     sfr@canb.auug.org.au, seanga2@gmail.com,
        zhaochongxi2019@email.szu.edu.cn, caoyixuan2019@email.szu.edu.cn,
        hanshenghong2019@email.szu.edu.cn, linux-kernel@vger.kernel.org,
        zhangyinan2019@email.szu.edu.cn, weizhenliang@huawei.com,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>
Subject: [PATCH 2/2] tools/vm/page_owner_sort: support for sorting by task command name
Date:   Sun,  6 Mar 2022 11:06:40 +0800
Message-Id: <20220306030640.43054-2-yejiajian2018@email.szu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220306030640.43054-1-yejiajian2018@email.szu.edu.cn>
References: <20220306030640.43054-1-yejiajian2018@email.szu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When viewing page owner information, we may also need to the block
to be sorted by task command name. Therefore, the following adjustments
are made:

1. Add a member variable to record task command name of block.

2. Add a new -n option to sort the information of blocks by task command
   name.

3. Add -n option explanation in the document.

Signed-off-by: Jiajian Ye <yejiajian2018@email.szu.edu.cn>
---
 Documentation/vm/page_owner.rst |  1 +
 tools/vm/page_owner_sort.c      | 35 ++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 941543a797fe..d658436a5e09 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -117,6 +117,7 @@ Usage
 		-m		Sort by total memory.
 		-p		Sort by pid.
 		-P		Sort by tgid.
+		-n		Sort by task command name.
 		-r		Sort by memory release time.
 		-s		Sort by stack trace.
 		-t		Sort by times (default).
diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index b8d2867b5b18..e508abd8f665 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -24,6 +24,7 @@
 
 struct block_list {
 	char *txt;
+	char *comm; // task command name
 	char *stacktrace;
 	__u64 ts_nsec;
 	__u64 free_ts_nsec;
@@ -37,6 +38,7 @@ struct block_list {
 static regex_t order_pattern;
 static regex_t pid_pattern;
 static regex_t tgid_pattern;
+static regex_t comm_pattern;
 static regex_t ts_nsec_pattern;
 static regex_t free_ts_nsec_pattern;
 static struct block_list *list;
@@ -102,6 +104,13 @@ static int compare_tgid(const void *p1, const void *p2)
 	return l1->tgid - l2->tgid;
 }
 
+static int compare_comm(const void *p1, const void *p2)
+{
+	const struct block_list *l1 = p1, *l2 = p2;
+
+	return strcmp(l1->comm, l2->comm);
+}
+
 static int compare_ts(const void *p1, const void *p2)
 {
 	const struct block_list *l1 = p1, *l2 = p2;
@@ -145,6 +154,7 @@ static void check_regcomp(regex_t *pattern, const char *regex)
 }
 
 # define FIELD_BUFF 25
+# define TASK_COMM_LEN 16
 
 static int get_page_num(char *buf)
 {
@@ -233,6 +243,22 @@ static __u64 get_free_ts_nsec(char *buf)
 	return free_ts_nsec;
 }
 
+static char *get_comm(char *buf)
+{
+	char *comm_str = malloc(TASK_COMM_LEN);
+
+	memset(comm_str, 0, TASK_COMM_LEN);
+
+	search_pattern(&comm_pattern, comm_str, buf);
+	errno = 0;
+	if (errno != 0) {
+		printf("wrong comm in follow buf:\n%s\n", buf);
+		return NULL;
+	}
+
+	return comm_str;
+}
+
 static void add_list(char *buf, int len)
 {
 	if (list_size != 0 &&
@@ -266,6 +292,7 @@ static void add_list(char *buf, int len)
 		list[list_size].stacktrace++;
 	list[list_size].pid = get_pid(buf);
 	list[list_size].tgid = get_tgid(buf);
+	list[list_size].comm = get_comm(buf);
 	list[list_size].ts_nsec = get_ts_nsec(buf);
 	list_size++;
 	if (list_size % 1000 == 0) {
@@ -284,6 +311,7 @@ static void usage(void)
 		"-t	Sort by times (default).\n"
 		"-p	Sort by pid.\n"
 		"-P	Sort by tgid.\n"
+		"-n	Sort by task command name.\n"
 		"-a	Sort by memory allocate time.\n"
 		"-r	Sort by memory release time.\n"
 		"-c	Cull by comparing stacktrace instead of total block.\n"
@@ -300,7 +328,7 @@ int main(int argc, char **argv)
 	struct stat st;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "acfmprstP")) != -1)
+	while ((opt = getopt(argc, argv, "acfmnprstP")) != -1)
 		switch (opt) {
 		case 'a':
 			cmp = compare_ts;
@@ -329,6 +357,9 @@ int main(int argc, char **argv)
 		case 'P':
 			cmp = compare_tgid;
 			break;
+		case 'n':
+			cmp = compare_comm;
+			break;
 		default:
 			usage();
 			exit(1);
@@ -350,6 +381,7 @@ int main(int argc, char **argv)
 	check_regcomp(&order_pattern, "order\\s*([0-9]*),");
 	check_regcomp(&pid_pattern, "pid\\s*([0-9]*),");
 	check_regcomp(&tgid_pattern, "tgid\\s*([0-9]*) ");
+	check_regcomp(&comm_pattern, "tgid\\s*[0-9]*\\s*\\((.*)\\),\\s*ts");
 	check_regcomp(&ts_nsec_pattern, "ts\\s*([0-9]*)\\s*ns,");
 	check_regcomp(&free_ts_nsec_pattern, "free_ts\\s*([0-9]*)\\s*ns");
 	fstat(fileno(fin), &st);
@@ -408,6 +440,7 @@ int main(int argc, char **argv)
 	regfree(&order_pattern);
 	regfree(&pid_pattern);
 	regfree(&tgid_pattern);
+	regfree(&comm_pattern);
 	regfree(&ts_nsec_pattern);
 	regfree(&free_ts_nsec_pattern);
 	return 0;
-- 
2.25.1



