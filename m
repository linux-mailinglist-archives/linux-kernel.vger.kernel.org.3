Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94A95958C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiHPKrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbiHPKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:46:06 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED6ADEA7B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:54:39 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1oNt3t-00FxfB-7a;
        Tue, 16 Aug 2022 11:41:48 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drivers: virtio: balloon - update inflated memory
Date:   Tue, 16 Aug 2022 12:41:17 +0300
Message-Id: <20220816094117.3144881-5-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the inflated memory when it changes.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/virtio/virtio_balloon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 6f69e483d98a..c8093c704c2f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -450,10 +450,15 @@ static void virtballoon_changed(struct virtio_device *vdev)
 static void update_balloon_size(struct virtio_balloon *vb)
 {
 	u32 actual = vb->num_pages;
+	long inflated_kb = actual << (VIRTIO_BALLOON_PFN_SHIFT - 10);
 
 	/* Legacy balloon config space is LE, unlike all other devices. */
 	virtio_cwrite_le(vb->vdev, struct virtio_balloon_config, actual,
 			 &actual);
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+		balloon_set_inflated_free(inflated_kb);
+	else
+		balloon_set_inflated_total(inflated_kb);
 }
 
 static void update_balloon_stats_func(struct work_struct *work)
-- 
2.31.1

