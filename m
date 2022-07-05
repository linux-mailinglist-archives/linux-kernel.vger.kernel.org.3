Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6342256652A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiGEIiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiGEIh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:37:59 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732512DC5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=VyOLurVZjtDB3kThqOnTi5a2yvQPYVuIPD89MQGJIaQ=; b=WSpoIukIgNEl
        UGkprsGzrdgdkO/+4VWFp7BmBl3h1ZXTpQLEA4Fg2DoQRc8GDV3M3nouWEVMA0PTE4Ys1tIU8xAn1
        LNLQfc2byOBwxYBPVX+nPfkD6jI9IkO89ZrZY+ViBIdk8ogORwv/IsUwlKZYkyxD3AG/P4W0mPtjv
        Z8BDY=;
Received: from [192.168.16.236] (helo=vzdev.sw.ru)
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1o8e2z-008ksn-3u;
        Tue, 05 Jul 2022 10:36:41 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] Create debugfs file with virtio balloon usage information
Date:   Tue,  5 Jul 2022 08:36:37 +0000
Message-Id: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the guest to know how much it is ballooned by the host.
It is useful when debugging out of memory conditions.

When host gets back memory from the guest it is accounted
as used memory in the guest but the guest have no way to know
how much it is actually ballooned.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/virtio/virtio_balloon.c     | 77 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_balloon.h |  1 +
 2 files changed, 78 insertions(+)

V2:
 - fixed coding style
 - removed pretty print
V3:
 - removed dublicate of features
 - comment about balooned_pages more clear
 - convert host pages to balloon pages
V4:
 - added a define for BALLOON_PAGE_SIZE to make things clear

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index b9737da6c4dd..dc4ad584b947 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -10,6 +10,7 @@
 #include <linux/virtio_balloon.h>
 #include <linux/swap.h>
 #include <linux/workqueue.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -731,6 +732,77 @@ static void report_free_page_func(struct work_struct *work)
 	}
 }
 
+/*
+ * DEBUGFS Interface
+ */
+#ifdef CONFIG_DEBUG_FS
+
+#define guest_to_balloon_pages(i) ((i)*VIRTIO_BALLOON_PAGES_PER_PAGE)
+/**
+ * virtio_balloon_debug_show - shows statistics of balloon operations.
+ * @f: pointer to the &struct seq_file.
+ * @offset: ignored.
+ *
+ * Provides the statistics that can be accessed in virtio-balloon in the debugfs.
+ *
+ * Return: zero on success or an error code.
+ */
+
+static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
+{
+	struct virtio_balloon *b = f->private;
+	u32 num_pages;
+	struct sysinfo i;
+
+	si_meminfo(&i);
+
+	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);
+
+	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
+			&num_pages);
+	/*
+	 * Pages allocated by host from the guest memory.
+	 * Host inflates the balloon to get more memory.
+	 * Guest needs to deflate the balloon to get more memory.
+	 */
+	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
+
+	/* Total Memory for the guest from host */
+	seq_printf(f, "%-22s: %lu\n", "total_pages",
+			guest_to_balloon_pages(i.totalram));
+
+	/* Current memory for the guest */
+	seq_printf(f, "%-22s: %lu\n", "current_pages",
+			guest_to_balloon_pages(i.totalram) - num_pages);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(virtio_balloon_debug);
+
+static void  virtio_balloon_debugfs_init(struct virtio_balloon *b)
+{
+	debugfs_create_file("virtio-balloon", 0444, NULL, b,
+			    &virtio_balloon_debug_fops);
+}
+
+static void  virtio_balloon_debugfs_exit(struct virtio_balloon *b)
+{
+	debugfs_remove(debugfs_lookup("virtio-balloon", NULL));
+}
+
+#else
+
+static inline void virtio_balloon_debugfs_init(struct virtio_balloon *b)
+{
+}
+
+static inline void virtio_balloon_debugfs_exit(struct virtio_balloon *b)
+{
+}
+
+#endif	/* CONFIG_DEBUG_FS */
+
 #ifdef CONFIG_BALLOON_COMPACTION
 /*
  * virtballoon_migratepage - perform the balloon page migration on behalf of
@@ -1019,6 +1091,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
+
+	virtio_balloon_debugfs_init(vb);
+
 	return 0;
 
 out_unregister_oom:
@@ -1065,6 +1140,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 
+	virtio_balloon_debugfs_exit(vb);
+
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		page_reporting_unregister(&vb->pr_dev_info);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ddaa45e723c4..f3ff7c4e5884 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -40,6 +40,7 @@
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
+#define VIRTIO_BALLOON_PAGE_SIZE (1<<VIRTIO_BALLOON_PFN_SHIFT)
 
 #define VIRTIO_BALLOON_CMD_ID_STOP	0
 #define VIRTIO_BALLOON_CMD_ID_DONE	1
-- 
2.25.1

