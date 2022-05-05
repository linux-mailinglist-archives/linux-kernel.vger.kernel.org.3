Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7BA51B9D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiEEITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbiEEITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:19:36 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D553529CB8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:15:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VCIxWfR_1651738540;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCIxWfR_1651738540)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 May 2022 16:15:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] altera-stapl: Use swap() instead of open coding it
Date:   Thu,  5 May 2022 16:15:39 +0800
Message-Id: <20220505081539.91575-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean the following coccicheck warning:

./drivers/misc/altera-stapl/altera.c:955:51-52: WARNING opportunity for
swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/misc/altera-stapl/altera.c | 56 +++++++++---------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
index 92c0611034b0..075f3a36d512 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -530,11 +530,8 @@ static int altera_execute(struct altera_state *astate,
 			}
 			break;
 		case OP_SWP:
-			if (altera_check_stack(stack_ptr, 2, &status)) {
-				long_tmp = stack[stack_ptr - 2];
-				stack[stack_ptr - 2] = stack[stack_ptr - 1];
-				stack[stack_ptr - 1] = long_tmp;
-			}
+			if (altera_check_stack(stack_ptr, 2, &status))
+				swap(stack[stack_ptr - 2], stack[stack_ptr - 1]);
 			break;
 		case OP_ADD:
 			if (altera_check_stack(stack_ptr, 2, &status)) {
@@ -912,34 +909,22 @@ static int altera_execute(struct altera_state *astate,
 			 */
 
 			/* SWP  */
-			if (altera_check_stack(stack_ptr, 2, &status)) {
-				long_tmp = stack[stack_ptr - 2];
-				stack[stack_ptr - 2] = stack[stack_ptr - 1];
-				stack[stack_ptr - 1] = long_tmp;
-			}
+			if (altera_check_stack(stack_ptr, 2, &status))
+				swap(stack[stack_ptr - 2], stack[stack_ptr - 1]);
 
 			/* SWPN 7 */
 			index = 7 + 1;
-			if (altera_check_stack(stack_ptr, index, &status)) {
-				long_tmp = stack[stack_ptr - index];
-				stack[stack_ptr - index] = stack[stack_ptr - 1];
-				stack[stack_ptr - 1] = long_tmp;
-			}
+			if (altera_check_stack(stack_ptr, index, &status))
+				swap(stack[stack_ptr - index], stack[stack_ptr - 1]);
 
 			/* SWP  */
-			if (altera_check_stack(stack_ptr, 2, &status)) {
-				long_tmp = stack[stack_ptr - 2];
-				stack[stack_ptr - 2] = stack[stack_ptr - 1];
-				stack[stack_ptr - 1] = long_tmp;
-			}
+			if (altera_check_stack(stack_ptr, 2, &status))
+				swap(stack[stack_ptr - 2], stack[stack_ptr - 1]);
 
 			/* SWPN 6 */
 			index = 6 + 1;
-			if (altera_check_stack(stack_ptr, index, &status)) {
-				long_tmp = stack[stack_ptr - index];
-				stack[stack_ptr - index] = stack[stack_ptr - 1];
-				stack[stack_ptr - 1] = long_tmp;
-			}
+			if (altera_check_stack(stack_ptr, index, &status))
+				swap(stack[stack_ptr - index], stack[stack_ptr - 1]);
 
 			/* DUPN 8 */
 			index = 8 + 1;
@@ -950,18 +935,12 @@ static int altera_execute(struct altera_state *astate,
 
 			/* SWPN 2 */
 			index = 2 + 1;
-			if (altera_check_stack(stack_ptr, index, &status)) {
-				long_tmp = stack[stack_ptr - index];
-				stack[stack_ptr - index] = stack[stack_ptr - 1];
-				stack[stack_ptr - 1] = long_tmp;
-			}
+			if (altera_check_stack(stack_ptr, index, &status))
+				swap(stack[stack_ptr - index], stack[stack_ptr - 1]);
 
 			/* SWP  */
-			if (altera_check_stack(stack_ptr, 2, &status)) {
-				long_tmp = stack[stack_ptr - 2];
-				stack[stack_ptr - 2] = stack[stack_ptr - 1];
-				stack[stack_ptr - 1] = long_tmp;
-			}
+			if (altera_check_stack(stack_ptr, 2, &status))
+				swap(stack[stack_ptr - 2], stack[stack_ptr - 1]);
 
 			/* DUPN 6 */
 			index = 6 + 1;
@@ -1075,11 +1054,8 @@ static int altera_execute(struct altera_state *astate,
 			 * to swap with top element
 			 */
 			index = (args[0]) + 1;
-			if (altera_check_stack(stack_ptr, index, &status)) {
-				long_tmp = stack[stack_ptr - index];
-				stack[stack_ptr - index] = stack[stack_ptr - 1];
-				stack[stack_ptr - 1] = long_tmp;
-			}
+			if (altera_check_stack(stack_ptr, index, &status))
+				swap(stack[stack_ptr - index], stack[stack_ptr - 1]);
 			break;
 		case OP_DUPN:
 			/*
-- 
2.20.1.7.g153144c

