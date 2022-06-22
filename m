Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072D05547C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353956AbiFVKbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiFVKbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:31:38 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298333A716
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:31:35 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id RIC00130;
        Wed, 22 Jun 2022 18:31:30 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2308.27; Wed, 22 Jun 2022 18:31:31 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] virtio_ring:Delete unused parameters for vring_alloc_desc_extra
Date:   Wed, 22 Jun 2022 06:31:20 -0400
Message-ID: <20220622103120.2297-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2022622183130c5d7720eeff8bed9b350ae9b7aa08bbd
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

So far, no use of vq has been found.We should delete it.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/virtio/virtio_ring.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 13a7348cedff..d30f18cab86b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1617,8 +1617,7 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 	return NULL;
 }
 
-static struct vring_desc_extra *vring_alloc_desc_extra(struct vring_virtqueue *vq,
-						       unsigned int num)
+static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
 {
 	struct vring_desc_extra *desc_extra;
 	unsigned int i;
@@ -1736,7 +1735,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	/* Put everything in free lists. */
 	vq->free_head = 0;
 
-	vq->packed.desc_extra = vring_alloc_desc_extra(vq, num);
+	vq->packed.desc_extra = vring_alloc_desc_extra(num);
 	if (!vq->packed.desc_extra)
 		goto err_desc_extra;
 
@@ -2217,7 +2216,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	if (!vq->split.desc_state)
 		goto err_state;
 
-	vq->split.desc_extra = vring_alloc_desc_extra(vq, vring.num);
+	vq->split.desc_extra = vring_alloc_desc_extra(vring.num);
 	if (!vq->split.desc_extra)
 		goto err_extra;
 
-- 
2.27.0

