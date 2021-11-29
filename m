Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3407B4615F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377830AbhK2NP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:15:57 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:59734 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhK2NN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:13:56 -0500
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mrgQP-0006O0-Uz; Mon, 29 Nov 2021 13:10:34 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mrgQK-00B6LL-Gu; Mon, 29 Nov 2021 13:10:26 +0000
From:   anton.ivanov@cambridgegreys.com
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        linux-kernel@vger.kernel.org
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] ixgbe: Restore crypto offload for tunnel mode where possile
Date:   Mon, 29 Nov 2021 13:09:58 +0000
Message-Id: <20211129130958.2642851-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Commit d785e1fec60179f534fbe8d006c890e5ad186e51 disabled IPSEC
in tunnel mode as not working.

It actually works correctly for TX if (and only if) TSO is disabled on the
interace. Hence, the offload in tunnel mode needs to be disabled only for RX.

CPU usage for TX side softirq thread without the patch ~ 88%. With the
patch < 20%. Tested using iperf. If the RX side is Linux with ixgbe
there is no difference in throughput, because the bottleneck is at
the RX end where the softirq thread is at 100%. If, however, the RX side is
capable of line rate, I would expect this patch to allow Linux to reach
line rate for TX.

Fixes: d785e1fec60179f534fbe8d006c890e5ad186e51 ixgbe: fail to create xfrm offload of IPsec tunnel mode SA

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 15 ++++++++++-----
 drivers/net/ethernet/intel/ixgbevf/ipsec.c     | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index e596e1a9fc75..98bd9d91d451 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -575,11 +575,6 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 		return -EINVAL;
 	}
 
-	if (xs->props.mode != XFRM_MODE_TRANSPORT) {
-		netdev_err(dev, "Unsupported mode for ipsec offload\n");
-		return -EINVAL;
-	}
-
 	if (ixgbe_ipsec_check_mgmt_ip(xs)) {
 		netdev_err(dev, "IPsec IP addr clash with mgmt filters\n");
 		return -EINVAL;
@@ -588,6 +583,11 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
 		struct rx_sa rsa;
 
+		if (xs->props.mode != XFRM_MODE_TRANSPORT) {
+			netdev_err(dev, "IPsec inbound offload supported only for transport mode\n");
+			return -EINVAL;
+		}
+
 		if (xs->calg) {
 			netdev_err(dev, "Compression offload not supported\n");
 			return -EINVAL;
@@ -699,6 +699,11 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 	} else {
 		struct tx_sa tsa;
 
+		if (xs->props.mode != XFRM_MODE_TRANSPORT && (dev->features & NETIF_F_TSO)) {
+			netdev_err(dev, "Cannot support tunnel mode IPsec offload and TSO simultaneously\n");
+			return -EINVAL;
+		}
+
 		if (adapter->num_vfs &&
 		    adapter->bridge_mode != BRIDGE_MODE_VEPA)
 			return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index e3e4676af9e4..ba15f0477649 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -275,14 +275,14 @@ static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs)
 		return -EINVAL;
 	}
 
-	if (xs->props.mode != XFRM_MODE_TRANSPORT) {
-		netdev_err(dev, "Unsupported mode for ipsec offload\n");
-		return -EINVAL;
-	}
-
 	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
 		struct rx_sa rsa;
 
+		if (xs->props.mode != XFRM_MODE_TRANSPORT) {
+			netdev_err(dev, "IPsec inbound offload supported only for transport mode\n");
+			return -EINVAL;
+		}
+
 		if (xs->calg) {
 			netdev_err(dev, "Compression offload not supported\n");
 			return -EINVAL;
@@ -342,6 +342,11 @@ static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs)
 	} else {
 		struct tx_sa tsa;
 
+		if (xs->props.mode != XFRM_MODE_TRANSPORT && (dev->features & NETIF_F_TSO)) {
+			netdev_err(dev, "Cannot support tunnel mode IPsec offload and TSO simultaneously\n");
+			return -EINVAL;
+		}
+
 		/* find the first unused index */
 		ret = ixgbevf_ipsec_find_empty_idx(ipsec, false);
 		if (ret < 0) {
-- 
2.30.2

