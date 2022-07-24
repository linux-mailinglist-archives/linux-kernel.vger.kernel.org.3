Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62FB57F5C6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiGXP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiGXP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:27:02 -0400
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2237712632
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:26:58 -0700 (PDT)
X-QQ-mid: bizesmtp66t1658676412tqqcubaa
Received: from localhost.localdomain ( [218.17.40.236])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 23:26:39 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000000A0000000
X-QQ-FEAT: 6hzDX+Y4lO/k77xX0x2ahn6AaRPvkQnJBt7N4W286Bi1e44cNgA9lUMLJpqK6
        nD9XqIct7gMtdFd1fT9Rhs9OFaq4XYAoLVTurmsf1LEQjkNFtdmy8e5Lo5ThV/ALw7FIFmD
        z7Wr6DFnv8WxCY5OFCsaDPLh07JW0KyKhMHzulBsspPVNU8pIVJXRhFCvDdRSVCB1bPGQtp
        eqa8VNXYPraMgidfB2Gti+alJa96IchkPyKHEITAjCDYHAtOs3PmOm9C35+JzAHKn/G05ZT
        YB2V4ynD5pKfMNT6TW1fyth06VCjq3UVIF3M4vRxvc6O165sRgKGGsJBpptQyOtF3DM5GCf
        16skGdyGVW/ErCnPYZcFaQv32GLN2bDd7aFLb67cKW9G9Ow/9sfYXJ+H8Mf2QDkrbQPPIC4
        7dO39p0kyorbOG7XBNXtEA==
X-QQ-GoodBg: 2
From:   Shenghong Han <hanshenghong2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, yuhongf@szu.edu.cn,
        caoyixuan2019@email.szu.edu.cn,
        Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>
Subject: [PATCH 2/2] Add --group option.
Date:   Sun, 24 Jul 2022 23:25:34 +0800
Message-Id: <20220724152534.9239-2-hanshenghong2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20220724152534.9239-1-hanshenghong2019@email.szu.edu.cn>
References: <20220724152534.9239-1-hanshenghong2019@email.szu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9c8a0a8e599f enhanced the culling funciton.The --cull option
displays the page owner information in a succinct way,but it is
not enough for some cases,so it needs to be supplemented and expanded.

The --group option will display blocks of information in groups.It shows
more details than the --cull option for further analysis, that is, the
--group option unfolds the information that use --cull option.

For example, the output of --cull option:
(./page_owner_sort demo.txt output_cull.txt --cull=allocator)

	23091 times, 23164 pages, allocated by OTHERS
	1384 times, 1545 pages, allocated by SLAB
	709 times, 709 pages, allocated by VMALLOC
	48 times, 48 pages, allocated by CMA

The output of --group option:
(./page_owner_sort demo.txt output_group.txt --group=allocator)

    23091 times, 23164 pages, allocator by OTHERS :

    //Block 1
    Page allocated via order XXX, ...
     // Detailed stack

    ...

    //Block 23091
    Page allocated via order XXX, ...
     // Detailed stack

    1384 times, 1545 pages, allocator by SLAB :
    // The Detailed Information of 1384 Block

    709 times, 709 pages, allocated by VMALLOC :
    // The Detailed Information of 709 Block

    48 times, 48 pages, allocated by CMA :
    // The Detailed Information of 48 Block

Signed-off-by: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
Signed-off-by: Jiajian Ye <yejiajian2018@email.szu.edu.cn>
---
 tools/vm/page_owner_sort.c | 128 ++++++++++++++++++++++++++++---------
 1 file changed, 99 insertions(+), 29 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index fb103aaf4..2b440dd81 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -41,6 +41,11 @@ struct block_list {
 	pid_t tgid;
 	int allocator;
 };
+struct block_group {
+	struct block_list *s_mem; /* group first block address*/
+	int s_idx; /* group first block index in arr*/
+	int len;
+};
 enum FILTER_BIT {
 	FILTER_UNRELEASE = 1<<1,
 	FILTER_PID = 1<<2,
@@ -93,9 +98,12 @@ static regex_t ts_nsec_pattern;
 static regex_t free_ts_nsec_pattern;
 static struct block_list *list;
 static int list_size;
+static struct block_group *group;
+static int group_size;
 static int max_size;
 static int cull;
 static int filter;
+static int is_group;
 static bool debug_on;
 
 static void set_single_cmp(int (*cmp)(const void *, const void *), int sign);
@@ -228,6 +236,18 @@ static int compare_sort_condition(const void *p1, const void *p2)
 	return cmp;
 }
 
+static int compare_sort_condition_btw_grp(const void *p1, const void *p2)
+{
+	int cmp = 0;
+	void *v1 = ((struct block_group *)p1)->s_mem;
+	void *v2 = ((struct block_group *)p2)->s_mem;
+
+	for (int i = 0; i < sc.size; ++i)
+		if (cmp == 0)
+			cmp = sc.signs[i] * sc.cmps[i](v1, v2);
+	return cmp;
+}
+
 static int search_pattern(regex_t *pattern, char *pattern_str, char *buf)
 {
 	int err, val_len;
@@ -657,7 +677,7 @@ static int *parse_nums_list(char *arg_str, int *list_size)
 
 static void print_allocator(FILE *out, int allocator)
 {
-	fprintf(out, "allocated by ");
+	fprintf(out, "allocator by ");
 	if (allocator & ALLOCATOR_CMA)
 		fprintf(out, "CMA ");
 	if (allocator & ALLOCATOR_SLAB)
@@ -668,6 +688,27 @@ static void print_allocator(FILE *out, int allocator)
 		fprintf(out, "OTHERS ");
 }
 
+static void print_cull_msg(FILE *out, struct block_list *p)
+{
+	fprintf(out, "%d times, %d pages",
+					p->num, p->page_num);
+	if (cull & CULL_PID || filter & FILTER_PID)
+		fprintf(out, ", PID %d", p->pid);
+	if (cull & CULL_TGID || filter & FILTER_TGID)
+		fprintf(out, ", TGID %d", p->pid);
+	if (cull & CULL_COMM || filter & FILTER_COMM)
+		fprintf(out, ", task_comm_name: %s", p->comm);
+	if (cull & CULL_ALLOCATOR) {
+		fprintf(out, ", ");
+		print_allocator(out, p->allocator);
+	}
+	if (cull & CULL_UNRELEASE)
+		fprintf(out, " (%s)",
+				p->free_ts_nsec ? "UNRELEASED" : "RELEASED");
+	if (cull & CULL_STACKTRACE)
+		fprintf(out, ":\n%s", p->stacktrace);
+}
+
 #define BUF_SIZE	(128 * 1024)
 
 static void usage(void)
@@ -687,6 +728,7 @@ static void usage(void)
 		"--tgid <tgidlist>\tSelect by tgid. This selects the information of blocks whose Thread Group ID numbers appear in <tgidlist>.\n"
 		"--name <cmdlist>\n\t\tSelect by command name. This selects the information of blocks whose command name appears in <cmdlist>.\n"
 		"--cull <rules>\tCull by user-defined rules.<rules> is a single argument in the form of a comma-separated list with some common fields predefined\n"
+		"--group <rules>\tGroup by user-defined rules.<rules> is a single argument in the form of a comma-separated list with some common fields predefined\n"
 		"--sort <order>\tSpecify sort order as: [+|-]key[,[+|-]key[,...]]\n"
 	);
 }
@@ -704,6 +746,7 @@ int main(int argc, char **argv)
 		{ "name", required_argument, NULL, 3 },
 		{ "cull",  required_argument, NULL, 4 },
 		{ "sort",  required_argument, NULL, 5 },
+		{ "group",  required_argument, NULL, 6 },
 		{ 0, 0, 0, 0},
 	};
 
@@ -775,6 +818,14 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			break;
+		case 6:
+			is_group = 1;
+			if (!parse_cull_args(optarg)) {
+				fprintf(stderr, "wrong argument after --group option:%s\n",
+						optarg);
+				exit(1);
+			}
+			break;
 		default:
 			usage();
 			exit(1);
@@ -826,42 +877,61 @@ int main(int argc, char **argv)
 
 	printf("culling\n");
 
-	for (i = count = 0; i < list_size; i++) {
-		if (count == 0 ||
-		    compare_cull_condition((void *)(&list[count-1]), (void *)(&list[i])) != 0) {
-			list[count++] = list[i];
-		} else {
-			list[count-1].num += list[i].num;
-			list[count-1].page_num += list[i].page_num;
+	if (is_group) {
+		group_size = 1;
+		for (i = 1; i < list_size; i++)
+			if (compare_cull_condition((void *)(&list[i-1]), (void *)(&list[i])) != 0)
+				group_size++;
+		group = malloc(group_size * sizeof(*group));
+		if (!group) {
+			fprintf(stderr, "Out of memory\n");
+			exit(1);
+		}
+		count = 0;
+		group[count].s_mem = &list[0];
+		group[count].s_idx = 0;
+		group[count].len = 1;
+
+		for (i = count = 1; i < list_size; i++)	{
+			if (compare_cull_condition((void *)(&list[i-1]), (void *)(&list[i])) != 0) {
+				group[count].s_mem = &list[i];
+				group[count].s_idx = i;
+				group[count].len = 1;
+				count++;
+			} else {
+				group[count-1].len++;
+				group[count-1].s_mem->num++;
+				group[count-1].s_mem->page_num += list[i].page_num;
+			}
+		}
+	} else {
+		for (i = count = 0; i < list_size; i++) {
+			if (count == 0 ||
+				compare_cull_condition((void *)(&list[count-1]), (void *)(&list[i])) != 0) {
+				list[count++] = list[i];
+			} else {
+				list[count-1].num += list[i].num;
+				list[count-1].page_num += list[i].page_num;
+			}
 		}
 	}
-
-	qsort(list, count, sizeof(list[0]), compare_sort_condition);
+	if (is_group)
+		qsort(group, group_size, sizeof(group[0]), compare_sort_condition_btw_grp);
+	else
+		qsort(list, count, sizeof(list[0]), compare_sort_condition);
 
 	for (i = 0; i < count; i++) {
 		if (cull == 0) {
 			fprintf(fout, "%d times, %d pages, ", list[i].num, list[i].page_num);
 			print_allocator(fout, list[i].allocator);
 			fprintf(fout, ":\n%s\n", list[i].txt);
-		}
-		else {
-			fprintf(fout, "%d times, %d pages",
-					list[i].num, list[i].page_num);
-			if (cull & CULL_PID || filter & FILTER_PID)
-				fprintf(fout, ", PID %d", list[i].pid);
-			if (cull & CULL_TGID || filter & FILTER_TGID)
-				fprintf(fout, ", TGID %d", list[i].pid);
-			if (cull & CULL_COMM || filter & FILTER_COMM)
-				fprintf(fout, ", task_comm_name: %s", list[i].comm);
-			if (cull & CULL_ALLOCATOR) {
-				fprintf(fout, ", ");
-				print_allocator(fout, list[i].allocator);
-			}
-			if (cull & CULL_UNRELEASE)
-				fprintf(fout, " (%s)",
-						list[i].free_ts_nsec ? "UNRELEASED" : "RELEASED");
-			if (cull & CULL_STACKTRACE)
-				fprintf(fout, ":\n%s", list[i].stacktrace);
+		} else if (is_group) {
+			print_cull_msg(fout, group[i].s_mem);
+			fprintf(fout, ":\n\n");
+			for (int j = 0; j < group[i].len; ++j)
+				fprintf(fout, "%s\n", list[j+group[i].s_idx].txt);
+		} else {
+			print_cull_msg(fout, &list[i]);
 			fprintf(fout, "\n");
 		}
 	}
-- 
2.30.1



