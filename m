Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33AB52E377
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiETEFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiETEFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:05:33 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2DE14A270;
        Thu, 19 May 2022 21:05:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VDoVbWo_1653019520;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VDoVbWo_1653019520)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 May 2022 12:05:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] xfs: Remove the redundant assignment
Date:   Fri, 20 May 2022 12:05:18 +0800
Message-Id: <20220520040518.73957-1-jiapeng.chong@linux.alibaba.com>
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

Variable 'ifree','freeblks' and 'itotal' set but not used.

Eliminate the follow clang warning:

fs/xfs/xfs_log_recover.c:3534:12: warning: variable 'freeblks' set but
not used [-Wunused-but-set-variable].

fs/xfs/xfs_log_recover.c:3535:12: warning: variable 'itotal' set but not
used [-Wunused-but-set-variable].

fs/xfs/xfs_log_recover.c:3536:12: warning: variable 'ifree'
set but not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/xfs/xfs_log_recover.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 97b941c07957..47736936ebba 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -3531,14 +3531,8 @@ xlog_recover_check_summary(
 	struct xfs_buf		*agfbp;
 	struct xfs_buf		*agibp;
 	xfs_agnumber_t		agno;
-	uint64_t		freeblks;
-	uint64_t		itotal;
-	uint64_t		ifree;
 	int			error;
 
-	freeblks = 0LL;
-	itotal = 0LL;
-	ifree = 0LL;
 	for_each_perag(mp, agno, pag) {
 		error = xfs_read_agf(mp, NULL, pag->pag_agno, 0, &agfbp);
 		if (error) {
@@ -3546,9 +3540,6 @@ xlog_recover_check_summary(
 						__func__, pag->pag_agno, error);
 		} else {
 			struct xfs_agf	*agfp = agfbp->b_addr;
-
-			freeblks += be32_to_cpu(agfp->agf_freeblks) +
-				    be32_to_cpu(agfp->agf_flcount);
 			xfs_buf_relse(agfbp);
 		}
 
@@ -3558,9 +3549,6 @@ xlog_recover_check_summary(
 						__func__, pag->pag_agno, error);
 		} else {
 			struct xfs_agi	*agi = agibp->b_addr;
-
-			itotal += be32_to_cpu(agi->agi_count);
-			ifree += be32_to_cpu(agi->agi_freecount);
 			xfs_buf_relse(agibp);
 		}
 	}
-- 
2.20.1.7.g153144c

