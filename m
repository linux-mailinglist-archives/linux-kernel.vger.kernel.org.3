Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3848551224
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiFTIHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiFTIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:07:15 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD92D213
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:07:08 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id PGC00101;
        Mon, 20 Jun 2022 16:07:01 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2308.27; Mon, 20 Jun 2022 16:07:02 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] virtio_ring: Optimize duplicate judgment codes for virtqueue_add_split
Date:   Mon, 20 Jun 2022 04:06:56 -0400
Message-ID: <20220620080656.1559-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20226201607012893fc8a5ca814948df10f459f10d27a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We combine repeated judgments about indirect in one place

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/virtio/virtio_ring.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 13a7348cedff..331fa3cf5be7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -582,23 +582,19 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 					 total_sg * sizeof(struct vring_desc),
 					 VRING_DESC_F_INDIRECT,
 					 false);
+		vq->free_head = vq->split.desc_extra[head].next;
+		vq->split.desc_state[head].indir_desc = desc;
+	} else {
+		/* Update free pointer */
+		vq->free_head = i;
+		vq->split.desc_state[head].indir_desc = ctx;
 	}
 
 	/* We're using some buffers from the free list. */
 	vq->vq.num_free -= descs_used;
 
-	/* Update free pointer */
-	if (indirect)
-		vq->free_head = vq->split.desc_extra[head].next;
-	else
-		vq->free_head = i;
-
 	/* Store token and indirect buffer state. */
 	vq->split.desc_state[head].data = data;
-	if (indirect)
-		vq->split.desc_state[head].indir_desc = desc;
-	else
-		vq->split.desc_state[head].indir_desc = ctx;
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
-- 
2.27.0

