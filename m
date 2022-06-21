Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF85537A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353853AbiFUQNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353913AbiFUQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0633CEB5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655827981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Us38wkS1w1HtLwDGe0amETwreFLuOach8d2EKXd31Cw=;
        b=GsxuVcuUVajaIt6OwoHzXwOFIwWpMwsca4qTB/IV7xw40N/9J90p4vpJp4mpW/C1z5vqpd
        360bUErhkUx9SXmVwvwU2atspAc5WgP3IdANAWmHBU+OOJVOhtnqpzNfEuTidIXCErFY7L
        D7yD2WZbuB8XOTmXnwRVi2gXusX7vig=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-36ubX7ofPSSvIJYNNNsjHw-1; Tue, 21 Jun 2022 12:13:00 -0400
X-MC-Unique: 36ubX7ofPSSvIJYNNNsjHw-1
Received: by mail-qk1-f200.google.com with SMTP id ay8-20020a05620a178800b006a76e584761so16890391qkb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Us38wkS1w1HtLwDGe0amETwreFLuOach8d2EKXd31Cw=;
        b=ixTDcBQgXRbDZrJqpWnxjJQUesMTZx6BHOInNOOvnzTwDogpTgcQhTEAWZKJmDzyyB
         h8G/tFK72ijJD8Y70t3d/u4TF8Ye6uHI0bIdywXyCsoffu1qhRIU4Tiu+hV5O1KMHEmg
         HMyejy94sG7/+MNQYL0J8zKzNKx7FGRi9JCn+1HhfI0Do5OgpJKOZVNKLwEY+b4QRQ2t
         uQknwJvP5pXBBcafD8eJu2X/wSgg9MzVxhNOgmK9B9f2/907R5Zx/O0rXUZVBuFaEPoc
         SKSUk3vZU8tnaYWD8FECiwDu+s/iBkU+Wk4OvaFq+TPvDkTnKbS+0YK/xIjEpWyAzbV+
         lB0w==
X-Gm-Message-State: AJIora+CG9RXJp/r7CBlnA+fJBy9rtyqvRjlvXvE4Bv0myUxZS1yZU2x
        6ZYopUD2dTkF0e2WK9oonpD5JYkmBIczG/0UQZ+4xT14/Oc+5f7K+qzbq/ObhckFLGojak+rqf5
        wm6i9UN15Po2FivEg+pqR/h0P
X-Received: by 2002:a05:6214:260c:b0:470:4ef5:7148 with SMTP id gu12-20020a056214260c00b004704ef57148mr5662127qvb.64.1655827978822;
        Tue, 21 Jun 2022 09:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tvrFRrNcJ+au4R/VYre6s+gKDS5BiaCvxaBCHNWnLGeGFqTWc18xHBZcCYjImLqyQYkzHdrQ==
X-Received: by 2002:a05:6214:260c:b0:470:4ef5:7148 with SMTP id gu12-20020a056214260c00b004704ef57148mr5662096qvb.64.1655827978503;
        Tue, 21 Jun 2022 09:12:58 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id 20-20020ac85754000000b002f93554c009sm11663915qtx.59.2022.06.21.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:12:57 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 3/3] vdpa_sim_blk: call vringh_complete_iotlb() also in the error path
Date:   Tue, 21 Jun 2022 18:12:52 +0200
Message-Id: <20220621161252.197173-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621160859.196646-1-sgarzare@redhat.com>
References: <20220621160859.196646-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call vringh_complete_iotlb() even when we encounter a serious error
that prevents us from writing the status in the "in" header
(e.g. the header length is incorrect, etc.).

The guest is misbehaving, so maybe the ring is in a bad state, but
let's avoid making things worse.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index ac86478845b6..de9cd9843143 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -63,6 +63,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 {
 	size_t pushed = 0, to_pull, to_push;
 	struct virtio_blk_outhdr hdr;
+	bool handled = false;
 	ssize_t bytes;
 	loff_t offset;
 	u64 sector;
@@ -78,12 +79,12 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	if (vq->out_iov.used < 1 || vq->in_iov.used < 1) {
 		dev_dbg(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
 			vq->out_iov.used, vq->in_iov.used);
-		return false;
+		goto err;
 	}
 
 	if (vq->in_iov.iov[vq->in_iov.used - 1].iov_len < 1) {
 		dev_dbg(&vdpasim->vdpa.dev, "request in header too short\n");
-		return false;
+		goto err;
 	}
 
 	/* The last byte is the status and we checked if the last iov has
@@ -97,7 +98,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 				      sizeof(hdr));
 	if (bytes != sizeof(hdr)) {
 		dev_dbg(&vdpasim->vdpa.dev, "request out header too short\n");
-		return false;
+		goto err;
 	}
 
 	to_pull -= bytes;
@@ -182,16 +183,19 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	/* Last byte is the status */
 	bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov, &status, 1);
 	if (bytes != 1)
-		return false;
+		goto err;
 
 	pushed += bytes;
 
 	/* Make sure data is wrote before advancing index */
 	smp_wmb();
 
+	handled = true;
+
+err:
 	vringh_complete_iotlb(&vq->vring, vq->head, pushed);
 
-	return true;
+	return handled;
 }
 
 static void vdpasim_blk_work(struct work_struct *work)
-- 
2.36.1

