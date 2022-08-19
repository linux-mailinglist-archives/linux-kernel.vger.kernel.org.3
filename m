Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1852759A506
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353399AbiHSQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353338AbiHSQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:39:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8490FA9275;
        Fri, 19 Aug 2022 09:08:18 -0700 (PDT)
Date:   Fri, 19 Aug 2022 18:07:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660925278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qhxX4xMaGu2VGLHQieOCQhhVaQg5txX0PipJPGZKbXo=;
        b=3uwpK8LoVxRvfdgm/jWGVKg1g9s0XEtg4/ugYbUbkzZgxApuMN78Um10fKgdDjAgfulcJQ
        9TOch2C3+Ry09KGY7GKfWtrgdv+4vl6IiDzw4aM/ujSHt2w84dn8maxk1HGKEMYQbGtFQl
        MLqaJBvpIVqlsDb03Pm+MicP+UOSbDEE+Kd8mnz95vby/onqTT9/sbHszAVgzkdNBAlEb3
        d+hTt2f3AoJma19pmkexvsDA6amavE6LqJvqF+3/tS12N38iu6Om1TiylHfrd037Fs0HRG
        aZU7vRKBmZ6+ZveqaE5REu6S/8p3YPvmTuLS4ESJ+FSS5wLQc2ApjFpPoWAwLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660925278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qhxX4xMaGu2VGLHQieOCQhhVaQg5txX0PipJPGZKbXo=;
        b=W1DjwqF0zo8uJWZstOcy3je7iRuyFK2dkwZWS93ltc2DIuVGdJqQ+10/Ymm0/wgp/Y8KNq
        OVaTCoyxmOTbfAAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.0-rc1-rt2
Message-ID: <Yv+1XYc7G3BGNZx/@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.0-rc1-rt2 patch set. 

Changes since v6.0-rc1-rt1:

  - A clean up to reduce the amount of ifdef RT within the tree.

  - A removal of an include to get vduse to compile.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v6.0-rc1-rt1 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/incr/patch-6.0-rc1-rt1-rt2.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.0-rc1-rt2

The RT patch against v6.0-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patch-6.0-rc1-rt2.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patches-6.0-rc1-rt2.tar.xz

Sebastian

diff --git a/drivers/net/ethernet/alacritech/slic.h b/drivers/net/ethernet/alacritech/slic.h
index 4eecbdfff3ff1..82071d0e5f7fc 100644
--- a/drivers/net/ethernet/alacritech/slic.h
+++ b/drivers/net/ethernet/alacritech/slic.h
@@ -288,13 +288,13 @@ do {						\
 	u64_stats_update_end(&(st)->syncp);	\
 } while (0)
 
-#define SLIC_GET_STATS_COUNTER(newst, st, counter)			\
-{									\
-	unsigned int start;						\
+#define SLIC_GET_STATS_COUNTER(newst, st, counter)		\
+{								\
+	unsigned int start;					\
 	do {							\
-		start = u64_stats_fetch_begin_irq(&(st)->syncp);	\
-		newst = (st)->counter;					\
-	} while (u64_stats_fetch_retry_irq(&(st)->syncp, start));	\
+		start = u64_stats_fetch_begin(&(st)->syncp);	\
+		newst = (st)->counter;				\
+	} while (u64_stats_fetch_retry(&(st)->syncp, start));	\
 }
 
 struct slic_upr {
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 39242c5a17290..8f81d288c4880 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -118,9 +118,9 @@ static void ena_safe_update_stat(u64 *src, u64 *dst,
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin_irq(syncp);
+		start = u64_stats_fetch_begin(syncp);
 		*(dst) = *src;
-	} while (u64_stats_fetch_retry_irq(syncp, start));
+	} while (u64_stats_fetch_retry(syncp, start));
 }
 
 static void ena_queue_stats(struct ena_adapter *adapter, u64 **data)
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 6a356a6cee15a..1c5d482990806 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3270,10 +3270,10 @@ static void ena_get_stats64(struct net_device *netdev,
 		tx_ring = &adapter->tx_ring[i];
 
 		do {
-			start = u64_stats_fetch_begin_irq(&tx_ring->syncp);
+			start = u64_stats_fetch_begin(&tx_ring->syncp);
 			packets = tx_ring->tx_stats.cnt;
 			bytes = tx_ring->tx_stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&tx_ring->syncp, start));
+		} while (u64_stats_fetch_retry(&tx_ring->syncp, start));
 
 		stats->tx_packets += packets;
 		stats->tx_bytes += bytes;
@@ -3281,20 +3281,20 @@ static void ena_get_stats64(struct net_device *netdev,
 		rx_ring = &adapter->rx_ring[i];
 
 		do {
-			start = u64_stats_fetch_begin_irq(&rx_ring->syncp);
+			start = u64_stats_fetch_begin(&rx_ring->syncp);
 			packets = rx_ring->rx_stats.cnt;
 			bytes = rx_ring->rx_stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&rx_ring->syncp, start));
+		} while (u64_stats_fetch_retry(&rx_ring->syncp, start));
 
 		stats->rx_packets += packets;
 		stats->rx_bytes += bytes;
 	}
 
 	do {
-		start = u64_stats_fetch_begin_irq(&adapter->syncp);
+		start = u64_stats_fetch_begin(&adapter->syncp);
 		rx_drops = adapter->dev_stats.rx_drops;
 		tx_drops = adapter->dev_stats.tx_drops;
-	} while (u64_stats_fetch_retry_irq(&adapter->syncp, start));
+	} while (u64_stats_fetch_retry(&adapter->syncp, start));
 
 	stats->rx_dropped = rx_drops;
 	stats->tx_dropped = tx_drops;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 25129e723b575..1e8d902e1c8ea 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -934,7 +934,7 @@ unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
 		/* This data should mimic aq_ethtool_queue_rx_stat_names structure */
 		do {
 			count = 0;
-			start = u64_stats_fetch_begin_irq(&self->stats.rx.syncp);
+			start = u64_stats_fetch_begin(&self->stats.rx.syncp);
 			data[count] = self->stats.rx.packets;
 			data[++count] = self->stats.rx.jumbo_packets;
 			data[++count] = self->stats.rx.lro_packets;
@@ -951,15 +951,15 @@ unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
 			data[++count] = self->stats.rx.xdp_tx;
 			data[++count] = self->stats.rx.xdp_invalid;
 			data[++count] = self->stats.rx.xdp_redirect;
-		} while (u64_stats_fetch_retry_irq(&self->stats.rx.syncp, start));
+		} while (u64_stats_fetch_retry(&self->stats.rx.syncp, start));
 	} else {
 		/* This data should mimic aq_ethtool_queue_tx_stat_names structure */
 		do {
 			count = 0;
-			start = u64_stats_fetch_begin_irq(&self->stats.tx.syncp);
+			start = u64_stats_fetch_begin(&self->stats.tx.syncp);
 			data[count] = self->stats.tx.packets;
 			data[++count] = self->stats.tx.queue_restarts;
-		} while (u64_stats_fetch_retry_irq(&self->stats.tx.syncp, start));
+		} while (u64_stats_fetch_retry(&self->stats.tx.syncp, start));
 	}
 
 	return ++count;
diff --git a/drivers/net/ethernet/asix/ax88796c_main.c b/drivers/net/ethernet/asix/ax88796c_main.c
index 6ba5b024a7be7..25e7beb68e515 100644
--- a/drivers/net/ethernet/asix/ax88796c_main.c
+++ b/drivers/net/ethernet/asix/ax88796c_main.c
@@ -662,12 +662,12 @@ static void ax88796c_get_stats64(struct net_device *ndev,
 		s = per_cpu_ptr(ax_local->stats, cpu);
 
 		do {
-			start = u64_stats_fetch_begin_irq(&s->syncp);
+			start = u64_stats_fetch_begin(&s->syncp);
 			rx_packets = u64_stats_read(&s->rx_packets);
 			rx_bytes   = u64_stats_read(&s->rx_bytes);
 			tx_packets = u64_stats_read(&s->tx_packets);
 			tx_bytes   = u64_stats_read(&s->tx_bytes);
-		} while (u64_stats_fetch_retry_irq(&s->syncp, start));
+		} while (u64_stats_fetch_retry(&s->syncp, start));
 
 		stats->rx_packets += rx_packets;
 		stats->rx_bytes   += rx_bytes;
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index e5857e88c2076..caf1714f36a18 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1680,7 +1680,7 @@ static void b44_get_stats64(struct net_device *dev,
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin_irq(&hwstat->syncp);
+		start = u64_stats_fetch_begin(&hwstat->syncp);
 
 		/* Convert HW stats into rtnl_link_stats64 stats. */
 		nstat->rx_packets = hwstat->rx_pkts;
@@ -1714,7 +1714,7 @@ static void b44_get_stats64(struct net_device *dev,
 		/* Carrier lost counter seems to be broken for some devices */
 		nstat->tx_carrier_errors = hwstat->tx_carrier_lost;
 #endif
-	} while (u64_stats_fetch_retry_irq(&hwstat->syncp, start));
+	} while (u64_stats_fetch_retry(&hwstat->syncp, start));
 
 }
 
@@ -2082,12 +2082,12 @@ static void b44_get_ethtool_stats(struct net_device *dev,
 	do {
 		data_src = &hwstat->tx_good_octets;
 		data_dst = data;
-		start = u64_stats_fetch_begin_irq(&hwstat->syncp);
+		start = u64_stats_fetch_begin(&hwstat->syncp);
 
 		for (i = 0; i < ARRAY_SIZE(b44_gstrings); i++)
 			*data_dst++ = *data_src++;
 
-	} while (u64_stats_fetch_retry_irq(&hwstat->syncp, start));
+	} while (u64_stats_fetch_retry(&hwstat->syncp, start));
 }
 
 static void b44_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 47fc8e6963d59..98d5bd15ee433 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -457,10 +457,10 @@ static void bcm_sysport_update_tx_stats(struct bcm_sysport_priv *priv,
 	for (q = 0; q < priv->netdev->num_tx_queues; q++) {
 		ring = &priv->tx_rings[q];
 		do {
-			start = u64_stats_fetch_begin_irq(&priv->syncp);
+			start = u64_stats_fetch_begin(&priv->syncp);
 			bytes = ring->bytes;
 			packets = ring->packets;
-		} while (u64_stats_fetch_retry_irq(&priv->syncp, start));
+		} while (u64_stats_fetch_retry(&priv->syncp, start));
 
 		*tx_bytes += bytes;
 		*tx_packets += packets;
@@ -504,9 +504,9 @@ static void bcm_sysport_get_stats(struct net_device *dev,
 		if (s->stat_sizeof == sizeof(u64) &&
 		    s->type == BCM_SYSPORT_STAT_NETDEV64) {
 			do {
-				start = u64_stats_fetch_begin_irq(syncp);
+				start = u64_stats_fetch_begin(syncp);
 				data[i] = *(u64 *)p;
-			} while (u64_stats_fetch_retry_irq(syncp, start));
+			} while (u64_stats_fetch_retry(syncp, start));
 		} else
 			data[i] = *(u32 *)p;
 		j++;
@@ -1878,10 +1878,10 @@ static void bcm_sysport_get_stats64(struct net_device *dev,
 				    &stats->tx_packets);
 
 	do {
-		start = u64_stats_fetch_begin_irq(&priv->syncp);
+		start = u64_stats_fetch_begin(&priv->syncp);
 		stats->rx_packets = stats64->rx_packets;
 		stats->rx_bytes = stats64->rx_bytes;
-	} while (u64_stats_fetch_retry_irq(&priv->syncp, start));
+	} while (u64_stats_fetch_retry(&priv->syncp, start));
 }
 
 static void bcm_sysport_netif_start(struct net_device *dev)
diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index bd0df189d8719..39e7a4a3c15e6 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -389,10 +389,10 @@ static void be_get_ethtool_stats(struct net_device *netdev,
 		struct be_rx_stats *stats = rx_stats(rxo);
 
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->sync);
+			start = u64_stats_fetch_begin(&stats->sync);
 			data[base] = stats->rx_bytes;
 			data[base + 1] = stats->rx_pkts;
-		} while (u64_stats_fetch_retry_irq(&stats->sync, start));
+		} while (u64_stats_fetch_retry(&stats->sync, start));
 
 		for (i = 2; i < ETHTOOL_RXSTATS_NUM; i++) {
 			p = (u8 *)stats + et_rx_stats[i].offset;
@@ -405,19 +405,19 @@ static void be_get_ethtool_stats(struct net_device *netdev,
 		struct be_tx_stats *stats = tx_stats(txo);
 
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->sync_compl);
+			start = u64_stats_fetch_begin(&stats->sync_compl);
 			data[base] = stats->tx_compl;
-		} while (u64_stats_fetch_retry_irq(&stats->sync_compl, start));
+		} while (u64_stats_fetch_retry(&stats->sync_compl, start));
 
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->sync);
+			start = u64_stats_fetch_begin(&stats->sync);
 			for (i = 1; i < ETHTOOL_TXSTATS_NUM; i++) {
 				p = (u8 *)stats + et_tx_stats[i].offset;
 				data[base + i] =
 					(et_tx_stats[i].size == sizeof(u64)) ?
 						*(u64 *)p : *(u32 *)p;
 			}
-		} while (u64_stats_fetch_retry_irq(&stats->sync, start));
+		} while (u64_stats_fetch_retry(&stats->sync, start));
 		base += ETHTOOL_TXSTATS_NUM;
 	}
 }
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 414362febbb9d..9350c901aa27b 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -665,10 +665,10 @@ static void be_get_stats64(struct net_device *netdev,
 		const struct be_rx_stats *rx_stats = rx_stats(rxo);
 
 		do {
-			start = u64_stats_fetch_begin_irq(&rx_stats->sync);
+			start = u64_stats_fetch_begin(&rx_stats->sync);
 			pkts = rx_stats(rxo)->rx_pkts;
 			bytes = rx_stats(rxo)->rx_bytes;
-		} while (u64_stats_fetch_retry_irq(&rx_stats->sync, start));
+		} while (u64_stats_fetch_retry(&rx_stats->sync, start));
 		stats->rx_packets += pkts;
 		stats->rx_bytes += bytes;
 		stats->multicast += rx_stats(rxo)->rx_mcast_pkts;
@@ -680,10 +680,10 @@ static void be_get_stats64(struct net_device *netdev,
 		const struct be_tx_stats *tx_stats = tx_stats(txo);
 
 		do {
-			start = u64_stats_fetch_begin_irq(&tx_stats->sync);
+			start = u64_stats_fetch_begin(&tx_stats->sync);
 			pkts = tx_stats(txo)->tx_pkts;
 			bytes = tx_stats(txo)->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&tx_stats->sync, start));
+		} while (u64_stats_fetch_retry(&tx_stats->sync, start));
 		stats->tx_packets += pkts;
 		stats->tx_bytes += bytes;
 	}
@@ -2155,16 +2155,16 @@ static int be_get_new_eqd(struct be_eq_obj *eqo)
 
 	for_all_rx_queues_on_eq(adapter, eqo, rxo, i) {
 		do {
-			start = u64_stats_fetch_begin_irq(&rxo->stats.sync);
+			start = u64_stats_fetch_begin(&rxo->stats.sync);
 			rx_pkts += rxo->stats.rx_pkts;
-		} while (u64_stats_fetch_retry_irq(&rxo->stats.sync, start));
+		} while (u64_stats_fetch_retry(&rxo->stats.sync, start));
 	}
 
 	for_all_tx_queues_on_eq(adapter, eqo, txo, i) {
 		do {
-			start = u64_stats_fetch_begin_irq(&txo->stats.sync);
+			start = u64_stats_fetch_begin(&txo->stats.sync);
 			tx_pkts += txo->stats.tx_reqs;
-		} while (u64_stats_fetch_retry_irq(&txo->stats.sync, start));
+		} while (u64_stats_fetch_retry(&txo->stats.sync, start));
 	}
 
 	/* Skip, if wrapped around or first calculation */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 35d70041b9e84..f82e98263307a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2486,7 +2486,7 @@ static void hns3_fetch_stats(struct rtnl_link_stats64 *stats,
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin_irq(&ring->syncp);
+		start = u64_stats_fetch_begin(&ring->syncp);
 		if (is_tx) {
 			stats->tx_bytes += ring->stats.tx_bytes;
 			stats->tx_packets += ring->stats.tx_pkts;
@@ -2520,7 +2520,7 @@ static void hns3_fetch_stats(struct rtnl_link_stats64 *stats,
 			stats->multicast += ring->stats.rx_multicast;
 			stats->rx_length_errors += ring->stats.err_pkt_len;
 		}
-	} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+	} while (u64_stats_fetch_retry(&ring->syncp, start));
 }
 
 static void hns3_nic_get_stats64(struct net_device *netdev,
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 2cca9e84e31e1..34ab5ff9823b7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1229,10 +1229,10 @@ static void fm10k_get_stats64(struct net_device *netdev,
 			continue;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			start = u64_stats_fetch_begin(&ring->syncp);
 			packets = ring->stats.packets;
 			bytes   = ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 
 		stats->rx_packets += packets;
 		stats->rx_bytes   += bytes;
@@ -1245,10 +1245,10 @@ static void fm10k_get_stats64(struct net_device *netdev,
 			continue;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			start = u64_stats_fetch_begin(&ring->syncp);
 			packets = ring->stats.packets;
 			bytes   = ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 
 		stats->tx_packets += packets;
 		stats->tx_bytes   += bytes;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 156e92c437803..8dbd86465165e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -154,7 +154,7 @@ __i40e_add_ethtool_stats(u64 **data, void *pointer,
  * @ring: the ring to copy
  *
  * Queue statistics must be copied while protected by
- * u64_stats_fetch_begin_irq, so we can't directly use i40e_add_ethtool_stats.
+ * u64_stats_fetch_begin, so we can't directly use i40e_add_ethtool_stats.
  * Assumes that queue stats are defined in i40e_gstrings_queue_stats. If the
  * ring pointer is null, zero out the queue stat values and update the data
  * pointer. Otherwise safely copy the stats from the ring into the supplied
@@ -172,16 +172,16 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
 
 	/* To avoid invalid statistics values, ensure that we keep retrying
 	 * the copy until we get a consistent value according to
-	 * u64_stats_fetch_retry_irq. But first, make sure our ring is
+	 * u64_stats_fetch_retry. But first, make sure our ring is
 	 * non-null before attempting to access its syncp.
 	 */
 	do {
-		start = !ring ? 0 : u64_stats_fetch_begin_irq(&ring->syncp);
+		start = !ring ? 0 : u64_stats_fetch_begin(&ring->syncp);
 		for (i = 0; i < size; i++) {
 			i40e_add_one_ethtool_stat(&(*data)[i], ring,
 						  &stats[i]);
 		}
-	} while (ring && u64_stats_fetch_retry_irq(&ring->syncp, start));
+	} while (ring && u64_stats_fetch_retry(&ring->syncp, start));
 
 	/* Once we successfully copy the stats in, update the data pointer */
 	*data += size;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b36bf9c3e1e49..c5ba822ddb33d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -416,10 +416,10 @@ static void i40e_get_netdev_stats_struct_tx(struct i40e_ring *ring,
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin_irq(&ring->syncp);
+		start = u64_stats_fetch_begin(&ring->syncp);
 		packets = ring->stats.packets;
 		bytes   = ring->stats.bytes;
-	} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+	} while (u64_stats_fetch_retry(&ring->syncp, start));
 
 	stats->tx_packets += packets;
 	stats->tx_bytes   += bytes;
@@ -469,10 +469,10 @@ static void i40e_get_netdev_stats_struct(struct net_device *netdev,
 		if (!ring)
 			continue;
 		do {
-			start   = u64_stats_fetch_begin_irq(&ring->syncp);
+			start   = u64_stats_fetch_begin(&ring->syncp);
 			packets = ring->stats.packets;
 			bytes   = ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 
 		stats->rx_packets += packets;
 		stats->rx_bytes   += bytes;
@@ -894,10 +894,10 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 			continue;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&p->syncp);
+			start = u64_stats_fetch_begin(&p->syncp);
 			packets = p->stats.packets;
 			bytes = p->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&p->syncp, start));
+		} while (u64_stats_fetch_retry(&p->syncp, start));
 		tx_b += bytes;
 		tx_p += packets;
 		tx_restart += p->tx_stats.restart_queue;
@@ -912,10 +912,10 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 			continue;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&p->syncp);
+			start = u64_stats_fetch_begin(&p->syncp);
 			packets = p->stats.packets;
 			bytes = p->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&p->syncp, start));
+		} while (u64_stats_fetch_retry(&p->syncp, start));
 		rx_b += bytes;
 		rx_p += packets;
 		rx_buf += p->rx_stats.alloc_buff_failed;
@@ -932,10 +932,10 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 				continue;
 
 			do {
-				start = u64_stats_fetch_begin_irq(&p->syncp);
+				start = u64_stats_fetch_begin(&p->syncp);
 				packets = p->stats.packets;
 				bytes = p->stats.bytes;
-			} while (u64_stats_fetch_retry_irq(&p->syncp, start));
+			} while (u64_stats_fetch_retry(&p->syncp, start));
 			tx_b += bytes;
 			tx_p += packets;
 			tx_restart += p->tx_stats.restart_queue;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index e535d4c3da49d..fafa3406e0bcc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -147,7 +147,7 @@ __iavf_add_ethtool_stats(u64 **data, void *pointer,
  * @ring: the ring to copy
  *
  * Queue statistics must be copied while protected by
- * u64_stats_fetch_begin_irq, so we can't directly use iavf_add_ethtool_stats.
+ * u64_stats_fetch_begin, so we can't directly use iavf_add_ethtool_stats.
  * Assumes that queue stats are defined in iavf_gstrings_queue_stats. If the
  * ring pointer is null, zero out the queue stat values and update the data
  * pointer. Otherwise safely copy the stats from the ring into the supplied
@@ -165,14 +165,14 @@ iavf_add_queue_stats(u64 **data, struct iavf_ring *ring)
 
 	/* To avoid invalid statistics values, ensure that we keep retrying
 	 * the copy until we get a consistent value according to
-	 * u64_stats_fetch_retry_irq. But first, make sure our ring is
+	 * u64_stats_fetch_retry. But first, make sure our ring is
 	 * non-null before attempting to access its syncp.
 	 */
 	do {
-		start = !ring ? 0 : u64_stats_fetch_begin_irq(&ring->syncp);
+		start = !ring ? 0 : u64_stats_fetch_begin(&ring->syncp);
 		for (i = 0; i < size; i++)
 			iavf_add_one_ethtool_stat(&(*data)[i], ring, &stats[i]);
-	} while (ring && u64_stats_fetch_retry_irq(&ring->syncp, start));
+	} while (ring && u64_stats_fetch_retry(&ring->syncp, start));
 
 	/* Once we successfully copy the stats in, update the data pointer */
 	*data += size;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index eb40526ee179f..20caf14b06be1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6270,10 +6270,10 @@ ice_fetch_u64_stats_per_ring(struct u64_stats_sync *syncp,
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin_irq(syncp);
+		start = u64_stats_fetch_begin(syncp);
 		*pkts = stats.pkts;
 		*bytes = stats.bytes;
-	} while (u64_stats_fetch_retry_irq(syncp, start));
+	} while (u64_stats_fetch_retry(syncp, start));
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index c14fc871dd417..23c6fcfcb905c 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2311,15 +2311,15 @@ static void igb_get_ethtool_stats(struct net_device *netdev,
 
 		ring = adapter->tx_ring[j];
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->tx_syncp);
+			start = u64_stats_fetch_begin(&ring->tx_syncp);
 			data[i]   = ring->tx_stats.packets;
 			data[i+1] = ring->tx_stats.bytes;
 			data[i+2] = ring->tx_stats.restart_queue;
-		} while (u64_stats_fetch_retry_irq(&ring->tx_syncp, start));
+		} while (u64_stats_fetch_retry(&ring->tx_syncp, start));
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->tx_syncp2);
+			start = u64_stats_fetch_begin(&ring->tx_syncp2);
 			restart2  = ring->tx_stats.restart_queue2;
-		} while (u64_stats_fetch_retry_irq(&ring->tx_syncp2, start));
+		} while (u64_stats_fetch_retry(&ring->tx_syncp2, start));
 		data[i+2] += restart2;
 
 		i += IGB_TX_QUEUE_STATS_LEN;
@@ -2327,13 +2327,13 @@ static void igb_get_ethtool_stats(struct net_device *netdev,
 	for (j = 0; j < adapter->num_rx_queues; j++) {
 		ring = adapter->rx_ring[j];
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->rx_syncp);
+			start = u64_stats_fetch_begin(&ring->rx_syncp);
 			data[i]   = ring->rx_stats.packets;
 			data[i+1] = ring->rx_stats.bytes;
 			data[i+2] = ring->rx_stats.drops;
 			data[i+3] = ring->rx_stats.csum_err;
 			data[i+4] = ring->rx_stats.alloc_failed;
-		} while (u64_stats_fetch_retry_irq(&ring->rx_syncp, start));
+		} while (u64_stats_fetch_retry(&ring->rx_syncp, start));
 		i += IGB_RX_QUEUE_STATS_LEN;
 	}
 	spin_unlock(&adapter->stats64_lock);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d8b836a85cc30..b1985be57acca 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6626,10 +6626,10 @@ void igb_update_stats(struct igb_adapter *adapter)
 		}
 
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->rx_syncp);
+			start = u64_stats_fetch_begin(&ring->rx_syncp);
 			_bytes = ring->rx_stats.bytes;
 			_packets = ring->rx_stats.packets;
-		} while (u64_stats_fetch_retry_irq(&ring->rx_syncp, start));
+		} while (u64_stats_fetch_retry(&ring->rx_syncp, start));
 		bytes += _bytes;
 		packets += _packets;
 	}
@@ -6642,10 +6642,10 @@ void igb_update_stats(struct igb_adapter *adapter)
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igb_ring *ring = adapter->tx_ring[i];
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->tx_syncp);
+			start = u64_stats_fetch_begin(&ring->tx_syncp);
 			_bytes = ring->tx_stats.bytes;
 			_packets = ring->tx_stats.packets;
-		} while (u64_stats_fetch_retry_irq(&ring->tx_syncp, start));
+		} while (u64_stats_fetch_retry(&ring->tx_syncp, start));
 		bytes += _bytes;
 		packets += _packets;
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 8cc077b712add..5a26a7805ef80 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -839,15 +839,15 @@ static void igc_ethtool_get_stats(struct net_device *netdev,
 
 		ring = adapter->tx_ring[j];
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->tx_syncp);
+			start = u64_stats_fetch_begin(&ring->tx_syncp);
 			data[i]   = ring->tx_stats.packets;
 			data[i + 1] = ring->tx_stats.bytes;
 			data[i + 2] = ring->tx_stats.restart_queue;
-		} while (u64_stats_fetch_retry_irq(&ring->tx_syncp, start));
+		} while (u64_stats_fetch_retry(&ring->tx_syncp, start));
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->tx_syncp2);
+			start = u64_stats_fetch_begin(&ring->tx_syncp2);
 			restart2  = ring->tx_stats.restart_queue2;
-		} while (u64_stats_fetch_retry_irq(&ring->tx_syncp2, start));
+		} while (u64_stats_fetch_retry(&ring->tx_syncp2, start));
 		data[i + 2] += restart2;
 
 		i += IGC_TX_QUEUE_STATS_LEN;
@@ -855,13 +855,13 @@ static void igc_ethtool_get_stats(struct net_device *netdev,
 	for (j = 0; j < adapter->num_rx_queues; j++) {
 		ring = adapter->rx_ring[j];
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->rx_syncp);
+			start = u64_stats_fetch_begin(&ring->rx_syncp);
 			data[i]   = ring->rx_stats.packets;
 			data[i + 1] = ring->rx_stats.bytes;
 			data[i + 2] = ring->rx_stats.drops;
 			data[i + 3] = ring->rx_stats.csum_err;
 			data[i + 4] = ring->rx_stats.alloc_failed;
-		} while (u64_stats_fetch_retry_irq(&ring->rx_syncp, start));
+		} while (u64_stats_fetch_retry(&ring->rx_syncp, start));
 		i += IGC_RX_QUEUE_STATS_LEN;
 	}
 	spin_unlock(&adapter->stats64_lock);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ebff0e04045d6..944299b06cc3d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4645,10 +4645,10 @@ void igc_update_stats(struct igc_adapter *adapter)
 		}
 
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->rx_syncp);
+			start = u64_stats_fetch_begin(&ring->rx_syncp);
 			_bytes = ring->rx_stats.bytes;
 			_packets = ring->rx_stats.packets;
-		} while (u64_stats_fetch_retry_irq(&ring->rx_syncp, start));
+		} while (u64_stats_fetch_retry(&ring->rx_syncp, start));
 		bytes += _bytes;
 		packets += _packets;
 	}
@@ -4662,10 +4662,10 @@ void igc_update_stats(struct igc_adapter *adapter)
 		struct igc_ring *ring = adapter->tx_ring[i];
 
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->tx_syncp);
+			start = u64_stats_fetch_begin(&ring->tx_syncp);
 			_bytes = ring->tx_stats.bytes;
 			_packets = ring->tx_stats.packets;
-		} while (u64_stats_fetch_retry_irq(&ring->tx_syncp, start));
+		} while (u64_stats_fetch_retry(&ring->tx_syncp, start));
 		bytes += _bytes;
 		packets += _packets;
 	}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 04f453eabef64..51bcf0df3adcc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1335,10 +1335,10 @@ static void ixgbe_get_ethtool_stats(struct net_device *netdev,
 		}
 
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			start = u64_stats_fetch_begin(&ring->syncp);
 			data[i]   = ring->stats.packets;
 			data[i+1] = ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		i += 2;
 	}
 	for (j = 0; j < IXGBE_NUM_RX_QUEUES; j++) {
@@ -1351,10 +1351,10 @@ static void ixgbe_get_ethtool_stats(struct net_device *netdev,
 		}
 
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			start = u64_stats_fetch_begin(&ring->syncp);
 			data[i]   = ring->stats.packets;
 			data[i+1] = ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		i += 2;
 	}
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d1e430b8c8aa1..01c5548f181d5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9041,10 +9041,10 @@ static void ixgbe_get_ring_stats64(struct rtnl_link_stats64 *stats,
 
 	if (ring) {
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			start = u64_stats_fetch_begin(&ring->syncp);
 			packets = ring->stats.packets;
 			bytes   = ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		stats->tx_packets += packets;
 		stats->tx_bytes   += bytes;
 	}
@@ -9064,10 +9064,10 @@ static void ixgbe_get_stats64(struct net_device *netdev,
 
 		if (ring) {
 			do {
-				start = u64_stats_fetch_begin_irq(&ring->syncp);
+				start = u64_stats_fetch_begin(&ring->syncp);
 				packets = ring->stats.packets;
 				bytes   = ring->stats.bytes;
-			} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+			} while (u64_stats_fetch_retry(&ring->syncp, start));
 			stats->rx_packets += packets;
 			stats->rx_bytes   += bytes;
 		}
diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index fed46872af2bf..b4632b67ab143 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -458,10 +458,10 @@ static void ixgbevf_get_ethtool_stats(struct net_device *netdev,
 		}
 
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			start = u64_stats_fetch_begin(&ring->syncp);
 			data[i]   = ring->stats.packets;
 			data[i + 1] = ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		i += 2;
 	}
 
@@ -475,10 +475,10 @@ static void ixgbevf_get_ethtool_stats(struct net_device *netdev,
 		}
 
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			start = u64_stats_fetch_begin(&ring->syncp);
 			data[i] = ring->stats.packets;
 			data[i + 1] = ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		i += 2;
 	}
 
@@ -492,10 +492,10 @@ static void ixgbevf_get_ethtool_stats(struct net_device *netdev,
 		}
 
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			start = u64_stats_fetch_begin(&ring->syncp);
 			data[i]   = ring->stats.packets;
 			data[i + 1] = ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		i += 2;
 	}
 }
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 2f12fbe229c15..1d31b8cff4f10 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4350,10 +4350,10 @@ static void ixgbevf_get_tx_ring_stats(struct rtnl_link_stats64 *stats,
 
 	if (ring) {
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			start = u64_stats_fetch_begin(&ring->syncp);
 			bytes = ring->stats.bytes;
 			packets = ring->stats.packets;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		stats->tx_bytes += bytes;
 		stats->tx_packets += packets;
 	}
@@ -4376,10 +4376,10 @@ static void ixgbevf_get_stats(struct net_device *netdev,
 	for (i = 0; i < adapter->num_rx_queues; i++) {
 		ring = adapter->rx_ring[i];
 		do {
-			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			start = u64_stats_fetch_begin(&ring->syncp);
 			bytes = ring->stats.bytes;
 			packets = ring->stats.packets;
-		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		stats->rx_bytes += bytes;
 		stats->rx_packets += packets;
 	}
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0caa2df87c044..89ea3ef0ee162 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -813,14 +813,14 @@ mvneta_get_stats64(struct net_device *dev,
 
 		cpu_stats = per_cpu_ptr(pp->stats, cpu);
 		do {
-			start = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
 			rx_packets = cpu_stats->es.ps.rx_packets;
 			rx_bytes   = cpu_stats->es.ps.rx_bytes;
 			rx_dropped = cpu_stats->rx_dropped;
 			rx_errors  = cpu_stats->rx_errors;
 			tx_packets = cpu_stats->es.ps.tx_packets;
 			tx_bytes   = cpu_stats->es.ps.tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		stats->rx_packets += rx_packets;
 		stats->rx_bytes   += rx_bytes;
@@ -4762,7 +4762,7 @@ mvneta_ethtool_update_pcpu_stats(struct mvneta_port *pp,
 
 		stats = per_cpu_ptr(pp->stats, cpu);
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			start = u64_stats_fetch_begin(&stats->syncp);
 			skb_alloc_error = stats->es.skb_alloc_error;
 			refill_error = stats->es.refill_error;
 			xdp_redirect = stats->es.ps.xdp_redirect;
@@ -4772,7 +4772,7 @@ mvneta_ethtool_update_pcpu_stats(struct mvneta_port *pp,
 			xdp_xmit_err = stats->es.ps.xdp_xmit_err;
 			xdp_tx = stats->es.ps.xdp_tx;
 			xdp_tx_err = stats->es.ps.xdp_tx_err;
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		es->skb_alloc_error += skb_alloc_error;
 		es->refill_error += refill_error;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index b84128b549b44..cdeea98e0b8c7 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2008,7 +2008,7 @@ mvpp2_get_xdp_stats(struct mvpp2_port *port, struct mvpp2_pcpu_stats *xdp_stats)
 
 		cpu_stats = per_cpu_ptr(port->stats, cpu);
 		do {
-			start = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
 			xdp_redirect = cpu_stats->xdp_redirect;
 			xdp_pass   = cpu_stats->xdp_pass;
 			xdp_drop = cpu_stats->xdp_drop;
@@ -2016,7 +2016,7 @@ mvpp2_get_xdp_stats(struct mvpp2_port *port, struct mvpp2_pcpu_stats *xdp_stats)
 			xdp_xmit_err   = cpu_stats->xdp_xmit_err;
 			xdp_tx   = cpu_stats->xdp_tx;
 			xdp_tx_err   = cpu_stats->xdp_tx_err;
-		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		xdp_stats->xdp_redirect += xdp_redirect;
 		xdp_stats->xdp_pass   += xdp_pass;
@@ -5115,12 +5115,12 @@ mvpp2_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 
 		cpu_stats = per_cpu_ptr(port->stats, cpu);
 		do {
-			start = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
 			rx_packets = cpu_stats->rx_packets;
 			rx_bytes   = cpu_stats->rx_bytes;
 			tx_packets = cpu_stats->tx_packets;
 			tx_bytes   = cpu_stats->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		stats->rx_packets += rx_packets;
 		stats->rx_bytes   += rx_bytes;
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index bbea5458000bf..c9bb92187719c 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -3894,19 +3894,19 @@ static void sky2_get_stats(struct net_device *dev,
 	u64 _bytes, _packets;
 
 	do {
-		start = u64_stats_fetch_begin_irq(&sky2->rx_stats.syncp);
+		start = u64_stats_fetch_begin(&sky2->rx_stats.syncp);
 		_bytes = sky2->rx_stats.bytes;
 		_packets = sky2->rx_stats.packets;
-	} while (u64_stats_fetch_retry_irq(&sky2->rx_stats.syncp, start));
+	} while (u64_stats_fetch_retry(&sky2->rx_stats.syncp, start));
 
 	stats->rx_packets = _packets;
 	stats->rx_bytes = _bytes;
 
 	do {
-		start = u64_stats_fetch_begin_irq(&sky2->tx_stats.syncp);
+		start = u64_stats_fetch_begin(&sky2->tx_stats.syncp);
 		_bytes = sky2->tx_stats.bytes;
 		_packets = sky2->tx_stats.packets;
-	} while (u64_stats_fetch_retry_irq(&sky2->tx_stats.syncp, start));
+	} while (u64_stats_fetch_retry(&sky2->tx_stats.syncp, start));
 
 	stats->tx_packets = _packets;
 	stats->tx_bytes = _bytes;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index d9426b01f4628..72ed53e795330 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -853,7 +853,7 @@ static void mtk_get_stats64(struct net_device *dev,
 	}
 
 	do {
-		start = u64_stats_fetch_begin_irq(&hw_stats->syncp);
+		start = u64_stats_fetch_begin(&hw_stats->syncp);
 		storage->rx_packets = hw_stats->rx_packets;
 		storage->tx_packets = hw_stats->tx_packets;
 		storage->rx_bytes = hw_stats->rx_bytes;
@@ -865,7 +865,7 @@ static void mtk_get_stats64(struct net_device *dev,
 		storage->rx_crc_errors = hw_stats->rx_fcs_errors;
 		storage->rx_errors = hw_stats->rx_checksum_errors;
 		storage->tx_aborted_errors = hw_stats->tx_skip;
-	} while (u64_stats_fetch_retry_irq(&hw_stats->syncp, start));
+	} while (u64_stats_fetch_retry(&hw_stats->syncp, start));
 
 	storage->tx_errors = dev->stats.tx_errors;
 	storage->rx_dropped = dev->stats.rx_dropped;
@@ -3662,13 +3662,13 @@ static void mtk_get_ethtool_stats(struct net_device *dev,
 
 	do {
 		data_dst = data;
-		start = u64_stats_fetch_begin_irq(&hwstats->syncp);
+		start = u64_stats_fetch_begin(&hwstats->syncp);
 
 		for (i = 0; i < ARRAY_SIZE(mtk_ethtool_stats); i++)
 			*data_dst++ = *(data_src + mtk_ethtool_stats[i].offset);
 		if (mtk_page_pool_enabled(mac->hw))
 			mtk_ethtool_pp_stats(mac->hw, data_dst);
-	} while (u64_stats_fetch_retry_irq(&hwstats->syncp, start));
+	} while (u64_stats_fetch_retry(&hwstats->syncp, start));
 }
 
 static int mtk_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 1e240cdd9cbde..4a6116914882e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -827,12 +827,12 @@ mlxsw_sp_port_get_sw_stats64(const struct net_device *dev,
 	for_each_possible_cpu(i) {
 		p = per_cpu_ptr(mlxsw_sp_port->pcpu_stats, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&p->syncp);
+			start = u64_stats_fetch_begin(&p->syncp);
 			rx_packets	= p->rx_packets;
 			rx_bytes	= p->rx_bytes;
 			tx_packets	= p->tx_packets;
 			tx_bytes	= p->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&p->syncp, start));
+		} while (u64_stats_fetch_retry(&p->syncp, start));
 
 		stats->rx_packets	+= rx_packets;
 		stats->rx_bytes		+= rx_bytes;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9259a74eca40b..318dbbb482797 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -315,10 +315,10 @@ static void mana_get_stats64(struct net_device *ndev,
 		rx_stats = &apc->rxqs[q]->stats;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&rx_stats->syncp);
+			start = u64_stats_fetch_begin(&rx_stats->syncp);
 			packets = rx_stats->packets;
 			bytes = rx_stats->bytes;
-		} while (u64_stats_fetch_retry_irq(&rx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
 
 		st->rx_packets += packets;
 		st->rx_bytes += bytes;
@@ -328,10 +328,10 @@ static void mana_get_stats64(struct net_device *ndev,
 		tx_stats = &apc->tx_qp[q].txq.stats;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&tx_stats->syncp);
+			start = u64_stats_fetch_begin(&tx_stats->syncp);
 			packets = tx_stats->packets;
 			bytes = tx_stats->bytes;
-		} while (u64_stats_fetch_retry_irq(&tx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
 
 		st->tx_packets += packets;
 		st->tx_bytes += bytes;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index c530db76880f0..96d55c91c9698 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -90,13 +90,13 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 		rx_stats = &apc->rxqs[q]->stats;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&rx_stats->syncp);
+			start = u64_stats_fetch_begin(&rx_stats->syncp);
 			packets = rx_stats->packets;
 			bytes = rx_stats->bytes;
 			xdp_drop = rx_stats->xdp_drop;
 			xdp_tx = rx_stats->xdp_tx;
 			xdp_redirect = rx_stats->xdp_redirect;
-		} while (u64_stats_fetch_retry_irq(&rx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
 
 		data[i++] = packets;
 		data[i++] = bytes;
@@ -109,11 +109,11 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 		tx_stats = &apc->tx_qp[q].txq.stats;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&tx_stats->syncp);
+			start = u64_stats_fetch_begin(&tx_stats->syncp);
 			packets = tx_stats->packets;
 			bytes = tx_stats->bytes;
 			xdp_xmit = tx_stats->xdp_xmit;
-		} while (u64_stats_fetch_retry_irq(&tx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
 
 		data[i++] = packets;
 		data[i++] = bytes;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index 8b77582bdfa01..a6b6ca1fd55ee 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -134,13 +134,13 @@ nfp_repr_get_host_stats64(const struct net_device *netdev,
 
 		repr_stats = per_cpu_ptr(repr->stats, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&repr_stats->syncp);
+			start = u64_stats_fetch_begin(&repr_stats->syncp);
 			tbytes = repr_stats->tx_bytes;
 			tpkts = repr_stats->tx_packets;
 			tdrops = repr_stats->tx_drops;
 			rbytes = repr_stats->rx_bytes;
 			rpkts = repr_stats->rx_packets;
-		} while (u64_stats_fetch_retry_irq(&repr_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&repr_stats->syncp, start));
 
 		stats->tx_bytes += tbytes;
 		stats->tx_packets += tpkts;
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 5116badaf0919..50ebbd7e91c48 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -1734,12 +1734,12 @@ static void nv_get_stats(int cpu, struct fe_priv *np,
 	u64 tx_packets, tx_bytes, tx_dropped;
 
 	do {
-		syncp_start = u64_stats_fetch_begin_irq(&np->swstats_rx_syncp);
+		syncp_start = u64_stats_fetch_begin(&np->swstats_rx_syncp);
 		rx_packets       = src->stat_rx_packets;
 		rx_bytes         = src->stat_rx_bytes;
 		rx_dropped       = src->stat_rx_dropped;
 		rx_missed_errors = src->stat_rx_missed_errors;
-	} while (u64_stats_fetch_retry_irq(&np->swstats_rx_syncp, syncp_start));
+	} while (u64_stats_fetch_retry(&np->swstats_rx_syncp, syncp_start));
 
 	storage->rx_packets       += rx_packets;
 	storage->rx_bytes         += rx_bytes;
@@ -1747,11 +1747,11 @@ static void nv_get_stats(int cpu, struct fe_priv *np,
 	storage->rx_missed_errors += rx_missed_errors;
 
 	do {
-		syncp_start = u64_stats_fetch_begin_irq(&np->swstats_tx_syncp);
+		syncp_start = u64_stats_fetch_begin(&np->swstats_tx_syncp);
 		tx_packets  = src->stat_tx_packets;
 		tx_bytes    = src->stat_tx_bytes;
 		tx_dropped  = src->stat_tx_dropped;
-	} while (u64_stats_fetch_retry_irq(&np->swstats_tx_syncp, syncp_start));
+	} while (u64_stats_fetch_retry(&np->swstats_tx_syncp, syncp_start));
 
 	storage->tx_packets += tx_packets;
 	storage->tx_bytes   += tx_bytes;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 1b2119b1d48aa..3f5e6572d20e7 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -135,9 +135,9 @@ static void rmnet_get_stats64(struct net_device *dev,
 		pcpu_ptr = per_cpu_ptr(priv->pcpu_stats, cpu);
 
 		do {
-			start = u64_stats_fetch_begin_irq(&pcpu_ptr->syncp);
+			start = u64_stats_fetch_begin(&pcpu_ptr->syncp);
 			snapshot = pcpu_ptr->stats;	/* struct assignment */
-		} while (u64_stats_fetch_retry_irq(&pcpu_ptr->syncp, start));
+		} while (u64_stats_fetch_retry(&pcpu_ptr->syncp, start));
 
 		total_stats.rx_pkts += snapshot.rx_pkts;
 		total_stats.rx_bytes += snapshot.rx_bytes;
diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index 15b40fd93cd2e..82bd0eb614634 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -2532,16 +2532,16 @@ rtl8139_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	netdev_stats_to_stats64(stats, &dev->stats);
 
 	do {
-		start = u64_stats_fetch_begin_irq(&tp->rx_stats.syncp);
+		start = u64_stats_fetch_begin(&tp->rx_stats.syncp);
 		stats->rx_packets = tp->rx_stats.packets;
 		stats->rx_bytes = tp->rx_stats.bytes;
-	} while (u64_stats_fetch_retry_irq(&tp->rx_stats.syncp, start));
+	} while (u64_stats_fetch_retry(&tp->rx_stats.syncp, start));
 
 	do {
-		start = u64_stats_fetch_begin_irq(&tp->tx_stats.syncp);
+		start = u64_stats_fetch_begin(&tp->tx_stats.syncp);
 		stats->tx_packets = tp->tx_stats.packets;
 		stats->tx_bytes = tp->tx_stats.bytes;
-	} while (u64_stats_fetch_retry_irq(&tp->tx_stats.syncp, start));
+	} while (u64_stats_fetch_retry(&tp->tx_stats.syncp, start));
 }
 
 /* Set or clear the multicast filter for this adaptor.
diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index f0c8de2c60755..d4f7238333bb7 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1506,16 +1506,16 @@ static void ave_get_stats64(struct net_device *ndev,
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin_irq(&priv->stats_rx.syncp);
+		start = u64_stats_fetch_begin(&priv->stats_rx.syncp);
 		stats->rx_packets = priv->stats_rx.packets;
 		stats->rx_bytes	  = priv->stats_rx.bytes;
-	} while (u64_stats_fetch_retry_irq(&priv->stats_rx.syncp, start));
+	} while (u64_stats_fetch_retry(&priv->stats_rx.syncp, start));
 
 	do {
-		start = u64_stats_fetch_begin_irq(&priv->stats_tx.syncp);
+		start = u64_stats_fetch_begin(&priv->stats_tx.syncp);
 		stats->tx_packets = priv->stats_tx.packets;
 		stats->tx_bytes	  = priv->stats_tx.bytes;
-	} while (u64_stats_fetch_retry_irq(&priv->stats_tx.syncp, start));
+	} while (u64_stats_fetch_retry(&priv->stats_tx.syncp, start));
 
 	stats->rx_errors      = priv->stats_rx.errors;
 	stats->tx_errors      = priv->stats_tx.errors;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index f4a6b590a1e39..1b62400c19049 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1365,12 +1365,12 @@ static void am65_cpsw_nuss_ndo_get_stats(struct net_device *dev,
 
 		cpu_stats = per_cpu_ptr(ndev_priv->stats, cpu);
 		do {
-			start = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
 			rx_packets = cpu_stats->rx_packets;
 			rx_bytes   = cpu_stats->rx_bytes;
 			tx_packets = cpu_stats->tx_packets;
 			tx_bytes   = cpu_stats->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		stats->rx_packets += rx_packets;
 		stats->rx_bytes   += rx_bytes;
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index b15d44261e766..68c7b2c05aab3 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1916,16 +1916,16 @@ netcp_get_stats(struct net_device *ndev, struct rtnl_link_stats64 *stats)
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin_irq(&p->syncp_rx);
+		start = u64_stats_fetch_begin(&p->syncp_rx);
 		rxpackets       = p->rx_packets;
 		rxbytes         = p->rx_bytes;
-	} while (u64_stats_fetch_retry_irq(&p->syncp_rx, start));
+	} while (u64_stats_fetch_retry(&p->syncp_rx, start));
 
 	do {
-		start = u64_stats_fetch_begin_irq(&p->syncp_tx);
+		start = u64_stats_fetch_begin(&p->syncp_tx);
 		txpackets       = p->tx_packets;
 		txbytes         = p->tx_bytes;
-	} while (u64_stats_fetch_retry_irq(&p->syncp_tx, start));
+	} while (u64_stats_fetch_retry(&p->syncp_tx, start));
 
 	stats->rx_packets = rxpackets;
 	stats->rx_bytes = rxbytes;
diff --git a/drivers/net/ethernet/via/via-rhine.c b/drivers/net/ethernet/via/via-rhine.c
index 509c5e9b29dfa..5301c907b5ae3 100644
--- a/drivers/net/ethernet/via/via-rhine.c
+++ b/drivers/net/ethernet/via/via-rhine.c
@@ -2217,16 +2217,16 @@ rhine_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	netdev_stats_to_stats64(stats, &dev->stats);
 
 	do {
-		start = u64_stats_fetch_begin_irq(&rp->rx_stats.syncp);
+		start = u64_stats_fetch_begin(&rp->rx_stats.syncp);
 		stats->rx_packets = rp->rx_stats.packets;
 		stats->rx_bytes = rp->rx_stats.bytes;
-	} while (u64_stats_fetch_retry_irq(&rp->rx_stats.syncp, start));
+	} while (u64_stats_fetch_retry(&rp->rx_stats.syncp, start));
 
 	do {
-		start = u64_stats_fetch_begin_irq(&rp->tx_stats.syncp);
+		start = u64_stats_fetch_begin(&rp->tx_stats.syncp);
 		stats->tx_packets = rp->tx_stats.packets;
 		stats->tx_bytes = rp->tx_stats.bytes;
-	} while (u64_stats_fetch_retry_irq(&rp->tx_stats.syncp, start));
+	} while (u64_stats_fetch_retry(&rp->tx_stats.syncp, start));
 }
 
 static void rhine_set_rx_mode(struct net_device *dev)
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 15ebd54266049..b68bed8f17dac 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1264,12 +1264,12 @@ static void netvsc_get_vf_stats(struct net_device *net,
 		unsigned int start;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			start = u64_stats_fetch_begin(&stats->syncp);
 			rx_packets = stats->rx_packets;
 			tx_packets = stats->tx_packets;
 			rx_bytes = stats->rx_bytes;
 			tx_bytes = stats->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		tot->rx_packets += rx_packets;
 		tot->tx_packets += tx_packets;
@@ -1294,12 +1294,12 @@ static void netvsc_get_pcpu_stats(struct net_device *net,
 		unsigned int start;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			start = u64_stats_fetch_begin(&stats->syncp);
 			this_tot->vf_rx_packets = stats->rx_packets;
 			this_tot->vf_tx_packets = stats->tx_packets;
 			this_tot->vf_rx_bytes = stats->rx_bytes;
 			this_tot->vf_tx_bytes = stats->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
 		this_tot->rx_packets = this_tot->vf_rx_packets;
 		this_tot->tx_packets = this_tot->vf_tx_packets;
 		this_tot->rx_bytes   = this_tot->vf_rx_bytes;
@@ -1318,20 +1318,20 @@ static void netvsc_get_pcpu_stats(struct net_device *net,
 
 		tx_stats = &nvchan->tx_stats;
 		do {
-			start = u64_stats_fetch_begin_irq(&tx_stats->syncp);
+			start = u64_stats_fetch_begin(&tx_stats->syncp);
 			packets = tx_stats->packets;
 			bytes = tx_stats->bytes;
-		} while (u64_stats_fetch_retry_irq(&tx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
 
 		this_tot->tx_bytes	+= bytes;
 		this_tot->tx_packets	+= packets;
 
 		rx_stats = &nvchan->rx_stats;
 		do {
-			start = u64_stats_fetch_begin_irq(&rx_stats->syncp);
+			start = u64_stats_fetch_begin(&rx_stats->syncp);
 			packets = rx_stats->packets;
 			bytes = rx_stats->bytes;
-		} while (u64_stats_fetch_retry_irq(&rx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
 
 		this_tot->rx_bytes	+= bytes;
 		this_tot->rx_packets	+= packets;
@@ -1370,21 +1370,21 @@ static void netvsc_get_stats64(struct net_device *net,
 
 		tx_stats = &nvchan->tx_stats;
 		do {
-			start = u64_stats_fetch_begin_irq(&tx_stats->syncp);
+			start = u64_stats_fetch_begin(&tx_stats->syncp);
 			packets = tx_stats->packets;
 			bytes = tx_stats->bytes;
-		} while (u64_stats_fetch_retry_irq(&tx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
 
 		t->tx_bytes	+= bytes;
 		t->tx_packets	+= packets;
 
 		rx_stats = &nvchan->rx_stats;
 		do {
-			start = u64_stats_fetch_begin_irq(&rx_stats->syncp);
+			start = u64_stats_fetch_begin(&rx_stats->syncp);
 			packets = rx_stats->packets;
 			bytes = rx_stats->bytes;
 			multicast = rx_stats->multicast + rx_stats->broadcast;
-		} while (u64_stats_fetch_retry_irq(&rx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
 
 		t->rx_bytes	+= bytes;
 		t->rx_packets	+= packets;
@@ -1527,24 +1527,24 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
 		tx_stats = &nvdev->chan_table[j].tx_stats;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&tx_stats->syncp);
+			start = u64_stats_fetch_begin(&tx_stats->syncp);
 			packets = tx_stats->packets;
 			bytes = tx_stats->bytes;
 			xdp_xmit = tx_stats->xdp_xmit;
-		} while (u64_stats_fetch_retry_irq(&tx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
 		data[i++] = packets;
 		data[i++] = bytes;
 		data[i++] = xdp_xmit;
 
 		rx_stats = &nvdev->chan_table[j].rx_stats;
 		do {
-			start = u64_stats_fetch_begin_irq(&rx_stats->syncp);
+			start = u64_stats_fetch_begin(&rx_stats->syncp);
 			packets = rx_stats->packets;
 			bytes = rx_stats->bytes;
 			xdp_drop = rx_stats->xdp_drop;
 			xdp_redirect = rx_stats->xdp_redirect;
 			xdp_tx = rx_stats->xdp_tx;
-		} while (u64_stats_fetch_retry_irq(&rx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
 		data[i++] = packets;
 		data[i++] = bytes;
 		data[i++] = xdp_drop;
diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 1c64d5347b8e0..78253ad57b2ef 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -162,18 +162,18 @@ static void ifb_stats64(struct net_device *dev,
 
 	for (i = 0; i < dev->num_tx_queues; i++,txp++) {
 		do {
-			start = u64_stats_fetch_begin_irq(&txp->rx_stats.sync);
+			start = u64_stats_fetch_begin(&txp->rx_stats.sync);
 			packets = txp->rx_stats.packets;
 			bytes = txp->rx_stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&txp->rx_stats.sync, start));
+		} while (u64_stats_fetch_retry(&txp->rx_stats.sync, start));
 		stats->rx_packets += packets;
 		stats->rx_bytes += bytes;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&txp->tx_stats.sync);
+			start = u64_stats_fetch_begin(&txp->tx_stats.sync);
 			packets = txp->tx_stats.packets;
 			bytes = txp->tx_stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&txp->tx_stats.sync, start));
+		} while (u64_stats_fetch_retry(&txp->tx_stats.sync, start));
 		stats->tx_packets += packets;
 		stats->tx_bytes += bytes;
 	}
@@ -245,12 +245,12 @@ static void ifb_fill_stats_data(u64 **data,
 	int j;
 
 	do {
-		start = u64_stats_fetch_begin_irq(&q_stats->sync);
+		start = u64_stats_fetch_begin(&q_stats->sync);
 		for (j = 0; j < IFB_Q_STATS_LEN; j++) {
 			offset = ifb_q_stats_desc[j].offset;
 			(*data)[j] = *(u64 *)(stats_base + offset);
 		}
-	} while (u64_stats_fetch_retry_irq(&q_stats->sync, start));
+	} while (u64_stats_fetch_retry(&q_stats->sync, start));
 
 	*data += IFB_Q_STATS_LEN;
 }
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 49ba8a50dfb1e..8a58d74638cd8 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -299,13 +299,13 @@ static void ipvlan_get_stats64(struct net_device *dev,
 		for_each_possible_cpu(idx) {
 			pcptr = per_cpu_ptr(ipvlan->pcpu_stats, idx);
 			do {
-				strt= u64_stats_fetch_begin_irq(&pcptr->syncp);
+				strt = u64_stats_fetch_begin(&pcptr->syncp);
 				rx_pkts = u64_stats_read(&pcptr->rx_pkts);
 				rx_bytes = u64_stats_read(&pcptr->rx_bytes);
 				rx_mcast = u64_stats_read(&pcptr->rx_mcast);
 				tx_pkts = u64_stats_read(&pcptr->tx_pkts);
 				tx_bytes = u64_stats_read(&pcptr->tx_bytes);
-			} while (u64_stats_fetch_retry_irq(&pcptr->syncp,
+			} while (u64_stats_fetch_retry(&pcptr->syncp,
 							   strt));
 
 			s->rx_packets += rx_pkts;
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 14e8d04cb4347..c4ad98d39ea60 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -106,10 +106,10 @@ void dev_lstats_read(struct net_device *dev, u64 *packets, u64 *bytes)
 
 		lb_stats = per_cpu_ptr(dev->lstats, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&lb_stats->syncp);
+			start = u64_stats_fetch_begin(&lb_stats->syncp);
 			tpackets = u64_stats_read(&lb_stats->packets);
 			tbytes = u64_stats_read(&lb_stats->bytes);
-		} while (u64_stats_fetch_retry_irq(&lb_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&lb_stats->syncp, start));
 		*bytes   += tbytes;
 		*packets += tpackets;
 	}
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ee6087e7b2bfb..f4fe202b47107 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2828,9 +2828,9 @@ static void get_rx_sc_stats(struct net_device *dev,
 
 		stats = per_cpu_ptr(rx_sc->stats, cpu);
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			start = u64_stats_fetch_begin(&stats->syncp);
 			memcpy(&tmp, &stats->stats, sizeof(tmp));
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		sum->InOctetsValidated += tmp.InOctetsValidated;
 		sum->InOctetsDecrypted += tmp.InOctetsDecrypted;
@@ -2909,9 +2909,9 @@ static void get_tx_sc_stats(struct net_device *dev,
 
 		stats = per_cpu_ptr(macsec_priv(dev)->secy.tx_sc.stats, cpu);
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			start = u64_stats_fetch_begin(&stats->syncp);
 			memcpy(&tmp, &stats->stats, sizeof(tmp));
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		sum->OutPktsProtected   += tmp.OutPktsProtected;
 		sum->OutPktsEncrypted   += tmp.OutPktsEncrypted;
@@ -2965,9 +2965,9 @@ static void get_secy_stats(struct net_device *dev, struct macsec_dev_stats *sum)
 
 		stats = per_cpu_ptr(macsec_priv(dev)->stats, cpu);
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			start = u64_stats_fetch_begin(&stats->syncp);
 			memcpy(&tmp, &stats->stats, sizeof(tmp));
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		sum->OutPktsUntagged  += tmp.OutPktsUntagged;
 		sum->InPktsUntagged   += tmp.InPktsUntagged;
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 1080d6ebff63b..a1c7823f0ba66 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -948,13 +948,13 @@ static void macvlan_dev_get_stats64(struct net_device *dev,
 		for_each_possible_cpu(i) {
 			p = per_cpu_ptr(vlan->pcpu_stats, i);
 			do {
-				start = u64_stats_fetch_begin_irq(&p->syncp);
+				start = u64_stats_fetch_begin(&p->syncp);
 				rx_packets	= u64_stats_read(&p->rx_packets);
 				rx_bytes	= u64_stats_read(&p->rx_bytes);
 				rx_multicast	= u64_stats_read(&p->rx_multicast);
 				tx_packets	= u64_stats_read(&p->tx_packets);
 				tx_bytes	= u64_stats_read(&p->tx_bytes);
-			} while (u64_stats_fetch_retry_irq(&p->syncp, start));
+			} while (u64_stats_fetch_retry(&p->syncp, start));
 
 			stats->rx_packets	+= rx_packets;
 			stats->rx_bytes		+= rx_bytes;
diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index 0b1b6f650104b..ff302144029de 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -104,19 +104,19 @@ static void mhi_ndo_get_stats64(struct net_device *ndev,
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin_irq(&mhi_netdev->stats.rx_syncp);
+		start = u64_stats_fetch_begin(&mhi_netdev->stats.rx_syncp);
 		stats->rx_packets = u64_stats_read(&mhi_netdev->stats.rx_packets);
 		stats->rx_bytes = u64_stats_read(&mhi_netdev->stats.rx_bytes);
 		stats->rx_errors = u64_stats_read(&mhi_netdev->stats.rx_errors);
-	} while (u64_stats_fetch_retry_irq(&mhi_netdev->stats.rx_syncp, start));
+	} while (u64_stats_fetch_retry(&mhi_netdev->stats.rx_syncp, start));
 
 	do {
-		start = u64_stats_fetch_begin_irq(&mhi_netdev->stats.tx_syncp);
+		start = u64_stats_fetch_begin(&mhi_netdev->stats.tx_syncp);
 		stats->tx_packets = u64_stats_read(&mhi_netdev->stats.tx_packets);
 		stats->tx_bytes = u64_stats_read(&mhi_netdev->stats.tx_bytes);
 		stats->tx_errors = u64_stats_read(&mhi_netdev->stats.tx_errors);
 		stats->tx_dropped = u64_stats_read(&mhi_netdev->stats.tx_dropped);
-	} while (u64_stats_fetch_retry_irq(&mhi_netdev->stats.tx_syncp, start));
+	} while (u64_stats_fetch_retry(&mhi_netdev->stats.tx_syncp, start));
 }
 
 static const struct net_device_ops mhi_netdev_ops = {
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index aac133a1e27a5..d42bd39701777 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1853,13 +1853,13 @@ team_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	for_each_possible_cpu(i) {
 		p = per_cpu_ptr(team->pcpu_stats, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&p->syncp);
+			start = u64_stats_fetch_begin(&p->syncp);
 			rx_packets	= u64_stats_read(&p->rx_packets);
 			rx_bytes	= u64_stats_read(&p->rx_bytes);
 			rx_multicast	= u64_stats_read(&p->rx_multicast);
 			tx_packets	= u64_stats_read(&p->tx_packets);
 			tx_bytes	= u64_stats_read(&p->tx_bytes);
-		} while (u64_stats_fetch_retry_irq(&p->syncp, start));
+		} while (u64_stats_fetch_retry(&p->syncp, start));
 
 		stats->rx_packets	+= rx_packets;
 		stats->rx_bytes		+= rx_bytes;
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index b095a4b4957bb..18d99fda997cf 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -466,9 +466,9 @@ static void __lb_one_cpu_stats_add(struct lb_stats *acc_stats,
 	struct lb_stats tmp;
 
 	do {
-		start = u64_stats_fetch_begin_irq(syncp);
+		start = u64_stats_fetch_begin(syncp);
 		tmp.tx_bytes = cpu_stats->tx_bytes;
-	} while (u64_stats_fetch_retry_irq(syncp, start));
+	} while (u64_stats_fetch_retry(syncp, start));
 	acc_stats->tx_bytes += tmp.tx_bytes;
 }
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 466da01ba2e3e..2da7cfcfe1c31 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -182,12 +182,12 @@ static void veth_get_ethtool_stats(struct net_device *dev,
 		size_t offset;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&rq_stats->syncp);
+			start = u64_stats_fetch_begin(&rq_stats->syncp);
 			for (j = 0; j < VETH_RQ_STATS_LEN; j++) {
 				offset = veth_rq_stats_desc[j].offset;
 				data[idx + j] = *(u64 *)(stats_base + offset);
 			}
-		} while (u64_stats_fetch_retry_irq(&rq_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&rq_stats->syncp, start));
 		idx += VETH_RQ_STATS_LEN;
 	}
 
@@ -203,12 +203,12 @@ static void veth_get_ethtool_stats(struct net_device *dev,
 
 		tx_idx += (i % dev->real_num_tx_queues) * VETH_TQ_STATS_LEN;
 		do {
-			start = u64_stats_fetch_begin_irq(&rq_stats->syncp);
+			start = u64_stats_fetch_begin(&rq_stats->syncp);
 			for (j = 0; j < VETH_TQ_STATS_LEN; j++) {
 				offset = veth_tq_stats_desc[j].offset;
 				data[tx_idx + j] += *(u64 *)(base + offset);
 			}
-		} while (u64_stats_fetch_retry_irq(&rq_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&rq_stats->syncp, start));
 	}
 }
 
@@ -379,13 +379,13 @@ static void veth_stats_rx(struct veth_stats *result, struct net_device *dev)
 		unsigned int start;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			start = u64_stats_fetch_begin(&stats->syncp);
 			peer_tq_xdp_xmit_err = stats->vs.peer_tq_xdp_xmit_err;
 			xdp_tx_err = stats->vs.xdp_tx_err;
 			packets = stats->vs.xdp_packets;
 			bytes = stats->vs.xdp_bytes;
 			drops = stats->vs.rx_drops;
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
 		result->peer_tq_xdp_xmit_err += peer_tq_xdp_xmit_err;
 		result->xdp_tx_err += xdp_tx_err;
 		result->xdp_packets += packets;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d934774e9733b..04ff016305218 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2066,18 +2066,18 @@ static void virtnet_stats(struct net_device *dev,
 		struct send_queue *sq = &vi->sq[i];
 
 		do {
-			start = u64_stats_fetch_begin_irq(&sq->stats.syncp);
+			start = u64_stats_fetch_begin(&sq->stats.syncp);
 			tpackets = sq->stats.packets;
 			tbytes   = sq->stats.bytes;
 			terrors  = sq->stats.tx_timeouts;
-		} while (u64_stats_fetch_retry_irq(&sq->stats.syncp, start));
+		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 
 		do {
-			start = u64_stats_fetch_begin_irq(&rq->stats.syncp);
+			start = u64_stats_fetch_begin(&rq->stats.syncp);
 			rpackets = rq->stats.packets;
 			rbytes   = rq->stats.bytes;
 			rdrops   = rq->stats.drops;
-		} while (u64_stats_fetch_retry_irq(&rq->stats.syncp, start));
+		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
 
 		tot->rx_packets += rpackets;
 		tot->tx_packets += tpackets;
@@ -2688,12 +2688,12 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 
 		stats_base = (u8 *)&rq->stats;
 		do {
-			start = u64_stats_fetch_begin_irq(&rq->stats.syncp);
+			start = u64_stats_fetch_begin(&rq->stats.syncp);
 			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++) {
 				offset = virtnet_rq_stats_desc[j].offset;
 				data[idx + j] = *(u64 *)(stats_base + offset);
 			}
-		} while (u64_stats_fetch_retry_irq(&rq->stats.syncp, start));
+		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
 		idx += VIRTNET_RQ_STATS_LEN;
 	}
 
@@ -2702,12 +2702,12 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 
 		stats_base = (u8 *)&sq->stats;
 		do {
-			start = u64_stats_fetch_begin_irq(&sq->stats.syncp);
+			start = u64_stats_fetch_begin(&sq->stats.syncp);
 			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++) {
 				offset = virtnet_sq_stats_desc[j].offset;
 				data[idx + j] = *(u64 *)(stats_base + offset);
 			}
-		} while (u64_stats_fetch_retry_irq(&sq->stats.syncp, start));
+		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 		idx += VIRTNET_SQ_STATS_LEN;
 	}
 }
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 5df7a0abc39d5..191ebc482f0c1 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -159,13 +159,13 @@ static void vrf_get_stats64(struct net_device *dev,
 
 		dstats = per_cpu_ptr(dev->dstats, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&dstats->syncp);
+			start = u64_stats_fetch_begin(&dstats->syncp);
 			tbytes = dstats->tx_bytes;
 			tpkts = dstats->tx_pkts;
 			tdrops = dstats->tx_drps;
 			rbytes = dstats->rx_bytes;
 			rpkts = dstats->rx_pkts;
-		} while (u64_stats_fetch_retry_irq(&dstats->syncp, start));
+		} while (u64_stats_fetch_retry(&dstats->syncp, start));
 		stats->tx_bytes += tbytes;
 		stats->tx_packets += tpkts;
 		stats->tx_dropped += tdrops;
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 3e04af4c5daa1..a3de081cda5ee 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -129,9 +129,9 @@ static void vxlan_vnifilter_stats_get(const struct vxlan_vni_node *vninode,
 
 		pstats = per_cpu_ptr(vninode->stats, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&pstats->syncp);
+			start = u64_stats_fetch_begin(&pstats->syncp);
 			memcpy(&temp, &pstats->stats, sizeof(temp));
-		} while (u64_stats_fetch_retry_irq(&pstats->syncp, start));
+		} while (u64_stats_fetch_retry(&pstats->syncp, start));
 
 		dest->rx_packets += temp.rx_packets;
 		dest->rx_bytes += temp.rx_bytes;
diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 6872782e8dd89..22b5939a42bb3 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -456,19 +456,19 @@ static void mhi_mbim_ndo_get_stats64(struct net_device *ndev,
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin_irq(&link->rx_syncp);
+		start = u64_stats_fetch_begin(&link->rx_syncp);
 		stats->rx_packets = u64_stats_read(&link->rx_packets);
 		stats->rx_bytes = u64_stats_read(&link->rx_bytes);
 		stats->rx_errors = u64_stats_read(&link->rx_errors);
-	} while (u64_stats_fetch_retry_irq(&link->rx_syncp, start));
+	} while (u64_stats_fetch_retry(&link->rx_syncp, start));
 
 	do {
-		start = u64_stats_fetch_begin_irq(&link->tx_syncp);
+		start = u64_stats_fetch_begin(&link->tx_syncp);
 		stats->tx_packets = u64_stats_read(&link->tx_packets);
 		stats->tx_bytes = u64_stats_read(&link->tx_bytes);
 		stats->tx_errors = u64_stats_read(&link->tx_errors);
 		stats->tx_dropped = u64_stats_read(&link->tx_dropped);
-	} while (u64_stats_fetch_retry_irq(&link->tx_syncp, start));
+	} while (u64_stats_fetch_retry(&link->tx_syncp, start));
 }
 
 static void mhi_mbim_ul_callback(struct mhi_device *mhi_dev,
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 27a11cc08c61e..df4dc02638a00 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1392,16 +1392,16 @@ static void xennet_get_stats64(struct net_device *dev,
 		unsigned int start;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&tx_stats->syncp);
+			start = u64_stats_fetch_begin(&tx_stats->syncp);
 			tx_packets = tx_stats->packets;
 			tx_bytes = tx_stats->bytes;
-		} while (u64_stats_fetch_retry_irq(&tx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
 
 		do {
-			start = u64_stats_fetch_begin_irq(&rx_stats->syncp);
+			start = u64_stats_fetch_begin(&rx_stats->syncp);
 			rx_packets = rx_stats->packets;
 			rx_bytes = rx_stats->bytes;
-		} while (u64_stats_fetch_retry_irq(&rx_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
 
 		tot->rx_packets += rx_packets;
 		tot->tx_packets += tx_packets;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8f97a3eacdeab..eb1a03a44d1bf 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -127,10 +127,10 @@ do {									\
 		unsigned int start;					\
 		pcpu_stats = per_cpu_ptr(in, i);			\
 		do {							\
-			start = u64_stats_fetch_begin_irq(		\
+			start = u64_stats_fetch_begin(		\
 					&pcpu_stats->syncp);		\
 			inc = u64_stats_read(&pcpu_stats->field);	\
-		} while (u64_stats_fetch_retry_irq(			\
+		} while (u64_stats_fetch_retry(			\
 					&pcpu_stats->syncp, start));	\
 		ret += inc;						\
 	}								\
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 4e0e50e7ac153..173e979b84a93 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -14,7 +14,6 @@
 #include <linux/iova.h>
 #include <linux/dma-mapping.h>
 #include <linux/vhost_iotlb.h>
-#include <linux/rwlock.h>
 
 #define IOVA_START_PFN 1
 
diff --git a/fs/dcache.c b/fs/dcache.c
index c5dc32a59c769..e633b20623d0f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2571,15 +2571,7 @@ EXPORT_SYMBOL(d_rehash);
 
 static inline unsigned start_dir_add(struct inode *dir)
 {
-	/*
-	 * The caller holds a spinlock (dentry::d_lock). On !PREEMPT_RT
-	 * kernels spin_lock() implicitly disables preemption, but not on
-	 * PREEMPT_RT.  So for RT it has to be done explicitly to protect
-	 * the sequence count write side critical section against a reader
-	 * or another writer preempting, which would result in a live lock.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 	for (;;) {
 		unsigned n = dir->i_dir_seq;
 		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) == n)
@@ -2592,8 +2584,7 @@ static inline void end_dir_add(struct inode *dir, unsigned int n,
 			       wait_queue_head_t *d_wait)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 	wake_up_all(d_wait);
 }
 
diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 15ae78cd28536..b8728d11c9490 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -94,6 +94,12 @@ void dump_mm(const struct mm_struct *mm);
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
 
+#ifdef CONFIG_DEBUG_VM_IRQSOFF
+#define VM_WARN_ON_IRQS_ENABLED() WARN_ON_ONCE(!irqs_disabled())
+#else
+#define VM_WARN_ON_IRQS_ENABLED() do { } while (0)
+#endif
+
 #ifdef CONFIG_DEBUG_VIRTUAL
 #define VIRTUAL_BUG_ON(cond) BUG_ON(cond)
 #else
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 873a5dac54e0e..12f59cdaaedda 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -469,4 +469,46 @@ static inline void migrate_enable(void)
 
 #endif /* CONFIG_SMP */
 
+/**
+ * preempt_disable_nested - Disable preemption inside a normally preempt disabled section
+ *
+ * Use for code which requires preemption protection inside a critical
+ * section which has preemption disabled implicitly on non-PREEMPT_RT
+ * enabled kernels, by e.g.:
+ *  - holding a spinlock/rwlock
+ *  - soft interrupt context
+ *  - regular interrupt handlers
+ *
+ * On PREEMPT_RT enabled kernels spinlock/rwlock held sections, soft
+ * interrupt context and regular interrupt handlers are preemptible and
+ * only prevent migration. preempt_disable_nested() ensures that preemption
+ * is disabled for cases which require CPU local serialization even on
+ * PREEMPT_RT. For non-PREEMPT_RT kernels this is a NOP.
+ *
+ * The use cases are code sequences which are not serialized by a
+ * particular lock instance, e.g.:
+ *  - seqcount write side critical sections where the seqcount is not
+ *    associated to a particular lock and therefore the automatic
+ *    protection mechanism does not work. This prevents a live lock
+ *    against a preempting high priority reader.
+ *  - RMW per CPU variable updates like vmstat.
+ */
+/* Macro to avoid header recursion hell vs. lockdep */
+#define preempt_disable_nested()				\
+do {								\
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		preempt_disable();				\
+	else							\
+		lockdep_assert_preemption_disabled();		\
+} while (0)
+
+/**
+ * preempt_enable_nested - Undo the effect of preempt_disable_nested()
+ */
+static __always_inline void preempt_enable_nested(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+}
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 6ad4e9032d538..ffe48e69b3f3a 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -8,7 +8,7 @@
  *
  * Key points :
  *
- * -  Use a seqcount on 32-bit SMP, only disable preemption for 32-bit UP.
+ * -  Use a seqcount on 32-bit
  * -  The whole thing is a no-op on 64-bit architectures.
  *
  * Usage constraints:
@@ -20,7 +20,8 @@
  *    writer and also spin forever.
  *
  * 3) Write side must use the _irqsave() variant if other writers, or a reader,
- *    can be invoked from an IRQ context.
+ *    can be invoked from an IRQ context. On 64bit systems this variant does not
+ *    disable interrupts.
  *
  * 4) If reader fetches several counters, there is no guarantee the whole values
  *    are consistent w.r.t. each other (remember point #2: seqcounts are not
@@ -29,11 +30,6 @@
  * 5) Readers are allowed to sleep or be preempted/interrupted: they perform
  *    pure reads.
  *
- * 6) Readers must use both u64_stats_fetch_{begin,retry}_irq() if the stats
- *    might be updated from a hardirq or softirq context (remember point #1:
- *    seqcounts are not used for UP kernels). 32-bit UP stat readers could read
- *    corrupted 64-bit values otherwise.
- *
  * Usage :
  *
  * Stats producer (writer) should use following template granted it already got
@@ -66,7 +62,7 @@
 #include <linux/seqlock.h>
 
 struct u64_stats_sync {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
+#if BITS_PER_LONG == 32
 	seqcount_t	seq;
 #endif
 };
@@ -98,7 +94,22 @@ static inline void u64_stats_inc(u64_stats_t *p)
 	local64_inc(&p->v);
 }
 
-#else
+static inline void u64_stats_init(struct u64_stats_sync *syncp) { }
+static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp) { }
+static inline void __u64_stats_update_end(struct u64_stats_sync *syncp) { }
+static inline unsigned long __u64_stats_irqsave(void) { return 0; }
+static inline void __u64_stats_irqrestore(unsigned long flags) { }
+static inline unsigned int __u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
+{
+	return 0;
+}
+static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
+					   unsigned int start)
+{
+	return false;
+}
+
+#else /* 64 bit */
 
 typedef struct {
 	u64		v;
@@ -123,122 +134,82 @@ static inline void u64_stats_inc(u64_stats_t *p)
 {
 	p->v++;
 }
-#endif
 
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
-#define u64_stats_init(syncp)	seqcount_init(&(syncp)->seq)
-#else
 static inline void u64_stats_init(struct u64_stats_sync *syncp)
 {
+	seqcount_init(&syncp->seq);
 }
-#endif
 
-static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
+static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 	write_seqcount_begin(&syncp->seq);
-#endif
 }
 
-static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
+static inline void __u64_stats_update_end(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 	write_seqcount_end(&syncp->seq);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
-#endif
+	preempt_enable_nested();
 }
 
-static inline unsigned long
-u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
+static inline unsigned long __u64_stats_irqsave(void)
 {
-	unsigned long flags = 0;
+	unsigned long flags;
 
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
-	else
-		local_irq_save(flags);
-	write_seqcount_begin(&syncp->seq);
-#endif
+	local_irq_save(flags);
 	return flags;
 }
 
-static inline void
-u64_stats_update_end_irqrestore(struct u64_stats_sync *syncp,
-				unsigned long flags)
+static inline void __u64_stats_irqrestore(unsigned long flags)
 {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
-	write_seqcount_end(&syncp->seq);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
-	else
-		local_irq_restore(flags);
-#endif
+	local_irq_restore(flags);
 }
 
 static inline unsigned int __u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 	return read_seqcount_begin(&syncp->seq);
-#else
-	return 0;
-#endif
+}
+
+static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
+					   unsigned int start)
+{
+	return read_seqcount_retry(&syncp->seq, start);
+}
+#endif /* !64 bit */
+
+static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
+{
+	__u64_stats_update_begin(syncp);
+}
+
+static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
+{
+	__u64_stats_update_end(syncp);
+}
+
+static inline unsigned long u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
+{
+	unsigned long flags = __u64_stats_irqsave();
+
+	__u64_stats_update_begin(syncp);
+	return flags;
+}
+
+static inline void u64_stats_update_end_irqrestore(struct u64_stats_sync *syncp,
+						   unsigned long flags)
+{
+	__u64_stats_update_end(syncp);
+	__u64_stats_irqrestore(flags);
 }
 
 static inline unsigned int u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && (!defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT))
-	preempt_disable();
-#endif
 	return __u64_stats_fetch_begin(syncp);
 }
 
-static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
-					 unsigned int start)
-{
-#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
-	return read_seqcount_retry(&syncp->seq, start);
-#else
-	return false;
-#endif
-}
-
 static inline bool u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 					 unsigned int start)
 {
-#if BITS_PER_LONG == 32 && (!defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT))
-	preempt_enable();
-#endif
-	return __u64_stats_fetch_retry(syncp, start);
-}
-
-/*
- * In case irq handlers can update u64 counters, readers can use following helpers
- * - SMP 32bit arches use seqcount protection, irq safe.
- * - UP 32bit must disable irqs.
- * - 64bit have no problem atomically reading u64 values, irq safe.
- */
-static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_stats_sync *syncp)
-{
-#if BITS_PER_LONG == 32 && defined(CONFIG_PREEMPT_RT)
-	preempt_disable();
-#elif BITS_PER_LONG == 32 && !defined(CONFIG_SMP)
-	local_irq_disable();
-#endif
-	return __u64_stats_fetch_begin(syncp);
-}
-
-static inline bool u64_stats_fetch_retry_irq(const struct u64_stats_sync *syncp,
-					     unsigned int start)
-{
-#if BITS_PER_LONG == 32 && defined(CONFIG_PREEMPT_RT)
-	preempt_enable();
-#elif BITS_PER_LONG == 32 && !defined(CONFIG_SMP)
-	local_irq_enable();
-#endif
 	return __u64_stats_fetch_retry(syncp, start);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a4d40d98428a3..b24612d94a124 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2107,11 +2107,11 @@ static void bpf_prog_get_stats(const struct bpf_prog *prog,
 
 		st = per_cpu_ptr(prog->stats, cpu);
 		do {
-			start = u64_stats_fetch_begin_irq(&st->syncp);
+			start = u64_stats_fetch_begin(&st->syncp);
 			tnsecs = u64_stats_read(&st->nsecs);
 			tcnt = u64_stats_read(&st->cnt);
 			tmisses = u64_stats_read(&st->misses);
-		} while (u64_stats_fetch_retry_irq(&st->syncp, start));
+		} while (u64_stats_fetch_retry(&st->syncp, start));
 		nsecs += tnsecs;
 		cnt += tcnt;
 		misses += tmisses;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 072e4b289c13e..c96fc6820544c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -803,6 +803,9 @@ config ARCH_HAS_DEBUG_VM_PGTABLE
 	  An architecture should select this when it can successfully
 	  build and run DEBUG_VM_PGTABLE.
 
+config DEBUG_VM_IRQSOFF
+	def_bool DEBUG_VM && !PREEMPT_RT
+
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
diff --git a/localversion-rt b/localversion-rt
index 6f206be67cd28..c3054d08a1129 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt1
+-rt2
diff --git a/mm/Kconfig b/mm/Kconfig
index 0331f1461f81c..a0506a54a4f3f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -579,6 +579,11 @@ config COMPACTION
 	  it and then we would be really interested to hear about that at
 	  linux-mm@kvack.org.
 
+config COMPACT_UNEVICTABLE_DEFAULT
+	int
+	default 0 if PREEMPT_RT
+	default 1
+
 #
 # support for free page reporting
 config PAGE_REPORTING
diff --git a/mm/compaction.c b/mm/compaction.c
index 640fa76228dd9..10561cb1aaad9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1727,11 +1727,7 @@ typedef enum {
  * Allow userspace to control policy on scanning the unevictable LRU for
  * compactable pages.
  */
-#ifdef CONFIG_PREEMPT_RT
-int sysctl_compact_unevictable_allowed __read_mostly = 0;
-#else
-int sysctl_compact_unevictable_allowed __read_mostly = 1;
-#endif
+int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
 
 static inline void
 update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5c..d35b6fa560f0a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -597,25 +597,18 @@ static u64 flush_next_time;
  */
 static void memcg_stats_lock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_disable();
-#else
-      VM_BUG_ON(!irqs_disabled());
-#endif
+	preempt_disable_nested();
+	VM_WARN_ON_IRQS_ENABLED();
 }
 
 static void __memcg_stats_lock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_disable();
-#endif
+	preempt_disable_nested();
 }
 
 static void memcg_stats_unlock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_enable();
-#endif
+	preempt_enable_nested();
 }
 
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
@@ -715,7 +708,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	 * interrupt context while other caller need to have disabled interrupt.
 	 */
 	__memcg_stats_lock();
-	if (IS_ENABLED(CONFIG_DEBUG_VM) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
 		switch (idx) {
 		case NR_ANON_MAPPED:
 		case NR_FILE_MAPPED:
@@ -725,7 +718,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			WARN_ON_ONCE(!in_task());
 			break;
 		default:
-			WARN_ON_ONCE(!irqs_disabled());
+			VM_WARN_ON_IRQS_ENABLED();
 		}
 	}
 
diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f52..5f7c5b5bd49f9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -100,9 +100,11 @@
  *   except the stat counters. This is a percpu structure manipulated only by
  *   the local cpu, so the lock protects against being preempted or interrupted
  *   by an irq. Fast path operations rely on lockless operations instead.
- *   On PREEMPT_RT, the local lock does not actually disable irqs (and thus
- *   prevent the lockless operations), so fastpath operations also need to take
- *   the lock and are no longer lockless.
+ *
+ *   On PREEMPT_RT, the local lock neither disables interrupts nor preemption
+ *   which means the lockless fastpath cannot be used as it might interfere with
+ *   an in-progress slow path operations. In this case the local lock is always
+ *   taken but it still utilizes the freelist for the common operations.
  *
  *   lockless fastpaths
  *
@@ -163,8 +165,11 @@
  * function call even on !PREEMPT_RT, use inline preempt_disable() there.
  */
 #ifndef CONFIG_PREEMPT_RT
-#define slub_get_cpu_ptr(var)	get_cpu_ptr(var)
-#define slub_put_cpu_ptr(var)	put_cpu_ptr(var)
+#define slub_get_cpu_ptr(var)		get_cpu_ptr(var)
+#define slub_put_cpu_ptr(var)		put_cpu_ptr(var)
+#define use_lockless_fast_path()	(true)
+#define slub_local_irq_save(flags)	local_irq_save(flags)
+#define slub_local_irq_restore(flags)	local_irq_restore(flags)
 #else
 #define slub_get_cpu_ptr(var)		\
 ({					\
@@ -176,6 +181,9 @@ do {					\
 	(void)(var);			\
 	migrate_enable();		\
 } while (0)
+#define use_lockless_fast_path()	(false)
+#define slub_local_irq_save(flags)	do { } while (0)
+#define slub_local_irq_restore(flags)	do { } while (0)
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -460,16 +468,14 @@ static __always_inline void __slab_unlock(struct slab *slab)
 
 static __always_inline void slab_lock(struct slab *slab, unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_save(*flags);
+	slub_local_irq_save(*flags);
 	__slab_lock(slab);
 }
 
 static __always_inline void slab_unlock(struct slab *slab, unsigned long *flags)
 {
 	__slab_unlock(slab);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_restore(*flags);
+	slub_local_irq_restore(*flags);
 }
 
 /*
@@ -482,7 +488,7 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	if (use_lockless_fast_path())
 		lockdep_assert_irqs_disabled();
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
@@ -3197,14 +3203,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 
 	object = c->freelist;
 	slab = c->slab;
-	/*
-	 * We cannot use the lockless fastpath on PREEMPT_RT because if a
-	 * slowpath has taken the local_lock_irqsave(), it is not protected
-	 * against a fast path operation in an irq handler. So we need to take
-	 * the slow path which uses local_lock. It is still relatively fast if
-	 * there is a suitable cpu freelist.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
+
+	if (!use_lockless_fast_path() ||
 	    unlikely(!object || !slab || !node_match(slab, node))) {
 		object = __slab_alloc(s, gfpflags, node, addr, c);
 	} else {
@@ -3463,6 +3463,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	void *tail_obj = tail ? : head;
 	struct kmem_cache_cpu *c;
 	unsigned long tid;
+	void **freelist;
 
 redo:
 	/*
@@ -3477,9 +3478,13 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	/* Same with comment on barrier() in slab_alloc_node() */
 	barrier();
 
-	if (likely(slab == c->slab)) {
-#ifndef CONFIG_PREEMPT_RT
-		void **freelist = READ_ONCE(c->freelist);
+	if (unlikely(slab != c->slab)) {
+		__slab_free(s, slab, head, tail_obj, cnt, addr);
+		return;
+	}
+
+	if (use_lockless_fast_path()) {
+		freelist = READ_ONCE(c->freelist);
 
 		set_freepointer(s, tail_obj, freelist);
 
@@ -3491,16 +3496,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 			note_cmpxchg_failure("slab_free", s, tid);
 			goto redo;
 		}
-#else /* CONFIG_PREEMPT_RT */
-		/*
-		 * We cannot use the lockless fastpath on PREEMPT_RT because if
-		 * a slowpath has taken the local_lock_irqsave(), it is not
-		 * protected against a fast path operation in an irq handler. So
-		 * we need to take the local_lock. We shouldn't simply defer to
-		 * __slab_free() as that wouldn't use the cpu freelist at all.
-		 */
-		void **freelist;
-
+	} else {
+		/* Update the free list under the local lock */
 		local_lock(&s->cpu_slab->lock);
 		c = this_cpu_ptr(s->cpu_slab);
 		if (unlikely(slab != c->slab)) {
@@ -3515,11 +3512,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 		c->tid = next_tid(tid);
 
 		local_unlock(&s->cpu_slab->lock);
-#endif
-		stat(s, FREE_FASTPATH);
-	} else
-		__slab_free(s, slab, head, tail_obj, cnt, addr);
-
+	}
+	stat(s, FREE_FASTPATH);
 }
 
 static __always_inline void slab_free(struct kmem_cache *s, struct slab *slab,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 373d2730fcf21..d514fe7f90af0 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -355,8 +355,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 	 * CPU migrations and preemption potentially corrupts a counter so
 	 * disable preemption.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	x = delta + __this_cpu_read(*p);
 
@@ -368,8 +367,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 	}
 	__this_cpu_write(*p, x);
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
 
@@ -393,8 +391,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	}
 
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	x = delta + __this_cpu_read(*p);
 
@@ -406,8 +403,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	}
 	__this_cpu_write(*p, x);
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 EXPORT_SYMBOL(__mod_node_page_state);
 
@@ -441,8 +437,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 v, t;
 
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -453,8 +448,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 		__this_cpu_write(*p, -overstep);
 	}
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -466,8 +460,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -478,8 +471,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		__this_cpu_write(*p, -overstep);
 	}
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 
 void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -501,8 +493,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 v, t;
 
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -513,8 +504,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 		__this_cpu_write(*p, overstep);
 	}
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -526,8 +516,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -538,8 +527,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		__this_cpu_write(*p, overstep);
 	}
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 035812b0461cc..ecdb47712d956 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -712,13 +712,13 @@ static void vlan_dev_get_stats64(struct net_device *dev,
 
 		p = per_cpu_ptr(vlan_dev_priv(dev)->vlan_pcpu_stats, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&p->syncp);
+			start = u64_stats_fetch_begin(&p->syncp);
 			rxpackets	= u64_stats_read(&p->rx_packets);
 			rxbytes		= u64_stats_read(&p->rx_bytes);
 			rxmulticast	= u64_stats_read(&p->rx_multicast);
 			txpackets	= u64_stats_read(&p->tx_packets);
 			txbytes		= u64_stats_read(&p->tx_bytes);
-		} while (u64_stats_fetch_retry_irq(&p->syncp, start));
+		} while (u64_stats_fetch_retry(&p->syncp, start));
 
 		stats->rx_packets	+= rxpackets;
 		stats->rx_bytes		+= rxbytes;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index db4f2641d1cd1..7e2a9fb5786c9 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4899,9 +4899,9 @@ void br_multicast_get_stats(const struct net_bridge *br,
 		unsigned int start;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
 			memcpy(&temp, &cpu_stats->mstats, sizeof(temp));
-		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		mcast_stats_add_dir(tdst.igmp_v1queries, temp.igmp_v1queries);
 		mcast_stats_add_dir(tdst.igmp_v2queries, temp.igmp_v2queries);
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 6e53dc9914094..f2fc284abab38 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1378,12 +1378,12 @@ void br_vlan_get_stats(const struct net_bridge_vlan *v,
 
 		cpu_stats = per_cpu_ptr(v->stats, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
 			rxpackets = u64_stats_read(&cpu_stats->rx_packets);
 			rxbytes = u64_stats_read(&cpu_stats->rx_bytes);
 			txbytes = u64_stats_read(&cpu_stats->tx_bytes);
 			txpackets = u64_stats_read(&cpu_stats->tx_packets);
-		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		u64_stats_add(&stats->rx_packets, rxpackets);
 		u64_stats_add(&stats->rx_bytes, rxbytes);
diff --git a/net/core/dev.c b/net/core/dev.c
index 9223251491c59..071ee39d95f6a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10507,12 +10507,12 @@ void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
 
 		stats = per_cpu_ptr(netstats, cpu);
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			start = u64_stats_fetch_begin(&stats->syncp);
 			rx_packets = u64_stats_read(&stats->rx_packets);
 			rx_bytes   = u64_stats_read(&stats->rx_bytes);
 			tx_packets = u64_stats_read(&stats->tx_packets);
 			tx_bytes   = u64_stats_read(&stats->tx_bytes);
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		s->rx_packets += rx_packets;
 		s->rx_bytes   += rx_bytes;
diff --git a/net/core/devlink.c b/net/core/devlink.c
index b50bcc18b8d9e..cfa6a099457ae 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -8268,10 +8268,10 @@ static void devlink_trap_stats_read(struct devlink_stats __percpu *trap_stats,
 
 		cpu_stats = per_cpu_ptr(trap_stats, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
 			rx_packets = u64_stats_read(&cpu_stats->rx_packets);
 			rx_bytes = u64_stats_read(&cpu_stats->rx_bytes);
-		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		u64_stats_add(&stats->rx_packets, rx_packets);
 		u64_stats_add(&stats->rx_bytes, rx_bytes);
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 75501e1bdd25b..dfcaf61d972c7 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -1432,9 +1432,9 @@ static void net_dm_stats_read(struct net_dm_stats *stats)
 		u64 dropped;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
 			dropped = u64_stats_read(&cpu_stats->dropped);
-		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		u64_stats_add(&stats->dropped, dropped);
 	}
@@ -1476,9 +1476,9 @@ static void net_dm_hw_stats_read(struct net_dm_stats *stats)
 		u64 dropped;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
 			dropped = u64_stats_read(&cpu_stats->dropped);
-		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		u64_stats_add(&stats->dropped, dropped);
 	}
diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index a10335b4ba2d0..330db87ee6676 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -135,10 +135,10 @@ static void gnet_stats_add_basic_cpu(struct gnet_stats_basic_sync *bstats,
 		u64 bytes, packets;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&bcpu->syncp);
+			start = u64_stats_fetch_begin(&bcpu->syncp);
 			bytes = u64_stats_read(&bcpu->bytes);
 			packets = u64_stats_read(&bcpu->packets);
-		} while (u64_stats_fetch_retry_irq(&bcpu->syncp, start));
+		} while (u64_stats_fetch_retry(&bcpu->syncp, start));
 
 		t_bytes += bytes;
 		t_packets += packets;
@@ -162,10 +162,10 @@ void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
 	}
 	do {
 		if (running)
-			start = u64_stats_fetch_begin_irq(&b->syncp);
+			start = u64_stats_fetch_begin(&b->syncp);
 		bytes = u64_stats_read(&b->bytes);
 		packets = u64_stats_read(&b->packets);
-	} while (running && u64_stats_fetch_retry_irq(&b->syncp, start));
+	} while (running && u64_stats_fetch_retry(&b->syncp, start));
 
 	_bstats_update(bstats, bytes, packets);
 }
@@ -187,10 +187,10 @@ static void gnet_stats_read_basic(u64 *ret_bytes, u64 *ret_packets,
 			u64 bytes, packets;
 
 			do {
-				start = u64_stats_fetch_begin_irq(&bcpu->syncp);
+				start = u64_stats_fetch_begin(&bcpu->syncp);
 				bytes = u64_stats_read(&bcpu->bytes);
 				packets = u64_stats_read(&bcpu->packets);
-			} while (u64_stats_fetch_retry_irq(&bcpu->syncp, start));
+			} while (u64_stats_fetch_retry(&bcpu->syncp, start));
 
 			t_bytes += bytes;
 			t_packets += packets;
@@ -201,10 +201,10 @@ static void gnet_stats_read_basic(u64 *ret_bytes, u64 *ret_packets,
 	}
 	do {
 		if (running)
-			start = u64_stats_fetch_begin_irq(&b->syncp);
+			start = u64_stats_fetch_begin(&b->syncp);
 		*ret_bytes = u64_stats_read(&b->bytes);
 		*ret_packets = u64_stats_read(&b->packets);
-	} while (running && u64_stats_fetch_retry_irq(&b->syncp, start));
+	} while (running && u64_stats_fetch_retry(&b->syncp, start));
 }
 
 static int
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index ad6a6663feeb5..30333a211ccfa 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -934,12 +934,12 @@ static void dsa_slave_get_ethtool_stats(struct net_device *dev,
 
 		s = per_cpu_ptr(dev->tstats, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&s->syncp);
+			start = u64_stats_fetch_begin(&s->syncp);
 			tx_packets = u64_stats_read(&s->tx_packets);
 			tx_bytes = u64_stats_read(&s->tx_bytes);
 			rx_packets = u64_stats_read(&s->rx_packets);
 			rx_bytes = u64_stats_read(&s->rx_bytes);
-		} while (u64_stats_fetch_retry_irq(&s->syncp, start));
+		} while (u64_stats_fetch_retry(&s->syncp, start));
 		data[0] += tx_packets;
 		data[1] += tx_bytes;
 		data[2] += rx_packets;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3ca0cc4678862..dbae0c79d5cfb 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1684,9 +1684,9 @@ u64 snmp_get_cpu_field64(void __percpu *mib, int cpu, int offt,
 	bhptr = per_cpu_ptr(mib, cpu);
 	syncp = (struct u64_stats_sync *)(bhptr + syncp_offset);
 	do {
-		start = u64_stats_fetch_begin_irq(syncp);
+		start = u64_stats_fetch_begin(syncp);
 		v = *(((u64 *)bhptr) + offt);
-	} while (u64_stats_fetch_retry_irq(syncp, start));
+	} while (u64_stats_fetch_retry(syncp, start));
 
 	return v;
 }
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index b7de5e46fdd8f..f84da849819cc 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1508,13 +1508,13 @@ static int put_nla_counters(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 
 		pcounters = per_cpu_ptr(slwt->pcpu_counters, i);
 		do {
-			start = u64_stats_fetch_begin_irq(&pcounters->syncp);
+			start = u64_stats_fetch_begin(&pcounters->syncp);
 
 			packets = u64_stats_read(&pcounters->packets);
 			bytes = u64_stats_read(&pcounters->bytes);
 			errors = u64_stats_read(&pcounters->errors);
 
-		} while (u64_stats_fetch_retry_irq(&pcounters->syncp, start));
+		} while (u64_stats_fetch_retry(&pcounters->syncp, start));
 
 		counters.packets += packets;
 		counters.bytes += bytes;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index efab2b06d3732..5a7349002508e 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2296,13 +2296,13 @@ static int ip_vs_stats_percpu_show(struct seq_file *seq, void *v)
 		u64 conns, inpkts, outpkts, inbytes, outbytes;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&u->syncp);
+			start = u64_stats_fetch_begin(&u->syncp);
 			conns = u->cnt.conns;
 			inpkts = u->cnt.inpkts;
 			outpkts = u->cnt.outpkts;
 			inbytes = u->cnt.inbytes;
 			outbytes = u->cnt.outbytes;
-		} while (u64_stats_fetch_retry_irq(&u->syncp, start));
+		} while (u64_stats_fetch_retry(&u->syncp, start));
 
 		seq_printf(seq, "%3X %8LX %8LX %8LX %16LX %16LX\n",
 			   i, (u64)conns, (u64)inpkts,
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3cc88998b8795..9366556e73932 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1535,10 +1535,10 @@ static int nft_dump_stats(struct sk_buff *skb, struct nft_stats __percpu *stats)
 	for_each_possible_cpu(cpu) {
 		cpu_stats = per_cpu_ptr(stats, cpu);
 		do {
-			seq = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
+			seq = u64_stats_fetch_begin(&cpu_stats->syncp);
 			pkts = cpu_stats->pkts;
 			bytes = cpu_stats->bytes;
-		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, seq));
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, seq));
 		total.pkts += pkts;
 		total.bytes += bytes;
 	}
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 7e8a39a356271..40c4218db429f 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -707,9 +707,9 @@ static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
 		percpu_stats = per_cpu_ptr(dp->stats_percpu, i);
 
 		do {
-			start = u64_stats_fetch_begin_irq(&percpu_stats->syncp);
+			start = u64_stats_fetch_begin(&percpu_stats->syncp);
 			local_stats = *percpu_stats;
-		} while (u64_stats_fetch_retry_irq(&percpu_stats->syncp, start));
+		} while (u64_stats_fetch_retry(&percpu_stats->syncp, start));
 
 		stats->n_hit += local_stats.n_hit;
 		stats->n_missed += local_stats.n_missed;
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index d4a2db0b22998..0a0e4c283f02e 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -205,9 +205,9 @@ static void tbl_mask_array_reset_counters(struct mask_array *ma)
 
 			stats = per_cpu_ptr(ma->masks_usage_stats, cpu);
 			do {
-				start = u64_stats_fetch_begin_irq(&stats->syncp);
+				start = u64_stats_fetch_begin(&stats->syncp);
 				counter = stats->usage_cntrs[i];
-			} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+			} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 			ma->masks_usage_zero_cntr[i] += counter;
 		}
@@ -1136,10 +1136,9 @@ void ovs_flow_masks_rebalance(struct flow_table *table)
 
 			stats = per_cpu_ptr(ma->masks_usage_stats, cpu);
 			do {
-				start = u64_stats_fetch_begin_irq(&stats->syncp);
+				start = u64_stats_fetch_begin(&stats->syncp);
 				counter = stats->usage_cntrs[i];
-			} while (u64_stats_fetch_retry_irq(&stats->syncp,
-							   start));
+			} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 			masks_and_count[i].counter += counter;
 		}
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543b..d130db6726414 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5749,6 +5749,12 @@ sub process {
 			}
 		}
 
+# rwlock.h must not be included directly. It will be included via spinlock.h if needed.
+		if ($rawline =~ /\#\s*include.*\<linux\/rwlock\.h/) {
+			ERROR("INCLUDES_BAD_HEADER",
+				"Please don't include rwlock.h directly, use spinlock.h if needed.\n" . $herecurr);
+		}
+
 # warn if <asm/foo.h> is #included and <linux/foo.h> is available and includes
 # itself <asm/foo.h> (uses RAW line)
 		if ($tree && $rawline =~ m{^.\s*\#\s*include\s*\<asm\/(.*)\.h\>}) {
