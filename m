Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E814FAE0F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiDJNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 09:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiDJNcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 09:32:17 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BEEF2A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 06:30:00 -0700 (PDT)
X-QQ-mid: bizesmtp79t1649597380t2y1mcg6
Received: from wuhui-virtual-machine.localdoma ( [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 10 Apr 2022 21:29:36 +0800 (CST)
X-QQ-SSF: 01400000002000D0P000B00A0000000
X-QQ-FEAT: F3yR32iATbhBfLqlwEmZKSHv4ORtiEqW6rKlETYzl9AYnhM93JdHIvs97j4yG
        tJupQqsmQG11e9Sn4WsqDk96h0uaU7gV5M4uXMUEbLgIbgTO2/CUpgtmggSnlUQynYDoqoB
        64fQsmVygnloKPkNn2ztNgYmNdX+gH52JnMRkzzvnJ+s14Vp2V64OGMLkDTay/bipWZtaSh
        wvTlMlqGWpG3+Y7SlZIl/8pCgjmnAKlaaaoZg13waKsy79toDM65w8gu7W+LwnmGaiqbk3i
        /4uBqHbkPov8K4G8u8vjrpKZLvYHvHEiPSp34XPanc2O3Up44BCk7nnVe20zPiq/G0P2Dga
        FT9Gs6GdUkAWQ0OrJBLETRSmhCw9j6AI9dF5VGI
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     yejiajian2018@email.szu.edu.cn, seanga2@gmail.com,
        sfr@canb.auug.org.au, zhangyinan2019@email.szu.edu.cn,
        tangbin@cmss.chinamobile.com, zhaochongxi2019@email.szu.edu.cn,
        linux-kernel@vger.kernel.org, yuhongf@szu.edu.cn,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] tools/vm/page_owner_sort.c: provide allocator labelling and update --cull and --sort options
Date:   Sun, 10 Apr 2022 21:29:32 +0800
Message-Id: <20220410132932.9402-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An application is suspected of having memory leak when its memory
consumption is high and keeps increasing. There are several commonly used
memory allocators: slab, cma, vmalloc, etc. The memory leak identification
can be sped up if the page information allocated by an allocator can be
analyzed separately.

This patch provides supports for memory allocator labelling for
slab, vmalloc, and cma. The pages allocated by slab and cma can be
confirmed from the "PFN" line according to the kernel codes,
and the label of the vmalloc allocator can be obtained by analyzing
the stack trace. Thanks for Vlastimil Babka's constructive suggestions.

Based on Yinan Zhang's study, the call chain of vmalloc() is vmalloc()
-> ... -> __vmalloc_node_range() -> __vmalloc_area_node().
__vmalloc_area_node() requests memory through the interface of buddy
allocation system. In the current version, __vmalloc_area_node() uses four
interfaces: alloc_pages_bulk_array_mempolicy(),
alloc_pages_bulk_array_node(), alloc_pages() and alloc_pages_node().
By disassembling the code, we find that __vmalloc_area_node() is
expanded in __vmalloc_node_range().
So __vmalloc_area_node is not in the stack trace.

On the test machine, the stack trace of pages allocated by vmalloc
has the following four forms:

__alloc_pages_bulk+0x230/0x6a0
__vmalloc_node_range+0x19c/0x598

alloc_pages_bulk_array_mempolicy+0xbc/0x278
__vmalloc_node_range+0x1e8/0x598

__alloc_pages+0x160/0x2b0
__vmalloc_node_range+0x234/0x598

alloc_pages+0xac/0x150
__vmalloc_node_range+0x44c/0x598

Therefore, in two consecutive lines of stacktrace, if the first line
contains the word "alloc_pages" and the second line contains the word
"__vmalloc_node_range", it can be determined that the page is allocated
by vmalloc. And the function offset and size are not the same on different
machines, so there is no need to match them.

At the same time, this patch updates the --cull and --sort options to
support allocator-based merge statistics and sorting. The added functions
are fully compatible with the original work. When using, you can
use "allocator", or abbreviated as "ator". Relevant updates have also
been made in the documentation(Documentation/vm/page_owner.rst).

Example:
./page_owner_sort <input> <output> --cull=st,pid,name,allocator
./page_owner_sort <input> <output> --sort=ator,pid,name

This work is coauthored by Jiajian Ye, Yinan Zhang, Shenghong Han,
Chongxi Zhao, Yuhong Feng and Yongqiang Liu.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 Documentation/vm/page_owner.rst |   3 +-
 tools/vm/page_owner_sort.c      | 112 +++++++++++++++++++++++++++-----
 2 files changed, 99 insertions(+), 16 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 2537386ab413..422d5fa99e84 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -182,6 +182,7 @@ For --sort option:
 	T		txt		full text of block
 	ft		free_ts		timestamp of the page when it was released
 	at		alloc_ts	timestamp of the page when it was allocated
+        ator            allocator       memory allocator for pages
 
 For --curl option:
 
@@ -191,4 +192,4 @@ For --curl option:
 	n		name		task command name
 	f		free		whether the page has been released or not
 	st		stacktrace	stack trace of the page allocation
-
+        ator            allocator       memory allocator for pages
diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index beca990707fb..35cbcbdd85ac 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -39,6 +39,7 @@ struct block_list {
 	int page_num;
 	pid_t pid;
 	pid_t tgid;
+	int allocator;
 };
 enum FILTER_BIT {
 	FILTER_UNRELEASE = 1<<1,
@@ -51,11 +52,19 @@ enum CULL_BIT {
 	CULL_PID = 1<<2,
 	CULL_TGID = 1<<3,
 	CULL_COMM = 1<<4,
-	CULL_STACKTRACE = 1<<5
+	CULL_STACKTRACE = 1<<5,
+	CULL_ALLOCATOR = 1<<6
+};
+enum ALLOCATOR_BIT {
+	ALLOCATOR_CMA = 1<<1,
+	ALLOCATOR_SLAB = 1<<2,
+	ALLOCATOR_VMALLOC = 1<<3,
+	ALLOCATOR_OTHERS = 1<<4
 };
 enum ARG_TYPE {
 	ARG_TXT, ARG_COMM, ARG_STACKTRACE, ARG_ALLOC_TS, ARG_FREE_TS,
-	ARG_CULL_TIME, ARG_PAGE_NUM, ARG_PID, ARG_TGID, ARG_UNKNOWN, ARG_FREE
+	ARG_CULL_TIME, ARG_PAGE_NUM, ARG_PID, ARG_TGID, ARG_UNKNOWN, ARG_FREE,
+	ARG_ALLOCATOR
 };
 enum SORT_ORDER {
 	SORT_ASC = 1,
@@ -88,15 +97,20 @@ static int max_size;
 static int cull;
 static int filter;
 
-int read_block(char *buf, int buf_size, FILE *fin)
+static void set_single_cmp(int (*cmp)(const void *, const void *), int sign);
+
+int read_block(char *buf, char *ext_buf, int buf_size, FILE *fin)
 {
 	char *curr = buf, *const buf_end = buf + buf_size;
 
 	while (buf_end - curr > 1 && fgets(curr, buf_end - curr, fin)) {
-		if (*curr == '\n') /* empty line */
+		if (*curr == '\n') { /* empty line */
 			return curr - buf;
-		if (!strncmp(curr, "PFN", 3))
+		}
+		if (!strncmp(curr, "PFN", 3)) {
+			strcpy(ext_buf, curr);
 			continue;
+		}
 		curr += strlen(curr);
 	}
 
@@ -145,6 +159,13 @@ static int compare_tgid(const void *p1, const void *p2)
 	return l1->tgid - l2->tgid;
 }
 
+static int compare_allocator(const void *p1, const void *p2)
+{
+	const struct block_list *l1 = p1, *l2 = p2;
+
+	return l1->allocator - l2->allocator;
+}
+
 static int compare_comm(const void *p1, const void *p2)
 {
 	const struct block_list *l1 = p1, *l2 = p2;
@@ -191,6 +212,8 @@ static int compare_cull_condition(const void *p1, const void *p2)
 		return compare_comm(p1, p2);
 	if ((cull & CULL_UNRELEASE) && compare_release(p1, p2))
 		return compare_release(p1, p2);
+	if ((cull & CULL_ALLOCATOR) && compare_allocator(p1, p2))
+		return compare_allocator(p1, p2);
 	return 0;
 }
 
@@ -387,11 +410,42 @@ static int get_arg_type(const char *arg)
 		return ARG_FREE_TS;
 	else if (!strcmp(arg, "alloc_ts") || !strcmp(arg, "at"))
 		return ARG_ALLOC_TS;
+	else if (!strcmp(arg, "allocator") || !strcmp(arg, "ator"))
+		return ARG_ALLOCATOR;
 	else {
 		return ARG_UNKNOWN;
 	}
 }
 
+static int get_allocator(const char *buf, const char *migrate_info)
+{
+	char *tmp, *first_line, *second_line;
+	int allocator = 0;
+
+	if (strstr(migrate_info, "CMA"))
+		allocator |= ALLOCATOR_CMA;
+	if (strstr(migrate_info, "slab"))
+		allocator |= ALLOCATOR_SLAB;
+	tmp = strstr(buf, "__vmalloc_node_range");
+	if (tmp) {
+		second_line = tmp;
+		while (*tmp != '\n')
+			tmp--;
+		tmp--;
+		while (*tmp != '\n')
+			tmp--;
+		first_line = ++tmp;
+		tmp = strstr(tmp, "alloc_pages");
+		if (tmp) {
+			if (tmp && first_line <= tmp && tmp < second_line)
+				allocator |= ALLOCATOR_VMALLOC;
+		}
+	}
+	if (allocator == 0)
+		allocator = ALLOCATOR_OTHERS;
+	return allocator;
+}
+
 static bool match_num_list(int num, int *list, int list_size)
 {
 	for (int i = 0; i < list_size; ++i)
@@ -429,7 +483,7 @@ static bool is_need(char *buf)
 		return true;
 }
 
-static void add_list(char *buf, int len)
+static void add_list(char *buf, int len, char *ext_buf)
 {
 	if (list_size != 0 &&
 		len == list[list_size-1].len &&
@@ -463,6 +517,7 @@ static void add_list(char *buf, int len)
 		list[list_size].stacktrace++;
 	list[list_size].ts_nsec = get_ts_nsec(buf);
 	list[list_size].free_ts_nsec = get_free_ts_nsec(buf);
+	list[list_size].allocator = get_allocator(buf, ext_buf);
 	list_size++;
 	if (list_size % 1000 == 0) {
 		printf("loaded %d\r", list_size);
@@ -488,12 +543,16 @@ static bool parse_cull_args(const char *arg_str)
 			cull |= CULL_STACKTRACE;
 		else if (arg_type == ARG_FREE)
 			cull |= CULL_UNRELEASE;
+		else if (arg_type == ARG_ALLOCATOR)
+			cull |= CULL_ALLOCATOR;
 		else {
 			free_explode(args, size);
 			return false;
 		}
 	}
 	free_explode(args, size);
+	if (sc.size == 0)
+		set_single_cmp(compare_num, SORT_DESC);
 	return true;
 }
 
@@ -548,6 +607,8 @@ static bool parse_sort_args(const char *arg_str)
 			sc.cmps[i] = compare_free_ts;
 		else if (arg_type == ARG_TXT)
 			sc.cmps[i] = compare_txt;
+		else if (arg_type == ARG_ALLOCATOR)
+			sc.cmps[i] = compare_allocator;
 		else {
 			free_explode(args, size);
 			sc.size = 0;
@@ -580,6 +641,19 @@ static int *parse_nums_list(char *arg_str, int *list_size)
 	return list;
 }
 
+static void print_allocator(FILE *out, int allocator)
+{
+	fprintf(out, "allocated by ");
+	if (allocator & ALLOCATOR_CMA)
+		fprintf(out, "CMA ");
+	if (allocator & ALLOCATOR_SLAB)
+		fprintf(out, "SLAB ");
+	if (allocator & ALLOCATOR_VMALLOC)
+		fprintf(out, "VMALLOC ");
+	if (allocator & ALLOCATOR_OTHERS)
+		fprintf(out, "OTHERS ");
+}
+
 #define BUF_SIZE	(128 * 1024)
 
 static void usage(void)
@@ -605,8 +679,8 @@ static void usage(void)
 int main(int argc, char **argv)
 {
 	FILE *fin, *fout;
-	char *buf;
-	int ret, i, count;
+	char *buf, *ext_buf;
+	int i, count;
 	struct stat st;
 	int opt;
 	struct option longopts[] = {
@@ -712,16 +786,18 @@ int main(int argc, char **argv)
 
 	list = malloc(max_size * sizeof(*list));
 	buf = malloc(BUF_SIZE);
-	if (!list || !buf) {
+	ext_buf = malloc(BUF_SIZE);
+	if (!list || !buf || !ext_buf) {
 		fprintf(stderr, "Out of memory\n");
 		exit(1);
 	}
 
 	for ( ; ; ) {
-		ret = read_block(buf, BUF_SIZE, fin);
-		if (ret < 0)
+		int buf_len = read_block(buf, ext_buf, BUF_SIZE, fin);
+
+		if (buf_len < 0)
 			break;
-		add_list(buf, ret);
+		add_list(buf, buf_len, ext_buf);
 	}
 
 	printf("loaded %d\n", list_size);
@@ -745,9 +821,11 @@ int main(int argc, char **argv)
 	qsort(list, count, sizeof(list[0]), compare_sort_condition);
 
 	for (i = 0; i < count; i++) {
-		if (cull == 0)
-			fprintf(fout, "%d times, %d pages:\n%s\n",
-					list[i].num, list[i].page_num, list[i].txt);
+		if (cull == 0) {
+			fprintf(fout, "%d times, %d pages, ", list[i].num, list[i].page_num);
+			print_allocator(fout, list[i].allocator);
+			fprintf(fout, ":\n%s\n", list[i].txt);
+		}
 		else {
 			fprintf(fout, "%d times, %d pages",
 					list[i].num, list[i].page_num);
@@ -757,6 +835,10 @@ int main(int argc, char **argv)
 				fprintf(fout, ", TGID %d", list[i].pid);
 			if (cull & CULL_COMM || filter & FILTER_COMM)
 				fprintf(fout, ", task_comm_name: %s", list[i].comm);
+			if (cull & CULL_ALLOCATOR) {
+				fprintf(fout, ", ");
+				print_allocator(fout, list[i].allocator);
+			}
 			if (cull & CULL_UNRELEASE)
 				fprintf(fout, " (%s)",
 						list[i].free_ts_nsec ? "UNRELEASED" : "RELEASED");
-- 
2.17.1



