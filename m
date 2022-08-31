Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3275A7368
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiHaBf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiHaBfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:35:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BA41A82B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:35:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t5so12811505pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=knSzJ4dgeDj1o+u9CcFXOjTBfzT4aiSB8/Bqvma9o8g=;
        b=GZm5pbpNoC3XLieL8BPHiDbQb9KAVxXNGYD2Y3++Amrr0/SkYVcVXNaYa2M5g7qsz3
         LMdoo1sCWsPox3Cxey4qa3k/0fWz3YSP7PR7ncmKjOgaSw/tIgef2BQ9KNg+O2z3+M0v
         YPqzZxUFbF9yJH8dMQNDr172j7xt8RnvTDt8RMhzXPaW3tu963DHfHDazRaIxUZmHXcw
         GRzsxiybW67sPCFQ9huiTdrmlB4IXQqp+0tX8siY8yS3v3rLOnUxFZ483nuYzUh9xQGd
         mPYrB5pf1BKFTWePvyd290e7LlhwESC7dp+FpMYTAzwhUmo7h0wKY2XPrZyXacdsaM0a
         svdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=knSzJ4dgeDj1o+u9CcFXOjTBfzT4aiSB8/Bqvma9o8g=;
        b=4UsYOVAFIXd9WM/FEalESiFE39HespLNoodxjIK/NKaXRolP/pepzoN/icojMqQ+cH
         JCHPS6EUA76n5wO4D6XUdrP0BqCw7SiJo08Aywkyc86F1ehoJqoNz4yJjQ0SD5zet6ym
         XlFXfh2WWSN9inUM6C4mecD7BOf68kuMV1fq31gs3Rch5tJ4arv2uwWlRzzVJ0wjS7dh
         Lne5TqaCij2BbFXQ76HZ/sHexglU1IkrKXqHI9NKQgGIrgigJx7ErFbpH41MhxvDSbFU
         UZydLvW+L0vt4CrIRcEBo0NtPdW4x1k9a3cFAwRW7PLgbOrXa7B2MwwPMVSv6yPpucj4
         ewsw==
X-Gm-Message-State: ACgBeo2NCQPV6BNGrgY/T5eZH4qVqB3J7tsTVIyYZBMwc8BHnibqTyvM
        kwrTSVNw/v4A1FebveaIGkTN4w==
X-Google-Smtp-Source: AA6agR43f6DFVqqsLW57CRQgWL4izuczvGKbiaYQNDUy2H5LH0LpYWtirupIcJoggPxCHQGv9D+yww==
X-Received: by 2002:a17:902:e5c3:b0:175:534:1735 with SMTP id u3-20020a170902e5c300b0017505341735mr7778141plf.87.1661909683391;
        Tue, 30 Aug 2022 18:34:43 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id r36-20020a17090a43a700b001f50e4c43c4sm202891pjg.22.2022.08.30.18.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:34:43 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me
Cc:     kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 1/1] nvmet-tcp: Fix NULL pointer dereference during release
Date:   Wed, 31 Aug 2022 09:34:02 +0800
Message-Id: <20220831013402.514055-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831013402.514055-1-pizhenwei@bytedance.com>
References: <20220831013402.514055-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
and waits the inflight IO requests in nvmet_sq_destroy(). During wait
the inflight IO requests, the callback nvmet_tcp_queue_response()
is called from backend after IO complete, this leads a typical
Use-After-Free issue like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 14 PID: 207 Comm: kworker/14:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #12
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
 RIP: 0010:shash_ahash_digest+0x2b/0x110
 Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
 RSP: 0018:ffffc900006e3dd8 EFLAGS: 00010206
 RAX: 0000000000001000 RBX: ffff888104ac1650 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff888104ac1650 RDI: ffff888104ac1600
 RBP: ffff888104ac1600 R08: ffff8881073980c8 R09: ffff8881057798b8
 R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
 R13: 0000000000000000 R14: ffff88810601a1cc R15: ffff888107398000
 FS:  0000000000000000(0000) GS:ffff88823fd80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 000000010a8e8000 CR4: 0000000000350ee0
 Call Trace:
  <TASK>
  nvmet_tcp_io_work+0xa1c/0xb1c [nvmet_tcp]
  ? __switch_to+0x106/0x420
  process_one_work+0x1ae/0x380
  ? process_one_work+0x380/0x380
  worker_thread+0x30/0x360
  ? process_one_work+0x380/0x380
  kthread+0xe6/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30

Suggested by Sagi, separate nvmet_tcp_uninit_data_in_cmds() into two
steps:
  uninit req          <- new step 1
  nvmet_sq_destroy();
  free CMD buffers    <- new step 2

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..3bfd139b1434 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1415,7 +1415,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 	nvmet_tcp_free_cmd_buffers(cmd);
 }
 
-static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
+static void nvmet_tcp_uninit_req(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
 	int i;
@@ -1423,14 +1423,27 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		if (nvmet_tcp_need_data_in(cmd))
 			nvmet_req_uninit(&cmd->req);
+	}
+
+	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
+		/* failed in connect */
+		nvmet_req_uninit(&queue->connect.req);
+	}
+}
+
+static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_cmd *cmd = queue->cmds;
+	int i;
 
+	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		nvmet_tcp_unmap_pdu_iovec(cmd);
 		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
-		/* failed in connect */
-		nvmet_tcp_finish_cmd(&queue->connect);
+		nvmet_tcp_unmap_pdu_iovec(&queue->connect);
+		nvmet_tcp_free_cmd_buffers(&queue->connect);
 	}
 }
 
@@ -1449,8 +1462,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
-	nvmet_tcp_uninit_data_in_cmds(queue);
+	nvmet_tcp_uninit_req(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
+	nvmet_tcp_uninit_data_in_cmds(queue);
 	cancel_work_sync(&queue->io_work);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
-- 
2.20.1

