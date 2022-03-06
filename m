Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4A4CE861
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 04:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiCFDH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 22:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiCFDH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 22:07:56 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6CE75605
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 19:07:01 -0800 (PST)
X-QQ-mid: bizesmtp72t1646536013tgid6nbg
Received: from leo.localdomain ( [103.144.149.54])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Mar 2022 11:06:46 +0800 (CST)
X-QQ-SSF: 0140000000800050C000B00A0000000
X-QQ-FEAT: vjg72bqnXRCQj8Hx+LluJb/PxEqfcNHktE7LslUrV8H9xX/LpyMWIi7MyAae5
        dW7SkDBlNk1ezZ2PsjX/Hp59o7Ka5MrarKx2QovCrA0isbwYh4oEZAfYMTAdHLMA2HdXw7d
        wKOetWKGDKznHihgKEBV1kucJULFxg4ikEqX1gmq4aJvHxjDXstpF1KsJgmZC+to5BepQUO
        y8Bb5lpDizGXJ/4sPfBxrpEc/ULwbTa8+1S+1B7b1CHBre1hk99h7MdpGlVi3t1o5Xkv7pM
        ajaODjhsAN2mq5aS4UP1JpDiXuKLjn7OnEJpia4oZeRnM4u5lRlwBRQtUJ40YzVF12G6YrC
        4IcbvG4usHfo2xYtLZC5BClgNWa5w==
X-QQ-GoodBg: 2
From:   Jiajian Ye <yejiajian2018@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     sfr@canb.auug.org.au, seanga2@gmail.com,
        zhaochongxi2019@email.szu.edu.cn, caoyixuan2019@email.szu.edu.cn,
        hanshenghong2019@email.szu.edu.cn, linux-kernel@vger.kernel.org,
        zhangyinan2019@email.szu.edu.cn, weizhenliang@huawei.com,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>
Subject: [PATCH 1/2] tools/vm/page_owner_sort: fix three trivival places
Date:   Sun,  6 Mar 2022 11:06:39 +0800
Message-Id: <20220306030640.43054-1-yejiajian2018@email.szu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following adjustments are made:

1. Instead of using another array to cull the blocks after sorting,
reuse the old array. So there is no need to malloc a new array.

2. When enabling '-f' option to filter out the blocks which have
been released, only add those have not been released in the list,
rather than add all of blocks in the list and then do the filtering
when printing the result.

3. When enabling '-c' option to cull the blocks by comparing stacktrace,
print the stacetrace rather than the total block.

Signed-off-by: Jiajian Ye <yejiajian2018@email.szu.edu.cn>
---
 tools/vm/page_owner_sort.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index d166f2f900eb..b8d2867b5b18 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -42,6 +42,8 @@ static regex_t free_ts_nsec_pattern;
 static struct block_list *list;
 static int list_size;
 static int max_size;
+static int cull_st;
+static int filter;
 
 int read_block(char *buf, int buf_size, FILE *fin)
 {
@@ -245,6 +247,9 @@ static void add_list(char *buf, int len)
 		exit(1);
 	}
 
+	list[list_size].free_ts_nsec = get_free_ts_nsec(buf);
+	if (filter == 1 && list[list_size].free_ts_nsec != 0)
+		return;
 	list[list_size].txt = malloc(len+1);
 	if (!list[list_size].txt) {
 		printf("Out of memory\n");
@@ -257,10 +262,11 @@ static void add_list(char *buf, int len)
 	memcpy(list[list_size].txt, buf, len);
 	list[list_size].txt[len] = 0;
 	list[list_size].stacktrace = strchr(list[list_size].txt, '\n') ?: "";
+	if (*list[list_size].stacktrace == '\n')
+		list[list_size].stacktrace++;
 	list[list_size].pid = get_pid(buf);
 	list[list_size].tgid = get_tgid(buf);
 	list[list_size].ts_nsec = get_ts_nsec(buf);
-	list[list_size].free_ts_nsec = get_free_ts_nsec(buf);
 	list_size++;
 	if (list_size % 1000 == 0) {
 		printf("loaded %d\r", list_size);
@@ -288,12 +294,9 @@ static void usage(void)
 int main(int argc, char **argv)
 {
 	int (*cmp)(const void *, const void *) = compare_num;
-	int cull_st = 0;
-	int filter = 0;
 	FILE *fin, *fout;
 	char *buf;
 	int ret, i, count;
-	struct block_list *list2;
 	struct stat st;
 	int opt;
 
@@ -376,11 +379,7 @@ int main(int argc, char **argv)
 	else
 		qsort(list, list_size, sizeof(list[0]), compare_txt);
 
-	list2 = malloc(sizeof(*list) * list_size);
-	if (!list2) {
-		printf("Out of memory\n");
-		exit(1);
-	}
+
 
 	printf("culling\n");
 
@@ -388,21 +387,23 @@ int main(int argc, char **argv)
 
 	for (i = count = 0; i < list_size; i++) {
 		if (count == 0 ||
-		    strcmp(*(&list2[count-1].txt+offset), *(&list[i].txt+offset)) != 0) {
-			list2[count++] = list[i];
+		    strcmp(*(&list[count-1].txt+offset), *(&list[i].txt+offset)) != 0) {
+			list[count++] = list[i];
 		} else {
-			list2[count-1].num += list[i].num;
-			list2[count-1].page_num += list[i].page_num;
+			list[count-1].num += list[i].num;
+			list[count-1].page_num += list[i].page_num;
 		}
 	}
 
-	qsort(list2, count, sizeof(list[0]), cmp);
+	qsort(list, count, sizeof(list[0]), cmp);
 
 	for (i = 0; i < count; i++) {
-		if (filter == 1 && list2[i].free_ts_nsec != 0)
-			continue;
-		fprintf(fout, "%d times, %d pages:\n%s\n",
-				list2[i].num, list2[i].page_num, list2[i].txt);
+		if (cull_st == 0)
+			fprintf(fout, "%d times, %d pages:\n%s\n",
+					list[i].num, list[i].page_num, list[i].txt);
+		else
+			fprintf(fout, "%d times, %d pages:\n%s\n",
+					list[i].num, list[i].page_num, list[i].stacktrace);
 	}
 	regfree(&order_pattern);
 	regfree(&pid_pattern);
-- 
2.25.1



