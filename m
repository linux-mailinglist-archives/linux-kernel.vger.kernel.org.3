Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA779561F54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiF3Pcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiF3Pcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C4DD3E5F5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656603157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyBXlP1VN/1Hl0hvlI7YsnhG2HRfml5jOvtsaK2qf2k=;
        b=B/KcYY2shGmNtfcDC2cc0d/vN6gQ6EI07j6yk3ZYPZ5zPRk350+BJIMs4irQxflqwCa67K
        pWuLDIw1e3YNCEaheSlPWaNc/SuRXkcM7xWNv2kyzCIfHUuKqpYiqFCDe4wVLpsuD+bXvd
        s/e1Ayb8HBs2Ezw/JS6mIDow5Tl8DSw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-D0PnVWjNOQCqgGSK4tHyyw-1; Thu, 30 Jun 2022 11:32:36 -0400
X-MC-Unique: D0PnVWjNOQCqgGSK4tHyyw-1
Received: by mail-qv1-f72.google.com with SMTP id u18-20020a0cf1d2000000b00470427ccfa5so18699703qvl.18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zyBXlP1VN/1Hl0hvlI7YsnhG2HRfml5jOvtsaK2qf2k=;
        b=d1doogTgvh/1+C6lH332mzHNvmrb5ebsNyKv0B3V5VbesG/5HaGAHggz4u00IcGaxt
         2dci0Nszab7eZYis2aXSnifrDnC/ColOEGEDicpxxrXyp+0y8/4eC1hlMWTSXZMq8a/j
         uJTkQezt9n2uL64YlcjJPnB0dTDEbOWYOIH4qg5AojYJy4w4o1WZ1fU7pgAKU6syWE8N
         qy3WEwRiWUFhmGqoIu/bBKZhMig4QnJEFvnlrfhXOXiEox1McqjJGmXA2u+ivPYUaiSI
         glDaFRloh71G9JlspefzTxiAJywYhtJ0EqQU5GHm7xUwPzg29dSMvI/Snmo7PUuoj++z
         HMYA==
X-Gm-Message-State: AJIora+8sEX4J3eUIp/xu43kv5UIHAA6FuSc/Lk0JFdf8XsytgVg7JX7
        wbenj/8H9YXnj3EhpornJgL26hTBuBqjLZiyFDe87teZKwLrQrDwSkM6g6DL//JTnIoNADZzlC7
        071qyN41LVpgtU21dK/BMgn1d
X-Received: by 2002:a05:620a:270b:b0:6af:18bb:277c with SMTP id b11-20020a05620a270b00b006af18bb277cmr6751637qkp.510.1656603155409;
        Thu, 30 Jun 2022 08:32:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vTc+Nr9zLyCxjBRj8LAHRagLUk1vEK4xwZW8noBEmXngs6Q+g5xoMvq7ks4Sz5hZUgCP5u0A==
X-Received: by 2002:a05:620a:270b:b0:6af:18bb:277c with SMTP id b11-20020a05620a270b00b006af18bb277cmr6751612qkp.510.1656603155026;
        Thu, 30 Jun 2022 08:32:35 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-149.retail.telecomitalia.it. [87.11.6.149])
        by smtp.gmail.com with ESMTPSA id y20-20020a05620a44d400b006af0639f7casm16089325qkp.12.2022.06.30.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:32:34 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 3/3] vdpa_sim_blk: call vringh_complete_iotlb() also in the error path
Date:   Thu, 30 Jun 2022 17:32:21 +0200
Message-Id: <20220630153221.83371-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630153221.83371-1-sgarzare@redhat.com>
References: <20220630153221.83371-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index b2d75efec63a..43422b3854d2 100644
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

