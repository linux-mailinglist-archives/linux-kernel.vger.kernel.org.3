Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70852057B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbiEITyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiEITy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:54:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34331F2C2A;
        Mon,  9 May 2022 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652125835; x=1683661835;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=4lF5eKVzZJ607ZK+N219R0WFG63ugDlCSKTeifbf0n4=;
  b=tOhpqQ6LP9ujjEfKG3u20PsDZacmNLPex0VavbjIDpalc5IOKhsuwqQR
   y3bOi6UlmAoCpCV5+lggkJTPi2JBzbRntIqO4GAJ3mLeq2A2N+r8XnG9d
   1v7sxTg3gsrD7zNBeRASvZxbMGropBdhNU1CaP4xmqgJccKYXmZLiytg5
   Y=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 12:50:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 12:50:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 12:50:32 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 12:50:28 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
        <hridya@google.com>, <daniel.vetter@ffwll.ch>,
        <gregkh@linuxfoundation.org>
CC:     <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <tjmercier@google.com>,
        Charan Teja Reddy <quic_charante@quicinc.com>
Subject: [PATCH] dma-buf: call dma_buf_stats_setup after dmabuf is in valid list
Date:   Tue, 10 May 2022 01:19:57 +0530
Message-ID: <1652125797-2043-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charan Teja Reddy <quic_charante@quicinc.com>

When dma_buf_stats_setup() fails, it closes the dmabuf file which
results into the calling of dma_buf_file_release() where it does
list_del(&dmabuf->list_node) with out first adding it to the proper
list. This is resulting into panic in the below path:
__list_del_entry_valid+0x38/0xac
dma_buf_file_release+0x74/0x158
__fput+0xf4/0x428
____fput+0x14/0x24
task_work_run+0x178/0x24c
do_notify_resume+0x194/0x264
work_pending+0xc/0x5f0

Fix it by moving the dma_buf_stats_setup() after dmabuf is added to the
list.

Fixes: bdb8d06dfefd ("dmabuf: Add the capability to expose DMA-BUF stats in sysfs")
Signed-off-by: Charan Teja Reddy <quic_charante@quicinc.com>
---
 drivers/dma-buf/dma-buf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 602b12d..a6fc96e 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -543,10 +543,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	file->f_mode |= FMODE_LSEEK;
 	dmabuf->file = file;
 
-	ret = dma_buf_stats_setup(dmabuf);
-	if (ret)
-		goto err_sysfs;
-
 	mutex_init(&dmabuf->lock);
 	INIT_LIST_HEAD(&dmabuf->attachments);
 
@@ -554,6 +550,10 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	list_add(&dmabuf->list_node, &db_list.head);
 	mutex_unlock(&db_list.lock);
 
+	ret = dma_buf_stats_setup(dmabuf);
+	if (ret)
+		goto err_sysfs;
+
 	return dmabuf;
 
 err_sysfs:
-- 
2.7.4

