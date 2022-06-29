Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F1455FA75
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiF2I1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiF2I0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:26:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40F63CA5A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r66so14656112pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdDNWS0N1qvnJfQ25v/RS+rQCZCKGnoXDZPV02ahj18=;
        b=Mn3g51LpoEJRQO+JVIvfJwcLpl2x0rEq2y7ZZi6Amc6vX8mqvg+cGS+qBDY4Qug+rU
         QAn2fpJFVWxqdcZgnu+sL3+vEAq6wnr5AVBsTtixjuWK7T/OxgvmJqow7QbOihZlaU6Q
         jfla/b+CZ86YgB9IzK9X89RlyuGRtMR9tRpIPinUGNzEuh30HERF5V+/qFP9ShLwNP8P
         m18ZtGetwTkFB525tdAvW60Ao90xBvDoJb+HzNXcT+m6pnnqtVK2X8CIoR9lP1/cQp+u
         px3gmiy4GRRff02ci7baSAnx8K9kO0lviSI+s9NOL433v4l2Ltb2idNp9oPf15uvRicp
         Qy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdDNWS0N1qvnJfQ25v/RS+rQCZCKGnoXDZPV02ahj18=;
        b=XcEpnvJcrJIv+shtPcFEwXfhdQS0s3z52LYL2S+SYVf7UqUKPgeAt8A7YGo3Ut8ao7
         Zie6CjtvE+NgNGTPDGCdYgbEaV4CaErFaRfVhCmLD7W13XzC+HzjSjH7FNbDzKy+8Cdw
         wEiYDyrUtlfHlsGVZfUS6diW2CM+ucycElZLChRHB0YZ9vyiCkXGfsvOCvPzckHnImdS
         NSp2NaQ2Vl1LixZprAkLxfvRGdsCu9RHgl7SqWbOrzrnZvP82s06gf2psFPmxQxiN7fQ
         jrc0xtY13XYPcxQG5Ak+rYQUeOMO68Em0w4otJLyjdSODD/AxOCGnvhU5tXKk6CraYbp
         QraQ==
X-Gm-Message-State: AJIora+emVINgDRrTmWws+Y9EgLeuMwsJDQgP/tOEZRVvIIXJD/lMsQX
        SXaPk1ezkE2zeRULuD56Ay9U
X-Google-Smtp-Source: AGRyM1sKjsilg6UCqmTF5QCwG1b8qKaQ0ysMyn8lKBlgt++PtByGTSsHrQeb4DtGTH+pB3e3bJn9Mw==
X-Received: by 2002:a63:2483:0:b0:40d:7d66:a86e with SMTP id k125-20020a632483000000b0040d7d66a86emr1981063pgk.161.1656491209317;
        Wed, 29 Jun 2022 01:26:49 -0700 (PDT)
Received: from localhost ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id a20-20020a170903101400b001641670d1adsm10668680plb.131.2022.06.29.01.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:26:48 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] vduse: Support registering userspace memory for IOTLB
Date:   Wed, 29 Jun 2022 16:25:40 +0800
Message-Id: <20220629082541.118-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629082541.118-1-xieyongji@bytedance.com>
References: <20220629082541.118-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce two ioctls: VDUSE_IOTLB_REG_UMEM and
VDUSE_IOTLB_DEREG_UMEM to support registering
and de-registering userspace memory for IOTLB
in virtio-vdpa case.

Now it only supports registering userspace memory
for IOTLB as bounce buffer.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 138 +++++++++++++++++++++++++++++
 include/uapi/linux/vduse.h         |  28 ++++++
 2 files changed, 166 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index c47a5d9765cf..7b2ea7612da9 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -21,6 +21,7 @@
 #include <linux/uio.h>
 #include <linux/vdpa.h>
 #include <linux/nospec.h>
+#include <linux/sched/mm.h>
 #include <uapi/linux/vduse.h>
 #include <uapi/linux/vdpa.h>
 #include <uapi/linux/virtio_config.h>
@@ -64,6 +65,13 @@ struct vduse_vdpa {
 	struct vduse_dev *dev;
 };
 
+struct vduse_iotlb_mem {
+	unsigned long iova;
+	unsigned long npages;
+	struct page **pages;
+	struct mm_struct *mm;
+};
+
 struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
@@ -95,6 +103,8 @@ struct vduse_dev {
 	u8 status;
 	u32 vq_num;
 	u32 vq_align;
+	struct vduse_iotlb_mem *iotlb_mem;
+	struct mutex mem_lock;
 };
 
 struct vduse_dev_msg {
@@ -917,6 +927,100 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 	return ret;
 }
 
+static int vduse_dev_dereg_iotlb_mem(struct vduse_dev *dev,
+				     u64 iova, u64 size)
+{
+	int ret;
+
+	mutex_lock(&dev->mem_lock);
+	ret = -ENOENT;
+	if (!dev->iotlb_mem)
+		goto unlock;
+
+	ret = -EINVAL;
+	if (dev->iotlb_mem->iova != iova || size != dev->domain->bounce_size)
+		goto unlock;
+
+	vduse_domain_remove_user_bounce_pages(dev->domain);
+	unpin_user_pages(dev->iotlb_mem->pages, dev->iotlb_mem->npages);
+	atomic64_sub(dev->iotlb_mem->npages, &dev->iotlb_mem->mm->pinned_vm);
+	mmdrop(dev->iotlb_mem->mm);
+	vfree(dev->iotlb_mem->pages);
+	kfree(dev->iotlb_mem);
+	dev->iotlb_mem = NULL;
+	ret = 0;
+unlock:
+	mutex_unlock(&dev->mem_lock);
+	return ret;
+}
+
+static int vduse_dev_reg_iotlb_mem(struct vduse_dev *dev,
+				   u64 iova, u64 uaddr, u64 size)
+{
+	struct page **page_list = NULL;
+	struct vduse_iotlb_mem *mem = NULL;
+	long pinned = 0;
+	unsigned long npages, lock_limit;
+	int ret;
+
+	if (size != dev->domain->bounce_size ||
+	    iova != 0 || uaddr & ~PAGE_MASK)
+		return -EINVAL;
+
+	mutex_lock(&dev->mem_lock);
+	ret = -EEXIST;
+	if (dev->iotlb_mem)
+		goto unlock;
+
+	ret = -ENOMEM;
+	npages = size >> PAGE_SHIFT;
+	page_list = vmalloc(array_size(npages,
+			    sizeof(struct page *)));
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!page_list || !mem)
+		goto unlock;
+
+	mmap_read_lock(current->mm);
+
+	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
+	if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
+		goto out;
+
+	pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
+				page_list, NULL);
+	if (pinned != npages) {
+		ret = pinned < 0 ? pinned : -ENOMEM;
+		goto out;
+	}
+
+	ret = vduse_domain_add_user_bounce_pages(dev->domain,
+						 page_list, pinned);
+	if (ret)
+		goto out;
+
+	atomic64_add(npages, &current->mm->pinned_vm);
+
+	mem->pages = page_list;
+	mem->npages = pinned;
+	mem->iova = iova;
+	mem->mm = current->mm;
+	mmgrab(current->mm);
+
+	dev->iotlb_mem = mem;
+out:
+	if (ret && pinned > 0)
+		unpin_user_pages(page_list, pinned);
+
+	mmap_read_unlock(current->mm);
+unlock:
+	if (ret) {
+		vfree(page_list);
+		kfree(mem);
+	}
+	mutex_unlock(&dev->mem_lock);
+	return ret;
+}
+
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -943,6 +1047,16 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (entry.start > entry.last)
 			break;
 
+		if (domain->bounce_map && dev->iotlb_mem) {
+			ret = -EEXIST;
+			if (entry.start >= 0 &&
+			    entry.last < domain->bounce_size)
+				break;
+
+			if (entry.start < domain->bounce_size)
+				entry.start = domain->bounce_size;
+		}
+
 		spin_lock(&domain->iotlb_lock);
 		map = vhost_iotlb_itree_first(domain->iotlb,
 					      entry.start, entry.last);
@@ -1102,6 +1216,28 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		ret = 0;
 		break;
 	}
+	case VDUSE_IOTLB_REG_UMEM: {
+		struct vduse_iotlb_umem umem;
+
+		ret = -EFAULT;
+		if (copy_from_user(&umem, argp, sizeof(umem)))
+			break;
+
+		ret = vduse_dev_reg_iotlb_mem(dev, umem.iova,
+					      umem.uaddr, umem.size);
+		break;
+	}
+	case VDUSE_IOTLB_DEREG_UMEM: {
+		struct vduse_iotlb_umem umem;
+
+		ret = -EFAULT;
+		if (copy_from_user(&umem, argp, sizeof(umem)))
+			break;
+
+		ret = vduse_dev_dereg_iotlb_mem(dev, umem.iova,
+						umem.size);
+		break;
+	}
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
@@ -1114,6 +1250,7 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 {
 	struct vduse_dev *dev = file->private_data;
 
+	vduse_dev_dereg_iotlb_mem(dev, 0, dev->domain->bounce_size);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
 	list_splice_init(&dev->recv_list, &dev->send_list);
@@ -1176,6 +1313,7 @@ static struct vduse_dev *vduse_dev_create(void)
 		return NULL;
 
 	mutex_init(&dev->lock);
+	mutex_init(&dev->mem_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
 	INIT_LIST_HEAD(&dev->recv_list);
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index c201b7a77c2c..1b17391e228f 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -227,6 +227,34 @@ struct vduse_iotlb_info {
 /* Get IOTLB information, e.g. bounce buffer size */
 #define VDUSE_IOTLB_GET_INFO    _IOR(VDUSE_BASE, 0x18, struct vduse_iotlb_info)
 
+/**
+ * struct vduse_iotlb_umem - userspace memory configuration
+ * @uaddr: start address of userspace memory, it must be aligned to page size
+ * @iova: IOVA of userspace memory, it must be equal to bounce iova returned
+ *        by VDUSE_IOTLB_GET_INFO now
+ * @size: size of userspace memory, it must be equal to bounce size returned
+ *        by VDUSE_IOTLB_GET_INFO now
+ * @reserved: for future use, needs to be initialized to zero
+ *
+ * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
+ * ioctls to register/de-register userspace memory for IOTLB.
+ */
+struct vduse_iotlb_umem {
+	__u64 uaddr;
+	__u64 iova;
+	__u64 size;
+	__u64 reserved[3];
+};
+
+/*
+ * Register userspace memory for IOTLB. Now we only support registering
+ * userspace memory as bounce buffer.
+ */
+#define VDUSE_IOTLB_REG_UMEM	_IOW(VDUSE_BASE, 0x19, struct vduse_iotlb_umem)
+
+/* De-register the userspace memory. Caller should set iova and size field. */
+#define VDUSE_IOTLB_DEREG_UMEM	_IOW(VDUSE_BASE, 0x1a, struct vduse_iotlb_umem)
+
 /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
 
 /**
-- 
2.20.1

