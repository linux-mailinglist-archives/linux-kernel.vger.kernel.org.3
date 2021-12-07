Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854F246C234
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbhLGR7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhLGR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:59:05 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A081C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:55:35 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so2496536pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YlKrbuhCHTae2u1Y/zo8WJTwjtVLySYksifYtybTVfs=;
        b=FOckHv3XOouJ9S2q95J4Cu0FBJwSpL2wI/fqHN5SVTFfPUJWVIyaQ8UpLwiqGbMmGp
         sH0f7823uN4mdr+JTaQ9hB4NYPCngP6qIlCWxArmJVcMMVKJbqf5YGSwRz0fTs5Jty8e
         Zlgfi2LwDXgkoRqU9E6ws57R9Nn7rEhSqdOyNIFxcSY/FQEf5cTGJRTTmZG7JEAlFTis
         BKJf2ud0OK37P4VBkvnYV0b+rqDBc+cUQj8yTiuuIYetsyRNZc0uFSvqLrMAiea2PsZK
         p91AfOTULMZjXzj/mj0D/v2J47qSDnPxM0YPv7wM4W8mu0ozXWmxBRu8nyttIHM/kpCR
         ocpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YlKrbuhCHTae2u1Y/zo8WJTwjtVLySYksifYtybTVfs=;
        b=we9h+maPNyVr7cWXQr1xsr/JjQ6BfHpRxR9c4/2oU6g2RXGRWBt7etqjrxiCE0fpqD
         xLg+LMtCeEeM85BcfI9/tUZXECBoEz7kemIx2HEwjmnp13gZYNBNJgiiMB37HXtv5dSX
         65HXYoMCqeUq4bfSmZLoYyQdeYIt0pxT3QV3ubd2quhknat3Jjrav0BatwB6TU4ATlQo
         82DtxNoL9eQfoopBwQ2w+XPg0qH9lD0srYGcfbLXZkqhCNWobNBdOHkJbev8o2B6koM8
         ZqOj6oTg8gXM0A4g1iX82km7u+XQjO81JOjBIDseyyT6MeZt/1qhg0FSPgBvAgba77Vh
         xZLw==
X-Gm-Message-State: AOAM530L24x1AZe7R1u4F4IvAw6QwEWTxsxk089o4Ju4X65D0QfA/sJ7
        R7xY8NlBwFN9xmWPljFu1n5qHg==
X-Google-Smtp-Source: ABdhPJwHY617fI8tDISKb0kXt+LzLLihZSWfvl82RRy3AvYsbekjyFnQYLugV72iQyPpICHlbIoqmw==
X-Received: by 2002:a17:90b:2251:: with SMTP id hk17mr628368pjb.31.1638899734876;
        Tue, 07 Dec 2021 09:55:34 -0800 (PST)
Received: from egranata-desktop.mtv.corp.google.com (098-127-066-156.res.spectrum.com. [98.127.66.156])
        by smtp.gmail.com with ESMTPSA id c6sm371281pfv.54.2021.12.07.09.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:55:34 -0800 (PST)
From:   Enrico Granata <egranata@android.com>
Cc:     Enrico Granata <egranata@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] virtio_blk: Add support for lifetime feature
Date:   Tue,  7 Dec 2021 10:55:17 -0700
Message-Id: <20211207175518.1703314-1-egranata@android.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@google.com>

The VirtIO TC has adopted a new feature in virtio-blk enabling
discovery of lifetime information.

This commit adds support for the VIRTIO_BLK_T_LIFETIME command
to the virtio_blk driver, and adds new attributes to the
sysfs entry for virtio_blk:
* pre_eol_info
* life_time_a
* life_time_b

which are defined in the VirtIO specification.

Signed-off-by: Enrico Granata <egranata@google.com>
---
Changes in v3:
 - Split life_time attribute in two
 - Made VirtIO specification independent of eMMC
 - Adopted newer APIs to mirror surrounding code

 drivers/block/virtio_blk.c      | 106 ++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_blk.h |  11 ++++
 2 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6ae38776e30e..c50f5d9a173b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -213,7 +213,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 				      struct virtblk_req *vbr)
 {
 	bool unmap = false;
-	u32 type;
+	u32 type = 0;
 
 	vbr->out_hdr.sector = 0;
 
@@ -239,14 +239,14 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 		unmap = !(req->cmd_flags & REQ_NOUNMAP);
 		break;
 	case REQ_OP_DRV_IN:
-		type = VIRTIO_BLK_T_GET_ID;
-		break;
+		break; /* type already set for custom requests */
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_IOERR;
 	}
 
-	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
+	if (req_op(req) != REQ_OP_DRV_IN)
+		vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
 	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
 	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES) {
@@ -374,11 +374,14 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	struct virtio_blk *vblk = disk->private_data;
 	struct request_queue *q = vblk->disk->queue;
 	struct request *req;
+	struct virtblk_req *vbr;
 	int err;
 
 	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
+	vbr = blk_mq_rq_to_pdu(req);
+	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
 
 	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
 	if (err)
@@ -391,6 +394,35 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	return err;
 }
 
+static int virtblk_get_lifetime(struct gendisk *disk, struct virtio_blk_lifetime *lifetime)
+{
+	struct virtio_blk *vblk = disk->private_data;
+	struct request_queue *q = vblk->disk->queue;
+	struct request *req;
+	struct virtblk_req *vbr;
+	int err;
+
+	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
+		return -EOPNOTSUPP;
+
+	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	vbr = blk_mq_rq_to_pdu(req);
+	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_LIFETIME);
+
+	err = blk_rq_map_kern(q, req, lifetime, sizeof(*lifetime), GFP_KERNEL);
+	if (err)
+		goto out;
+
+	blk_execute_rq(vblk->disk, req, false);
+	err = blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
+out:
+	blk_mq_free_request(req);
+	return err;
+}
+
+
 static void virtblk_get(struct virtio_blk *vblk)
 {
 	refcount_inc(&vblk->refs);
@@ -499,6 +531,68 @@ static ssize_t serial_show(struct device *dev,
 
 static DEVICE_ATTR_RO(serial);
 
+static ssize_t pre_eol_info_show(struct device *dev,
+								 struct device_attribute *attr,
+								 char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct virtio_blk_lifetime lft;
+	int err;
+
+	/* sysfs gives us a PAGE_SIZE buffer */
+	BUILD_BUG_ON(sizeof(lft) >= PAGE_SIZE);
+
+	err = virtblk_get_lifetime(disk, &lft);
+	if (err)
+		return 0;
+
+	return sprintf(buf, "0x%02x\n", le16_to_cpu(lft.pre_eol_info));
+}
+
+static DEVICE_ATTR_RO(pre_eol_info);
+
+static ssize_t life_time_a_show(struct device *dev,
+								struct device_attribute *attr,
+								char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct virtio_blk_lifetime lft;
+	int err;
+
+	/* sysfs gives us a PAGE_SIZE buffer */
+	BUILD_BUG_ON(sizeof(lft) >= PAGE_SIZE);
+
+	err = virtblk_get_lifetime(disk, &lft);
+	if (err)
+		return 0;
+
+	return sprintf(buf, "0x%02x\n",
+		le16_to_cpu(lft.device_life_time_est_typ_a));
+}
+
+static DEVICE_ATTR_RO(life_time_a);
+
+static ssize_t life_time_b_show(struct device *dev,
+								struct device_attribute *attr,
+								char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct virtio_blk_lifetime lft;
+	int err;
+
+	/* sysfs gives us a PAGE_SIZE buffer */
+	BUILD_BUG_ON(sizeof(lft) >= PAGE_SIZE);
+
+	err = virtblk_get_lifetime(disk, &lft);
+	if (err)
+		return 0;
+
+	return sprintf(buf, "0x%02x\n",
+		le16_to_cpu(lft.device_life_time_est_typ_b));
+}
+
+static DEVICE_ATTR_RO(life_time_b);
+
 /* The queue's logical block size must be set before calling this */
 static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 {
@@ -702,6 +796,9 @@ static DEVICE_ATTR_RW(cache_type);
 static struct attribute *virtblk_attrs[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_cache_type.attr,
+	&dev_attr_pre_eol_info.attr,
+	&dev_attr_life_time_a.attr,
+	&dev_attr_life_time_b.attr,
 	NULL,
 };
 
@@ -1042,6 +1139,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+	VIRTIO_BLK_F_LIFETIME,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index d888f013d9ff..7ca0b3aac570 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -40,6 +40,7 @@
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
 #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
+#define VIRTIO_BLK_F_LIFETIME  15 /* LIFETIME is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -149,6 +150,9 @@ struct virtio_blk_config {
 /* Get device ID command */
 #define VIRTIO_BLK_T_GET_ID    8
 
+/* Get device lifetime command */
+#define VIRTIO_BLK_T_GET_LIFETIME 10
+
 /* Discard command */
 #define VIRTIO_BLK_T_DISCARD	11
 
@@ -160,6 +164,13 @@ struct virtio_blk_config {
 #define VIRTIO_BLK_T_BARRIER	0x80000000
 #endif /* !VIRTIO_BLK_NO_LEGACY */
 
+/* Lifetime information for virtio_blk device */
+struct virtio_blk_lifetime {
+	__le16 pre_eol_info;
+	__le16 device_life_time_est_typ_a;
+	__le16 device_life_time_est_typ_b;
+};
+
 /*
  * This comes first in the read scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated,
-- 
2.34.1.400.ga245620fadb-goog

