Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434CA4C8EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiCAPQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiCAPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:16:20 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA15692B2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:15:38 -0800 (PST)
X-QQ-mid: bizesmtp88t1646147715twcfrl2f
Received: from leo.localdomain (unknown [103.144.149.54])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Mar 2022 23:15:12 +0800 (CST)
X-QQ-SSF: 0140000000800040B000000A0000000
X-QQ-FEAT: lCTDServp3q2HPFfw4iGLRGq1tHHetsng/rg5T71b8BxjrqVGV8SHpV6Z69IP
        9MST2gC4gceBE8dZnDhlLZVwtNxZyHfM6qB1I71bs4HxLkZ7XEt9+9nvi+Fq0ynryAvkbeA
        wPTsMDsbb5u16WUmFSparDMmkvz5SkVkHmy9RUUNSL2W3UV2/HBpRFBk/rZIwQiQExzmSc4
        EnqgsUttY990k9mFiGjISDMjAhFOYOaXiOrGiHIf1aC4J0mn6PFRsMLDKHi4RnSgIrTyOcJ
        TtO+8u2kx9uIrGuMkuStJXPtLPfueFLU4kbbanTPEVJx3Gu+HNybcBZyXmCp65lVDmvyFzh
        Vgy8CqN1a0UXL8CAHvhmWnDewKh5BfAKrRglOE/
X-QQ-GoodBg: 2
From:   Jiajian Ye <yejiajian2018@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     sfr@canb.auug.org.au, caoyixuan2019@email.szu.edu.cn,
        hanshenghong2019@email.szu.edu.cn,
        zhaochongxi2019@email.szu.edu.cn, weizhenliang@huawei.com,
        zhangyinan2019@email.szu.edu.cn, linux-kernel@vger.kernel.org,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>
Subject: [PATCH 3/3] tools/vm/page_owner_sort.c: support sorting by tgid and update documentation
Date:   Tue,  1 Mar 2022 23:14:38 +0800
Message-Id: <20220301151438.166118-3-yejiajian2018@email.szu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301151438.166118-1-yejiajian2018@email.szu.edu.cn>
References: <20220301151438.166118-1-yejiajian2018@email.szu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the "page owner" information is read, the information sorted
by TGID is expected.

As a result, the following adjustments have been made:

1. Add a new -P option to sort the information of blocks by TGID
in ascending order.

2. Adjust the order of member variables in block_list strust
to avoid one 4 byte hole.

3. Add -P option explanation in the document.

Signed-off-by: Jiajian Ye <yejiajian2018@email.szu.edu.cn>
---
 Documentation/vm/page_owner.rst |  1 +
 tools/vm/page_owner_sort.c      | 40 ++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 2ddb632d847b..941543a797fe 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -116,6 +116,7 @@ Usage
 		-a		Sort by memory allocation time.
 		-m		Sort by total memory.
 		-p		Sort by pid.
+		-P		Sort by tgid.
 		-r		Sort by memory release time.
 		-s		Sort by stack trace.
 		-t		Sort by times (default).
diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index 69fb6ca7c0b7..d166f2f900eb 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -25,16 +25,18 @@
 struct block_list {
 	char *txt;
 	char *stacktrace;
+	__u64 ts_nsec;
+	__u64 free_ts_nsec;
 	int len;
 	int num;
 	int page_num;
 	pid_t pid;
-	__u64 ts_nsec;
-	__u64 free_ts_nsec;
+	pid_t tgid;
 };
 
 static regex_t order_pattern;
 static regex_t pid_pattern;
+static regex_t tgid_pattern;
 static regex_t ts_nsec_pattern;
 static regex_t free_ts_nsec_pattern;
 static struct block_list *list;
@@ -91,6 +93,13 @@ static int compare_pid(const void *p1, const void *p2)
 	return l1->pid - l2->pid;
 }
 
+static int compare_tgid(const void *p1, const void *p2)
+{
+	const struct block_list *l1 = p1, *l2 = p2;
+
+	return l1->tgid - l2->tgid;
+}
+
 static int compare_ts(const void *p1, const void *p2)
 {
 	const struct block_list *l1 = p1, *l2 = p2;
@@ -170,6 +179,24 @@ static pid_t get_pid(char *buf)
 
 }
 
+static pid_t get_tgid(char *buf)
+{
+	pid_t tgid;
+	char tgid_str[FIELD_BUFF] = {0};
+	char *endptr;
+
+	search_pattern(&tgid_pattern, tgid_str, buf);
+	errno = 0;
+	tgid = strtol(tgid_str, &endptr, 10);
+	if (errno != 0 || endptr == tgid_str || *endptr != '\0') {
+		printf("wrong/invalid tgid in follow buf:\n%s\n", buf);
+		return -1;
+	}
+
+	return tgid;
+
+}
+
 static __u64 get_ts_nsec(char *buf)
 {
 	__u64 ts_nsec;
@@ -231,6 +258,7 @@ static void add_list(char *buf, int len)
 	list[list_size].txt[len] = 0;
 	list[list_size].stacktrace = strchr(list[list_size].txt, '\n') ?: "";
 	list[list_size].pid = get_pid(buf);
+	list[list_size].tgid = get_tgid(buf);
 	list[list_size].ts_nsec = get_ts_nsec(buf);
 	list[list_size].free_ts_nsec = get_free_ts_nsec(buf);
 	list_size++;
@@ -249,6 +277,7 @@ static void usage(void)
 		"-s	Sort by the stack trace.\n"
 		"-t	Sort by times (default).\n"
 		"-p	Sort by pid.\n"
+		"-P	Sort by tgid.\n"
 		"-a	Sort by memory allocate time.\n"
 		"-r	Sort by memory release time.\n"
 		"-c	Cull by comparing stacktrace instead of total block.\n"
@@ -268,7 +297,7 @@ int main(int argc, char **argv)
 	struct stat st;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "acfmprst")) != -1)
+	while ((opt = getopt(argc, argv, "acfmprstP")) != -1)
 		switch (opt) {
 		case 'a':
 			cmp = compare_ts;
@@ -294,6 +323,9 @@ int main(int argc, char **argv)
 		case 't':
 			cmp = compare_num;
 			break;
+		case 'P':
+			cmp = compare_tgid;
+			break;
 		default:
 			usage();
 			exit(1);
@@ -314,6 +346,7 @@ int main(int argc, char **argv)
 
 	check_regcomp(&order_pattern, "order\\s*([0-9]*),");
 	check_regcomp(&pid_pattern, "pid\\s*([0-9]*),");
+	check_regcomp(&tgid_pattern, "tgid\\s*([0-9]*) ");
 	check_regcomp(&ts_nsec_pattern, "ts\\s*([0-9]*)\\s*ns,");
 	check_regcomp(&free_ts_nsec_pattern, "free_ts\\s*([0-9]*)\\s*ns");
 	fstat(fileno(fin), &st);
@@ -373,6 +406,7 @@ int main(int argc, char **argv)
 	}
 	regfree(&order_pattern);
 	regfree(&pid_pattern);
+	regfree(&tgid_pattern);
 	regfree(&ts_nsec_pattern);
 	regfree(&free_ts_nsec_pattern);
 	return 0;
-- 
2.25.1



