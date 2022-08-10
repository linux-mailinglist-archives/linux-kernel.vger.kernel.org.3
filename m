Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5058F01F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiHJQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiHJQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74A8B7C745
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660147807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EKo8MVKlyw+SXHb20Eh7M8mnIDKk4tia9D6xw3EgvBA=;
        b=MaoFxXwKHVOMv1/3VVUFC875hs4K8RNeextOZSfUUxD8tIJX1IWFBuRTki8kzdADkXs1LF
        cb6CcynKaz9SFFgcsnw7DCCDmtyzybmv+Hr/bTnmwvTIQgsv3jxk2AwazKufm5X4MGVdWe
        q5hZ0Uw8WYtOhnRZIH+jJ/hSOroX+jM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-aCbHZpyhMoKmsGvqUbBrkw-1; Wed, 10 Aug 2022 12:10:05 -0400
X-MC-Unique: aCbHZpyhMoKmsGvqUbBrkw-1
Received: by mail-pl1-f197.google.com with SMTP id q11-20020a170902dacb00b0016efd6984c3so10090475plx.17
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=EKo8MVKlyw+SXHb20Eh7M8mnIDKk4tia9D6xw3EgvBA=;
        b=azaD6xlbKtjc2UKuzlrC6SAhhHBZIoCpXOgHTNxMfV0g8CWarsBqXiqMRt2pgXvcOQ
         0/Sa9IIkoqgkymKjc5HZ0rDKY6neAzAYaxjC732e7G3si5ehjN8wwWHje4XdknRfe0dH
         jOafL4N7w4MKLjP+k4to5a8vL4CcmjoODEIhu9/LyE6Y6fTT3ZD59GP5+660PRImrL2f
         fiTVo42ObGiqhm9muWVR0mt3JpIQOdd+AVh0rqs2IQHUlq34WCw25nFisWWOw3lUKGAy
         St079XlT2bGywGIB8zaVNxaZJ/m5a0V1bkS+JCG8enSzTjwP/iUoDWUGlsQzkKnGfQZw
         XU5A==
X-Gm-Message-State: ACgBeo1/SVlzpl1rL/o2NcO3ed92Cf18EGc/tN4IujnjfiisKfUNrd58
        S4QLfxPlGVhnpLIWhGftnXmhrWedbPQh8ie9H5ed6KEy/KqEkOgm2eXwhFKleL2EFaom4d+Radb
        0V/QUAhN3fVie3yk7JpTINYvs
X-Received: by 2002:a17:90a:c205:b0:1f5:1041:a4ff with SMTP id e5-20020a17090ac20500b001f51041a4ffmr4421859pjt.14.1660147804219;
        Wed, 10 Aug 2022 09:10:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5GLuV2/hBEjYTz01Fw2asicci9chTvjWSKIlU1dYjF3QgCwW0tiO66AT8MrmKNBgHK7p2k8A==
X-Received: by 2002:a17:90a:c205:b0:1f5:1041:a4ff with SMTP id e5-20020a17090ac20500b001f51041a4ffmr4421830pjt.14.1660147803925;
        Wed, 10 Aug 2022 09:10:03 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090a928b00b001ef8780f873sm1810449pjo.39.2022.08.10.09.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:10:03 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk
Cc:     pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        suwan.kim027@gmail.com, Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH v2] virtio-blk: Avoid use-after-free on suspend/resume
Date:   Thu, 11 Aug 2022 01:09:48 +0900
Message-Id: <20220810160948.959781-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
Cc: "Suwan Kim" <suwan.kim027@gmail.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
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

