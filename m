Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2994BF7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiBVMCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiBVMCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:02:19 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC56B239F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:01:36 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t14so19121159ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmisMDrSSGPjd6k26IfvbT/yYcP9P6fSTHbqUG2ZH1c=;
        b=A85yfPysYfgKo+nOa2VAQ4WP5WQa1Q8L4CdNVIb/faqgDh+xvvfWFc1tQj21Nk/+eV
         SmnVglFNfrlq8/dNzKAX7uYaxm4KjBJJlrXaLlW4DPv93I1I3q/UeXTpgcT/I4JqAVA1
         H4H/4KvHsueOLbalAG8JS46FIKWsKnkzCDJzAo9+5sxooDArEw5lsuuFbI/gVIY1XKks
         q40uAb4TNUGIKtz0UX1C0xt6MTspIfYiJr8c6gaWmy2mvmsq37mdourciUF5crLUeEjO
         i0nV1BLHX8VPEzLrralSMDu8oE5RQPx5tLgOFrL1IhXfz8tdN8nmCccyauncCagU2wEY
         uRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmisMDrSSGPjd6k26IfvbT/yYcP9P6fSTHbqUG2ZH1c=;
        b=PeFGXvqvQhkXBCSt+vvmYFseQ2FiWUMY4JzvMgXsvqpKoVFT4rBsRANc1b6D1MJNUl
         2T2J9957i9kLf6O1N+ooJ/dtxeWwQ24W0EIEfD5u+cS6lYBB8ed74axHn2j7LpjK0zXH
         1f8WVDrVs4ojoB+xYODj6RGdjV9lkJa6gUzToPwbf04THfXwUvT7GNikL7RitFCNqwv2
         JoZx2WFXfNPgrmzugyP9/KZlBN2mrjZKcGzR+tkz4V9PVxgmxvIUEXJ3WeqLY39xji0l
         Jtv9ho5z5cUZjHqwp4r+KaOHQv4ZyuHIeOr9lOGw8Iv6dGmy2ddOSWtwM75NTIlK8caX
         uDeg==
X-Gm-Message-State: AOAM532VwPFcvlodFyU00fyjF92IXlZH8kwesyH9hAvMQIM7TbqMyl7N
        0lnDwKXecsHJDm1n0wD0Pid4C4jROI9tyA==
X-Google-Smtp-Source: ABdhPJwNe9yz9JfMc9894rGsESCDBjJXEfxNKyt8Q5nKCXeAYJRDpxnyY3hGQ4KgT1TYBa+B3iEz0w==
X-Received: by 2002:a2e:944e:0:b0:246:4a4f:c610 with SMTP id o14-20020a2e944e000000b002464a4fc610mr2391153ljh.458.1645531294502;
        Tue, 22 Feb 2022 04:01:34 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id v29sm1664024ljv.72.2022.02.22.04.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 04:01:34 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jasowang@redhat.com, mst@redhat.com
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v4 3/4] drivers/net/virtio_net: Added RSS hash report.
Date:   Tue, 22 Feb 2022 14:00:53 +0200
Message-Id: <20220222120054.400208-4-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222120054.400208-1-andrew@daynix.com>
References: <20220222120054.400208-1-andrew@daynix.com>
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

Added features for RSS hash report.
If hash is provided - it sets to skb.
Added checks if rss and/or hash are enabled together.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b5f2bb426a7b..8b317b3ef5aa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -227,6 +227,7 @@ struct virtnet_info {
 
 	/* Host supports rss and/or hash report */
 	bool has_rss;
+	bool has_rss_hash_report;
 	u8 rss_key_size;
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
@@ -1148,6 +1149,35 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	return NULL;
 }
 
+static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
+				struct sk_buff *skb)
+{
+	enum pkt_hash_types rss_hash_type;
+
+	if (!hdr_hash || !skb)
+		return;
+
+	switch (hdr_hash->hash_report) {
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+	case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+	case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+		rss_hash_type = PKT_HASH_TYPE_L4;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+		rss_hash_type = PKT_HASH_TYPE_L3;
+		break;
+	case VIRTIO_NET_HASH_REPORT_NONE:
+	default:
+		rss_hash_type = PKT_HASH_TYPE_NONE;
+	}
+	skb_set_hash(skb, hdr_hash->hash_value, rss_hash_type);
+}
+
 static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 			void *buf, unsigned int len, void **ctx,
 			unsigned int *xdp_xmit,
@@ -1182,6 +1212,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 
 	hdr = skb_vnet_hdr(skb);
+	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
+		virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
 
 	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -2232,7 +2264,8 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 	sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
-				  VIRTIO_NET_CTRL_MQ_RSS_CONFIG, sgs)) {
+				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
+				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
 		dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
 		return false;
 	}
@@ -3231,6 +3264,8 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR,
 			     "VIRTIO_NET_F_CTRL_VQ") ||
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_RSS,
+			     "VIRTIO_NET_F_CTRL_VQ") ||
+	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
 			     "VIRTIO_NET_F_CTRL_VQ"))) {
 		return false;
 	}
@@ -3366,8 +3401,13 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 		vi->mergeable_rx_bufs = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
+		vi->has_rss_hash_report = true;
+
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
 		vi->has_rss = true;
+
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_indir_table_size =
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
@@ -3383,8 +3423,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		dev->hw_features |= NETIF_F_RXHASH;
 	}
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
-	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+
+	if (vi->has_rss_hash_report)
+		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
+		 virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
 	else
 		vi->hdr_len = sizeof(struct virtio_net_hdr);
@@ -3451,7 +3494,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
-	if (vi->has_rss)
+	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
 	err = register_netdev(dev);
@@ -3586,7 +3629,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
-	VIRTIO_NET_F_RSS
+	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
-- 
2.34.1

