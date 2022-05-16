Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D49528625
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbiEPNzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiEPNyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:54:50 -0400
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288126AEA;
        Mon, 16 May 2022 06:54:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 73EB0460031;
        Mon, 16 May 2022 16:49:04 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qtuwBDk3KX4S; Mon, 16 May 2022 16:49:01 +0300 (EEST)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 47C6546002F;
        Mon, 16 May 2022 16:48:57 +0300 (EEST)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] can: kvaser_usb_leaf: Fix improved state not being reported
Date:   Mon, 16 May 2022 16:47:44 +0300
Message-Id: <20220516134748.3724796-9-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tested 0bfd:0017 Kvaser Memorator Professional HS/HS FW 2.0.50 and
0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778 do not seem to send
any unsolicited events when error counters decrease or when the device
transitions from ERROR_PASSIVE to ERROR_ACTIVE (or WARNING).

This causes the interface to e.g. indefinitely stay in the ERROR_PASSIVE
state.

Fix that by asking for chip state (inc. counters) event every 0.5 secs
when error counters are non-zero.

Since the driver seems to be prepared for non-error-counter devices
(!KVASER_USB_HAS_TXRX_ERRORS) as well, also always poll in ERROR_PASSIVE
even if the counters show zero.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  7 +++
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 18 +++++-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 58 +++++++++++++++++++
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index f1bea13a3829..70aa7a9ed35b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -107,6 +107,9 @@ struct kvaser_usb_net_priv {
 	struct can_priv can;
 	struct can_berr_counter bec;
 
+	/* subdriver-specific data */
+	void *sub_priv;
+
 	struct kvaser_usb *dev;
 	struct net_device *netdev;
 	int channel;
@@ -128,6 +131,8 @@ struct kvaser_usb_net_priv {
  *
  * @dev_setup_endpoints:	setup USB in and out endpoints
  * @dev_init_card:		initialize card
+ * @dev_init_channel:		initialize channel
+ * @dev_remove_channel:		uninitialize channel
  * @dev_get_software_info:	get software info
  * @dev_get_software_details:	get software details
  * @dev_get_card_info:		get card info
@@ -149,6 +154,8 @@ struct kvaser_usb_dev_ops {
 				    struct can_berr_counter *bec);
 	int (*dev_setup_endpoints)(struct kvaser_usb *dev);
 	int (*dev_init_card)(struct kvaser_usb *dev);
+	int (*dev_init_channel)(struct kvaser_usb_net_priv *priv);
+	void (*dev_remove_channel)(struct kvaser_usb_net_priv *priv);
 	int (*dev_get_software_info)(struct kvaser_usb *dev);
 	int (*dev_get_software_details)(struct kvaser_usb *dev);
 	int (*dev_get_card_info)(struct kvaser_usb *dev);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index a8d72fb8291a..6a1ebdd9ba85 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -645,6 +645,9 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 		if (!dev->nets[i])
 			continue;
 
+		if (dev->ops->dev_remove_channel)
+			dev->ops->dev_remove_channel(dev->nets[i]);
+
 		free_candev(dev->nets[i]->netdev);
 	}
 }
@@ -712,17 +715,26 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev,
 
 	dev->nets[channel] = priv;
 
+	if (dev->ops->dev_init_channel) {
+		err = dev->ops->dev_init_channel(priv);
+		if (err)
+			goto err;
+	}
+
 	err = register_candev(netdev);
 	if (err) {
 		dev_err(&dev->intf->dev, "Failed to register CAN device\n");
-		free_candev(netdev);
-		dev->nets[channel] = NULL;
-		return err;
+		goto err;
 	}
 
 	netdev_dbg(netdev, "device registered\n");
 
 	return 0;
+
+err:
+	free_candev(netdev);
+	dev->nets[channel] = NULL;
+	return err;
 }
 
 static int kvaser_usb_probe(struct usb_interface *intf,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 5f27c00179c1..abb681808a28 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/units.h>
 #include <linux/usb.h>
+#include <linux/workqueue.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -56,6 +57,7 @@
 #define CMD_RX_EXT_MESSAGE		14
 #define CMD_TX_EXT_MESSAGE		15
 #define CMD_SET_BUS_PARAMS		16
+#define CMD_GET_CHIP_STATE		19
 #define CMD_CHIP_STATE_EVENT		20
 #define CMD_SET_CTRL_MODE		21
 #define CMD_RESET_CHIP			24
@@ -375,6 +377,12 @@ struct kvaser_usb_err_summary {
 	};
 };
 
+struct kvaser_usb_net_leaf_priv {
+	struct kvaser_usb_net_priv *net;
+
+	struct delayed_work chip_state_req_work;
+};
+
 static const struct can_bittiming_const kvaser_usb_leaf_bittiming_const = {
 	.name = "kvaser_usb",
 	.tseg1_min = KVASER_USB_TSEG1_MIN,
@@ -757,6 +765,16 @@ static int kvaser_usb_leaf_simple_cmd_async(struct kvaser_usb_net_priv *priv,
 	return err;
 }
 
+static void kvaser_usb_leaf_chip_state_req_work(struct work_struct *work)
+{
+	struct kvaser_usb_net_leaf_priv *leaf =
+		container_of(work, struct kvaser_usb_net_leaf_priv,
+			     chip_state_req_work.work);
+	struct kvaser_usb_net_priv *priv = leaf->net;
+
+	kvaser_usb_leaf_simple_cmd_async(priv, CMD_GET_CHIP_STATE);
+}
+
 static void
 kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
 					const struct kvaser_usb_err_summary *es,
@@ -828,6 +846,7 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	struct sk_buff *skb;
 	struct net_device_stats *stats;
 	struct kvaser_usb_net_priv *priv;
+	struct kvaser_usb_net_leaf_priv *leaf;
 	enum can_state old_state, new_state;
 
 	if (es->channel >= dev->nchannels) {
@@ -837,6 +856,7 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	}
 
 	priv = dev->nets[es->channel];
+	leaf = priv->sub_priv;
 	stats = &priv->netdev->stats;
 
 	/* Update all of the CAN interface's state and error counters before
@@ -853,6 +873,14 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	kvaser_usb_leaf_rx_error_update_can_state(priv, es, &tmp_cf);
 	new_state = priv->can.state;
 
+	/* If there are errors, request status updates periodically as we do
+	 * not get automatic notifications of improved state.
+	 */
+	if (new_state < CAN_STATE_BUS_OFF &&
+	    (es->rxerr || es->txerr || new_state == CAN_STATE_ERROR_PASSIVE))
+		schedule_delayed_work(&leaf->chip_state_req_work,
+				      msecs_to_jiffies(500));
+
 	skb = alloc_can_err_skb(priv->netdev, &cf);
 	if (!skb) {
 		stats->rx_dropped++;
@@ -1312,10 +1340,13 @@ static int kvaser_usb_leaf_start_chip(struct kvaser_usb_net_priv *priv)
 
 static int kvaser_usb_leaf_stop_chip(struct kvaser_usb_net_priv *priv)
 {
+	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
 	int err;
 
 	reinit_completion(&priv->stop_comp);
 
+	cancel_delayed_work(&leaf->chip_state_req_work);
+
 	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_STOP_CHIP,
 					      priv->channel);
 	if (err)
@@ -1362,6 +1393,31 @@ static int kvaser_usb_leaf_init_card(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_leaf_init_channel(struct kvaser_usb_net_priv *priv)
+{
+	struct kvaser_usb_net_leaf_priv *leaf;
+
+	leaf = devm_kzalloc(&priv->dev->intf->dev, sizeof(*leaf), GFP_KERNEL);
+	if (!leaf)
+		return -ENOMEM;
+
+	leaf->net = priv;
+	INIT_DELAYED_WORK(&leaf->chip_state_req_work,
+			  kvaser_usb_leaf_chip_state_req_work);
+
+	priv->sub_priv = leaf;
+
+	return 0;
+}
+
+static void kvaser_usb_leaf_remove_channel(struct kvaser_usb_net_priv *priv)
+{
+	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
+
+	if (leaf)
+		cancel_delayed_work_sync(&leaf->chip_state_req_work);
+}
+
 static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
@@ -1463,6 +1519,8 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_get_berr_counter = kvaser_usb_leaf_get_berr_counter,
 	.dev_setup_endpoints = kvaser_usb_leaf_setup_endpoints,
 	.dev_init_card = kvaser_usb_leaf_init_card,
+	.dev_init_channel = kvaser_usb_leaf_init_channel,
+	.dev_remove_channel = kvaser_usb_leaf_remove_channel,
 	.dev_get_software_info = kvaser_usb_leaf_get_software_info,
 	.dev_get_software_details = NULL,
 	.dev_get_card_info = kvaser_usb_leaf_get_card_info,
-- 
2.34.1

