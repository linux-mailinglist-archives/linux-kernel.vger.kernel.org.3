Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC955376F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353657AbiFUQJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353740AbiFUQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD9F22DAA7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655827746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QwdoYcSexrOCzV1teWJ7RyQQyOgHsOoOsUPcLIRzoFM=;
        b=VBqKbmtnn78BqU52r6XPrKrm133FzkCRmI+bknxwa2L25nB7UJfduHsjL/WWzYedoWBgf5
        +T3bgGFO8L8+oc+ihgsSzHL9QkZtc9aSRJ6wJuT6/1Bb1xGyaid0qSkI5JC1o7MI2h7WZZ
        DP6LZ3A8Hh8UhUN88vWnjzeb1drBW3U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-Ir05w2w4Ns2RmbY2blr5gw-1; Tue, 21 Jun 2022 12:09:05 -0400
X-MC-Unique: Ir05w2w4Ns2RmbY2blr5gw-1
Received: by mail-wm1-f71.google.com with SMTP id i188-20020a1c3bc5000000b0039db971c6d9so7336932wma.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwdoYcSexrOCzV1teWJ7RyQQyOgHsOoOsUPcLIRzoFM=;
        b=mNJOY9OwTyxHq3r9tsRohJBJJ/2qAHZRCsqmNP8Ff+CfdWOLJlqTMuS7/2Yk9eoDay
         2tsomzEsz/sDM5bpK6DzuirgxWcuwsY+P1ifX9ZGaL+GofL3OEJ+XlEDhb61hYfT+1yz
         VpaFewjvVua445KC8W5KYZp8tX3GWx4MJ/K1OlJKSUIK57qEtERp2VUc52sIs78kUG3g
         X3ICt8HVbQLJcweSBtQvgnKYc3s7NOPsfQRklRqilrKfTrvisqeLyf6C6e4kCIFPWUmR
         TQfGUMhtzA7V1AcM5kZzmUQGHTIuKLptooWOMmEHTKYS/VafUXoU/X/8zA+KFGtIH56C
         e+Sw==
X-Gm-Message-State: AJIora9oCdwPSgp+5Z1uhYRfYyQCdTik7chuHU+Tox3RaD3rD7LOa19Z
        6zqk2yytCfdNdDEGpJ3gZuLD8u4FH9VF6U+qMJ+IqmpZIwiuyCD+lCOYLJpI6Imb3HTLTj1jQwt
        MeIbc6zBMw9ZZ0Ze8kjKwZZbS
X-Received: by 2002:a05:600c:3489:b0:39d:b58f:6797 with SMTP id a9-20020a05600c348900b0039db58f6797mr31017434wmq.205.1655827744244;
        Tue, 21 Jun 2022 09:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtz1/kwO2GKBAW1YJVuUDOT0/wuEhfMdbVmbF7WpAqjGTrMqa7Xyd1gz62UtYc+FOogELr3Q==
X-Received: by 2002:a05:600c:3489:b0:39d:b58f:6797 with SMTP id a9-20020a05600c348900b0039db58f6797mr31017415wmq.205.1655827743985;
        Tue, 21 Jun 2022 09:09:03 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0560001c0700b0021b903a018bsm6531560wrb.92.2022.06.21.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:09:03 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/3] vdpa_sim_blk: use dev_dbg() to print errors
Date:   Tue, 21 Jun 2022 18:08:57 +0200
Message-Id: <20220621160859.196646-2-sgarzare@redhat.com>
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

Use dev_dbg() instead of dev_err()/dev_warn() to avoid flooding the
host with prints, when the guest driver is misbehaving.
In this way, prints can be dynamically enabled when the vDPA block
simulator is used to validate a driver.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 42d401d43911..a83a5c76f620 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -76,13 +76,13 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		return false;
 
 	if (vq->out_iov.used < 1 || vq->in_iov.used < 1) {
-		dev_err(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
+		dev_dbg(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
 			vq->out_iov.used, vq->in_iov.used);
 		return false;
 	}
 
 	if (vq->in_iov.iov[vq->in_iov.used - 1].iov_len < 1) {
-		dev_err(&vdpasim->vdpa.dev, "request in header too short\n");
+		dev_dbg(&vdpasim->vdpa.dev, "request in header too short\n");
 		return false;
 	}
 
@@ -96,7 +96,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &hdr,
 				      sizeof(hdr));
 	if (bytes != sizeof(hdr)) {
-		dev_err(&vdpasim->vdpa.dev, "request out header too short\n");
+		dev_dbg(&vdpasim->vdpa.dev, "request out header too short\n");
 		return false;
 	}
 
@@ -110,7 +110,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	switch (type) {
 	case VIRTIO_BLK_T_IN:
 		if (!vdpasim_blk_check_range(sector, to_push)) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"reading over the capacity - offset: 0x%llx len: 0x%zx\n",
 				offset, to_push);
 			status = VIRTIO_BLK_S_IOERR;
@@ -121,7 +121,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 					      vdpasim->buffer + offset,
 					      to_push);
 		if (bytes < 0) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_push_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
 				bytes, offset, to_push);
 			status = VIRTIO_BLK_S_IOERR;
@@ -133,7 +133,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 
 	case VIRTIO_BLK_T_OUT:
 		if (!vdpasim_blk_check_range(sector, to_pull)) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"writing over the capacity - offset: 0x%llx len: 0x%zx\n",
 				offset, to_pull);
 			status = VIRTIO_BLK_S_IOERR;
@@ -144,7 +144,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 					      vdpasim->buffer + offset,
 					      to_pull);
 		if (bytes < 0) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
 				bytes, offset, to_pull);
 			status = VIRTIO_BLK_S_IOERR;
@@ -157,7 +157,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 					      vdpasim_blk_id,
 					      VIRTIO_BLK_ID_BYTES);
 		if (bytes < 0) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_push_iotlb() error: %zd\n", bytes);
 			status = VIRTIO_BLK_S_IOERR;
 			break;
@@ -167,8 +167,8 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 
 	default:
-		dev_warn(&vdpasim->vdpa.dev,
-			 "Unsupported request type %d\n", type);
+		dev_dbg(&vdpasim->vdpa.dev,
+			"Unsupported request type %d\n", type);
 		status = VIRTIO_BLK_S_IOERR;
 		break;
 	}
-- 
2.36.1

