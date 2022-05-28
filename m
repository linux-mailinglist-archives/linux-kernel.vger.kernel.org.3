Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABB5536A07
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbiE1B7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 21:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354563AbiE1B7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 21:59:10 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33625D1A4;
        Fri, 27 May 2022 18:59:09 -0700 (PDT)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L94bT2BJtzDqVJ;
        Sat, 28 May 2022 09:59:01 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500022.china.huawei.com (7.221.188.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 09:59:07 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 09:59:07 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <yukuai3@huawei.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH -next v4 3/6] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
Date:   Sat, 28 May 2022 10:12:32 +0800
Message-ID: <20220528021235.2120995-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220528021235.2120995-1-yukuai3@huawei.com>
References: <20220528021235.2120995-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/block/nbd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2ee1e376d5c4..a673a97b9b6b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -403,13 +403,14 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	if (!mutex_trylock(&cmd->lock))
 		return BLK_EH_RESET_TIMER;
 
-	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
+	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
 		mutex_unlock(&cmd->lock);
 		return BLK_EH_DONE;
 	}
 
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		cmd->status = BLK_STS_TIMEOUT;
+		__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 		mutex_unlock(&cmd->lock);
 		goto done;
 	}
@@ -478,6 +479,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	dev_err_ratelimited(nbd_to_dev(nbd), "Connection timed out\n");
 	set_bit(NBD_RT_TIMEDOUT, &config->runtime_flags);
 	cmd->status = BLK_STS_IOERR;
+	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 	mutex_unlock(&cmd->lock);
 	sock_shutdown(nbd);
 	nbd_config_put(nbd);
@@ -745,7 +747,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 	cmd = blk_mq_rq_to_pdu(req);
 
 	mutex_lock(&cmd->lock);
-	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
+	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
 		dev_err(disk_to_dev(nbd->disk), "Suspicious reply %d (status %u flags %lu)",
 			tag, cmd->status, cmd->flags);
 		ret = -ENOENT;
@@ -813,6 +815,10 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 	}
 out:
 	trace_nbd_payload_received(req, handle);
+	if (!ret && likely(!blk_should_fake_timeout(req->q)))
+		__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
+	else if (!ret)
+		ret = -ENOENT;
 	mutex_unlock(&cmd->lock);
 	return ret ? ERR_PTR(ret) : cmd;
 }
@@ -854,8 +860,7 @@ static void recv_work(struct work_struct *work)
 		}
 
 		rq = blk_mq_rq_from_pdu(cmd);
-		if (likely(!blk_should_fake_timeout(rq->q)))
-			blk_mq_complete_request(rq);
+		blk_mq_complete_request(rq);
 		percpu_ref_put(&q->q_usage_counter);
 	}
 
-- 
2.31.1

