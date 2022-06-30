Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13569561F49
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiF3Pcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiF3Pcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1DC43DDDB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656603151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRre2mmiUkpHj1mcdypLppTGL5vL6JLZXVbGfJnDALg=;
        b=OQ4u4Nh0FDZDABTecc6CHcgtW+jyslG3ctatVGBLz9NZT2Dlh1iefhCduo9m8evMbxLdMh
        mGkiTXtV4FrbW7T4Ho5GKXLC7aTz2l0YL7YmeDR/5Dg52Idm9v8yVJAZA/MUyQb2CpnHNP
        uRZBUNNRYR3/PVT0eTwS9wNFmglYHLM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-9sevPzYQMLOayiV0NYkCng-1; Thu, 30 Jun 2022 11:32:29 -0400
X-MC-Unique: 9sevPzYQMLOayiV0NYkCng-1
Received: by mail-qv1-f70.google.com with SMTP id e10-20020a0ce3ca000000b004702b8819beso18719456qvl.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRre2mmiUkpHj1mcdypLppTGL5vL6JLZXVbGfJnDALg=;
        b=kcOpQDlePHAJIBtEb9s/F2pxOKkr3kBV1gEVIzvbIM5gotyzlQ28T1nlJW+NkAU1tL
         e7uzaMSnuRqCXV34SW1UnpZmoU5Pj/eSTfr8CAOlH6kAevSVox2bIe1D6n8Vzs20sxog
         ymye3HkiuZQbjjxPq18HONcpHAsMHC+IU6YReL/j2L7ZbYC7ip1bm5OpFa6P9oUQvqX3
         MqpMbovsEk95P2S7ZW83npx7J4KShTeFG4upmSYoYJQ7VKE39n5iMGxJzNVQbzKkclSx
         wVdcskxJ2jKYidAs0DHA5tnXD5g69HMMAsl2Agtu1hiCcWJWIBwFOy2OlubwgPRVugs0
         SSQw==
X-Gm-Message-State: AJIora/4fXQMJ3q3RTHDAmXf4kluc2/TaHGabikVZ2NEUFPBynqD2z6l
        DDCX42+AmL2e3ssSY/Nc52CDvDvLUYNk6pZ5issCWPBb04Jod9NMLHqIR7lOhP9FOYek58YkjMB
        ToCCJjWKekNy64I1LOj7vtOBm
X-Received: by 2002:a05:620a:40cf:b0:6b1:41dd:9710 with SMTP id g15-20020a05620a40cf00b006b141dd9710mr6329771qko.727.1656603149351;
        Thu, 30 Jun 2022 08:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAcFYzWpyw+b6fujbaqZt6VZhUiFDHom86OOiiyoqB6cQlPZGEL6VrqMoaZqdOzN2T9zXkXA==
X-Received: by 2002:a05:620a:40cf:b0:6b1:41dd:9710 with SMTP id g15-20020a05620a40cf00b006b141dd9710mr6329749qko.727.1656603149110;
        Thu, 30 Jun 2022 08:32:29 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-149.retail.telecomitalia.it. [87.11.6.149])
        by smtp.gmail.com with ESMTPSA id y20-20020a05620a44d400b006af0639f7casm16089325qkp.12.2022.06.30.08.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:32:28 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 1/3] vdpa_sim_blk: use dev_dbg() to print errors
Date:   Thu, 30 Jun 2022 17:32:19 +0200
Message-Id: <20220630153221.83371-2-sgarzare@redhat.com>
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

Use dev_dbg() instead of dev_err()/dev_warn() to avoid flooding the
host with prints, when the guest driver is misbehaving.
In this way, prints can be dynamically enabled when the vDPA block
simulator is used to validate a driver.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
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

