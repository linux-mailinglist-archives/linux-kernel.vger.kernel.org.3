Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB150FDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350284AbiDZM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350260AbiDZM4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:56:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99717D4AD;
        Tue, 26 Apr 2022 05:53:36 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Knhd943FzzhYmX;
        Tue, 26 Apr 2022 20:53:17 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 20:53:34 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 20:53:33 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 3/6] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
Date:   Tue, 26 Apr 2022 21:07:43 +0800
Message-ID: <20220426130746.885140-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220426130746.885140-1-yukuai3@huawei.com>
References: <20220426130746.885140-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise io will hung because request will only be completed if the
cmd has the flag 'NBD_CMD_INFLIGHT'.

Fixes: 07175cb1baf4 ("nbd: make sure request completion won't concurrent")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c0a787cb5153..4829868706af 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -429,6 +429,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 		 * a new connection is reconfigured or util dead timeout.
 		 */
 		if (config->socks) {
+			__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 			if (cmd->index < config->num_connections) {
 				struct nbd_sock *nsock =
 					config->socks[cmd->index];
@@ -456,6 +457,8 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 		 * so just warn and reset the timer.
 		 */
 		struct nbd_sock *nsock = config->socks[cmd->index];
+
+		__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 		cmd->retries++;
 		dev_info(nbd_to_dev(nbd), "Possible stuck request %p: control (%s@%llu,%uB). Runtime %u seconds\n",
 			req, nbdcmd_to_ascii(req_to_nbd_cmd_type(req)),
@@ -756,31 +759,31 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 		dev_err(disk_to_dev(nbd->disk), "Unexpected reply %d from different sock %d (expected %d)",
 			tag, index, cmd->index);
 		ret = -ENOENT;
-		goto out;
+		goto out_reset_inflight;
 	}
 	if (cmd->cmd_cookie != nbd_handle_to_cookie(handle)) {
 		dev_err(disk_to_dev(nbd->disk), "Double reply on req %p, cmd_cookie %u, handle cookie %u\n",
 			req, cmd->cmd_cookie, nbd_handle_to_cookie(handle));
 		ret = -ENOENT;
-		goto out;
+		goto out_reset_inflight;
 	}
 	if (cmd->status != BLK_STS_OK) {
 		dev_err(disk_to_dev(nbd->disk), "Command already handled %p\n",
 			req);
 		ret = -ENOENT;
-		goto out;
+		goto out_reset_inflight;
 	}
 	if (test_bit(NBD_CMD_REQUEUED, &cmd->flags)) {
 		dev_err(disk_to_dev(nbd->disk), "Raced with timeout on req %p\n",
 			req);
 		ret = -ENOENT;
-		goto out;
+		goto out_reset_inflight;
 	}
 	if (ntohl(reply->error)) {
 		dev_err(disk_to_dev(nbd->disk), "Other side returned error (%d)\n",
 			ntohl(reply->error));
 		cmd->status = BLK_STS_IOERR;
-		goto out;
+		goto out_reset_inflight;
 	}
 
 	dev_dbg(nbd_to_dev(nbd), "request %p: got reply\n", req);
@@ -803,15 +806,22 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 				 */
 				if (nbd_disconnected(nbd->config)) {
 					cmd->status = BLK_STS_IOERR;
-					goto out;
+					goto out_reset_inflight;
 				}
 				ret = -EIO;
-				goto out;
+				goto out_reset_inflight;
 			}
 			dev_dbg(nbd_to_dev(nbd), "request %p: got %d bytes data\n",
 				req, bvec.bv_len);
 		}
 	}
+out_reset_inflight:
+	if (ret)
+		/*
+		 * Caller will not complete the request, thus set the flag so
+		 * that it can be completed from other context.
+		 */
+		__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 out:
 	trace_nbd_payload_received(req, handle);
 	mutex_unlock(&cmd->lock);
@@ -857,6 +867,9 @@ static void recv_work(struct work_struct *work)
 		rq = blk_mq_rq_from_pdu(cmd);
 		if (likely(!blk_should_fake_timeout(rq->q)))
 			blk_mq_complete_request(rq);
+		else
+			/* Timeout rely on this flag to complete request. */
+			__test_and_set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 		percpu_ref_put(&q->q_usage_counter);
 	}
 
-- 
2.31.1

