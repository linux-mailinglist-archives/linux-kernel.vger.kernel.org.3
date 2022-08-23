Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A6F59CDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiHWBjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiHWBjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:39:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4125A1BEBF;
        Mon, 22 Aug 2022 18:39:47 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MBWy83wrgzXdvm;
        Tue, 23 Aug 2022 09:35:28 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 09:39:45 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <djwong@kernel.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] xfs: remove redundant else for clean code
Date:   Tue, 23 Aug 2022 09:47:45 +0800
Message-ID: <20220823014745.4156948-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"else" is not generally useful after a return, so remove it for clean code.

There is no logical changes.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/xfs/xfs_log.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 386b0307aed8..f6e7e4fd72ae 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -226,12 +226,12 @@ xlog_ticket_reservation(
 	if (head == &log->l_write_head) {
 		ASSERT(tic->t_flags & XLOG_TIC_PERM_RESERV);
 		return tic->t_unit_res;
-	} else {
-		if (tic->t_flags & XLOG_TIC_PERM_RESERV)
-			return tic->t_unit_res * tic->t_cnt;
-		else
-			return tic->t_unit_res;
 	}
+
+	if (tic->t_flags & XLOG_TIC_PERM_RESERV)
+		return tic->t_unit_res * tic->t_cnt;
+
+	return tic->t_unit_res;
 }
 
 STATIC bool
-- 
2.25.1

