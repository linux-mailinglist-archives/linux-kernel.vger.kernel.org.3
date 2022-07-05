Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCEF5660D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiGEB5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGEB5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:57:37 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF71101F5;
        Mon,  4 Jul 2022 18:57:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VIPTyZN_1656986253;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VIPTyZN_1656986253)
          by smtp.aliyun-inc.com;
          Tue, 05 Jul 2022 09:57:33 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] xfs: clean up some inconsistent indenting
Date:   Tue,  5 Jul 2022 09:57:31 +0800
Message-Id: <20220705015731.115025-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
fs/xfs/xfs_log.c:3576 xlog_verify_tail_lsn() warn: inconsistent indenting

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/xfs/xfs_log.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index ae904b21e9cc..058173dcf4e7 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -3573,21 +3573,21 @@ xlog_verify_tail_lsn(
 	xfs_lsn_t	tail_lsn = be64_to_cpu(iclog->ic_header.h_tail_lsn);
 	int		blocks;
 
-    if (CYCLE_LSN(tail_lsn) == log->l_prev_cycle) {
-	blocks =
-	    log->l_logBBsize - (log->l_prev_block - BLOCK_LSN(tail_lsn));
-	if (blocks < BTOBB(iclog->ic_offset)+BTOBB(log->l_iclog_hsize))
-		xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
-    } else {
-	ASSERT(CYCLE_LSN(tail_lsn)+1 == log->l_prev_cycle);
-
-	if (BLOCK_LSN(tail_lsn) == log->l_prev_block)
-		xfs_emerg(log->l_mp, "%s: tail wrapped", __func__);
-
-	blocks = BLOCK_LSN(tail_lsn) - log->l_prev_block;
-	if (blocks < BTOBB(iclog->ic_offset) + 1)
-		xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
-    }
+	if (CYCLE_LSN(tail_lsn) == log->l_prev_cycle) {
+		blocks =
+			log->l_logBBsize - (log->l_prev_block - BLOCK_LSN(tail_lsn));
+		if (blocks < BTOBB(iclog->ic_offset)+BTOBB(log->l_iclog_hsize))
+			xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
+	} else {
+		ASSERT(CYCLE_LSN(tail_lsn)+1 == log->l_prev_cycle);
+
+		if (BLOCK_LSN(tail_lsn) == log->l_prev_block)
+			xfs_emerg(log->l_mp, "%s: tail wrapped", __func__);
+
+		blocks = BLOCK_LSN(tail_lsn) - log->l_prev_block;
+		if (blocks < BTOBB(iclog->ic_offset) + 1)
+			xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
+	}
 }
 
 /*
-- 
2.20.1.7.g153144c

