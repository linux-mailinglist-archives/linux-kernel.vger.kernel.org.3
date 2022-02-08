Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B612B4AE085
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384748AbiBHSPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384743AbiBHSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:15:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EFC061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:15:45 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 13so1357758lfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwrnbyLNdtTm0btNv2HP1O4KlFU0i9XXxpiCHX2F+Pc=;
        b=tzNlIqib5jH9XFKGuZa+YMoAj9U8joZMJeU+ui8Zcv/IDBs4+XgzC1gQofsf0pGOJC
         gSlyGOPLYjc8L/Be+N+wb521dnQ/lkySge3j5SGgV1ALefdhamIqPqWmnALQAD25sNca
         O3Jvbze4FPuQv7lPe9KA4pU7Ddl7gqac6dVvmtBTxiFNC8fj5iF9Bp/6LyZqJOHiZYWN
         Nqwq928pL8jsZ7bUVLHpSgRgchGNlAQ4ZpSf+ryLQpNJT3Z34l+7iKpzEkI5rRbhOnSJ
         Kw+mFk4umJjnNojd/XA58TNTwM7zRvY0QxwPkquwrGILglqytsQEzqcgN+BCfP3bOAGq
         nRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwrnbyLNdtTm0btNv2HP1O4KlFU0i9XXxpiCHX2F+Pc=;
        b=4egis4rdx6ZWOwdcpjED+RgnH2+lph2+dnTyCcFd0iVA+xhBkFpUAAkHpoZKZniamk
         UDpoNXMexn4caLM2yyVk7jDC17vsbw+yLfQxYVSAQryXWR3LFfixzt2MpxkuWxSR4Xu9
         SFxh+KZ0/jfbK+2NiEe7BJOqXWQeD1JNY6fbaDGVHbG6RYLI/pOygd9FjBjKh0OK592n
         YlG29Z8V2EIP4SErlICM/GnheNKADKp/vxe8VEepgz02i/SZ/Waz2UgV3/9j6oSa+/+t
         NZLA3svSYjPQCY6lHG1LmIlgkYpWqLfvj7ZMz4HhysHcISnmiSOxDO4EBg2lpwi6aVMx
         VOmg==
X-Gm-Message-State: AOAM532AwYnMuzycKgyuRm2QMCtwBADRp5Zp4ysO21mNWKYMUF7wfVsB
        KFhZnewYa5l7X9RWxF02++cwmg==
X-Google-Smtp-Source: ABdhPJwAV0zcT5EY4vC/gPjMGB5tdxsfLzkDK1pFzGI5vqPmF/9DgAx4UdfdZdCYsJBKHLDCbJxV1w==
X-Received: by 2002:a05:6512:3ba:: with SMTP id v26mr3534983lfp.662.1644344143814;
        Tue, 08 Feb 2022 10:15:43 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id p16sm2125082ljc.86.2022.02.08.10.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:15:43 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jasowang@redhat.com, mst@redhat.com
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v3 1/4] drivers/net/virtio_net: Fixed padded vheader to use v1 with hash.
Date:   Tue,  8 Feb 2022 20:15:07 +0200
Message-Id: <20220208181510.787069-2-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208181510.787069-1-andrew@daynix.com>
References: <20220208181510.787069-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header v1 provides additional info about RSS.
Added changes to computing proper header length.
In the next patches, the header may contain RSS hash info
for the hash population.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a801ea40908f..1404e683a2fd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -242,13 +242,13 @@ struct virtnet_info {
 };
 
 struct padded_vnet_hdr {
-	struct virtio_net_hdr_mrg_rxbuf hdr;
+	struct virtio_net_hdr_v1_hash hdr;
 	/*
 	 * hdr is in a separate sg buffer, and data sg buffer shares same page
 	 * with this header sg. This padding makes next sg 16 byte aligned
 	 * after the header.
 	 */
-	char padding[4];
+	char padding[12];
 };
 
 static bool is_xdp_frame(void *ptr)
@@ -1266,7 +1266,8 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 					  struct ewma_pkt_len *avg_pkt_len,
 					  unsigned int room)
 {
-	const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	const size_t hdr_len = vi->hdr_len;
 	unsigned int len;
 
 	if (room)
@@ -2851,7 +2852,7 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
  */
 static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqueue *vq)
 {
-	const unsigned int hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	const unsigned int hdr_len = vi->hdr_len;
 	unsigned int rq_size = virtqueue_get_vring_size(vq);
 	unsigned int packet_len = vi->big_packets ? IP_MAX_MTU : vi->dev->max_mtu;
 	unsigned int buf_len = hdr_len + ETH_HLEN + VLAN_HLEN + packet_len;
-- 
2.34.1

