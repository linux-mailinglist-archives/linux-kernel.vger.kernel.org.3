Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E94259C18A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbiHVOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiHVOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:24:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1327F2C12A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:24:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so12855023ejt.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UqdwmA13nyBstb3LLHqV9cDnbeU1qajuXcxfCTpGT0U=;
        b=Rt/5FX0mvQ+cMkyy5Jj6jYpCapyl2esoEAIsyUXJIoJokJfwF6rolyOBCRPiOTdFK/
         kr2v3SaXXMG4NYskxUPtAzy/bdASHponLcF9h1VaEjV48GkzSYyvlqztGiPLmgDwvYaA
         evStkYIty6U8+b+ilmVO9pCUsRx5JcZAalEdKvmIufgb/hlzQD1V2WNKb6yR07S+tyYC
         VM61J4Q2PHmrJtqUUI55KGTNrymqF87fAeG3+9Ag51W/dpDW2TsgKk0mnhuj1NnP3ua6
         3a2yTS2CuV0gDtqXQoMS7p7p89PzuvUr0Y+jBQ75L99bvaHYt2f1yszRdIHSteQU5tCs
         H4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UqdwmA13nyBstb3LLHqV9cDnbeU1qajuXcxfCTpGT0U=;
        b=FIukLrcLdduGtLQUqJspCGxO7dumsfR3jZmY/W/MHh0JjNp0qfDYp9jwcjks9fm02Y
         4GhIEBsX5Eg49r8mxsxWw9SGnI75g4W/FxWGMQp5+dEdHaF2vlpsgJOKKfiGkGTH0Ycv
         O6eZJRSs488sGb8o703vEh0XrxT9ntBKHr2MDe51RWl9SiCvTUNaYay7om1oy/17uMHm
         bStUDQlcooT3SKY0W7wQimLyUs82gYZyc0WAQh62SDavUG1Xr/3nd3/bj/MZEtrKJ5Cy
         17d67Xh1aZGypnemrY7gCGz2T/qxQkOZDiY0OYXqa/2gtRDqPzNPNPuSzZXsp3zyZydA
         /pHw==
X-Gm-Message-State: ACgBeo0T94TNdHDZ+ByaNaRqR6RgeuU8acG6QbRF6tzSkbN2GbQKPI0q
        WPxmTe1bVrg3a5oTv7gqFGM=
X-Google-Smtp-Source: AA6agR4m2NrHXm24VJGTtiRTJFIWJpt0bKcmR0lG6LI+zTpSqNmwDv5doKvm3NI1wWuB4R6HCJG4pQ==
X-Received: by 2002:a17:907:7d91:b0:731:7ecb:1e5b with SMTP id oz17-20020a1709077d9100b007317ecb1e5bmr12910146ejc.78.1661178290533;
        Mon, 22 Aug 2022 07:24:50 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id h4-20020a170906398400b0073151ce7726sm6286083eje.100.2022.08.22.07.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:24:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date:   Mon, 22 Aug 2022 16:24:38 +0200
Message-Id: <20220822142438.5954-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822142438.5954-1-fmdefrancesco@gmail.com>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().[1]

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

The pages which will be mapped are allocated in nvmet_tcp_map_data(),
using the GFP_KERNEL flag. This assures that they cannot come from
HIGHMEM. This imply that a straight page_address() can replace the kmap()
of sg_page(sg) in nvmet_tcp_map_pdu_iovec(). As a side effect, we might
also delete the field "nr_mapped" from struct "nvmet_tcp_cmd" because,
after removing the kmap() calls, there would be no longer any need of it.

Therefore, replace the kmap() of sg_page(sg) with a page_address() and
delete the "nr_mapped" field from "nvmet_tcp_cmd" and instead pass a
local variable to iov_iter_kvec() from the call site in
nvmet_tcp_map_pdu_iovec().

Test with blktests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

[1] "[PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated
list" https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/nvme/target/tcp.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..2e2a7367b77e 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -77,7 +77,6 @@ struct nvmet_tcp_cmd {
 	u32				pdu_len;
 	u32				pdu_recv;
 	int				sg_idx;
-	int				nr_mapped;
 	struct msghdr			recv_msg;
 	struct kvec			*iov;
 	u32				flags;
@@ -167,7 +166,6 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
-static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -301,35 +299,21 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 {
-	WARN_ON(unlikely(cmd->nr_mapped > 0));
-
 	kfree(cmd->iov);
 	sgl_free(cmd->req.sg);
 	cmd->iov = NULL;
 	cmd->req.sg = NULL;
 }
 
-static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)
-{
-	struct scatterlist *sg;
-	int i;
-
-	sg = &cmd->req.sg[cmd->sg_idx];
-
-	for (i = 0; i < cmd->nr_mapped; i++)
-		kunmap(sg_page(&sg[i]));
-
-	cmd->nr_mapped = 0;
-}
-
 static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct kvec *iov = cmd->iov;
 	struct scatterlist *sg;
 	u32 length, offset, sg_offset;
+	int nr_mapped;
 
 	length = cmd->pdu_len;
-	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
+	nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
 	offset = cmd->rbytes_done;
 	cmd->sg_idx = offset / PAGE_SIZE;
 	sg_offset = offset % PAGE_SIZE;
@@ -338,7 +322,8 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
+		iov->iov_base = page_address(sg_page(sg)) +
+				sg->offset + sg_offset;
 		iov->iov_len = iov_len;
 
 		length -= iov_len;
@@ -348,7 +333,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	}
 
 	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
-		cmd->nr_mapped, cmd->pdu_len);
+		      nr_mapped, cmd->pdu_len);
 }
 
 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
@@ -1141,7 +1126,6 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	if (queue->data_digest) {
 		nvmet_tcp_prep_recv_ddgst(cmd);
 		return 0;
@@ -1411,7 +1395,6 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 {
 	nvmet_req_uninit(&cmd->req);
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	nvmet_tcp_free_cmd_buffers(cmd);
 }
 
@@ -1424,7 +1407,6 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 		if (nvmet_tcp_need_data_in(cmd))
 			nvmet_req_uninit(&cmd->req);
 
-		nvmet_tcp_unmap_pdu_iovec(cmd);
 		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
-- 
2.37.2

