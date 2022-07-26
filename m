Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150705814CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiGZOK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiGZOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:10:26 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52C10A3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:10:24 -0700 (PDT)
Received: from [192.168.16.236] (helo=vzdev.sw.ru)
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1oGLFL-00C6Vd-Bj;
        Tue, 26 Jul 2022 16:09:38 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] Create debugfs file with virtio balloon usage information
Date:   Tue, 26 Jul 2022 14:08:27 +0000
Message-Id: <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the guest to know how much it is ballooned by the host
and how that memory is accounted.

It is useful when debugging out of memory conditions,
as well for userspace processes that monitor the memory pressure
and for nested virtualization.

Depending on the deflate on oom flag memory is accounted in two ways.
If the flag is set the inflated pages are accounted as used memory.
If the flag is not set the inflated pages are substracted from totalram.
To make clear how are inflated pages accounted sign prefix the value.
Where negative means substracted from totalram and positive means
they are accounted as used.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

V2:
  - fixed coding style
  - removed pretty print
V3:
  - removed dublicate of features
  - comment about balooned_pages more clear
  - convert host pages to balloon pages
V4:
  - added a define for BALLOON_PAGE_SIZE to make things clear
V5:
  - Made the calculatons work properly for both ways of memory accounting
    with or without deflate_on_oom
  - dropped comment
V6:
  - reduced the file to minimum
  - unify accounting

I didn't understand if you agree to change the accounting to be the same
so following part 2 is about it.


diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f4c34a2a6b8e..97d3b29cb9f1 100644
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
@@ -731,6 +732,59 @@ static void report_free_page_func(struct work_struct *work)
 	}
 }
 
+/*
+ * DEBUGFS Interface
+ */
+#ifdef CONFIG_DEBUG_FS
+
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
+	struct virtio_balloon *vb = f->private;
+	s64 num_pages = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);
+
+	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+		num_pages = -num_pages;
+
+	seq_printf(f, "inflated: %lld kB\n", num_pages);
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
@@ -1019,6 +1073,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
+
+	virtio_balloon_debugfs_init(vb);
+
 	return 0;
 
 out_unregister_oom:
@@ -1065,6 +1122,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 
+	virtio_balloon_debugfs_exit(vb);
+
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		page_reporting_unregister(&vb->pr_dev_info);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-- 
2.25.1

