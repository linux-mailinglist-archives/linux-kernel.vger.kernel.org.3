Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9924C5891
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiBZWoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 17:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBZWoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:44:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD91326D3;
        Sat, 26 Feb 2022 14:43:33 -0800 (PST)
Date:   Sat, 26 Feb 2022 23:43:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645915411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=62mXuDyPZvTaWtzRBtgpNyg93bsy32xCgDN4TB3A2Lc=;
        b=XMDXJFLnLmJEF3Puy193Tk1wR4GZbyBOer/UXt26woOgQmtdgxkFmIdiGGnFb3anlgf5hW
        GJ+1linsd7kqnxDx/mzUtnsQ2K+/OJ1+KN/rcjdjougWIdddEVitoARJtYdeyvEVYpy7BI
        g5WZVSwyjh8+TN75mi26MyX7sMsdqz3VMrsGQcOlSGJSAUwSFBEThk96F6ysguhKXI07r5
        T9JqitMTWN63TLMcuJn/mv88KUtHOVL8ZATvZ/JcPhJCKzb+dVUbYYkN/1OIZKS2JAsVsJ
        gqBXvrvtS3C5YBgqQThT7kEKp8Z96HKKkY1AM74arB7iQw/ziE5C06vTnVbtIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645915411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=62mXuDyPZvTaWtzRBtgpNyg93bsy32xCgDN4TB3A2Lc=;
        b=49wA0DaxlCu1sICkbnRG9sGL24YRAdIFUH1XnzZ00uh4M/cyp0EBXupiMUPieQAaOEGRdt
        jFsBEFd3PUMhXPAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.17-rc5-rt9
Message-ID: <YhqtEWToJVZV2npr@linutronix.de>
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

I'm pleased to announce the v5.17-rc5-rt9 patch set. 

Changes since v5.17-rc5-rt8:

  - Update the memcg patches to v5.

  - Update the networking patches to v3 and include the follow-up
    patches.

  - Update the patches for the random subsystem to the latest version as
    committed to the the subsystem's git tree.

  - Update the delayed task-struct free patches to v2.

  - Update the generic_handle_irq_safe() patches to v4.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.17-rc5-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/incr/patch-5.17-rc5-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.17-rc5-rt9

The RT patch against v5.17-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patch-5.17-rc5-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patches-5.17-rc5-rt9.tar.xz

Sebastian

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e4bde9c917654..82ee3ed8099dd 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -401,13 +401,12 @@ static void mix_pool_bytes(const void *in, int nbytes)
 }
 
 struct fast_pool {
+	u32 pool[4];
 	struct work_struct mix;
 	unsigned long last;
-	u32 pool[4];
 	unsigned int count;
 	u16 reg_idx;
 };
-#define FAST_POOL_MIX_INFLIGHT (1U << 31)
 
 /*
  * This is a fast mixing routine used by the interrupt randomness
@@ -719,12 +718,13 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
 		p[crng_init_cnt % CHACHA_KEY_SIZE] ^= *cp;
 		cp++; crng_init_cnt++; len--; ret++;
 	}
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 		invalidate_batched_entropy();
 		crng_init = 1;
-		pr_notice("fast init done\n");
 	}
+	spin_unlock_irqrestore(&primary_crng.lock, flags);
+	if (crng_init == 1)
+		pr_notice("fast init done\n");
 	return ret;
 }
 
@@ -1006,6 +1006,29 @@ EXPORT_SYMBOL_GPL(add_input_randomness);
 
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
 
+#ifdef CONFIG_SMP
+/*
+ * This function is called when the CPU has just come online, with
+ * entry CPUHP_AP_RANDOM_ONLINE, just after CPUHP_AP_WORKQUEUE_ONLINE.
+ */
+int random_online_cpu(unsigned int cpu)
+{
+	/*
+	 * During CPU shutdown and before CPU onlining, add_interrupt_
+	 * randomness() may schedule mix_interrupt_randomness(), and
+	 * set the MIX_INFLIGHT flag. However, because the worker can
+	 * be scheduled on a different CPU during this period, that
+	 * flag will never be cleared. For that reason, we zero out
+	 * the flag here, which runs just after workqueues are onlined
+	 * for the CPU again. This also has the effect of setting the
+	 * irq randomness count to zero so that new accumulated irqs
+	 * are fresh.
+	 */
+	per_cpu_ptr(&irq_randomness, cpu)->count = 0;
+	return 0;
+}
+#endif
+
 #ifdef ADD_INTERRUPT_BENCH
 static unsigned long avg_cycles, avg_deviation;
 
@@ -1045,29 +1068,23 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 static void mix_interrupt_randomness(struct work_struct *work)
 {
 	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
-	u8 pool[sizeof(fast_pool->pool)];
+	u32 pool[4];
 
-	if (unlikely(crng_init == 0)) {
-		size_t ret;
-
-		ret = crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool));
-		if (ret) {
-			WRITE_ONCE(fast_pool->count, 0);
-			fast_pool->last = jiffies;
-			return;
-		}
+	/* Check to see if we're running on the wrong CPU due to hotplug. */
+	local_irq_disable();
+	if (fast_pool != this_cpu_ptr(&irq_randomness)) {
+		local_irq_enable();
+		return;
 	}
 
 	/*
-	 * Since this is the result of a trip through the scheduler, xor in
-	 * a cycle counter. It can't hurt, and might help.
+	 * Copy the pool to the stack so that the mixer always has a
+	 * consistent view, before we reenable irqs again.
 	 */
-	fast_pool->pool[3] ^= random_get_entropy();
-	/* Copy the pool to the stack so that the mixer always has a consistent view. */
 	memcpy(pool, fast_pool->pool, sizeof(pool));
-	/* We take care to zero out the count only after we're done reading the pool. */
-	WRITE_ONCE(fast_pool->count, 0);
+	fast_pool->count = 0;
 	fast_pool->last = jiffies;
+	local_irq_enable();
 
 	mix_pool_bytes(pool, sizeof(pool));
 	credit_entropy_bits(1);
@@ -1076,13 +1093,14 @@ static void mix_interrupt_randomness(struct work_struct *work)
 
 void add_interrupt_randomness(int irq)
 {
+	enum { MIX_INFLIGHT = 1U << 31 };
 	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
 	struct pt_regs *regs = get_irq_regs();
 	unsigned long now = jiffies;
 	cycles_t cycles = random_get_entropy();
-	unsigned int new_count;
 	u32 c_high, j_high;
 	u64 ip;
+	unsigned int new_count;
 
 	if (cycles == 0)
 		cycles = get_reg(fast_pool, regs);
@@ -1096,33 +1114,28 @@ void add_interrupt_randomness(int irq)
 		(sizeof(ip) > 4) ? ip >> 32 : get_reg(fast_pool, regs);
 
 	fast_mix(fast_pool);
-	add_interrupt_bench(cycles);
 	new_count = ++fast_pool->count;
 
+	add_interrupt_bench(cycles);
+
 	if (unlikely(crng_init == 0)) {
-		if (new_count & FAST_POOL_MIX_INFLIGHT)
-			return;
-
-		if (new_count < 64)
-			return;
-
-		fast_pool->count |= FAST_POOL_MIX_INFLIGHT;
-		if (unlikely(!fast_pool->mix.func))
-			INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
-		queue_work_on(raw_smp_processor_id(), system_highpri_wq,
-			      &fast_pool->mix);
+		if ((new_count >= 64) &&
+		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
+			fast_pool->count = 0;
+			fast_pool->last = now;
+		}
 		return;
 	}
 
-	if (new_count & FAST_POOL_MIX_INFLIGHT)
+	if (new_count & MIX_INFLIGHT)
 		return;
 
-	if (new_count < 64 && !time_after(now, fast_pool->last + HZ))
+	if ((new_count < 64) && !time_after(now, fast_pool->last + HZ))
 		return;
 
 	if (unlikely(!fast_pool->mix.func))
 		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
-	fast_pool->count |= FAST_POOL_MIX_INFLIGHT;
+	fast_pool->count |= MIX_INFLIGHT;
 	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
@@ -1945,7 +1958,7 @@ u64 get_random_u64(void)
 	batch = raw_cpu_ptr(&batched_entropy_u64);
 
 	next_gen = atomic_read(&batch_generation);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0 ||
+	if (batch->position >= ARRAY_SIZE(batch->entropy_u64) ||
 	    next_gen != batch->generation) {
 		extract_crng((u8 *)batch->entropy_u64);
 		batch->position = 0;
@@ -1976,7 +1989,7 @@ u32 get_random_u32(void)
 	batch = raw_cpu_ptr(&batched_entropy_u32);
 
 	next_gen = atomic_read(&batch_generation);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0 ||
+	if (batch->position >= ARRAY_SIZE(batch->entropy_u32) ||
 	    next_gen != batch->generation) {
 		extract_crng((u8 *)batch->entropy_u32);
 		batch->position = 0;
@@ -1989,6 +2002,24 @@ u32 get_random_u32(void)
 }
 EXPORT_SYMBOL(get_random_u32);
 
+#ifdef CONFIG_SMP
+/*
+ * This function is called when the CPU is coming up, with entry
+ * CPUHP_RANDOM_PREPARE, which comes before CPUHP_WORKQUEUE_PREP.
+ */
+int random_prepare_cpu(unsigned int cpu)
+{
+	/*
+	 * When the cpu comes back online, immediately invalidate both
+	 * the per-cpu crng and all batches, so that we serve fresh
+	 * randomness.
+	 */
+	per_cpu_ptr(&batched_entropy_u32, cpu)->position = UINT_MAX;
+	per_cpu_ptr(&batched_entropy_u64, cpu)->position = UINT_MAX;
+	return 0;
+}
+#endif
+
 /* It's important to invalidate all potential batched entropy that might
  * be stored before the crng is initialized, which we can do lazily by
  * bumping the generation counter.
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index f1a36d7e2151c..10455c9b9da0e 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2373,7 +2373,7 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	skb->pkt_type = PACKET_MULTICAST;
 	skb->ip_summed = CHECKSUM_NONE;
 	len = skb->len;
-	if (netif_rx(skb) == NET_RX_SUCCESS) {
+	if (__netif_rx(skb) == NET_RX_SUCCESS) {
 		amt_update_gw_status(amt, AMT_STATUS_RECEIVED_QUERY, true);
 		dev_sw_netstats_rx_add(amt->dev, len);
 	} else {
@@ -2470,7 +2470,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb->pkt_type = PACKET_MULTICAST;
 	skb->ip_summed = CHECKSUM_NONE;
 	len = skb->len;
-	if (netif_rx(skb) == NET_RX_SUCCESS) {
+	if (__netif_rx(skb) == NET_RX_SUCCESS) {
 		amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_UPDATE,
 					true);
 		dev_sw_netstats_rx_add(amt->dev, len);
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c1fdd721a730d..a895ff756093a 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -925,7 +925,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		skb->protocol = eth_type_trans(skb, geneve->dev);
-		netif_rx(skb);
+		__netif_rx(skb);
 		dst_release(&rt->dst);
 		return -EMSGSIZE;
 	}
@@ -1021,7 +1021,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		skb->protocol = eth_type_trans(skb, geneve->dev);
-		netif_rx(skb);
+		__netif_rx(skb);
 		dst_release(dst);
 		return -EMSGSIZE;
 	}
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 24e5c54d06c15..bf087171bcf04 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -207,7 +207,7 @@ static int gtp_rx(struct pdp_ctx *pctx, struct sk_buff *skb,
 
 	dev_sw_netstats_rx_add(pctx->dev, skb->len);
 
-	netif_rx(skb);
+	__netif_rx(skb);
 	return 0;
 
 err:
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 77f5b564382b6..d05f86fe78c95 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -78,7 +78,7 @@ static netdev_tx_t loopback_xmit(struct sk_buff *skb,
 
 	skb_orphan(skb);
 
-	/* Before queueing this packet to netif_rx(),
+	/* Before queueing this packet to __netif_rx(),
 	 * make sure dst is refcounted.
 	 */
 	skb_dst_force(skb);
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 3d08743317634..832f09ac075e7 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1033,7 +1033,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 				else
 					nskb->pkt_type = PACKET_MULTICAST;
 
-				netif_rx(nskb);
+				__netif_rx(nskb);
 			}
 			continue;
 		}
@@ -1056,7 +1056,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 
 		nskb->dev = ndev;
 
-		if (netif_rx(nskb) == NET_RX_SUCCESS) {
+		if (__netif_rx(nskb) == NET_RX_SUCCESS) {
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsUntagged++;
 			u64_stats_update_end(&secy_stats->syncp);
@@ -1288,7 +1288,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 
 		macsec_reset_skb(nskb, macsec->secy.netdev);
 
-		ret = netif_rx(nskb);
+		ret = __netif_rx(nskb);
 		if (ret == NET_RX_SUCCESS) {
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsUnknownSCI++;
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 6ef5f77be4d0a..d87c06c317ede 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -410,7 +410,7 @@ static void macvlan_forward_source_one(struct sk_buff *skb,
 	if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest, dev->dev_addr))
 		nskb->pkt_type = PACKET_HOST;
 
-	ret = netif_rx(nskb);
+	ret = __netif_rx(nskb);
 	macvlan_count_rx(vlan, len, ret == NET_RX_SUCCESS, false);
 }
 
@@ -468,7 +468,7 @@ static rx_handler_result_t macvlan_handle_frame(struct sk_buff **pskb)
 			/* forward to original port. */
 			vlan = src;
 			ret = macvlan_broadcast_one(skb, vlan, eth, 0) ?:
-			      netif_rx(skb);
+			      __netif_rx(skb);
 			handle_res = RX_HANDLER_CONSUMED;
 			goto out;
 		}
diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index aaa628f859fd4..0b1b6f650104b 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -225,7 +225,7 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
 		u64_stats_inc(&mhi_netdev->stats.rx_packets);
 		u64_stats_add(&mhi_netdev->stats.rx_bytes, skb->len);
 		u64_stats_update_end(&mhi_netdev->stats.rx_syncp);
-		netif_rx(skb);
+		__netif_rx(skb);
 	}
 
 	/* Refill if RX buffers queue becomes low */
diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 98ca6b18415e7..80bdc07f2cd33 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -119,7 +119,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
 
-	if (netif_rx(skb) == NET_RX_DROP) {
+	if (__netif_rx(skb) == NET_RX_DROP) {
 		ndev->stats.rx_errors++;
 		ndev->stats.rx_dropped++;
 	} else {
diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index 1a95f3beb784d..39e61e07e4894 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -109,7 +109,7 @@ static int rionet_rx_clean(struct net_device *ndev)
 		skb_put(rnet->rx_skb[i], RIO_MAX_MSG_SIZE);
 		rnet->rx_skb[i]->protocol =
 		    eth_type_trans(rnet->rx_skb[i], ndev);
-		error = netif_rx(rnet->rx_skb[i]);
+		error = __netif_rx(rnet->rx_skb[i]);
 
 		if (error == NET_RX_DROP) {
 			ndev->stats.rx_dropped++;
diff --git a/drivers/net/sb1000.c b/drivers/net/sb1000.c
index 57a6d598467b2..c3f8020571add 100644
--- a/drivers/net/sb1000.c
+++ b/drivers/net/sb1000.c
@@ -872,7 +872,7 @@ printk("cm0: IP identification: %02x%02x  fragment offset: %02x%02x\n", buffer[3
 
 	/* datagram completed: send to upper level */
 	skb_trim(skb, dlen);
-	netif_rx(skb);
+	__netif_rx(skb);
 	stats->rx_bytes+=dlen;
 	stats->rx_packets++;
 	lp->rx_skb[ns] = NULL;
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index d29fb9759cc95..58b20ea171dda 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -287,7 +287,7 @@ static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
 {
 	return __dev_forward_skb(dev, skb) ?: xdp ?
 		veth_xdp_rx(rq, skb) :
-		netif_rx(skb);
+		__netif_rx(skb);
 }
 
 /* return true if the specified skb has chances of GRO aggregation
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index e0b1ab99a359e..714cafcf6c6c8 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -418,7 +418,7 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	skb->protocol = eth_type_trans(skb, dev);
 
-	if (likely(netif_rx(skb) == NET_RX_SUCCESS))
+	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
 		vrf_rx_stats(dev, len);
 	else
 		this_cpu_inc(dev->dstats->rx_drps);
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 359d16780dbbc..d0dc90d3dac28 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2541,7 +2541,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	tx_stats->tx_bytes += len;
 	u64_stats_update_end(&tx_stats->syncp);
 
-	if (netif_rx(skb) == NET_RX_SUCCESS) {
+	if (__netif_rx(skb) == NET_RX_SUCCESS) {
 		u64_stats_update_begin(&rx_stats->syncp);
 		rx_stats->rx_packets++;
 		rx_stats->rx_bytes += len;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 183b90923f51b..a0c883f19a417 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4160,9 +4160,11 @@ static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
+	local_bh_disable();
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = dwc3_process_event_buf(evt);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 411a428ace4d4..481e565cc5c42 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -100,6 +100,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
 	CPUHP_PADATA_DEAD,
 	CPUHP_AP_DTPM_CPU_DEAD,
+	CPUHP_RANDOM_PREPARE,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
@@ -240,6 +241,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_CSKY_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
+	CPUHP_AP_RANDOM_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
diff --git a/include/linux/random.h b/include/linux/random.h
index c45b2693e51fb..b78ac91e6b256 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -158,4 +158,9 @@ static inline bool __init arch_get_random_long_early(unsigned long *v)
 }
 #endif
 
+#ifdef CONFIG_SMP
+extern int random_prepare_cpu(unsigned int cpu);
+extern int random_online_cpu(unsigned int cpu);
+#endif
+
 #endif /* _LINUX_RANDOM_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 613178f062308..99807ada20a6e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1084,7 +1084,6 @@ struct task_struct {
 	sigset_t			saved_sigmask;
 	struct sigpending		pending;
 #ifdef CONFIG_PREEMPT_RT
-	/* TODO: move me into ->restart_block ? */
 	struct				kernel_siginfo forced_info;
 #endif
 	unsigned long			sas_ss_sp;
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index ccd1336aa7f42..892562ebbd3aa 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -70,7 +70,6 @@ static inline void *try_get_task_stack(struct task_struct *tsk)
 }
 
 extern void put_task_stack(struct task_struct *tsk);
-extern void put_task_stack_sched(struct task_struct *tsk);
 #else
 static inline void *try_get_task_stack(struct task_struct *tsk)
 {
@@ -78,13 +77,6 @@ static inline void *try_get_task_stack(struct task_struct *tsk)
 }
 
 static inline void put_task_stack(struct task_struct *tsk) {}
-static inline void put_task_stack_sched(struct task_struct *tsk) {}
-#endif
-
-#ifdef CONFIG_ARCH_THREAD_STACK_ALLOCATOR
-static inline void task_stack_cleanup(struct task_struct *tsk) {}
-#else
-extern void task_stack_cleanup(struct task_struct *tsk);
 #endif
 
 void exit_task_stack_account(struct task_struct *tsk);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 407a2568f35eb..01dabccad814e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -34,6 +34,7 @@
 #include <linux/scs.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
+#include <linux/random.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1659,6 +1660,11 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= perf_event_init_cpu,
 		.teardown.single	= perf_event_exit_cpu,
 	},
+	[CPUHP_RANDOM_PREPARE] = {
+		.name                   = "random:prepare",
+		.startup.single         = random_prepare_cpu,
+		.teardown.single        = NULL,
+	},
 	[CPUHP_WORKQUEUE_PREP] = {
 		.name			= "workqueue:prepare",
 		.startup.single		= workqueue_prepare_cpu,
@@ -1782,6 +1788,11 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= workqueue_online_cpu,
 		.teardown.single	= workqueue_offline_cpu,
 	},
+	[CPUHP_AP_RANDOM_ONLINE] = {
+		.name                   = "random:online",
+		.startup.single         = random_online_cpu,
+		.teardown.single        = NULL,
+	},
 	[CPUHP_AP_RCUTREE_ONLINE] = {
 		.name			= "RCU/tree:online",
 		.startup.single		= rcutree_online_cpu,
diff --git a/kernel/exit.c b/kernel/exit.c
index 293b280d23192..c303cffe7fdb4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -171,7 +171,6 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 	kprobe_flush_task(tsk);
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
-	task_stack_cleanup(tsk);
 	put_task_struct(tsk);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 416abb6fc218c..1279b57c4ad9e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -179,16 +179,6 @@ static inline void free_task_struct(struct task_struct *tsk)
 
 #ifndef CONFIG_ARCH_THREAD_STACK_ALLOCATOR
 
-#define THREAD_STACK_DELAYED_FREE	1UL
-
-static void thread_stack_mark_delayed_free(struct task_struct *tsk)
-{
-	unsigned long val = (unsigned long)tsk->stack;
-
-	val |= THREAD_STACK_DELAYED_FREE;
-	WRITE_ONCE(tsk->stack, (void *)val);
-}
-
 /*
  * Allocate pages if THREAD_SIZE is >= PAGE_SIZE, otherwise use a
  * kmemcache based allocator.
@@ -203,6 +193,41 @@ static void thread_stack_mark_delayed_free(struct task_struct *tsk)
 #define NR_CACHED_STACKS 2
 static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
 
+struct vm_stack {
+	struct rcu_head rcu;
+	struct vm_struct *stack_vm_area;
+};
+
+static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
+{
+	unsigned int i;
+
+	for (i = 0; i < NR_CACHED_STACKS; i++) {
+		if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm) != NULL)
+			continue;
+		return true;
+	}
+	return false;
+}
+
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	struct vm_stack *vm_stack = container_of(rh, struct vm_stack, rcu);
+
+	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
+		return;
+
+	vfree(vm_stack);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct vm_stack *vm_stack = tsk->stack;
+
+	vm_stack->stack_vm_area = tsk->stack_vm_area;
+	call_rcu(&vm_stack->rcu, thread_stack_free_rcu);
+}
+
 static int free_vm_stack_cache(unsigned int cpu)
 {
 	struct vm_struct **cached_vm_stacks = per_cpu_ptr(cached_stacks, cpu);
@@ -304,31 +329,29 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	return 0;
 }
 
-static void free_thread_stack(struct task_struct *tsk, bool cache_only)
+static void free_thread_stack(struct task_struct *tsk)
 {
-	int i;
+	if (!try_release_thread_stack_to_cache(tsk->stack_vm_area))
+		thread_stack_delayed_free(tsk);
 
-	for (i = 0; i < NR_CACHED_STACKS; i++) {
-		if (this_cpu_cmpxchg(cached_stacks[i], NULL,
-				     tsk->stack_vm_area) != NULL)
-			continue;
-
-		tsk->stack = NULL;
-		tsk->stack_vm_area = NULL;
-		return;
-	}
-	if (cache_only) {
-		thread_stack_mark_delayed_free(tsk);
-		return;
-	}
-
-	vfree(tsk->stack);
 	tsk->stack = NULL;
 	tsk->stack_vm_area = NULL;
 }
 
 #  else /* !CONFIG_VMAP_STACK */
 
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	__free_pages(virt_to_page(rh), THREAD_SIZE_ORDER);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct rcu_head *rh = tsk->stack;
+
+	call_rcu(rh, thread_stack_free_rcu);
+}
+
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	struct page *page = alloc_pages_node(node, THREADINFO_GFP,
@@ -341,13 +364,9 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	return -ENOMEM;
 }
 
-static void free_thread_stack(struct task_struct *tsk, bool cache_only)
+static void free_thread_stack(struct task_struct *tsk)
 {
-	if (cache_only) {
-		thread_stack_mark_delayed_free(tsk);
-		return;
-	}
-	__free_pages(virt_to_page(tsk->stack), THREAD_SIZE_ORDER);
+	thread_stack_delayed_free(tsk);
 	tsk->stack = NULL;
 }
 
@@ -356,6 +375,18 @@ static void free_thread_stack(struct task_struct *tsk, bool cache_only)
 
 static struct kmem_cache *thread_stack_cache;
 
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	kmem_cache_free(thread_stack_cache, rh);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct rcu_head *rh = tsk->stack;
+
+	call_rcu(rh, thread_stack_free_rcu);
+}
+
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
@@ -365,13 +396,9 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	return stack ? 0 : -ENOMEM;
 }
 
-static void free_thread_stack(struct task_struct *tsk, bool cache_only)
+static void free_thread_stack(struct task_struct *tsk)
 {
-	if (cache_only) {
-		thread_stack_mark_delayed_free(tsk);
-		return;
-	}
-	kmem_cache_free(thread_stack_cache, tsk->stack);
+	thread_stack_delayed_free(tsk);
 	tsk->stack = NULL;
 }
 
@@ -384,19 +411,8 @@ void thread_stack_cache_init(void)
 }
 
 # endif /* THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
-
-void task_stack_cleanup(struct task_struct *tsk)
-{
-	unsigned long val = (unsigned long)tsk->stack;
-
-	if (!(val & THREAD_STACK_DELAYED_FREE))
-		return;
-
-	WRITE_ONCE(tsk->stack, (void *)(val & ~THREAD_STACK_DELAYED_FREE));
-	free_thread_stack(tsk, false);
-}
-
 #else /* CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
+
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
@@ -406,9 +422,10 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	return stack ? 0 : -ENOMEM;
 }
 
-static void free_thread_stack(struct task_struct *tsk, bool cache_only)
+static void free_thread_stack(struct task_struct *tsk)
 {
 	arch_free_thread_stack(tsk);
+	tsk->stack = NULL;
 }
 
 #endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
@@ -498,25 +515,19 @@ void exit_task_stack_account(struct task_struct *tsk)
 	}
 }
 
-static void release_task_stack(struct task_struct *tsk, bool cache_only)
+static void release_task_stack(struct task_struct *tsk)
 {
 	if (WARN_ON(READ_ONCE(tsk->__state) != TASK_DEAD))
 		return;  /* Better to leak the stack than to free prematurely */
 
-	free_thread_stack(tsk, cache_only);
+	free_thread_stack(tsk);
 }
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 void put_task_stack(struct task_struct *tsk)
 {
 	if (refcount_dec_and_test(&tsk->stack_refcount))
-		release_task_stack(tsk, false);
-}
-
-void put_task_stack_sched(struct task_struct *tsk)
-{
-	if (refcount_dec_and_test(&tsk->stack_refcount))
-		release_task_stack(tsk, true);
+		release_task_stack(tsk);
 }
 #endif
 
@@ -530,7 +541,7 @@ void free_task(struct task_struct *tsk)
 	 * The task is finally done with both the stack and thread_info,
 	 * so free both.
 	 */
-	release_task_stack(tsk, false);
+	release_task_stack(tsk);
 #else
 	/*
 	 * If the task had a separate stack allocation, it should be gone
@@ -1030,7 +1041,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 free_stack:
 	exit_task_stack_account(tsk);
-	free_thread_stack(tsk, false);
+	free_thread_stack(tsk);
 free_tsk:
 	free_task_struct(tsk);
 	return NULL;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 97223df2f460e..346d283d2da14 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -663,13 +663,15 @@ int generic_handle_irq(unsigned int irq)
 EXPORT_SYMBOL_GPL(generic_handle_irq);
 
 /**
- * generic_handle_irq_safe - Invoke the handler for a particular irq
+ * generic_handle_irq_safe - Invoke the handler for a particular irq from any
+ *			     context.
  * @irq:	The irq number to handle
  *
- * Returns:	0 on success, or -EINVAL if conversion has failed
+ * Returns:	0 on success, a negative value on error.
  *
- * This function must be called either from an IRQ context with irq regs
- * initialized or with care from any context.
+ * This function can be called from any context (IRQ or process context). It
+ * will report an error if not invoked from IRQ context and the irq has been
+ * marked to enforce IRQ-context only.
  */
 int generic_handle_irq_safe(unsigned int irq)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d9b85784a1188..327a48b14f00a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4948,11 +4948,8 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
-		/*
-		 * Cache only the VMAP stack. The final deallocation is in
-		 * delayed_put_task_struct.
-		 */
-		put_task_stack_sched(prev);
+		/* Task is done with its stack. */
+		put_task_stack(prev);
 
 		put_task_struct_rcu_user(prev);
 	}
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a86e984c6b66a..63287fd03250b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -169,6 +169,7 @@ struct mem_cgroup_event {
 	struct work_struct remove;
 };
 
+static void mem_cgroup_threshold(struct mem_cgroup *memcg);
 static void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
 
 /* Stuffs for move charges at task migration. */
@@ -260,10 +261,8 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
 
-struct memcg_stock_pcp;
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages,
-				      bool stock_lock_acquried);
+				      unsigned int nr_pages);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -297,7 +296,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages, false);
+		obj_cgroup_uncharge_pages(objcg, nr_pages);
 
 	spin_lock_irqsave(&objcg_lock, flags);
 	list_del(&objcg->list);
@@ -522,6 +521,43 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 	return excess;
 }
 
+static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
+{
+	unsigned long excess;
+	struct mem_cgroup_per_node *mz;
+	struct mem_cgroup_tree_per_node *mctz;
+
+	mctz = soft_limit_tree.rb_tree_per_node[nid];
+	if (!mctz)
+		return;
+	/*
+	 * Necessary to update all ancestors when hierarchy is used.
+	 * because their event counter is not touched.
+	 */
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		mz = memcg->nodeinfo[nid];
+		excess = soft_limit_excess(memcg);
+		/*
+		 * We have to update the tree if mz is on RB-tree or
+		 * mem is over its softlimit.
+		 */
+		if (excess || mz->on_tree) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&mctz->lock, flags);
+			/* if on-tree, remove it */
+			if (mz->on_tree)
+				__mem_cgroup_remove_exceeded(mz, mctz);
+			/*
+			 * Insert again. mz->usage_in_excess will be updated.
+			 * If excess is 0, no tree ops.
+			 */
+			__mem_cgroup_insert_exceeded(mz, mctz, excess);
+			spin_unlock_irqrestore(&mctz->lock, flags);
+		}
+	}
+}
+
 static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_tree_per_node *mctz;
@@ -593,6 +629,35 @@ static DEFINE_SPINLOCK(stats_flush_lock);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 
+/*
+ * Accessors to ensure that preemption is disabled on PREEMPT_RT because it can
+ * not rely on this as part of an acquired spinlock_t lock. These functions are
+ * never used in hardirq context on PREEMPT_RT and therefore disabling preemtion
+ * is sufficient.
+ */
+static void memcg_stats_lock(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+      preempt_disable();
+#else
+      VM_BUG_ON(!irqs_disabled());
+#endif
+}
+
+static void __memcg_stats_lock(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+      preempt_disable();
+#endif
+}
+
+static void memcg_stats_unlock(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+      preempt_enable();
+#endif
+}
+
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
 	unsigned int x;
@@ -669,8 +734,27 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	/*
+	 * The caller from rmap relay on disabled preemption becase they never
+	 * update their counter from in-interrupt context. For these two
+	 * counters we check that the update is never performed from an
+	 * interrupt context while other caller need to have disabled interrupt.
+	 */
+	__memcg_stats_lock();
+	if (IS_ENABLED(CONFIG_DEBUG_VM) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		switch (idx) {
+		case NR_ANON_MAPPED:
+		case NR_FILE_MAPPED:
+		case NR_ANON_THPS:
+		case NR_SHMEM_PMDMAPPED:
+		case NR_FILE_PMDMAPPED:
+			WARN_ON_ONCE(!in_task());
+			break;
+		default:
+			WARN_ON_ONCE(!irqs_disabled());
+		}
+	}
+
 	/* Update memcg */
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 
@@ -678,8 +762,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
 
 	memcg_rstat_updated(memcg, val);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	memcg_stats_unlock();
 }
 
 /**
@@ -762,12 +845,10 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	if (mem_cgroup_disabled())
 		return;
 
-	if (IS_ENABLED(PREEMPT_RT))
-		preempt_disable();
+	memcg_stats_lock();
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
 	memcg_rstat_updated(memcg, count);
-	if (IS_ENABLED(PREEMPT_RT))
-		preempt_enable();
+	memcg_stats_unlock();
 }
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
@@ -799,6 +880,53 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
 }
 
+static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
+				       enum mem_cgroup_events_target target)
+{
+	unsigned long val, next;
+
+	val = __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
+	next = __this_cpu_read(memcg->vmstats_percpu->targets[target]);
+	/* from time_after() in jiffies.h */
+	if ((long)(next - val) < 0) {
+		switch (target) {
+		case MEM_CGROUP_TARGET_THRESH:
+			next = val + THRESHOLDS_EVENTS_TARGET;
+			break;
+		case MEM_CGROUP_TARGET_SOFTLIMIT:
+			next = val + SOFTLIMIT_EVENTS_TARGET;
+			break;
+		default:
+			break;
+		}
+		__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
+		return true;
+	}
+	return false;
+}
+
+/*
+ * Check events in order.
+ *
+ */
+static void memcg_check_events(struct mem_cgroup *memcg, int nid)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return;
+
+	/* threshold event is triggered in finer grain than soft limit */
+	if (unlikely(mem_cgroup_event_ratelimit(memcg,
+						MEM_CGROUP_TARGET_THRESH))) {
+		bool do_softlimit;
+
+		do_softlimit = mem_cgroup_event_ratelimit(memcg,
+						MEM_CGROUP_TARGET_SOFTLIMIT);
+		mem_cgroup_threshold(memcg);
+		if (unlikely(do_softlimit))
+			mem_cgroup_update_tree(memcg, nid);
+	}
+}
+
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 {
 	/*
@@ -2013,29 +2141,18 @@ void unlock_page_memcg(struct page *page)
 	folio_memcg_unlock(page_folio(page));
 }
 
-struct obj_stock {
+struct memcg_stock_pcp {
+	local_lock_t stock_lock;
+	struct mem_cgroup *cached; /* this never be root cgroup */
+	unsigned int nr_pages;
+
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
 	unsigned int nr_bytes;
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
-#else
-	int dummy[0];
 #endif
-};
-
-struct memcg_stock_pcp {
-	/* Protects memcg_stock_pcp */
-	local_lock_t stock_lock;
-	struct mem_cgroup *cached; /* this never be root cgroup */
-	unsigned int nr_pages;
-#ifndef CONFIG_PREEMPTION
-	/* Protects only task_obj */
-	local_lock_t task_obj_lock;
-	struct obj_stock task_obj;
-#endif
-	struct obj_stock irq_obj;
 
 	struct work_struct work;
 	unsigned long flags;
@@ -2043,21 +2160,16 @@ struct memcg_stock_pcp {
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
 	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
-#ifndef CONFIG_PREEMPTION
-	.task_obj_lock = INIT_LOCAL_LOCK(task_obj_lock),
-#endif
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
-static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
-					  bool stock_lock_acquried);
+static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
 #else
-static inline struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
-						 bool stock_lock_acquried)
+static inline struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 	return NULL;
 }
@@ -2124,30 +2236,23 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 
 static void drain_local_stock(struct work_struct *dummy)
 {
-	struct memcg_stock_pcp *stock_pcp;
-	struct obj_cgroup *old;
+	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old = NULL;
+	unsigned long flags;
 
 	/*
 	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-#ifndef CONFIG_PREEMPTION
-	local_lock(&memcg_stock.task_obj_lock);
-	old = drain_obj_stock(&this_cpu_ptr(&memcg_stock)->task_obj, NULL);
-	local_unlock(&memcg_stock.task_obj_lock);
-	if (old)
-		obj_cgroup_put(old);
-#endif
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
-	local_lock_irq(&memcg_stock.stock_lock);
-	stock_pcp = this_cpu_ptr(&memcg_stock);
-	old = drain_obj_stock(&stock_pcp->irq_obj, stock_pcp);
+	stock = this_cpu_ptr(&memcg_stock);
+	old = drain_obj_stock(stock);
+	drain_stock(stock);
+	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	drain_stock(stock_pcp);
-	clear_bit(FLUSHING_CACHED_CHARGE, &stock_pcp->flags);
-
-	local_unlock_irq(&memcg_stock.stock_lock);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	if (old)
 		obj_cgroup_put(old);
 }
@@ -2158,9 +2263,9 @@ static void drain_local_stock(struct work_struct *dummy)
  */
 static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
+	struct memcg_stock_pcp *stock;
 
-	lockdep_assert_held(&stock->stock_lock);
+	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		css_get(&memcg->css);
@@ -2172,15 +2277,10 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		drain_stock(stock);
 }
 
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
-			 bool stock_lock_acquried)
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
 
-	if (stock_lock_acquried) {
-		__refill_stock(memcg, nr_pages);
-		return;
-	}
 	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	__refill_stock(memcg, nr_pages);
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
@@ -2192,7 +2292,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
  */
 static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
-	int cpu;
+	int cpu, curcpu;
 
 	/* If someone's already draining, avoid adding running more workers. */
 	if (!mutex_trylock(&percpu_charge_mutex))
@@ -2203,7 +2303,8 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	 * as well as workers from this path always operate on the local
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
-	cpus_read_lock();
+	migrate_disable();
+	curcpu = smp_processor_id();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -2219,10 +2320,14 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		rcu_read_unlock();
 
 		if (flush &&
-		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags))
-			schedule_work_on(cpu, &stock->work);
+		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
+			if (cpu == curcpu)
+				drain_local_stock(&stock->work);
+			else
+				schedule_work_on(cpu, &stock->work);
+		}
 	}
-	cpus_read_unlock();
+	migrate_enable();
 	mutex_unlock(&percpu_charge_mutex);
 }
 
@@ -2623,7 +2728,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 done_restock:
 	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages, false);
+		refill_stock(memcg, batch - nr_pages);
 
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
@@ -2725,49 +2830,6 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
  */
 #define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
 
-/*
- * Most kmem_cache_alloc() calls are from user context. The irq disable/enable
- * sequence used in this case to access content from object stock is slow.
- * To optimize for user context access, there are now two object stocks for
- * task context and interrupt context access respectively.
- *
- * The task context object stock can be accessed by disabling preemption only
- * which is cheap in non-preempt kernel. The interrupt context object stock
- * can only be accessed after disabling interrupt. User context code can
- * access interrupt object stock, but not vice versa.
- */
-static inline struct obj_stock *get_obj_stock(unsigned long *pflags,
-					      bool *stock_lock_acquried)
-{
-	struct memcg_stock_pcp *stock;
-
-#ifndef CONFIG_PREEMPTION
-	if (likely(in_task())) {
-		*pflags = 0UL;
-		*stock_lock_acquried = false;
-		local_lock(&memcg_stock.task_obj_lock);
-		stock = this_cpu_ptr(&memcg_stock);
-		return &stock->task_obj;
-	}
-#endif
-	*stock_lock_acquried = true;
-	local_lock_irqsave(&memcg_stock.stock_lock, *pflags);
-	stock = this_cpu_ptr(&memcg_stock);
-	return &stock->irq_obj;
-}
-
-static inline void put_obj_stock(unsigned long flags,
-				 bool stock_lock_acquried)
-{
-#ifndef CONFIG_PREEMPTION
-	if (likely(!stock_lock_acquried)) {
-		local_unlock(&memcg_stock.task_obj_lock);
-		return;
-	}
-#endif
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
-}
-
 /*
  * mod_objcg_mlstate() may be called with irq enabled, so
  * mod_memcg_lruvec_state() should be used.
@@ -2948,8 +3010,7 @@ static void memcg_free_cache_id(int id)
  * @nr_pages: number of pages to uncharge
  */
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages,
-				      bool stock_lock_acquried)
+				      unsigned int nr_pages)
 {
 	struct mem_cgroup *memcg;
 
@@ -2957,7 +3018,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
-	refill_stock(memcg, nr_pages, stock_lock_acquried);
+	refill_stock(memcg, nr_pages);
 
 	css_put(&memcg->css);
 }
@@ -3031,7 +3092,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 		return;
 
 	objcg = __folio_objcg(folio);
-	obj_cgroup_uncharge_pages(objcg, nr_pages, false);
+	obj_cgroup_uncharge_pages(objcg, nr_pages);
 	folio->memcg_data = 0;
 	obj_cgroup_put(objcg);
 }
@@ -3039,21 +3100,21 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
-	bool stock_lock_acquried;
-	unsigned long flags;
+	struct memcg_stock_pcp *stock;
 	struct obj_cgroup *old = NULL;
-	struct obj_stock *stock;
+	unsigned long flags;
 	int *bytes;
 
-	stock = get_obj_stock(&flags, &stock_lock_acquried);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	stock = this_cpu_ptr(&memcg_stock);
+
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat or idx
 	 * changes.
 	 */
 	if (stock->cached_objcg != objcg) {
-		old = drain_obj_stock(stock, stock_lock_acquried);
-
+		old = drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
@@ -3097,31 +3158,31 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	put_obj_stock(flags, stock_lock_acquried);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	if (old)
 		obj_cgroup_put(old);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
-	bool stock_lock_acquried;
+	struct memcg_stock_pcp *stock;
 	unsigned long flags;
-	struct obj_stock *stock;
 	bool ret = false;
 
-	stock = get_obj_stock(&flags, &stock_lock_acquried);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+
+	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
 	}
 
-	put_obj_stock(flags, stock_lock_acquried);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
 
-static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
-					  bool stock_lock_acquried)
+static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 	struct obj_cgroup *old = stock->cached_objcg;
 
@@ -3132,8 +3193,18 @@ static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
 
-		if (nr_pages)
-			obj_cgroup_uncharge_pages(old, nr_pages, stock_lock_acquried);
+		if (nr_pages) {
+			struct mem_cgroup *memcg;
+
+			memcg = get_mem_cgroup_from_objcg(old);
+
+			if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+				page_counter_uncharge(&memcg->kmem, nr_pages);
+
+			__refill_stock(memcg, nr_pages);
+
+			css_put(&memcg->css);
+		}
 
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
@@ -3169,6 +3240,10 @@ static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
 	}
 
 	stock->cached_objcg = NULL;
+	/*
+	 * The `old' objects needs to be released by the caller via
+	 * obj_cgroup_put() outside of memcg_stock_pcp::stock_lock.
+	 */
 	return old;
 }
 
@@ -3177,15 +3252,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 {
 	struct mem_cgroup *memcg;
 
-#ifndef CONFIG_PREEMPTION
-	if (in_task() && stock->task_obj.cached_objcg) {
-		memcg = obj_cgroup_memcg(stock->task_obj.cached_objcg);
-		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
-			return true;
-	}
-#endif
-	if (stock->irq_obj.cached_objcg) {
-		memcg = obj_cgroup_memcg(stock->irq_obj.cached_objcg);
+	if (stock->cached_objcg) {
+		memcg = obj_cgroup_memcg(stock->cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
@@ -3196,15 +3264,16 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
-	bool stock_lock_acquried;
-	unsigned long flags;
-	struct obj_stock *stock;
-	unsigned int nr_pages = 0;
+	struct memcg_stock_pcp *stock;
 	struct obj_cgroup *old = NULL;
+	unsigned long flags;
+	unsigned int nr_pages = 0;
 
-	stock = get_obj_stock(&flags, &stock_lock_acquried);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+
+	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
-		old = drain_obj_stock(stock, stock_lock_acquried);
+		old = drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg = objcg;
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
@@ -3218,12 +3287,12 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	put_obj_stock(flags, stock_lock_acquried);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	if (old)
 		obj_cgroup_put(old);
 
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages, false);
+		obj_cgroup_uncharge_pages(objcg, nr_pages);
 }
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -3743,12 +3812,12 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		}
 		break;
 	case RES_SOFT_LIMIT:
-#ifndef CONFIG_PREEMPT_RT
-		memcg->soft_limit = nr_pages;
-		ret = 0;
-#else
-		ret = -EOPNOTSUPP;
-#endif
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			ret = -EOPNOTSUPP;
+		} else {
+			memcg->soft_limit = nr_pages;
+			ret = 0;
+		}
 		break;
 	}
 	return ret ?: nbytes;
@@ -4053,6 +4122,82 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
+static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
+{
+	struct mem_cgroup_threshold_ary *t;
+	unsigned long usage;
+	int i;
+
+	rcu_read_lock();
+	if (!swap)
+		t = rcu_dereference(memcg->thresholds.primary);
+	else
+		t = rcu_dereference(memcg->memsw_thresholds.primary);
+
+	if (!t)
+		goto unlock;
+
+	usage = mem_cgroup_usage(memcg, swap);
+
+	/*
+	 * current_threshold points to threshold just below or equal to usage.
+	 * If it's not true, a threshold was crossed after last
+	 * call of __mem_cgroup_threshold().
+	 */
+	i = t->current_threshold;
+
+	/*
+	 * Iterate backward over array of thresholds starting from
+	 * current_threshold and check if a threshold is crossed.
+	 * If none of thresholds below usage is crossed, we read
+	 * only one element of the array here.
+	 */
+	for (; i >= 0 && unlikely(t->entries[i].threshold > usage); i--)
+		eventfd_signal(t->entries[i].eventfd, 1);
+
+	/* i = current_threshold + 1 */
+	i++;
+
+	/*
+	 * Iterate forward over array of thresholds starting from
+	 * current_threshold+1 and check if a threshold is crossed.
+	 * If none of thresholds above usage is crossed, we read
+	 * only one element of the array here.
+	 */
+	for (; i < t->size && unlikely(t->entries[i].threshold <= usage); i++)
+		eventfd_signal(t->entries[i].eventfd, 1);
+
+	/* Update current_threshold */
+	t->current_threshold = i - 1;
+unlock:
+	rcu_read_unlock();
+}
+
+static void mem_cgroup_threshold(struct mem_cgroup *memcg)
+{
+	while (memcg) {
+		__mem_cgroup_threshold(memcg, false);
+		if (do_memsw_account())
+			__mem_cgroup_threshold(memcg, true);
+
+		memcg = parent_mem_cgroup(memcg);
+	}
+}
+
+static int compare_thresholds(const void *a, const void *b)
+{
+	const struct mem_cgroup_threshold *_a = a;
+	const struct mem_cgroup_threshold *_b = b;
+
+	if (_a->threshold > _b->threshold)
+		return 1;
+
+	if (_a->threshold < _b->threshold)
+		return -1;
+
+	return 0;
+}
+
 static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_eventfd_list *ev;
@@ -4074,6 +4219,234 @@ static void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
 		mem_cgroup_oom_notify_cb(iter);
 }
 
+static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args, enum res_type type)
+{
+	struct mem_cgroup_thresholds *thresholds;
+	struct mem_cgroup_threshold_ary *new;
+	unsigned long threshold;
+	unsigned long usage;
+	int i, size, ret;
+
+	ret = page_counter_memparse(args, "-1", &threshold);
+	if (ret)
+		return ret;
+
+	mutex_lock(&memcg->thresholds_lock);
+
+	if (type == _MEM) {
+		thresholds = &memcg->thresholds;
+		usage = mem_cgroup_usage(memcg, false);
+	} else if (type == _MEMSWAP) {
+		thresholds = &memcg->memsw_thresholds;
+		usage = mem_cgroup_usage(memcg, true);
+	} else
+		BUG();
+
+	/* Check if a threshold crossed before adding a new one */
+	if (thresholds->primary)
+		__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+
+	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
+
+	/* Allocate memory for new array of thresholds */
+	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+	new->size = size;
+
+	/* Copy thresholds (if any) to new array */
+	if (thresholds->primary)
+		memcpy(new->entries, thresholds->primary->entries,
+		       flex_array_size(new, entries, size - 1));
+
+	/* Add new threshold */
+	new->entries[size - 1].eventfd = eventfd;
+	new->entries[size - 1].threshold = threshold;
+
+	/* Sort thresholds. Registering of new threshold isn't time-critical */
+	sort(new->entries, size, sizeof(*new->entries),
+			compare_thresholds, NULL);
+
+	/* Find current threshold */
+	new->current_threshold = -1;
+	for (i = 0; i < size; i++) {
+		if (new->entries[i].threshold <= usage) {
+			/*
+			 * new->current_threshold will not be used until
+			 * rcu_assign_pointer(), so it's safe to increment
+			 * it here.
+			 */
+			++new->current_threshold;
+		} else
+			break;
+	}
+
+	/* Free old spare buffer and save old primary buffer as spare */
+	kfree(thresholds->spare);
+	thresholds->spare = thresholds->primary;
+
+	rcu_assign_pointer(thresholds->primary, new);
+
+	/* To be sure that nobody uses thresholds */
+	synchronize_rcu();
+
+unlock:
+	mutex_unlock(&memcg->thresholds_lock);
+
+	return ret;
+}
+
+static int mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args)
+{
+	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEM);
+}
+
+static int memsw_cgroup_usage_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args)
+{
+	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEMSWAP);
+}
+
+static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, enum res_type type)
+{
+	struct mem_cgroup_thresholds *thresholds;
+	struct mem_cgroup_threshold_ary *new;
+	unsigned long usage;
+	int i, j, size, entries;
+
+	mutex_lock(&memcg->thresholds_lock);
+
+	if (type == _MEM) {
+		thresholds = &memcg->thresholds;
+		usage = mem_cgroup_usage(memcg, false);
+	} else if (type == _MEMSWAP) {
+		thresholds = &memcg->memsw_thresholds;
+		usage = mem_cgroup_usage(memcg, true);
+	} else
+		BUG();
+
+	if (!thresholds->primary)
+		goto unlock;
+
+	/* Check if a threshold crossed before removing */
+	__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+
+	/* Calculate new number of threshold */
+	size = entries = 0;
+	for (i = 0; i < thresholds->primary->size; i++) {
+		if (thresholds->primary->entries[i].eventfd != eventfd)
+			size++;
+		else
+			entries++;
+	}
+
+	new = thresholds->spare;
+
+	/* If no items related to eventfd have been cleared, nothing to do */
+	if (!entries)
+		goto unlock;
+
+	/* Set thresholds array to NULL if we don't have thresholds */
+	if (!size) {
+		kfree(new);
+		new = NULL;
+		goto swap_buffers;
+	}
+
+	new->size = size;
+
+	/* Copy thresholds and find current threshold */
+	new->current_threshold = -1;
+	for (i = 0, j = 0; i < thresholds->primary->size; i++) {
+		if (thresholds->primary->entries[i].eventfd == eventfd)
+			continue;
+
+		new->entries[j] = thresholds->primary->entries[i];
+		if (new->entries[j].threshold <= usage) {
+			/*
+			 * new->current_threshold will not be used
+			 * until rcu_assign_pointer(), so it's safe to increment
+			 * it here.
+			 */
+			++new->current_threshold;
+		}
+		j++;
+	}
+
+swap_buffers:
+	/* Swap primary and spare array */
+	thresholds->spare = thresholds->primary;
+
+	rcu_assign_pointer(thresholds->primary, new);
+
+	/* To be sure that nobody uses thresholds */
+	synchronize_rcu();
+
+	/* If all events are unregistered, free the spare array */
+	if (!new) {
+		kfree(thresholds->spare);
+		thresholds->spare = NULL;
+	}
+unlock:
+	mutex_unlock(&memcg->thresholds_lock);
+}
+
+static void mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd)
+{
+	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEM);
+}
+
+static void memsw_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd)
+{
+	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEMSWAP);
+}
+
+static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args)
+{
+	struct mem_cgroup_eventfd_list *event;
+
+	event = kmalloc(sizeof(*event),	GFP_KERNEL);
+	if (!event)
+		return -ENOMEM;
+
+	spin_lock(&memcg_oom_lock);
+
+	event->eventfd = eventfd;
+	list_add(&event->list, &memcg->oom_notify);
+
+	/* already in OOM ? */
+	if (memcg->under_oom)
+		eventfd_signal(eventfd, 1);
+	spin_unlock(&memcg_oom_lock);
+
+	return 0;
+}
+
+static void mem_cgroup_oom_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd)
+{
+	struct mem_cgroup_eventfd_list *ev, *tmp;
+
+	spin_lock(&memcg_oom_lock);
+
+	list_for_each_entry_safe(ev, tmp, &memcg->oom_notify, list) {
+		if (ev->eventfd == eventfd) {
+			list_del(&ev->list);
+			kfree(ev);
+		}
+	}
+
+	spin_unlock(&memcg_oom_lock);
+}
+
 static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
@@ -4314,7 +4687,6 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
-#ifndef CONFIG_PREEMPT_RT
 /*
  * DO NOT USE IN NEW FILES.
  *
@@ -4328,391 +4700,6 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
  * possible.
  */
 
-static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
-				       enum mem_cgroup_events_target target)
-{
-	unsigned long val, next;
-
-	val = __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
-	next = __this_cpu_read(memcg->vmstats_percpu->targets[target]);
-	/* from time_after() in jiffies.h */
-	if ((long)(next - val) < 0) {
-		switch (target) {
-		case MEM_CGROUP_TARGET_THRESH:
-			next = val + THRESHOLDS_EVENTS_TARGET;
-			break;
-		case MEM_CGROUP_TARGET_SOFTLIMIT:
-			next = val + SOFTLIMIT_EVENTS_TARGET;
-			break;
-		default:
-			break;
-		}
-		__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
-		return true;
-	}
-	return false;
-}
-
-static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
-{
-	unsigned long excess;
-	struct mem_cgroup_per_node *mz;
-	struct mem_cgroup_tree_per_node *mctz;
-
-	mctz = soft_limit_tree.rb_tree_per_node[nid];
-	if (!mctz)
-		return;
-	/*
-	 * Necessary to update all ancestors when hierarchy is used.
-	 * because their event counter is not touched.
-	 */
-	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		mz = memcg->nodeinfo[nid];
-		excess = soft_limit_excess(memcg);
-		/*
-		 * We have to update the tree if mz is on RB-tree or
-		 * mem is over its softlimit.
-		 */
-		if (excess || mz->on_tree) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&mctz->lock, flags);
-			/* if on-tree, remove it */
-			if (mz->on_tree)
-				__mem_cgroup_remove_exceeded(mz, mctz);
-			/*
-			 * Insert again. mz->usage_in_excess will be updated.
-			 * If excess is 0, no tree ops.
-			 */
-			__mem_cgroup_insert_exceeded(mz, mctz, excess);
-			spin_unlock_irqrestore(&mctz->lock, flags);
-		}
-	}
-}
-
-static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
-{
-	struct mem_cgroup_threshold_ary *t;
-	unsigned long usage;
-	int i;
-
-	rcu_read_lock();
-	if (!swap)
-		t = rcu_dereference(memcg->thresholds.primary);
-	else
-		t = rcu_dereference(memcg->memsw_thresholds.primary);
-
-	if (!t)
-		goto unlock;
-
-	usage = mem_cgroup_usage(memcg, swap);
-
-	/*
-	 * current_threshold points to threshold just below or equal to usage.
-	 * If it's not true, a threshold was crossed after last
-	 * call of __mem_cgroup_threshold().
-	 */
-	i = t->current_threshold;
-
-	/*
-	 * Iterate backward over array of thresholds starting from
-	 * current_threshold and check if a threshold is crossed.
-	 * If none of thresholds below usage is crossed, we read
-	 * only one element of the array here.
-	 */
-	for (; i >= 0 && unlikely(t->entries[i].threshold > usage); i--)
-		eventfd_signal(t->entries[i].eventfd, 1);
-
-	/* i = current_threshold + 1 */
-	i++;
-
-	/*
-	 * Iterate forward over array of thresholds starting from
-	 * current_threshold+1 and check if a threshold is crossed.
-	 * If none of thresholds above usage is crossed, we read
-	 * only one element of the array here.
-	 */
-	for (; i < t->size && unlikely(t->entries[i].threshold <= usage); i++)
-		eventfd_signal(t->entries[i].eventfd, 1);
-
-	/* Update current_threshold */
-	t->current_threshold = i - 1;
-unlock:
-	rcu_read_unlock();
-}
-
-static void mem_cgroup_threshold(struct mem_cgroup *memcg)
-{
-	while (memcg) {
-		__mem_cgroup_threshold(memcg, false);
-		if (do_memsw_account())
-			__mem_cgroup_threshold(memcg, true);
-
-		memcg = parent_mem_cgroup(memcg);
-	}
-}
-
-/*
- * Check events in order.
- *
- */
-static void memcg_check_events(struct mem_cgroup *memcg, int nid)
-{
-	/* threshold event is triggered in finer grain than soft limit */
-	if (unlikely(mem_cgroup_event_ratelimit(memcg,
-						MEM_CGROUP_TARGET_THRESH))) {
-		bool do_softlimit;
-
-		do_softlimit = mem_cgroup_event_ratelimit(memcg,
-						MEM_CGROUP_TARGET_SOFTLIMIT);
-		mem_cgroup_threshold(memcg);
-		if (unlikely(do_softlimit))
-			mem_cgroup_update_tree(memcg, nid);
-	}
-}
-
-static int compare_thresholds(const void *a, const void *b)
-{
-	const struct mem_cgroup_threshold *_a = a;
-	const struct mem_cgroup_threshold *_b = b;
-
-	if (_a->threshold > _b->threshold)
-		return 1;
-
-	if (_a->threshold < _b->threshold)
-		return -1;
-
-	return 0;
-}
-
-static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args, enum res_type type)
-{
-	struct mem_cgroup_thresholds *thresholds;
-	struct mem_cgroup_threshold_ary *new;
-	unsigned long threshold;
-	unsigned long usage;
-	int i, size, ret;
-
-	ret = page_counter_memparse(args, "-1", &threshold);
-	if (ret)
-		return ret;
-
-	mutex_lock(&memcg->thresholds_lock);
-
-	if (type == _MEM) {
-		thresholds = &memcg->thresholds;
-		usage = mem_cgroup_usage(memcg, false);
-	} else if (type == _MEMSWAP) {
-		thresholds = &memcg->memsw_thresholds;
-		usage = mem_cgroup_usage(memcg, true);
-	} else
-		BUG();
-
-	/* Check if a threshold crossed before adding a new one */
-	if (thresholds->primary)
-		__mem_cgroup_threshold(memcg, type == _MEMSWAP);
-
-	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
-
-	/* Allocate memory for new array of thresholds */
-	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
-	if (!new) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
-	new->size = size;
-
-	/* Copy thresholds (if any) to new array */
-	if (thresholds->primary)
-		memcpy(new->entries, thresholds->primary->entries,
-		       flex_array_size(new, entries, size - 1));
-
-	/* Add new threshold */
-	new->entries[size - 1].eventfd = eventfd;
-	new->entries[size - 1].threshold = threshold;
-
-	/* Sort thresholds. Registering of new threshold isn't time-critical */
-	sort(new->entries, size, sizeof(*new->entries),
-			compare_thresholds, NULL);
-
-	/* Find current threshold */
-	new->current_threshold = -1;
-	for (i = 0; i < size; i++) {
-		if (new->entries[i].threshold <= usage) {
-			/*
-			 * new->current_threshold will not be used until
-			 * rcu_assign_pointer(), so it's safe to increment
-			 * it here.
-			 */
-			++new->current_threshold;
-		} else
-			break;
-	}
-
-	/* Free old spare buffer and save old primary buffer as spare */
-	kfree(thresholds->spare);
-	thresholds->spare = thresholds->primary;
-
-	rcu_assign_pointer(thresholds->primary, new);
-
-	/* To be sure that nobody uses thresholds */
-	synchronize_rcu();
-
-unlock:
-	mutex_unlock(&memcg->thresholds_lock);
-
-	return ret;
-}
-
-static int mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args)
-{
-	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEM);
-}
-
-static int memsw_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args)
-{
-	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEMSWAP);
-}
-
-static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, enum res_type type)
-{
-	struct mem_cgroup_thresholds *thresholds;
-	struct mem_cgroup_threshold_ary *new;
-	unsigned long usage;
-	int i, j, size, entries;
-
-	mutex_lock(&memcg->thresholds_lock);
-
-	if (type == _MEM) {
-		thresholds = &memcg->thresholds;
-		usage = mem_cgroup_usage(memcg, false);
-	} else if (type == _MEMSWAP) {
-		thresholds = &memcg->memsw_thresholds;
-		usage = mem_cgroup_usage(memcg, true);
-	} else
-		BUG();
-
-	if (!thresholds->primary)
-		goto unlock;
-
-	/* Check if a threshold crossed before removing */
-	__mem_cgroup_threshold(memcg, type == _MEMSWAP);
-
-	/* Calculate new number of threshold */
-	size = entries = 0;
-	for (i = 0; i < thresholds->primary->size; i++) {
-		if (thresholds->primary->entries[i].eventfd != eventfd)
-			size++;
-		else
-			entries++;
-	}
-
-	new = thresholds->spare;
-
-	/* If no items related to eventfd have been cleared, nothing to do */
-	if (!entries)
-		goto unlock;
-
-	/* Set thresholds array to NULL if we don't have thresholds */
-	if (!size) {
-		kfree(new);
-		new = NULL;
-		goto swap_buffers;
-	}
-
-	new->size = size;
-
-	/* Copy thresholds and find current threshold */
-	new->current_threshold = -1;
-	for (i = 0, j = 0; i < thresholds->primary->size; i++) {
-		if (thresholds->primary->entries[i].eventfd == eventfd)
-			continue;
-
-		new->entries[j] = thresholds->primary->entries[i];
-		if (new->entries[j].threshold <= usage) {
-			/*
-			 * new->current_threshold will not be used
-			 * until rcu_assign_pointer(), so it's safe to increment
-			 * it here.
-			 */
-			++new->current_threshold;
-		}
-		j++;
-	}
-
-swap_buffers:
-	/* Swap primary and spare array */
-	thresholds->spare = thresholds->primary;
-
-	rcu_assign_pointer(thresholds->primary, new);
-
-	/* To be sure that nobody uses thresholds */
-	synchronize_rcu();
-
-	/* If all events are unregistered, free the spare array */
-	if (!new) {
-		kfree(thresholds->spare);
-		thresholds->spare = NULL;
-	}
-unlock:
-	mutex_unlock(&memcg->thresholds_lock);
-}
-
-static void mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd)
-{
-	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEM);
-}
-
-static void memsw_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd)
-{
-	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEMSWAP);
-}
-
-static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args)
-{
-	struct mem_cgroup_eventfd_list *event;
-
-	event = kmalloc(sizeof(*event),	GFP_KERNEL);
-	if (!event)
-		return -ENOMEM;
-
-	spin_lock(&memcg_oom_lock);
-
-	event->eventfd = eventfd;
-	list_add(&event->list, &memcg->oom_notify);
-
-	/* already in OOM ? */
-	if (memcg->under_oom)
-		eventfd_signal(eventfd, 1);
-	spin_unlock(&memcg_oom_lock);
-
-	return 0;
-}
-
-static void mem_cgroup_oom_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd)
-{
-	struct mem_cgroup_eventfd_list *ev, *tmp;
-
-	spin_lock(&memcg_oom_lock);
-
-	list_for_each_entry_safe(ev, tmp, &memcg->oom_notify, list) {
-		if (ev->eventfd == eventfd) {
-			list_del(&ev->list);
-			kfree(ev);
-		}
-	}
-
-	spin_unlock(&memcg_oom_lock);
-}
-
 /*
  * Unregister event and free resources.
  *
@@ -4806,6 +4793,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	char *endp;
 	int ret;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return -EOPNOTSUPP;
+
 	buf = strstrip(buf);
 
 	efd = simple_strtoul(buf, &endp, 10);
@@ -4923,18 +4913,6 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	return ret;
 }
 
-#else
-
-static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
-					 char *buf, size_t nbytes, loff_t off)
-{
-	return -EOPNOTSUPP;
-}
-
-static void memcg_check_events(struct mem_cgroup *memcg, int nid) { }
-
-#endif
-
 #if defined(CONFIG_MEMCG_KMEM) && (defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
 static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 {
@@ -6899,7 +6877,6 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	long nr_pages;
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
-	bool use_objcg = folio_memcg_kmem(folio);
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
@@ -6908,7 +6885,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	 * folio memcg or objcg at this point, we have fully
 	 * exclusive access to the folio.
 	 */
-	if (use_objcg) {
+	if (folio_memcg_kmem(folio)) {
 		objcg = __folio_objcg(folio);
 		/*
 		 * This get matches the put at the end of the function and
@@ -6936,7 +6913,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 
 	nr_pages = folio_nr_pages(folio);
 
-	if (use_objcg) {
+	if (folio_memcg_kmem(folio)) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
 
@@ -7116,7 +7093,7 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
-	refill_stock(memcg, nr_pages, false);
+	refill_stock(memcg, nr_pages);
 }
 
 static int __init cgroup_memory(char *s)
@@ -7256,18 +7233,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * i_pages lock which is taken with interrupts-off. It is
 	 * important here to have the interrupts disabled because it is the
 	 * only synchronisation we have for updating the per-CPU variables.
-	 * On PREEMPT_RT interrupts are never disabled and the updates to per-CPU
-	 * variables are synchronised by keeping preemption disabled.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		VM_BUG_ON(!irqs_disabled());
-		mem_cgroup_charge_statistics(memcg, -nr_entries);
-	} else {
-		preempt_disable();
-		mem_cgroup_charge_statistics(memcg, -nr_entries);
-		preempt_enable();
-	}
-
+	memcg_stats_lock();
+	mem_cgroup_charge_statistics(memcg, -nr_entries);
+	memcg_stats_unlock();
 	memcg_check_events(memcg, page_to_nid(page));
 
 	css_put(&memcg->css);
diff --git a/net/core/dev.c b/net/core/dev.c
index 7ac37cbc42df4..a386d596881d0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4831,26 +4831,40 @@ static int netif_rx_internal(struct sk_buff *skb)
 	return ret;
 }
 
+/**
+ *	__netif_rx	-	Slightly optimized version of netif_rx
+ *	@skb: buffer to post
+ *
+ *	This behaves as netif_rx except that it does not disable bottom halves.
+ *	As a result this function may only be invoked from the interrupt context
+ *	(either hard or soft interrupt).
+ */
 int __netif_rx(struct sk_buff *skb)
 {
 	int ret;
 
+	lockdep_assert_once(hardirq_count() | softirq_count());
+
 	trace_netif_rx_entry(skb);
 	ret = netif_rx_internal(skb);
 	trace_netif_rx_exit(ret);
 	return ret;
 }
+EXPORT_SYMBOL(__netif_rx);
 
 /**
  *	netif_rx	-	post buffer to the network code
  *	@skb: buffer to post
  *
  *	This function receives a packet from a device driver and queues it for
- *	the upper (protocol) levels to process.  It always succeeds. The buffer
- *	may be dropped during processing for congestion control or by the
- *	protocol layers.
- *	This interface is considered legacy. Modern NIC driver should use NAPI
- *	and GRO.
+ *	the upper (protocol) levels to process via the backlog NAPI device. It
+ *	always succeeds. The buffer may be dropped during processing for
+ *	congestion control or by the protocol layers.
+ *	The network buffer is passed via the backlog NAPI device. Modern NIC
+ *	driver should use NAPI and GRO.
+ *	This function can used from interrupt and from process context. The
+ *	caller from process context must not disable interrupts before invoking
+ *	this function.
  *
  *	return values:
  *	NET_RX_SUCCESS	(no congestion)
@@ -4859,11 +4873,16 @@ int __netif_rx(struct sk_buff *skb)
  */
 int netif_rx(struct sk_buff *skb)
 {
+	bool need_bh_off = !(hardirq_count() | softirq_count());
 	int ret;
 
-	local_bh_disable();
-	ret = __netif_rx(skb);
-	local_bh_enable();
+	if (need_bh_off)
+		local_bh_disable();
+	trace_netif_rx_entry(skb);
+	ret = netif_rx_internal(skb);
+	trace_netif_rx_exit(ret);
+	if (need_bh_off)
+		local_bh_enable();
 	return ret;
 }
 EXPORT_SYMBOL(netif_rx);
