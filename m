Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F9D57B011
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbiGTEm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbiGTEmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:42:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F5E5E839
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so1048576pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ui5VsOiqPlbFzgNja1ZpVg2rMEp2u3D+47XZRqpxdBk=;
        b=HtS3acIFgPtsTtHcSZM18KMc+EB1mh85pgY4A5BzMJcDqB+ddeWXtr+VPK2D1y0lWi
         4GgU0sr+nkLg/uA+Wi/b9Ir11MG+lXrvIK5dapRBY07X1ATi/EQ5oeMfaG5s/JizZ+T0
         ANIEEwTqDsbookSPhh6ORNdDAlLN/dnOi3cyD/tUmMseKRYiun+BxcjO5mLneurocD+1
         mhpDxphFqr5eyt0G+OcaQNPLux/NAMfsOD8SPbMpgY8WAp07HT7zVBR2MRCys+k7lxUI
         3HYKWDKn5/YJQw73DK/BCgXToae4ykwOqcYQKslLl59SHL9i0AkNFBCPmLC3Ssqtlb87
         ArFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ui5VsOiqPlbFzgNja1ZpVg2rMEp2u3D+47XZRqpxdBk=;
        b=5cjHDOlwjtcu0g6tDhLkKWHZDOxnZwtoyOenGvmPt3HoEy4W+O+rZ9xEQtQak1ucPW
         v900zdF89ffh0GWaCDHQFZBNZzeySk/ldRbEDynhtGWeEiI0Oi2aebZXrZa5iZg4WccG
         h9Uocb+tfC0QgR0jLgHscY9F7Bm8MgTuErROawVsO6a98SmFt8+djsUjkfuxyldCyvnq
         u/7YqtRFUrFEOTJBaqqzVsdE22x2p9pKQ2L5SIfqlh0ouee0hXzCwxAdZUpZyxdNZ+6F
         Fdrk/AgthYT2euAviYw+jW4gQzjAvzdHmfkDg+IINsoxNhThFpX+PEQ800eZbkkSkFnx
         uSeg==
X-Gm-Message-State: AJIora9GlzgyRj/qE/kZuNSZpAiYJFsdIvpHgWEqISp7uAMpDgrsyMz0
        sQBs/tyeYntf9SYsYxkjSzc5
X-Google-Smtp-Source: AGRyM1vzEZqDHVIKRxonl+LPdfdfLPeNpP+6+5j5JzZuZsUP5RFXh6Ra5RubPg6oqIe8JK21q8MY3g==
X-Received: by 2002:a17:903:22d2:b0:16c:5575:d510 with SMTP id y18-20020a17090322d200b0016c5575d510mr37376183plg.123.1658292138347;
        Tue, 19 Jul 2022 21:42:18 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b0016bec529f77sm632920plg.272.2022.07.19.21.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 21:42:17 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] vduse: Support registering userspace memory for IOVA regions
Date:   Wed, 20 Jul 2022 12:41:43 +0800
Message-Id: <20220720044144.90-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720044144.90-1-xieyongji@bytedance.com>
References: <20220720044144.90-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce two ioctls: VDUSE_IOTLB_REG_UMEM and
VDUSE_IOTLB_DEREG_UMEM to support registering
and de-registering userspace memory for IOVA
regions.

Now it only supports registering userspace memory
for bounce buffer region in virtio-vdpa case.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 141 +++++++++++++++++++++++++++++
 include/uapi/linux/vduse.h         |  23 +++++
 2 files changed, 164 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 3bc27de58f46..eedff0a3885a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -21,6 +21,8 @@
 #include <linux/uio.h>
 #include <linux/vdpa.h>
 #include <linux/nospec.h>
+#include <linux/vmalloc.h>
+#include <linux/sched/mm.h>
 #include <uapi/linux/vduse.h>
 #include <uapi/linux/vdpa.h>
 #include <uapi/linux/virtio_config.h>
@@ -64,6 +66,13 @@ struct vduse_vdpa {
 	struct vduse_dev *dev;
 };
 
+struct vduse_umem {
+	unsigned long iova;
+	unsigned long npages;
+	struct page **pages;
+	struct mm_struct *mm;
+};
+
 struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
@@ -95,6 +104,8 @@ struct vduse_dev {
 	u8 status;
 	u32 vq_num;
 	u32 vq_align;
+	struct vduse_umem *umem;
+	struct mutex mem_lock;
 };
 
 struct vduse_dev_msg {
@@ -917,6 +928,102 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 	return ret;
 }
 
+static int vduse_dev_dereg_umem(struct vduse_dev *dev,
+				u64 iova, u64 size)
+{
+	int ret;
+
+	mutex_lock(&dev->mem_lock);
+	ret = -ENOENT;
+	if (!dev->umem)
+		goto unlock;
+
+	ret = -EINVAL;
+	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
+		goto unlock;
+
+	vduse_domain_remove_user_bounce_pages(dev->domain);
+	unpin_user_pages_dirty_lock(dev->umem->pages,
+				    dev->umem->npages, true);
+	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
+	mmdrop(dev->umem->mm);
+	vfree(dev->umem->pages);
+	kfree(dev->umem);
+	dev->umem = NULL;
+	ret = 0;
+unlock:
+	mutex_unlock(&dev->mem_lock);
+	return ret;
+}
+
+static int vduse_dev_reg_umem(struct vduse_dev *dev,
+			      u64 iova, u64 uaddr, u64 size)
+{
+	struct page **page_list = NULL;
+	struct vduse_umem *umem = NULL;
+	long pinned = 0;
+	unsigned long npages, lock_limit;
+	int ret;
+
+	if (!dev->domain->bounce_map ||
+	    size != dev->domain->bounce_size ||
+	    iova != 0 || uaddr & ~PAGE_MASK)
+		return -EINVAL;
+
+	mutex_lock(&dev->mem_lock);
+	ret = -EEXIST;
+	if (dev->umem)
+		goto unlock;
+
+	ret = -ENOMEM;
+	npages = size >> PAGE_SHIFT;
+	page_list = __vmalloc(array_size(npages, sizeof(struct page *)),
+			      GFP_KERNEL_ACCOUNT);
+	umem = kzalloc(sizeof(*umem), GFP_KERNEL);
+	if (!page_list || !umem)
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
+	umem->pages = page_list;
+	umem->npages = pinned;
+	umem->iova = iova;
+	umem->mm = current->mm;
+	mmgrab(current->mm);
+
+	dev->umem = umem;
+out:
+	if (ret && pinned > 0)
+		unpin_user_pages(page_list, pinned);
+
+	mmap_read_unlock(current->mm);
+unlock:
+	if (ret) {
+		vfree(page_list);
+		kfree(umem);
+	}
+	mutex_unlock(&dev->mem_lock);
+	return ret;
+}
+
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -1089,6 +1196,38 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index].inject);
 		break;
 	}
+	case VDUSE_IOTLB_REG_UMEM: {
+		struct vduse_iova_umem umem;
+
+		ret = -EFAULT;
+		if (copy_from_user(&umem, argp, sizeof(umem)))
+			break;
+
+		ret = -EINVAL;
+		if (!is_mem_zero((const char *)umem.reserved,
+				 sizeof(umem.reserved)))
+			break;
+
+		ret = vduse_dev_reg_umem(dev, umem.iova,
+					 umem.uaddr, umem.size);
+		break;
+	}
+	case VDUSE_IOTLB_DEREG_UMEM: {
+		struct vduse_iova_umem umem;
+
+		ret = -EFAULT;
+		if (copy_from_user(&umem, argp, sizeof(umem)))
+			break;
+
+		ret = -EINVAL;
+		if (!is_mem_zero((const char *)umem.reserved,
+				 sizeof(umem.reserved)))
+			break;
+
+		ret = vduse_dev_dereg_umem(dev, umem.iova,
+					   umem.size);
+		break;
+	}
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
@@ -1101,6 +1240,7 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 {
 	struct vduse_dev *dev = file->private_data;
 
+	vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
 	list_splice_init(&dev->recv_list, &dev->send_list);
@@ -1163,6 +1303,7 @@ static struct vduse_dev *vduse_dev_create(void)
 		return NULL;
 
 	mutex_init(&dev->lock);
+	mutex_init(&dev->mem_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
 	INIT_LIST_HEAD(&dev->recv_list);
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 7cfe1c1280c0..9885e0571f09 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -210,6 +210,29 @@ struct vduse_vq_eventfd {
  */
 #define VDUSE_VQ_INJECT_IRQ	_IOW(VDUSE_BASE, 0x17, __u32)
 
+/**
+ * struct vduse_iova_umem - userspace memory configuration for one IOVA region
+ * @uaddr: start address of userspace memory, it must be aligned to page size
+ * @iova: start of the IOVA region
+ * @size: size of the IOVA region
+ * @reserved: for future use, needs to be initialized to zero
+ *
+ * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
+ * ioctls to register/de-register userspace memory for IOVA regions
+ */
+struct vduse_iova_umem {
+	__u64 uaddr;
+	__u64 iova;
+	__u64 size;
+	__u64 reserved[3];
+};
+
+/* Register userspace memory for IOVA regions */
+#define VDUSE_IOTLB_REG_UMEM	_IOW(VDUSE_BASE, 0x18, struct vduse_iova_umem)
+
+/* De-register the userspace memory. Caller should set iova and size field. */
+#define VDUSE_IOTLB_DEREG_UMEM	_IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
+
 /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
 
 /**
-- 
2.20.1

