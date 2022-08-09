Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D23E58D6DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiHIJyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiHIJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:54:30 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B886237CC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:54:29 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1oLLv2-00ElXo-EF;
        Tue, 09 Aug 2022 11:53:59 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] Drivers: virtio: balloon: Report inflated memory
Date:   Tue,  9 Aug 2022 12:53:58 +0300
Message-Id: <20220809095358.2203355-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
References: <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
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

Update the value in page_alloc on balloon fill/leak.

Cc: David Hildenbrand <david@redhat.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Nadav Amit <namit@vmware.com>

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/virtio/virtio_balloon.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

Firts user, other balloons i will do if it is accepted to avoid too much emails.


diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index b9737da6c4dd..e2693ffbd48b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -208,6 +208,16 @@ static void set_page_pfns(struct virtio_balloon *vb,
 					  page_to_balloon_pfn(page) + i);
 }
 
+static void update_meminfo(struct virtio_balloon *vb)
+{
+	long inflated_kb = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);
+
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+		inflated_kb = -inflated_kb;
+
+	atomic_long_set(&mem_balloon_inflated_kb, inflated_kb);
+}
+
 static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 {
 	unsigned int num_allocated_pages;
@@ -250,6 +260,7 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 	}
 
 	num_allocated_pages = vb->num_pfns;
+	update_meminfo(vb);
 	/* Did we get any? */
 	if (vb->num_pfns != 0)
 		tell_host(vb, vb->inflate_vq);
@@ -296,6 +307,7 @@ static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
 	}
 
 	num_freed_pages = vb->num_pfns;
+	update_meminfo(vb);
 	/*
 	 * Note that if
 	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
@@ -1089,6 +1101,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
 
 	kern_unmount(balloon_mnt);
 #endif
+	update_meminfo(0);
 	kfree(vb);
 }
 
-- 
2.31.1

