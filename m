Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922BA49035F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiAQIAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiAQIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:00:36 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA35C061747
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:00:35 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x7so54412118lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o//IbTH215uTRxD5sxKW6X3QC5cqZD8DwHxz9/rse7k=;
        b=aMcpopkKOXGy+N4zaHU4fwC683S96p/WCr4X0v9i0QD+DZe5D25PAjANQotNk/nh8E
         bUcTgxfnHzqUoeajz+r8fK3GR/05gq3QV32fMMSJVLRgZnQmS47CHdbehzLQ5pH4H+am
         yRSNyuBbOHaCHaknon37pSbM1qaEo8HknING/OKVaT5+ajadNqFECMTRdfIngErcl+AI
         ix5EKIY68OXZy64SQdOG5pHkES/O8s6BUO6u/7jpGWhty6AtwKGDCWZMgI1ufrYnbcPQ
         0il8MiTN3NBYF+bEs+B/dHQFldc9YTePRLiSLme7DY0S98j+uNo4c42LWq1aostu1F83
         uUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o//IbTH215uTRxD5sxKW6X3QC5cqZD8DwHxz9/rse7k=;
        b=GrD0geysLl05UUE21cOq8z0NPESIxghUjXFbVRY0JPcy/RaYCXfcDtwht0+gMo5fqB
         gDt7wAbmBp8dIX3FiMyDU6q5+I4lW5ZED/SdNWy0S2i9YmDbYKeVAHVhIiwn1E+3G6VS
         48hLIvHlIxb8fLsdfwyDq2G6NvJpBdoqVzqRZl/Cn46a6bvMJM0VUE9yWNC0+r/ho441
         DyK02LqEDeXMpwWQy48aE2Q1/mtLFyNE1kmSoNHIf/015JvyKOK1Kw2oUoJoIgD5X0Re
         QD/CqeNrVUeHPhU8jujRZLTUWztFfN0g+qd+MhijqylDeKlVQGtf0pa98Zx7y2EVSsrx
         k9uA==
X-Gm-Message-State: AOAM531HXnFkSUUmlvzAnrJgwbRmrZdZsZheAb53HOTDLeXW0G7CcngQ
        7PEWvxbXb1q9bUSAo5meWm2wXA==
X-Google-Smtp-Source: ABdhPJztWIKFVe9SovCV6OXubU9yRHijgjxJcTwXc0Q5JyQNZNm+M2ALokCStPcp//pSiTmEKtRruA==
X-Received: by 2002:a19:ae1a:: with SMTP id f26mr15719595lfc.270.1642406434270;
        Mon, 17 Jan 2022 00:00:34 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id x18sm1279423ljd.105.2022.01.17.00.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 00:00:33 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jasowang@redhat.com, mst@redhat.com
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v2 3/4] drivers/net/virtio_net: Added RSS hash report.
Date:   Mon, 17 Jan 2022 10:00:08 +0200
Message-Id: <20220117080009.3055012-4-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117080009.3055012-1-andrew@daynix.com>
References: <20220117080009.3055012-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added features for RSS hash report.
If hash is provided - it sets to skb.
Added checks if rss and/or hash are enabled together.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 58 ++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9aae11cb568e..2c61f96ce3e6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -227,6 +227,7 @@ struct virtnet_info {
 
 	/* Host supports rss and/or hash report */
 	bool has_rss;
+	bool has_rss_hash_report;
 	u8 rss_key_size;
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
@@ -420,7 +421,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	hdr_p = p;
 
 	hdr_len = vi->hdr_len;
-	if (vi->mergeable_rx_bufs)
+	if (vi->has_rss_hash_report)
+		hdr_padded_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (vi->mergeable_rx_bufs)
 		hdr_padded_len = sizeof(*hdr);
 	else
 		hdr_padded_len = sizeof(struct padded_vnet_hdr);
@@ -1156,6 +1159,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct virtio_net_hdr_v1_hash *hdr_hash;
+	enum pkt_hash_types rss_hash_type;
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
@@ -1182,6 +1187,29 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 
 	hdr = skb_vnet_hdr(skb);
+	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report) {
+		hdr_hash = (struct virtio_net_hdr_v1_hash *)(hdr);
+
+		switch (hdr_hash->hash_report) {
+		case VIRTIO_NET_HASH_REPORT_TCPv4:
+		case VIRTIO_NET_HASH_REPORT_UDPv4:
+		case VIRTIO_NET_HASH_REPORT_TCPv6:
+		case VIRTIO_NET_HASH_REPORT_UDPv6:
+		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+			rss_hash_type = PKT_HASH_TYPE_L4;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv4:
+		case VIRTIO_NET_HASH_REPORT_IPv6:
+		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+			rss_hash_type = PKT_HASH_TYPE_L3;
+			break;
+		case VIRTIO_NET_HASH_REPORT_NONE:
+		default:
+			rss_hash_type = PKT_HASH_TYPE_NONE;
+		}
+		skb_set_hash(skb, hdr_hash->hash_value, rss_hash_type);
+	}
 
 	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -2232,7 +2260,8 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 	sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
-				  VIRTIO_NET_CTRL_MQ_RSS_CONFIG, sgs)) {
+				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
+				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
 		dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
 		return false;
 	}
@@ -3230,6 +3259,8 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR,
 			     "VIRTIO_NET_F_CTRL_VQ") ||
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_RSS,
+			     "VIRTIO_NET_F_CTRL_VQ") ||
+	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
 			     "VIRTIO_NET_F_CTRL_VQ"))) {
 		return false;
 	}
@@ -3365,16 +3396,18 @@ static int virtnet_probe(struct virtio_device *vdev)
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
-						      rss_max_indirection_table_length));
+					rss_max_indirection_table_length));
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
-	}
-
-	if (vi->has_rss) {
 		vi->rss_hash_types_supported =
 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
 		vi->rss_hash_types_supported &=
@@ -3384,8 +3417,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 
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
@@ -3452,7 +3488,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
-	if (vi->has_rss)
+	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
 	err = register_netdev(dev);
@@ -3587,7 +3623,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
-	VIRTIO_NET_F_RSS
+	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
-- 
2.34.1

