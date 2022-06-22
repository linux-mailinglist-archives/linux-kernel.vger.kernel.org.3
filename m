Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2CD554492
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351178AbiFVIKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350705AbiFVIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:10:45 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E582A37AB0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:10:43 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id RGH00140;
        Wed, 22 Jun 2022 16:10:40 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2308.27; Wed, 22 Jun 2022 16:10:40 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] virtio_ring: remove unnecessary to_vvq call in virtqueue_enable_cb_prepare_packed
Date:   Wed, 22 Jun 2022 04:10:38 -0400
Message-ID: <20220622081038.1681-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2022622161040b21c479fd5829ea88279af39af35a8f5
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

It passes '_vq' to virtqueue_use_indirect(), which still calls
to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
unnecessary call of to_vvq in hot path.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/virtio/virtio_ring.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 13a7348cedff..3418e10f21a5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1486,10 +1486,8 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 	}
 }
 
-static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	START_USE(vq);
 
 	/*
@@ -2032,7 +2030,7 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 	if (vq->event_triggered)
 		vq->event_triggered = false;
 
-	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
+	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
 				 virtqueue_enable_cb_prepare_split(_vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
-- 
2.27.0

