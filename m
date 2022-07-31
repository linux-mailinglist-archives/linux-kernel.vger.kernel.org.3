Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383D8585DDF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiGaHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 03:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiGaHKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 03:10:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF262120AC;
        Sun, 31 Jul 2022 00:09:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bf13so7152475pgb.11;
        Sun, 31 Jul 2022 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVVea980B8st8DA18ARnaDm7eXyjZl5zQLRXfKhT3UM=;
        b=PqaaFnKVJy7/fLrOYcyuSlfWuoKRQmjHrjB/lcxbzvqbvVZbQovuf6tjUuJdCsMncO
         ZNf9OF1fIShOw5FfVmk2r/KZmOnpNc9WXZ+Jv39SIP5eDAjLQ3PGLLeQEMnO/HuSX2z9
         0zGh7rKO4nUm4lQp9PEHXP9hwYwqJL3GZ9W8iTIFw7sd26vpZ7aqSadtwJkbTI42WL8H
         Gr3WWElGbtN1zgTsSRTNlE7S6G+1GRcBTKv2pcpdXqj9rAq+neGJeCXiGYU/YINFaNYd
         FogiQ5cSW2L/TaOeHT5AldPOeC+UCFeKxJZuX3QsIy9uEOeRuWDAZbqChXmpMJGsAmf0
         tAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVVea980B8st8DA18ARnaDm7eXyjZl5zQLRXfKhT3UM=;
        b=3Re31C8/eGn0aK8B1OjTMit2umO8FaCa81nhSmpsasGJG03EcB6KlBXxqdVsLfHv2p
         UpC4NmCLh1uJvdx7q4KK7+LSVAl8UR7HtfBGfFseUQdcwOKbMdOeqxxpug1KI2Y2oaK6
         jGUIiDNwyc9PL79+73ooY4x3xq301YTtslwz5La2BilEXmEVkGaH33mrkbovnUXjfRLb
         cHJEJrpEg7MoezJMubPfdEDDsyrcswqZD2MIISRjgETAjIv51pmesLt9WmTp8kpR4TZG
         +xdzr9D4v6WYSPZtxVNvolRqlMOOfZNZXZQxg31dOP6TI+eYvW9ZUWJP+IJIcXAZRzFz
         ebOA==
X-Gm-Message-State: AJIora9xZxWp61rkyjcKmNPSzT0YsWcVCJapnF240Gdcyzn/ZDXoLY/R
        oZrEhrsa5EBAhihB505Xuw==
X-Google-Smtp-Source: AGRyM1sep/xzs0hUqyqt4S9YvKeNZ1I4Z44CYT8pI0M3F75ZXvITvNN/ECFwrJEHULN+JSJADBziLQ==
X-Received: by 2002:a65:6a55:0:b0:41b:7a0b:672c with SMTP id o21-20020a656a55000000b0041b7a0b672cmr9105366pgu.594.1659251399215;
        Sun, 31 Jul 2022 00:09:59 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id y21-20020a1709027c9500b0016bef6f6903sm6786755pll.72.2022.07.31.00.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 00:09:58 -0700 (PDT)
From:   Shigeru Yoshida <shigeru.yoshida@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk
Cc:     pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <shigeru.yoshida@gmail.com>
Subject: [PATCH] virtio-blk: Avoid use-after-free on suspend/resume
Date:   Sun, 31 Jul 2022 16:09:51 +0900
Message-Id: <20220731070951.196831-1-shigeru.yoshida@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hctx->user_data is set to vq in virtblk_init_hctx().  However, vq is
freed on suspend and reallocated on resume.  So, hctx->user_data is
invalid after resume, and it will cause use-after-free accessing which
will result in the kernel crash something like below:

[   22.428391] Call Trace:
[   22.428899]  <TASK>
[   22.429339]  virtqueue_add_split+0x3eb/0x620
[   22.430035]  ? __blk_mq_alloc_requests+0x17f/0x2d0
[   22.430789]  ? kvm_clock_get_cycles+0x14/0x30
[   22.431496]  virtqueue_add_sgs+0xad/0xd0
[   22.432108]  virtblk_add_req+0xe8/0x150
[   22.432692]  virtio_queue_rqs+0xeb/0x210
[   22.433330]  blk_mq_flush_plug_list+0x1b8/0x280
[   22.434059]  __blk_flush_plug+0xe1/0x140
[   22.434853]  blk_finish_plug+0x20/0x40
[   22.435512]  read_pages+0x20a/0x2e0
[   22.436063]  ? folio_add_lru+0x62/0xa0
[   22.436652]  page_cache_ra_unbounded+0x112/0x160
[   22.437365]  filemap_get_pages+0xe1/0x5b0
[   22.437964]  ? context_to_sid+0x70/0x100
[   22.438580]  ? sidtab_context_to_sid+0x32/0x400
[   22.439979]  filemap_read+0xcd/0x3d0
[   22.440917]  xfs_file_buffered_read+0x4a/0xc0
[   22.441984]  xfs_file_read_iter+0x65/0xd0
[   22.442970]  __kernel_read+0x160/0x2e0
[   22.443921]  bprm_execve+0x21b/0x640
[   22.444809]  do_execveat_common.isra.0+0x1a8/0x220
[   22.446008]  __x64_sys_execve+0x2d/0x40
[   22.446920]  do_syscall_64+0x37/0x90
[   22.447773]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

This patch fixes this issue by getting vq from vblk, and removes
virtblk_init_hctx().

Signed-off-by: Shigeru Yoshida <shigeru.yoshida@gmail.com>
---
 drivers/block/virtio_blk.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6fc7850c2b0a..d756423e0059 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -101,6 +101,14 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
 	}
 }
 
+static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
+{
+	struct virtio_blk *vblk = hctx->queue->queuedata;
+	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
+
+	return vq;
+}
+
 static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 {
 	struct scatterlist hdr, status, *sgs[3];
@@ -416,7 +424,7 @@ static void virtio_queue_rqs(struct request **rqlist)
 	struct request *requeue_list = NULL;
 
 	rq_list_for_each_safe(rqlist, req, next) {
-		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
+		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
 		bool kick;
 
 		if (!virtblk_prep_rq_batch(req)) {
@@ -837,7 +845,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
 static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct virtio_blk *vblk = hctx->queue->queuedata;
-	struct virtio_blk_vq *vq = hctx->driver_data;
+	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
 	struct virtblk_req *vbr;
 	unsigned long flags;
 	unsigned int len;
@@ -862,22 +870,10 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	return found;
 }
 
-static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
-			  unsigned int hctx_idx)
-{
-	struct virtio_blk *vblk = data;
-	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
-
-	WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
-	hctx->driver_data = vq;
-	return 0;
-}
-
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.queue_rqs	= virtio_queue_rqs,
 	.commit_rqs	= virtio_commit_rqs,
-	.init_hctx	= virtblk_init_hctx,
 	.complete	= virtblk_request_done,
 	.map_queues	= virtblk_map_queues,
 	.poll		= virtblk_poll,
-- 
2.37.1

