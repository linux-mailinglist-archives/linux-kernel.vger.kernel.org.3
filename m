Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C584823FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 13:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhLaMYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 07:24:03 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52715 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229985AbhLaMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 07:24:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0RHZP-_1640953434;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V0RHZP-_1640953434)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 Dec 2021 20:23:59 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] net/tls: Remove redundant initialization of mp
Date:   Fri, 31 Dec 2021 20:23:52 +0800
Message-Id: <20211231122352.14275-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mp is being initialized to log->l_mp but this is never read
as record is overwritten later on. Remove the redundant
initialization.

Cleans up the following clang-analyzer warning:

fs/xfs/xfs_log_recover.c:3543:20: warning: Value stored to 'mp' during
its initialization is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/xfs/xfs_log_recover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 8ecb9a8567b7..9142efbdc670 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -3540,7 +3540,7 @@ STATIC void
 xlog_recover_check_summary(
 	struct xlog		*log)
 {
-	struct xfs_mount	*mp = log->l_mp;
+	struct xfs_mount	*mp;
 	struct xfs_perag	*pag;
 	struct xfs_buf		*agfbp;
 	struct xfs_buf		*agibp;
-- 
2.20.1.7.g153144c

