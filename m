Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DDB4B9C90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbiBQJ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:56:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbiBQJ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:56:09 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6089D14FBE3;
        Thu, 17 Feb 2022 01:55:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0V4iq.VG_1645091744;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V4iq.VG_1645091744)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 17:55:51 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     xfs <linux-xfs@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] xfs: add missing cmap->br_state = XFS_EXT_NORM update
Date:   Thu, 17 Feb 2022 17:55:42 +0800
Message-Id: <20220217095542.68085-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

COW extents are already converted into written real extents after
xfs_reflink_convert_cow_locked(), therefore cmap->br_state should
reflect it.

Otherwise, there is another necessary unwritten convertion
triggered in xfs_dio_write_end_io() for direct I/O cases.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
From the logic itself and runtime tracing, IMO, it seems true.
Kindly correct me here if my understanding is wrong.

 fs/xfs/xfs_reflink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 75bd2e03cd5b..5f0a364739a5 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -424,7 +424,10 @@ xfs_reflink_allocate_cow(
 	if (!convert_now || cmap->br_state == XFS_EXT_NORM)
 		return 0;
 	trace_xfs_reflink_convert_cow(ip, cmap);
-	return xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
+	error = xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
+	if (!error)
+		cmap->br_state = XFS_EXT_NORM;
+	return error;
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
-- 
2.24.4

