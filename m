Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C974B4E9EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244991AbiC1SEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbiC1SDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:03:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AE54839F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:01:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r22so20315655ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03PefwHsmItmTHhL6lJqxa9zDP27cAxap27LRrEspsw=;
        b=nfEeQvfRPoop5plFvifW8xUkvneLhLrM5cl1yZzcG3YIDt2bpnZh7Qb9BRBR1KMqmL
         kfO1vMpuGZgnfmUwktAGevzrihWEkV9fN4OOcZXIbkx0MTCNrzRZsnEGnalt+4oRAgTE
         m06MWgTGnRU1nxRZ7Lkhc+foCiS3XRX7xJrah10DtdHgJ5xYYz4c7gjJdZ3vNIfdmi0z
         lVqA8TavemfrvABP0O/yjV5G007U9UPNqy0mBinYHmnnpc1+vllkqfZojYw9uy/thFnS
         XN3ewSHXVb6Mkm52MJBdCvDzPa25xYyuiXDOAKL2JXf2hB/RxZ8Ez8I5pn+Q3HdNdJ7R
         jw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03PefwHsmItmTHhL6lJqxa9zDP27cAxap27LRrEspsw=;
        b=j3vH6ulp87Tti/+fjdzwApOgPswOdm7iIDGSu7DzPtnAj67XXbXZ8WAHxEJ4Z/bok8
         8tqJ8MDWXuP/a4v2/wdBUvMxsX3p0rFrn1zFKf3E2eaxWU+OjHqAQvLYZ33OFJdvY5ZI
         M/j1hn0Aammgs/B+tXlfkZmO+Wb55ISGTQWjIUUR1c5Wg3ySZkQfjICgHe7Mgfk4ujOS
         WiCExzX3AYggQJ6Q4J31fvNTeK9lRhOems5EeWkJwOP9ePSu38E2gEx3mkOog2HOzCDL
         YwCA1d0bpMxTBEikeblBdRGjOiWYn4JnrQblrlv3LKbjNaTAwpsYubmFa4N4y8D41UhN
         kdIg==
X-Gm-Message-State: AOAM530vmfL0X8Gj/mR9Z9mSKpDBENu0tZvdtDQpi6OKesMHBOfr83lr
        x1UdkHHuZvbN4s54C6nFtK9jkFgZG2NO81wt
X-Google-Smtp-Source: ABdhPJwxC1xj/F41v0H5XnVzziyNIhKmsc3QKEy+VvVawVWVILEfs+1ka8b4jxlkNvZDbalOWQBThQ==
X-Received: by 2002:a2e:b054:0:b0:248:5819:b946 with SMTP id d20-20020a2eb054000000b002485819b946mr7119493ljl.389.1648490501549;
        Mon, 28 Mar 2022 11:01:41 -0700 (PDT)
Received: from localhost.localdomain (host-188-190-49-235.la.net.ua. [188.190.49.235])
        by smtp.gmail.com with ESMTPSA id a4-20020a2eb164000000b0024988e1cfb6sm1801559ljm.94.2022.03.28.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 11:01:41 -0700 (PDT)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, jasowang@redhat.com,
        mst@redhat.com, yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v5 1/4] drivers/net/virtio_net: Fixed padded vheader to use v1 with hash.
Date:   Mon, 28 Mar 2022 20:53:33 +0300
Message-Id: <20220328175336.10802-2-andrew@daynix.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328175336.10802-1-andrew@daynix.com>
References: <20220328175336.10802-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/net/virtio_net.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a801ea40908f..b9ed7c55d9a0 100644
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
@@ -396,7 +396,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	hdr_len = vi->hdr_len;
 	if (vi->mergeable_rx_bufs)
-		hdr_padded_len = sizeof(*hdr);
+		hdr_padded_len = hdr_len;
 	else
 		hdr_padded_len = sizeof(struct padded_vnet_hdr);
 
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
2.35.1

