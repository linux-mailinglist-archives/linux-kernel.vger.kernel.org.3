Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3836752E531
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbiETGoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiETGo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:44:29 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16814CA35;
        Thu, 19 May 2022 23:44:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VDpGp-p_1653029058;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VDpGp-p_1653029058)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 May 2022 14:44:25 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] xfs: Remove dead code
Date:   Fri, 20 May 2022 14:44:16 +0800
Message-Id: <20220520064416.5092-1-jiapeng.chong@linux.alibaba.com>
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

Remove tht entire xlog_recover_check_summary() function, this entire
function is dead code and has been for 12 years.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Remove dead code.

 fs/xfs/xfs_log_recover.c | 59 ----------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 97b941c07957..b1980d7cbbee 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -39,13 +39,6 @@ STATIC int
 xlog_clear_stale_blocks(
 	struct xlog	*,
 	xfs_lsn_t);
-#if defined(DEBUG)
-STATIC void
-xlog_recover_check_summary(
-	struct xlog *);
-#else
-#define	xlog_recover_check_summary(log)
-#endif
 STATIC int
 xlog_do_recovery_pass(
         struct xlog *, xfs_daddr_t, xfs_daddr_t, int, xfs_daddr_t *);
@@ -3339,8 +3332,6 @@ xlog_do_recover(
 	}
 	mp->m_alloc_set_aside = xfs_alloc_set_aside(mp);
 
-	xlog_recover_check_summary(log);
-
 	/* Normal transactions can now occur */
 	clear_bit(XLOG_ACTIVE_RECOVERY, &log->l_opstate);
 	return 0;
@@ -3483,7 +3474,6 @@ xlog_recover_finish(
 	}
 
 	xlog_recover_process_iunlinks(log);
-	xlog_recover_check_summary(log);
 
 	/*
 	 * Recover any CoW staging blocks that are still referenced by the
@@ -3517,52 +3507,3 @@ xlog_recover_cancel(
 		xlog_recover_cancel_intents(log);
 }
 
-#if defined(DEBUG)
-/*
- * Read all of the agf and agi counters and check that they
- * are consistent with the superblock counters.
- */
-STATIC void
-xlog_recover_check_summary(
-	struct xlog		*log)
-{
-	struct xfs_mount	*mp = log->l_mp;
-	struct xfs_perag	*pag;
-	struct xfs_buf		*agfbp;
-	struct xfs_buf		*agibp;
-	xfs_agnumber_t		agno;
-	uint64_t		freeblks;
-	uint64_t		itotal;
-	uint64_t		ifree;
-	int			error;
-
-	freeblks = 0LL;
-	itotal = 0LL;
-	ifree = 0LL;
-	for_each_perag(mp, agno, pag) {
-		error = xfs_read_agf(mp, NULL, pag->pag_agno, 0, &agfbp);
-		if (error) {
-			xfs_alert(mp, "%s agf read failed agno %d error %d",
-						__func__, pag->pag_agno, error);
-		} else {
-			struct xfs_agf	*agfp = agfbp->b_addr;
-
-			freeblks += be32_to_cpu(agfp->agf_freeblks) +
-				    be32_to_cpu(agfp->agf_flcount);
-			xfs_buf_relse(agfbp);
-		}
-
-		error = xfs_read_agi(mp, NULL, pag->pag_agno, &agibp);
-		if (error) {
-			xfs_alert(mp, "%s agi read failed agno %d error %d",
-						__func__, pag->pag_agno, error);
-		} else {
-			struct xfs_agi	*agi = agibp->b_addr;
-
-			itotal += be32_to_cpu(agi->agi_count);
-			ifree += be32_to_cpu(agi->agi_freecount);
-			xfs_buf_relse(agibp);
-		}
-	}
-}
-#endif /* DEBUG */
-- 
2.20.1.7.g153144c

