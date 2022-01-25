Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B5949AFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457277AbiAYJOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455336AbiAYJE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:04:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9FDC06135C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:47:27 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o12so11895451lfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KADXDwPSZzBNJZyGOf6/RaxmVEZ0dcQMEj4ph2LZrIA=;
        b=E5N6rnfpLVuomzpKv7B2iO6tqIya1+zMB7j6sPn5f/I6ggTAaJqoDqBHwysCe4g6D6
         FFcao7hF04BWqCwu9s+U+g3GORW4cq8dmt4RqSXNaDPnA329ZI81GDO8lKVEe11XmxoQ
         qdqv+GI8VdBE3edikJPt8xXPZZ59+BR55A+ZXBmrAZ/XtcgN0qouXrcIbmYQCfYJ1juM
         58JkfDeW2VsEdCxdU5Z8THlgm7GFAZOYY3Sv9b4Htj2gMJgKUTQkszP8lSJ24EnW4P4X
         GRkuYMYKrVRlJjnYxt6ud7UUwMM80YzgH3LH9zlOS/Gbh1c2aXETX6oG4qZtSPzLk19N
         KCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KADXDwPSZzBNJZyGOf6/RaxmVEZ0dcQMEj4ph2LZrIA=;
        b=yVtpJ3XvhZkN55F2GlDbWmCzaV6Fz3DZIPgQrmuSOGIeR33VRaDijZuplozSqBYD8k
         MikGT7Ss1JCd/BcuJd5OgBcxh9X+iZn6XDW4DkIS+1bqKOudWdrvAd3pu0p3v58VcIUe
         xW18/uf1XFZdJ7ENcImsfMrCqp65HamdQu5KrBOFVVX0Qx7LHD6fmzdinc7ChYTrylW/
         bWFoW7+4wCvpbZ9CkEV2lzNCouEWovrzRi7jHKcpu7k1Sllcu/xF51CJnYtCL6QQZ2Vc
         dJbtGbu4mnnppqJwiv4PXuLSjMgn3GWHxNfIoGc72NOetkepnb8VKbwoaeIIxktipBYy
         1syw==
X-Gm-Message-State: AOAM53109bJWrEDliFc5bIN8tteX46bIySauZL7Yn3NCNbx7TkGX4P9M
        qSmt2YfFggWGk4SvQg+cMpFfcA==
X-Google-Smtp-Source: ABdhPJxBOpDCi+HD+W7m+aCE1uJ74rL4NmI8ow4BsEsaN6ZHzn0gSv57q1zh/Uyab4PWRk17uBBwWA==
X-Received: by 2002:a05:6512:3d0a:: with SMTP id d10mr2796243lfv.472.1643100445460;
        Tue, 25 Jan 2022 00:47:25 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id q5sm1418944lfe.279.2022.01.25.00.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 00:47:25 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        jasowang@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yuri.benditovich@daynix.com, yan@daynix.com
Subject: [RFC PATCH 5/5] drivers/net/virtio_net.c: Added USO support.
Date:   Tue, 25 Jan 2022 10:47:02 +0200
Message-Id: <20220125084702.3636253-6-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125084702.3636253-1-andrew@daynix.com>
References: <20220125084702.3636253-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, it possible to enable GSO_UDP_L4("tx-udp-segmentation") for VirtioNet.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a801ea40908f..a45eee022be4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -60,13 +60,17 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
 	VIRTIO_NET_F_GUEST_UFO,
-	VIRTIO_NET_F_GUEST_CSUM
+	VIRTIO_NET_F_GUEST_CSUM,
+	VIRTIO_NET_F_GUEST_USO4,
+	VIRTIO_NET_F_GUEST_USO6
 };
 
 #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
 				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
 				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
-				(1ULL << VIRTIO_NET_F_GUEST_UFO))
+				(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
+				(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
+				(1ULL << VIRTIO_NET_F_GUEST_USO6))
 
 struct virtnet_stat_desc {
 	char desc[ETH_GSTRING_LEN];
@@ -2530,7 +2534,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
-		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6))) {
 		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
 		return -EOPNOTSUPP;
 	}
@@ -3155,6 +3161,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->hw_features |= NETIF_F_TSO6;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
 			dev->hw_features |= NETIF_F_TSO_ECN;
+		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
+			dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 		dev->features |= NETIF_F_GSO_ROBUST;
 
@@ -3169,6 +3177,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->features |= NETIF_F_GRO_HW;
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
 		dev->hw_features |= NETIF_F_GRO_HW;
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO4) ||
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO6))
+		dev->hw_features |= NETIF_F_LRO;
 
 	dev->vlan_features = dev->features;
 
@@ -3200,7 +3211,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
-	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO) ||
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO4) ||
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO6))
 		vi->big_packets = true;
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
@@ -3400,6 +3413,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
 	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
 	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
+	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
 	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
-- 
2.34.1

