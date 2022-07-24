Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBF457F5C5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiGXP05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiGXP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:26:55 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9191E2620
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:26:50 -0700 (PDT)
X-QQ-mid: bizesmtp66t1658676396t1qsw34p
Received: from localhost.localdomain ( [218.17.40.236])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 23:26:21 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000000A0000000
X-QQ-FEAT: B4Sc/jD84f6PXBhR4tnsAGZtkTllm7tFUcI0J/sU/bqKRBLXPEkcJXN1TiBSN
        SU6IYrmHgbkG3RymtuU/GmYwXg8MZ626/r2Mk/8Cu4flSh9XYNIBWv4AmNG78bK1n3evay2
        hRs7D13QV1IRXRjc9bYKA6cOeeYlcV9eWFIXJXqWM+1Tpp8l+UDudYHmYMUjroO198pL7At
        nn8phpyhjNbvFkfsVobYa3eO7H0wh1Kl0lBPcl5AFsBTcLrz3KQESJoafdLqHueO9cBEQo0
        lnCsg8S4e+/KP2j2gFqLvIhOrZpEVzTpGlzOv6KLT5OskVxqNPDQ6LgJZL71yfflKD9FHNK
        9nKyusuTP4FR8dOq+C4uQBceLthm2TB21cqfBXTKRpanDxRYTDndn42ZK1h8jJmS9pfl6NI
        nT/DtcvL3Ys=
X-QQ-GoodBg: 2
From:   Shenghong Han <hanshenghong2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, yuhongf@szu.edu.cn,
        caoyixuan2019@email.szu.edu.cn,
        Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>
Subject: [PATCH 1/2] fix three trivival places
Date:   Sun, 24 Jul 2022 23:25:33 +0800
Message-Id: <20220724152534.9239-1-hanshenghong2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dirty work:
1.Rename some Variables.
2.Some if-statement was missed at Commit ebbeae36387c,so make up them.

Signed-off-by: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
Signed-off-by: Jiajian Ye <yejiajian2018@email.szu.edu.cn>
---
 tools/vm/page_owner_sort.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index ec2e67c85..fb103aaf4 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -63,7 +63,7 @@ enum ALLOCATOR_BIT {
 };
 enum ARG_TYPE {
 	ARG_TXT, ARG_COMM, ARG_STACKTRACE, ARG_ALLOC_TS, ARG_FREE_TS,
-	ARG_CULL_TIME, ARG_PAGE_NUM, ARG_PID, ARG_TGID, ARG_UNKNOWN, ARG_FREE,
+	ARG_TIMES, ARG_TOTAL_MEM, ARG_PID, ARG_TGID, ARG_UNKNOWN, ARG_FREE,
 	ARG_ALLOCATOR
 };
 enum SORT_ORDER {
@@ -402,7 +402,11 @@ static char *get_comm(char *buf)
 
 static int get_arg_type(const char *arg)
 {
-	if (!strcmp(arg, "pid") || !strcmp(arg, "p"))
+	if (!strcmp(arg, "times") || !strcmp(arg, "t"))
+		return ARG_TIMES;
+	else if (!strcmp(arg, "memory") || !strcmp(arg, "m"))
+		return ARG_TOTAL_MEM;
+	else if (!strcmp(arg, "pid") || !strcmp(arg, "p"))
 		return ARG_PID;
 	else if (!strcmp(arg, "tgid") || !strcmp(arg, "tg"))
 		return ARG_TGID;
@@ -599,7 +603,11 @@ static bool parse_sort_args(const char *arg_str)
 
 		int arg_type = get_arg_type(args[i]+offset);
 
-		if (arg_type == ARG_PID)
+		if (arg_type == ARG_TIMES)
+			sc.cmps[i] = compare_num;
+		else if (arg_type == ARG_TOTAL_MEM)
+			sc.cmps[i] = compare_page_num;
+		else if (arg_type == ARG_PID)
 			sc.cmps[i] = compare_pid;
 		else if (arg_type == ARG_TGID)
 			sc.cmps[i] = compare_tgid;
-- 
2.30.1



