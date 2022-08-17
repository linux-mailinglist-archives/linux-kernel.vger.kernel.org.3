Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B035974C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbiHQREi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbiHQREf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:04:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1587E828
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:04:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z2so18338891edc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=iKUCUDi2SfnduC7piObEFyzun59ij4PD/TgFI7EIPmE=;
        b=GVobNuPoIQk4FYGcP5+3o2DPEfAa9CaGLRS4Y0kS6qBp1dkyPuJqdY9Uyv6LTVRQr4
         BtsQZvO4xsLmkXoIvBhY4oQLm4spLxNNfnyJCl92Mj+pr9gIrzde5LPF1HxbFwvPkb3A
         AO4jkbGr272w1Oyhs6nH9ub0c71YdATQLtlk84mfIWaliHof5629cV4bQh74Z6ImNGAh
         3EragBVnAQS7KyKu8Oh51dka1ZgYquBLpIAuUq8ZO0Jo0DTKGpT4Q2xFYfqI556zWgzq
         vlcOdQXZ6iWulSa/HQ7z5IOlxxLKUqZZXvcccgnou4hvuznlN+/pYlhvStiFbddbC8OU
         fMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=iKUCUDi2SfnduC7piObEFyzun59ij4PD/TgFI7EIPmE=;
        b=uNAft1qXf/F8znbr7w98zoTmJrWc+zgacaDvBCs699gEc2haA0FjQqjAprXbnN7XgH
         EALghUgVgIiJJ7VP5ODgm1HfH/r6GkCYxg9S6old4NWlqupeC40LW8pkSL3JjacFUWx/
         dlVgYpEv4YZ5CWjWH14oomiibm3qOA4wxAMLbd6F4Q2/5mjnbvQOGFb8Gd9OtsT2WHEy
         KWmoIkzbuur1ek2SO/awnacy/S+k7bOLgahHOcTptMpjnxzmGeInibNFT7lvnpPaytlo
         +ZA5m7SynC4K7V/eP+Qjtkx13prNCSH4qKupz8/Mi+5DqB3XNgU559+ilclngl8WJRqX
         SCVA==
X-Gm-Message-State: ACgBeo2GamBXYzQD4FHo6UWE51rrWGYS/o+/sBC080VNeZUTzgeYGVJa
        kbiDkSsMj40ZdyFEOIxugjA=
X-Google-Smtp-Source: AA6agR5pYx0/TsNQJIeMVJc58mUylsDroBV3h72JoICmf0cjWMdAtAjbSGIc0HxQ+ssspQkYIJdBew==
X-Received: by 2002:a05:6402:7c8:b0:445:ce63:7ab0 with SMTP id u8-20020a05640207c800b00445ce637ab0mr4577377edy.8.1660755872875;
        Wed, 17 Aug 2022 10:04:32 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id kx18-20020a170907775200b007341663d7ddsm6962978ejc.96.2022.08.17.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:04:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date:   Wed, 17 Aug 2022 19:04:27 +0200
Message-Id: <20220817170427.15682-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
delete the "nr_mapped" field from "nvmet_tcp_cmd".

[1] "[PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated
list" https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Thanks so much to Chaitanya, Keith, Sagi, for the answers and the comments
on the RFC which gave birth to this patch. The RFC is at:
https://lore.kernel.org/all/20220816091808.23236-1-fmdefrancesco@gmail.com/

 drivers/nvme/target/tcp.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..6ed44531de55 100644
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
@@ -301,27 +299,12 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 
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
@@ -329,7 +312,6 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	u32 length, offset, sg_offset;
 
 	length = cmd->pdu_len;
-	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
 	offset = cmd->rbytes_done;
 	cmd->sg_idx = offset / PAGE_SIZE;
 	sg_offset = offset % PAGE_SIZE;
@@ -338,7 +320,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
+		iov->iov_base = page_address(sg_page(sg)) + sg->offset + sg_offset;
 		iov->iov_len = iov_len;
 
 		length -= iov_len;
@@ -347,8 +329,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 		sg_offset = 0;
 	}
 
-	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
-		cmd->nr_mapped, cmd->pdu_len);
+	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov, 0, cmd->pdu_len);
 }
 
 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
@@ -1141,7 +1122,6 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	if (queue->data_digest) {
 		nvmet_tcp_prep_recv_ddgst(cmd);
 		return 0;
@@ -1411,7 +1391,6 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 {
 	nvmet_req_uninit(&cmd->req);
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	nvmet_tcp_free_cmd_buffers(cmd);
 }
 
@@ -1424,7 +1403,6 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 		if (nvmet_tcp_need_data_in(cmd))
 			nvmet_req_uninit(&cmd->req);
 
-		nvmet_tcp_unmap_pdu_iovec(cmd);
 		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
-- 
2.37.1

