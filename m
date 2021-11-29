Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BC2461A87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245708AbhK2PCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:02:50 -0500
Received: from smtpbguseast3.qq.com ([54.243.244.52]:34499 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245487AbhK2PAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:00:48 -0500
X-QQ-mid: bizesmtp44t1638197831tq2j9s6v
Received: from ubu2004.mshome.net (unknown [202.96.137.248])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 29 Nov 2021 22:57:00 +0800 (CST)
X-QQ-SSF: 01400000006000406000B00B0000000
X-QQ-FEAT: a4niRxydalEZN1GXCGikaEDf5jDtebQZtgIEb/iYUS361d1G4a+QcDRUUH5QN
        hU1vAsjwaQuyJM6X4VjaGHVeArYSexbobv2mYd/2va+rjVfOHYJimLg48OakPrLcoetubqZ
        OoOGm8npurVF55oIyaped4Ktgctdn3nUF+TFxRty/byV7sXlkBmrq+4KT5QcWT9Sp8kDiwD
        k57sn+NsvqhI4rcwBr6x+4XrOpq4gREbBU0z6tfMdLaLrVlciqqnGkNpiBbwrVYk1V6WzUi
        tKB2+20lCjQYV3o4OjQREEu3OxPzpO8Gzn+itHbYoH62wdkGnfVJ29XhB0tzoAXnR/SQcKW
        Q4xDeYkFqlAqUIsaoz+SK3OOaNssQ==
X-QQ-GoodBg: 2
From:   Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     seanga2@gmail.com, linux-kernel@vger.kernel.org,
        zhangyinan2019@email.szu.edu.cn
Subject: [PATCH] tools/vm/page_owner_sort.c: add switch between culling by stacktrace and txt
Date:   Mon, 29 Nov 2021 22:56:58 +0800
Message-Id: <20211129145658.2491-1-zhangyinan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Culling by comparing stacktrace would casue loss of some
information. For example, if there exists 2 blocks which
have the same stacktrace and the different head info

Page allocated via order 0, mask 0x108c48(...), pid 73696,
 ts 1578829190639010 ns, free_ts 1576583851324450 ns
 prep_new_page+0x80/0xb8
 get_page_from_freelist+0x924/0xee8
 __alloc_pages+0x138/0xc18
 alloc_pages+0x80/0xf0
 __page_cache_alloc+0x90/0xc8

Page allocated via order 0, mask 0x108c48(...), pid 61806,
 ts 1354113726046100 ns, free_ts 1354104926841400 ns
 prep_new_page+0x80/0xb8
 get_page_from_freelist+0x924/0xee8
 __alloc_pages+0x138/0xc18
 alloc_pages+0x80/0xf0
 __page_cache_alloc+0x90/0xc8

After culling, it would be like this

2 times, 2 pages:
Page allocated via order 0, mask 0x108c48(...), pid 73696,
 ts 1578829190639010 ns, free_ts 1576583851324450 ns
 prep_new_page+0x80/0xb8
 get_page_from_freelist+0x924/0xee8
 __alloc_pages+0x138/0xc18
 alloc_pages+0x80/0xf0
 __page_cache_alloc+0x90/0xc8

The info of second block missed. So, add -c to turn on culling
by stacktrace. By default, it will cull by txt.

Signed-off-by: Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
---
 tools/vm/page_owner_sort.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index 1b2acf02d3cd..492be7f752c0 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -51,6 +51,13 @@ int read_block(char *buf, int buf_size, FILE *fin)
 	return -1; /* EOF or no space left in buf. */
 }
 
+static int compare_txt(const void *p1, const void *p2)
+{
+	const struct block_list *l1 = p1, *l2 = p2;
+
+	return strcmp(l1->txt, l2->txt);
+}
+
 static int compare_stacktrace(const void *p1, const void *p2)
 {
 	const struct block_list *l1 = p1, *l2 = p2;
@@ -137,12 +144,14 @@ static void usage(void)
 		"-m	Sort by total memory.\n"
 		"-s	Sort by the stack trace.\n"
 		"-t	Sort by times (default).\n"
+		"-c	cull by comparing stacktrace instead of total block.\n"
 	);
 }
 
 int main(int argc, char **argv)
 {
 	int (*cmp)(const void *, const void *) = compare_num;
+	int cull_st = 0;
 	FILE *fin, *fout;
 	char *buf;
 	int ret, i, count;
@@ -151,7 +160,7 @@ int main(int argc, char **argv)
 	int err;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "mst")) != -1)
+	while ((opt = getopt(argc, argv, "mstc")) != -1)
 		switch (opt) {
 		case 'm':
 			cmp = compare_page_num;
@@ -162,6 +171,9 @@ int main(int argc, char **argv)
 		case 't':
 			cmp = compare_num;
 			break;
+		case 'c':
+			cull_st = 1;
+			break;
 		default:
 			usage();
 			exit(1);
@@ -209,7 +221,10 @@ int main(int argc, char **argv)
 
 	printf("sorting ....\n");
 
-	qsort(list, list_size, sizeof(list[0]), compare_stacktrace);
+	if (cull_st == 1)
+		qsort(list, list_size, sizeof(list[0]), compare_stacktrace);
+	else
+		qsort(list, list_size, sizeof(list[0]), compare_txt);
 
 	list2 = malloc(sizeof(*list) * list_size);
 	if (!list2) {
@@ -219,9 +234,11 @@ int main(int argc, char **argv)
 
 	printf("culling\n");
 
+	long offset = cull_st ? &list[0].stacktrace - &list[0].txt : 0;
+
 	for (i = count = 0; i < list_size; i++) {
 		if (count == 0 ||
-		    strcmp(list2[count-1].stacktrace, list[i].stacktrace) != 0) {
+		    strcmp(*(&list2[count-1].txt+offset), *(&list[i].txt+offset)) != 0) {
 			list2[count++] = list[i];
 		} else {
 			list2[count-1].num += list[i].num;
-- 
2.23.0



