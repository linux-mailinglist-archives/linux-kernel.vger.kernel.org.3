Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9038C48B1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349762AbiAKQUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343692AbiAKQUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:20:00 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1FC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:20:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l4so11440137wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=788DtV6vo9SwBe7eTuihnRO6i8jSTvMov4ZaeZWVanU=;
        b=izGBaLmG850opO+rVIL+zvPnP3ujFBiINK1ZjaDqN2c0KYCiS+pEistB2nem0VTTKM
         vMBwdAITuj7VRtCxpiK6uKtnR+CvQPIxkqMvZX9X8ltFymZZTEK+Z2RQo08ppKoLy7E1
         eBaUwheYSLzH/QSvC4TbPVWCAG/oGw/+xOw5maNkEE68iwo2WtS/yxUtY9ziaYXkEqhf
         qfl9mSib4JXhcDzrWeV1bUI8uo7sbgG9BUNNxstDyFqPuhJGh+iCPXP2cC8EoHLLqjS+
         Y6ekhwMU1ncxI/Y3R/jWyqA6XkHrvkgtkyz8niinzXp+Yh+a5EQwnMNbGINM2m61WXJy
         hRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=788DtV6vo9SwBe7eTuihnRO6i8jSTvMov4ZaeZWVanU=;
        b=y+BSoBS0y6lEXTw2RbMxxLXIKLxUBgNbnyjsHpBKCYvMXYHq0gxwbFrmZs2d8kNSAg
         UAP3tNIBGEp3W95vCT6WMMbDhgHnMfgmkTyoUsrGG6rSkKJUeMKGe2TfrHFOJliFCjd9
         M7ZtXoWLg9gqQhW7HhYc0K+GyleAtjaQ+hsHbICbAFUiT+gz57UuSJHtFEzl04Yb5TsU
         CCjtkFm1H/sATwlNNE9F1LQDGbi5+ZyK64bqVhaP/SwKcld4lcQ6xu+GNm0Qd6pK4Fny
         B1VVJrntkgid6j2En111lNCln3h7PADZJOqTiHkP7uL3HtBta2x4AgQ5JemTpAC4lwoc
         KIJg==
X-Gm-Message-State: AOAM533Pr5BEm3XzF4iVwA2IRyrqu6T+DErX9HxwoziqU8zPB4A6b8On
        bS4SzUOBhk4eVVssrPDTehM=
X-Google-Smtp-Source: ABdhPJwreHRf8KWXWtGPj9Q16m/S6zNq7h/IhkFQTzFFcuA50BGFgn+k4DcVG2wjSslm6NAcB1956w==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr3209806wmj.56.1641917998829;
        Tue, 11 Jan 2022 08:19:58 -0800 (PST)
Received: from lb01399.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id p18sm3012397wmq.0.2022.01.11.08.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:19:58 -0800 (PST)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     nvdimm@lists.linux.dev, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, jmoyer@redhat.com, stefanha@redhat.com,
        david@redhat.com, mst@redhat.com, cohuck@redhat.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, pankaj.gupta@ionos.com,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [RFC v3 1/2] virtio-pmem: Async virtio-pmem flush
Date:   Tue, 11 Jan 2022 17:19:36 +0100
Message-Id: <20220111161937.56272-2-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable asynchronous flush for virtio pmem using work queue. Also,
coalesce the flush requests when a flush is already in process.
This functionality is copied from md/RAID code.

When a flush is already in process, new flush requests wait till
previous flush completes in another context (work queue). For all
the requests come between ongoing flush and new flush start time, only
single flush executes, thus adhers to flush coalscing logic. This is
important for maintaining the flush request order with request coalscing.

Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 drivers/nvdimm/nd_virtio.c   | 74 +++++++++++++++++++++++++++---------
 drivers/nvdimm/virtio_pmem.c | 10 +++++
 drivers/nvdimm/virtio_pmem.h | 16 ++++++++
 3 files changed, 83 insertions(+), 17 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 10351d5b49fa..179ea7a73338 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -100,26 +100,66 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 /* The asynchronous flush callback function */
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 {
-	/*
-	 * Create child bio for asynchronous flush and chain with
-	 * parent bio. Otherwise directly call nd_region flush.
+	/* queue asynchronous flush and coalesce the flush requests */
+	struct virtio_device *vdev = nd_region->provider_data;
+	struct virtio_pmem *vpmem  = vdev->priv;
+	ktime_t req_start = ktime_get_boottime();
+	int ret = -EINPROGRESS;
+
+	spin_lock_irq(&vpmem->lock);
+	/* flush requests wait until ongoing flush completes,
+	 * hence coalescing all the pending requests.
 	 */
-	if (bio && bio->bi_iter.bi_sector != -1) {
-		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
-
-		if (!child)
-			return -ENOMEM;
-		bio_copy_dev(child, bio);
-		child->bi_opf = REQ_PREFLUSH;
-		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
-		return 0;
+	wait_event_lock_irq(vpmem->sb_wait,
+			    !vpmem->flush_bio ||
+			    ktime_before(req_start, vpmem->prev_flush_start),
+			    vpmem->lock);
+	/* new request after previous flush is completed */
+	if (ktime_after(req_start, vpmem->prev_flush_start)) {
+		WARN_ON(vpmem->flush_bio);
+		vpmem->flush_bio = bio;
+		bio = NULL;
+	}
+	spin_unlock_irq(&vpmem->lock);
+
+	if (!bio)
+		queue_work(vpmem->pmem_wq, &vpmem->flush_work);
+	else {
+	/* flush completed in other context while we waited */
+		if (bio && (bio->bi_opf & REQ_PREFLUSH))
+			bio->bi_opf &= ~REQ_PREFLUSH;
+		else if (bio && (bio->bi_opf & REQ_FUA))
+			bio->bi_opf &= ~REQ_FUA;
+
+		ret = vpmem->prev_flush_err;
 	}
-	if (virtio_pmem_flush(nd_region))
-		return -EIO;
 
-	return 0;
+	return ret;
 };
 EXPORT_SYMBOL_GPL(async_pmem_flush);
+
+void submit_async_flush(struct work_struct *ws)
+{
+	struct virtio_pmem *vpmem = container_of(ws, struct virtio_pmem, flush_work);
+	struct bio *bio = vpmem->flush_bio;
+
+	vpmem->start_flush = ktime_get_boottime();
+	vpmem->prev_flush_err = virtio_pmem_flush(vpmem->nd_region);
+	vpmem->prev_flush_start = vpmem->start_flush;
+	vpmem->flush_bio = NULL;
+	wake_up(&vpmem->sb_wait);
+
+	if (vpmem->prev_flush_err)
+		bio->bi_status = errno_to_blk_status(-EIO);
+
+	/* Submit parent bio only for PREFLUSH */
+	if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
+		bio->bi_opf &= ~REQ_PREFLUSH;
+		submit_bio(bio);
+	} else if (bio && (bio->bi_opf & REQ_FUA)) {
+		bio->bi_opf &= ~REQ_FUA;
+		bio_endio(bio);
+	}
+}
+EXPORT_SYMBOL_GPL(submit_async_flush);
 MODULE_LICENSE("GPL");
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 726c7354d465..75ed9b7ddea1 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -24,6 +24,7 @@ static int init_vq(struct virtio_pmem *vpmem)
 		return PTR_ERR(vpmem->req_vq);
 
 	spin_lock_init(&vpmem->pmem_lock);
+	spin_lock_init(&vpmem->lock);
 	INIT_LIST_HEAD(&vpmem->req_list);
 
 	return 0;
@@ -57,7 +58,14 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
 		goto out_err;
 	}
+	vpmem->pmem_wq = alloc_workqueue("vpmem_wq", WQ_MEM_RECLAIM, 0);
+	if (!vpmem->pmem_wq) {
+		err = -ENOMEM;
+		goto out_err;
+	}
 
+	INIT_WORK(&vpmem->flush_work, submit_async_flush);
+	init_waitqueue_head(&vpmem->sb_wait);
 	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
 			start, &vpmem->start);
 	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
@@ -90,10 +98,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_nd;
 	}
 	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
+	vpmem->nd_region = nd_region;
 	return 0;
 out_nd:
 	nvdimm_bus_unregister(vpmem->nvdimm_bus);
 out_vq:
+	destroy_workqueue(vpmem->pmem_wq);
 	vdev->config->del_vqs(vdev);
 out_err:
 	return err;
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index 0dddefe594c4..495dc20e1cdb 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -35,9 +35,24 @@ struct virtio_pmem {
 	/* Virtio pmem request queue */
 	struct virtqueue *req_vq;
 
+	struct bio *flush_bio;
+	/* last_flush is when the last completed flush was started */
+	ktime_t prev_flush_start, start_flush;
+	int prev_flush_err;
+
+	/* work queue for deferred flush */
+	struct work_struct flush_work;
+	struct workqueue_struct *pmem_wq;
+
+	/* Synchronize flush wait queue data */
+	spinlock_t lock;
+	/* for waiting for previous flush to complete */
+	wait_queue_head_t sb_wait;
+
 	/* nvdimm bus registers virtio pmem device */
 	struct nvdimm_bus *nvdimm_bus;
 	struct nvdimm_bus_descriptor nd_desc;
+	struct nd_region *nd_region;
 
 	/* List to store deferred work if virtqueue is full */
 	struct list_head req_list;
@@ -52,4 +67,5 @@ struct virtio_pmem {
 
 void virtio_pmem_host_ack(struct virtqueue *vq);
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
+void submit_async_flush(struct work_struct *ws);
 #endif
-- 
2.25.1

